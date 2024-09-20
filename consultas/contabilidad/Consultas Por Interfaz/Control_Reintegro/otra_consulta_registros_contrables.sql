SELECT e.tipointerfaz TipoInterfaz,
       c.ecrcfech Fecha,
       --open.ldci_pkinterfazsap.fvaGetData(14, d.dcrcinad, '|') DocumentoSoporte,
       --open.ldci_pkinterfazsap.fvaGetData(30, dcrcinad, '|') FechaTransaccion,
       d.dcrcsign SIGNO,
       d.dcrcvalo VALOR,
       --open.ldci_pkinterfazsap.fvaGetData(35, d.dcrcinad, '|') Cod_TipoEntidad,
       open.ldci_pkinterfazsap.fvaGetData(45, d.dcrcinad, '|') Cod_Entidad,
       --open.ldci_pkinterfazsap.fvaGetData(34, d.dcrcinad, '|') Nit_Bancorecauda,
       open.ldci_pkinterfazsap.fvaGetData(36, d.dcrcinad, '|') Nit_Banco,
       open.ldci_pkinterfazsap.fvaGetData(8, d.dcrcinad, '|')  Cod_BancoTransaccion,
       --open.ldci_pkinterfazsap.fvaGetData(13, d.dcrcinad, '|') Conciliacion,
       DCRCCUCO CuentaContable
  FROM open.ic_ticocont a, open.ic_compcont b, open.ic_encoreco c, open.ic_decoreco d,
       open.ldci_tipointerfaz e, open.ic_confreco f
 WHERE trunc(c.ecrcfech) BETWEEN ('&FECHA_INICIAL') AND ('&FECHA_FINAL')
   AND a.TCCOCODI = b.COCOTCCO
   AND a.TCCOCODI = 8
   AND b.COCOCODI = c.ECRCCOCO
   AND c.ecrccons = d.dcrcecrc
   AND b.COCOCODI = e.cod_comprobante
   AND d.dcrccorc = f.corccons
   AND d.dcrcsign = 'D'
