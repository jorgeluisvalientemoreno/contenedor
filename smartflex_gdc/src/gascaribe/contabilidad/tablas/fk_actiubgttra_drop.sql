DECLARE
    -- OSF-4558
    PROCEDURE pExecImm( isbSent VARCHAR2) IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSent;

        DBMS_OUTPUT.PUT_LINE( 'INFO[' || isbSent || '][OK]' );
                
        EXCEPTION WHEN OTHERS THEN        
            DBMS_OUTPUT.PUT_LINE( 'ERROR[' || isbSent || '][' || sqlerrm || ']' );
            RAISE;
        
    END pExecImm;
BEGIN
    pExecImm('ALTER TABLE OPEN.ldci_actiubgttra DROP CONSTRAINT fk_actiubgttra');
END;
/