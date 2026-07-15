select ciclcodi, cicldesc, pc.pecscons, pc.pecsfeci, pc.pecsfecf, pf.pefacodi, pf.pefafimo, pf.pefaffmo, pf.pefaactu
from open.ciclo
left join open.pericose pc on pc.pecscico=ciclcodi and sysdate between pc.pecsfeci and pc.pecsfecf
left join open.perifact pf on pf.pefacicl=ciclcodi and sysdate between pf.pefafimo and pf.pefaffmo
where ciclcodi in (201)
;


select *
from open.pericose p
where p.pecscico=301
 and p.pecsfeci>='01/01/2026'
for update

;
select *
from open.perifact
where pefacicl=301
 and pefaano>=2026
 for update


SELECT SESUCICL
FROM OPEN.SERVSUSC
WHERE SESUNUSE=1015760;
