--LOG_PROC_MIGRA OSF

DECLARE

  nuconta NUMBER;
  nuErrorCode NUMBER;
  sbErrorMessage VARCHAR2(4000);
  
BEGIN

    
	dbms_output.put_Line('INICIO');
	dbms_output.put_Line('-------------------------------------');
	
    SELECT COUNT(*) INTO nuconta
    FROM Dba_tables
    WHERE TABLE_NAME = UPPER('LOG_PROC_MIGRA') ;
	
	
	IF nuconta = 0 THEN 
      
		dbms_output.put_line('Creando tabla LOG_PROC_MIGRA');
		-- Create table
	    EXECUTE IMMEDIATE  'CREATE TABLE MIGRAGG.LOG_PROC_MIGRA (
							LPMCODI   NUMBER,
							LPMPROG   VARCHAR2(100),
							LPMHILO   NUMBER,
							LPMESTA	  VARCHAR2(1),
							LPMUSER   VARCHAR2(50),
							LPMTERM   VARCHAR2(50),
							LPMSESI   VARCHAR2(50),
							LPMFEIN   DATE,
							LPMFEFI   DATE,
							LPMREPR   NUMBER,
							LPMREER   NUMBER,
							LPMOBSE   VARCHAR2(4000)
						)';
							
		-- Add comments to the table							
		EXECUTE IMMEDIATE 'COMMENT ON TABLE MIGRAGG.LOG_PROC_MIGRA IS ''Log de estado Procesos Migracion''';					
							
		-- Add comments to the columns 
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMCODI IS ''Codigo de log''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMPROG IS ''ID Proceso''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMHILO IS ''Número de Hilo''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMESTA IS ''Estado Proceso (P - En Proceso,T - Terminó, E - Terminó con errores)''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMUSER IS ''Usuario''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMTERM IS ''Terminal''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMSESI IS ''Sesion''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMFEIN IS ''Fecha inicial''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMFEFI IS ''Fecha final''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMREPR IS ''Registros a procesar''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMREER IS ''Registros con Error''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN MIGRAGG.LOG_PROC_MIGRA.LPMOBSE IS ''Observaciones''';



    END IF;
    dbms_output.put_Line('-------------------------------------');
    dbms_output.put_Line('FIN');


EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('ERROR: ' || SQLERRM);
    ROLLBACK;
	
END;
/