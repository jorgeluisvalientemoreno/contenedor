set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF-4495

SELECT SYS_CONTEXT('USERENV', 'DB_NAME') instancia,
   TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss') fecha_ejec,
   SYS_CONTEXT('USERENV','CURRENT_SCHEMA') esquema,
   USER ejecutado_por,
   SYS_CONTEXT('USERENV', 'OS_USER') usuario_so
FROM DUAL;

PROMPT
PROMPT =========================================
PROMPT  ****   Información de Ejecución    ****
PROMPT =========================================
PROMPT Instancia        : &instancia
PROMPT Fecha ejecución  : &fecha_ejec
PROMPT Usuario DB       : &ejecutado_por
PROMPT Usuario O.S      : &usuario_so
PROMPT Esquema          : &esquema
PROMPT CASO             : &CASO
PROMPT =========================================
PROMPT

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"
DECLARE
/*
    OSF-4495: Se solicita la anulación de 43 contratos hijos relacionados en el excel adjunto correspondientes 
    al proyecto de  Villas de Santa Ana123 casas, bajo el contrato 67654368 y la solicitud 222281267 
    Esta solicitud se realiza debido a que, por temas relacionados con el subsidio que otroga el gobierno, 
    el cliente constructor Unión Temporal Santa Ana únicamente entregará 80 casas.
*/
    -- ID de la solicitud relacionada a los contratos a retirar
    cnuPackage_id   constant number := 222281267;
    -- Informacion general
    nuInfomrGen     constant or_order_comment.comment_type_id%type := 1277;

    -- Cursor para Anular ordenes de contratos definidos del CASO OSF-2346
    CURSOR cuOrderActiv is
      select product_id PRODUCTO, oa.order_id ORDEN, o.causal_id CAUSAL, gc.class_causal_id
        from open.or_order_activity oa, open.or_order o, open.ge_causal gc
       where oa.package_id = cnuPackage_id
         and oa.order_id = o.order_id
         and o.causal_id = gc.causal_id
         and oa.motive_id in 
         (
            select motive_id
            from open.mo_motive mo
            where mo.package_id = oa.package_id
            and mo.subscription_id in 
            (
                67661705,67661707,67661701,67661700,67661702,67661699,67661650,67661657,
                67661659,67661661,67661662,67661663,67661664,67661665,67661651,67661670,
                67661672,67661673,67661674,67661706,67661677,67661675,67661676,67661678,
                67661652,67661680,67661682,67661683,67661684,67661685,67661686,67661688,
                67661689,67661691,67661690,67661654,67661692,67661655,67661653,67661679,
                67661656,67661703,67661708
            )
         );

    -- Cursor de Person ID para el comentario
    CURSOR cuLoadData IS
        select person_id
        from ge_person
        where person_id = 42877; -- Kelly San Miguel
        
        
    -- Registro de Comentario de la orden  
    rcOR_ORDER_COMMENT  daor_order_comment.styor_order_comment;
    nuPersonID          ge_person.person_id%type;

    sbComment           VARCHAR2(4000) := 'SE ANULA ORDEN CON EL CASO OSF-4495';

    nuErrorCode         number;
    nuCont              number;
    nuTotal             number;
    nuOrderCommentID    number;
    sbErrorMessage      varchar2(4000);
    exError             EXCEPTION;
    
    function fblValidaCartera(inusesu in number) return boolean 
    is
        blsaldo boolean := false;
        
        cursor cudata is
        select sesunuse,sesususc,sesuserv,
        nvl((
            select sum(cucosacu) from cuencobr
            where cuconuse = sesunuse
            and cucosacu > 0
        ),0) saldo,
        nvl((
            select sum(difesape) from diferido
            where difenuse = sesunuse
        ),0) saldife,
        nvl((
            select sum(mosfvalo)
            from saldfavo,movisafa
            where safasesu = sesunuse
            and mosfsafa = safacons
        ),0) saldfavo
        from servsusc
        where sesunuse = inusesu;
        
        rcdata  cudata%rowtype;
    begin
        if cudata%isopen then close cudata; end if;
        rcdata := null;
        open cudata;
        fetch cudata into rcdata;
        close cudata;
        
        if rcdata.saldo = 0 and rcdata.saldife = 0 and rcdata.saldfavo = 0 then
            blsaldo := true;
        end if;
        
        return blsaldo;
        
    exception
        when others then
            blsaldo := false;
            return blsaldo;
    end fblValidaCartera;

