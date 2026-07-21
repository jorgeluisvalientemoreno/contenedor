with DATA_FACTURA_CUPON as
 (select c.cuponume CUPON,
         c.cupotipo TIPO,
         c.cupovalo VALOR,
         c.cupoprog PROGRAMA,
         c.cuposusc CONTRATO,
         c.cupoflpa FLAG_PAGO,
         f.factcodi FACTURA,
         f.factpefa PERIODO,
         pp.product_id PRODUCTO,
         s.sesucicl CICLO,
         TO_CHAR(TO_DATE(pf.pefames || '-' || pf.pefaano, 'MM-YYYY'),
                 'MON-YYYY',
                 'nls_date_language=spanish') MES_FACTURA,
         ldc_boformatofactura.fnuobtperconsumo(s.sesucicl, f.factpefa) PERIODO_CONSUMO,
         rownum ORDEN
    from open.cupon c
   inner join open.factura f
      on f.factcodi = c.cupodocu
   inner join open.pr_product pp
      on pp.subscription_id = f.factsusc
     and pp.product_type_id = 7014
   inner join open.servsusc s
      on s.sesususc = f.factsusc
     and s.sesunuse = pp.product_id
   inner join open.perifact pf
      on pf.pefacodi = f.factpefa
   where c.cuponume in
         (898239573, 899706925, 901119711, 902550280, 903954154)
     and c.cupotipo = 'FA'
   order by f.factfege desc)
select DATA_FACTURA_CUPON.* --, ldc_boformatofactura.fnuobtperconsumo(DATA_FACTURA_CUPON.CICLO, DATA_FACTURA_CUPON.PERIODO) periodo_consumo
  from DATA_FACTURA_CUPON
--, vw_cmprodconsumptions vc
--WHERE vc.cosssesu = DATA_FACTURA_CUPON.PRODUCTO
--   AND vc.cosspefa = DATA_FACTURA_CUPON.PERIODO
--   AND vc.cosspecs = 1--ldc_boformatofactura.fnuobtperconsumo(DATA_FACTURA_CUPON.CICLO, DATA_FACTURA_CUPON.PERIODO)
--WHERE p.pecscico = DATA_FACTURA_CUPON.CICLO
--AND p.pecsfecf <= (select pf.pefaffmo FROM perifact pf WHERE pf.pefacodi = DATA_FACTURA_CUPON.PERIODO)
--and rownum = 1
 ORDER BY DATA_FACTURA_CUPON.ORDEN desc;
/*
   SELECT decode(cossmecc, 1, 'LEC.MEDIDOR', 'ESTIMADO') INTO calculo_cons
    FROM vw_cmprodconsumptions
   WHERE cosssesu = inuproducto
     AND cosspefa = inuperifact
     AND cosspecs = nuperidocons;
 */
