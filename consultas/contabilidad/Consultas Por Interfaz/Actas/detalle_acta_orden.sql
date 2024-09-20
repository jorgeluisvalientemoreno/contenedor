ALTER SESSION SET CURRENT_SCHEMA= "OPEN";
SELECT Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN)) tipotrabajo,
  (select orta.description from or_task_type orta where orta.task_type_id = Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) desctipotrab,
  ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) clasificador,
(select lc.clcodesc from open.ic_clascont lc where lc.clcocodi = (open.ldci_pkinterfazactas.fvaGetClasifi(Decode(open.ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, open.ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN)))) ) DESCLASIF,
gd.id_items item, gd.descripcion_items descripcion, gd.cantidad cantidad, gd.valor_unitario valor_unitario,
sum(gd.valor_total) total, gd.id_acta acta, gd.geograp_location_id cod_localidad, (select g.description from ge_geogra_location g where g.geograp_location_id = gd.geograp_location_id) localidad,GD.ID_ORDEN, nvl(gcon.valor_aui_admin,0) valor_aui_admin, nvl(gcon.valor_aui_util,0) valor_aui_util, nvl(gcon.valor_aui_imprev,0) valor_aui_imprev
  FROM ge_detalle_acta gd, open.ge_items gi, OR_ORDER OT, ge_acta gac, ge_contrato gcon
 WHERE gd.id_items(+) = gi.items_id
   AND OT.order_id(+) = GD.ID_ORDEN
   AND gd.VALOR_TOTAL <> 0
   and gac.id_acta = gd.id_acta
   and gd.id_acta = &acta
  -- and gd.id_orden in (7342377)
   and gcon.id_contrato = gac.id_contrato
  -- and gac.id_acta not in (select lca.idacta from ldci_actacont lca where lca.actcontabiliza = 'S')
   group by ot.task_type_id,GD.ID_ORDEN,
gd.id_items, gd.descripcion_items, gd.cantidad, gd.valor_unitario,
gd.id_acta, gd.geograp_location_id, Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN)), gcon.valor_aui_admin, gcon.valor_aui_util, gcon.valor_aui_imprev
