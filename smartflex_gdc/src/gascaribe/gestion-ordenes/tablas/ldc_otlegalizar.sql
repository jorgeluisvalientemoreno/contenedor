DECLARE
    nuconta NUMBER;
    nuContarConstraint NUMBER;

    CURSOR cuConstraint
    (
        sbConstraint  IN  VARCHAR2
    )
    IS
    SELECT  COUNT(1)
    FROM    all_constraints 
    WHERE   constraint_name = upper(sbConstraint);

BEGIN
    SELECT COUNT(1) INTO nuconta
    FROM DBA_TABLES
    WHERE TABLE_NAME = 'LDC_OTLEGALIZAR';
    
    IF nuconta != 0 THEN  

        OPEN cuConstraint ('ch_ldc_otlegalizar_01');
        FETCH cuConstraint INTO nuContarConstraint;
        CLOSE cuConstraint;
        
        IF (nuContarConstraint = 0) THEN
            EXECUTE IMMEDIATE 'ALTER TABLE ldc_otlegalizar MODIFY EXEC_INITIAL_DATE CONSTRAINT ch_ldc_otlegalizar_01 NOT NULL'  ;  
        END IF;

        OPEN cuConstraint ('ch_ldc_otlegalizar_02');
        FETCH cuConstraint INTO nuContarConstraint;
        CLOSE cuConstraint;

        IF (nuContarConstraint = 0) THEN
            EXECUTE IMMEDIATE 'ALTER TABLE ldc_otlegalizar MODIFY EXEC_FINAL_DATE CONSTRAINT ch_ldc_otlegalizar_02 NOT NULL'  ;  
        END IF;

        OPEN cuConstraint ('ch_ldc_otlegalizar_03');
        FETCH cuConstraint INTO nuContarConstraint;
        CLOSE cuConstraint;

        IF (nuContarConstraint = 0) THEN
            EXECUTE IMMEDIATE 'ALTER TABLE ldc_otlegalizar MODIFY FECHA_REGISTRO CONSTRAINT ch_ldc_otlegalizar_03 NOT NULL';  
        END IF;
    END IF;	

END;
/