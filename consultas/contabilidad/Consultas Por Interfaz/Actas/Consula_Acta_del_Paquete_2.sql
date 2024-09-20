select aa.*, open.ldci_pkinterfazsap.fvaGetData(17,dcrcinad,'|') loca
from
(
  SELECT 'consulta_1' cons, dcrccons, dcrcecrc, dcrccorc, dcrccuco cuenta, dcrcsign signos, dcrcvalo valor,
         dcrcinad, dcrcfecr, dcrcclcr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,
         'ACTA-'||acta acta, NIT, clcrclco clasificador, ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') item, contrato
  FROM ic_compgene, ic_encoreco, ic_decoreco,(SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta,
         ga.EXTERN_INVOICE_NUM factura, gs.identification NIT
  FROM ge_contratista gc ,ge_subscriber  gs, ge_acta ga, ge_contrato gco
 WHERE gc.SUBSCRIBER_ID = gs.SUBSCRIBER_ID
   AND gco.id_contratista = gc.id_contratista
   AND gco.id_contrato = ga.id_contrato
   AND ga.id_acta = &inuacta) v_deco, ic_confreco, ic_clascore, ic_clascont, ldci_tipointerfaz
 WHERE COGECOCO = cod_tipocomp
   AND tipointerfaz = 'L7' --Decode(ivaiclitido, ldci_pkinterfazsap.vaInterInversion, tipointerfaz, ivaiclitido)
   AND ECRCCOGE = cogecons
   AND ECRCCONS = dcrcecrc
   AND CORCCOCO = COGECOCO
   AND clcrcons = dcrcclcr
   AND clcrclco = clcocodi
   and CORCCONS = DCRCCORC
   AND ldci_pkinterfazsap.fvaGetData(11, DCRCINAD, '|') = v_deco.nit
   AND ldci_pkinterfazsap.fvaGetData(42, DCRCINAD, '|') = v_deco.factura
   AND ldci_pkinterfazsap.fvaGetData(40, DCRCINAD, '|') in (23)
   AND dcrccuco <> '-1'
   AND Round(dcrcvalo) <> 0
  -- AND ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') = 100002262
   AND ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') <> 4001293
   UNION ALL
   --<<
   --Cursor 2
   --Cursor que obtiene los datos de los costos a nivel de detalle de acta para
   --resolver el tema de los items agrupados en decoreco  sin multas.
   -->>
--ALTER SESSION SET CURRENT_SCHEMA= "OPEN";   
   SELECT 'consulta_2' cons, NULL dcrccons, NULL dcrcecrc, NULL dcrccorc,
          Decode(gc.account_classif_id, To_Number(1420900100),'8390909001',
                                        4, '1420900100',
                                        ldci_pkinterfazactas.fvaGetCuGaCoClasi(GD.ID_ORDEN)) cuenta,
          Decode(sign(SUM(gd.valor_total)), 1, 'D', 'C') signos, (SUM(gd.valor_total)) valor,
          '||||||||||'||gs.identification||'|||||'||(SELECT geo_loca_father_id
                                                       FROM ge_geogra_location
                                                      WHERE geograp_location_id = gd.geograp_location_id)
          ||'|'||gd.geograp_location_id||'||||||||||||||||'||abs(SUM(gd.valor_total))||'||||||'
          ||Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id,
                   ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))
          ||'|'||gi.item_classif_id||'||'||ga.extern_invoice_num||'||||'||gd.id_items||'||'||
          ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN)||'|'||GD.ID_ORDEN dcrcinad,
          NULL dcrcfecr, NULL dcrcclcr, USER dcrcusua, NULL dcrcterm, NULL dcrcprog, NULL dcrcsist,
          'ACTA-'||gd.id_acta acta,

          Decode(gc.account_classif_id,4,ldci_pkinterfazactas.fnuGetNitRedTerc(ga.id_contrato),
                                       gs.identification) nit,

          ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN), 0,
                                                    ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) clasificador,
          To_Char(gd.id_items) item, ga.id_contrato contrato
     FROM ge_detalle_acta gd, ge_items gi, OR_ORDER OT, ge_acta ga, ge_contrato gc, ge_contratista gco, ge_subscriber gs
    WHERE gd.id_acta = (&inuacta)
      AND gd.id_items = gi.items_id
      AND OT.order_id = GD.ID_ORDEN
      AND gd.id_acta = ga.id_acta
      AND ga.id_contrato = gc.id_contrato
      AND gc.id_contratista = gco.id_contratista
      AND gs.subscriber_id = gco.SUBSCRIBER_ID
      AND gi.item_classif_id not in (23)
      AND ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id) NOT IN (267)
      AND gd.valor_total <> 0
      -- and ot.task_type_id = 12688
    GROUP BY Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN), 0, ot.task_type_id,
             ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN)), gd.id_items, gd.geograp_location_id,
             ot.geograp_location_id, gs.identification, gi.item_classif_id, ga.extern_invoice_num,
             gd.id_acta, ga.id_contrato, gc.account_classif_id, ldci_pkinterfazactas.fvaGetCuGaCoClasi(gd.id_orden),
             ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN), GD.ID_ORDEN

   UNION ALL
   --<<
   --Cursor 3
   --Cursor que obtiene los datos de los costos a nivel de detalle de acta para
   --resolver el tema de los items agrupados en decoreco  solo multas.
   -->>
