ALTER SESSION SET CURRENT_SCHEMA= "OPEN";
SELECT NULL dcrccons, NULL dcrcecrc, NULL dcrccorc, '-1' cuenta, dcrcsign signos, Round(Sum(Decode(dcrcsign, 'D', -dcrcvalo, 'C', dcrcvalo)))  valor,
            NULL dcrcinad, null dcrcfecr, null dcrcclcr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,
            'ACTA-'||acta acta, NIT, null clasificador, NULL item,
            NULL depto,
            NULL locali,
            contrato
      FROM ic_compgene, ic_encoreco, ic_decoreco,(SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta,
            ga.EXTERN_INVOICE_NUM factura, gs.identification NIT
      FROM ge_contratista gc ,ge_subscriber  gs, ge_acta ga, ge_contrato gco
    WHERE gc.SUBSCRIBER_ID = gs.SUBSCRIBER_ID
      AND gco.id_contratista = gc.id_contratista
      AND gco.id_contrato = ga.id_contrato
      AND ga.id_acta = &inuacta) v_deco, ic_confreco, ic_clascore, ic_clascont, ldci_tipointerfaz
    WHERE COGECOCO = cod_tipocomp
      AND tipointerfaz = Decode('L7', 'L9', tipointerfaz, 'L7')
      AND ECRCCOGE = cogecons
      AND ECRCCONS = dcrcecrc
      AND CORCCOCO = COGECOCO
      AND clcrcons = dcrcclcr
      AND clcrclco = clcocodi
      and CORCCONS = DCRCCORC
      AND ldci_pkinterfazsap.fvaGetData(11, DCRCINAD, '|') = v_deco.nit
      AND ldci_pkinterfazsap.fvaGetData(42, DCRCINAD, '|') = v_deco.factura
      AND dcrccuco in ('-1', 'G', 'A')
      GROUP BY dcrcecrc, dcrccorc, dcrccuco ,
            dcrcfecr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,dcrcsign,
            'ACTA-'||acta, NIT, contrato
            ORDER BY CUENTA
