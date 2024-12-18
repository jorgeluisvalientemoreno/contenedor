declare
 nuConta  NUMBER;
begin
   
  SELECT COUNT(1) INTO nuConta
  FROM dba_indexes
  WHERE INDEX_NAME = 'IDX_CON03ESTAPROC' 
    AND OWNER = 'PERSONALIZACIONES';

   IF nuConta = 0 THEN
      EXECUTE IMMEDIATE 'create index personalizaciones.idx_con03estaproc on personalizaciones.estaproc(sesion)';
   END IF;
end;
/
