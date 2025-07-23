DECLARE
BEGIN
    -- OSF-4259
    UPDATE ldci_motipedi
    SET empresa =   CASE MOPECODI 
                        WHEN 100  THEN 
                            'GDGU'
                        WHEN 110 THEN
                            'GDGU'
                        WHEN 104 THEN
                            NULL
                        ELSE
                            'GDCA'
                    END;

    UPDATE ldci_motipedi
    SET MOPECLDO = 'ZRMT'
    WHERE MOPECODI = 100;

    UPDATE ldci_motipedi
    SET MOPECLDO = 'ZGME'
    WHERE MOPECODI = 110;    
    
    COMMIT;          

END;
/