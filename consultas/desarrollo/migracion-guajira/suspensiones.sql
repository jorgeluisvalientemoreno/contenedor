with base as (
select sesunuse, sesuferp,sesueste, max(c.cetsfech) fecha_cambio
from servsusc
left join caestese c on c.cetsnuse = sesunuse and c.cetsetac =sesueste
where sesueste in (11/*,14*/)
  and sesuserv = 1
  group by sesunuse, sesuferp, sesueste)
, base2 as(
select base.*,
       o.ortrtitr,
       (select titrdesc from tipotrab where titrcodi=ortrtitr) desc_titr,
       ortrcatr,
       (select co.capedesc from  causpere co where co.capecodi = ortrcatr) desc_caus,
       o.ortrfele,
       o.ortrfeej,
       row_number() over ( partition by base.sesunuse order by base.sesunuse, ortrfeej desc) fila
from base
left join ordetrab o on o.ortrnuse=base.sesunuse and trunc(fecha_cambio)=trunc(ortrfeej) and o.ortresot=3 
                                   and o.ortrtitr in (2103, 1511 , 1581 ,2103 ,1282, 1163) --centro medicion
)
select *
from base2
where fila=1
  
