select consulta.id_consulta,
       consulta.nombre,
       consulta.descripcion,
       consulta.id_directorio || ' - ' || directorio.nombre,
       consulta.consulta
  from orm.opt_consulta consulta
  left join orm.opt_directorio directorio
    on directorio.id_directorio = consulta.id_directorio
 order by consulta.id_consulta;
