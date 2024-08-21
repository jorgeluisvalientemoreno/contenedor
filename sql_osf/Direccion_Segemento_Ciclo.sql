select a.susccodi    Contrato,
       a.susciddi    Direccion_Contrato,
       aa.address_id Direccion_Creada,
       aa.address    Formato_Direccion,
       aa.segment_id Segmento,
       ass.cicocodi  Ciclo
  from OPEN.ab_address aa
  left join OPEN.AB_SEGMENTS ass
    on ass.segments_id = aa.segment_id
  left join OPEN.SUSCRIPC a
    on aa.address_id = a.susciddi
 where aa.address_id = 1078204; --2015048;
