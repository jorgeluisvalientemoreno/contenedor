select c.cosssesu,
       c.cosspefa,
       c.cosspecs,
       c.cosscoca,
       c.cossfere,
       c.cossmecc,
       c.cossidre,
       c.cosscavc,
       c.cossfufa
from open.conssesu  c
where c.cosssesu = 52521913
order by c.cossfere desc
for update;
