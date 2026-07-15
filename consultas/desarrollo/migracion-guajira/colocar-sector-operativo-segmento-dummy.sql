declare
cursor cuSegmentos is
select distinct  se.segments_id      , di.geograp_location_id, lo.description,(select se.geograp_location_id from open.ge_geogra_location se where se.geo_loca_father_id = di.geograp_location_id and se.geog_loca_area_type=4 and rownum=1) sector

from migragg.migra_direcciones_gdg m
join open.ab_address di on di.address_id=m.predabdr
join open.ab_segments se on se.segments_id = di.segment_id
join open.ge_geogra_location lo on lo.geograp_location_id=di.geograp_location_id
where se.operating_sector_id   is  null;

begin
  for reg in cuSegmentos loop
    begin
          update ab_segments se set se.operating_sector_id=reg.sector where se.segments_id=reg.segments_id;
          commit;
    exception
      when others then
        rollback;
        dbms_output.put_line(reg.segments_id||':'||sqlerrm);
    end;
  end loop;
end;
/