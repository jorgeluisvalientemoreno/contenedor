select count(*),COD_TIPCOMPROBANTE,
       CLCRCONS,
       DESC_TIPCOMPROBANTE,
       COD_COMPROBANTE,
       DES_COMPROBANTE,
       DESC_TIPODOCUMENTO,
       COD_TIPOMOVIMIENTO,
       DESC_TIPOMOVIMIENTO,
       COD_CLASCONT,
       DESC_CLASCONT,
       CTA_CONTABLE_DB, (select CUCTDESC from OPEN.LDCI_CUENTACONTABLE where cuctcodi = CTA_CONTABLE_DB) desc_cuenta,
       CTA_CONTABLE_CR,
       CRITERIO,
       substr(CRITERIO,(regexp_instr(CRITERIO,'[0-9]')),9) item,
       (select description from OPEN.GE_ITEMS where items_id = (ltrim(rtrim(substr(CRITERIO,(regexp_instr(CRITERIO,'[0-9]')),9))))) desc_item
      ,porcentaje
      --(SELECT itemtire||' ; '||iteminre||' ; '||itemcate FROM OPEN.ldci_intemindica WHERE itemcodi = (ltrim(rtrim(substr(CRITERIO,(instr(CRITERIO, '=')+1), 30))))
      --  AND itemclco = COD_CLASCONT) indicadores
      -- ,(SELECT descripcion||' ; '||porcentaje||' ; '||tipo_retencion FROM OPEN.ldc_tipo_actividad tc WHERE tc.tipo_actividad_id = ldcii.type_activity)
       from (
SELECT
       COD_TIPCOMPROBANTE,
       DESC_TIPCOMPROBANTE,
       COD_COMPROBANTE,
       DES_COMPROBANTE,
       DESC_TIPODOCUMENTO,
       COD_TIPOMOVIMIENTO,
       DESC_TIPOMOVIMIENTO,
       COD_CLASCONT,
       DESC_CLASCONT,
       DOMINIO,
       VALOR_REPORTAR,
       max(CTA_CONTABLE_DB) CTA_CONTABLE_DB,
       max(CTA_CONTABLE_CR) CTA_CONTABLE_CR,
       CLCRCONS,
       CRITERIO,
       porcentaje
 FROM (
  SELECT
         A.COCOCODI COD_COMPROBANTE,
         A.COCODESC DES_COMPROBANTE,
         B.TCCOCODI COD_TIPCOMPROBANTE,
         B.TCCODESC DESC_TIPCOMPROBANTE,
         D.TIDCDESC DESC_TIPODOCUMENTO,
         E.TIMOCODI COD_TIPOMOVIMIENTO,
         E.TIMODESC DESC_TIPOMOVIMIENTO,
         F.CLCRCONS,
         G.CLCOCODI COD_CLASCONT,
         G.CLCODESC DESC_CLASCONT,
         DECODE(G.CLCODOMI,'C','Concepto','B','Banco','T''Tipo Trabajo') DOMINIO,
         DECODE(I.RCCCVALO,'V','Valor Total',I.RCCCVALO) VALOR_REPORTAR,
         decode (I.RCCCNATU,'D',I.RCCCCUCO) CTA_CONTABLE_DB,
         decode (I.RCCCNATU,'C',I.RCCCCUCO) CTA_CONTABLE_CR,
         I.RCCCPOPA porcentaje,
         J.CCRCCAMP||' '||J.CCRCOPER||' '||J.CCRCVALO CRITERIO
  FROM  OPEN.IC_COMPCONT A, OPEN.IC_TICOCONT B, OPEN.IC_CONFRECO C, OPEN.IC_TIPODOCO D,
        OPEN.IC_TIPOMOVI E, OPEN.IC_CLASCORE F, OPEN.IC_CLASCONT G, OPEN.IC_RECOCLCO I, open.IC_CRCORECO J
  WHERE
        J.CCRCCLCR(+)=F.CLCRCONS and
        A.COCOCODI=C.CORCCOCO(+) AND
        C.CORCTIDO=D.TIDCCODI(+) AND
        C.CORCTIMO=E.TIMOCODI(+) AND
        C.CORCCONS=F.CLCRCORC(+) AND
        F.CLCRCLCO=G.CLCOCODI(+) AND
        F.CLCRCONS=I.RCCCCLCR(+) AND
        A.COCOTCCO=B.TCCOCODI(+) and
        B.TCCOCODI = 4
         )
        GROUP BY
        COD_COMPROBANTE,
       DES_COMPROBANTE,
       COD_TIPCOMPROBANTE,
       DESC_TIPCOMPROBANTE,
       DESC_TIPODOCUMENTO,
       COD_TIPOMOVIMIENTO,
       DESC_TIPOMOVIMIENTO,
       CLCRCONS,
       COD_CLASCONT,
       DESC_CLASCONT,
       DOMINIO,
       VALOR_REPORTAR,
       criterio,
       porcentaje
       ORDER BY COD_CLASCONT, CTA_CONTABLE_DB)
     where substr(CRITERIO,(regexp_instr(CRITERIO,'[0-9]')),9) = '100002140'       
       group by COD_TIPCOMPROBANTE,
       DESC_TIPCOMPROBANTE,
       COD_COMPROBANTE,
       DES_COMPROBANTE,
       DESC_TIPODOCUMENTO,
       COD_TIPOMOVIMIENTO,
       DESC_TIPOMOVIMIENTO,
       COD_CLASCONT,
       DESC_CLASCONT,
       DOMINIO,
       VALOR_REPORTAR, CTA_CONTABLE_DB,CTA_CONTABLE_CR,
       criterio,
       porcentaje, CLCRCONS