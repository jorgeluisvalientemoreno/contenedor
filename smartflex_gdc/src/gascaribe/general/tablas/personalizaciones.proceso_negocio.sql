
DECLARE
  nuExistsTable NUMBER;
    
BEGIN

   SELECT COUNT(1) INTO nuExistsTable
   FROM DBA_TABLES
   WHERE table_name = 'PROCESO_NEGOCIO'
   AND OWNER = 'PERSONALIZACIONES';

   
   
    IF (nuExistsTable <> 0) THEN

        /*Si la tabla existe, se elimina*/
 		  EXECUTE IMMEDIATE 'DROP TABLE PERSONALIZACIONES.PROCESO_NEGOCIO';
       
    
    END IF;
END;
/