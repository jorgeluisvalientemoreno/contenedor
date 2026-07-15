select * from IC_CONFRECO where corccoco =4; 
select * from ic_clascore where clcrcons =108648; 
select * from ic_recoclco where rcccclcr = 108648 ;
select * from IC_CRCORECO where CCRCCORC = 427 and CCRCCLCR = 108620 ; 




select cr.*
from IC_CONFRECO  f
inner join ic_clascore c on  c.clcrcorc  =f.corccons
inner join  IC_CRCORECO cr on  cr.CCRCCLCR = c.clcrcons and c.clcrcorc = cr.ccrccorc 
where f.corccoco =4 and f.CORCTIMO= 63;

select r.*
from IC_CONFRECO F
inner join ic_clascore c on  c.clcrcorc  =f.corccons
inner join  ic_recoclco r on  r.rcccclcr = c.clcrcons
where corccoco =4 and CORCTIMO= 63; 
