column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  insert into master_open select object_type TIPO_OPEN, object_name nombre, object_type, 'IDENTIFICADO POR CARLOS,ENTREGADO EN SAO'
    from dba_objects
    where object_name in ('CC_BCCHANGEINTERACTION','CC_BCCOUPON','CC_BCSUBSCRIBERDATA','CC_BCSUSCRIPTIONDATA','CC_BOCOUPON','CC_BOSUBSIDYPROMOTION','CO_BOCONTROLVERSION')
      and object_type='PACKAGE';

  commit;
  
  
  update open.master_personalizaciones
    set comentario='OPEN'
  where nombre in ('CC_BCCHANGEINTERACTION','CC_BCCOUPON','CC_BCSUBSCRIBERDATA','CC_BCSUSCRIPTIONDATA','CC_BOCOUPON','CC_BOSUBSIDYPROMOTION','CO_BOCONTROLVERSION');
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/