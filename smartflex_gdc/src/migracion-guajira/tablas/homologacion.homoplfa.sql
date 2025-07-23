DECLARE

  nuconta NUMBER;
  nuErrorCode NUMBER;
  sbErrorMessage VARCHAR2(4000);
  
BEGIN

    
	dbms_output.put_Line('INICIO');
	dbms_output.put_Line('-------------------------------------');
	
    SELECT COUNT(*) INTO nuconta
    FROM Dba_tables
    WHERE TABLE_NAME = UPPER('HOMOPLFA') ;
	
	
	IF nuconta = 0 THEN 
      
		dbms_output.put_line('Creando tabla HOMOLOGACION.HOMOPLFA');
		-- Create table
	    EXECUTE IMMEDIATE  'CREATE TABLE HOMOLOGACION.HOMOPLFA (
							PLSUCODI	NUMBER(10),
							PLFAHOMO	NUMBER(10)						
							)';
							
		-- Add comments to the table							
		EXECUTE IMMEDIATE 'COMMENT ON TABLE HOMOLOGACION.HOMOPLFA IS ''HOMOLOGACION PLAN FACTURACION GASPLUS OSF''';					
							
		-- Add comments to the columns 
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOPLFA.PLSUCODI IS ''CODIGO PLAN SUSCRIPCION GASPLUS''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOPLFA.PLFAHOMO IS ''CODIGO PLAN FACTURACION HOMOLOGADO''';


    END IF;
    dbms_output.put_Line('-------------------------------------');
    dbms_output.put_Line('FIN');


EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('ERROR: ' || SQLERRM);
    ROLLBACK;
	
END;
/