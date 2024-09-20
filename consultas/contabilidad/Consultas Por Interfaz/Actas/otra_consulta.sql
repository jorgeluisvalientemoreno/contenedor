  SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta, ga.EXTERN_INVOICE_NUM factura, cod_comprobante
  FROM open.ge_contratista gc ,open.ge_subscriber  gs, open.ge_acta ga, open.ge_contrato gco,
  (SELECT DISTINCT(open.ldci_pkinterfazsap.fvaGetData(11, DCRCINAD, '|')) nit, (open.ldci_pkinterfazsap.fvaGetData(42, DCRCINAD, '|')) factura, cod_comprobante
  FROM open.ic_encoreco, open.ic_decoreco, open.ldci_tipointerfaz
 WHERE ECRCCOCO = cod_comprobante
   AND ECRCCONS = dcrcecrc
   AND tipointerfaz = 'L7' --ivaiclitido
   AND Trunc(dcrcfecr) BETWEEN '01-08-2015' AND '31-08-2015'
   AND dcrccuco NOT IN ('A', 'G')) v_acta
 WHERE gc.SUBSCRIBER_ID = gs.SUBSCRIBER_ID
   AND gs.IDENTIFICATION = v_acta.nit
   AND gco.id_contratista = gc.id_contratista
   AND gco.id_contrato = ga.id_contrato
   AND ga.EXTERN_INVOICE_NUM = v_acta.factura
   AND ga.id_acta = Decode(14860, -1, ga.id_acta, 14860)
   AND ga.id_acta NOT IN (SELECT idacta
                            FROM open.ldci_actacont
                           WHERE actcontabiliza = 'S'
                             AND idacta = Decode(14860, -1, ga.id_acta, 14860))
