ALTER SESSION SET CURRENT_SCHEMA= "OPEN";
select dcrcinad, ldci_pkinterfazsap.fvaGetData(50,dcrcinad,'|') orden from (
SELECT NULL dcrccons, NULL dcrcecrc, NULL dcrccorc,
          Decode(gc.account_classif_id, To_Number(4),'12343',
                                        5,'12345',
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

          Decode(gc.account_classif_id,5,ldci_pkinterfazactas.fnuGetNitRedTerc(ga.id_contrato),
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
      AND gi.item_classif_id not in (SELECT item_classif_id
                                       FROM ge_item_classif
                                      WHERE ',' || ',23,' || ',' LIKE
                                             '%,' || item_classif_id || ',%')
      AND ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id)
          NOT IN (SELECT clcocodi FROM ic_clascont
                   WHERE ',' || 267 || ',' LIKE '%,' || clcocodi || ',%')
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
   SELECT NULL dcrccons, NULL dcrcecrc, NULL dcrccorc,
          --<<
          --Mmejia
          --SAO.329776
          --Se modifica para que las multas tenga la cuenta por medio de la orden
          --Decode(gc.account_classif_id, To_Number(ldci_pkinterfazactas.vaClasifContrato),ldci_pkinterfazactas.vaCuentaL9,
          --                              To_Number(ldci_pkinterfazactas.gvaClasifContRedTerc),ldci_pkinterfazactas.gvaCuentacontRedTerc,
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
    --Decode(gc.account_classif_id,To_Number(ldci_pkinterfazactas.gvaClasifContRedTerc),ldci_pkinterfazactas.fnuGetNitRedTerc(ga.id_contrato),
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
     AND gi.item_classif_id not in (SELECT item_classif_id
                            FROM ge_item_classif
                           WHERE ',' || ',23,' || ',' LIKE
                                 '%,' || item_classif_id || ',%')
     AND ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id) IN (SELECT clcocodi
                            FROM ic_clascont
                           WHERE ',' || 267 || ',' LIKE
                                 '%,' || clcocodi || ',%')
     AND gd.VALOR_TOTAL <> 0
    -- and ot.task_type_id = 12688
     GROUP BY ot.task_type_id, gd.id_items, gd.geograp_location_id, ot.geograp_location_id, gs.identification, gi.item_classif_id,
     ga.extern_invoice_num, gd.id_acta, ga.id_contrato, gc.account_classif_id, gd.id_orden, ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN));

