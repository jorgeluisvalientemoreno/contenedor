select servsusc.sesususc , 
       servsusc.sesunuse , 
       servsusc.sesuserv ,
       servsusc.sesucicl , 
       plansusc.plsudesc plan_comercial 
from open.servsusc 
left join open.plansusc on plansusc.plsucodi = servsusc.sesuplfa 
where servsusc.sesunuse = 50684345