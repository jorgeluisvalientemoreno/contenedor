declare
 nuConta  NUMBER;
begin
   
  SELECT COUNT(1) INTO nuConta
  FROM dba_indexes
  WHERE INDEX_NAME = 'IDX_CON01HOMOL_SERVICIOS' 
    AND OWNER = 'PERSONALIZACIONES';

   IF nuConta = 0 THEN
          EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_CON01HOMOL_SERVICIOS on PERSONALIZACIONES.HOMOLOGACION_SERVICIOS(SERVICIO_ORIGEN)';
   END IF;

end;
/