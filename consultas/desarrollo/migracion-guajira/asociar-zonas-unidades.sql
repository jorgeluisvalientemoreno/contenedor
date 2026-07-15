declare
  cursor cuDatos is
    with homologacion_zona as(
    select 1 gasplus, 254 as osf from dual union all
    select 7 gasplus, 255 as osf from dual union all
    select 8 gasplus, 256 as osf from dual union all
    select 9 gasplus, 257 as osf from dual union all
    select 10 gasplus, 258 as osf from dual union all
    select 14 gasplus, 259 as osf from dual union all
    select 15 gasplus, 260 as osf from dual union all
    select 16 gasplus, 261 as osf from dual union all
    select 17 gasplus, 262 as osf from dual union all
    select 18 gasplus, 263 as osf from dual union all
    select 19 gasplus, 264 as osf from dual union all
    select 20 gasplus, 265 as osf from dual union all
    select 23 gasplus, 266 as osf from dual union all
    select 25 gasplus, 267 as osf from dual union all
    select 26 gasplus, 268 as osf from dual union all
    select 30 gasplus, 269 as osf from dual union all
    select 40 gasplus, 270 as osf from dual union all
    select 90 gasplus, 271 as osf from dual union all
    select 91 gasplus, 272 as osf from dual union all
    select 93 gasplus, 273 as osf from dual union all
    select 94 gasplus, 274 as osf from dual union all
    select 99 gasplus, 275 as osf from dual )
    select cuadcodi, cuadzoop, uniophomo, osf
    from homologacion.homouniop h
    join gasgg.cuadcont on cuadcodi=h.uniopcodi
    left join homologacion_zona z on z.gasplus=cuadzoop
    where uniophomo=4926;
begin
  for reg in cuDatos loop
      begin
          update or_operating_unit o set o.operating_zone_id = reg.osf where o.operating_unit_id= reg.uniophomo;
          commit;
      exception
        when others then
          rollback;
          dbms_output.put_line('Error unidad '||reg.uniophomo||' '||sqlerrm);
      end;
  end loop;
end;
/

