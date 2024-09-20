ALTER SESSION SET CURRENT_SCHEMA= "OPEN";
SELECT dcrccons, dcrcecrc, dcrccorc, dcrccuco cuenta, dcrcsign signos, dcrcvalo valor,
         dcrcinad, dcrcfecr, dcrcclcr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,
         'ACTA-'||acta acta, NIT, clcrclco clasificador, ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') item, contrato
  FROM ic_compgene, ic_encoreco, ic_decoreco,(SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta,
         ga.EXTERN_INVOICE_NUM factura, gs.identification NIT
  FROM ge_contratista gc ,ge_subscriber  gs, ge_acta ga, ge_contrato gco
 WHERE gc.SUBSCRIBER_ID = gs.SUBSCRIBER_ID
   AND gco.id_contratista = gc.id_contratista
   AND gco.id_contrato = ga.id_contrato
   AND ga.id_acta = &acta) v_deco, ic_confreco, ic_clascore, ic_clascont, ldci_tipointerfaz
 WHERE COGECOCO = cod_tipocomp
   AND tipointerfaz = Decode('&tipo', 'L9', tipointerfaz, '&tipo')
   AND ECRCCOGE = cogecons
   AND ECRCCONS = dcrcecrc
   AND CORCCOCO = COGECOCO
   AND clcrcons = dcrcclcr
   AND clcrclco = clcocodi
   and CORCCONS = DCRCCORC
   AND ldci_pkinterfazsap.fvaGetData(11, DCRCINAD, '|') = v_deco.nit
   AND ldci_pkinterfazsap.fvaGetData(42, DCRCINAD, '|') = v_deco.factura
   AND ldci_pkinterfazsap.fvaGetData(40, DCRCINAD, '|') in (SELECT item_classif_id
                          FROM ge_item_classif
                         WHERE ',' || ',23,' || ',' LIKE
                               '%,' || item_classif_id || ',%')
   AND dcrccuco <> '-1'
  -- AND ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') in (4295236)
   and round(dcrcvalo) <> 0


