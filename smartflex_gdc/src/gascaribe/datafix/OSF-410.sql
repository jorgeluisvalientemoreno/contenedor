DECLARE
    nuErrorCode 	NUMBER;
    sbErrorMessage 	VARCHAR2(4000);
	
	PROCEDURE RECOVERRETAINEDINSTANCES
    IS
		NUINSTANCE 		WF_EXCEPTION_LOG.INSTANCE_ID%TYPE;
		RCGELOGTRACE 	DAGE_LOG_TRACE.STYGE_LOG_TRACE;
		
		CNUEXCEPTIONTYPE 	CONSTANT NUMBER( 4 ) := 15;
		CNUACTIVEEXCSTATUS 	CONSTANT NUMBER( 2 ) := 1;
		
		CURSOR CUEXCEPTIONS IS
			SELECT /*+index(a IDX_WF_EXCEPTION_LOG) */
					a.instance_id
			FROM 	wf_exception_log a
			WHERE 	exception_type_id = cnuEXCEPTIONTYPE
			AND    	status = cnuACTIVEEXCSTATUS
			AND 	instance_id < 0;
	BEGIN
		OPEN CUEXCEPTIONS;
		
		LOOP
			FETCH CUEXCEPTIONS INTO NUINSTANCE;
			EXIT WHEN CUEXCEPTIONS%NOTFOUND;
			WF_BOEIFINSTANCE.RECOVERRETAINEDINSTANCE( NUINSTANCE );
		END LOOP;
		
		CLOSE CUEXCEPTIONS;
		
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			IF ( CUEXCEPTIONS%ISOPEN ) THEN
				CLOSE CUEXCEPTIONS;
			END IF;
			RAISE EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			IF ( CUEXCEPTIONS%ISOPEN ) THEN
				CLOSE CUEXCEPTIONS;
			END IF;
			RAISE EX.CONTROLLED_ERROR;
	END RECOVERRETAINEDINSTANCES;

BEGIN

    RECOVERRETAINEDINSTANCES;

EXCEPTION
    WHEN ex.CONTROLLED_ERROR  THEN
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
    WHEN OTHERS THEN
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;
/