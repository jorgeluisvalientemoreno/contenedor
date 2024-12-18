CREATE OR REPLACE PROCEDURE LDCACTCERT(inuProgramacion in ge_process_schedule.process_schedule_id%TYPE) IS
/*****************************************************************
	Autor       : Carlos Gonzalez / Horbath
    Fecha       : 17/08/2022
    Ticket      : OSF-505
    Descripcion : Procedimiento del Proceso Batch LDCACTCERT para actualizacion de certificados OIA por archivo plano

	Historia de Modificaciones
	Fecha       Ticket		Autor           Modificacion
	==========	=========	=============	====================
	17/08/2022	OSF-505	  	cgonzalez	    Creacion
******************************************************************/
	sbParametros    ge_process_schedule.parameters_%TYPE;
	sbDirectory 	ge_boInstanceControl.stysbValue;
	sbFileName      ge_boInstanceControl.stysbValue;
	sbPathFile      ge_directory.path%TYPE;
BEGIN
	UT_TRACE.TRACE('INICIO LDCACTCERT', 3);
	UT_TRACE.TRACE('inuProgramacion: '||inuProgramacion, 3);
	
	sbParametros 	:= dage_process_schedule.fsbGetParameters_(inuProgramacion);
	sbDirectory 	:= ut_string.getparametervalue(sbParametros, 'DIRECTORY_ID', '|', '=');
	sbFileName 		:= ut_string.getparametervalue(sbParametros, 'DESCRIPTION', '|', '=');
	sbPathFile 		:= dage_directory.fsbgetpath(sbDirectory);
	
	PROCLDCACTCERT(sbPathFile, sbFileName);
	
	COMMIT;
	
	UT_TRACE.TRACE('FIN LDCACTCERT', 3);
EXCEPTION
	WHEN EX.CONTROLLED_ERROR THEN
        UT_TRACE.TRACE('ERROR EX.CONTROLLED_ERROR', 3);
		ROLLBACK;
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
		UT_TRACE.TRACE('ERROR OTHERS', 3);
        ROLLBACK;
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;
/