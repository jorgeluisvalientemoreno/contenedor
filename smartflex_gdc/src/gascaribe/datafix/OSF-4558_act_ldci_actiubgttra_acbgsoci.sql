BEGIN
    -- OSF-4558
    UPDATE ldci_actiubgttra
    SET acbgsoci = 'GDCA'
    WHERE acbgsoci IS NULL;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('INFO[Se actualizo ldci_actiubgttra.acbgsoci]');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR[' || SQLERRM || ']');
        ROLLBACK;        
END;
/