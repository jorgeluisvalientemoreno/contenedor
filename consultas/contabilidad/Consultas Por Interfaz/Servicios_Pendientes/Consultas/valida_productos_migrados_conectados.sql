select m.invmsesu, m.invmvain, m.invmconc,
       (select 'EXISTE' from open.hicaesco h where h.hcecnuse = m.invmsesu and rownum = 1)
  from open.Ldci_Ingrevemi m
 
