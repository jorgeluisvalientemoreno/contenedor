column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
/*
    OSF-2409 verificar ERROR en anulacion de venta contrato 66770401
             Se requiere revisar porque razón a pesar de tener las condiciones para ser anulada no es
             posible la anulacion del contrato 66770401 solicitud de venta 85409798 al parecer el plan
             comercial 51 - 51-PRECIO ESPECIAL LAS TINAS no es posible anularlo pero se necesita saber
             porque razón y si hay alguna manera de configurarlo.

    Se crea este caso para realizar la solución operativa con respecto al producto y sus estados.
*/
    -- ID de la solicitud relacionada a los contratos a retirar
    cnuPackage_id   constant number := 85409798;
    -- Informacion general
    nuInfomrGen     constant open.or_order_comment.comment_type_id%type := 1277;

    -- Cursor para Anular ordenes de contratos definidos del CASO OSF-2409
    CURSOR cuOrderActiv is
        select product_id PRODUCTO, order_id ORDEN
        from open.or_order_activity oa
        where oa.package_id = cnuPackage_id
          and oa.motive_id in (select motive_id
                               from open.mo_motive mo
                               where mo.package_id = oa.package_id
                                 and mo.subscription_id in (66770401));

    -- Cursor para retirar los productos CASO OSF-2409
    CURSOR cuProducto is
        select unique (product_id) PRODUCTO
        from open.or_order_activity oa
        where oa.package_id = cnuPackage_id
          and oa.product_id is not null
          and oa.motive_id in (select motive_id
                               from open.mo_motive mo
                               where mo.package_id = oa.package_id
                                 and mo.subscription_id in (66770401));

    -- Cursor de Person ID para el comentario
    CURSOR cuLoadData IS
        select person_id
        from ge_person
        where person_id = 13549; -- Pablo

    -- Registro de Comentario de la orden
    rcOR_ORDER_COMMENT  open.daor_order_comment.styor_order_comment;
    nuPersonID          open.ge_person.person_id%type;

    sbComment           VARCHAR2(4000) := 'SE ANULA ORDEN CON EL CASO OSF-2409';
    nuCommentType       number         := 1277;

    nuErrorCode         number;
    nuContOrd           number;
    nuTotOrd            number;
    nuContProd          number;
    nuTotProd           number;
    nuError             number;
    nuOrderCommentID    number;
    sbErrorMessage      varchar2(4000);
    exError             EXCEPTION;

BEGIN

    nuContOrd  := 0;
    nuTotOrd   := 0;
    nuContProd := 0;
    nuTotProd  := 0;
    nuError    := 0;

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

    -- Recorrer ordenes del contrato de venta
    FOR rcOrderActiv in cuOrderActiv LOOP
        nuTotOrd := nuTotOrd + 1;
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

            nuContOrd := nuContOrd + 1;

            -- Asienta la transaccion
            commit;

        EXCEPTION
            WHEN exError THEN
                rollback;
                nuError := 1;
            WHEN OTHERS THEN
                rollback;
                dbms_output.put_line('Error Anulando Orden: '|| rcOrderActiv.ORDEN ||', SQLERRM: '|| SQLERRM );
                nuError := 1;
        END;

    END LOOP;

    -- Si no hay error al anular las ordenes, retira los producto asociados
    IF nuError = 0 or nuContOrd > 0 THEN

        -- Recorrer los productos del contrato de venta
        FOR rcProd in cuProducto LOOP
            nuTotProd := nuTotProd + 1;
            BEGIN
                -- Se actualiza la fecha de retiro en el producto y componente - GDGA 15/02/2024
                update open.pr_product
                  set product_status_id = 16,  -- Retirado sin instalacion
                      suspen_ord_act_id = null,
                      retire_date = sysdate
                where product_id = rcProd.PRODUCTO;

                -- Estado de corte
                update open.servsusc s
                  set s.sesuesco = 110,         -- Retirado sin Instalacion
                      s.sesufere = sysdate
                where sesunuse = rcProd.PRODUCTO;

                -- componente del producto
                update open.pr_component
                  set component_status_id = 18  -- Retirado sin instalacion
                where product_id = rcProd.PRODUCTO;

                update open.compsesu
                  set cmssescm = 18,  --
                      cmssfere = sysdate
                where cmsssesu = rcProd.PRODUCTO;

                -- Cambia estado del motivo
                update open.mo_motive m
                  set m.motive_status_id = 5
                where m.package_id = cnuPackage_id
                  and m.product_id in rcProd.PRODUCTO;

                -- Componentes del motivo
                update open.mo_component m
                  set m.motive_status_id = 26
                where m.package_id = cnuPackage_id
                  and m.product_id = rcProd.PRODUCTO;

                nuContProd := nuContProd + 1;

                -- Asienta la transaccion
                commit;

            EXCEPTION
                WHEN exError THEN
                    rollback;
                    nuError := 1;
                WHEN OTHERS THEN
                    rollback;
                    dbms_output.put_line('Error retirando producto: '|| rcProd.PRODUCTO ||', SQLERRM: '|| SQLERRM );
                    nuError := 1;
            END;

        END LOOP;
    END IF;

    dbms_output.put_line('Ordenes Seleccionadas:   '||nuTotOrd ||', Ordenes Anuladas:    '||nuContOrd);
    dbms_output.put_line('Productos Seleccionados: '||nuTotProd||', Productos Retirados: '||nuContProd);
    dbms_output.put_line('Fin del Proceso.');

EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error del proceso. Ordenes Seleccionadas: '||nuTotOrd||', Ordenes Anuladas: '||nuContOrd ||', '||SQLERRM );
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/