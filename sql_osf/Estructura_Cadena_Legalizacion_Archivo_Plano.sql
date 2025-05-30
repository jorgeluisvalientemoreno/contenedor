select --o.order_id  orden , o.task_type_id tipo_trabajo, o.order_status_id estado_orden , o.created_date fecha_creacion ,
 o.order_id || '|' || &causal_id || '|' ||
 (select ge.person_id
    from open.sa_user sa, open.ge_person ge
   where ge.user_id = sa.user_id
     and upper(mask) = upper(&usuario)) || '||' || a.order_activity_id ||
 '>1;;;;|||1277;' || &observacion || '|' || &fecha_ini_ejec || ';' ||
 &fecha_fin_ejec Cadena_txt
  from open.or_order o
 inner join open.or_order_activity a
    on o.order_id = a.order_id
 where o.task_type_id = &TipoTrabajo --11082
   and o.order_status_id = 5
   and o.operating_unit_id = &unidad_op
