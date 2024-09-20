SELECT *    
  FROM  (  
      SELECT Comprobante, (select co.cocodesc from open.ic_compcont co where co.cococodi = comprobante) Descripcion,
            B.TipoDocumento,
            B.TipoMovimiento,
            (SELECT TIMODESC  FROM open.ic_tipomovi  WHERE  TIMOCODI = B.TipoMovimiento  and  rownum=1)  DES_TIPOMOVI,            
            To_Char(B.clasificador) CLASIFICADOR,
            To_Char(replace(CLCODESC,',','.'))  DESC_CLASCONT, 
            To_Char(Tipo_Producto||' - '||Decode(Tipo_Producto,NULL,'',OPEN.pktblservicio.fsbGetservdesc(Tipo_Producto))) TIPO_PRODUCTO,
            To_Char(causal) COD_CAUSAL,
            To_Char((SELECT  ccrccamp||'  -  '||ccrcoper||' - '||ccrcvalo FROM open.ic_crcoreco  WHERE  CCRCCLCR = clcrcons  and  ccrccamp like  '%MOVICACA%'))  Causal,
            To_Char(clcrcons) clcrcons,
  --                  OPEN.ldci_pkinterfazsap.fvaGetClaveContaPagos(B.clasificador,B.cuenta,signo,100) CLAVE,
            cuenta,
            signo, 
            SUM(B.valor) valor 
      FROM
            (SELECT 
                   (
                      SELECT  DISTINCT a.rcccpopa FROM open.ic_recoclco a WHERE clcrcons=a.rcccclcr AND a.rccccuco=dcrccuco) porcent,
                              Nvl(open.ldci_pkinterfazsap.fvaGetData(5,dcrcinad,'|'),NULL)  categoria,
                              Nvl(open.ldci_pkinterfazsap.fvaGetData(6,dcrcinad,'|'),NULL)  sub_categoria,
                              Nvl(open.ldci_pkinterfazsap.fvaGetData(10,dcrcinad,'|'),NULL) Tipo_Producto,
                              Nvl(open.ldci_pkinterfazsap.fvaGetData(17,dcrcinad,'|'),NULL) Localidad,
                              Nvl(open.ldci_pkinterfazsap.fvaGetData(41,dcrcinad,'|'),NULL) causal,
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
                              open.ldci_pkinterfazsap.fvaGetData(30,dcrcinad,'|') FechaPago,clcrcons
                      FROM  open.ic_encoreco
                      JOIN  open.ic_decoreco ON (ecrccons = dcrcecrc)
                      JOIN  open.ic_confreco ON (dcrccorc = corccons)
                      JOIN  open.ic_clascore ON (clcrcons = dcrcclcr)
                      JOIN  open.ic_clascont ON (clcrclco =clcocodi) 
                      WHERE  ecrccoco IN (select cod_comprobante from OPEN.LDCI_TIPOINTERFAZ where tipointerfaz = 'L1')
                      AND    ecrcfech  BETWEEN '01-07-2022' and '31-07-2022'
                      GROUP  BY dcrcecrc,clcrcons,CLCODESC,dcrccorc,dcrccuco,dcrcsign,dcrcinad,corctimo,
                               dcrcusua,dcrcterm,dcrcprog,dcrcsist,clcrclco,corccoco,corctido,clcrcons
            )  B
      GROUP  BY clcrcons,Tipo_Producto,categoria,sub_categoria, dcrcinad,B.TipoMovimiento,causal,B.FechaPago,B.clasificador,
               CLCODESC,B.cuenta,B.signo,clas_orig,B.Comprobante,B.TipoDocumento,categoria,localidad)
