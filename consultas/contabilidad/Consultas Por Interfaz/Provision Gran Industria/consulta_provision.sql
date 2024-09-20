ALTER SESSION SET CURRENT_SCHEMA= "OPEN";
SELECT         'L5' DocumentoSAP,
                     (select distinct a.rcccpopa from ic_recoclco a where clcrcons=a.rcccclcr and a.rccccuco=dcrccuco) porcent,
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
                     (select cocodesc from ic_compcont where cococodi=ecrccoco) DescComprobante,
                     corctido TipoComprobante,
                     (select tccodesc from ic_ticocont
                          where tccocodi =  (select distinct cocotcco from ic_compcont where cococodi=ecrccoco)
                     ) DescTipoComprobante,
                     ecrcfech
        FROM       ic_encoreco
        JOIN       ic_decoreco on (ecrccons = dcrcecrc)
        JOIN       ic_confreco on (dcrccorc = corccons )
        JOIN       ic_clascore on (clcrcons = dcrcclcr)
        JOIN       ic_clascont on (clcrclco=clcocodi)
        WHERE      ecrccoco in (SELECT COD_COMPROBANTE from LDCI_TIPOINTERFAZ WHERE TIPOINTERFAZ ='LC')
        AND        ecrcfech BETWEEN '03-10-2015' and '03-10-2015' ;
