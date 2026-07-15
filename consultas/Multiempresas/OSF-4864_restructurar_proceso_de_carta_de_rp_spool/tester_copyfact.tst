PL/SQL Developer Test script 3.0
25
DECLARE
    
    onuCodError     NUMBER;
    osbMensError    VARCHAR2(4000);
    
BEGIN

    UPDATE LDC_PECOFACT c
    SET PCFAESTA = 'N',
    PCFAFEPR = NULL
    WHERE PCFAPEFA IN (117837);
    
    COMMIT;

    LDC_PKGGCMA.PRPROCOPYFACT;
    
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR CONTR|' || osbMensError);
        when others then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR NCONT|' || osbMensError );
END;
0
0