--ALTER SESSION SET CURRENT_SCHEMA= "OPEN";   
   SELECT 'consulta_3' cons, NULL dcrccons, NULL dcrcecrc, NULL dcrccorc,
          --<<
          --Mmejia
          --SAO.329776
          --Se modifica para que las multas tenga la cuenta por medio de la orden
          --Decode(gc.account_classif_id, 2,8390909001,
          --                              4,1420900100,
          --                              ldci_pkinterfazactas.fvaGetCuGaCoClasi(gd.id_orden)) cuenta,
          ldci_pkinterfazactas.fvaGetCuGaCoClasi(gd.id_orden) cuenta,
   decode(sign(SUM(gd.valor_total)), 1, 'D', 'C') signos, (SUM(gd.valor_total)) valor,
  '||||||||||'||gs.identification||'|||||'||(SELECT GEO_LOCA_FATHER_ID
                                               FROM ge_geogra_location
                                              WHERE GEOGRAP_LOCATION_ID = gd.geograp_location_id)||'|'||
                                                    gd.geograp_location_id||'||||||||||||||||'||
                                                    abs(SUM(gd.valor_total))||'||||||'||ot.task_type_id||
                                                    '|'||gi.item_classif_id||'||'||ga.extern_invoice_num||
                                                    '||||'||gd.id_items||'||'||ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN)||
                                                    '|'||GD.ID_ORDEN dcrcinad,
    null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
    'ACTA-'||gd.id_acta acta,

    --<<
    --Mmejia
    --SAO.329776
    --Se modifica para que las multas tenga la identificacino del contratista
    --sin discriminar si el contrato es tipo Red de tercero
    --Decode(gc.account_classif_id,4,ldci_pkinterfazactas.fnuGetNitRedTerc(ga.id_contrato),
    --                             gs.identification) nit,
    gs.identification nit,

    ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id) clasificador,
    To_Char(gd.id_items) item, ga.id_contrato contrato
    FROM ge_detalle_acta gd, ge_items gi, OR_ORDER OT, ge_acta ga, ge_contrato gc, ge_contratista gco, ge_subscriber gs
   WHERE gd.id_acta = (&inuacta)
     AND gd.id_items = gi.items_id
     AND OT.order_id = GD.ID_ORDEN
     and gd.id_acta = ga.id_acta
     and ga.id_contrato = gc.id_contrato
     and gc.id_contratista = gco.id_contratista
     and gs.subscriber_id = gco.SUBSCRIBER_ID
     AND gi.item_classif_id not in (23)
     AND ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id) IN (267)
     AND gd.VALOR_TOTAL <> 0
    -- and ot.task_type_id = 12688
     GROUP BY ot.task_type_id, gd.id_items, gd.geograp_location_id, ot.geograp_location_id, gs.identification, gi.item_classif_id,
     ga.extern_invoice_num, gd.id_acta, ga.id_contrato, gc.account_classif_id, gd.id_orden, ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN)

 UNION ALL
