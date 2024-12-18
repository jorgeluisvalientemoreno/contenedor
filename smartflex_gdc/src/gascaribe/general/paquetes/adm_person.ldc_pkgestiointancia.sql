CREATE OR REPLACE PACKAGE adm_person.ldc_pkgestiointancia IS

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  18/06/2024   Adrianavg   OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  PROCEDURE tmp_Cambiar_Instancia_Negativo (inuInstIni in  number,
                                            inuInstFin in number,
                                            isbAction  varchar2);

  PROCEDURE tmp_Cambiar_Instancia_NegaHilo ( inuInstIni in number,
                                            inuInstFin in number,
                                              inuHilo  in number,
                                              isbAction  varchar2);

  PROCEDURE prJobEjecutaInsta;
  PROCEDURE prCambiaAtributoNega(inuatribIni IN NUMBER, inuAtribFinal IN NUMBER, isbProceso IN VARCHAR2);
  PROCEDURE prCambiaTransNega(inuTotalHilo IN NUMBER, inuHilo IN NUMBER, isbProceso IN VARCHAR2);
  PROCEDURE prOrdenatributos;
  PROCEDURE prOrdentransacion;
  PROCEDURE prEliminaTras(nuTotalHilo IN NUMBER, nuHilo in number);
  PROCEDURE prJobEliminaTras;
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_pkgestioIntancia IS
    PROCEDURE  disable_constraints IS
    BEGIN
        ut_trace.trace('disable constraint FK_WF_INST_WF_EXLO',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_WF_EXLO');
        execute immediate 'alter table WF_EXCEPTION_LOG disable constraint FK_WF_INST_WF_EXLO';
        dbms_output.put_Line('disable constraint FK_WF_INST_WF_INEQ');
        ut_trace.trace('disable constraint FK_WF_INST_WF_INEQ',2);
        execute immediate 'alter table WF_INSTANCE_EQUIV disable constraint FK_WF_INST_WF_INEQ';
        ut_trace.trace('disable constraint FK_WF_INST_WF_INST_2',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_WF_INST_2');
        execute immediate 'alter table WF_INSTANCE disable constraint FK_WF_INST_WF_INST_2';
        ut_trace.trace('disable constraint FK_WF_INST_WF_INST_3',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_WF_INST_3');
        execute immediate 'alter table WF_INSTANCE disable constraint FK_WF_INST_WF_INST_3';
        ut_trace.trace('disable constraint FK_WF_INST_WF_INST_4',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_WF_INST_4');
        execute immediate 'alter table WF_INSTANCE disable constraint FK_WF_INST_WF_INST_4';
        ut_trace.trace('disable constraint FK_WF_INST_WF_INST_5',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_WF_INST_5');
        execute immediate 'alter table WF_INSTANCE disable constraint FK_WF_INST_WF_INST_5';
        ut_trace.trace('disable constraint FK_WF_INST_WF_INAT',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_WF_INAT');
        execute immediate 'alter table WF_INSTANCE_ATTRIB disable constraint FK_WF_INST_WF_INAT';
        ut_trace.trace('disable constraint FK_WF_INST_WF_INTR_1',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_WF_INTR_1');
        execute immediate 'alter table WF_INSTANCE_TRANS disable constraint FK_WF_INST_WF_INTR_1';
        ut_trace.trace('disable constraint FK_WF_INST_WF_INTR_2',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_WF_INTR_2');
        execute immediate 'alter table WF_INSTANCE_TRANS disable constraint FK_WF_INST_WF_INTR_2';
        ut_trace.trace('disable constraint FK_WF_INST_MO_WCIN_01',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_MO_WCIN_01');
        execute immediate 'alter table MO_WF_COMP_INTERFAC disable constraint FK_WF_INST_MO_WCIN_01';
        ut_trace.trace('disable constraint FK_WF_INST_MO_WCIN_02',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_MO_WCIN_02');
        execute immediate 'alter table MO_WF_COMP_INTERFAC disable constraint FK_WF_INST_MO_WCIN_02';
        ut_trace.trace('disable constraint FK_WF_INST_MO_WCIN_03',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_MO_WCIN_03');
        execute immediate 'alter table MO_WF_COMP_INTERFAC disable constraint FK_WF_INST_MO_WCIN_03';
        ut_trace.trace('disable constraint FK_WF_INST_MO_WMIN_01',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_MO_WMIN_01');
        execute immediate 'alter table MO_WF_MOTIV_INTERFAC disable constraint FK_WF_INST_MO_WMIN_01';
        ut_trace.trace('disable constraint FK_WF_INST_MO_WMIN_02',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_MO_WMIN_02');
        execute immediate 'alter table MO_WF_MOTIV_INTERFAC disable constraint FK_WF_INST_MO_WMIN_02';
        ut_trace.trace('disable constraint FK_WF_INST_MO_WMIN_03',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_MO_WMIN_03');
        execute immediate 'alter table MO_WF_MOTIV_INTERFAC disable constraint FK_WF_INST_MO_WMIN_03';
        ut_trace.trace('disable constraint FK_WF_INST_MO_WPIN_01',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_MO_WPIN_01');
        execute immediate 'alter table MO_WF_PACK_INTERFAC disable constraint FK_WF_INST_MO_WPIN_01';
        ut_trace.trace('disable constraint FK_WF_INST_MO_WPIN_02',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_MO_WPIN_02');
        execute immediate 'alter table MO_WF_PACK_INTERFAC disable constraint FK_WF_INST_MO_WPIN_02';
        ut_trace.trace('disable constraint FK_WF_INST_MO_WPIN_03',2);
        dbms_output.put_Line('disable constraint FK_WF_INST_MO_WPIN_03');
        execute immediate 'alter table MO_WF_PACK_INTERFAC disable constraint FK_WF_INST_MO_WPIN_03';
        ut_trace.trace('End disable_constraints',2);
    END;

    PROCEDURE enable_constraints  IS
    BEGIN
        ut_trace.trace('enable constraint FK_WF_INST_WF_EXLO',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_WF_EXLO');
        execute immediate 'alter table WF_EXCEPTION_LOG enable novalidate constraint FK_WF_INST_WF_EXLO';
        ut_trace.trace('enable constraint FK_WF_INST_WF_INEQ',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_WF_INEQ');
        execute immediate 'alter table WF_INSTANCE_EQUIV enable novalidate constraint FK_WF_INST_WF_INEQ';
        ut_trace.trace('enable constraint FK_WF_INST_WF_INST_2',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_WF_INST_2');
        execute immediate 'alter table WF_INSTANCE enable novalidate constraint FK_WF_INST_WF_INST_2';
        ut_trace.trace('enable constraint FK_WF_INST_WF_INST_3',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_WF_INST_3');
        execute immediate 'alter table WF_INSTANCE enable novalidate constraint FK_WF_INST_WF_INST_3';
        ut_trace.trace('enable constraint FK_WF_INST_WF_INST_4',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_WF_INST_4');
        execute immediate 'alter table WF_INSTANCE enable novalidate constraint FK_WF_INST_WF_INST_4';
        ut_trace.trace('enable constraint FK_WF_INST_WF_INST_5',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_WF_INST_5');
        execute immediate 'alter table WF_INSTANCE enable novalidate constraint FK_WF_INST_WF_INST_5';
        ut_trace.trace('enable constraint FK_WF_INST_WF_INAT',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_WF_INAT');
        execute immediate 'alter table WF_INSTANCE_ATTRIB enable novalidate constraint FK_WF_INST_WF_INAT';
        ut_trace.trace('enable constraint FK_WF_INST_WF_INTR_1',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_WF_INTR_1');
        execute immediate 'alter table WF_INSTANCE_TRANS enable novalidate constraint FK_WF_INST_WF_INTR_1';
        ut_trace.trace('enable constraint FK_WF_INST_WF_INTR_2',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_WF_INTR_2');
        execute immediate 'alter table WF_INSTANCE_TRANS enable novalidate constraint FK_WF_INST_WF_INTR_2';
        ut_trace.trace('enable constraint FK_WF_INST_MO_WCIN_01',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_MO_WCIN_01');
        execute immediate 'alter table MO_WF_COMP_INTERFAC enable novalidate constraint FK_WF_INST_MO_WCIN_01';
        ut_trace.trace('enable constraint FK_WF_INST_MO_WCIN_02',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_MO_WCIN_02');
        execute immediate 'alter table MO_WF_COMP_INTERFAC enable novalidate constraint FK_WF_INST_MO_WCIN_02';
        ut_trace.trace('enable constraint FK_WF_INST_MO_WCIN_03',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_MO_WCIN_03');
        execute immediate 'alter table MO_WF_COMP_INTERFAC enable novalidate constraint FK_WF_INST_MO_WCIN_03';
        ut_trace.trace('enable constraint FK_WF_INST_MO_WMIN_01',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_MO_WMIN_01');
        execute immediate 'alter table MO_WF_MOTIV_INTERFAC enable novalidate constraint FK_WF_INST_MO_WMIN_01';
        ut_trace.trace('enable constraint FK_WF_INST_MO_WMIN_02',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_MO_WMIN_02');
        execute immediate 'alter table MO_WF_MOTIV_INTERFAC enable novalidate constraint FK_WF_INST_MO_WMIN_02';
        ut_trace.trace('enable constraint FK_WF_INST_MO_WMIN_03',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_MO_WMIN_03');
        execute immediate 'alter table MO_WF_MOTIV_INTERFAC enable novalidate constraint FK_WF_INST_MO_WMIN_03';
        ut_trace.trace('enable constraint FK_WF_INST_MO_WPIN_01',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_MO_WPIN_01');
        execute immediate 'alter table MO_WF_PACK_INTERFAC enable novalidate constraint FK_WF_INST_MO_WPIN_01';
        ut_trace.trace('enable constraint FK_WF_INST_MO_WPIN_02',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_MO_WPIN_02');
        execute immediate 'alter table MO_WF_PACK_INTERFAC enable novalidate constraint FK_WF_INST_MO_WPIN_02';
        ut_trace.trace('enable constraint FK_WF_INST_MO_WPIN_03',2);
        dbms_output.put_Line('enable constraint FK_WF_INST_MO_WPIN_03');
        execute immediate 'alter table MO_WF_PACK_INTERFAC enable novalidate constraint FK_WF_INST_MO_WPIN_03';
        ut_trace.trace('End enable_constraints',2);


  END;

  PROCEDURE tmp_Cambiar_Instancia_Negativo (inuInstIni in  number,
                                            inuInstFin in number,
                                            isbAction  varchar2) IS
   nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nuVal   number;

    PROCEDURE DELETE_esquema_wf IS

        CURSOR DatosBorrado IS

            SELECT  *
            FROM    wf_instance
            where instance_id between inuInstIni and inuInstFin
            ORDER BY instance_id asc;

        TYPE styInstance IS TABLE OF DatosBorrado%ROWTYPE INDEX BY PLS_INTEGER;
        regInstance styInstance;
        CnuLimit         NUMBER  := 100; -- Cantidad maxima de registros a procesar
        nuRegProcesados  number  := 0;
        indx             PLS_INTEGER;

        BEGIN
        dbms_output.put_Line('Ini DELETE_esquema_wf');
        ut_trace.trace('Ini DELETE_esquema_wf',2);
        -- Valida si el cursor principal esta abierto
        IF DatosBorrado%isopen THEN
           CLOSE DatosBorrado;
        END IF;

        nuRegProcesados := 0;
        -- Abre el cursor principal y obtiene los registros a procesar
        OPEN DatosBorrado;
        LOOP
            -- Recorre los registros a procesar
            FETCH DatosBorrado BULK COLLECT INTO regInstance LIMIT CnuLimit;

            -- Obtiene primer registro a procesar
            indx := regInstance.first;     -- regInstance(indx)

            -- Valida que hayan productos para procesar
            WHILE (indx IS NOT NULL)
            LOOP

            -- Actualiza contadores
            nuRegProcesados := nuRegProcesados + 1;

            ut_trace.trace('delete wf_data_external '||regInstance(indx).instance_id,3); --
            delete FROM open.wf_data_external WHERE plan_id in (SELECT  plan_id FROM open.wf_instance WHERE instance_id = regInstance(indx).instance_id);
            ut_trace.trace('delete WF_INSTANCE_EQUIV ',3); --
            delete FROM open.WF_INSTANCE_EQUIV WHERE instance_id in (SELECT  instance_id FROM open.wf_instance WHERE instance_id = regInstance(indx).instance_id) ;

            nuVal:=0;
            SELECT  count(*) INTO nuVal
            FROM open.WF_EXCEPTION_LOG
            WHERE instance_id = regInstance(indx).instance_id;

            if nuVal > 0 then
                ut_trace.trace('delete WF_EXCEPTION_LOG ',3);
                delete FROM open.WF_EXCEPTION_LOG WHERE instance_id = regInstance(indx).instance_id;
            END if;

            ut_trace.trace('delete MO_WF_MOTIV_INTERFAC ',3);
            delete FROM open.MO_WF_MOTIV_INTERFAC WHERE activity_id          =  regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_MOTIV_INTERFAC ',3);
            delete FROM open.MO_WF_MOTIV_INTERFAC WHERE previous_activity_id = regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_MOTIV_INTERFAC ',3);
            delete FROM open.MO_WF_MOTIV_INTERFAC WHERE undo_activity_id     = regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_COMP_INTERFAC ',3);
            delete FROM open.MO_WF_COMP_INTERFAC  WHERE activity_id          = regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_COMP_INTERFAC ',3);
            delete FROM open.MO_WF_COMP_INTERFAC  WHERE previous_activity_id = regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_COMP_INTERFAC ',3);
            delete FROM open.MO_WF_COMP_INTERFAC  WHERE undo_activity_id     = regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_PACK_INTERFAC ',3);
            delete FROM open.MO_WF_PACK_INTERFAC  WHERE activity_id          = regInstance(indx).instance_id ;
            ut_trace.trace('delete MO_WF_PACK_INTERFAC ',3);
            delete FROM open.MO_WF_PACK_INTERFAC  WHERE previous_activity_id = regInstance(indx).instance_id;
            ut_trace.trace('delete WF_INSTANCE_TRANS ',3);
            delete FROM open.WF_INSTANCE_TRANS    WHERE target_id            = regInstance(indx).instance_id ;
            ut_trace.trace('delete WF_INSTANCE_TRANS ',3);
            delete FROM open.WF_INSTANCE_TRANS    WHERE origin_id            = regInstance(indx).instance_id ;
            ut_trace.trace('delete WF_INSTANCE_DATA_MAP ',3);
            delete FROM open.WF_INSTANCE_DATA_MAP WHERE target in (SELECT instance_ATTRIB_id FROM Open.WF_INSTANCE_ATTRIB WHERE instance_id = regInstance(indx).instance_id);
            ut_trace.trace('delete WF_INSTANCE_DATA_MAP ',3);
            delete FROM open.WF_INSTANCE_DATA_MAP WHERE source_id in (SELECT instance_ATTRIB_id FROM Open.WF_INSTANCE_ATTRIB WHERE instance_id = regInstance(indx).instance_id);
            ut_trace.trace('delete WF_INSTANCE_ATTRIB ',3);
            delete FROM open.WF_INSTANCE_ATTRIB   WHERE instance_id = regInstance(indx).instance_id ;

            nuVal:=0;
            SELECT  count(*) INTO nuVal
            FROM open.MO_WF_PACK_INTERFAC
            WHERE undo_activity_id = regInstance(indx).instance_id ;

            if nuVal > 0 then
                ut_trace.trace('delete MO_WF_PACK_INTERFAC ',3);
                delete FROM open.MO_WF_PACK_INTERFAC WHERE undo_activity_id = regInstance(indx).instance_id ;
            END if;

            ut_trace.trace('update de instancia en or_order_activity ',3);
            update open.or_order_activity set instance_id =-instance_id WHERE instance_id = regInstance(indx).instance_id;
            ut_trace.trace('delete wf_instance ',3);
            delete FROM open.wf_instance WHERE instance_id = regInstance(indx).instance_id;

            ut_trace.trace('Instancia Procesada:'|| regInstance(indx).instance_id);

            -- Obtiene proximo registro a procesar
            indx := regInstance.NEXT(indx);
            END LOOP;
            -- Realiza persistencia de los cambios efectuados
            ut_trace.trace('commit ',3);
            COMMIT;
            -- Sale del cursor principal si no existen registros a procesar
            EXIT WHEN DatosBorrado%NOTFOUND;
       END LOOP;

       -- Cierra el cursor principal
      CLOSE DatosBorrado;
      ut_trace.trace('Registros Procesados: '||nuRegProcesados,2);
      dbms_output.put_Line('Registros Procesados: '||nuRegProcesados);
      ut_trace.trace('End DELETE_esquema_wf',2);
      dbms_output.put_Line('End DELETE_esquema_wf');
    END;


    PROCEDURE UPDATE_esquema_wf IS

        CURSOR DatosBorrado IS
          SELECT  *
        FROM    wf_instance
        where instance_id between inuInstIni and inuInstFin
        ORDER BY instance_id asc;


        TYPE styInstance IS TABLE OF DatosBorrado%ROWTYPE INDEX BY PLS_INTEGER;
        regInstance styInstance;
        CnuLimit         NUMBER  := 100; -- Cantidad maxima de registros a procesar
        nuRegProcesados  number  := 0;
        indx             PLS_INTEGER;

        regdata_external wf_data_external%rowtype;
        reg_instance_equiv wf_instance_equiv%rowtype;

    BEGIN
        dbms_output.put_Line('Ini UPDATE_esquema_wf');
        ut_trace.trace('Ini UPDATE_esquema_wf',2);
        -- Valida si el cursor principal esta abierto
        IF DatosBorrado%isopen THEN
           CLOSE DatosBorrado;
        END IF;

        nuRegProcesados := 0;
        -- Abre el cursor principal y obtiene los registros a procesar
        OPEN DatosBorrado;
        LOOP
            -- Recorre los registros a procesar
            FETCH DatosBorrado BULK COLLECT INTO regInstance LIMIT CnuLimit;

            -- Obtiene primer registro a procesar
            indx := regInstance.first;     -- regInstance(indx)

            -- Valida que hayan productos para procesar
            WHILE (indx IS NOT NULL)
            LOOP

            -- Actualiza contadores
            nuRegProcesados := nuRegProcesados + 1;
            ut_trace.trace('insert WF_INSTANCE ',3);
            -- Inserta registro en wf_instance con valor negativo
            IF  regInstance(indx).PARENT_ID is null THEN
               regInstance(indx).PARENT_ID := regInstance(indx).PARENT_ID;
            else
               regInstance(indx).PARENT_ID := -regInstance(indx).PARENT_ID;
            END IF;

            IF  regInstance(indx).PREVIOUS_INSTANCE_ID is null THEN
               regInstance(indx).PREVIOUS_INSTANCE_ID := regInstance(indx).PREVIOUS_INSTANCE_ID;
            else
               regInstance(indx).PREVIOUS_INSTANCE_ID := -regInstance(indx).PREVIOUS_INSTANCE_ID;
            END IF;

            INSERT INTO WF_INSTANCE
            (INSTANCE_ID, DESCRIPTION, PARENT_ID, ORIGINAL_TASK, PLAN_ID, UNIT_ID, STATUS_ID, PREVIOUS_STATUS_ID, ONLINE_EXEC_ID, ACTION_ID, PRE_EXPRESSION_ID, POS_EXPRESSION_ID, QUANTITY, INITIAL_DATE, FINAL_DATE, SINCRONIC_TIMEOUT, ASINCRONIC_TIMEOUT, LAYER_ID, EXTERNAL_ID, GEOMETRY, TRY_NUMBER, MULTI_INSTANCE, FUNCTION_TYPE, NODE_TYPE_ID, MODULE_ID, IS_COUNTABLE, TOTAL_TIME, PARENT_EXTERNAL_ID, ENTITY_ID, PAR_EXT_ENTITY_ID, GROUP_ID, MIN_GROUP_SIZE, UNIT_TYPE_ID, EXECUTION_ORDER, ANNULATION_ORDER, NOTIFICATION_ID, EXECUTION_ID, PREVIOUS_INSTANCE_ID)
            VALUES (-regInstance(indx).INSTANCE_ID, regInstance(indx).DESCRIPTION, regInstance(indx).PARENT_ID, regInstance(indx).ORIGINAL_TASK, -regInstance(indx).PLAN_ID, regInstance(indx).UNIT_ID, regInstance(indx).STATUS_ID, regInstance(indx).PREVIOUS_STATUS_ID,
                    regInstance(indx).ONLINE_EXEC_ID, regInstance(indx).ACTION_ID, regInstance(indx).PRE_EXPRESSION_ID, regInstance(indx).POS_EXPRESSION_ID, regInstance(indx).QUANTITY, regInstance(indx).INITIAL_DATE, regInstance(indx).FINAL_DATE, regInstance(indx).SINCRONIC_TIMEOUT,
                    regInstance(indx).ASINCRONIC_TIMEOUT, regInstance(indx).LAYER_ID, regInstance(indx).EXTERNAL_ID, regInstance(indx).GEOMETRY, regInstance(indx).TRY_NUMBER, regInstance(indx).MULTI_INSTANCE, regInstance(indx).FUNCTION_TYPE, regInstance(indx).NODE_TYPE_ID,
                    regInstance(indx).MODULE_ID, regInstance(indx).IS_COUNTABLE, regInstance(indx).TOTAL_TIME, regInstance(indx).PARENT_EXTERNAL_ID, regInstance(indx).ENTITY_ID, regInstance(indx).PAR_EXT_ENTITY_ID, regInstance(indx).GROUP_ID, regInstance(indx).MIN_GROUP_SIZE,
                    regInstance(indx).UNIT_TYPE_ID, regInstance(indx).EXECUTION_ORDER, regInstance(indx).ANNULATION_ORDER, regInstance(indx).NOTIFICATION_ID, regInstance(indx).EXECUTION_ID, regInstance(indx).PREVIOUS_INSTANCE_ID);

            nuVal:=0;
            SELECT  count(*) INTO nuVal
            from  wf_data_external
            WHERE plan_id = regInstance(indx).instance_id;

            if nuVal > 0 then
                ut_trace.trace('insert wf_data_external ',3);
                select * into regdata_external from wf_data_external where plan_id = regInstance(indx).instance_id;

                INSERT INTO WF_DATA_EXTERNAL
                       (PLAN_ID, PACK_TYPE_TAG, PRODUCT_TYPE_TAG, UNIT_TYPE_ID, PACKAGE_ID)
                VALUES (-regdata_external.PLAN_ID, regdata_external.PACK_TYPE_TAG, regdata_external.PRODUCT_TYPE_TAG, regdata_external.UNIT_TYPE_ID, regdata_external.PACKAGE_ID);
                ut_trace.trace('delete wf_data_external ',3);
                delete FROM open.wf_data_external WHERE plan_id = regInstance(indx).instance_id;
            END if;


            nuVal:=0;
            SELECT  count(*) INTO nuVal
            from  wf_instance_equiv
            WHERE instance_id = regInstance(indx).instance_id;

            if nuVal > 0 then
                ut_trace.trace('insert WF_INSTANCE_EQUIV ',3);
                select * into reg_instance_equiv from wf_instance_equiv where instance_id = regInstance(indx).instance_id;

                INSERT INTO WF_INSTANCE_EQUIV
                (INSTANCE_ID, ATTRIBUTES_EQUIV_ID, EXTERNAL_ID, ENTITY_ID)
                VALUES (-reg_instance_equiv.INSTANCE_ID, reg_instance_equiv.ATTRIBUTES_EQUIV_ID, reg_instance_equiv.EXTERNAL_ID, reg_instance_equiv.ENTITY_ID);

                ut_trace.trace('delete WF_INSTANCE_EQUIV ',3);
                delete FROM open.WF_INSTANCE_EQUIV WHERE instance_id = regInstance(indx).instance_id;
            END if;

            nuVal:=0;
            SELECT  count(*) INTO nuVal
            FROM open.WF_EXCEPTION_LOG
            WHERE instance_id = regInstance(indx).instance_id;

            if nuVal > 0 then
                ut_trace.trace('update WF_EXCEPTION_LOG ',3);
                update open.WF_EXCEPTION_LOG set instance_id = -regInstance(indx).instance_id
                WHERE instance_id = regInstance(indx).instance_id;
            END if;
            ut_trace.trace('update MO_WF_MOTIV_INTERFAC ',3);
            update open.MO_WF_MOTIV_INTERFAC set activity_id = -activity_id                   WHERE activity_id          = regInstance(indx).instance_id;
            ut_trace.trace('update MO_WF_MOTIV_INTERFAC ',3);
            update open.MO_WF_MOTIV_INTERFAC set previous_activity_id = -previous_activity_id WHERE previous_activity_id = regInstance(indx).instance_id;
            ut_trace.trace('update MO_WF_MOTIV_INTERFAC ',3);
            update open.MO_WF_MOTIV_INTERFAC set undo_activity_id = -undo_activity_id         WHERE undo_activity_id     = regInstance(indx).instance_id;
            ut_trace.trace('update MO_WF_COMP_INTERFAC ',3);
            update open.MO_WF_COMP_INTERFAC  set activity_id = -activity_id                   WHERE activity_id          = regInstance(indx).instance_id;
            ut_trace.trace('update MO_WF_COMP_INTERFAC ',3);
            update open.MO_WF_COMP_INTERFAC  set previous_activity_id = -previous_activity_id WHERE previous_activity_id = regInstance(indx).instance_id;
            ut_trace.trace('update MO_WF_COMP_INTERFAC ',3);
            update open.MO_WF_COMP_INTERFAC  set undo_activity_id = -undo_activity_id         WHERE undo_activity_id     = regInstance(indx).instance_id;
            ut_trace.trace('update MO_WF_PACK_INTERFAC ',3);
            update open.MO_WF_PACK_INTERFAC  set activity_id = -activity_id                   WHERE activity_id          = regInstance(indx).instance_id ;
            ut_trace.trace('update MO_WF_PACK_INTERFAC ',3);
            update open.MO_WF_PACK_INTERFAC  set previous_activity_id = -previous_activity_id WHERE previous_activity_id = regInstance(indx).instance_id;
            ut_trace.trace('update WF_INSTANCE_TRANS ',3);
            update open.WF_INSTANCE_TRANS    set target_id = -target_id                       WHERE target_id            = regInstance(indx).instance_id ;
            ut_trace.trace('update WF_INSTANCE_TRANS ',3);
            update open.WF_INSTANCE_TRANS    set origin_id = -origin_id                       WHERE origin_id            = regInstance(indx).instance_id ;
            --update open.WF_INSTANCE_DATA_MAP set target_id = -target_id                       WHERE target in (SELECT instance_ATTRIB_id FROM Open.WF_INSTANCE_ATTRIB WHERE instance_id = regInstance(indx).instance_id);
            --update open.WF_INSTANCE_DATA_MAP set source_id = -source_id                       WHERE source_id in (SELECT instance_ATTRIB_id FROM Open.WF_INSTANCE_ATTRIB WHERE instance_id = regInstance(indx).instance_id);
            ut_trace.trace('update WF_INSTANCE_ATTRIB ',3);
            update open.WF_INSTANCE_ATTRIB   set instance_id = -instance_id                   WHERE instance_id = regInstance(indx).instance_id ;

            nuVal:=0;
            SELECT  count(*) INTO nuVal
            FROM open.MO_WF_PACK_INTERFAC
            WHERE undo_activity_id = regInstance(indx).instance_id ;

            if nuVal > 0 then
                ut_trace.trace('update MO_WF_PACK_INTERFAC ',3);
                update open.MO_WF_PACK_INTERFAC set undo_activity_id = -undo_activity_id WHERE undo_activity_id = regInstance(indx).instance_id ;
            END if;

            ut_trace.trace('update or_order_activity ',3);
            update open.or_order_activity set instance_id = -instance_id WHERE instance_id = regInstance(indx).instance_id;

            ut_trace.trace('delete wf_instance ',3);
            delete FROM open.wf_instance WHERE instance_id = regInstance(indx).instance_id;

            ut_trace.trace('Instancia Procesada:'|| regInstance(indx).instance_id,3);

            -- Obtiene proximo registro a procesar
            indx := regInstance.NEXT(indx);
            END LOOP;
            -- Realiza persistencia de los cambios efectuados
            ut_trace.trace('commit ',3);
            COMMIT;
            -- Sale del cursor principal si no existen registros a procesar
            EXIT WHEN DatosBorrado%NOTFOUND;
       END LOOP;

       -- Cierra el cursor principal
      CLOSE DatosBorrado;
      dbms_output.put_Line('Registros Procesados: '||nuRegProcesados);
      ut_trace.trace('Registros Procesados: '||nuRegProcesados,2);
      dbms_output.put_Line('End UPDATE_esquema_wf');
      ut_trace.trace('End UPDATE_esquema_wf',2);
    END;

BEGIN

    dbms_output.put_Line('Inicio ['||sysdate||']');
    dbms_output.put_Line('inuInstIni ['||inuInstIni||']');
    dbms_output.put_Line('inuInstFin ['||inuInstFin||']');
    dbms_output.put_Line('isbAction ['||inuInstFin||']');

    disable_constraints;

    IF upper(isbAction) = 'DELETE' THEN
        DELETE_esquema_wf;
    elsif upper(isbAction) = 'UPDATE' THEN
    	UPDATE_esquema_wf;
	END IF;

	enable_constraints;

    dbms_output.put_Line('Fin ['||sysdate||']');

EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
  END tmp_Cambiar_Instancia_Negativo;

  PROCEDURE tmp_Cambiar_Instancia_NegaHilo (inuInstIni in number,
                                            inuInstFin in number,
                                            inuHilo  in number,
                                            isbAction  varchar2) IS
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nuVal   number;

     nusession   NUMBER;
    sbuser      VARCHAR2(30);
    nuano       NUMBER;
    numes       NUMBER;


      PROCEDURE DELETE_esquema_wf IS

        CURSOR DatosBorrado IS
        SELECT /*+ index(e PK_WF_DATA_EXTERNAL) */i.*
		FROM    wf_instance i--, WF_DATA_EXTERNAL e
		where /*e.PLAN_ID = i.PLAN_ID
			 and mod(e.PLAN_ID, 12) + 1 =  1*/
       i.instance_id between inuInstIni and inuInstFin;

        TYPE styInstance IS TABLE OF DatosBorrado%ROWTYPE INDEX BY PLS_INTEGER;
        regInstance styInstance;
        CnuLimit         NUMBER  := 100; -- Cantidad maxima de registros a procesar
        nuRegProcesados  number  := 0;
        indx             PLS_INTEGER;

        BEGIN
        dbms_output.put_Line('Ini DELETE_esquema_wf');
        ut_trace.trace('Ini DELETE_esquema_wf',2);
        -- Valida si el cursor principal esta abierto
        IF DatosBorrado%isopen THEN
           CLOSE DatosBorrado;
        END IF;

        nuRegProcesados := 0;
        -- Abre el cursor principal y obtiene los registros a procesar
        OPEN DatosBorrado;
        LOOP
            -- Recorre los registros a procesar
            FETCH DatosBorrado BULK COLLECT INTO regInstance LIMIT CnuLimit;

            -- Obtiene primer registro a procesar
            indx := regInstance.first;     -- regInstance(indx)

            -- Valida que hayan productos para procesar
            WHILE (indx IS NOT NULL)
            LOOP

            -- Actualiza contadores
            nuRegProcesados := nuRegProcesados + 1;

            ut_trace.trace('delete wf_data_external '||regInstance(indx).instance_id,3); --
            delete FROM open.wf_data_external WHERE plan_id in (SELECT  plan_id FROM open.wf_instance WHERE instance_id = regInstance(indx).instance_id);
            ut_trace.trace('delete WF_INSTANCE_EQUIV ',3); --
            delete FROM open.WF_INSTANCE_EQUIV WHERE instance_id in (SELECT  instance_id FROM open.wf_instance WHERE instance_id = regInstance(indx).instance_id) ;

            nuVal:=0;
            SELECT  count(*) INTO nuVal
            FROM open.WF_EXCEPTION_LOG
            WHERE instance_id = regInstance(indx).instance_id;

            if nuVal > 0 then
                ut_trace.trace('delete WF_EXCEPTION_LOG ',3);
                delete FROM open.WF_EXCEPTION_LOG WHERE instance_id = regInstance(indx).instance_id;
            END if;

            ut_trace.trace('delete MO_WF_MOTIV_INTERFAC ',3);
            delete FROM open.MO_WF_MOTIV_INTERFAC WHERE activity_id          =  regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_MOTIV_INTERFAC ',3);
            delete FROM open.MO_WF_MOTIV_INTERFAC WHERE previous_activity_id = regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_MOTIV_INTERFAC ',3);
            delete FROM open.MO_WF_MOTIV_INTERFAC WHERE undo_activity_id     = regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_COMP_INTERFAC ',3);
            delete FROM open.MO_WF_COMP_INTERFAC  WHERE activity_id          = regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_COMP_INTERFAC ',3);
            delete FROM open.MO_WF_COMP_INTERFAC  WHERE previous_activity_id = regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_COMP_INTERFAC ',3);
            delete FROM open.MO_WF_COMP_INTERFAC  WHERE undo_activity_id     = regInstance(indx).instance_id;
            ut_trace.trace('delete MO_WF_PACK_INTERFAC ',3);
            delete FROM open.MO_WF_PACK_INTERFAC  WHERE activity_id          = regInstance(indx).instance_id ;
            ut_trace.trace('delete MO_WF_PACK_INTERFAC ',3);
            delete FROM open.MO_WF_PACK_INTERFAC  WHERE previous_activity_id = regInstance(indx).instance_id;
            ut_trace.trace('delete WF_INSTANCE_TRANS ',3);
            delete FROM open.WF_INSTANCE_TRANS    WHERE target_id            = regInstance(indx).instance_id ;
            ut_trace.trace('delete WF_INSTANCE_TRANS ',3);
            delete FROM open.WF_INSTANCE_TRANS    WHERE origin_id            = regInstance(indx).instance_id ;
            ut_trace.trace('delete WF_INSTANCE_DATA_MAP ',3);
            delete FROM open.WF_INSTANCE_DATA_MAP WHERE target in (SELECT instance_ATTRIB_id FROM Open.WF_INSTANCE_ATTRIB WHERE instance_id = regInstance(indx).instance_id);
            ut_trace.trace('delete WF_INSTANCE_DATA_MAP ',3);
            delete FROM open.WF_INSTANCE_DATA_MAP WHERE source_id in (SELECT instance_ATTRIB_id FROM Open.WF_INSTANCE_ATTRIB WHERE instance_id = regInstance(indx).instance_id);
            ut_trace.trace('delete WF_INSTANCE_ATTRIB ',3);
            delete FROM open.WF_INSTANCE_ATTRIB   WHERE instance_id = regInstance(indx).instance_id ;

            nuVal:=0;
            SELECT  count(*) INTO nuVal
            FROM open.MO_WF_PACK_INTERFAC
            WHERE undo_activity_id = regInstance(indx).instance_id ;

            if nuVal > 0 then
                ut_trace.trace('delete MO_WF_PACK_INTERFAC ',3);
                delete FROM open.MO_WF_PACK_INTERFAC WHERE undo_activity_id = regInstance(indx).instance_id ;
            END if;

            ut_trace.trace('update de instancia en or_order_activity ',3);
            update open.or_order_activity set instance_id =-instance_id WHERE instance_id = regInstance(indx).instance_id;
            ut_trace.trace('delete wf_instance ',3);
            delete FROM open.wf_instance WHERE instance_id = regInstance(indx).instance_id;

            ut_trace.trace('Instancia Procesada:'|| regInstance(indx).instance_id);

            -- Obtiene proximo registro a procesar
            indx := regInstance.NEXT(indx);
            END LOOP;
            -- Realiza persistencia de los cambios efectuados
            ut_trace.trace('commit ',3);
            COMMIT;
            -- Sale del cursor principal si no existen registros a procesar
            EXIT WHEN DatosBorrado%NOTFOUND;
       END LOOP;

       -- Cierra el cursor principal
      CLOSE DatosBorrado;
      ut_trace.trace('Registros Procesados: '||nuRegProcesados,2);
      dbms_output.put_Line('Registros Procesados: '||nuRegProcesados);
      ut_trace.trace('End DELETE_esquema_wf',2);
      dbms_output.put_Line('End DELETE_esquema_wf');
    END;


    PROCEDURE UPDATE_esquema_wf IS

        CURSOR DatosBorrado IS
		SELECT /*+ index(e PK_WF_DATA_EXTERNAL) */i.*
		FROM    wf_instance i--, WF_DATA_EXTERNAL e
		where /* instance_id >= 124567751 --between inuInstIni and inuInstFin
		   and e.PLAN_ID = i.PLAN_ID
			 and mod(e.PLAN_ID, 12) + 1 =  1*/
       i.instance_id between inuInstIni and inuInstFin
       and i.instance_id > 0;

        TYPE styInstance IS TABLE OF DatosBorrado%ROWTYPE INDEX BY PLS_INTEGER;
        regInstance styInstance;
        CnuLimit         NUMBER  := 100; -- Cantidad maxima de registros a procesar
        nuRegProcesados  number  := 0;
        indx             PLS_INTEGER;

        regdata_external wf_data_external%rowtype;
        reg_instance_equiv wf_instance_equiv%rowtype;
        nuerror number;
        sberror varchar2(4000);
    BEGIN
        dbms_output.put_Line('Ini UPDATE_esquema_wf');
        ut_trace.trace('Ini UPDATE_esquema_wf',2);
        -- Valida si el cursor principal esta abierto
        IF DatosBorrado%isopen THEN
           CLOSE DatosBorrado;
        END IF;

        nuRegProcesados := 0;
        -- Abre el cursor principal y obtiene los registros a procesar
        OPEN DatosBorrado;
        LOOP
            -- Recorre los registros a procesar
            FETCH DatosBorrado BULK COLLECT INTO regInstance LIMIT CnuLimit;

            -- Obtiene primer registro a procesar
            indx := regInstance.first;     -- regInstance(indx)

            -- Valida que hayan productos para procesar
            WHILE (indx IS NOT NULL) LOOP

            -- Actualiza contadores
            nuRegProcesados := nuRegProcesados + 1;
            ut_trace.trace('insert WF_INSTANCE ',3);
            -- Inserta registro en wf_instance con valor negativo
            IF  regInstance(indx).PARENT_ID is null THEN
               regInstance(indx).PARENT_ID := regInstance(indx).PARENT_ID;
            else
               regInstance(indx).PARENT_ID := -regInstance(indx).PARENT_ID;
            END IF;

            IF  regInstance(indx).PREVIOUS_INSTANCE_ID is null THEN
               regInstance(indx).PREVIOUS_INSTANCE_ID := regInstance(indx).PREVIOUS_INSTANCE_ID;
            else
               regInstance(indx).PREVIOUS_INSTANCE_ID := -regInstance(indx).PREVIOUS_INSTANCE_ID;
            END IF;
            begin

                INSERT INTO WF_INSTANCE
                (INSTANCE_ID, DESCRIPTION, PARENT_ID, ORIGINAL_TASK, PLAN_ID, UNIT_ID, STATUS_ID, PREVIOUS_STATUS_ID, ONLINE_EXEC_ID, ACTION_ID, PRE_EXPRESSION_ID, POS_EXPRESSION_ID, QUANTITY, INITIAL_DATE, FINAL_DATE, SINCRONIC_TIMEOUT, ASINCRONIC_TIMEOUT, LAYER_ID, EXTERNAL_ID, GEOMETRY, TRY_NUMBER, MULTI_INSTANCE, FUNCTION_TYPE, NODE_TYPE_ID, MODULE_ID, IS_COUNTABLE, TOTAL_TIME, PARENT_EXTERNAL_ID, ENTITY_ID, PAR_EXT_ENTITY_ID, GROUP_ID, MIN_GROUP_SIZE, UNIT_TYPE_ID, EXECUTION_ORDER, ANNULATION_ORDER, NOTIFICATION_ID, EXECUTION_ID, PREVIOUS_INSTANCE_ID)
                VALUES (-regInstance(indx).INSTANCE_ID, regInstance(indx).DESCRIPTION, regInstance(indx).PARENT_ID, regInstance(indx).ORIGINAL_TASK, -regInstance(indx).PLAN_ID, regInstance(indx).UNIT_ID, regInstance(indx).STATUS_ID, regInstance(indx).PREVIOUS_STATUS_ID,
                        regInstance(indx).ONLINE_EXEC_ID, regInstance(indx).ACTION_ID, regInstance(indx).PRE_EXPRESSION_ID, regInstance(indx).POS_EXPRESSION_ID, regInstance(indx).QUANTITY, regInstance(indx).INITIAL_DATE, regInstance(indx).FINAL_DATE, regInstance(indx).SINCRONIC_TIMEOUT,
                        regInstance(indx).ASINCRONIC_TIMEOUT, regInstance(indx).LAYER_ID, regInstance(indx).EXTERNAL_ID, regInstance(indx).GEOMETRY, regInstance(indx).TRY_NUMBER, regInstance(indx).MULTI_INSTANCE, regInstance(indx).FUNCTION_TYPE, regInstance(indx).NODE_TYPE_ID,
                        regInstance(indx).MODULE_ID, regInstance(indx).IS_COUNTABLE, regInstance(indx).TOTAL_TIME, regInstance(indx).PARENT_EXTERNAL_ID, regInstance(indx).ENTITY_ID, regInstance(indx).PAR_EXT_ENTITY_ID, regInstance(indx).GROUP_ID, regInstance(indx).MIN_GROUP_SIZE,
                        regInstance(indx).UNIT_TYPE_ID, regInstance(indx).EXECUTION_ORDER, regInstance(indx).ANNULATION_ORDER, regInstance(indx).NOTIFICATION_ID, regInstance(indx).EXECUTION_ID, regInstance(indx).PREVIOUS_INSTANCE_ID);

                nuVal:=0;
                SELECT  count(*) INTO nuVal
                from  wf_data_external
                WHERE plan_id = regInstance(indx).instance_id;

                if nuVal > 0 then
                    ut_trace.trace('insert wf_data_external ',3);
                    select * into regdata_external from wf_data_external where plan_id = regInstance(indx).instance_id;

                    INSERT INTO WF_DATA_EXTERNAL
                           (PLAN_ID, PACK_TYPE_TAG, PRODUCT_TYPE_TAG, UNIT_TYPE_ID, PACKAGE_ID)
                    VALUES (-regdata_external.PLAN_ID, regdata_external.PACK_TYPE_TAG, regdata_external.PRODUCT_TYPE_TAG, regdata_external.UNIT_TYPE_ID, regdata_external.PACKAGE_ID);
                    ut_trace.trace('delete wf_data_external ',3);
                    delete FROM open.wf_data_external WHERE plan_id = regInstance(indx).instance_id;
                END if;


                nuVal:=0;
                SELECT  count(*) INTO nuVal
                from  wf_instance_equiv
                WHERE instance_id = regInstance(indx).instance_id;

                if nuVal > 0 then
                    ut_trace.trace('insert WF_INSTANCE_EQUIV ',3);
                    select * into reg_instance_equiv from wf_instance_equiv where instance_id = regInstance(indx).instance_id;

                    INSERT INTO WF_INSTANCE_EQUIV
                    (INSTANCE_ID, ATTRIBUTES_EQUIV_ID, EXTERNAL_ID, ENTITY_ID)
                    VALUES (-reg_instance_equiv.INSTANCE_ID, reg_instance_equiv.ATTRIBUTES_EQUIV_ID, reg_instance_equiv.EXTERNAL_ID, reg_instance_equiv.ENTITY_ID);

                    ut_trace.trace('delete WF_INSTANCE_EQUIV ',3);
                    delete FROM open.WF_INSTANCE_EQUIV WHERE instance_id = regInstance(indx).instance_id;
                END if;

                nuVal:=0;
                SELECT  count(*) INTO nuVal
                FROM open.WF_EXCEPTION_LOG
                WHERE instance_id = regInstance(indx).instance_id;

                if nuVal > 0 then
                    ut_trace.trace('update WF_EXCEPTION_LOG ',3);
                    update open.WF_EXCEPTION_LOG set instance_id = -regInstance(indx).instance_id
                    WHERE instance_id = regInstance(indx).instance_id;
                END if;
                ut_trace.trace('update MO_WF_MOTIV_INTERFAC ',3);
                update open.MO_WF_MOTIV_INTERFAC set activity_id = -activity_id                   WHERE activity_id          = regInstance(indx).instance_id;
                ut_trace.trace('update MO_WF_MOTIV_INTERFAC ',3);
                update open.MO_WF_MOTIV_INTERFAC set previous_activity_id = -previous_activity_id WHERE previous_activity_id = regInstance(indx).instance_id;
                ut_trace.trace('update MO_WF_MOTIV_INTERFAC ',3);
                update open.MO_WF_MOTIV_INTERFAC set undo_activity_id = -undo_activity_id         WHERE undo_activity_id     = regInstance(indx).instance_id;
                ut_trace.trace('update MO_WF_COMP_INTERFAC ',3);
                update open.MO_WF_COMP_INTERFAC  set activity_id = -activity_id                   WHERE activity_id          = regInstance(indx).instance_id;
                ut_trace.trace('update MO_WF_COMP_INTERFAC ',3);
                update open.MO_WF_COMP_INTERFAC  set previous_activity_id = -previous_activity_id WHERE previous_activity_id = regInstance(indx).instance_id;
                ut_trace.trace('update MO_WF_COMP_INTERFAC ',3);
                update open.MO_WF_COMP_INTERFAC  set undo_activity_id = -undo_activity_id         WHERE undo_activity_id     = regInstance(indx).instance_id;
                ut_trace.trace('update MO_WF_PACK_INTERFAC ',3);
                update open.MO_WF_PACK_INTERFAC  set activity_id = -activity_id                   WHERE activity_id          = regInstance(indx).instance_id ;
                ut_trace.trace('update MO_WF_PACK_INTERFAC ',3);
                update open.MO_WF_PACK_INTERFAC  set previous_activity_id = -previous_activity_id WHERE previous_activity_id = regInstance(indx).instance_id;
                ut_trace.trace('update WF_INSTANCE_TRANS ',3);
                update open.WF_INSTANCE_TRANS    set target_id = -target_id                       WHERE target_id            = regInstance(indx).instance_id ;
                ut_trace.trace('update WF_INSTANCE_TRANS ',3);
                update open.WF_INSTANCE_TRANS    set origin_id = -origin_id                       WHERE origin_id            = regInstance(indx).instance_id ;
                --update open.WF_INSTANCE_DATA_MAP set target_id = -target_id                       WHERE target in (SELECT instance_ATTRIB_id FROM Open.WF_INSTANCE_ATTRIB WHERE instance_id = regInstance(indx).instance_id);
                --update open.WF_INSTANCE_DATA_MAP set source_id = -source_id                       WHERE source_id in (SELECT instance_ATTRIB_id FROM Open.WF_INSTANCE_ATTRIB WHERE instance_id = regInstance(indx).instance_id);
                ut_trace.trace('update WF_INSTANCE_ATTRIB ',3);
                update open.WF_INSTANCE_ATTRIB   set instance_id = -instance_id                   WHERE instance_id = regInstance(indx).instance_id ;

                nuVal:=0;
                SELECT  count(*) INTO nuVal
                FROM open.MO_WF_PACK_INTERFAC
                WHERE undo_activity_id = regInstance(indx).instance_id ;

                if nuVal > 0 then
                    ut_trace.trace('update MO_WF_PACK_INTERFAC ',3);
                    update open.MO_WF_PACK_INTERFAC set undo_activity_id = -undo_activity_id WHERE undo_activity_id = regInstance(indx).instance_id ;
                END if;

                ut_trace.trace('update or_order_activity ',3);
                update open.or_order_activity set instance_id = -instance_id WHERE instance_id = regInstance(indx).instance_id;

                ut_trace.trace('delete wf_instance ',3);
                delete FROM open.wf_instance WHERE instance_id = regInstance(indx).instance_id;

                ut_trace.trace('Instancia Procesada:'|| regInstance(indx).instance_id,3);
             exception
               when others then
                  errors.seterror;
                  errors.geterror(nuerror, sberror);
                  rollback;
                   INSERT INTO LDC_TRAZA_LOG
                      (TRALOG_ID, FECHA_REGISTRO, DATA1, DATA2)
                    VALUES
                      (regInstance(indx).instance_id,
                       SYSDATE,
                       sberror,
                       regInstance(indx).instance_id);
                       COMMIT;
             end;
            -- Obtiene proximo registro a procesar
               indx := regInstance.NEXT(indx);
            END LOOP;
            -- Realiza persistencia de los cambios efectuados
            ut_trace.trace('commit ',3);
            COMMIT;
            -- Sale del cursor principal si no existen registros a procesar
            EXIT WHEN DatosBorrado%NOTFOUND;
       END LOOP;

       -- Cierra el cursor principal
      CLOSE DatosBorrado;
      dbms_output.put_Line('Registros Procesados: '||nuRegProcesados);
      ut_trace.trace('Registros Procesados: '||nuRegProcesados,2);
      dbms_output.put_Line('End UPDATE_esquema_wf');
      ut_trace.trace('End UPDATE_esquema_wf',2);
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

BEGIN

    SELECT USERENV('SESSIONID'),USER, TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'MM') INTO nusession,sbuser,nuano, numes
    FROM dual;

    ldc_proinsertaestaprog(nuano,numes,'INSTANCIA_'||upper(isbAction)||'_'||inuHilo,'En ejecucion..',nusession,sbuser);
   -- disable_constraints;

    IF upper(isbAction) = 'DELETE' THEN
          DELETE_esquema_wf;
    elsif upper(isbAction) = 'UPDATE' THEN
        UPDATE_esquema_wf;
    END IF;
    COMMIT;
    ldc_proactualizaestaprog(nusession,nvl(sbErrorMessage,'Ok'),'INSTANCIA_'||upper(isbAction)||'_'||inuHilo,'Termino '||nuErrorCode);
   -- enable_constraints;

   -- dbms_output.put_Line('Fin ['||sysdate||']');

EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
         ldc_proactualizaestaprog(nusession,'ERROR '||sbErrorMessage,'INSTANCIA_'||upper(isbAction)||'_'||inuHilo,'Termino '||nuErrorCode);
        --dbms_output.put_line('ERROR CONTROLLED ');
      --  dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
       -- dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
          ldc_proactualizaestaprog(nusession,'ERROR '||sbErrorMessage,'INSTANCIA_'||upper(isbAction)||'_'||inuHilo,'Termino '||nuErrorCode);
--        dbms_output.put_line('ERROR OTHERS ');
  --      dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
     --   dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
  END tmp_Cambiar_Instancia_NegaHilo;

  PROCEDURE prCambiaAtributoNega(inuatribIni IN NUMBER, inuAtribFinal IN NUMBER, isbProceso IN VARCHAR2) IS
     nuErrorCode NUMBER;
     sbErrorMessage VARCHAR2(4000);
    --nuVal   number;

	CURSOR DatosAtributos IS
	SELECT  *
	FROM  WF_INSTANCE_ATTRIB i
	where  i.INSTANCE_ATTRIB_ID between inuatribIni and inuAtribFinal
   and i.INSTANCE_ATTRIB_ID > 0;

	TYPE styAtributos IS TABLE OF DatosAtributos%ROWTYPE INDEX BY PLS_INTEGER;
	regInstance styAtributos;
	CnuLimit         NUMBER  := 100; -- Cantidad maxima de registros a procesar
	indx             PLS_INTEGER;

    nusession   NUMBER;
    sbuser      VARCHAR2(30);
    nuano       NUMBER;
    numes       NUMBER;
	nuRegProcesados number;

  BEGIN
    SELECT USERENV('SESSIONID'),USER, TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'MM') INTO nusession,sbuser,nuano, numes
    FROM dual;

    ldc_proinsertaestaprog(nuano,numes,isbProceso,'En ejecucion..',nusession,sbuser);
	-- Abre el cursor principal y obtiene los registros a procesar
        OPEN DatosAtributos;
        LOOP
            -- Recorre los registros a procesar
            FETCH DatosAtributos BULK COLLECT INTO regInstance LIMIT CnuLimit;

            -- Obtiene primer registro a procesar
            indx := regInstance.first;     -- regInstance(indx)

            -- Valida que hayan productos para procesar
            WHILE (indx IS NOT NULL) LOOP

            -- Actualiza contadores
            nuRegProcesados := nuRegProcesados + 1;
               ut_trace.trace('insert WF_INSTANCE ',3);
            -- Inserta registro en wf_instance con valor negativo

            begin
             ut_trace.trace('insert WF_INSTANCE_ATTRIB ',3);
                INSERT INTO WF_INSTANCE_ATTRIB (INSTANCE_ATTRIB_ID,INSTANCE_ID,ATTRIBUTE_ID,VALUE,ATTRIB_LAYER,IS_DUPLICABLE,IN_OUT,STATEMENT_ID,MANDATORY)
                VALUES (-regInstance(indx).INSTANCE_ATTRIB_ID,
                        regInstance(indx).INSTANCE_ID,
                        regInstance(indx).ATTRIBUTE_ID,
                        regInstance(indx).VALUE,
                        regInstance(indx).ATTRIB_LAYER,
                        regInstance(indx).IS_DUPLICABLE,
                        regInstance(indx).IN_OUT,
                        regInstance(indx).STATEMENT_ID,
                        regInstance(indx).MANDATORY);

                ut_trace.trace('update WF_INSTANCE_DATA_MAP SOURCE_ID ',3);
                update open.WF_INSTANCE_DATA_MAP set INSTANCE_DATA_MAP_ID =  -ABS(INSTANCE_DATA_MAP_ID), SOURCE_ID = -SOURCE_ID WHERE SOURCE_ID = regInstance(indx).INSTANCE_ATTRIB_ID;
            	 ut_trace.trace('update WF_INSTANCE_DATA_MAP TARGET',3);
                update open.WF_INSTANCE_DATA_MAP set INSTANCE_DATA_MAP_ID =  -ABS(INSTANCE_DATA_MAP_ID), TARGET = -TARGET WHERE TARGET = regInstance(indx).INSTANCE_ATTRIB_ID;

	             ut_trace.trace('delete WF_INSTANCE_ATTRIB ',3);
                delete FROM open.WF_INSTANCE_ATTRIB WHERE INSTANCE_ATTRIB_ID = regInstance(indx).INSTANCE_ATTRIB_ID;

                ut_trace.trace('atributo Procesado:'|| regInstance(indx).INSTANCE_ATTRIB_ID,3);
             exception
               when others then
                  errors.seterror;
                  errors.geterror(nuErrorCode, sbErrorMessage);
                  rollback;
                   INSERT INTO LDC_TRAZA_LOG
                      (TRALOG_ID, FECHA_REGISTRO, DATA1, DATA2)
                    VALUES
                      (regInstance(indx).INSTANCE_ATTRIB_ID,
                       SYSDATE,
                       sbErrorMessage,
                       regInstance(indx).INSTANCE_ATTRIB_ID);
                       COMMIT;
             end;
            -- Obtiene proximo registro a procesar
               indx := regInstance.NEXT(indx);
            END LOOP;
            -- Realiza persistencia de los cambios efectuados
            ut_trace.trace('commit ',3);
            COMMIT;
            -- Sale del cursor principal si no existen registros a procesar
            EXIT WHEN DatosAtributos%NOTFOUND;
       END LOOP;
       -- Cierra el cursor principal
      CLOSE DatosAtributos;
      commit;
	dbms_output.put_Line('Registros Procesados: '||nuRegProcesados);
    ut_trace.trace('Registros Procesados: '||nuRegProcesados,2);
	ldc_proactualizaestaprog(nusession,nvl(sbErrorMessage,'ok'),isbProceso,'Termino '||nuRegProcesados);
   -- disable_constraints;
  EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
         ldc_proactualizaestaprog(nusession,'ERROR '||sbErrorMessage,isbProceso,'Termino '||nuErrorCode);
        --dbms_output.put_line('ERROR CONTROLLED ');
      --  dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
       -- dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
          ldc_proactualizaestaprog(nusession,'ERROR '||sbErrorMessage,isbProceso,'Termino '||nuErrorCode);
  END;


  PROCEDURE prCambiaTransNega(inuTotalHilo IN NUMBER, inuHilo IN NUMBER, isbProceso IN VARCHAR2) IS
     nuErrorCode NUMBER;
     sbErrorMessage VARCHAR2(4000);
    --nuVal   number;

	CURSOR DatosTrans IS
	SELECT  *
	FROM  WF_INSTANCE_TRANS i
	where  mod(INST_TRAN_ID, inuTotalHilo) + 1 = inuHilo;

	TYPE styTransacion IS TABLE OF DatosTrans%ROWTYPE INDEX BY PLS_INTEGER;
	regInstance styTransacion;
	CnuLimit         NUMBER  := 100; -- Cantidad maxima de registros a procesar
	indx             PLS_INTEGER;

    nusession   NUMBER;
    sbuser      VARCHAR2(30);
    nuano       NUMBER;
    numes       NUMBER;
	nuRegProcesados number;

  BEGIN
    SELECT USERENV('SESSIONID'),USER, TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'MM') INTO nusession,sbuser,nuano, numes
    FROM dual;

    ldc_proinsertaestaprog(nuano,numes,isbProceso,'En ejecucion..',nusession,sbuser);
	-- Abre el cursor principal y obtiene los registros a procesar
        OPEN DatosTrans;
        LOOP
            -- Recorre los registros a procesar
            FETCH DatosTrans BULK COLLECT INTO regInstance LIMIT CnuLimit;

            -- Obtiene primer registro a procesar
            indx := regInstance.first;     -- regInstance(indx)

            -- Valida que hayan productos para procesar
            WHILE (indx IS NOT NULL) LOOP

            -- Actualiza contadores
            nuRegProcesados := nuRegProcesados + 1;
               ut_trace.trace('insert WF_INSTANCE ',3);
            -- Inserta registro en wf_instance con valor negativo

            begin
             ut_trace.trace('insert WF_INSTANCE_TRANS ',3);
                INSERT INTO WF_INSTANCE_TRANS
                (INST_TRAN_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID,ORIGINAL,STATUS)
                VALUES (-regInstance(indx).INST_TRAN_ID,
                        regInstance(indx).ORIGIN_ID,
                        regInstance(indx).TARGET_ID,
                        regInstance(indx).GEOMETRY,
                        regInstance(indx).GROUP_ID,
                        regInstance(indx).EXPRESSION,
                        regInstance(indx).EXPRESSION_TYPE,
                        regInstance(indx).DESCRIPTION,
                        regInstance(indx).TRANSITION_TYPE_ID,
                        regInstance(indx).ORIGINAL,
                        regInstance(indx).STATUS);


	             ut_trace.trace('delete WF_INSTANCE_TRANS ',3);
                delete FROM open.WF_INSTANCE_TRANS WHERE INST_TRAN_ID = regInstance(indx).INST_TRAN_ID;

                ut_trace.trace('transacion Procesado:'|| regInstance(indx).INST_TRAN_ID,3);
             exception
               when others then
                  errors.seterror;
                  errors.geterror(nuErrorCode, sbErrorMessage);
                  rollback;
                   INSERT INTO LDC_TRAZA_LOG
                      (TRALOG_ID, FECHA_REGISTRO, DATA1, DATA2)
                    VALUES
                      (regInstance(indx).INST_TRAN_ID,
                       SYSDATE,
                       sbErrorMessage,
                       regInstance(indx).INST_TRAN_ID);
                       COMMIT;
             end;
            -- Obtiene proximo registro a procesar
               indx := regInstance.NEXT(indx);
            END LOOP;
            -- Realiza persistencia de los cambios efectuados
            ut_trace.trace('commit ',3);
            COMMIT;
            -- Sale del cursor principal si no existen registros a procesar
            EXIT WHEN DatosTrans%NOTFOUND;
       END LOOP;
       -- Cierra el cursor principal
      CLOSE DatosTrans;
      commit;
	dbms_output.put_Line('Registros Procesados: '||nuRegProcesados);
    ut_trace.trace('Registros Procesados: '||nuRegProcesados,2);
	ldc_proactualizaestaprog(nusession,nvl(sbErrorMessage,'ok'),isbProceso,'Termino '||nuRegProcesados);
   -- disable_constraints;
  EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
         ldc_proactualizaestaprog(nusession,'ERROR '||sbErrorMessage,isbProceso,'Termino '||nuErrorCode);
        --dbms_output.put_line('ERROR CONTROLLED ');
      --  dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
       -- dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
          ldc_proactualizaestaprog(nusession,'ERROR '||sbErrorMessage,isbProceso,'Termino '||nuErrorCode);
  END;

  FUNCTION fnuValidaEje(isbproceso in varchar2) RETURN NUMBER IS
    CURSOR cugetEjecuHilo IS
    SELECT COUNT(1)
    FROM ldc_osf_estaproc
    WHERE PROCESO LIKE isbproceso||'%'
     AND TRUNC(FECHA_INICIAL_EJEC) = TRUNC(SYSDATE)
     AND FECHA_FINAL_EJEC IS NOT NULL;

     nuCant NUMBER;

  BEGIN
    OPEN cugetEjecuHilo;
    FETCH cugetEjecuHilo INTO nuCant;
    CLOSE cugetEjecuHilo;

    RETURN nuCant;

  END fnuValidaEje;

  PROCEDURE prJobEjecutaInsta IS
    nuJob NUMBER;
    nuValiEje NUMBER;
	 nusession   NUMBER;
    sbuser      VARCHAR2(30);
    nuano       NUMBER;
    numes       NUMBER;
	nuErrorCode NUMBER;
	sbErrorMessage VARCHAR2(4000);
  nufin number := 124567750;
  nuinicio number;
  nuFinal number;
  nuAumento number;

  BEGIN
     SELECT USERENV('SESSIONID'),USER, TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'MM') INTO nusession,sbuser,nuano, numes
    FROM dual;

    ldc_proinsertaestaprog(nuano,numes,'PRJOBEJECUTAINSTA','En ejecucion..',nusession,sbuser);

    disable_constraints;

    /*FOR reg IN 1..12 LOOP
       nuinicio := nufin + 1;
       nufin := nuinicio  + 168576324;

       DBMS_OUTPUT.PUT_LINE(' nuinicio '||nuinicio||' nufin '||nufin);
       if reg = 12 then
         nufin := 2147483647;
       end if;
       DBMS_JOB.SUBMIT (
           job  => nuJob,
           what  => 'begin ldc_pkgestioIntancia.tmp_Cambiar_Instancia_NegaHilo('||nuinicio||','||nufin||','||reg||',''UPDATE''); exception when others then null; end;',
           next_date =>  sysdate + 1 / 3600
          );
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('HILO '||REG||' JOB '||nuJob);
    END LOOP;
   --Espera ejecucion
   nuValiEje :=  fnuValidaEje('INSTANCIA');
    WHILE nuValiEje < 12 loop
        dbms_lock.sleep(10);
        nuValiEje :=  fnuValidaEje('INSTANCIA');
    end loop;
    */
    select min(INSTANCE_ATTRIB_ID) - 1 INTO nufin
    from open.WF_INSTANCE_ATTRIB
    WHERE INSTANCE_ATTRIB_ID > 0;


    select MAX(INSTANCE_ATTRIB_ID) INTO nuFinal
    from open.WF_INSTANCE_ATTRIB;

    SELECT round((nuFinal - nufin ) / 12,0) into nuAumento
    from dual;
    --se ejecutan atributos
     FOR reg IN 1..12 LOOP
       nuinicio := nufin + 1;
       nufin := nuinicio  + nuAumento;

       DBMS_OUTPUT.PUT_LINE(' nuinicio '||nuinicio||' nufin '||nufin);
       if reg = 12 then
         nufin := nuFinal;
       end if;
       DBMS_JOB.SUBMIT (
           job  => nuJob,
           what  => 'begin ldc_pkgestioIntancia.prCambiaAtributoNega('||nuinicio||','||nufin||',''ATRIBUTO'||reg||'''); exception when others then null; end;',
           next_date =>  sysdate + 1 / 3600
          );
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('HILO '||REG||' JOB '||nuJob);
    END LOOP;

     --se ejecutan atributos
     FOR reg IN 1..12 LOOP

       DBMS_JOB.SUBMIT (
           job  => nuJob,
           what  => 'begin ldc_pkgestioIntancia.prCambiaTransNega('||12||','||reg||',''TRANSACCION'||reg||'''); exception when others then null; end;',
           next_date =>  sysdate + 1 / 3600
          );
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('HILO '||REG||' JOB '||nuJob);
    END LOOP;

     --Espera ejecucion
   nuValiEje :=  fnuValidaEje('ATRIBUTO');
    WHILE nuValiEje < 12 loop
        dbms_lock.sleep(10);
        nuValiEje :=  fnuValidaEje('ATRIBUTO');
    end loop;

    enable_constraints;
	 ldc_proactualizaestaprog(nusession,nvl(sbErrorMessage,'Ok'),'PRJOBEJECUTAINSTA','Termino '||nuErrorCode);
  exception
    when others then
     -- DBMS_OUTPUT.PUT_LINE('error no controlado '||sqlerrm);
	  ERRORS.SETERROR;
	    Errors.getError(nuErrorCode, sbErrorMessage);
       ldc_proactualizaestaprog(nusession,'ERROR '||sbErrorMessage,'PRJOBEJECUTAINSTA','Termino '||nuErrorCode);
	    enable_constraints;
  END;

  PROCEDURE prOrdenatributos IS
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nusession   NUMBER;
    sbuser      VARCHAR2(30);
    nuano       NUMBER;
    numes       NUMBER;
    nuMaximo NUMBER;

    cursor CUDATOSPRINC IS
	  WITH datosorde AS
	  (
	  SELECT  *
	  FROM OPEN.wf_instance_attrib A
	  WHERE /*instance_attrib_id < nuMaximo AND*/ instance_attrib_id > 0
	  ORDER BY instance_attrib_id), datoscolum AS (
	  SELECT ROWNUM id_reg, instance_attrib_id ID
	  FROM datosorde)
	  SELECT *
	  FROM datoscolum
	  WHERE ID <> id_reg;

	TYPE styaTRIBUTOS IS TABLE OF CUDATOSPRINC%ROWTYPE;
	v_t_atributos styaTRIBUTOS;


   nuconta number := 0;
   SBrOWID varchar2(4000);
   nuIDATRIBUTO NUMBER;
   ACTIVO NUMBER;
    nuUltiId NUMBER;
  BEGIN
    SELECT USERENV('SESSIONID'),USER, TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'MM') INTO nusession,sbuser,nuano, numes
    FROM dual;

    ldc_proinsertaestaprog(nuano,numes,'PRORDENATRIBUTOS','En ejecucion..',nusession,sbuser);

   -- nuMaximo := SEQ_WF_INSTANCE_ATTRIB.NEXTVAL - 100;

	select count(1) into ACTIVO
	FROM DBA_CONSTRAINTS
	WHERE CONSTRAINT_NAME = 'FK_WF_INAT_WF_IDMA_1'
	 AND STATUS = 'ENABLED';

	IF ACTIVO > 0 THEN
		execute immediate 'alter table WF_INSTANCE_DATA_MAP disable constraint FK_WF_INAT_WF_IDMA_1';
		execute immediate 'alter table WF_INSTANCE_DATA_MAP disable constraint FK_WF_INAT_WF_IDMA_2';
    END IF;

    OPEN CUDATOSPRINC;
        LOOP            -- Recorre los registros a procesar
            FETCH CUDATOSPRINC BULK COLLECT INTO v_t_atributos LIMIT 100;
                FOR i IN 1..v_t_atributos.count loop
                  begin
                    update WF_INSTANCE_ATTRIB
                        set INSTANCE_ATTRIB_ID = v_t_atributos(I).id_reg
                     where INSTANCE_ATTRIB_ID = v_t_atributos(I).id;

                    update open.WF_INSTANCE_DATA_MAP set SOURCE_ID = v_t_atributos(I).id_reg WHERE SOURCE_ID = v_t_atributos(I).id;
                       ut_trace.trace('update WF_INSTANCE_DATA_MAP TARGET',3);
                    update open.WF_INSTANCE_DATA_MAP set TARGET = v_t_atributos(I).id_reg WHERE TARGET = v_t_atributos(I).id;

					nuUltiId := v_t_atributos(I).id_reg;
					nuConta := nuConta + 1;
                  exception
                    when others then
                       errors.seterror;
                       errors.geterror(nuErrorCode, sbErrorMessage);
                        DBMS_OUTPUT.PUT_LINE(sbErrorMessage);

                 END;
              end loop;
              COMMIT;
          --  nuConta := nuConta + v_t_atributos.count;
            if mod(nuConta,10000) = 0 THEN
               ldc_proactualizaestaprog(nusession,'Registros procesados '||nuConta,'PRORDENATRIBUTOS','Ejecutando ');
            end if;
            EXIT WHEN CUDATOSPRINC%NOTFOUND;
        end loop;
    CLOSE CUDATOSPRINC;
    commit;
	nuUltiId := nuUltiId+1;
	execute immediate 'DROP SEQUENCE  SEQ_WF_INSTANCE_ATTRIB';
	execute immediate 'CREATE SEQUENCE  SEQ_WF_INSTANCE_ATTRIB MINVALUE 1 MAXVALUE  9999999999999999999999999999  INCREMENT BY 100  START WITH '||nuUltiId ||' NOCACHE  ORDER  CYCLE';
    execute immediate 'alter table WF_INSTANCE_DATA_MAP enable novalidate constraint FK_WF_INAT_WF_IDMA_1';
    execute immediate 'alter table WF_INSTANCE_DATA_MAP enable novalidate constraint FK_WF_INAT_WF_IDMA_2';
  	ldc_proactualizaestaprog(nusession,nvl(sbErrorMessage,'Ok ult id '||nuUltiId),'PRORDENATRIBUTOS','Termino '||nuconta);
  exception
    when others then
     -- DBMS_OUTPUT.PUT_LINE('error no controlado '||sqlerrm);
      ERRORS.SETERROR;
	    Errors.getError(nuErrorCode, sbErrorMessage);
       ldc_proactualizaestaprog(nusession,'ERROR '||sbErrorMessage,'PRORDENATRIBUTOS','Termino '||nuErrorCode);
      execute immediate 'alter table WF_INSTANCE_DATA_MAP enable novalidate constraint FK_WF_INAT_WF_IDMA_1';
      execute immediate 'alter table WF_INSTANCE_DATA_MAP enable novalidate constraint FK_WF_INAT_WF_IDMA_2';
  END prOrdenatributos;

    PROCEDURE PRORDENTRANSACION IS
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nusession   NUMBER;
    sbuser      VARCHAR2(30);
    nuano       NUMBER;
    numes       NUMBER;
    nuMaximo NUMBER;

    cursor CUDATOSPRINC IS
	  with datosorde as (
		SELECT *
		FROM OPEN.WF_INSTANCE_TRANS A
		WHERE INST_TRAN_ID > 0 and INST_TRAN_ID < nuMaximo
		ORDER BY INST_TRAN_ID), datoscolum AS (
		SELECT ROWNUM id_reg, INST_TRAN_ID ID
		FROM datosorde)
		SELECT  id_reg, ID
		FROM datoscolum
		WHERE ID <> id_reg;

	TYPE styTransacion IS TABLE OF CUDATOSPRINC%ROWTYPE;
	v_t_transaccion styTransacion;


   nuconta number := 0;
   SBrOWID varchar2(4000);
   nuIDATRIBUTO NUMBER;
   ACTIVO NUMBER;
    nuUltiId NUMBER;
  BEGIN
    SELECT USERENV('SESSIONID'),USER, TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'MM') INTO nusession,sbuser,nuano, numes
    FROM dual;

    ldc_proinsertaestaprog(nuano,numes,'PRORDENTRANSACION','En ejecucion..',nusession,sbuser);

    nuMaximo := SEQ_WF_INSTANCE_TRANS.NEXTVAL - 100;

	  OPEN CUDATOSPRINC;
        LOOP            -- Recorre los registros a procesar
            FETCH CUDATOSPRINC BULK COLLECT INTO v_t_transaccion LIMIT 100;
                FOR i IN 1..v_t_transaccion.count loop
                  begin
                    update WF_INSTANCE_TRANS
                        set INST_TRAN_ID = v_t_transaccion(i).id_reg
                     where INST_TRAN_ID = v_t_transaccion(i).id;

                        nuUltiId := v_t_transaccion(I).id_reg;
                        nuConta := nuConta + 1;
                  exception
                    when others then
                       errors.seterror;
                       errors.geterror(nuErrorCode, sbErrorMessage);
                        DBMS_OUTPUT.PUT_LINE(sbErrorMessage);

                 END;
              end loop;
              COMMIT;
          --  nuConta := nuConta + v_t_atributos.count;
            if mod(nuConta,10000) = 0 THEN
               ldc_proactualizaestaprog(nusession,'Registros procesados '||nuConta,'PRORDENTRANSACION','Ejecutando ');
            end if;
            EXIT WHEN CUDATOSPRINC%NOTFOUND;
        end loop;
    CLOSE CUDATOSPRINC;
    commit;
	nuUltiId := nuUltiId+1;
	--execute immediate 'DROP SEQUENCE  SEQ_WF_INSTANCE_TRANS';
	--execute immediate 'CREATE SEQUENCE  SEQ_WF_INSTANCE_TRANS MINVALUE 1 MAXVALUE  9999999999999999999999999999  INCREMENT BY 100  START WITH '||nuUltiId ||' NOCACHE  ORDER  CYCLE';
   --  execute immediate 'alter table WF_INSTANCE_DATA_MAP enable novalidate constraint FK_WF_INAT_WF_IDMA_1';
   -- execute immediate 'alter table WF_INSTANCE_DATA_MAP enable novalidate constraint FK_WF_INAT_WF_IDMA_2';
  	ldc_proactualizaestaprog(nusession,nvl(sbErrorMessage,'Ok ult id '||nuUltiId),'PRORDENTRANSACION','Termino '||nuconta);
  exception
    when others then
     -- DBMS_OUTPUT.PUT_LINE('error no controlado '||sqlerrm);
      ERRORS.SETERROR;
	    Errors.getError(nuErrorCode, sbErrorMessage);
       ldc_proactualizaestaprog(nusession,'ERROR '||sbErrorMessage,'PRORDENTRANSACION','Termino '||nuErrorCode);

  END PRORDENTRANSACION;

  PROCEDURE prEliminaTras(nuTotalHilo IN NUMBER, nuHilo in number) IS

	 nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nusession   NUMBER;
    sbuser      VARCHAR2(30);
    nuano       NUMBER;
    numes       NUMBER;
    nuMaximo NUMBER;

    cursor CUDATOSPRINC IS
	 SELECT rowid id_reg, a.*
	 FROM OPEN.WF_INSTANCE_TRANS A
	 WHERE INST_TRAN_ID > 0
	  AND  MOD(INST_TRAN_ID, nuTotalHilo) + 1 = nuHilo;

	TYPE styTransacion IS TABLE OF CUDATOSPRINC%ROWTYPE;
	v_t_transaccion styTransacion;


	cursor cuInstancia(nuInstancia NUMBER) IS
	select s.package_id solicitud, s.motive_status_id estado, s.request_date fecha, S.PACKAGE_TYPE_ID tiposol, d.PLAN_ID planid
	from OPEN.WF_DATA_EXTERNAL d, open.mo_packages s, open.wf_instance i
	where d.PLAN_ID = i.PLAN_ID
	 and D.PACKAGE_ID = S.PACKAGE_ID
	 and I.INSTANCE_ID = nuInstancia
	 and S.request_date < to_date('01/01/2020', 'dd/mm/yyyy');

	 regSolicitud cuInstancia%rowtype;

	cursor cuexisteIntanciaAbierta(nuplan number) IS
  SELECT COUNT(1)
  FROM open.wf_instance i
  where i.PLAN_ID = nuplan
   AND I.STATUS_ID  IN ( select INSTANCE_STATUS_ID
                         from WF_INSTANCE_STATUS
                         where ACTIVE_FLAG = 'Y');

	cursor cuExisteSoliatendida(nusolicitud number ) is
	SELECT count(1)
	FROM open.mo_packages so
	where SO.CUST_CARE_REQUES_NUM = to_char(nusolicitud)
	 and package_type_id <> 268
	 and so.MOTIVE_STATUS_ID = 13;

   nuExiste number;

   nuconta number := 0;
  BEGIN
	  SELECT USERENV('SESSIONID'),USER, TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'MM') INTO nusession,sbuser,nuano, numes
    FROM dual;

    ldc_proinsertaestaprog(nuano,numes,'PRELIMINATRAS'||nuHilo,'En ejecucion..',nusession,sbuser);
	  OPEN CUDATOSPRINC;
        LOOP -- Recorre los registros a procesar
            FETCH CUDATOSPRINC BULK COLLECT INTO v_t_transaccion LIMIT 100;
                FOR i IN 1..v_t_transaccion.count loop

				   if cuInstancia%isopen then
                     close cuInstancia;
                   end if;

				   open cuInstancia(v_t_transaccion(i).ORIGIN_ID);
                   fetch cuInstancia INTO regSolicitud;
                   if cuInstancia%found THEN
                      if regSolicitud.estado = 14 then
                        IF cuexisteIntanciaAbierta%ISOPEN THEN
                           CLOSE cuexisteIntanciaAbierta;
                        END IF;

                          OPEN cuexisteIntanciaAbierta(regSolicitud.planid);
                          FETCH cuexisteIntanciaAbierta INTO nuExiste;
                          CLOSE cuexisteIntanciaAbierta;

                         If nuExiste = 0 THEN
                            delete from WF_INSTANCE_TRANS where rowid = v_t_transaccion(i).id_reg;
                            nuConta := nuConta + 1;
                         end if;
                      ELSE
                        if regSolicitud.tiposol = 268
							and regSolicitud.fecha < to_date('01/01/2016','dd/mm/yyyy')
							  THEN
                           if cuExisteSoliatendida%isopen THEN
                             close cuExisteSoliatendida;
                           end if;

                            open cuExisteSoliatendida(regSolicitud.solicitud);
                            fetch cuExisteSoliatendida INTO nuExiste;
                            close cuExisteSoliatendida;

                            if nuExiste = 0 THEN
                                delete from WF_INSTANCE_TRANS where rowid = v_t_transaccion(i).id_reg;
                                nuConta := nuConta + 1;
                            end if;
                        end if;
                       end if;
                     end if;
                     close cuInstancia;
                 END LOOP;
				 commit;
			      if mod(nuConta,1000) = 0 THEN

					   ldc_proactualizaestaprog(nusession,'Registros procesados '||nuConta,'PRELIMINATRAS'||nuHilo,'Ejecutando ');
					  --EXIT;
				  end if;

				  if  to_number(to_char(sysdate, 'hh24')) between 6 and 7 THEN
				      exit;
				  end if;
            EXIT WHEN CUDATOSPRINC%NOTFOUND;
        end loop;
    CLOSE CUDATOSPRINC;
    commit;
  	ldc_proactualizaestaprog(nusession,nvl(sbErrorMessage,'Ok'), 'PRELIMINATRAS'||nuHilo,'Termino '||nuconta);
  exception
    when others then
     -- DBMS_OUTPUT.PUT_LINE('error no controlado '||sqlerrm);
      ERRORS.SETERROR;
	    Errors.getError(nuErrorCode, sbErrorMessage);
       ldc_proactualizaestaprog(nusession,'ERROR '||sbErrorMessage,'PRELIMINATRAS'||nuHilo,'Termino '||nuErrorCode);
  END prEliminaTras;

 PROCEDURE prJobEliminaTras IS
   nuValiEje NUMBER;
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nusession   NUMBER;
    sbuser      VARCHAR2(30);
    nuano       NUMBER;
    numes       NUMBER;
    nuJob NUMBER;
 BEGIN

    SELECT USERENV('SESSIONID'),USER, TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'MM') INTO nusession,sbuser,nuano, numes
    FROM dual;

    ldc_proinsertaestaprog(nuano,numes,'PRJOBELIMINATRAS','En ejecucion..',nusession,sbuser);
    --se ejecutan atributos
     FOR reg IN 1..12 LOOP
       DBMS_JOB.SUBMIT (
           job  => nuJob,
           what  => 'begin ldc_pkgestioIntancia.prEliminaTras('||12||','||reg||'); exception when others then null; end;',
           next_date =>  sysdate + 1 / 3600
          );
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('HILO '||REG||' JOB '||nuJob);
    END LOOP;

     --Espera ejecucion
   nuValiEje :=  fnuValidaEje('PRELIMINATRAS');
    WHILE nuValiEje < 12 loop
        dbms_lock.sleep(10);
        nuValiEje :=  fnuValidaEje('PRELIMINATRAS');
    end loop;
    ldc_proactualizaestaprog(nusession,nvl(sbErrorMessage,'Ok'), 'PRJOBELIMINATRAS','Termino ');
 exception
    when others then
     -- DBMS_OUTPUT.PUT_LINE('error no controlado '||sqlerrm);
      ERRORS.SETERROR;
	    Errors.getError(nuErrorCode, sbErrorMessage);
       ldc_proactualizaestaprog(nusession,'ERROR '||sbErrorMessage,'PRJOBELIMINATRAS','Termino '||nuErrorCode);
 END prJobEliminaTras;
END ldc_pkgestioIntancia;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGESTIOINTANCIA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGESTIOINTANCIA', 'ADM_PERSON'); 
END;
/   
