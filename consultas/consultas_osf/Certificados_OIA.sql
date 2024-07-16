--1701005	1701005


SELECT l.*, rowid --l.certificados_oia_id,l.resultado_inspeccion,l.status_certificado
  FROM OPEN.LDC_CERTIFICADOS_OIA L
 WHERE l.status_certificado = 'A'
   and L.ORDER_ID is not null
--and l.id_producto = 17196233
--AND L.STATUS_CERTIFICADO = open.dald_parameter.fsbgetvalue_chain('STATUS_CERTIF_OIA')
 ORDER BY L.FECHA_APROBACION DESC;
SELECT COUNT(1)
--INTO nuconta
  FROM open.or_requ_data_value k,
       open.or_order           o,
       open.or_order_activity  d,
       open.LDCCTROIACCTRL     l
 WHERE k.order_id <> 304374726
      --AND k.attribute_set_id = nugrupoatrib
   AND k.task_type_id IN
       (select nvl(to_number(column_value), 0)
          from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('TITR_VALIDA_CERTIF_RP_LEGA',
                                                                                             NULL),
                                                       ',')))
   AND TRIM(k.value_1) = TRIM('227804')
   AND o.operating_unit_id = CONTRALEGCERT
      --and l.CONTRATISTAOIA = nuorganismoinsp
      --AND d.product_id        = nuproductid
   AND k.order_id = o.order_id
   AND o.order_id = d.order_id;
SELECT certificados_oia_id, resultado_inspeccion, status_certificado
  FROM (SELECT l.certificados_oia_id,
               l.resultado_inspeccion,
               l.status_certificado
          FROM OPEN.LDC_CERTIFICADOS_OIA L
         WHERE L.ORDER_ID = 304374726
           AND L.STATUS_CERTIFICADO =
               open.dald_parameter.fsbgetvalue_chain('STATUS_CERTIF_OIA')
         ORDER BY L.FECHA_APROBACION DESC)
 WHERE ROWNUM = 1;

SELECT id_producto, id_organismo_oia, resultado_inspeccion --INTO nuproductocert,nuorganismoinsp,nuresultadoins
  FROM (SELECT c.id_producto, c.id_organismo_oia, c.resultado_inspeccion
        -- se agrega la tabla de configuracion de oia de certificacion
          FROM open.ldc_certificados_oia c, open.LDCCTROIACCTRL l
         WHERE TRIM(c.certificado) = TRIM('227804')
              --se agrega la validacion de oia de certificacion
           AND c.id_producto = 50687576
           AND c.id_organismo_oia = l.CONTRATISTAOIA
           AND l.CONTRALEGCERT = 4205
         ORDER BY c.fecha_registro DESC)
 WHERE ROWNUM = 1;
