column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
DECLARE
/*
    OSF-2759: Se solicita la anulación de las solicitudes, los motivos de solicitud, de ordenes de trabajo (Anuladas), 
              retiro de productos (16-Retirado sin instalación), cambio de estado de corte (110-Retirado sin instalación), 
              retiro de componentes de producto (18-Retirado sin instalación), 
              actualización fecha de retiro, de los 2 contratos y productos 

              Contrato 67567059 solicitud 214339471
              Contrato 67567061 solicitud 214339685
              Contrato 67567065 solicitud 214339749

              Esto no se puede anular por la herramienta porque son ventas fuera del módulo de constructoras.

    Autor:    German Dario Guevara Alzate - GlobaMVM
    Fecha:    28/05/2024
*/
    -- Informacion general
    sbComment       CONSTANT VARCHAR2(200) := 'SE ANULA ORDEN CON EL CASO OSF-2759';
    nuCommentType   CONSTANT NUMBER        := 1277;

    -- Tipo de dato de tabla PL, donde el indice es el contrato y el valor es la solicitud
    TYPE tytbSusc IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    tbSusc      tytbSusc;
    
/*
    -- Cursor aplica para traer las ordenes de un contrato especifico y una solicitud dada
    CURSOR cuOrderActiv
    (
        inuSusc     NUMBER,
        inuPackage  NUMBER
    )
    IS
        select oa.product_id       PRODUCTO,
               oa.order_id         ORDEN,
               gc.class_causal_id  CLASS_CAUSAL,
               (select sesuserv from open.servsusc where sesunuse = oa.product_id) SESUSERV
        from open.or_order_activity oa
            inner join open.or_order o   ON o.order_id  = oa.order_id
                                        AND o.order_status_id not in (8,12)
            left  join open.ge_causal gc ON o.causal_id = gc.causal_id
        where oa.package_id = inuPackage
          and oa.motive_id in (select motive_id
                               from open.mo_motive mo
                               where mo.package_id = oa.package_id
                                 and mo.subscription_id = inuSusc);
*/


    -- Cursor aplica para traer las ordenes de una solicitud dada
    CURSOR cuOrderActiv
    (
        inuSusc     NUMBER,
        inuPackage  NUMBER
    )
    IS                                 
        select oa.product_id       PRODUCTO,
               oa.order_id         ORDEN,
               gc.class_causal_id  CLASS_CAUSAL,
               (select sesuserv from open.servsusc where sesunuse = oa.product_id) SESUSERV
        from open.or_order_activity oa
            inner join open.or_order o   ON o.order_id  = oa.order_id
                                        AND o.order_status_id not in (8,12)
            left  join open.ge_causal gc ON o.causal_id = gc.causal_id
        where oa.package_id = inuPackage;

    -- Cursor de Person ID para el comentario
    CURSOR cuLoadData IS
        select person_id
        from ge_person
        where person_id = 13549; -- Pablo

    rcOR_ORDER_COMMENT      open.daor_order_comment.styor_order_comment;
    nuPersonID              open.ge_person.person_id%type;
    package_idvar           MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type := null;
    cust_care_reques_numvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type := null;
    package_type_idvar      MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type := null;
    current_table_namevar   MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type := 'MO_PACKAGES';
    current_event_idvar     MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type := ge_boconstants.UPDATE_;
    current_even_descvar    MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type := 'UPDATE';
    o_motive_status_idvar   MO_PACKAGE_CHNG_LOG.o_motive_status_id%TYPE;    
    nuErrorCode             NUMBER;
    nuSusc                  NUMBER;
    nuCont                  NUMBER;
    nuTotal                 NUMBER;
    nuTotOrd                NUMBER;
    nuEstado                NUMBER;
    nuPackage               NUMBER;
    nuOrdenes               NUMBER;
    nuEstaCort              NUMBER;
    nuTotSol                NUMBER;
    sbErrorMessage          VARCHAR2(4000);
    sbEstado                VARCHAR2(10);
    exError                 EXCEPTION;
    nuPlanId                wf_instance.instance_id%type;

