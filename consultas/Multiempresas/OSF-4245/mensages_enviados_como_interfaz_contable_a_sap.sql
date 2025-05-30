--mensages_enviados_como_interfaz_contable_a_sap
select *
from ldci_mesaenvws
where 1=1
and mesadefi = 'WS_RESERVA_MATERIALES'
and mesafech >= '21/05/2025'
order by mesafech desc;


/*
select *
from ldci_defisewe*/
