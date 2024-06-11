select c.copcorig,
       p.pldidesc, 
       c.copcdest,
       p2.pldidesc
from ldc_confplcaes c
inner join plandife p on p.pldicodi = c.copcorig
inner join plandife p2 on p2.pldicodi = c.copcdest