BEGIN
    nuCont   := 0;
    nuTotal  := 0;
    nuTotOrd := 0;
    nuTotSol := 0;
    tbSusc.DELETE;

    -- tbSusc(SUSCCODI) := PACKAGE_ID
    tbSusc(67567059) := 214339471;
    tbSusc(67567061) := 214339685;
    tbSusc(67567065) := 214339749;

    -- Carga de Person ID para el comentario
    open cuLoadData;
    fetch cuLoadData into nuPersonID;
    close cuLoadData;

    -- sino existe la persona pone la default de OPEN
    IF nuPersonID is null THEN
        nuPersonID := ge_bopersonal.fnugetpersonid;
    END IF;

    dbms_output.put_line('Inicia Proceso OSF-2733_Anular_Productos_Constructora');
    dbms_output.put_line('----------------------------------------------------------------------------');
    dbms_output.put_line('Codigo Tipo Comentario[' || nuCommentType || ']');
    dbms_output.put_line('Mensaje del Comentario[' || sbComment || ']');
    dbms_output.put_line('Person ID             [' || nuPersonID || ']');
    dbms_output.put_line('Fecha sistema         [' || open.pkgeneralservices.fdtgetsystemdate || ']');
    dbms_output.put_line('----------------------------------------------------------------------------');

    -- Total de registros de la coleccion
    nuTotal := tbSusc.COUNT;

    -- Primer registro
    nuSusc  := tbSusc.FIRST;

    -- Recorre la coleccion
    LOOP
        EXIT WHEN nuSusc IS NULL;
        nuPackage := tbSusc(nuSusc);
        dbms_output.put_line('Procesando contrato: ['||nuSusc||']');
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

                -- Valida servicio para asignar estado de corte
                -- 95:  Retiro para el tipo de producto 6121
                -- 110: Retirado sin instalacion para el tipo de producto 7014
                nuEstaCort := 110;                
                IF (rcOrderActiv.SESUSERV = 6121) THEN
                    nuEstaCort := 95;
                END IF;
                
                -- Estado de corte
                nuEstado := null;
                update open.servsusc
                  set sesuesco = nuEstaCort,
                      sesufere = sysdate
                where sesunuse = rcOrderActiv.PRODUCTO
                  and sesuesco <> nuEstaCort
                returning sesuesco INTO nuEstado;

                IF (nuEstado is not null) THEN
                    dbms_output.put_line('Actualiza SERVSUSC sesunuse: '||nuEstaCort||', estado de corte '||nuEstaCort);
                END IF;                
                
                dbms_output.put_line('Actualiza SERVSUSC sesunuse: '||rcOrderActiv.PRODUCTO||', estado de corte 110 OK');

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
        
        --Cambio estado de la solicitud siempre y cuando no exista ninguna orden pendiente
        nuEstado := null;
        UPDATE OPEN.mo_packages
          SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'), 
              attention_date = sysdate
        WHERE package_id = nuPackage
          AND motive_status_id not in(14, dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'))
          AND NOT EXISTS (select 1 
                          from open.or_order_activity oa 
                               inner join open.or_order o  ON oa.order_id = o.order_id 
                                                          AND o.order_status_id not in (8, 12)
                               left join open.ge_causal gc ON o.causal_id = gc.causal_id
                          where oa.package_id = nuPackage
                            and nvl(gc.class_causal_id,0) <> 1)
        returning count(1) INTO nuEstado;

        IF (nvl(nuEstado,0) > 0) THEN
            dbms_output.put_line('Actualiza MO_PACKAGE: '||nuPackage||', estado '||dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'));
            nuTotSol := nuTotSol + 1;
            -- Adiciona log de cambio de estado de la solicitud
            package_idvar           := nuPackage;
            cust_care_reques_numvar := damo_packages.fsbgetcust_care_reques_num (nuPackage,null);
            package_type_idvar      := damo_packages.fnugetpackage_type_id (nuPackage, null);
            o_motive_status_idvar   := damo_motive.fnugetmotive_status_id (mo_bcpackages.fnugetmotiveid(nuPackage));

            INSERT INTO MO_PACKAGE_CHNG_LOG
                (
                    CURRENT_USER_ID,
                    CURRENT_USER_MASK,
                    CURRENT_TERMINAL,
                    CURRENT_TERM_IP_ADDR,
                    CURRENT_DATE,
                    CURRENT_TABLE_NAME,
                    CURRENT_EXEC_NAME,
                    CURRENT_SESSION_ID,
                    CURRENT_EVENT_ID,
                    CURRENT_EVEN_DESC,
                    CURRENT_PROGRAM,
                    CURRENT_MODULE,
                    CURRENT_CLIENT_INFO,
                    CURRENT_ACTION,
                    PACKAGE_CHNG_LOG_ID,
                    PACKAGE_ID,
                    CUST_CARE_REQUES_NUM,
                    PACKAGE_TYPE_ID,
                    O_MOTIVE_STATUS_ID,
                    N_MOTIVE_STATUS_ID
                 )
            VALUES
                (
                    AU_BOSystem.getSystemUserID,
                    AU_BOSystem.getSystemUserMask,
                    ut_session.getTERMINAL,
                    ut_session.getIP,
                    ut_date.fdtSysdate,
                    current_table_namevar,
                    AU_BOSystem.getSystemProcessName,
                    ut_session.getSESSIONID,
                    current_event_idvar,
                    current_even_descvar,
                    ut_session.getProgram || '-' || SBCOMMENT,
                    ut_session.getModule,
                    ut_session.GetClientInfo,
                    ut_session.GetAction,
                    MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,
                    package_idvar,
                    cust_care_reques_numvar,
                    package_type_idvar,
                    o_motive_status_idvar,
                    dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
                ); 
                
               -- Se obtiene el plan de wf
               BEGIN
                nuPlanId := wf_boinstance.fnugetplanid(package_idvar, 17);
               EXCEPTION
                WHEN OTHERS THEN
                  dbms_output.put_line('Error wf_boinstance.fnugetplanid : '||to_char(package_idvar)||' - '|| 'Plan_Id no Existe. SQLERRM: '|| SQLERRM );
                  null;
               END;
                -- anula el plan de wf
               IF nuPlanId is not null THEN
                 BEGIN
                  mo_boannulment.annulwfplan(nuPlanId);
                 EXCEPTION
                  WHEN OTHERS THEN
                    dbms_output.put_line('Error mo_boannulment.annulwfplan : '||to_char(nuPlanId)||' - '|| SQLERRM );
                    ROLLBACK;
                 END;
               END IF;                
                
            COMMIT;
            --
        END IF;        

        -- Siguiente registro
        nuSusc := tbSusc.NEXT(nuSusc);
    END LOOP;

    tbSusc.DELETE;
    dbms_output.put_line('----------------------------------------------------------------------------');
    dbms_output.put_line('Fin del Proceso. Total Contratos: '||nuTotal||', Ordenes Selecc.: '||nuTotOrd||', Ordenes Anuladas: '||nuCont||', Solicitudes Anuladas: '||nuTotSol);

EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error del proceso. Total Contratos: '||nuTotal||', Ordenes Selecc.: '||nuTotOrd||', Ordenes Anuladas: '||nuCont||', Solicitudes Anuladas: '||nuTotSol||', '||SQLERRM );
END;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/