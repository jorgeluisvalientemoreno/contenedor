select *
from open.ldci_intemmit i
inner join open.ldci_dmitmmit d on d.dmitmmit=i.mmitcodi
left join open.ldci_seridmit s on s.serimmit= i.mmitcodi and s.seridmit=d.dmitcodi