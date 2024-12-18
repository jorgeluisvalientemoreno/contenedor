DECLARE
    nuContador  NUMBER;
BEGIN

    SELECT  COUNT(1) 
    INTO    nuContador
    FROM 	all_indexes
    WHERE   index_name = 'IDX_LD_POLICY_01';
	
	IF (nuContador = 0) THEN
  
		execute immediate 'CREATE INDEX "OPEN"."IDX_LD_POLICY_01" ON "OPEN"."LD_POLICY" (TO_NUMBER(SUBSTR(COLLECTIVE_NUMBER, 3, 4)))';
				
		COMMIT;
	END IF;
END;
/