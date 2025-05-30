select ppu.package_unittype_id,
       ppu.package_type_id || ' - ' || ppt.description,
       ppu.product_type_id,
       ppu.product_motive_id,
       ppu.unit_type_id || ' - ' || wut.description,
       ppu.interface_config_id
  from ps_package_unittype ppu
  left join ps_package_type ppt
    on ppt.package_type_id = ppu.package_type_id
  left join wf_unit_type wut
    on wut.unit_type_id = ppu.unit_type_id
 where ppu.unit_type_id in
       (154, 100377, 100463, 100500, 100505, 100590, 100595);

select *
  from wf_unit_type
 where unit_type_id in (select unit_type_id
                          from ps_package_unittype
                         where package_type_id in (100014));
