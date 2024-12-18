DECLARE

    nuError          NUMBER;
    sbError          VARCHAR2(4000);


    CURSOR cuDBA_SYNONYMS
    IS
    select unique 'PERSONALIZACIONES' OWNER, object_name
    from dba_objects s
    where s.owner = 'OPEN'
    and s.object_type <> 'SYNONYM'
    and s.object_type not in ('TABLE', 'VIEW')
    --Objetos de OPEN que tenga sinonimo en PERSONALIZACIONES
    and exists (select 'x' from dba_objects o where owner = 'PERSONALIZACIONES' and s.object_name = o.object_name and o.object_type = 'SYNONYM')
    --Objetos de OPEN sin dependencias en el esquema PERSONALIZACIONES
    and not exists (select 'x' from dba_dependencies where referenced_name = s.object_name and owner = 'PERSONALIZACIONES' and name <> referenced_name);   

    sbSentencia     VARCHAR2(4000);
    
begin

    FOR rcSinonimo IN cuDBA_SYNONYMS LOOP
    
        BEGIN
            sbSentencia := 'DROP SYNONYM  '  || rcSinonimo.OWNER || '.' || rcSinonimo.object_name;
            
            EXECUTE IMMEDIATE sbSentencia ;
            
            dbms_output.put_line ( 'Se ejecutó [' || sbSentencia || ']' ); 
            
            EXCEPTION WHEN OTHERS THEN
                dbms_output.put_line ( 'ERROR [' || sbSentencia || '][' || SQLERRM || ']' );             
            
        END;

    END LOOP;
    
    
    EXCEPTION
        WHEN OTHERS THEN        
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            dbms_output.put_line('sbError => ' || sbError );
            RAISE pkg_error.Controlled_Error;
END;
/