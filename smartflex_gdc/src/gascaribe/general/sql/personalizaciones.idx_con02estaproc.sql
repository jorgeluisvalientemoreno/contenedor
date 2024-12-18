declare
 nuConta  NUMBER;
begin
   
  SELECT COUNT(1) INTO nuConta
  FROM dba_indexes
  WHERE INDEX_NAME = 'IDX_CON02ESTAPROC' 
    AND OWNER = 'PERSONALIZACIONES';

   IF nuConta = 0 THEN
      EXECUTE IMMEDIATE 'create index personalizaciones.idx_con02estaproc on personalizaciones.estaproc(proceso, sesion)';
   END IF;
end;
/
