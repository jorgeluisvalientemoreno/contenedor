DECLARE 

    CURSOR cuQueryIndex 
    IS
    SELECT  COUNT('X')
    FROM    all_indexes
    WHERE   index_name = 'IDX_LDC_ORDER_03';

    nuCount NUMBER;
BEGIN

    nuCount := 0;

    OPEN cuQueryIndex;
    FETCH cuQueryIndex INTO nuCount;
    CLOSE cuQueryIndex;

    IF nuCount = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX OPEN.IDX_LDC_ORDER_03 ON OPEN.LDC_ORDER (PACKAGE_ID)';
    END IF;
END;
/