ALTER SESSION SET CURRENT_SCHEMA= "OPEN";
SELECT *    FROM  (  
            SELECT
                  To_Char(B.clasificador) CLASIFICADOR,
                  To_Char(replace(CLCODESC,',','.'))  DESC_CLASCONT, 
                  To_Char(Tipo_Producto||' - '||Decode(Tipo_Producto,NULL,'',OPEN.pktblservicio.fsbGetservdesc(Tipo_Producto))) TIPO_PRODUCTO,
                  To_Char(categoria)  COD_CATEGORIA,
                  To_Char(Decode(categoria,NULL,'',OPEN.dacategori.fsbgetcatedesc(categoria)))  DESC_CATEGORIA,
--                  To_Char(causal) COD_CAUSAL,
--                  To_Char((SELECT  ccrccamp||'  -  '||ccrcoper||' - '||ccrcvalo FROM  ic_crcoreco  WHERE  CCRCCLCR = clcrcons  and  ccrccamp like  '%MOVICACA%'))  Causal,
                  B.TipoDocumento,
                  B.TipoMovimiento,
                  (SELECT TIMODESC  FROM open.ic_tipomovi  WHERE  TIMOCODI = B.TipoMovimiento  and  rownum=1)  DES_TIPOMOVI,
                  To_Char(clcrcons) clcrcons,
                  OPEN.ldci_pkinterfazsap.fvaGetClaveContaPagos(B.clasificador,B.cuenta,signo,100) CLAVE,
                  cuenta,
                  B.Comprobante, 
                  SUM(decode(signo, 'D', B.valor, -B.valor)) valor
            FROM
                  (SELECT 
                         (
                            SELECT  DISTINCT a.rcccpopa FROM ic_recoclco a WHERE clcrcons=a.rcccclcr AND a.rccccuco=dcrccuco) porcent,
                                    To_Char((SELECT  ccrcoper||'  '||ccrcvalo  FROM ic_crcoreco WHERE CCRCCLCR  =  clcrcons and ccrccamp  like '%MOVITIHE%')) TIPOHECHO,
                                    Nvl(ldci_pkinterfazsap.fvaGetData(5,dcrcinad,'|'),NULL)  categoria,
                                    Nvl(ldci_pkinterfazsap.fvaGetData(6,dcrcinad,'|'),NULL)  sub_categoria,
                                    Nvl(ldci_pkinterfazsap.fvaGetData(10,dcrcinad,'|'),NULL) Tipo_Producto,
                                    Nvl(ldci_pkinterfazsap.fvaGetData(17,dcrcinad,'|'),NULL) Localidad,
                                    Nvl(ldci_pkinterfazsap.fvaGetData(41,dcrcinad,'|'),NULL) causal,
                                    dcrcecrc,
                                    dcrccorc,
                                    dcrccuco cuenta,
                                    dcrcsign signo,
                                    SUM(dcrcvalo) valor,
                                    dcrcinad,
                                    dcrcusua,
                                    dcrcterm,
                                    dcrcprog,
                                    dcrcsist,
                                    clcrclco clas_orig,
                                    clcrclco clasificador,CLCODESC,
                                    corccoco Comprobante,
                                    corctido TipoDocumento,
                                    corctimo TipoMovimiento,
                                    clcrcons
                            FROM  ic_encoreco
                            JOIN  ic_decoreco ON (ecrccons = dcrcecrc)
                            JOIN  ic_confreco ON (dcrccorc = corccons)
                            JOIN  ic_clascore ON (clcrcons = dcrcclcr)
                            JOIN  ic_clascont ON (clcrclco =clcocodi) 
                            WHERE  ecrccoco IN (select cod_comprobante from OPEN.LDCI_TIPOINTERFAZ where tipointerfaz = 'L1' /*and cod_comprobante = 1*/)
                            AND    ecrcfech  BETWEEN  '09/02/2015' and '28/02/2015'
                            GROUP  BY dcrcecrc,clcrcons,CLCODESC,dcrccorc,dcrccuco,dcrcsign,dcrcinad,corctimo,--TRUNC(dcrcfecr),
                                     dcrcusua,dcrcterm,dcrcprog,dcrcsist,clcrclco,corccoco,corctido,/*TRUNC(ecrcfech),*/clcrcons
                  )  B
            GROUP  BY clcrcons, Tipo_Producto,categoria,B.TipoMovimiento,causal,B.clasificador,CLCODESC,B.cuenta,B.signo,
                      clas_orig, B.Comprobante,B.TipoDocumento,categoria)

                     
