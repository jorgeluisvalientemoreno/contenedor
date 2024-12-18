CREATE OR REPLACE PROCEDURE LDC_DIFEAPM(inuProgramacion in ge_process_schedule.process_schedule_id%type) IS
/*****************************************************************
  Unidad         : LDC_DIFEAPM
  Descripcion    : Metodo del Proceso Batch LDC_DIFEAPM para pasar deuda diferia a presente de acuerdo a 
                   los productos que estan en el archivo plano.
  Fecha          : 01/12/2022

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  sbParametros    GE_PROCESS_SCHEDULE.PARAMETERS_%type;
  sbDIRECTORY_ID  ge_boInstanceControl.stysbValue;
  sbFILE_NAME     ge_boInstanceControl.stysbValue;
  SBPATHFILE      GE_DIRECTORY.PATH%TYPE;
  NUPERSONID      GE_PERSON.PERSON_ID%TYPE;

BEGIN
  UT_TRACE.TRACE('[LDC_DIFEAPM] INICIO',3);
  sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);
  sbDIRECTORY_ID := ut_string.getparametervalue(sbParametros, 'DIRECTORY_ID', '|', '=');
  sbFILE_NAME := ut_string.getparametervalue(sbParametros, 'FILE_NAME', '|', '=');
  SBPATHFILE := DAGE_DIRECTORY.FSBGETPATH( sbDIRECTORY_ID );
  NUPERSONID:=GE_BOPERSONAL.FNUGETPERSONID;
  LDC_PASADIFEAPMPLANO(SBPATHFILE,sbFILE_NAME,NUPERSONID);
  COMMIT;
  UT_TRACE.TRACE('[LDC_DIFEAPM] FIN',3);
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
