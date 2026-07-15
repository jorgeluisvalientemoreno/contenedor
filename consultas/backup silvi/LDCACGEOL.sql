 
 select *
 from ldc_recroble; 
 
 select *
 from  ldc_obleacti; 
 
 
 select *
 from ldc_recroble 
 left join ldc_obleacti on regloble = reobcodi 

 select *
 from ldc_calificacion_cons 

 select reobcodi id_regla,
        reobdesc Nombre_regla,
        l.oblecodi || ' ' ||  obledesc Obs_no_lect,
        actividad,
        medio_recepcion,
        period_conse,
        dias_gen_ot,
        gen_noti,
        causal_exito,
        regloble,
        estacorte , L.GEN_RELECTURA, L.TIPO_SUSPENSION
from ldc_recroble
inner join ldc_obleacti l  on regloble = reobcodi
inner join obselect o  on l.oblecodi = o.oblecodi
where reobcodi =4 and l.oblecodi=8

select * from ldc_obleacti 
where oblecodi= 8 and regloble =13  for update 

update ldc_obleacti set tipo_suspension='101,2,102,103,104,105' where oblecodi= 8 and regloble =4
update ldc_obleacti set estacorte = '5,2,4,94,95,96,110,111,112' where oblecodi= 8 and regloble =4

select *
from open.ldc_obleacti@osfpl
