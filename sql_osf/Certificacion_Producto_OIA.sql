--Certiifcado
SELECT * FROM OPEN.PR_CERTIfiCATE A WHERE A.Product_Id = 6516919;
SELECT * FROM OPEN.PR_CERTIfiCATE A WHERE A.Product_Id = 6528623;
--Certiifcado OIA
SELECT *
  FROM OPEN.LDC_CERTIFICADOS_OIA B
 WHERE B.CERTIFICADO = '487717'
   and b.id_organismo_oia = 4212;
select gel.*, rowid
  from open.ge_error_log gel
 where gel.error_log_id in (1411392909, 1411392910); --,1411392911,1411392908 )
--Organizmo de inspeccion
SELECT id_producto, id_organismo_oia, resultado_inspeccion
  FROM (SELECT c.id_producto, c.id_organismo_oia, c.resultado_inspeccion
        -- se agrega la tabla de configuracion de oia de certificacion
          FROM open.ldc_certificados_oia c, open.LDCCTROIACCTRL l
         WHERE TRIM(c.certificado) = TRIM('487717')
              --se agrega la validacion de oia de certificacion
           AND c.id_producto =
               (select ooa.product_id
                  from open.Or_Order_Activity ooa
                 where ooa.order_id = 264361263)
           AND c.id_organismo_oia = l.CONTRATISTAOIA
           AND l.CONTRALEGCERT =
               (SELECT ot.operating_unit_id
                  FROM open.or_order ot
                 WHERE ot.order_id = 264361263
                   AND ot.operating_unit_id IS NOT NULL)
         ORDER BY c.fecha_registro DESC)
 WHERE ROWNUM = 1;
--Certiifcado en ordenes legalizadasOIA
SELECT *
  FROM open.or_requ_data_value k,
       open.or_order           o,
       open.or_order_activity  d,
       open.LDCCTROIACCTRL     l
 WHERE /*k.order_id <> 264361263
   AND */
 k.attribute_set_id =
 open.dald_parameter.fnuGetNumeric_Value('COD_GRUPO_DATO_ADIC_VAL_CERTI',
                                         NULL)
 AND k.task_type_id IN
 (select nvl(to_number(column_value), 0)
    from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('TITR_VALIDA_CERTIF_RP_LEGA',
                                                                                       NULL),
                                                 ',')))
 AND TRIM(k.value_1) = TRIM('487717')
 AND o.operating_unit_id = CONTRALEGCERT
 and l.CONTRATISTAOIA = 4212
 AND d.product_id = 6516919
 AND k.order_id = o.order_id
 AND o.order_id = d.order_id;
select ooa.*, rowid
  from open.Or_Order_Activity ooa
 where ooa.order_id = 264361263;
select oo.*, rowid
  from open.or_order oo
 where oo.order_id in (264361263, /*186459988,*/ 258226403);
select *
  from open.or_operating_unit a
 where a.operating_unit_id in (2732, 4212);
