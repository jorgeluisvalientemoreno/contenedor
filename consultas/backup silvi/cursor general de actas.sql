  SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta,
         ga.EXTERN_INVOICE_NUM factura, cod_comprobante, ga.id_tipo_acta, ga.numero_fiscal,
          v_acta.empresa
  FROM ge_contratista gc ,ge_subscriber  gs, ge_acta ga, ge_contrato gco,
       (SELECT DISTINCT(ldci_pkinterfazsap.fvaGetData(11, DCRCINAD, '|')) nit,
               ldci_pkinterfazsap.fvaGetData(42, DCRCINAD, '|') factura,
               cod_comprobante, empresa
        FROM ic_encoreco, ic_decoreco, ldci_tipointerfaz
        WHERE ecrccoco = cod_comprobante
          AND ecrcfech BETWEEN '10/03/2025' AND '13/05/2025' --No hay Actas a Procesar 242955 ivaiclitido L7 idafechaini 10-03-2025 00:00:00 idafechafin 13-05-2025 00:00:00
          AND dcrcecrc = ecrccons
          AND dcrccuco NOT IN ('A', 'G')
          AND tipointerfaz = 'L7'
        ) v_acta
 WHERE gc.SUBSCRIBER_ID = gs.SUBSCRIBER_ID
   AND gs.IDENTIFICATION = v_acta.nit
   AND gco.id_contratista = gc.id_contratista
   AND gco.id_contrato = ga.id_contrato
   AND ga.EXTERN_INVOICE_NUM = v_acta.factura
   AND pkg_boconsultaempresa.fsbObtEmpresaContratista(gc.id_contratista ) = v_acta.empresa
   AND ga.id_acta = Decode(242955, -1, ga.id_acta, 242955)
   AND ga.id_acta NOT IN (SELECT idacta
                            FROM ldci_actacont
                           WHERE actcontabiliza = 'S'
                             AND idacta = Decode(242955, -1, ga.id_acta, 242955));
