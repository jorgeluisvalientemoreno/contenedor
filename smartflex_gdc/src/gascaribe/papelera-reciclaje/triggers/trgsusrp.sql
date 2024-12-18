DECLARE

    -- OSF-3516
    csbObjeto        CONSTANT VARCHAR2(70) :=   upper('trgsusrp');
    csbEsquema       CONSTANT VARCHAR2(30) :=   'OPEN';
    csbTipoObjeto    CONSTANT VARCHAR2(30) :=   'TRIGGER';
              
    nuError          NUMBER;
    sbError          VARCHAR2(4000);
    
    CURSOR cuDBA_Objects
    IS
    SELECT *
    FROM DBA_Objects
    WHERE owner = UPPER(csbEsquema) 
    AND object_name = UPPER(csbObjeto)
    AND object_type = UPPER(csbTipoObjeto);   

    TYPE tyDBA_Objects IS TABLE OF cuDBA_Objects%ROWTYPE INDEX BY BINARY_INTEGER;
    tbDBA_Objects tyDBA_Objects;
    
    PROCEDURE prcExeImm( isbSent VARCHAR2)
    IS
    BEGIN

        EXECUTE IMMEDIATE isbSent;
        dbms_output.put_line('Ok Sentencia[' || isbSent || ']');
                
        EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('Error Sentencia[' || isbSent || '][' || sqlerrm || ']');
    END prcExeImm;

begin


    OPEN cuDBA_Objects;
    FETCH cuDBA_Objects BULK COLLECT INTO tbDBA_Objects;
    CLOSE cuDBA_Objects;

    IF tbDBA_Objects.COUNT > 0 THEN
        FOR indtb IN 1..tbDBA_Objects.COUNT LOOP
            prcExeImm('DROP ' || tbDBA_Objects(indtb).OBJECT_TYPE ||' '||  tbDBA_Objects(indtb).Owner || '.' ||  tbDBA_Objects(indtb).Object_Name);     
        END LOOP;
    ELSE
        dbms_output.put_line('No existe [' || csbEsquema || '.' || csbObjeto || ']');    
    END IF;
    
    
    EXCEPTION
        WHEN OTHERS THEN        
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            dbms_output.put_line('sbError => ' || sbError );
            RAISE pkg_error.Controlled_Error;
END;
/