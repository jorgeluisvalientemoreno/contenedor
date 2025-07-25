DECLARE

  nuconta NUMBER;
  nuErrorCode NUMBER;
  sbErrorMessage VARCHAR2(4000);

BEGIN


	dbms_output.put_Line('INICIO');
	dbms_output.put_Line('-------------------------------------');

    SELECT COUNT(*) INTO nuconta
    FROM Dba_tables
    WHERE TABLE_NAME = UPPER('HOMOUBGE') ;


	IF nuconta = 0 THEN 

		dbms_output.put_line('Creando tabla HOMOUBGE');
		-- Create table
	    EXECUTE IMMEDIATE  'CREATE TABLE HOMOLOGACION.HOMOUBGE (
							DEPACODI	NUMBER(4),
							LOCACODI	NUMBER(6),
							CODIGO		NUMBER(4),
							GEOGRAP_LOCATION_ID	NUMBER(6),
							TIPO		VARCHAR2(100)
							)';

		-- Add comments to the table							
		EXECUTE IMMEDIATE 'COMMENT ON TABLE HOMOLOGACION.HOMOUBGE IS ''HOMOLOGACION UBICACIONES GEOGRAFICAS GASPLUS OSF''';					

		-- Add comments to the columns 
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOUBGE.DEPACODI IS ''CODIGO DEPARTAMENNTO GASPLUS''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOUBGE.LOCACODI IS ''CODIGO LOCALIDAD GASPLUS''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOUBGE.CODIGO IS ''CODIGO DEL SECTOR OPERATIVO O BARRIO GASPLUS''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOUBGE.TIPO IS ''TIPO DE LA UBICACION GEOGRAFICA''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOUBGE.GEOGRAP_LOCATION_ID IS ''CODIGO OSF HOMOLOGADO''';


    END IF;
    dbms_output.put_Line('-------------------------------------');
    dbms_output.put_Line('FIN');


EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('ERROR: ' || SQLERRM);
    ROLLBACK;

END;
/