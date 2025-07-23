DECLARE

    -- OSF-4264
    CURSOR cuGe_Items
    IS
    SELECT items_id Material,
    'GDCA' Empresa,
    CASE 
        WHEN SUBSTR(items_id,1,1) = 4 THEN
            'N'
        WHEN items_id IN (100003008,100003011) THEN
            'N'
        WHEN obsoleto IS NULL THEN
            'S'
        WHEN obsoleto = 'S' THEN
            'N'
        WHEN obsoleto = 'N' THEN
            'S'
    END Habilitado
    FROM ge_items it
    WHERE items_id > 0
    AND it.ITEM_CLASSIF_ID IN (3,8,21);
    
    TYPE tytbGe_Items IS TABLE OF cuGe_Items%ROWTYPE INDEX BY BINARY_INTEGER;
    
    tbGe_Items tytbGe_Items;
    
    nuCantidadInsertados    NUMBER  := 0;
    nuCantidadExistentes    NUMBER  := 0;
    nuCantidadError         NUMBER  := 0;

BEGIN

    OPEN cuGe_Items;
    
    LOOP 
        
        tbGe_Items.DELETE;
        
        FETCH cuGe_Items BULK COLLECT INTO tbGe_Items LIMIT 1000;
    
        EXIT WHEN tbGe_Items.COUNT = 0;

        FOR indtb IN 1..tbGe_Items.COUNT LOOP
        
            BEGIN
            
                INSERT INTO multiempresa.materiales
                (
                    MATERIAL,
                    EMPRESA,
                    HABILITADO
                )
                VALUES
                (
                    tbGe_Items(indtb).MATERIAL,
                    tbGe_Items(indtb).EMPRESA,
                    tbGe_Items(indtb).HABILITADO                    
                ); 
                  
                nuCantidadInsertados := nuCantidadInsertados + 1; 

                EXCEPTION
                    WHEN DUP_VAL_ON_INDEX THEN
                        nuCantidadExistentes := nuCantidadExistentes + 1; 
                    WHEN OTHERS THEN
                        nuCantidadError :=  nuCantidadError + 1;
                        dbms_output.put_line( 'ERROR INSERT MATERIAL[' || tbGe_Items(indtb).MATERIAL || '][' || SQLERRM || ']');
            END;
            
            COMMIT;
                            
        END LOOP;
        
    END LOOP;
    
    CLOSE cuGe_Items;

    dbms_output.put_line( 'INFO[Ya existian ' || nuCantidadExistentes || ']');   
    dbms_output.put_line( 'INFO[Se insertaron ' || nuCantidadInsertados || ']');   
    dbms_output.put_line( 'INFO[Cantidad con error ' || nuCantidadError || ']');   
    

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( 'ERROR[' || SQLERRM || ']');    
END;
/