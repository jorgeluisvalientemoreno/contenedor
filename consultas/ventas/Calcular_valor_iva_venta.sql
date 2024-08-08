select ravtcons, 
       ravtvitc, 
       ravtliin, 
       ravtlisu, 
       ravtvalo, 
       ravtporc, 
       ravtprog, 
       ravtusua, 
       ravtterm
from  open.ta_rangvitc
where ravtvitc in (40093,40111) ; 

--Consultar por vitccons de ta_vigetaco