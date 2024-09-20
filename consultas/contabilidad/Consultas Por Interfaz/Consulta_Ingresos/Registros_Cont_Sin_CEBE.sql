                SELECT
                         100 porcent,
                         dcrccons,
                         dcrcecrc,
                         dcrccorc,
                         dcrccuco cuenta,
                         dcrcsign signos,
                         dcrcvalo valor,
                         dcrcinad,
                         dcrcfecr,
                         dcrcclcr,
                         dcrcusua,
                         dcrcterm,
                         dcrcprog,
                         dcrcsist,
                         clcrclco clasificador,
                         clcodesc,
                         corccoco Comprobante ,
                         (select cocodesc from open.ic_compcont where cococodi=ecrccoco) DescComprobante,
                         corctido TipoComprobante,
                         (select tccodesc from open.ic_ticocont
                              where tccocodi =  (select distinct cocotcco from open.ic_compcont where cococodi=ecrccoco)
                         ) DescTipoComprobante,
                         ecrcfech
                         , ledgers, open.ldci_pkinterfazsap.fvaGetData(17,dcrcinad,'|') Localidad
                FROM           open.ic_encoreco
                JOIN           open.ic_decoreco on (ecrccons = dcrcecrc)
                JOIN           open.ic_confreco on (dcrccorc = corccons )
                JOIN           open.ic_clascore on (clcrcons = dcrcclcr)
                JOIN           open.ic_clascont on (clcrclco=clcocodi)
                JOIN           open.LDCI_TIPOINTERFAZ on ( corccoco = COD_COMPROBANTE AND TIPOINTERFAZ  = 'L1')
                WHERE          ecrcfech >= '01-11-2015'
                AND            ecrcfech <= '30-11-2015' /*Fecha diaria, con la cual se generan los documentos*/
                AND            clcrclco NOT IN (SELECT TO_NUMBER(COLUMN_VALUE)
                                                  FROM TABLE(open.LDC_BOUTILITIES.SPLITSTRINGS(2,',') ))
                AND            open.ldci_pkinterfazsap.fvaGetData(17,dcrcinad,'|')
                               not in (select ll.celoloca from open.ldci_centbenelocal ll
                                        where ll.celoloca = open.ldci_pkinterfazsap.fvaGetData(17,dcrcinad,'|'))
