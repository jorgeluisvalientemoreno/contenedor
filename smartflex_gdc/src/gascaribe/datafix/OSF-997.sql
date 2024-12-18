DECLARE
    nuErrorCode 	NUMBER;
    sbErrorMessage 	VARCHAR2(4000);
    SBCOMMENT       VARCHAR2(4000) := 'SE ANULA ORDEN SEGUN CASO OSF-997';
    nuCommentType   number:=1277;
    nuPlanId 	NUMBER;
BEGIN
    dbms_output.put_line('Inicia anulación de orden: '||270833369);
    or_boanullorder.anullorderwithoutval(270833369, SYSDATE);

    OS_ADDORDERCOMMENT (270833369, nuCommentType, SBCOMMENT, nuErrorCode, sbErrorMessage);    

    -- Se obtiene el plan de wf
    nuPlanId := wf_boinstance.fnugetplanid(194882188, 17);
    -- anula el plan de wf
    mo_boannulment.annulwfplan(nuPlanId);  

    If nuErrorCode = 0 then
           pkgeneralservices.committransaction;
    Else
           rollback;
           dbms_output.put_line('Error en Orden 270833369 Error : ' || sbErrorMessage);
    End if;

    dbms_output.put_line('Termina anulación de orden: '||270833369);
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