create or replace PROCEDURE LDCGPAD(inuProgramacion  in ge_process_schedule.process_schedule_id%type) IS
 /*****************************************************************
  Propiedad intelectual de GDC

  Unidad         : LDCGPAD
  Descripcion    : proceso que se encarga de programar el PB LDCGPAD
  Autor          : Luis Javier Lopez Barrios / Horbath
  Fecha          : 05/12/2022

  Parametros              Descripcion
  ============         ===================
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
 nuHilos          NUMBER := 1;
 nuLogProceso     ge_log_process.log_process_id%TYPE;
 nutsess          NUMBER;
 sbparuser        VARCHAR2(30);
 nuerror          NUMBER;
 sbError          VARCHAR2(4000);
 nuvaano          NUMBER(4);
 nuvames          NUMBER(2);
 
 CURSOR cugetContratos IS
 SELECT *
 FROM ldc_contabdi;
 
BEGIN
  ge_boschedule.AddLogToScheduleProcess(inuProgramacion,nuHilos,nuLogProceso);
   
  SELECT USERENV('SESSIONID'), USER, TO_CHAR(SYSDATE, 'YYYY'),TO_CHAR(SYSDATE, 'MM')  
        INTO nutsess,sbparuser, nuvaano, nuvames
  FROM dual;
  ldc_proinsertaestaprog(nuvaano,nuvames,'LDCGPAD','En ejecucion',nutsess,sbparuser);
  LDC_PKGESTIONABONDECONS.nuIdReporte :=  LDC_PKGESTIONABONDECONS.fnuCrReportHeader;
  
  FOR reg IN cugetContratos LOOP
      nuerror := 0;
      LDC_PKGESTIONABONDECONS.prGeneraAbonDiferido( REG.CONTRATO,nuerror, sbError);
      IF nuerror = 0 THEN
         COMMIT;
      ELSE
        LDC_PKGESTIONABONDECONS.nuConsecutivo := LDC_PKGESTIONABONDECONS.nuConsecutivo  + 1;
        LDC_PKGESTIONABONDECONS.crReportDetail(LDC_PKGESTIONABONDECONS.nuIdReporte,
                                               REG.CONTRATO,
                                               sbError,
                                               'S');
        ROLLBACK;
      END IF;
  END LOOP;
  
  ldc_proactualizaestaprog(nutsess,sbError,'LDCGPAD','OK');
  ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
EXCEPTION
 WHEN OTHERS THEN
    Errors.setError;
    Errors.getError(nuerror, sbError);
    ldc_proactualizaestaprog(nutsess,sbError,'LDCGPAD','con errores');
    ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
    RAISE ex.controlled_error;
END LDCGPAD;
/
GRANT EXECUTE ON LDCGPAD TO SYSTEM_OBJ_PRIVS_ROLE
/