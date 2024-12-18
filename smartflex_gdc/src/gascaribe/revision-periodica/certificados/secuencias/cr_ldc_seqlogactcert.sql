DECLARE
	CURSOR cuTabla(sbTable IN VARCHAR2) IS
		SELECT 	*
		FROM 	all_sequences
		WHERE 	upper(SEQUENCE_NAME) = upper(sbTable);
		
	rccuTabla cuTabla%ROWTYPE;
BEGIN
	OPEN cuTabla('LDC_SEQLOGACTCERT');
	FETCH cuTabla INTO rccuTabla;
	
	IF (cuTabla%NOTFOUND) THEN
		EXECUTE IMMEDIATE 'create sequence LDC_SEQLOGACTCERT
		minvalue 1
		maxvalue 999999999999999
		start with 1
		increment by 1
		nocache';
	END IF;
	
	CLOSE cuTabla;
END;
/