select r.orden_padre, r.orden_hija, (select c2.certificate_id from open.ct_order_certifica c2 where c2.order_id=r.orden_hija) acta_hija,
       r.orden_nieta, c.certificate_id, (select count(1) from open.or_related_order ro where ro.order_id=r.orden_nieta and ro.rela_order_type_id=14) cantidad_novedades
    from open.ldc_ordenes_ofertados_redes r, OPEN.CT_ORDER_CERTIFICA C
WHERE R.ORDEN_HIJA=158662485
  AND C.ORDER_ID=R.ORDEN_NIETA
--  AND C.CERTIFICATE_ID=115398
