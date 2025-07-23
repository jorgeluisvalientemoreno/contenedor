DECLARE

    -- OSF-4245    
    sbParametro LDCI_CARASEWE.casecodi%TYPE := 'PREFIJO_LDC';
    
    CURSOR cuServWeb
    IS
    SELECT 'WS_TRASLADO_MATERIALES' ServWeb FROM DUAL
    UNION ALL
    SELECT 'WS_RESERVA_MATERIALES' ServWeb FROM DUAL;
    
    CURSOR cuLDCI_CARASEWE( isbServWeb VARCHAR2)
    IS
    SELECT a.rowid rId
    FROM LDCI_CARASEWE a
    WHERE casedese = isbServWeb
    AND casecodi = sbParametro;
    
    rcLDCI_CARASEWE cuLDCI_CARASEWE%ROWTYPE;

BEGIN

    FOR rgServWeb IN cuServWeb LOOP
    
        rcLDCI_CARASEWE := NULL;
    
        OPEN cuLDCI_CARASEWE(rgServWeb.ServWeb);
        FETCH cuLDCI_CARASEWE INTO rcLDCI_CARASEWE;
        CLOSE cuLDCI_CARASEWE;

        IF rcLDCI_CARASEWE.rId IS NOT NULL THEN
                
            DELETE LDCI_CARASEWE           
            WHERE rowId = rcLDCI_CARASEWE.rId;
            
            COMMIT;
            
            DBMS_OUTPUT.PUT_LINE( 'INFO[Ok se borró en LDCI_CARASEWE parámetro[' || sbParametro || ']Servicio Web[' || rgServWeb.ServWeb || ']' );
        
        ELSE

            DBMS_OUTPUT.PUT_LINE( 'INFO[No existe en LDCI_CARASEWE parámetro[' || sbParametro || ']Servicio Web[' || rgServWeb.ServWeb || ']' );
        
        END IF;

        
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE( 'ERROR[' || sqlErrm || ']' );
        ROLLBACK;
END;
/