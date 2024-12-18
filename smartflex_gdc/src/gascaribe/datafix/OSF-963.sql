declare
    cursor cuSolicitudes is
        SELECT p2.package_id,
                p2.request_Date,
                p2.motive_status_id,
                p2.user_id,
                p2.comment_,
                p2.cust_care_reques_num,
                p2.package_type_id
        FROM OPEN.mo_packages p
        INNER JOIN OPEN.mo_packages p2 on p2.cust_care_reques_num=to_char(p.cust_care_reques_num)
        WHERE p.package_id IN (196512968)
        AND p2.motive_status_id = 13
        ORDER BY  p2.package_id;
        
	 
    sbComment 		VARCHAR2(4000):='Se cambia estado a anulado por OSF-963';
	sbmensaje		VARCHAR2(4000);
	eerrorexception	EXCEPTION;
	onuErrorCode	NUMBER(18);
	osbErrorMessage	VARCHAR2(2000);
	cnuCommentType	CONSTANT NUMBER := 83;
	nuPlanId        wf_instance.instance_id%TYPE;
	nuError			NUMBER;
	nuCommentType   NUMBER:=1277;
    nuErrorCode     NUMBER;
    sbErrorMesse    VARCHAR2(4000);
	nuEstSolAnul	NUMBER:=32;
	nuEstMotAnul	NUMBER:=5;
	nuEstComAnul	NUMBER:=26;
	nuCausalAnul	NUMBER:=ge_boparameter.fnuget('ANNUL_CAUSAL');
	TYPE t_array_solicitudes IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
	
	v_array_solicitudes t_array_solicitudes;
	
	PACKAGE_IDvar MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type :=null;
	CUST_CARE_REQUES_NUMvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type :=null;
	PACKAGE_TYPE_IDvar MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type :=null;
	CURRENT_TABLE_NAMEvar MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type := 'MO_PACKAGES';
	CURRENT_EVENT_IDvar MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type := ge_boconstants.UPDATE_;
	CURRENT_EVEN_DESCvar MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type := 'UPDATE';
	O_MOTIVE_STATUS_IDVar MO_PACKAGE_CHNG_LOG.o_motive_status_id%TYPE;

	cursor cuOrdenes(nuSolicitud number) is
	select o.order_id, order_status_id, o.operating_unit_id
	  from open.or_order o, open.or_order_activity A
	 where a.order_id=o.order_id  
	   and a.package_id=nuSolicitud
	   and a.status!='F';

