DECLARE

  nuconta NUMBER;
  nuErrorCode NUMBER;
  sbErrorMessage VARCHAR2(4000);
  
BEGIN

    
	dbms_output.put_Line('INICIO');
	dbms_output.put_Line('-------------------------------------');
	
    SELECT COUNT(*) INTO nuconta
    FROM Dba_tables
    WHERE TABLE_NAME = UPPER('HOMOCATE') ;
	
	
	IF nuconta = 0 THEN 
      
		dbms_output.put_line('Creando tabla HOMOCATE');
		-- Create table
	    EXECUTE IMMEDIATE  'CREATE TABLE HOMOLOGACION.HOMOCATE (
							CATECODI	NUMBER(4),
							CATEHOMO	NUMBER(4)						
							)';
							
		-- Add comments to the table							
		EXECUTE IMMEDIATE 'COMMENT ON TABLE HOMOLOGACION.HOMOCATE IS ''HOMOLOGACION CATEGORIAS GASPLUS OSF''';					
							
		-- Add comments to the columns 
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOCATE.CATECODI IS ''CODIGO CATEGORIA GASPLUS''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN HOMOLOGACION.HOMOCATE.CATEHOMO IS ''CODIGO CATEGORIA HOMOLOGADO''';


    END IF;
    dbms_output.put_Line('-------------------------------------');
    dbms_output.put_Line('FIN');


EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('ERROR: ' || SQLERRM);
    ROLLBACK;
	
END;
/