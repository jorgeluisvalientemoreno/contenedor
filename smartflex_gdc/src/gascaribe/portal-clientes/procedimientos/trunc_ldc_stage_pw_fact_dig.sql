create or replace procedure "PERSONALIZACIONES"."TRUNC_LDC_STAGE_PW_FACT_DIG" as
begin
  execute immediate 'truncate table "PERSONALIZACIONES"."LDC_STAGE_PW_FACT_DIG"';
end;
/