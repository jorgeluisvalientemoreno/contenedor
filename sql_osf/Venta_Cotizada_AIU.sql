select co.*, rowid
  from open.ldc_cotizacion_comercial co
 where 1 = 1
      --and co.id_cot_comercial in (9897)
      --and co.fecha_registro >= sysdate - 50
   and co.estado = 'R'
 order by co.id_cot_comercial desc;

select * -- sum(precio_total) Precio_total , sum(iva) IVA_total, sum(precio_total) + sum(iva) TOTAL_COTIZACION
  from OPEN.LDC_ITEMS_COTIZACION_COM cm --, open.ge_items i
 where cm.id_cot_comercial = 9897
--and cm.id_item = i.items_id
 order by cm.tipo_trabajo, cm.id_item;

select t.*, t.rowid from open.DATOS_COTIZACION_COMERCIAL t;

select *
  from open.cc_quotation q
 where q.package_id = (select co.sol_cotizacion
                         from open.ldc_cotizacion_comercial co
                        where co.id_cot_comercial = 9897);

select *
  from open.cc_quoted_work qw
 where qw.quotation_id in
       (select q.quotation_id
          from open.cc_quotation q
         where q.package_id =
               (select co.sol_cotizacion
                  from open.ldc_cotizacion_comercial co
                 where co.id_cot_comercial = 9897));

select *
  from open.cc_quotation_item qi
 where qi.quotation_id in
       (select q.quotation_id
          from open.cc_quotation q
         where q.package_id =
               (select co.sol_cotizacion
                  from open.ldc_cotizacion_comercial co
                 where co.id_cot_comercial = 9897));

select *
  from open.cc_quot_financ_cond cc
 where cc.quotation_id in
       (select q.quotation_id
          from open.cc_quotation q
         where q.package_id =
               (select co.sol_cotizacion
                  from open.ldc_cotizacion_comercial co
                 where co.id_cot_comercial = 9897));
