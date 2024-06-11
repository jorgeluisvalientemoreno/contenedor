
select n.inpnpefa, n.inpnmere, count (distinct n.inpnsesu)
from ldc_infoprnorp  n
Where  n.inpnpefa in (101942)
Group by n.inpnpefa, n.inpnmere
