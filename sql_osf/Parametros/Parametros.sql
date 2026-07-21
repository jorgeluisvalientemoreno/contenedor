select l.*, rowid
  from open.ld_parameter l
 where l.value_chain like '%SUSPENSION%PERSECUCION%CARTERA%';
select l.*, rowid
  from open.parametros l
 where l.valor_cadena like '%SUSPENSION%PERSECUCION%CARTERA%';
select l.*, rowid
  from open.ldc_pararepe l
 where l.paravast like '%SUSPENSION%PERSECUCION%CARTERA%';
