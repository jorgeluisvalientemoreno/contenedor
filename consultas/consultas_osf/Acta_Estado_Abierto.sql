select ga.*, rowid
  from open.ge_acta ga
 where /*ga.id_acta in (select g.id_acta
                        from ge_detalle_acta g
                       where g.id_items in (100002253, 100002275)
                       group by g.id_acta)
   and*/ ga.estado = 'A'
   and ga.fecha_creacion > sysdate -100
 order by ga.fecha_creacion desc;       
select gc.*, rowid from open. ge_contrato gc where gc.id_contrato = 5165; --1194;
