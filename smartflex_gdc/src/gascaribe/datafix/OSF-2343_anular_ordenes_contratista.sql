column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    -- ID de la solicitud relacionada a los contratos a retirar
    cnuPackage_id       constant number := 190246557;
    nuInfomrGen         constant open.or_order_comment.comment_type_id%type := 1277; -- INFORMACION GENERAL

    --cursor para Anular ordenes de contratos definidos del CASO OSF-2343 de la solicitud de venta contrato padre 67308520 solicitud 190246557
    cursor cuproductopenins is
        select ooa.package_id, ooa.product_id PRODUCTO, ooa.order_id ORDEN
        from open.Or_Order_Activity ooa
        where ooa.order_id in (256698309,256698306,256698312,256698310)
        and ooa.package_id = cnuPackage_id;

    -- Comentario de orden 
    -- Registro de Comentario de la orden
    rcOR_ORDER_COMMENT  open.daor_order_comment.styor_order_comment;
    nuPersonID          open.ge_person.person_id%type;

    -- Carga de Person ID para el comentario
    CURSOR cuLoadData IS
        select ge_person.person_id
        from open.ge_person
        where ge_person.person_id = 13549; -- Pablo

    SBCOMMENT           VARCHAR2(4000) := 'SE ANULA ORDEN CON EL CASO OSF-2343';
    nuCommentType       number         := 1277;
    nuErrorCode         number;
    nuCont              number;
    nuTotal             number;
    sbErrorMessage      varchar2(4000);
    exError             EXCEPTION;

BEGIN

    nuCont  := 0;
    nuTotal := 0;

    -- Arma el registro del comment de la orden dejando evidencia de ANULACION de la orden
    open cuLoadData;
    fetch cuLoadData into nuPersonID;
    close cuLoadData;
      -- sino existe la persona pone la default de OPEN
    IF nuPersonID is null THEN
        nuPersonID := ge_bopersonal.fnugetpersonid;
    END IF;

    dbms_output.put_line('*********** Codigo Tipo Comentario[' || nuInfomrGen || ']');
    dbms_output.put_line('*********** Fecha sistema[' || open.pkgeneralservices.fdtgetsystemdate || ']');
    dbms_output.put_line('*********** Person ID[' || nuPersonID || ']');

    --Recorrer ordenes del contrato de venta a constructora
    FOR rfcuproductopenins in cuproductopenins LOOP
        nuTotal := nuTotal + 1;
        BEGIN
            dbms_output.put_line('************* ANULAR ORDEN [' || rfcuproductopenins.ORDEN || ']');

            -- or_boanullorder.anullorderwithoutval(rfcuproductopenins.ORDEN,SYSDATE);
            -- Se reemplaza por el nuevo API para anular ordenes - GDGA 14/02/2024
            api_anullorder
            (
                rfcuproductopenins.ORDEN,
                null,
                null,
                nuErrorCode,
                sbErrorMessage
            );
            IF (nuErrorCode <> 0) THEN
                dbms_output.put_line('Error en api_anullorder, Orden: '|| rfcuproductopenins.ORDEN ||', '|| sbErrorMessage);
                RAISE exError;
            END IF;      

            -- Cambia el estado de la orden a Finalizada
            update open.or_order_activity
             set status = 'F'
            where order_id = rfcuproductopenins.ORDEN;

            rcOR_ORDER_COMMENT.ORDER_COMMENT_ID := seq_or_order_comment.nextval;
            rcOR_ORDER_COMMENT.ORDER_COMMENT    := SBCOMMENT;
            rcOR_ORDER_COMMENT.ORDER_ID         := rfcuproductopenins.ORDEN;
            rcOR_ORDER_COMMENT.COMMENT_TYPE_ID  := nuInfomrGen;
            rcOR_ORDER_COMMENT.REGISTER_DATE    := open.pkgeneralservices.fdtgetsystemdate;
            rcOR_ORDER_COMMENT.LEGALIZE_COMMENT := 'N';
            rcOR_ORDER_COMMENT.PERSON_ID        := nuPersonID;

            -- Inserta el registro en or_order_comment
            daor_order_comment.insrecord(rcOR_ORDER_COMMENT);

            --
            -- Se actualiza la fecha de retiro en el producto y componente - GDGA 15/02/2024
            update open.pr_product
             set product_status_id = 16,  -- Retirado sin instalacion
                 suspen_ord_act_id = null,
                 retire_date = sysdate
            where product_id = rfcuproductopenins.PRODUCTO;
            --       
            -- Estado de corte
            update open.servsusc s
             set s.sesuesco = 110, -- Retirado sin Instalacion
                 s.sesufere = sysdate
            where sesunuse = rfcuproductopenins.PRODUCTO;

            -- componente del producto
            update open.pr_component
             set component_status_id = 18  -- Retirado sin instalacion
            where product_id = rfcuproductopenins.PRODUCTO;

            update open.compsesu
             set cmssescm = 18,  --
                 cmssfere = sysdate
            where cmsssesu = rfcuproductopenins.PRODUCTO;      
            --
            -- Cambia estado del motivo
            update open.mo_motive m
             set m.motive_status_id = 5
            where m.package_id = cnuPackage_id
             and m.product_id in rfcuproductopenins.PRODUCTO;

            -- Componentes del motivo
            update mo_component m
             set m.motive_status_id = 26
            where m.package_id = cnuPackage_id
             and m.product_id = rfcuproductopenins.PRODUCTO;
            --

            nuCont := nuCont + 1;

            -- Asienta la transaccion
            commit;

        EXCEPTION
            WHEN exError THEN
                rollback;
            WHEN OTHERS THEN
                rollback;
                dbms_output.put_line('Error Anulando Orden: '|| rfcuproductopenins.ORDEN ||', SQLERRM: '|| SQLERRM );
        END;
       
    END LOOP;
    --

    dbms_output.put_line('Fin del Proceso. Ordenes Seleccionadas: '||nuTotal||', Ordenes Anuladas: '||nuCont);
    
EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error del proceso. Ordenes Seleccionadas: '||nuTotal||', Ordenes Anuladas: '||nuCont ||', '||SQLERRM );    

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/