select --emss.emsselme,
 emss.emsscoem Medidor,
 emss.emssfein Fecha_Instalacion,
 emss.emssfere Fecha_Retiro,
 --emss.emsscmss ,
 emss.emsssesu Porducto,
 --emss.emssserv,
 --emss.emsssspr,
 gis.operating_unit_id Unidad_Operativa,
 gis.numero_servicio Servicio,
 gis.subscriber_id Cliente,
 gis.id_items_seriado Item_seriado,
 gis.items_id || ' - ' || gi.description Item,
 gis.serie Serie_Medidor,
 decode(gis.estado_tecnico,
        'N',
        'N - Nuevo',
        'R',
        'R - Reacondicionado',
        'D',
        'D - Dañado') Estado_Tecnico,
 gis.id_items_estado_inv || ' - ' || giei.descripcion Estado_Inventario,
 gis.costo Costo,
 gis.subsidio Subsidio,
 DECODE(gis.propiedad,
        'E',
        'E - EMPRESA',
        'T',
        'T - TERCERO',
        'C',
        'C - TRAIDO POR CLIENTE',
        'V',
        'V - VENDIDO AL CLIENTE') Propietario,
 gis.fecha_ingreso Fecha_Ingreso_a_Sistema,
 gis.fecha_salida Fecha_Salida_de_Sistema,
 gis.fecha_reacon Fecha_Reacondicionamiento,
 gis.fecha_baja Fecha_de_Baja,
 gis.fecha_garantia Fecha_Garantia,
 gs.subscriber_name || '-' || gs.subs_last_name
  from OPEN.ELMESESU emss
  left join open.ge_items_seriado gis
    on gis.serie = emss.emsscoem
  left join open.ge_items gi
    on gi.items_id = gis.items_id
  left join OPEN.GE_ITEMS_ESTADO_INV GIEI
    on giei.id_items_estado_inv = gis.id_items_estado_inv
  left join OPEN.ge_subscriber gs
    on gs.subscriber_id = gis.subscriber_id
 where emss.emsssesu in
       (select pp.product_id
          from open.pr_product pp
         where pp.subscription_id in (67637315));
