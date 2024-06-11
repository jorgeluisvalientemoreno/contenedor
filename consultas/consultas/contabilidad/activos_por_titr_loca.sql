select acbgloca, acbgtitr, count(1)
from ldci_actiubgttra
having count(1)>1
group by acbgloca, acbgtitr
