
select n.inpnpefa, n.inpnmere, count (distinct n.inpnsesu)
from ldc_infoprnorp  n
Where  n.inpnpefa in (107378)
Group by n.inpnpefa, n.inpnmere