BEGIN
	
	FOR reg IN cuSolicitudes LOOP
		nuError  :=0;
		IF nuError = 0 THEN --1 VALIDACION
			BEGIN
				ldc_pkg_changstatesolici.packageinttransition(reg.package_id,ge_boparameter.fnuget('ANNUL_CAUSAL'));
			EXCEPTION
				WHEN OTHERS THEN
					rollback;
					nuError:=0;
			END;
			FOR regOt IN cuOrdenes(reg.package_id) LOOP
				BEGIN
					ldc_cancel_order(
									regOt.order_id,
									3446,
									SBCOMMENT,
									cnuCommentType,
									onuErrorCode,
									osbErrorMessage
									);
					if onuErrorCode <>0 then
						nuError := 1;
						rollback;
					else
						--Si la orden se encuentra en esta tabla se debe cambiar el estado.
						UPDATE if_maintenance
						SET maintenance_status = 3
						WHERE maintenance_id IN (regOt.order_id);
					end if;

				EXCEPTION
					WHEN OTHERS THEN
						nuError := 1;
						rollback;
				END;
			END LOOP;
			IF nuError = 0 THEN
				BEGIN
					--Cambio estado de la solicitud
					UPDATE OPEN.mo_packages
					SET motive_status_id = nuEstSolAnul
					WHERE package_id IN (reg.package_id);

					PACKAGE_IDvar:=reg.package_id;
					CUST_CARE_REQUES_NUMvar:=damo_packages.fsbgetcust_care_reques_num(reg.package_id,null);
					PACKAGE_TYPE_IDvar:= damo_packages.fnugetpackage_type_id(reg.package_id,null);
					O_MOTIVE_STATUS_IDVar :=  DAMO_MOTIVE.FNUGETMOTIVE_STATUS_ID(MO_BCPACKAGES.FNUGETMOTIVEID(reg.package_id));

					INSERT INTO MO_PACKAGE_CHNG_LOG  (CURRENT_USER_ID,CURRENT_USER_MASK,CURRENT_TERMINAL,CURRENT_TERM_IP_ADDR,CURRENT_DATE,CURRENT_TABLE_NAME,CURRENT_EXEC_NAME,CURRENT_SESSION_ID,CURRENT_EVENT_ID,CURRENT_EVEN_DESC,
														CURRENT_PROGRAM,CURRENT_MODULE,CURRENT_CLIENT_INFO,CURRENT_ACTION,PACKAGE_CHNG_LOG_ID,PACKAGE_ID,CUST_CARE_REQUES_NUM,PACKAGE_TYPE_ID,O_MOTIVE_STATUS_ID,N_MOTIVE_STATUS_ID)
					VALUES
					(AU_BOSystem.getSystemUserID, AU_BOSystem.getSystemUserMask,ut_session.getTERMINAL, ut_session.getIP, ut_date.fdtSysdate,CURRENT_TABLE_NAMEvar, AU_BOSystem.getSystemProcessName,ut_session.getSESSIONID,CURRENT_EVENT_IDvar,
					CURRENT_EVEN_DESCvar,ut_session.getProgram||'-'||SBCOMMENT,ut_session.getModule,ut_session.GetClientInfo,ut_session.GetAction,MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,PACKAGE_IDvar,CUST_CARE_REQUES_NUMvar,PACKAGE_TYPE_IDvar,O_MOTIVE_STATUS_IDVar,nuEstSolAnul
					) ;
					--SE ANULA EL MOTIVO
					UPDATE OPEN.MO_MOTIVE
					SET annul_date         = SYSDATE,
					annul_causal_id    = nuCausalAnul,
					motive_status_id   = nuEstMotAnul
					WHERE package_id IN (reg.package_id);
					--SE ANULA EL COMPONENTE
					UPDATE OPEN.MO_COMPONENT
					SET annul_date         = SYSDATE,
					annul_causal_id    = nuCausalAnul,
					motive_status_id   = nuEstComAnul
					WHERE package_id IN (reg.package_id);
				EXCEPTION
					WHEN OTHERS THEN 
						rollback;
						nuError:=1;
						dbms_output.put_line('Error anulando solicitud|'||reg.package_id||'|'||sqlerrm);
				END;
				IF nuError = 0 THEN
					COMMIT;
					BEGIN
						nuPlanId := wf_boinstance.fnugetplanid(reg.package_id, 17);
					EXCEPTION
						WHEN OTHERS THEN
							rollback;
							nuError:=1;
							dbms_output.put_line('Error obteniendo plan solicitud|'||reg.package_id||'|'||sqlerrm);
					END;
					-- anula el plan de wf
                    IF (nuPlanId IS NOT NULL) THEN
                        BEGIN
                            mo_boannulment.annulwfplan(nuPlanId);
                        EXCEPTION
                            WHEN OTHERS THEN
                                rollback;
                                nuError:=1;
                                dbms_output.put_line('Error anulando plan solicitud|'||reg.package_id||'|'||sqlerrm);
    
                        END;
						
						IF nuError = 0 THEN
							osbErrorMessage := 0;
							ldc_anularerrorflujo(reg.package_id, onuErrorCode, osbErrorMessage);
							IF (onuErrorCode <> 0) THEN
								dbms_output.put_line('Error anulando errores solicitud|'||reg.package_id||'|'||osbErrorMessage);
							END IF;
							COMMIT;
						END IF;
                    END IF;
					
				END IF;
			END IF;
		END IF;----1 VALIDACION
	END LOOP;
END;
/