--<<
--Cursor 4
--cursor que obtiene el IVA
-->>
--<<
--heiberb 18-02-2015 se posiciona el cugacoclasi del group by
-->>
--ALTER SESSION SET CURRENT_SCHEMA= "OPEN";
 SELECT 'consulta_4' cons, NULL dcrccons, NULL dcrcecrc, NULL dcrccorc,
        Decode(gc.account_classif_id, 2,'8390909001',
                                      4,'1420900100',
                                      ldci_pkinterfazactas.fvaGetCuGaCoClasi(GD.ID_ORDEN)) cuenta,
        decode(sign(SUM(gd.valor_total)), 1, 'D', 'C') signos, (SUM(gd.valor_total)) valor,
        '||||||||||'||gs.identification||'|||||'||(SELECT geo_loca_father_id FROM ge_geogra_location
                                                    WHERE geograp_location_id = gd.geograp_location_id)
        ||'|'||gd.geograp_location_id||'||||||||||||||||'||abs(SUM(gd.base_value))||'||||||'||
        Decode(ldci_pkinterfazactas.fnuGetTipoTrab(gd.id_orden),0, ot.task_type_id,
               ldci_pkinterfazactas.fnuGetTipoTrab(gd.id_orden))||'|'||gi.item_classif_id
        ||'||'||ga.extern_invoice_num||'||||'||gd.id_items||'|'||'IVA|'||
        ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN)||'|'||GD.ID_ORDEN dcrcinad,
        null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
        'ACTA-'||gd.id_acta acta,

        Decode(gc.account_classif_id,4,ldci_pkinterfazactas.fnuGetNitRedTerc(ga.id_contrato),
                                     gs.identification) nit,

        ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id,
                                                  ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) clasificador,
        To_Char(gd.id_items) item, ga.id_contrato contrato
   FROM ge_detalle_acta gd, ge_items gi, or_order ot, ge_acta ga, ge_contrato gc, ge_contratista gco, ge_subscriber gs
  WHERE gd.id_acta = (&inuacta)
    AND gd.id_items = gi.items_id
    AND ot.order_id = gd.id_orden
    AND gd.id_acta = ga.id_acta
    AND ga.id_contrato = gc.id_contrato
    AND gc.id_contratista = gco.id_contratista
    AND gs.subscriber_id = gco.subscriber_id
    AND gd.id_items = 4001293
    AND gd.valor_total <> 0
  -- and ot.task_type_id = 12688
   GROUP BY Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN)), gd.id_items, gd.geograp_location_id, GD.ID_ORDEN,
            ot.geograp_location_id, gs.identification, gi.item_classif_id, ga.extern_invoice_num, ot.task_type_id, ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN),
            gd.id_acta, ga.id_contrato, gc.account_classif_id, ldci_pkinterfazactas.fvaGetCuGaCoClasi(gd.id_orden)

UNION ALL
   --<<
   --Cursor 5
   --Cursor para obtener el total de la cuenta por pagar
   -->>
--ALTER SESSION SET CURRENT_SCHEMA= "OPEN";   
    SELECT 'consulta_5' cons, dcrccons, dcrcecrc, dcrccorc, cuenta, Decode(Sign(SUM(valor)), -1, 'C', 1, 'D') signos,
           Abs(SUM(valor)) valor, NULL dcrcinad, dcrcfecr, dcrcclcr, dcrcusua, dcrcterm, dcrcprog,
           dcrcsist, acta, nit, clasificador, item, contrato
      FROM (SELECT NULL dcrccons, NULL dcrcecrc, NULL dcrccorc, '-1' cuenta, dcrcsign signos,
                   Round(Sum(Decode(dcrcsign, 'D', -dcrcvalo, 'C', dcrcvalo)))  valor, NULL dcrcinad,
                   NULL dcrcfecr, NULL dcrcclcr, dcrcusua, dcrcterm, dcrcprog, dcrcsist, 'ACTA-'||acta acta,
                   nit, NULL clasificador, NULL item, NULL depto, NULL locali, contrato
              FROM ic_compgene, ic_encoreco, ic_decoreco,
                   (SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta,
                           ga.extern_invoice_num factura, gs.identification nit
                      FROM ge_contratista gc ,ge_subscriber  gs, ge_acta ga, ge_contrato gco
                     WHERE gc.subscriber_id = gs.subscriber_id
                       AND gco.id_contratista = gc.id_contratista
                       AND gco.id_contrato = ga.id_contrato
                       AND ga.id_acta = &inuacta) v_deco,
                   ic_confreco, ic_clascore, ic_clascont, ldci_tipointerfaz
             WHERE cogecoco = cod_tipocomp
               AND tipointerfaz = 'L7' --Decode(ivaiclitido, ldci_pkinterfazsap.vaInterInversion, tipointerfaz, ivaiclitido)
               AND ecrccoge = cogecons
               AND ecrccons = dcrcecrc
               AND corccoco = cogecoco
               AND clcrcons = dcrcclcr
               AND clcrclco = clcocodi
               AND corccons = dcrccorc
               AND ldci_pkinterfazsap.fvaGetData(11, dcrcinad, '|') = v_deco.nit
               AND ldci_pkinterfazsap.fvaGetData(42, dcrcinad, '|') = v_deco.factura
               AND dcrccuco IN ('-1', 'G', 'A')
             GROUP BY dcrcecrc, dcrccorc, dcrccuco ,
                      dcrcfecr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,dcrcsign,
                      'ACTA-'||acta, NIT, contrato
             ORDER BY cuenta)
     GROUP BY dcrccons, dcrcecrc, dcrccorc, cuenta, dcrcinad, dcrcfecr, dcrcclcr, dcrcusua, dcrcterm,
              dcrcprog, dcrcsist, acta, nit, clasificador, item, contrato
) aa;
