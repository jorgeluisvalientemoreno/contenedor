column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
/*
    OSF-2346: Se solicita anular 5 contratos hijos del proyecto #2019 TERRA bajo
              contrato padre 67206509 solicitud 181882394, por solicitud del cliente
              los contratos que se deben anular son los siguientes:
                67346653 - Casa 153
                67346674 - Casa 172
                67346696 - Casa 195
                67346691 - Casa 189
                67346554 - Casa 219
*/
    -- ID de la solicitud relacionada a los contratos a retirar
    cnuPackage_id   constant number := 181882394;
    -- Informacion general
    nuInfomrGen     constant open.or_order_comment.comment_type_id%type := 1277;

    -- Cursor para Anular ordenes de contratos definidos del CASO OSF-2346
    CURSOR cuOrderActiv is
        select product_id PRODUCTO, order_id ORDEN
        from open.or_order_activity oa
        where oa.package_id = cnuPackage_id
          and oa.motive_id in (select motive_id
                               from open.mo_motive mo
                               where mo.package_id = oa.package_id
                                 and mo.subscription_id in (67346653,67346674,67346696,67346691,67346554));

    -- Cursor de Person ID para el comentario
    CURSOR cuLoadData IS
        select person_id
        from ge_person
        where person_id = 13549; -- Pablo

    -- Registro de Comentario de la orden
    rcOR_ORDER_COMMENT  open.daor_order_comment.styor_order_comment;
    nuPersonID          open.ge_person.person_id%type;

    sbComment           VARCHAR2(4000) := 'SE ANULA ORDEN CON EL CASO OSF-2346';
    nuCommentType       number         := 1277;

    nuErrorCode         number;
    nuCont              number;
    nuTotal             number;
    nuOrderCommentID    number;
    sbErrorMessage      varchar2(4000);
    exError             EXCEPTION;

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
            update open.servsusc s
              set s.sesuesco = 110,         -- Retirado sin Instalacion
                  s.sesufere = sysdate
            where sesunuse = rcOrderActiv.PRODUCTO;

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
              set m.motive_status_id = 5
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

    END LOOP;

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