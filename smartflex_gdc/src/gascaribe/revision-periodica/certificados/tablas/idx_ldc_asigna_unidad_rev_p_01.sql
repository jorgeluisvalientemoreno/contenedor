DECLARE

    csbObjeto        CONSTANT VARCHAR2(70) :=   'IDX_LDC_ASIGNA_UNIDAD_REV_P_01';
    csbEsquema       CONSTANT VARCHAR2(30) :=   'OPEN';
    csbTipoObjeto    CONSTANT VARCHAR2(30) :=   'INDEX';
              
    nuError          NUMBER;
    sbError          VARCHAR2(4000);
    
    sbComando       VARCHAR2(4000);
    
    CURSOR cuDBA_Objects
    IS
    SELECT *
    FROM DBA_Objects
    WHERE owner = UPPER(csbEsquema) 
    AND object_name = UPPER(csbObjeto)
    AND object_type = UPPER(csbTipoObjeto)
    AND object_type IN ( 'PACKAGE','PROCEDURE','FUNCTION','TRIGGER','INDEX');   

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
        dbms_output.put_line('Ya existe ' || csbTipoObjeto || ' [' || csbEsquema || '.' || csbObjeto || ']');
    ELSE
        sbComando :=    'CREATE ' || csbTipoObjeto || ' ' || csbEsquema || '.' || csbObjeto || CHR(10) || 
                        ' ON ' || csbEsquema || '.' ||'Ldc_Asigna_Unidad_Rev_Per(Solicitud_Generada) ' || CHR(10) || 
                        ' TABLESPACE TSI_DEFAULT';
        
        
        prcExeImm( sbComando );
        
    END IF;
    
    
    EXCEPTION
        WHEN OTHERS THEN        
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            dbms_output.put_line('sbError => ' || sbError );
            RAISE pkg_error.Controlled_Error;
END;
/