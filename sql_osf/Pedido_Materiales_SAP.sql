select t.trsmcodi Pedido,
       t.trsmcont || ' - ' || gc.descripcion Contratista,
       --t.trsmprov Proveedor,
       t.trsmunop || ' - ' || oou.name Unidad_Operativa,
       t.trsmfecr Fecha_Pedifo,
       --t.trsmesta Estado_Pedido,
       /*t.trsmofve,
       t.trsmvtot,
       t.trsmdore,
       t.trsmdsre,
       t.trsmmdpe,
       t.trsmusmo,
       t.trsmmpdi,
       t.trsmacti,
       t.trsmsol,
       t.trsmtipo,
       t.trsmprog,
       t.order_id,
       t.trsmcome,*/
       t.trsmobse Observacion
  from OPEN.LDCI_TRANSOMA t
 inner join open.or_operating_unit oou
    on oou.operating_unit_id = t.trsmunop
 inner join open.ge_contratista gc
    on gc.id_contratista = oou.contractor_id
 where TRSMCODI = 260756;
select l.result_process_id,
       l.request_material_id,
       l.estado_anterior || ' - ' || lt_ea.descripcion,
       l.estado_nuevo || ' - ' || lt_en.descripcion,
       l.user_,
       l.register_date,
       l.comment_,
       l.terminal
  from open.LDC_RESULT_PROCESS_PEDIDOVENTA l
  left join open.LDCI_TRANESTA lt_ea
    on lt_ea.codigo = l.estado_anterior
  left join open.LDCI_TRANESTA lt_en
    on lt_en.codigo = l.estado_nuevo
 where l.request_material_id in (260756)
 order by l.register_date desc;
