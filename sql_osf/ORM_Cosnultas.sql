select consulta.id_consulta,
       consulta.nombre,
       consulta.descripcion,
       consulta.id_directorio || ' - ' || directorio.nombre,
       consulta.consulta
  from orm.opt_consulta consulta
  left join orm.opt_directorio directorio
    on directorio.id_directorio = consulta.id_directorio
 where 1 = 1
   and upper(consulta.consulta) like '%LDC_LOGERRLEORRESU%'
 order by consulta.id_consulta;
