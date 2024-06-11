select ciclcodi, cicldesc, pc.pecscons, pc.pecsfeci, pc.pecsfecf, pf.pefacodi, pf.pefafimo, pf.pefaffmo, pf.pefaactu
from open.ciclo
left join open.pericose pc on pc.pecscico=ciclcodi and sysdate between pc.pecsfeci and pc.pecsfecf
left join open.perifact pf on pf.pefacicl=ciclcodi and sysdate between pf.pefafimo and pf.pefaffmo
where ciclcodi in (606)
;


select *
from open.pericose p
where p.pecscico=1406
 and p.pecsfeci>='01/01/2021'
for update

;
select *
from open.perifact
where pefacicl=1406
 and pefaano>=2021
 for update


SELECT SESUCICL
FROM OPEN.SERVSUSC
WHERE SESUNUSE=1000043;
