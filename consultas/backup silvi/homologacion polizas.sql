SELECT *
FROM SERVSUSC
WHERE SESUSUSC = 5511304 ;

SELECT *
FROM MIGRAGG.SERVSUSC
WHERE SESUSUSC = 5511304 ;

SELECT SH.* , SESUSERV 
FROM SERVSUSC S 
INNER JOIN HOMOLOGACION.SERVSUSC_HOMOLOGADO SH ON S.SESUNUSE = SH.SESUNUSEOSF 
WHERE S.SESUSUSC = 5511304 ;


;

SELECT *
FROM GASGG.SERVSUSC S 
INNER JOIN GASGG.SERVICIO SE ON SE.SERVCODI = S.SESUSERV
WHERE SESUSUSC  = 2011304 ;

select *
from gasgg.poliza
where polisusc  = 2011304 
and poliesta= 1  ;

select * 
from homologacion.homopoli
where homopoliaseg   in ( 5) --14--1408
AND HOMOPOLICOTP in ('206' , '402')
;

select * 
from LD_PRODUCT_LINE
where product_line_id in (291,131,251);

select *
from homologacion.homoconcepto
where conccodi in (8016)

 --conchomo in (183,937,945)


;
SELECT UNIQUE difeconc, concdesc
FROM    migragg.ld_policy, homologacion.servsusc_homologado, gasgg.diferido, gasgg.concepto
WHERE   product_id = sesunuseosf
AND     difenuse = sesunusegas
AND     difeconc = conccodi
