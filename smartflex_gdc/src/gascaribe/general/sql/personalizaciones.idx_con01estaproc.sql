declare
 nuConta  NUMBER;
begin
   
  SELECT COUNT(1) INTO nuConta
  FROM dba_indexes
  WHERE INDEX_NAME = 'IDX_CON01ESTAPROC' 
    AND OWNER = 'PERSONALIZACIONES';

   IF nuConta = 0 THEN
      EXECUTE IMMEDIATE 'create index personalizaciones.idx_con01estaproc on personalizaciones.estaproc(proceso)';
   END IF;
end;
/
