column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
/*
    OSF-2474: Se solicita la anulación de los motivos de solicitud, de ordenes de trabajo (Anuladas),
              retiro de productos (16-Retirado sin instalación), cambio de estado de corte (110-Retirado sin instalación),
              retiro de componentes de producto (18-Retirado sin instalación), actualización fecha de retiro,
              de los 2 contratos y productos anexos que pertenecen a diferentes solicitudes de venta que según
              memorando 23-006260 instalaciones realizo la visita y les notifico a los usuarios el proceso que
              se va a seguir ya que no se van a construir. Esto no se puede anular por la herramienta porque
              son ventas fuera del módulo de constructoras

              segun verificacion realizada se pudo evidenciar que no habian cambiado porque tenian datos errados.
              se adjunta informacion correcta para que por favor nos colaboren con estos dos que quedaron pendientes.

                CONTRATO    solicitud   Producto
                66440361    38575930    51149125
                66595554    63287646    51408557

    Autor:    German Dario Guevara Alzate - GlobaMVM
    Fecha:    13/03/2024
*/
    -- Informacion general
    sbComment       CONSTANT VARCHAR2(200) := 'SE ANULA ORDEN CON EL CASO OSF-2474';
    nuCommentType   CONSTANT NUMBER        := 1277;

    -- Tipo de dato de tabla PL, donde el indice es el contrato y el valor es la solicitud
    TYPE tytbSusc IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    tbSusc      tytbSusc;

    -- Cursor para traer las ordenes del contrato dado
    CURSOR cuOrderActiv
    (
        inuSusc     NUMBER,
        inuPackage  NUMBER
    )
    IS
        select oa.product_id       PRODUCTO,
               oa.order_id         ORDEN,
               gc.class_causal_id  CLASS_CAUSAL
        from open.or_order_activity oa
            inner join open.or_order o   ON o.order_id  = oa.order_id
                                        AND o.order_status_id not in (8,12)
            left  join open.ge_causal gc ON o.causal_id = gc.causal_id
        where oa.package_id = inuPackage
          and oa.motive_id in (select motive_id
                               from open.mo_motive mo
                               where mo.package_id = oa.package_id
                                 and mo.subscription_id = inuSusc);

    -- Cursor de Person ID para el comentario
    CURSOR cuLoadData IS
        select person_id
        from ge_person
        where person_id = 13549; -- Pablo

    rcOR_ORDER_COMMENT  open.daor_order_comment.styor_order_comment;
    nuPersonID          open.ge_person.person_id%type;
    nuErrorCode         NUMBER;
    nuSusc              NUMBER;
    nuCont              NUMBER;
    nuTotal             NUMBER;
    nuTotOrd            NUMBER;
    nuEstado            NUMBER;
    nuPackage           NUMBER;
    sbErrorMessage      VARCHAR2(4000);
    sbEstado            VARCHAR2(10);
    exError             EXCEPTION;

