DECLARE

  nuconta NUMBER;
  nuErrorCode NUMBER;
  sbErrorMessage VARCHAR2(4000);
  
BEGIN

    
	dbms_output.put_Line('INICIO');
	dbms_output.put_Line('-------------------------------------');
	
    SELECT COUNT(*) INTO nuconta
    FROM Dba_tables
    WHERE TABLE_NAME = UPPER('HOMOCONCEPTO') ;
	
	
	IF nuconta = 0 THEN 
      
		dbms_output.put_line('Creando tabla HOMOLOGACION.HOMOCONCEPTO');
		-- Create table
	    EXECUTE IMMEDIATE  'CREATE TABLE HOMOLOGACION.HOMOCONCEPTO (
							CONCCODI	NUMBER(10),
							CONCHOMO	NUMBER(10)						
							)';
							
		-- Add comments to the table							
		EXECUTE IMMEDIATE 'COMMENT ON TABLE HOMOLOGACION.HOMOCONCEPTO IS ''HOMOLOGACION CONCEPTOS GASPLUS OSF''';					
							
		-- Add comments to the columns 
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOCONCEPTO.CONCCODI IS ''CODIGO CONCEPTO GASPLUS''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOCONCEPTO.CONCHOMO IS ''CODIGO CONCEPTO HOMOLOGADO''';


    END IF;
    dbms_output.put_Line('-------------------------------------');
    dbms_output.put_Line('FIN');


EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('ERROR: ' || SQLERRM);
    ROLLBACK;
	
END;
/