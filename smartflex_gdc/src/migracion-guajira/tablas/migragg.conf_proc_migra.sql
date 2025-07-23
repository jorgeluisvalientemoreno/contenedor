--CONF_PROC_MIGRA OSF

DECLARE

  nuconta NUMBER;
  nuErrorCode NUMBER;
  sbErrorMessage VARCHAR2(4000);
  
BEGIN

    
	dbms_output.put_Line('INICIO');
	dbms_output.put_Line('-------------------------------------');
	
    SELECT COUNT(*) INTO nuconta
    FROM Dba_tables
    WHERE TABLE_NAME = UPPER('CONF_PROC_MIGRA') ;
	
	
	IF nuconta = 0 THEN 
      
		dbms_output.put_line('Creando tabla CONF_PROC_MIGRA');
		-- Create table
	    EXECUTE IMMEDIATE  'CREATE TABLE MIGRAGG.CONF_PROC_MIGRA (
							CPMCODI   NUMBER,
							CPMENTI	  VARCHAR2(100),
							CPMHILO   NUMBER
						)';
							
		-- Add comments to the table							
		EXECUTE IMMEDIATE 'COMMENT ON TABLE MIGRAGG.CONF_PROC_MIGRA IS ''Configuracion hilos proceso migracion''';					
							
		-- Add comments to the columns 
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.CONF_PROC_MIGRA.CPMCODI IS ''Id Registro''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.CONF_PROC_MIGRA.CPMENTI IS ''Id Proceso''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.CONF_PROC_MIGRA.CPMHILO IS ''Cantidad de Hilos''';


    END IF;
    dbms_output.put_Line('-------------------------------------');
    dbms_output.put_Line('FIN');


EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('ERROR: ' || SQLERRM);
    ROLLBACK;
	
END;
/