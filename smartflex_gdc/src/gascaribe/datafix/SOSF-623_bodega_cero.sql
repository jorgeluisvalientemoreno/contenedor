column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
CURSOR CUDATOS IS
select a.operating_unit_id,open.daor_operating_unit.fsbgetname(a.operating_unit_id), a.items_id, a.balance, (select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_act, (select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_inv,
a.total_costs, (select total_costs from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id)cost_act, (select total_costs from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cost_inv,
A.TRANSIT_IN,A.TRANSIT_OUT
from OPEN.OR_OPE_UNI_ITEM_BALA a
where (
a.balance!=nvl((select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id), 0)+
nvl((select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id),0)
or
a.total_costs!=nvl((select total_costs from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id), 0)+
nvl((select total_costs from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id),0)
or
nvl((select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id), 0)<0
or
nvl((select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id), 0)<0
or
nvl((select total_costs from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id), 0)<0
or
nvl((select total_costs from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id), 0)<0
)
and a.balance=0
;


cursor cuBodega(nuBodega number, nuItem number) is
select *
from open.or_ope_uni_item_bala
where items_id=nuitem
and operating_unit_id=nuBodega;
RGBODEGA CUBODEGA%ROWTYPE;

NUACTIVO NUMBER;
NUINVENTARIO NUMBER;
NUOTROS  NUMBER;
NUACTIVO2 NUMBER;
NUINVENTARIO2 NUMBER;
NUCOSTPROM  NUMBER(13,2);
NUCOSTACTI  NUMBER(13,2);
NUCOSTINVE  NUMBER(13,2);  

BEGIN
  DBMS_OUTPUT.PUT_LINE('CODIGO UNIDAD'||'|'||'CODIGO_ITEM'||'|'||'TOTAL_BODEGA'||'|' ||'INVENTARIO'||'|'||'ACTIVO'||'|'||'OTROS'||'|'||'COSTO BODEGA'||'|'||'COSTO INV'||'|'||'COSTO ACT');
  FOR REG IN CUDATOS LOOP
    NUACTIVO:=0;
    NUINVENTARIO:=0;
    NUOTROS:=0;
    open cubodega(REG.OPERATING_UNIT_ID, REG.ITEMS_ID);
    FETCH CUBODEGA INTO RGBODEGA;
    CLOSE CUBODEGA;
    IF RGBODEGA.BALANCE = 0 THEN
      UPDATE ldc_act_ouib b SET B.BALANCE=0, B.TOTAL_COSTS=0  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
      if sql%rowcount=0 then
      insert into ldc_act_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
      values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA, 0, 0, 0,null,null);
      end if;
      UPDATE ldc_inv_ouib b SET B.BALANCE=0, B.TOTAL_COSTS=0  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
      if sql%rowcount=0 then
      insert into ldc_inv_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
      values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA, 0, 0, 0,null,null);
      end if;
      NUACTIVO2 :=0;
      NUINVENTARIO2:=0;
      NUCOSTACTI :=0;
      NUCOSTINVE:=0;
    END IF;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(REG.OPERATING_UNIT_ID||'|'||REG.ITEMS_ID||'|'||RGBODEGA.BALANCE||'|'||nvl(NUINVENTARIO,0)||'|'||nvl(NUACTIVO,0)||'|'||nvl(NUOTROS,0)||'|'||RGBODEGA.TOTAL_COSTS||'|'|| NUCOSTINVE||'|'|| NUCOSTACTI ||'|REAL');
    DBMS_OUTPUT.PUT_LINE(REG.OPERATING_UNIT_ID||'|'||REG.ITEMS_ID||'|'||RGBODEGA.BALANCE||'|'||nvl(NUINVENTARIO2,0)||'|'||nvl(NUACTIVO2,0)||'|'||nvl(0,0)||'|'||RGBODEGA.TOTAL_COSTS||'|'|| NUCOSTINVE||'|'|| NUCOSTACTI ||'|QUEDO');
  END LOOP;
END;    
/



select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/