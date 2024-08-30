--alter session set current_schema =OPEN;
select *
  from OPEN.ld_parameter
 where parameter_id = 'CONFEXME_EST_DEU_PROD';
select * from open.ed_confexme where coemcodi = 108;
select * from open.ed_formato where formiden = '<125>';
-- 'LDC_PLAN_DEU_PROD_EFG';
--OPEN.LDC_BOCERTIFICADO_ESTDEUDA
