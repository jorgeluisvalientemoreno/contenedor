 select reobcodi id_regla,
        reobdesc Nombre_regla,
        l.oblecodi || ' ' ||  obledesc Obs_no_lect,
        actividad,
        medio_recepcion,
        period_conse,
        dias_gen_ot,
        gen_noti,
        causal_exito,
        actividad_critica,
        regloble,
        estacorte
from ldc_recroble
inner join ldc_obleacti l  on regloble = reobcodi
inner join obselect o  on l.oblecodi = o.oblecodi