select c.order_id,
       c.certificate_id,
       a.estado,
       a.fecha_creacion,
       a.id_tipo_acta,
       cc.id_tipo_contrato,
       tc.descripcion,
       a.id_contrato,
       cc.id_contratista,
       a.id_base_administrativa
  from open.ct_order_certifica c
 inner join open.ge_acta  a  on a.id_acta = c.certificate_id and a.estado = 'A'
inner join open.ge_contrato  cc  on cc.id_contrato = a.id_contrato
inner join open.ge_tipo_contrato  tc  on tc.id_tipo_contrato = cc.id_tipo_contrato
 where cc.id_tipo_contrato = 890
   and not exists (select null
          from open.ct_order_certifica da
         inner join open.ge_acta a2 on a2.id_acta = da.certificate_id and a2.estado = 'A'
    where da.order_id = c.order_id
   and   a2.id_contrato != a.id_contrato)
  and rownum <= 5
     order by a.fecha_creacion desc
