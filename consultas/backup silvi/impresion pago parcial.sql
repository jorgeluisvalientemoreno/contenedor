SELECT (b.subscriber_name||' '||b.subs_last_name||' '||
      b.subs_second_last_name) CLIENTE
      , b.identification IDENTIFICACION
      ,s.susccodi CONTRATO
      ,(a.address ||'  '||
      pkg_bcdirecciones.fsbgetdescripcionubicageo(a.neighborthood_id))DIRPROYECTO
      ,cu.cupotipo TIPOCUPON
      ,DECODE(cu.cuponume, NULL, 'No se ha generado Cupon', cu.cuponume) CUPON
      ,DECODE(fr.factvaap, NULL, 'No se ha generado Cupon', '$'||TO_CHAR(cu.cupovalo,'FM999,999,999,999')) VALOR
      , CASE
        WHEN (pkg_bcproducto.fnuCategoria(se.sesunuse) <= 3 AND pkg_bcfacturacion.fnuContarCuentasConSaldo(se.sesunuse) >1) THEN
        'INMEDIATO'
        ELSE TO_CHAR(pf.pefafepa,'DD-MON-YYYY') END  VALIDOHASTA
      ,'CUPON DE PAGO PARCIAL' TIPO_SOL
      ,pkg_bcimpresioncodigobarras.fsbobtcadenacodigobarras(cu.cuponume,pf.pefafepa,isbcodempresa) CODIGODEBARRAS
  FROM  suscripc s, servsusc se, ge_subscriber b
     ,ab_address a, factura fr
     ,cupon cu, perifact pf
  where cu.cupodocu = fr.factcodi
    AND s.susccicl = pf.pefacicl
    AND pf.pefaactu = 'S'
    AND s.susciddi = a.address_id
    AND s.suscclie = b.subscriber_id
    AND s.susccodi = cu.cuposusc
    AND se.sesususc = s.susccodi
    AND cu.cuponume = inuCupon
    AND rownum = 1;
