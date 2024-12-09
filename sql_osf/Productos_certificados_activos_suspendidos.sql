SELECT a.id_contrato Contrato,
       A.ID_PRODUCTO Producto,
       p.suspension_type_id Tipo_Suspension,
       DECODE(S.SESUESFN,
              'A',
              'AL DIA',
              'D',
              'CON DEUDA',
              'C',
              'CASTIGADO',
              'M',
              'MORA',
              S.SESUESFN) Estado_Financiero,
       (select (select l.numeric_value
                  from open.ld_parameter l
                 where l.parameter_id = 'LDC_MESES_VALIDEZ_CERT') -
               months_between(trunc(to_date(plazo_maximo), 'MONTH'),
                              trunc(sysdate, 'MONTH'))
          from open.LDC_PLAZOS_CERT
         where id_producto = p.product_id) Meses
  FROM open.pr_prod_suspension p
  JOIN open.ldc_plazos_cert a
    ON a.id_producto = p.product_id
   and a.plazo_maximo > sysdate
   and p.active = 'Y'
   and p.inactive_date is null
--and p.suspension_type_id in (101, 102, 103, 104)
--and OPEN.ldc_getEdadRP(p.product_id) <= 55
  join open.servsusc s
    on s.sesunuse = a.id_producto
   and s.sesususc = 67506235

/*SELECT A.ID_PRODUCTO Producto, p.suspension_type_id TS \*,
       (select open.dald_parameter.fnuGetNumeric_Value('LDC_MESES_VALIDEZ_CERT') -
               months_between(trunc(to_date(plazo_maximo), 'MONTH'),
                              trunc(sysdate, 'MONTH'))
          from open.LDC_PLAZOS_CERT
         where id_producto = p.product_id)*\
  FROM open.pr_prod_suspension p
  JOIN open.ldc_plazos_cert a
    ON a.id_producto = p.product_id
   and a.plazo_maximo > sysdate
   and p.active = 'Y'
   and p.inactive_date is null
   and p.suspension_type_id in (101, 102, 103, 104)
      --and p.product_id = 2087913
   and OPEN.ldc_getEdadRP(p.product_id) <= 55
--and OPEN.ldc_getEdadRP(p.product_id) >54
  join open.servsusc s
    on s.sesunuse = a.id_producto
   and s.sesuesfn not in ('C');
*/
