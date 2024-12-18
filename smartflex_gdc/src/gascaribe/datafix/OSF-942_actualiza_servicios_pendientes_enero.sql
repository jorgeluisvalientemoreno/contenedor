column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

Declare
  vsbsolici varchar2(15);
  vsbclasif varchar2(4);
Begin
  --
  vsbsolici := 'Paso-1';
  vsbclasif := null;
  delete OPEN.LDC_OSF_SERV_PENDIENTE p
   where p.nuano = 2023
     and p.numes = 01 
     and p.solicitud in (192028549,190693973,189985765,189495322,193185071,192790886,192079862,189051233,188699402,182219074);
  commit;
  --
  vsbsolici := 176339488;
  vsbclasif := 4;
  delete OPEN.LDC_OSF_SERV_PENDIENTE p
   where p.nuano = 2023
     and p.numes = 01 
     and p.solicitud = 176339488
     and p.concepto = 4;
  commit;
  --
  vsbsolici := 125010509;
  vsbclasif := null;
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -74000000
   where p.nuano = 2023
     and p.numes = 01 
     and p.solicitud = 125010509;
  commit;
  --
  vsbsolici := 189889905;
  vsbclasif := 4;
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -621599
   where p.nuano = 2023
     and p.numes = 01 
     and p.solicitud = 189889905
     and p.product_id in (52468835,52468836,52468846,52468842,52468839,52468847,52468843,52468837,52468844,52468841,52468838,52468845,
                          52468840,52468852,52468848,52468849,52468853,52468850,52468854,52468851,52468855,52468856,52468857,52468858,
                          52468861,52468859,52468860,52468862,52468863,52468864,52468865,52468866,52468867,52468870,52468868,52468871,
                          52468869,52468873,52468872,52468875,52468874,52468882,52468879,52468896,52468880,52468883,52468889,52468894,
                          52468877,52468890,52468878,52468892,52468887,52468897,52468895,52468891,52468886,52468885,52468888,52468881,
                          52468884,52468899)
     and p.concepto = 4;
  commit;
  --
  vsbsolici := 190246557;
  vsbclasif := 4;
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -621599 
   where p.nuano = 2023
     and p.numes = 01 
     and p.solicitud = 190246557
     and p.product_id in (52469683,52469672,52469681,52469677,52469682,52469676,52469679,52469668,52469678,52469663,52469666,52469667,
                          52469665,52469675,52469671,52469669,52469688,52469685,52469686,52469690,52469687,52469664,52469673,52469670,
                          52469691,52469689,52469692,52469696,52469695,52469693,52469698,52469694,52469697,52469699,52469700,52469702,
                          52469701,52469703,52469706,52469704,52469707,52469705,52469711,52469708,52469710,52469713,52469709,52469674,
                          52469680,52469684,52469712,52469714,52469717,52469716,52469715,52469718,52469719,52469720,52469723,52469722,
                          52469721,52469725,52469724,52469726,52469727,52469730,52469728,52469729,52469732,52469731,52469733,52469734,
                          52469735,52469736,52469737,52469739)
     and p.concepto = 4;
  commit;
  --
  vsbsolici := 190246557;
  vsbclasif := 400;
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -92699
   where p.nuano = 2023
     and p.numes = 01 
     and p.solicitud = 190246557
     and p.product_id in (52469683,52469672,52469677,52469681,52469682,52469676,52469663,52469668,52469678,52469679,52469666,52469667,
                          52469675,52469669,52469671,52469686,52469688,52469687,52469685,52469665,52469690,52469664,52469673,52469670,
                          52469689,52469692,52469691,52469695,52469696,52469693,52469694,52469699,52469698,52469697,52469700,52469702,
                          52469701,52469706,52469707,52469705,52469708,52469711,52469709,52469713,52469710,52469680,52469684,52469712,
                          52469714,52469717,52469715,52469716,52469718,52469719,52469720,52469723,52469721,52469725,52469726,52469724,
                          52469727,52469728,52469730,52469729,52469732,52469731,52469733,52469735,52469734,52469736,52469737,52469703,
                          52469704,52469739,52469722,52469674)
     and p.concepto = 400;
  commit;
  --
  --
  DBMS_OUTPUT.PUT_LINE('Proceso termina Ok.');
  --
  Exception
    when others then
        ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error solicitud : ' || vsbsolici || '  clasificador : ' || vsbclasif ||'   ' || SQLERRM);
  End;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/