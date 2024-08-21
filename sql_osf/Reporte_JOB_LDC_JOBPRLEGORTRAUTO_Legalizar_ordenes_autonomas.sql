select * from open.Reportes a where a.repouser like 'JOB%';
select *
  from open.repoinco pi, open.Reportes r
 where r.
  select *
          from open.repoinco a
         where a.reincod1 = (332088027, 319150560, 319147256, 318001635);


with detalle as
 (select * from open.repoinco a where a.reincod1 is not null)
select *
  from detalle d
 order by d.reinrepo desc -- where d.reindes1 = 'S' --d.reincod1 =  332088027
;
select open.repoinco.reinval1, substr(open.repoinco.reinobse, 1, 112)
  from open.reportes, open.repoinco
 where repoapli = 'LEGAJLOC'
   AND REINREPO = REPONUME
   and reinval1 in (303933435)
   and repofech > trunc(sysdate)
 group by open.repoinco.reinval1, substr(open.repoinco.reinobse, 1, 112);

SELECT FM_possible_ntl.*, FM_possible_ntl.rowid
  FROM open.FM_possible_ntl
 where ORDER_ID in (332088027, 319150560, 319147256, 318001635);

/*select gel.*,rowid from open.ge_error_log gel where gel.error_log_id=2071108973;
