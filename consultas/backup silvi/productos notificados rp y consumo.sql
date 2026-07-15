select l.* , sesuesco ,
(
SELECT  SUM(NVL(cosscoca,0)) 
        FROM open.conssesu
        WHERE cosspefa = inpnpefa
        AND cosssesu = inpnsesu
        AND cosstcon+0 = NVL(1,cosstcon)
        AND cossflli = 'S'
)cosssuma
from open.ldc_infoprnorp l , open.servsusc 
where sesunuse = inpnsesu and l.inpnfere>= '14/05/2024 21:00:00'
and inpnmere in (54,57)  and inpnorim is not null
order by inpnfere desc;

