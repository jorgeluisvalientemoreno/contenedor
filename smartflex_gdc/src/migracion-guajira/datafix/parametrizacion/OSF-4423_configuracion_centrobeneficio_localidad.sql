column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  insert into ldci_centbenelocal
  with base as(
  select 44 as depa, 1 as loca, 6101 as cebe from dual union all
  select 44 as depa, 2 as loca, 6102 as cebe from dual union all
  select 44 as depa, 3 as loca, 6106 as cebe from dual union all
  select 44 as depa, 4 as loca, 6106 as cebe from dual union all
  select 44 as depa, 5 as loca, 6101 as cebe from dual union all
  select 44 as depa, 6 as loca, 6106 as cebe from dual union all
  select 44 as depa, 7 as loca, 6107 as cebe from dual union all
  select 44 as depa, 8 as loca, 6108 as cebe from dual union all
  select 44 as depa, 9 as loca, 6109 as cebe from dual union all
  select 44 as depa, 10 as loca, 6111 as cebe from dual union all
  select 44 as depa, 11 as loca, 6111 as cebe from dual union all
  select 44 as depa, 12 as loca, 6112 as cebe from dual union all
  select 44 as depa, 13 as loca, 6113 as cebe from dual union all
  select 44 as depa, 14 as loca, 6114 as cebe from dual union all
  select 44 as depa, 15 as loca, 6115 as cebe from dual union all
  select 44 as depa, 16 as loca, 6104 as cebe from dual union all
  select 44 as depa, 17 as loca, 6103 as cebe from dual union all
  select 44 as depa, 18 as loca, 6103 as cebe from dual union all
  select 44 as depa, 19 as loca, 6110 as cebe from dual union all
  select 44 as depa, 20 as loca, 6110 as cebe from dual union all
  select 44 as depa, 21 as loca, 6106 as cebe from dual union all
  select 44 as depa, 22 as loca, 6106 as cebe from dual union all
  select 44 as depa, 23 as loca, 6106 as cebe from dual union all
  select 44 as depa, 24 as loca, 6101 as cebe from dual union all
  select 44 as depa, 25 as loca, 6105 as cebe from dual union all
  select 44 as depa, 26 as loca, 6108 as cebe from dual union all
  select 44 as depa, 27 as loca, 6113 as cebe from dual union all
  select 44 as depa, 28 as loca, 6101 as cebe from dual union all
  select 44 as depa, 29 as loca, 6101 as cebe from dual union all
  select 44 as depa, 30 as loca, 6101 as cebe from dual union all
  select 44 as depa, 31 as loca, 6101 as cebe from dual union all
  select 44 as depa, 32 as loca, 6101 as cebe from dual union all
  select 44 as depa, 33 as loca, 6101 as cebe from dual union all
  select 44 as depa, 34 as loca, 6101 as cebe from dual union all
  select 44 as depa, 35 as loca, 6101 as cebe from dual union all
  select 44 as depa, 36 as loca, 6102 as cebe from dual union all
  select 44 as depa, 37 as loca, 6111 as cebe from dual union all
  select 44 as depa, 38 as loca, 6112 as cebe from dual union all
  select 44 as depa, 39 as loca, 6101 as cebe from dual union all
  select 44 as depa, 40 as loca, 6110 as cebe from dual union all
  select 44 as depa, 41 as loca, 6108 as cebe from dual union all
  select 44 as depa, 42 as loca, 6101 as cebe from dual union all
  select 44 as depa, 43 as loca, 6102 as cebe from dual union all
  select 44 as depa, 44 as loca, 6111 as cebe from dual union all
  select 44 as depa, 45 as loca, 6111 as cebe from dual union all
  select 44 as depa, 46 as loca, 6112 as cebe from dual union all
  select 44 as depa, 47 as loca, 6101 as cebe from dual union all
  select 44 as depa, 48 as loca, 6113 as cebe from dual union all
  select 44 as depa, 49 as loca, 6113 as cebe from dual union all
  select 44 as depa, 50 as loca, 6113 as cebe from dual union all
  select 44 as depa, 51 as loca, 6113 as cebe from dual union all
  select 44 as depa, 52 as loca, 6113 as cebe from dual union all
  select 44 as depa, 53 as loca, 6113 as cebe from dual union all
  select 44 as depa, 54 as loca, 6101 as cebe from dual union all
  select 44 as depa, 55 as loca, 6103 as cebe from dual union all
  select 44 as depa, 56 as loca, 6113 as cebe from dual union all
  select 44 as depa, 57 as loca, 6113 as cebe from dual union all
  select 44 as depa, 58 as loca, 6101 as cebe from dual union all
  select 44 as depa, 59 as loca, 6101 as cebe from dual union all
  select 44 as depa, 60 as loca, 6101 as cebe from dual union all
  select 44 as depa, 61 as loca, 6101 as cebe from dual union all
  select 44 as depa, 62 as loca, 6101 as cebe from dual union all
  select 44 as depa, 63 as loca, 6101 as cebe from dual union all
  select 44 as depa, 64 as loca, 6101 as cebe from dual union all
  select 44 as depa, 65 as loca, 6101 as cebe from dual union all
  select 44 as depa, 66 as loca, 6111 as cebe from dual union all
  select 44 as depa, 67 as loca, 6111 as cebe from dual union all
  select 44 as depa, 68 as loca, 6111 as cebe from dual union all
  select 44 as depa, 69 as loca, 6111 as cebe from dual union all
  select 44 as depa, 70 as loca, 6113 as cebe from dual union all
  select 44 as depa, 71 as loca, 6113 as cebe from dual union all
  select 44 as depa, 72 as loca, 6113 as cebe from dual union all
  select 44 as depa, 73 as loca, 6113 as cebe from dual union all
  select 44 as depa, 74 as loca, 6113 as cebe from dual union all
  select 44 as depa, 75 as loca, 6113 as cebe from dual union all
  select 44 as depa, 76 as loca, 6101 as cebe from dual union all
  select 44 as depa, 77 as loca, 6101 as cebe from dual union all
  select 44 as depa, 78 as loca, 6101 as cebe from dual union all
  select 44 as depa, 79 as loca, 6103 as cebe from dual union all
  select 44 as depa, 80 as loca, 6101 as cebe from dual union all
  select 44 as depa, 81 as loca, 6111 as cebe from dual union all
  select 44 as depa, 82 as loca, 6111 as cebe from dual union all
  select 44 as depa, 83 as loca, 6113 as cebe from dual)
  select  1 as pais, (select lo.geo_loca_father_id from open.ge_geogra_location lo where lo.geograp_location_id = h.geograp_location_id) depa, h.geograp_location_id,  base.cebe
  from homologacion.homoubge h
  left join base on base.depa = depacodi and base.loca=locacodi
  where tipo='LOCALIDAD';
  dbms_output.put_line('PROCESO TERMINO OK');
   
exception  
  when others then
       rollback;
       dbms_output.put_line(sqlerrm);
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/