with base as(
select ortrdenu,
       ortrlonu,
       ortrnume,
       ortrfeel,
       trunc(ortrfeej) ortrfeej,
       ortrfele,
       ortrnuse,
       ortrtitr,
       (select titrdesc from tipotrab where titrcodi = ortrtitr) desc_titr,
       ortresot,
       (select e.esotdesc from estaortr e where e.esotcodi = ortresot) desc_estado,
       ortrcatr,
       (select co.capedesc from  causpere co where co.capecodi = ortrcatr) desc_caus,
       ortrcain,
       (select ci.caotdesc from causortr ci where ci.caotcodi = ortrcain) desc_cain,
       row_number() over ( partition by ortrnuse order by ortrfele desc) fila,
       substr(ortrovdi,1,4) depa,
       substr(ortrovdi,6,6) loca,
       substr(ortrovdi,13) nume,
       ortrovdi,
       ortrobse
from ordetrab
where 1=1
  and ortresot in (3)
  and ortrnuse=9000205
 -- and ortrtitr in (2103, 1511, 1581)
  order by ortrfeel asc
)
select sesunuse, sesueste,(select e.etsedesc from esteserv e where e.etsecodi=sesueste) desc_esta, trunc(sesufere) sesufere, trunc(sesuferp) sesuferp, sesufein, sesumedi,
       base.*,
       ortrtitr titrvdi,
       (select titrdesc from tipotrab where titrcodi=ot.ortrtitr) desc_titr_vdi,
       peremope,
       (select mp.mopedesc from GAS.MOTIPERE mp where mp.mopecodi = p.peremope)
from servsusc
left join base on ortrnuse=sesunuse
left join ordetrab ot on ot.ortrdenu=base.depa and ot.ortrlonu=base.loca and ot.ortrnume=base.nume and base.ortrtitr=1535
left join perequej p on p.peredepa = ot.ortrdnpe and p.pereloca = ot.ortrlnpe and p.perecodi = ot.ortrpere
where servsusc.sesuserv=1
  and  sesueste!=2
  and sesunuse=9000205
  and (
          (sesueste != 10) or
          
          (sesueste=10    and 
           (sesufere is not null or sesuferp is not null)
          )
      )
      
order by sesunuse asc;

