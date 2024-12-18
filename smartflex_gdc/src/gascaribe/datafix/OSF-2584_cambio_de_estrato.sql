column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  execute immediate 'alter trigger TRGBIDURAB_PREMISE disable';
  update open.pr_product p
     set p.subcategory_id = 1
   where p.product_id =  6531251 ;
  update open.servsusc s
     set s.sesusuca = 1
   where s.sesunuse =  6531251 ;

   update ab_premise
   set  subcategory_ = 1
   where premise_id = 127871;

     update open.pr_product p
     set p.subcategory_id = 2
   where p.product_id =  14510029  ;
  update open.servsusc s
     set s.sesusuca = 2
   where s.sesunuse =  14510029  ;

     update ab_premise
   set  subcategory_ = 2
   where premise_id = 21898;
  commit;

  execute immediate 'alter trigger TRGBIDURAB_PREMISE ENABLE';
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/