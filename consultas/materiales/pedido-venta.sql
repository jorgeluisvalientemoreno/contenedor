select *
from open.ldci_transoma t
inner join open.ldci_trsoitem it on t.trsmcodi = it.tsittrsm
left join open.ldci_seriposi ts on ts.seritrsm=t.trsmcodi and ts.seritsit=it.tsititem