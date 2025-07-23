select --* 
 count(1),
 t.susp_persec_depa,
 t.susp_persec_loca,
 t.susp_persec_ciclcodi || ','
  from LDC_SUSP_PERSECUCION t, ldc_proceso_actividad lpa
 where SUSP_PERSEC_ORDER_ID is null
   and 0 = (select count(1)
              from ldc_consumo_cero lcc
             where lcc.proceso_id = 3
               and lcc.product_id = SUSP_PERSEC_PRODUCTO)
   and t.susp_persec_producto in
       (SELECT A.ID_PRODUCTO
          FROM open.pr_prod_suspension p
         INNER JOIN open.ldc_plazos_cert a
            ON a.id_producto = p.product_id
           and a.plazo_maximo > sysdate
           and p.active = 'Y'
           and p.inactive_date is null
           and p.suspension_type_id in
               (SELECT to_number(regexp_substr(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TIPO_SUSPENSION_RP',
                                                                                NULL),
                                               '[^,]+',
                                               1,
                                               LEVEL)) AS tiposusp
                  FROM dual
                CONNECT BY regexp_substr(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TIPO_SUSPENSION_RP',
                                                                          NULL),
                                         '[^,]+',
                                         1,
                                         LEVEL) IS NOT NULL)
           and OPEN.ldc_getEdadRP(p.product_id) <= 54
         INNER join open.servsusc s
            on s.sesunuse = a.id_producto)
   and 3 = lpa.proceso_id
   and t.susp_persec_depa = 4
   --and t.susp_persec_loca = 5
--   and t.susp_persec_ciclcodi = 7314
 group by t.susp_persec_depa, t.susp_persec_loca, t.susp_persec_ciclcodi
