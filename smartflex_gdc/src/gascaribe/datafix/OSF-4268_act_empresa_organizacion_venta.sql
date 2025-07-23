DECLARE
    -- OSF-4268
BEGIN
    -- GDC1 para la empresa GDCA y valor GDG1 para la empresa GDGU
    UPDATE multiempresa.empresa
    SET organizacion_venta = CASE codigo
                                WHEN 'GDCA' THEN 
                                    'GDC1' 
                                WHEN 'GDGU' THEN  
                                     'GDG1'
                                 ELSE NULL END;

    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE( 'INFO[ OK UPDATE multiempresa.empresa.organizacion_venta]');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE( 'ERROR[UPDATE multiempresa.empresa.organizacion_venta][' || SQLERRM || ']');
        ROLLBACK;        
END;
/