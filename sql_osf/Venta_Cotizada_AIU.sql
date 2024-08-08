select co.*, rowid
  from open.ldc_cotizacion_comercial co
 where co.id_cot_comercial = co.id_cot_comercial--7772
   --and co.fecha_registro >= sysdate - 50
 order by co.id_cot_comercial desc;
select *
  from OPEN.LDC_ITEMS_COTIZACION_COM cm, open.ge_items i
 where cm.id_cot_comercial = 7772
   and cm.id_item = i.items_id;

select t.*, t.rowid from DATOS_COTIZACION_COMERCIAL t;
select *
  from open.cc_quotation q
 where q.package_id = (select co.sol_cotizacion
                         from open.ldc_cotizacion_comercial co
                        where co.id_cot_comercial = 7772);
select *
  from open.cc_quoted_work qw
 where qw.quotation_id in
       (select q.quotation_id
          from open.cc_quotation q
         where q.package_id =
               (select co.sol_cotizacion
                  from open.ldc_cotizacion_comercial co
                 where co.id_cot_comercial = 7772));
select *
  from open.cc_quotation_item qi
 where qi.quotation_id in
       (select q.quotation_id
          from open.cc_quotation q
         where q.package_id =
               (select co.sol_cotizacion
                  from open.ldc_cotizacion_comercial co
                 where co.id_cot_comercial = 7772));
select *
  from open.cc_quot_financ_cond cc
 where cc.quotation_id in
       (select q.quotation_id
          from open.cc_quotation q
         where q.package_id =
               (select co.sol_cotizacion
                  from open.ldc_cotizacion_comercial co
                 where co.id_cot_comercial = 7772));

select *
  from open.mo_packages mp, open.mo_motive mm
 where mp.package_id = mm.package_id
   and mm.product_id = 52756763;
