CREATE OR REPLACE PROCEDURE LDC_JOBGENSAC
IS
    /*******************************************************************************
    Propiedad intelectual de PROYECTO GASES DEL CARIBE

      Autor         :ESANTIAGO (horbath)
      Fecha         :17-09-2019
      DESCRIPCION   :JOB PARA LA GENEREACION DE LA SOLICITUD SAC DE REVICION PERIODICA
      CASO          : 44

      Fecha                IDEntrega           Modificacion
      ============    ================    ============================================
      15/04/2021      652                 Se realizan controles al proceso:
                                          1. si el contrato ya tiene solicitud sac no debe generar otra
                                          2. si la solicitud origen esta en esatdo diferente de regsitrada no la genera.
                                          3. se coloca control de errorres.
                                          4. Se registran con medio de recepción segun parametro
                                          5. Se corrige el log de errores para que solo actualice el registro con error.
										  
	  14/11/2023	  OSF-1766			  Ajustes:
											-Manejo de trazas con pkg_traza
											-Manejo de errores con pkg_error
											-Reemplazo de llamado a algunos objetos de producto por personalizados
											-Se suprimen "AplicaEntregas" que no estén activas actualmente
      *******************************************************************************/

    -- Mensaje de error
    OSBERRORMESSAGE   GE_ERROR_LOG.DESCRIPTION%TYPE;
    -- Codigo de error
    ONUERRORCODE      GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    sbRequestXML      constants_per.tipo_xml_sol%TYPE;
    sbObserva         MO_PACKAGES.COMMENT_%TYPE;
    dtFechasol        DATE;
    nuPtoAtncndsol    MO_PACKAGES.Pos_Oper_Unit_Id%TYPE;
    nuPersonIdsol     MO_PACKAGES.PERSON_ID%TYPE;
    inuTipoRecepsol   MO_PACKAGES.Reception_Type_Id%TYPE;
    nuPackageId       mo_packages.package_id%TYPE;
    nuMotiveId        mo_motive.motive_id%TYPE;

    nuEstadoPack      mo_packages.motive_status_id%TYPE;               --- 652
    nuEstadoReg       mo_packages.motive_status_id%TYPE;               --- 652
    nuFindPackage     mo_packages.package_id%TYPE;                     --- 652
	
	csbMT_NAME  VARCHAR2(70) :=  'LDC_JOBGENSAC';
	sbproceso  VARCHAR2(100) := 'LDC_JOBGENSAC'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');




    CURSOR cu_gsac IS
        SELECT g.PACKAGE_ID,
               g.ORDER_ID,
               g.PRODUCT_ID,
               g.SUBSCRIPTION_ID,
               g.ADDRESS_ID,
               g.OBSERVACION,
               SUSCCLIE     SUBSCRIBER_ID,
               ACTIVITY_ID
          FROM LDC_GENSAC g, suscripc s
         WHERE g.SUBSCRIPTION_ID = s.SUSCCODI AND FLAG = 'N';

    regOrdenes        cu_gsac%ROWTYPE;


    CURSOR cuValPackTypeContracSAC (
        nuContrato   or_order_activity.subscription_id%TYPE)
    IS
        SELECT mo.package_id
          FROM mo_motive mt, mo_packages mo
         WHERE     mt.package_id = mo.package_id
               AND mo.package_type_id =
                   dald_parameter.fnugetnumeric_value ('SOL_REVPER_SAC',
                                                            NULL)    -- 100306
               AND mo.motive_status_id =
                   dald_parameter.fnugetnumeric_value (
                       'ESTADO_SOL_REGISTRADA',
                       NULL)                                             -- 13
               AND mt.subscription_id = nuContrato;


    ------------ modificacion cambio 652 -------------
    PROCEDURE err_upd (sbmessageerror   ge_error_log.description%TYPE,
                       nupackage_id     mo_packages.package_id%TYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        UPDATE LDC_GENSAC lg
           SET lg.ERROR_SAC = sbmessageerror, lg.FECHERRO = SYSDATE
         WHERE lg.PACKAGE_ID = nupackage_id;

        COMMIT;
    END err_upd;

    -----------------------------------------------------

    PROCEDURE err_upd_con_Flag (
        sbmessageerror   ge_error_log.description%TYPE,
        nupackage_id     mo_packages.package_id%TYPE)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        UPDATE LDC_GENSAC lg
           SET lg.ERROR_SAC = sbmessageerror,
               lg.FECHERRO = SYSDATE,
               FLAG = 'Y'
         WHERE lg.PACKAGE_ID = nupackage_id;

        COMMIT;
    END err_upd_con_Flag;
------------ fin modificacion cambio 652 ---------

BEGIN

	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

	pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

    nuPersonIdsol := pkg_bopersonal.fnugetpersonaid;                --- 652

	nuPtoAtncndsol := pkg_bopersonal.fnugetpuntoatencionid(nuPersonIdsol);

    FOR regOrdenes IN cu_gsac
    LOOP
        BEGIN
            nuEstadoPack :=   
                pkg_bcsolicitudes.fnugetestado(regOrdenes.PACKAGE_ID);           --- 652
            nuEstadoReg :=
                dald_parameter.fnugetnumeric_value ('ESTADO_SOL_REGISTRADA',NULL);             --- 652

            --- se valida el estado de la solicitud obtenida del cursor cu_gsac caso 652---
            IF (nuEstadoPack = nuEstadoReg)
            THEN
                -- se realiza la validacion del contrato que no tenga una solicitud SAC 100306 en estado registrada (13)
                IF (cuValPackTypeContracSAC%ISOPEN)
                THEN
                    CLOSE cuValPackTypeContracSAC;
                END IF;

                OPEN cuValPackTypeContracSAC (regOrdenes.SUBSCRIPTION_ID);

                FETCH cuValPackTypeContracSAC INTO nuFindPackage;

                IF (cuValPackTypeContracSAC%NOTFOUND)
                THEN
                    nuFindPackage := 0;
                END IF;

                CLOSE cuValPackTypeContracSAC;

                -- si la variable es igual a 0 quiere decir que NO encontro una solicitud SAC registrada para ese contrato
                IF (nuFindPackage = 0)
                THEN
                    BEGIN                                              --- 652
                        ONUERRORCODE := 0;
                        OSBERRORMESSAGE := '';
                        nuPackageId := 0;
                        nuMotiveId := 0;
                        dtFechasol :=
                            TO_DATE (SYSDATE, 'dd/mm/yyyy HH24:MI:SS');

                        inuTipoRecepsol :=
                            daldc_pararepe.fnugetparevanu (
                                'LDC_PARMERECEP',
                                NULL);                                 --- 652

                        pkg_traza.trace ('CREAR TRAMITE  ' || nuPersonIdsol, pkg_traza.cnuNivelTrzDef);

                        sbRequestXML :=  Pkg_xml_soli_rev_periodica.Getsolicitudsacrp(inuTipoRecepsol,
																					  regOrdenes.OBSERVACION,
																					  regOrdenes.PRODUCT_ID,
																					  regOrdenes.SUBSCRIBER_ID,
																					  dtFechasol,
																					  regOrdenes.ACTIVITY_ID,
																					  regOrdenes.ORDER_ID);
						

                        /*Ejecuta el XML creado*/
                        api_registerRequestByXml(sbRequestXML,
                                                 nuPackageId,
                                                 nuMotiveId,
                                                 ONUERRORCODE,
                                                 OSBERRORMESSAGE);

                        IF ONUERRORCODE <> 0
                        THEN
                            err_upd (OSBERRORMESSAGE, regOrdenes.PACKAGE_ID);
                            ROLLBACK;
                        ELSE
                            UPDATE LDC_GENSAC
                               SET FLAG = 'Y',
                                   ERROR_SAC =
                                       'Solciitud generada:' || nuPackageId
                             WHERE PACKAGE_ID = regOrdenes.PACKAGE_ID;

                            COMMIT;
                        END IF;

                    EXCEPTION
                        WHEN pkg_error.controlled_error
                        THEN
                            ROLLBACK;
                            pkg_error.getError(ONUERRORCODE, OSBERRORMESSAGE);
							pkg_traza.trace ('ERROR LDC_JOBGENSAC  ' || OSBERRORMESSAGE, pkg_traza.cnuNivelTrzDef);
                            err_upd (OSBERRORMESSAGE, regOrdenes.PACKAGE_ID);
                        WHEN OTHERS
                        THEN
                            ROLLBACK;
                            pkg_error.setError;
                            pkg_error.getError(ONUERRORCODE, OSBERRORMESSAGE);
							pkg_traza.trace ('ERROR LDC_JOBGENSAC  ' || OSBERRORMESSAGE, pkg_traza.cnuNivelTrzDef);
                            err_upd (OSBERRORMESSAGE, regOrdenes.PACKAGE_ID);
                    END;
                ELSE
                    -- en caso de que encuentre una solicitud SAC se deja el mensaje de error
                    err_upd_con_Flag (
                           'No se pudo procesar porque ya cuenta con la solicitud SAC: #'
                        || nuFindPackage
                        || ' en proceso',
                        regOrdenes.PACKAGE_ID);
                END IF;
            ELSE
                -- si el estado se la solicitud no es registrada se deja el msj de error 652
                err_upd_con_Flag (
                       'La solicitud tiene un estado diferente a registrado ('
                    || nuEstadoPack
                    || ')',
                    regOrdenes.PACKAGE_ID);
            END IF;      --- fin if (nuEstadoPack = nuEstadoReg) then caso 652
        EXCEPTION
            WHEN pkg_error.controlled_error
            THEN
                ROLLBACK;
                pkg_error.getError(ONUERRORCODE, OSBERRORMESSAGE);
				pkg_traza.trace ('ERROR LDC_JOBGENSAC  ' || OSBERRORMESSAGE, pkg_traza.cnuNivelTrzDef);
                err_upd (OSBERRORMESSAGE, regOrdenes.PACKAGE_ID);
            WHEN OTHERS
            THEN
                ROLLBACK;
                pkg_error.setError;
                pkg_error.getError(ONUERRORCODE, OSBERRORMESSAGE);
				pkg_traza.trace ('ERROR LDC_JOBGENSAC  ' || OSBERRORMESSAGE, pkg_traza.cnuNivelTrzDef);
                err_upd (OSBERRORMESSAGE, regOrdenes.PACKAGE_ID);
        END;
    END LOOP;
	
	
    pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);

	pkg_estaproc.prActualizaEstaproc(sbProceso,' Ok', 'Termino con Exito');
	
					  
EXCEPTION
    WHEN pkg_error.controlled_error
    THEN
        pkg_error.getError(ONUERRORCODE, OSBERRORMESSAGE);
        pkg_traza.trace ('ERROR LDC_JOBGENSAC  ' || OSBERRORMESSAGE, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
        pkg_estaproc.prActualizaEstaproc(sbProceso,' Error', OSBERRORMESSAGE);
        ROLLBACK;
    WHEN OTHERS
    THEN
        pkg_error.setError;
		pkg_error.getError(ONUERRORCODE,OSBERRORMESSAGE);
        pkg_traza.trace ('ERROR LDC_JOBGENSAC  ' || OSBERRORMESSAGE, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
		pkg_estaproc.prActualizaEstaproc(sbProceso,' Error', OSBERRORMESSAGE);
        ROLLBACK;
END LDC_JOBGENSAC;
/

