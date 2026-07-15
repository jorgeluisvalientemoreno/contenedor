--machete_pedido_cruzado_pl
select *
from open.LDCI_DOCUVENT
where DOVECODI = '413058493';
--documento_sap
select *
from LDCI_ITEMDOVE
where itdvdove='417005056';

DELETE 
FROM LDCI_ITEMDOVE
WHERE ITDVDOVE = '413058493';
