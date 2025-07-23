/**********************************
Caso: OSF-4196
Descripcion: Anulación solicitudes
Fecha: 07/04/2025
***********************************/
DECLARE
    CURSOR cusolicitudes IS
    SELECT
    p2.package_id,
    p2.request_date,
    p2.motive_status_id,
    p2.user_id,
    p2.comment_,
    p2.cust_care_reques_num,
    p2.package_type_id
FROM
         open.mo_packages p
    INNER JOIN open.mo_packages p2 ON p2.cust_care_reques_num = to_char(p.cust_care_reques_num)
WHERE
    p.package_id IN ( 223748955, 223598442, 223597873, 223583024, 223581838,
                      223077512, 221190719, 220706170, 220549496, 220364740,
                      219867402, 219743688, 219654109, 219395853, 219129459,
                      218665024, 218664784, 218618580, 218317144, 217373157,
                      217358640, 217092162, 216743646, 215940030, 215195354,
                      214025305, 212695145, 212388042, 211721557, 211585319,
                      211454351, 211198087, 210616985, 209073562, 207033987,
                      206806085, 206773464, 205078349, 205078283, 203337632,
                      203248141, 202543037, 202542075, 201905061, 201904954,
                      201877371, 201658481, 201605201, 200255205, 200253699,
                      197891223, 197702167, 197295057, 197295009, 197294958,
                      197294905, 197052442, 197052339, 196226443, 196044297,
                      196044180, 195873643, 189257137, 187054910, 184023724,
                      183543065, 183255173, 183213307, 183210779, 180108557,
                      180056839, 178815736, 174809220, 153981668, 129068693,
                      129052423, 124920350, 117323783, 117322883, 116567834,
                      116567644, 110500481, 110500141, 110499923, 109542850,
                      107459885, 106886908, 106886800, 106886507, 98785663,
                      88373420, 86202109, 85791089, 83040789, 83034338,
                      82002666, 81467300, 81467233, 81466828, 80741134,
                      79968163, 79968090, 67566738, 66184119, 65819496,
                      64188644, 63870147, 63635018, 63373832, 63326934,
                      63316530, 63296795, 63289971, 61879313, 60659711,
                      60658712, 60392666, 60204057, 60164851, 60086738,
                      60086429, 60065680, 60065599, 60065461, 59993321,
                      59991120, 59990576, 59968839, 58285845, 58264980,
                      55715813, 55202220, 55200981, 55189751, 55006590,
                      55006390, 55005092, 55005067, 54472057, 54471156,
                      54469963, 54468853, 54468243, 54467785, 49534424,
                      49532231, 49049476, 48801907, 48626537, 48474262,
                      43371856, 43368977, 43368804, 42952155, 42929125,
                      42518758, 42518318, 42518093, 42517975, 41551213,
                      41549900, 40612072, 40611405, 40601021, 40599948,
                      39524173, 39520478, 39509116, 39505313 )
        AND p2.motive_status_id = 13
    ORDER BY
        p2.package_id;

    sbcomment               VARCHAR2(4000) := 'Se cambia estado a anulado por OSF-4196';
    sbmensaje               VARCHAR2(4000);
    eerrorexception EXCEPTION;
    onuerrorcode            NUMBER(18);
    osberrormessage         VARCHAR2(2000);
    cnucommenttype          CONSTANT NUMBER := 83;
    nuplanid                wf_instance.instance_id%TYPE;
    nuerror                 NUMBER;
    nucommenttype           NUMBER := 1277;
    nuerrorcode             NUMBER;
    nucont                  NUMBER;
    sberrormesse            VARCHAR2(4000);
    TYPE t_array_solicitudes IS
        TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    v_array_solicitudes     t_array_solicitudes;
    package_idvar           mo_package_chng_log.package_id%TYPE := NULL;
    cust_care_reques_numvar mo_package_chng_log.cust_care_reques_num%TYPE := NULL;
    package_type_idvar      mo_package_chng_log.package_type_id%TYPE := NULL;
    current_table_namevar   mo_package_chng_log.current_table_name%TYPE := 'MO_PACKAGES';
    current_event_idvar     mo_package_chng_log.current_event_id%TYPE := ge_boconstants.update_;
    current_even_descvar    mo_package_chng_log.current_even_desc%TYPE := 'UPDATE';
    o_motive_status_idvar   mo_package_chng_log.o_motive_status_id%TYPE;
    CURSOR cuordenes (
        nusolicitud NUMBER
    ) IS
    SELECT
        o.order_id,
        order_status_id,
        o.operating_unit_id
    FROM
        open.or_order          o,
        open.or_order_activity a
    WHERE
            a.order_id = o.order_id
        AND a.package_id = nusolicitud
        AND a.status != 'F';

    CURSOR cuerrorflujo (
        nusol NUMBER
    ) IS
    SELECT
        'MOPRP' forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        el.message,
        NULL,
        el.date_,
        NULL    codigo_cambiar
    FROM
        open.mo_executor_log_mot lm,
        open.ge_executor_log     el,
        open.mo_packages         p
    WHERE
            lm.executor_log_id = el.executor_log_id
        AND p.package_id = lm.package_id
        AND lm.status_exec_log_id = 4
        AND p.package_id = nusol
    UNION ALL
    SELECT
        'MOPWP' forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        el.message,
        NULL,
        el.date_,
        NULL    codigo_cambiar
    FROM
        open.mo_wf_pack_interfac lm,
        open.ge_executor_log     el,
        open.mo_packages         p
    WHERE
            lm.executor_log_id = el.executor_log_id
        AND p.package_id = lm.package_id
        AND lm.status_activity_id = 4
        AND p.package_id = nusol
    UNION ALL
    SELECT
        'MOPWM' forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        el.message,
        NULL,
        el.date_,
        NULL    codigo_cambiar
    FROM
        open.mo_wf_motiv_interfac lm,
        open.ge_executor_log      el,
        open.mo_packages          p,
        open.mo_motive            m
    WHERE
            lm.executor_log_id = el.executor_log_id
        AND p.package_id = m.package_id
        AND m.motive_id = lm.motive_id
        AND p.package_id = nusol
    UNION ALL
    SELECT
        'MOPWC' forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        el.message,
        NULL,
        el.date_,
        NULL    codigo_cambiar
    FROM
        open.mo_wf_comp_interfac lm,
        open.ge_executor_log     el,
        open.mo_packages         p,
        open.mo_component        c
    WHERE
            lm.executor_log_id = el.executor_log_id
        AND p.package_id = c.package_id
        AND c.component_id = lm.component_id
        AND lm.status_activity_id = 4
        AND p.package_id = nusol
    UNION ALL
    SELECT
        'INRMO/WFEWF' forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        el.message_desc,
        wf.instance_id,
        el.log_date,
        NULL          codigo_cambiar
    FROM
        open.wf_instance      wf,
        open.wf_exception_log el,
        open.mo_packages      p,
        open.wf_data_external de
    WHERE
            wf.instance_id = el.instance_id
        AND de.plan_id = wf.plan_id
        AND de.package_id = p.package_id
        AND wf.status_id = 9
        AND el.status = 1
        AND p.package_id = nusol
    UNION ALL
    SELECT
        'INRMO'                forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        last_mess_desc_error,
        w.instance_id,
        i.inserting_date,
        i.interface_history_id codigo_cambiar
    FROM
        open.in_interface_history i,
        open.wf_instance          w,
        open.mo_packages          p,
        open.wf_data_external     de
    WHERE
            i.status_id = 9
        AND i.request_number_origi = w.instance_id
        AND de.plan_id = w.plan_id
        AND de.package_id = p.package_id
        AND p.package_id = nusol;

    rgerrorflujo            cuerrorflujo%rowtype;
