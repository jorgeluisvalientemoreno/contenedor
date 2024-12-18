declare
 nuconta number;
begin

   select count(*) into nuconta
   from dba_tab_columns
   where TABLE_NAME = 'LDC_OBLEACTI' 
    and COLUMN_NAME = 'CAUSAL_EXITO';
    
   if nuconta = 0 then 
     execute immediate 'alter table LDC_OBLEACTI add CAUSAL_EXITO  VARCHAR2(1) DEFAULT ''N''';
      execute immediate 'alter table LDC_OBLEACTI add ACTIVIDAD_CRITICA  NUMBER(15)';
      execute immediate 'COMMENT ON COLUMN LDC_OBLEACTI.CAUSAL_EXITO IS ''ES CAUSAL DE EXITO- S-SI, N-NO''';
      execute immediate 'COMMENT ON COLUMN LDC_OBLEACTI.ACTIVIDAD_CRITICA IS ''ACTIVIDAD DE CRITICA''';
  end if;
end;
/