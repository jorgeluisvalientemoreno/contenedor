SELECT * FROM IC_TIPODOCO ;
SELECT *  FROM IC_TIDOTIMO; 
select * from IC_TICOCONT ;
SELECT * FROM IC_COMPCONT ; 
select * from LDCI_PROCMONI ;
select * from Ldci_registrainterfaz ;

SELECT *
FROM ldci_logsproc
WHERE LOPRPROC = 'L7' AND LOPRFECH > SYSDATE -30
order by LOPRFECH desc ;

select *
from ldci_actacont
where idacta= 242955
order by fechcontabiliza desc;

select *
from ldci_tipointerfaz
where tipointerfaz= 'L7'