BEGIN

    nuCont  := 0;
    nuTotal := 0;

    -- Carga de Person ID para el comentario
    open cuLoadData;
    fetch cuLoadData into nuPersonID;
    close cuLoadData;

    -- sino existe la persona pone la default de OPEN
    IF nuPersonID is null THEN
        nuPersonID := ge_bopersonal.fnugetpersonid;
    END IF;

    dbms_output.put_line('Codigo Tipo Comentario[' || nuInfomrGen || ']');
    dbms_output.put_line('Fecha sistema         [' || open.pkgeneralservices.fdtgetsystemdate || ']');
    dbms_output.put_line('Person ID             [' || nuPersonID || ']');

    --Recorrer ordenes del contrato de venta a constructora
    FOR rcOrderActiv in cuOrderActiv LOOP
    
      nuTotal := nuTotal + 1;      
      
      -- Si la Orden no esta legalizada con causal de exito, anula
      If nvl(rcOrderActiv.class_causal_id,0) != 1 then
      
        if fblValidaCartera(rcOrderActiv.PRODUCTO) then
        
            BEGIN
                dbms_output.put_line(chr(10)||'ANULA ORDEN: [' || rcOrderActiv.ORDEN || ']');

                -- or_boanullorder.anullorderwithoutval(rcOrderActiv.ORDEN,SYSDATE);
                -- Se reemplaza por el nuevo API para anular ordenes - GDGA 20/02/2024
                api_anullorder
                (
                    rcOrderActiv.ORDEN,
                    null,
                    null,
                    nuErrorCode,
                    sbErrorMessage
                );
                IF (nuErrorCode <> 0) THEN
                    dbms_output.put_line('Error en api_anullorder, Orden: '|| rcOrderActiv.ORDEN ||', '|| sbErrorMessage);
                    RAISE exError;
                END IF;

                -- Arma el registro con el comentario
                rcOR_ORDER_COMMENT.ORDER_COMMENT_ID := seq_or_order_comment.nextval;
                rcOR_ORDER_COMMENT.ORDER_COMMENT    := sbComment;
                rcOR_ORDER_COMMENT.ORDER_ID         := rcOrderActiv.ORDEN;
                rcOR_ORDER_COMMENT.COMMENT_TYPE_ID  := nuInfomrGen;
                rcOR_ORDER_COMMENT.REGISTER_DATE    := open.pkgeneralservices.fdtgetsystemdate;
                rcOR_ORDER_COMMENT.LEGALIZE_COMMENT := 'N';
                rcOR_ORDER_COMMENT.PERSON_ID        := nuPersonID;

                -- Inserta el registro en or_order_comment
                daor_order_comment.insrecord(rcOR_ORDER_COMMENT);

                -- Cambia el estado de la orden a Finalizada
                update open.or_order_activity
                  set status = 'F'
                where order_id = rcOrderActiv.ORDEN;

                -- Se actualiza la fecha de retiro en el producto y componente - GDGA 15/02/2024
                update open.pr_product
                  set product_status_id = 16,  -- Retirado sin instalacion
                      suspen_ord_act_id = null,
                      retire_date = sysdate
                where product_id = rcOrderActiv.PRODUCTO;

                -- Estado de corte
                pktblservsusc.updsesuesco(rcOrderActiv.PRODUCTO, 110); -- Retirado sin instalacion.
                
                -- componente del producto
                update open.pr_component
                  set component_status_id = 18  -- Retirado sin instalacion
                where product_id = rcOrderActiv.PRODUCTO;

                update open.compsesu
                  set cmssescm = 18,  --
                      cmssfere = sysdate
                where cmsssesu = rcOrderActiv.PRODUCTO;

                -- Cambia estado del motivo
                update open.mo_motive m
                  set m.motive_status_id = 5 -- 
                where m.package_id = cnuPackage_id
                  and m.product_id in rcOrderActiv.PRODUCTO;

                -- Componentes del motivo
                update mo_component m
                  set m.motive_status_id = 26
                where m.package_id = cnuPackage_id
                  and m.product_id = rcOrderActiv.PRODUCTO;

                nuCont := nuCont + 1;

                -- Asienta la transaccion
                commit;

            EXCEPTION
                WHEN exError THEN
                    rollback;
                WHEN OTHERS THEN
                    rollback;
                    dbms_output.put_line('Error Anulando Orden: '|| rcOrderActiv.ORDEN ||', SQLERRM: '|| SQLERRM );
            END;
        ELSE
            dbms_output.put_line('Producto con saldo: '|| rcOrderActiv.PRODUCTO ||', no se puede anular.');
        END IF;
      Else
        
        dbms_output.put_line('Orden: '|| rcOrderActiv.ORDEN ||' , Esta legalizada con Exito, no se puede anular.');
      
      END If;

    END LOOP;

    dbms_output.put_line('Fin del Proceso. Ordenes Seleccionadas: '||nuTotal||', Ordenes Anuladas: '||nuCont);
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error del proceso. Ordenes Seleccionadas: '||nuTotal||', Ordenes Anuladas: '||nuCont ||', '||SQLERRM );
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
quit
/
