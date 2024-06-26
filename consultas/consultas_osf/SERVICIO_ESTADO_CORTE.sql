select * from estacort p where p.escocodi = 96;
select cf.coecserv || ' - ' || s.servdesc Servicio,
       cf.coeccodi || '-' || ec.escodesc Estado_Corte,
       cf.coecfufa Facturable
  from confesco cf, servicio s, estacort ec
 where cf.coecserv = s.servcodi
   and cf.coecserv = 7057
   and cf.coeccodi = ec.escocodi
