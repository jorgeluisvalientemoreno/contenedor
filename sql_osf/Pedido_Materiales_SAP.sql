select t.*, rowid from OPEN.LDCI_TRANSOMA t where TRSMCODI = 245719;
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
 where l.request_material_id in (245719)
 order by l.register_date desc;
