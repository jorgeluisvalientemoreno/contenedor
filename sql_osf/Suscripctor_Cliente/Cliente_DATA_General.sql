--DATA GENERAL
SELECT a.address_id Direccion,
       a.subscriber_id Suscriptor,
       a.subscriber_name Nombre,
       a.subs_last_name Apellido,
       a.ident_type_id || ' - ' || git.description Tipo_Identificacion,
       a.identification Identification,
       a.subscriber_type_id || ' - ' || ges.description Tipo_Suscriptor,
       a.e_mail e_mail,
       A.phone Telefono,
       A.address Direccion,
       a.subs_status_id || ' - ' || a.subs_status_id Estado,
       c.economic_activity_id || ' - ' || gea.description Actividad_Economica,
       c.url url,
       decode(a.active, 'Y', 'Si', 'No') Activo,
       a.vinculate_date Fecha_Vinculacion,
       a.marketing_segment_id || ' - ' || a.marketing_segment_id SEGMENTO_MERCADO,
       a.accept_call Acepta_Llamadas,
       a.taxpayer_type || ' - ' || a.taxpayer_type TIPO_CONTRIBUYENTE,
       decode(a.Is_Corporative, 'Y', 'Si', 'No') Cliente_Corporativo,
       ab.segment_id Segmento,
       as1.category_ Categoria_Segmento,
       as1.subcategory_ Subcategoria_Segmento,
       a.contact_id Contacto,
       s.susccodi Contrato,
       s.susccicl Cilo_Facturacion,
       s.SUSCIDDI || ' - ' || ab.address Direccion_Cobro,
       s.SUSCTISU || ' - ' || gst.description Tipo_contrato,
       ss_.sesunuse Servicio_Producto,
       ss_.sesuserv || ' - ' || servicio.servdesc Tipo,
       ss_.sesuesco || ' - ' || ec.escodesc Estado_Servicio,
       pp.product_status_id || ' - ' || pps.description Estado_Producto,
       decode(ss_.sesuesfn,
              'A',
              'Al dia',
              'D',
              'Con Deuda',
              'C',
              'Castigado',
              'M',
              'Mora',
              ss_.sesuesfn) Estado_Financiero
--, cc_boOssSubscriberData.fnuGetOlderClient(a.subscriber_id) older_client
  FROM open.ge_subscriber a
  left join open.ge_subs_busines_data c
    on a.subscriber_id = c.subscriber_id
  left join open.ge_identifica_type git
    on git.ident_type_id = a.ident_type_id
  left join open.ge_subscriber_type ges
    on ges.subscriber_type_id = a.subscriber_type_id
  left join open.ge_economic_activity gea
    on gea.economic_activity_id = c.economic_activity_id
  left join open.suscripc s
    on a.subscriber_id = s.suscclie
  left join open.ab_address ab
    on ab.address_id = s.SUSCIDDI
  left join OPEN.GE_SUBSCRIPTION_TYPE gst
    on gst.subscription_type = s.susctisu
  left join OPEN.AB_SEGMENTS as1
    on as1.segments_id = ab.segment_id
  left join open.servsusc ss_
    on ss_.sesususc = s.susccodi
  left join open.pr_product pp
    on pp.product_id = ss_.sesunuse
  left join open.servicio
    on servicio.servcodi = ss_.sesuserv
  left join open.estacort ec
    on ec.escocodi = ss_.sesuesco
  left join open.ps_product_status pps
    on pps.product_status_id = pp.product_status_id
 WHERE 1 = 1
      --and s.susccodi in (67450983)
   AND A.IDENTIFICATION = '9013940062'
--and 
-- a.subscriber_id in (67450983)
