DECLARE

    -- OSF-3956    
    nuContador      NUMBER := 1;
    
    nuUltContrato   NUMBER := -1;
    
    sbEmpresa   VARCHAR2(10);
        
    CURSOR cuContratosGdC( inuUltContrato NUMBER )
    IS
    SELECT *
    FROM suscripc sc
    WHERE sc.susccodi  > inuUltContrato
    ORDER BY sc.susccodi;
    
    TYPE tytbContratosGdC IS TABLE OF cuContratosGdC%ROWTYPE INDEX BY BINARY_INTEGER;
    
    tbContratosGdC  tytbContratosGdC;

    CURSOR cuProducto( inuContrato NUMBER )
    IS
    SELECT PKG_BCDIRECCIONES.fnuGetDepartamento( pr.address_id ) Departamento
    FROM pr_product pr
    WHERE pr.subscription_id = inuContrato
    AND pr.product_type_id <> 3
    AND ROWNUM < 2    
    ;
    
    rcProducto  cuProducto%ROWTYPE;
        
    FUNCTION fnuUltContrato RETURN NUMBER
    IS
        CURSOR cuUltCont
        IS
        SELECT MAX(CONTRATO)
        FROM contrato;
        
        nuUltCont   NUMBER;
        
    BEGIN
    
        OPEN cuUltCont;
        FETCH cuUltCont INTO nuUltCont;
        CLOSE cuUltCont;
        
        RETURN NVL(nuUltCont,-1);
    
    END fnuUltContrato;
    
                
BEGIN
    
    nuUltContrato := fnuUltContrato;

    LOOP
    
        tbContratosGdC.DELETE;
        
        OPEN cuContratosGdC( nuUltContrato );
        FETCH cuContratosGdC BULK COLLECT INTO tbContratosGdC LIMIT 5000; -- 50000/minuto
        CLOSE cuContratosGdC;
        
        EXIT WHEN tbContratosGdC.COUNT = 0;
        
        FOR indtbContr IN 1..tbContratosGdC.COUNT LOOP
        
            IF NOT pkg_Contrato.fblExiste( tbContratosGdC(indtbContr).susccodi ) THEN
            
                rcProducto := NULL;
            
                OPEN cuProducto( tbContratosGdC(indtbContr).susccodi );
                FETCH cuProducto INTO rcProducto;
                CLOSE cuProducto;
                
                IF rcProducto.Departamento IS NOT NULL THEN
                
                    sbEmpresa := pkg_empresa.fsbObtEmpresaDepartamento( rcProducto.Departamento );
                
                    IF sbEmpresa IS NOT NULL THEN
                                        
                        pkg_Contrato.prInsRegistro
                        (
                            inuContrato =>  tbContratosGdC(indtbContr).susccodi ,
                            isbEmpresa  =>  sbEmpresa
                        );
                        
                    END IF;
                    
                END IF;
                
            END IF;
                    
        END LOOP;
        
        COMMIT;
        
        nuUltContrato :=  tbContratosGdC(tbContratosGdC.COUNT).susccodi;
                
        nuContador := nuContador + 1;
            
    END LOOP;
    
END;
/