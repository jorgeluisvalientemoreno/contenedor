select a.susccodi       Contrato,
       a.susciddi       Direccion_Contrato,
       aa.address_id    Direccion_Creada,
       aa.address       Formato_Direccion,
       aa.segment_id    Segmento,
       ass.cicocodi     Ciclo,
       ass.subcategory_ Subcategoria_Segmento
  from OPEN.ab_address aa
  left join OPEN.AB_SEGMENTS ass
    on ass.segments_id = aa.segment_id
  left join OPEN.SUSCRIPC a
    on aa.address_id = a.susciddi
 where 1 = 1
   --and aa.address_id = 129075
   and aa.address = 'KR 42A4 CL 83 - 73'
   ;
