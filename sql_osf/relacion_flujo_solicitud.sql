with Flujo_Solicitud as
 (select distinct ppu.package_type_id codigo_solicitud,
                  ppu.package_type_id || ' - ' || ppt.description Solicitud,
                  ppu.unit_type_id codigo_flujo,
                  ppu.unit_type_id || ' - ' || wut.description Flujo
    from open.PS_PACKAGE_UNITTYPE ppu
   inner join OPEN.WF_UNIT_TYPE wut
      on ppu.unit_type_id = wut.unit_type_id
   inner join open.ps_package_type ppt
      on ppu.package_type_id = ppt.package_type_id)
select * from Flujo_Solicitud order by codigo_solicitud
