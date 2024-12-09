declare
    sbIdentificacion VARCHAR2(100) := '125856789';
    nuModDigitoVer VARCHAR2(100);
    nuDigVerCalculado number;
begin
    nuModDigitoVer :=  MOD(CAST(SUBSTR(sbIdentificacion, 1, 1) AS NUMBER) * 41 +
                        CAST(SUBSTR(sbIdentificacion, 2, 1) AS NUMBER) * 37 +
                        CAST(SUBSTR(sbIdentificacion, 3, 1) AS NUMBER) * 29 +
                        CAST(SUBSTR(sbIdentificacion, 4, 1) AS NUMBER) * 23 +
                        CAST(SUBSTR(sbIdentificacion, 5, 1) AS NUMBER) * 19 +
                        CAST(SUBSTR(sbIdentificacion, 6, 1) AS NUMBER) * 17 +
                        CAST(SUBSTR(sbIdentificacion, 7, 1) AS NUMBER) * 13 +
                        CAST(SUBSTR(sbIdentificacion, 8, 1) AS NUMBER) * 7 +
                        CAST(SUBSTR(sbIdentificacion, 9, 1) AS NUMBER) * 3, 11);
        
    IF nuModDigitoVer IN (0, 1) THEN
    nuDigVerCalculado := nuModDigitoVer;
    ELSE   
    nuDigVerCalculado := 11 - nuModDigitoVer;
    END IF; 
    DBMS_OUTPUT.PUT_LINE('nuDigVerCalculado: '||nuDigVerCalculado);
end;