BEGIN
    nucont := 0;
    FOR reg IN cusolicitudes LOOP
        nucont := nucont + 1;
        nuerror := 0;
        IF nuerror = 0 THEN
            --1 VALIDACION
            BEGIN
                ldc_pkg_changstatesolici.packageinttransition(reg.package_id, ge_boparameter.fnuget('ANNUL_CAUSAL'));
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    nuerror := 0;
            END;

            FOR regot IN cuordenes(reg.package_id) LOOP
                BEGIN
                    ldc_cancel_order(regot.order_id, 3446, sbcomment, cnucommenttype, onuerrorcode,
                                    osberrormessage);
                    IF onuerrorcode <> 0 THEN
                        nuerror := 1;
                        ROLLBACK;
                    END IF;
                EXCEPTION
                    WHEN OTHERS THEN
                        nuerror := 1;
                        ROLLBACK;
                END;
            END LOOP;

            IF nuerror = 0 THEN
                BEGIN
                    --Cambio estado de la solicitud
                    UPDATE open.mo_packages
                    SET
                        motive_status_id = dald_parameter.fnugetnumeric_value('ID_ESTADO_PKG_ANULADA'),
                        attention_date = sysdate
                    WHERE
                        package_id IN ( reg.package_id );

                    package_idvar := reg.package_id;
                    cust_care_reques_numvar := damo_packages.fsbgetcust_care_reques_num(reg.package_id, NULL);
                    package_type_idvar := damo_packages.fnugetpackage_type_id(reg.package_id, NULL);
                    o_motive_status_idvar := damo_motive.fnugetmotive_status_id(mo_bcpackages.fnugetmotiveid(reg.package_id));
                    INSERT INTO mo_package_chng_log (
                        current_user_id,
                        current_user_mask,
                        current_terminal,
                        current_term_ip_addr,
                        current_date,
                        current_table_name,
                        current_exec_name,
                        current_session_id,
                        current_event_id,
                        current_even_desc,
                        current_program,
                        current_module,
                        current_client_info,
                        current_action,
                        package_chng_log_id,
                        package_id,
                        cust_care_reques_num,
                        package_type_id,
                        o_motive_status_id,
                        n_motive_status_id
                    ) VALUES (
                        au_bosystem.getsystemuserid,
                        au_bosystem.getsystemusermask,
                        ut_session.getterminal,
                        ut_session.getip,
                        ut_date.fdtsysdate,
                        current_table_namevar,
                        au_bosystem.getsystemprocessname,
                        ut_session.getsessionid,
                        current_event_idvar,
                        current_even_descvar,
                        ut_session.getprogram
                        || '-'
                        || sbcomment,
                        ut_session.getmodule,
                        ut_session.getclientinfo,
                        ut_session.getaction,
                        mo_bosequences.fnugetseq_mo_package_chng_log,
                        package_idvar,
                        cust_care_reques_numvar,
                        package_type_idvar,
                        o_motive_status_idvar,
                        dald_parameter.fnugetnumeric_value('ID_ESTADO_PKG_ANULADA')
                    );

                    UPDATE open.mo_motive
                    SET
                        annul_date = sysdate,
                        status_change_date = sysdate,
                        annul_causal_id = ge_boparameter.fnuget('ANNUL_CAUSAL'),
                        motive_status_id = 5,
                        causal_id = 287,
                        attention_date = sysdate
                    WHERE
                        package_id IN ( reg.package_id );

                EXCEPTION
                    WHEN OTHERS THEN
                        ROLLBACK;
                        nuerror := 1;
                        dbms_output.put_line('Error anulando solicitud|'
                                             || reg.package_id
                                             || '|'
                                             || sqlerrm);
                END;

                IF nuerror = 0 THEN
                    COMMIT;
                    BEGIN
                        nuplanid := wf_boinstance.fnugetplanid(reg.package_id, 17);
                    EXCEPTION
                        WHEN OTHERS THEN
                            ROLLBACK;
                            nuerror := 1;
                            dbms_output.put_line('Error anulando plan solicitud|'
                                                 || reg.package_id
                                                 || '|'
                                                 || sqlerrm);
                    END;
                    
                    -- anula el plan de wf
                    IF ( nvl(nuplanid, 0) <> 0 ) THEN
                        BEGIN
                            mo_boannulment.annulwfplan(nuplanid);
                        EXCEPTION
                            WHEN OTHERS THEN
                                ROLLBACK;
                                nuerror := 0;
                        END;
                    END IF;

                    IF nuerror = 0 THEN
                        IF cuerrorflujo%isopen THEN
                            CLOSE cuerrorflujo;
                        END IF;
                        OPEN cuerrorflujo(reg.package_id);
                        FETCH cuerrorflujo INTO rgerrorflujo;
                        IF cuerrorflujo%notfound THEN
                            COMMIT;
                            dbms_output.put_line('SOLICITUD ANULADA SIN ERROR DE FLUJO|' || reg.package_id);
                        ELSE
                            IF rgerrorflujo.forma = 'INRMO' THEN
                                UPDATE in_interface_history i
                                SET
                                    i.status_id = 6
                                WHERE
                                    i.interface_history_id = rgerrorflujo.codigo_cambiar;

                            END IF;

                            COMMIT;
                            dbms_output.put_line('SOLICITUD ANULADA CON ERROR DE FLUJO|' || reg.package_id);
                        END IF;

                        CLOSE cuerrorflujo;
                    END IF;

                END IF;

            END IF;

        END IF; ----1 VALIDACION
    END LOOP;

    IF nucont = 0 THEN
        dbms_output.put_line('No existe ninguna solicitud para anular');
    END IF;
END;
/