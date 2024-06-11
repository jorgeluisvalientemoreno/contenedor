select r.reponume,
       r.repoapli,
       r.repofech,
       repouser,
       repodesc,
       reinval1 producto,
       decode(reindes1, 'S', 'SUSPENSION', 'N', 'NOTIFICACION', 'NA'), reinobse OBSERVACION,
       (select ps.product_status_id || '-' || open.daps_product_status.fsbgetdescription(ps.product_status_id, null)
          from open.pr_product ps
         where ps.product_id = reinval1) estado_producto
  from open.reportes r, open.repoinco ri
 where r.reponume = ri.reinrepo
   and r.repoapli='SUS_NOT_RP'
   and trunc(repofech) >= '24/10/2022'
   and reindes1 = 'S'
   and reinval1 in (1022572)
