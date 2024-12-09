SELECT distinct a.pagacodi         pagare,
       a.pagacofi         Fianciacion,
       mm.subscription_id Contrato,
       mm.product_id      Producto
  FROM pagare a
  LEFT JOIN cc_financing_request b
    ON a.pagacofi = b.FINANCING_ID
  LEFT JOIN diferido c
    ON b.financing_id = c.difecofi
  LEFT JOIN mo_motive mm
    ON mm.package_id = b.package_id
 where a.pagafech > sysdate-220
