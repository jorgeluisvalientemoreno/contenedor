select Hcecnuse,
       Interna, Acta_Int, (select extern_invoice_num from open.ge_acta g where id_acta = Acta_Int) Fra_Int,
       Car_x_con, Acta_Cxc, (select extern_invoice_num from open.ge_acta g where id_acta = Acta_Cxc) Fra_Cxc,
       Rev_prev, Acta_Rev, (select extern_invoice_num from open.ge_acta g where id_acta = Acta_Rev) Fra_Rev
  from (
select Hcecnuse,
       Interna, (select d.id_acta from open.ge_detalle_acta d where d.id_orden = Interna and rownum = 1) Acta_Int,
       Car_x_con, (select d.id_acta from open.ge_detalle_acta d where d.id_orden = Car_x_con and rownum = 1) Acta_Cxc,
       Rev_prev, (select d.id_acta from open.ge_detalle_acta d where d.id_orden = Rev_prev and rownum = 1) Acta_Rev
from (select hcecnuse, (select order_id from open.or_order_activity
                         where product_id = hcecnuse
                           and task_type_id in (12149)) INTERNA,
                       (select order_id from open.or_order_activity
                         where product_id = hcecnuse
                           and task_type_id in (12150)) CAR_X_CON,
                       (select order_id from open.or_order_activity
                         where product_id = hcecnuse
                           and task_type_id in (12162)) REV_PREV
  from open.hicaesco h
 where hcececan =  96
   and hcececac =  1
   and hcecfech >= '01-03-2015'
   and hcecfech <  '01-04-2015'
   and hcecserv =  7014
   and hcecnuse not in (select invmsesu from open.Ldci_Ingrevemi i where i.invmsesu = hcecnuse)))
