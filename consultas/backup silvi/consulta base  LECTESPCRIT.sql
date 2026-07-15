Select  c.critica_id,c.sesunuse,gs.subscriber_name ||   nvl(gs.subs_last_name, ' ') nombre,gs.address_id "dir contrato",pr.address_id "dir producto",
      (select ad.address_parsed
      from open.ab_address ad where gs.address_id = ad.address_id ) address_parsed_cont,
      (select ad2.address_parsed
      from open.ab_address ad2 where pr.address_id = ad2.address_id ) address_parsed_prod,
      serv.sesucico,c.pefacodi,c.pecscons,c.consprom,c.conspromdc,c.leemlean,c.leemleac,trunc(c.volncorr,2) volncorr,trunc(c.presmesant,2) presmesant,trunc(c.facorrmant,2) facorrmant,trunc(c.volcorrest,2) volcorrest,trunc(c.lepresa,2) lepresa,c.funca,c.caupresa,trunc(c.lepresb,2) lepresb,c.funcb,c.caupresb,trunc(c.lepresc,2) lepresc,c.funcc,c.caupresc,trunc(c.presfin,2) presfin,c.lectfin,c.proc,c.sort_id,(SELECT nvl(SUM (cosscoca),0) FROM open.conssesu WHERE cosssesu=c.sesunuse AND cosspecs=c.pecscons AND cossmecc=4) VolFacturado,(select o.legalization_date from open.or_order o where  o.order_id =c.order_id)  Fecha_legal, pf.pefaano ano, pf.pefames mes, open.dage_geogra_location.fnugetgeo_loca_father_id(open.daab_address.fnugetgeograp_location_id(gs.address_id, Null),NULL) || '-' ||
      open.dage_geogra_location.fsbgetdescription(open.dage_geogra_location.fnugetgeo_loca_father_id(open.daab_address.fnugetgeograp_location_id(gs.address_id, Null),NULL)) DPTO, (SELECT user_id usuario FROM or_order_stat_change e WHERE e.order_id =c.order_id AND e.final_status_id=8 AND ROWNUM < 2) Usuario_lega,nvl(c.maquina,(Select decode(o.order_status_id,8,ch.terminal,12,ch.terminal,'') From open.or_order_stat_change ch, open.or_order o Where ch.order_id = o.order_id and ch.order_id = c.order_id And ch.final_status_id = o.order_status_id AND ROWNUM < 2)) terminal, impexcel,serv.sesuesco || '-' || SUBSTR(replace(open.daestacort.fsbgetescodesc(serv.sesuesco),'-',''),1,27) estado_corte,decode(UPPER(serv.sesuesfn), 'A', 'A-AL DIA', 'D', 'D-CON DEUDA', 'M', 'M-EN MORA', 'C', 'C- CASTIGADO', serv.sesuesfn) estado_financiero, nvl(TO_CHAR(c.FECHA_ULTLECT),'')  UFECH_LECT 
      
      From open.ldc_cm_lectesp_crit c,open.suscripc contr,open.servsusc serv,
      open.ge_subscriber gs,open.perifact pf ,  pr_product pr 
  Where c.sesunuse = serv.sesunuse And serv.sesususc = contr.susccodi and  serv.sesunuse = pr.product_id 
  And ldc_pkcm_lectesp.fsbGetCiclo(pf.pefacicl) = 'S' 
  And contr.suscclie = gs.subscriber_id  And c.pefacodi = pf.pefacodi And pf.pefaactu = 'S'  
  and (c.proc='N' OR (c.proc='S' AND pf.pefaactu='S')) and gs.address_id <> pr.address_id  and sesucicl = 1801 
  Order By c.sort_id,c.proc,serv.sesucico,c.pefacodi Desc,c.sesunuse;

