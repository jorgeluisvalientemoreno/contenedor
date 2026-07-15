select * from open.ta_taricopr where tacpprta= 12291;

/*select * from open.ta_vigetacp */

select * 
from open.ta_taricopr t
inner join OPEN.TA_PROYTARI p on p.PRTACONS  = t.tacpprta
inner join OPEN.TA_CONFTACO c on c.COTCCONS=t.TACPCOTC
inner join OPEN.TA_DEFICRTA d on d.DECTCONS= c.COTCDECT
where tacpprta= 12271;

SELECT tacpprta proyecto,
        tacpcotc conf_tarifa_concepto, 
        tacpreso resolucion, 
        tacpdesc descripcion, 
        tacpcr01 , 
        tacpcr02,
        tacpcr03,
        tacpcr04,
        cotcconc concepto,
        vitpfein fecha_inicio_vigencia,
        vitpfefi fecha_fin_vigencia,
        vitptipo,
        vitpvalo valor
FROM OPEN.ta_taricopr
    JOIN OPEN.ta_conftaco ON ta_conftaco.cotccons = ta_taricopr.tacpcotc
    JOIN open.ta_vigetacp ON ta_vigetacp.vitptacp= ta_taricopr.tacpcons
WHERE ta_taricopr.tacpprta =12271
/*and vitptipo='B'*/;


select *
 from open.ta_proytari
 left join open.ta_estaproy on esprcons = prtaesta 
 where prtacons in (12351) ;


update  ta_vigetacp 
set vitpfein ='21/04/2026'
WHERE VITPUSUA='MATCAR'
AND vitptacp IN ( select tacpcons from ta_taricopr where tacpprta =12291) 
