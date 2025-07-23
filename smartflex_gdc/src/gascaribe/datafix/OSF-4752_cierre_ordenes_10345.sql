column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  onuErrorCode    NUMBER; --TICKET 2001901 LJLB -- se almacena codigo del error
  osbErrorMessage VARCHAR2(4000); --TICKET 2001901 LJLB -- se almacena mensaje de error

  CURSOR cuSubsisdio IS
    select ASIG_SUBSIDY_ID || '-S' codigo
      from OPEN.LDC_LOGERCODAVE   a,
           open.or_order          oo,
           open.ld_asig_subsidy   asu,
           open.ld_subsidy        su,
           open.or_order_activity ooa,
           open.hicaespr          hcep
     where 1 = 1
       and a.order_id = oo.order_id
       and a.order_id = asu.order_id
       AND asu.delivery_doc = ld_boconstans.csbNOFlag
       AND asu.state_subsidy <> ld_boconstans.cnuSubreverstate
       AND Asu.subsidy_id = su.subsidy_id
       AND OO.ORDER_STATUS_ID NOT IN (8, 12)
       and oo.order_id = ooa.order_id
       and ooa.product_id = hcep.hcetnuse
       and hcep.hcetepac = 1
       and hcep.hcetepan = 15
     ORDER BY A.FECHERROR DESC;

  sbmensa VARCHAR2(4000);

BEGIN

  FOR reg IN cuSubsisdio LOOP
    LDC_PROCCONTDOCUVENT(REG.codigo, onuErrorCode, osbErrorMessage);
    dbms_output.put_line('Orden: ' || REG.codigo || ' - Error: ' ||
                         NVL(onuErrorCode, 0) || ' ' || osbErrorMessage);
  END LOOP;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/