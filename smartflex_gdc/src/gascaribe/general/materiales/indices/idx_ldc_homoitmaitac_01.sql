declare
 nuConta  NUMBER;
begin
   
  SELECT COUNT(1) INTO nuConta
  FROM dba_indexes
  WHERE INDEX_NAME = 'IDX_LDC_HOMOITMAITAC_01' 
    AND OWNER = 'OPEN';

   IF nuConta = 0 THEN
      EXECUTE IMMEDIATE 'create index open.idx_ldc_homoitmaitac_01 ON LDC_HOMOITMAITAC (ITEM_ACTIVIDAD)';
   END IF;
end;
/
