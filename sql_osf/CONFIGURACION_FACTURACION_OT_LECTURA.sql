select * from open.ldc_recroble;
select * from open.ldc_obleacti;
select reobcodi id_regla,
       reobdesc Nombre_regla,
       l.oblecodi || ' ' || obledesc Obs_no_lect,
       actividad,
       medio_recepcion,
       period_conse,
       dias_gen_ot,
       gen_noti,
       causal_exito,
       actividad_critica,
       regloble,
       estacorte --l.tipo_suspension , l.gen_relectura
  from open.ldc_recroble
 inner join open.ldc_obleacti l
    on regloble = reobcodi
 inner join open.obselect o
    on l.oblecodi = o.oblecodi
