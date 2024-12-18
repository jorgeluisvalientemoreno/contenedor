create or replace PROCEDURE LDCPAVEN(inuProgramacion in ge_process_schedule.process_schedule_id%type) IS
/*****************************************************************
  Unidad         : LDCPAVEN
  Descripcion    : metodo del Proceso Batch LDCPAVEN para registro de ventas de anuladas 
  Fecha          : 25/07/2022
  Autor          : Luis Javier Lopez Barrios

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  sbParametros    GE_PROCESS_SCHEDULE.PARAMETERS_%type;
  sbDIRECTORY_ID  ge_boInstanceControl.stysbValue;
  sbFILE_NAME     ge_boInstanceControl.stysbValue;
  SBPATHFILE      GE_DIRECTORY.PATH%TYPE;


BEGIN
  UT_TRACE.TRACE('[LDCPAVEN] INICIO',3);
  sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);

  sbDIRECTORY_ID := ut_string.getparametervalue(sbParametros, 'DIRECTORY_ID', '|', '=');
  sbFILE_NAME := ut_string.getparametervalue(sbParametros, 'FILE_NAME', '|', '=');
  SBPATHFILE := DAGE_DIRECTORY.FSBGETPATH( sbDIRECTORY_ID );

  ldc_pkgestionAnulaVenta.LDCPRGENANUVENTA(SBPATHFILE,sbFILE_NAME);
  COMMIT;
  UT_TRACE.TRACE('[LDCPAVEN] FIN',3);
EXCEPTION
WHEN EX.CONTROLLED_ERROR THEN
	ROLLBACK;
	RAISE EX.CONTROLLED_ERROR;
WHEN OTHERS THEN
	ROLLBACK;
	ERRORS.SETERROR;
	RAISE EX.CONTROLLED_ERROR;
END;
/
grant execute on LDCPAVEN to SYSTEM_OBJ_PRIVS_ROLE;
/