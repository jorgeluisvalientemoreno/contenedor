PROMPT Crea Sinonimo a función LDC_CARTASNOTIFICACION
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_CARTASNOTIFICACION FOR ADM_PERSON.LDC_CARTASNOTIFICACION';
END;
/
