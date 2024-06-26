select *
  from open.LDC_TIPO_ACTIVIDAD a
 where a.tipo_actividad_id like '%CALARCA%';
select *
  from open.LDC_PARAMETROS_ICA b
 where b.type_activity in
       (select a.tipo_actividad_id
          from open.LDC_TIPO_ACTIVIDAD a
         where a.tipo_actividad_id like '%CALARCA%');
select * from open.LDC_CONSTRUCTION_SERVICE;
select * from open.LDC_CONTRA_ICA_GEOGRA;