BEGIN
    nuCont   := 0;
    nuTotal  := 0;
    nuTotOrd := 0;
    tbSusc.DELETE;

    -- tbSusc(SUSCCODI) := PACKAGE_ID
    tbSusc(66440361) := 38575930;
    tbSusc(66595554) := 63287646;

    -- Carga de Person ID para el comentario
    open cuLoadData;
    fetch cuLoadData into nuPersonID;
    close cuLoadData;

    -- sino existe la persona pone la default de OPEN
    IF nuPersonID is null THEN
        nuPersonID := ge_bopersonal.fnugetpersonid;
    END IF;

    dbms_output.put_line('Inicia Proceso OSF-2474_Anular_Productos_Constructora');
    dbms_output.put_line('---------------------------------------------------------------------------------');
    dbms_output.put_line('Codigo Tipo Comentario[' || nuCommentType || ']');
    dbms_output.put_line('Mensaje del Comentario[' || sbComment || ']');
    dbms_output.put_line('Person ID             [' || nuPersonID || ']');
    dbms_output.put_line('Fecha sistema         [' || open.pkgeneralservices.fdtgetsystemdate || ']');

    -- Total de registros de la coleccion
    nuTotal := tbSusc.COUNT;

    -- Primer registro
    nuSusc  := tbSusc.FIRST;

    -- Recorre la coleccion
    LOOP
        EXIT WHEN nuSusc IS NULL;
        nuPackage := tbSusc(nuSusc);
        --Recorrer ordenes de venta de cada contrato x solicitud
        FOR rcOrderActiv in cuOrderActiv (nuSusc, nuPackage) LOOP
            nuTotOrd := nuTotOrd + 1;
            BEGIN
                dbms_output.put_line(chr(10)||'ANULA ORDEN: ['||rcOrderActiv.ORDEN||'] CONTRATO: ['||nuSusc||']');

                -- Si la Orden no esta legalizada con causal de exito, anula
                IF NVL(rcOrderActiv.CLASS_CAUSAL, 0) = 1 THEN
                    dbms_output.put_line('Contrato: '||nuSusc||', con Orden: '|| rcOrderActiv.ORDEN ||' Esta legalizada con Exito y No se puede Anular');
                    RAISE exError;
                END IF;

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
                    dbms_output.put_line('Error en api_anullorder, Contrato: '||nuSusc||', con Orden: '|| rcOrderActiv.ORDEN ||', '|| sbErrorMessage);
                    RAISE exError;
                END IF;

                -- Arma el registro con el comentario
                rcOR_ORDER_COMMENT.ORDER_COMMENT_ID := seq_or_order_comment.nextval;
                rcOR_ORDER_COMMENT.ORDER_COMMENT    := sbComment;
                rcOR_ORDER_COMMENT.ORDER_ID         := rcOrderActiv.ORDEN;
                rcOR_ORDER_COMMENT.COMMENT_TYPE_ID  := nuCommentType;
                rcOR_ORDER_COMMENT.REGISTER_DATE    := open.pkgeneralservices.fdtgetsystemdate;
                rcOR_ORDER_COMMENT.LEGALIZE_COMMENT := 'N';
                rcOR_ORDER_COMMENT.PERSON_ID        := nuPersonID;

                -- Inserta el registro en or_order_comment
                daor_order_comment.insrecord(rcOR_ORDER_COMMENT);

                -- Cambia el estado de la orden a Finalizada
                nuEstado := null;
                update open.or_order_activity
                  set status     = 'F',
                      final_date = sysdate
                where order_id = rcOrderActiv.ORDEN
                  and status <> 'F'
                returning order_activity_id INTO nuEstado;

                IF (nuEstado is not null) THEN
                    dbms_output.put_line('Actualiza OR_ORDER_ACTIVITY: '||nuEstado||', Estado F-finalizada OK');
                END IF;

                -- Se actualiza la fecha de retiro en el producto y componente
                nuEstado := null;
                update open.pr_product
                  set product_status_id = 16,  -- Retirado sin instalacion
                      suspen_ord_act_id = null,
                      retire_date       = sysdate
                where product_id = rcOrderActiv.PRODUCTO
                  and product_status_id <> 16
                returning product_id INTO nuEstado;

                IF (nuEstado is not null) THEN
                    dbms_output.put_line('Actualiza PR_PRODUCT product_id: '||nuEstado||', Estado del producto 16 Retirado OK');
                END IF;

                -- Estado de corte
                nuEstado := null;
                update open.servsusc
                  set sesuesco = 110,         -- Retirado sin Instalacion
                      sesufere = sysdate
                where sesunuse = rcOrderActiv.PRODUCTO
                  and sesuesco <> 110
                returning sesunuse INTO nuEstado;

                IF (nuEstado is not null) THEN
                    dbms_output.put_line('Actualiza SERVSUSC sesunuse: '||nuEstado||', estado de corte 110 OK');
                END IF;

                -- componente del producto
                nuEstado := null;
                update open.pr_component
                  set component_status_id = 18, -- Retirado sin instalacion
                      last_upd_date       = sysdate
                where product_id = rcOrderActiv.PRODUCTO
                  and component_status_id <> 18
                returning count(1) INTO nuEstado;

                IF (nvl(nuEstado,0) > 0) THEN
                    dbms_output.put_line('Actualiza PR_COMPONENT total: '||nuEstado||', estado del componente 18 OK');
                END IF;

                -- componente del producto
                nuEstado := null;
                update open.compsesu
                  set cmssescm = 18,            -- Retirado sin instalacion
                      cmssfere = sysdate
                where cmsssesu = rcOrderActiv.PRODUCTO
                  and cmssescm <> 18
                returning count(1) INTO nuEstado;

                IF (nvl(nuEstado,0) > 0) THEN
                    dbms_output.put_line('Actualiza COMPSESU total: '||nuEstado||', estado del componente 18 OK');
                END IF;

                -- Cambia estado del motivo
                nuEstado := null;
                update open.mo_motive m
                  set m.motive_status_id   = 5,
                      m.status_change_date = sysdate,
                      m.annul_date         = sysdate
                where m.package_id = nuPackage
                  and m.product_id in rcOrderActiv.PRODUCTO
                  and motive_status_id <> 5
                returning count(1) INTO nuEstado;

                IF (nvl(nuEstado,0) > 0) THEN
                    dbms_output.put_line('Actualiza MO_MOTIVE total: '||nuEstado||', estado del motivo 5 OK');
                END IF;

                -- Componentes del motivo
                nuEstado := null;
                update mo_component m
                  set m.motive_status_id   = 26,
                      m.status_change_date = sysdate,
                      m.annul_date         = sysdate
                where m.package_id = nuPackage
                  and m.product_id = rcOrderActiv.PRODUCTO
                  and motive_status_id <> 26
                returning count(1) INTO nuEstado;

                IF (nvl(nuEstado,0) > 0) THEN
                    dbms_output.put_line('Actualiza MO_COMPONENT total: '||nuEstado||', estado del componente 26 OK');
                END IF;

                nuCont := nuCont + 1;

                -- Asienta la transaccion
                commit;

            EXCEPTION
                WHEN exError THEN
                    rollback;
                WHEN OTHERS THEN
                    rollback;
                    dbms_output.put_line('Error: Contrato '||nuSusc||', con Orden: '|| rcOrderActiv.ORDEN ||', no se pudo Anular. SQLERRM: '|| SQLERRM );
            END;

        END LOOP;
        -- Siguiente registro
        nuSusc := tbSusc.NEXT(nuSusc);
    END LOOP;

    tbSusc.DELETE;
    dbms_output.put_line('---------------------------------------------------------------------------------');
    dbms_output.put_line('Fin del Proceso. Total Contratos: '||nuTotal||', Ordenes Selecc.: '||nuTotOrd||', Ordenes Anuladas: '||nuCont);

EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error del proceso. Total Contratos: '||nuTotal||', Ordenes Selecc.: '||nuTotOrd||', Ordenes Anuladas: '||nuCont ||', '||SQLERRM );
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/