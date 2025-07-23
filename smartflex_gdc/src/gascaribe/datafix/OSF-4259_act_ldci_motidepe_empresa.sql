DECLARE
    
    PROCEDURE prcInsLdci_motidepe
    (
        inuMDPECODI NUMBER,
        isbMDPEDESC VARCHAR2,
        isbMDPECLDO VARCHAR2,
        isbEMPRESA  VARCHAR2          
    )
    IS
    BEGIN
    
        INSERT INTO ldci_motidepe
        (
            MDPECODI,
            MDPEDESC,
            MDPECLDO,
            EMPRESA
        )
        VALUES
        (
            inuMDPECODI ,
            isbMDPEDESC ,
            isbMDPECLDO ,
            isbEMPRESA      
        );

        dbms_output.put_line( 'INFO[Ok insert MDPECODI = ' || inuMDPECODI || ' en ldci_motidepe]' );
        
        COMMIT;
                    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN            
            dbms_output.put_line( 'INFO[Ya existe MDPECODI = ' || inuMDPECODI || ' en ldci_motidepe]' );
    END prcInsLdci_motidepe;
    
BEGIN

    UPDATE ldci_motidepe
    SET empresa = 'GDCA'
    WHERE MDPECODI NOT IN ( 300, 302, 307 )
    AND NVL(empresa,'-') <> 'GDCA';
    
    COMMIT;

    dbms_output.put_line( 'INFO[Ok update ldci_motidepe.empresa = GDCA]' );
        
    prcInsLdci_motidepe
    (
        302,
        'DEVOLUCION DE BIENES POR GARANTIAS',
        'ZRRE',
        'GDGU'
    );

    prcInsLdci_motidepe
    (
        300, 
        'DEVOLUCION DE BIENES INTERNAS Y OTROS', 
        'ZRDC',
        'GDGU'
    );
    
    prcInsLdci_motidepe
    (
        307, 
        'DEVOLUCION DE BIENES POR EXTERNAS', 
        'ZRDE',
        'GDGU'
    );
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( 'ERROR[' || sqlerrm || ']' );        
END;
/