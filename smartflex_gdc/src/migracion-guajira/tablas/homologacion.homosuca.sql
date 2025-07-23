DECLARE

  nuconta NUMBER;
  nuErrorCode NUMBER;
  sbErrorMessage VARCHAR2(4000);
  
BEGIN

    
	dbms_output.put_Line('INICIO');
	dbms_output.put_Line('-------------------------------------');
	
    SELECT COUNT(*) INTO nuconta
    FROM Dba_tables
    WHERE TABLE_NAME = UPPER('HOMOSUCA') ;
	
	
	IF nuconta = 0 THEN 
      
		dbms_output.put_line('Creando tabla HOMOLOGACION.HOMOSUCA');
		-- Create table
	    EXECUTE IMMEDIATE  'CREATE TABLE HOMOLOGACION.HOMOSUCA (
							SUCACODI	NUMBER(4),
							SUCAHOMO	NUMBER(4)						
							)';
							
		-- Add comments to the table							
		EXECUTE IMMEDIATE 'COMMENT ON TABLE HOMOLOGACION.HOMOSUCA IS ''HOMOLOGACION SUBCATEGORIAS GASPLUS OSF''';					
							
		-- Add comments to the columns 
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOSUCA.SUCACODI IS ''CODIGO SUBCATEGORIA GASPLUS''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOSUCA.SUCAHOMO IS ''CODIGO SUBCATEGORIA HOMOLOGADO''';


    END IF;
    dbms_output.put_Line('-------------------------------------');
    dbms_output.put_Line('FIN');


EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('ERROR: ' || SQLERRM);
    ROLLBACK;
	
END;
/