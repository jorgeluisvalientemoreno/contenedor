select conssesu.cosssesu,
       conssesu.cosspefa,
       conssesu.cosspecs,
       conssesu.cosscoca,
       conssesu.cossfere,
       conssesu.cossmecc,
       conssesu.cossidre,
       conssesu.cosscavc
from open.conssesu
where cosssesu = 40000007
order by cossfere desc;
