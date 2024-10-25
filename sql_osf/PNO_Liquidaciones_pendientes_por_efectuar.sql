-- son producto, contrato, cliente, valor , periodo de consumo.
SELECT FPN.PRODUCT_ID PRODUCTO,
       PP.SUBSCRIPTION_ID CONTRATO,
       GS.SUBSCRIBER_NAME || ' ' || GS.SUBS_LAST_NAME || ' ' ||
       GS.SUBS_SECOND_LAST_NAME CLIENTE,
       sum(cargvalo) valor,
       fpin.pecscons periodo_consumo
  FROM open.fm_possible_ntl fpn
 inner join open.pr_product pp
    on pp.product_id = fpn.product_id
 inner join open.suscripc s
    on s.susccodi = pp.subscription_id
 inner join open.ge_subscriber gs
    on gs.subscriber_id = s.suscclie
 inner join open.fm_preinvoice_pno fpin
    on fpin.package_id = fpn.package_id
   AND fpin.cargvalotype = 'D'
 WHERE fpn.product_id = nvl(&producto, fpn.product_id)
   and fpn.product_id in
       (select pp1.product_id
          from open.pr_product pp1
         where pp1.product_type_id = 7014
           and pp1.subscription_id = nvl(&contrato, pp1.subscription_id))
   and fpn.status = 'F'
 group by FPN.PRODUCT_ID,
          PP.SUBSCRIPTION_ID,
          GS.SUBSCRIBER_NAME || ' ' || GS.SUBS_LAST_NAME || ' ' ||
          GS.SUBS_SECOND_LAST_NAME,
          fpin.pecscons;
