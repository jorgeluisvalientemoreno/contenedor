declare

  nuError	number;
  sbError varchar2(4000);
  cursor cuDatos is
select lo.description,
       lo.geograp_location_id
from open.ge_geogra_location  lo
where lo.geo_loca_father_id in ( 8973);

begin
      for reg in cudatos loop
        nuError := null;
        sbError := null;

          os_delgeograplocation(reg.geograp_location_id,
                                nuError,
                                sbError);
          if nuError = 0 then
             commit;
          else
            rollback;
            dbms_output.put_line(sberror);
          end if;
      end loop;
end;


declare

  nuError	number;
  sbError varchar2(4000);
  cursor cuDatos is
   select ba.description,
       ba.geograp_location_id
from open.ge_geogra_location  lo
inner join ge_geogra_location ba on ba.geo_loca_father_id=lo.geograp_location_id and ba.geog_loca_area_type  = 5
where lo.geo_loca_father_id in ( 8973);

begin
      for reg in cudatos loop
        nuError := null;
        sbError := null;

          os_delgeograplocation(reg.geograp_location_id,
                                nuError,
                                sbError);
          if nuError = 0 then
             commit;
          else
            rollback;
            dbms_output.put_line(sbError);
          end if;
      end loop;
end;

declare

  nuError	number;
  sbError varchar2(4000);
  cursor cuDatos is
    select se.geograp_location_id,
           se.description,
           sec.operating_sector_id
    from open.ge_geogra_location  lo
    inner join ge_geogra_location se on se.geo_loca_father_id=lo.geograp_location_id and se.geog_loca_area_type  = 4
    left join or_operating_sector sec on sec.operating_sector_id = se.geograp_location_id
    where lo.geo_loca_father_id in ( 8973);

begin
      for reg in cudatos loop
        nuError := null;
        sbError := null;
        os_delgeograplocation(reg.geograp_location_id,
                                nuError,
                                sbError);
        if nuerror = 0  then
          
          os_del_oper_sector(reg.operating_sector_id,
                           nuError,
                           sbError);
          if nuError = 0 then
             commit;
          else
            rollback;
            dbms_output.put_line(sbError);
          end if;
        else
          rollback;
          dbms_output.put_line(sbError);
        end if;
      end loop;
end;