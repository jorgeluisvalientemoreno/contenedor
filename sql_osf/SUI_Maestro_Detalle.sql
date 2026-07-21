select t.*, t.rowid
  from LDC_DETAREPOATECLI t
 where t.ateclirepo_id = 2728
 order by t.detarepoatecli_id desc -- to_date(t.fecha_registro,'DD/MM/YYYY') desc-->= sysdate -10
;
select a.*, rowid
  from OPEN.LDC_ATECLIREPO a
 where 1 = 1
   --and a.ateclirepo_id = 2728
   and a.ano_reporte = 2025
   and a.mes_reporte = 3;

with detallesui as
 (select t.ateclirepo_id, count(1) cantidad
    from LDC_DETAREPOATECLI t
   group by t.ateclirepo_id)
select ds.*, a.ano_reporte, a.mes_reporte
  from detallesui ds
 inner join OPEN.LDC_ATECLIREPO a
    on a.ateclirepo_id = ds.ateclirepo_id
 order by ano_reporte asc, mes_reporte asc, ds.cantidad
