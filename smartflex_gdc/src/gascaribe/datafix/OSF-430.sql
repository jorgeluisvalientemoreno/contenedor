DECLARE
    nuErrorCode 	NUMBER;
    sbErrorMessage 	VARCHAR2(4000);
BEGIN

    or_boanullorder.anullorderwithoutval(228569185, SYSDATE);
	
	update wf_instance
    set status_id = 14
    where parent_external_id = '180126124';
						 
	pkgeneralservices.committransaction;

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