COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX');
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

DECLARE
    nuCant NUMBER;
BEGIN

    -- Corregir campo de documento soporte en los memorandos que hicieron en diciembre
    -- Barranquilla
    update open.cargos c
       set cargdoso = 'PP-198775030'
     where cargnuse =  52615547
       and cargdoso =  'PP-24006956'
       and cargfecr >= '27-12-2024'
       and cargfecr <  '28-12-2024'
       and cargtipr =  'A';
        
    nuCant := SQL%ROWCOUNT;
    
    if nuCant > 0 then    
        DBMS_OUTPUT.PUT_LINE('Se ajusta el CARGDOSO del producto 52615547, de PP-24006956 a PP-198775030. Cantidad: '||SQL%ROWCOUNT);  
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se encontraron cargos para ajustar para el producto 52615547');  
    END IF;
    
    commit;
    
    -----------------
    update open.cargos c
       set cargdoso = 'PP-194066594'
     where cargnuse =  52538094
       and cargdoso =  'PP-24006956'
       and cargfecr >= '27-12-2024'
       and cargfecr <  '28-12-2024'
       and cargtipr =  'A';
          
    nuCant := SQL%ROWCOUNT;
    
    if nuCant > 0 then     
        DBMS_OUTPUT.PUT_LINE('Se ajusta el CARGDOSO del producto 52538094, de PP-24006956 a PP-194066594. Cantidad: '||SQL%ROWCOUNT);   
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se encontraron cargos para ajustar para el producto 52538094');  
    END IF;
    
    commit;
    
    -----------------
    update open.cargos c
       set cargdoso = 'PP-195160412'
     where cargnuse =  52554594
       and cargdoso =  'PP-24006956'
       and cargfecr >= '27-12-2024'
       and cargfecr <  '28-12-2024'
       and cargtipr =  'A';
        
    nuCant := SQL%ROWCOUNT;
    
    if nuCant > 0 then     
        DBMS_OUTPUT.PUT_LINE('Se ajusta el CARGDOSO del producto 52554594, de PP-24006956 a PP-195160412. Cantidad: '||SQL%ROWCOUNT); 
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se encontraron cargos para ajustar para el producto 52554594');  
    END IF;
    
    commit;
    
    -----------------
    update open.cargos c
       set cargdoso = 'PP-193875743'
     where cargnuse =  52535322
       and cargdoso =  'PP-24006956'
       and cargfecr >= '27-12-2024'
       and cargfecr <  '28-12-2024'
       and cargtipr =  'A';
            
    nuCant := SQL%ROWCOUNT;
    
    if nuCant > 0 then    
        DBMS_OUTPUT.PUT_LINE('Se ajusta el CARGDOSO del producto 52535322, de PP-24006956 a PP-193875743. Cantidad: '||SQL%ROWCOUNT);    
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se encontraron cargos para ajustar para el producto 52535322');  
    END IF;
    
    commit;
    
    -----------------
    update open.cargos c
       set cargdoso = 'PP-193125608'
     where cargnuse =  52518526
       and cargdoso =  'PP-24006956'
       and cargfecr >= '27-12-2024'
       and cargfecr <  '28-12-2024'
       and cargtipr =  'A';
        
    nuCant := SQL%ROWCOUNT;
    
    if nuCant > 0 then     
        DBMS_OUTPUT.PUT_LINE('Se ajusta el CARGDOSO del producto 52518526, de PP-24006956 a PP-193125608. Cantidad: '||SQL%ROWCOUNT);   
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se encontraron cargos para ajustar para el producto 52518526');  
    END IF;      
    
    commit;
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error[' || sqlerrm || ']');
        ROLLBACK;  
END;
/

SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
SET SERVEROUTPUT OFF
QUIT
/