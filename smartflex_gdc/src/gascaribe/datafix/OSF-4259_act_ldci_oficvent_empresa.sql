BEGIN
    
    -- OSF-4259
    UPDATE ldci_oficvent
    SET empresa = 'GDCA'
    WHERE OFVECODI IN 
    ( 
        'GC01',
        'GC02',
        'GC03'
    )
    AND NVL( empresa, '-') <> 'GDCA' ;
    
    COMMIT;

    DBMS_OUTPUT.PUT_LINE( 'INFO[Ok update en ldci_oficvent.empresa para GC01,GC02,GC03]' ); 
    
    BEGIN
    
        INSERT INTO ldci_oficvent
        (
            OFVECODI,
            OFVEDESC,
            EMPRESA
        )
        VALUES
        (
            'GG01',
            'Sede Admon Riohacha',
            'GDGU'
        );
        
        COMMIT;

        DBMS_OUTPUT.PUT_LINE( 'INFO[Ok insert en ldci_oficvent del registro GG01]' );  
                    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE( 'INFO[Ya existe en ldci_oficvent el registro GG01]' );    
    END;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE( 'ERROR[' || SQLERRM || ']' );         
END;
/