declare
  cursor cuunidad is
  select *
  from open.or_operating_unit u
  where not exists(select null from or_oper_unit_persons p where u.operating_unit_id=p.operating_unit_id and person_id=38963)
    and not exists(select null from ge_organizat_area a where a.organizat_area_id=u.operating_unit_id);;
begin
  for reg in cuunidad loop
      insert into or_oper_unit_persons values(reg.operating_unit_id, 38963);
      
      commit;
  end loop;
end;
/
