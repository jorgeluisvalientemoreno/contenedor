select dpttcont "Contrato",
       dpttsesu "Producto",
       concepto "Concepto",
       dpttsign "Signo",
       (valornota*-1) "Valornota"
from (select   (select c.conccodi || ' - ' || c.concdesc
      from OPEN.concepto c
      where c.conccodi = ld.dpttconc) concepto,ld.dpttcont,ld.dpttsesu,ld.dpttsign ,
      decode(ld.dpttsign, 'DB', ld.dpttvano, -ld.dpttvano) valornota 
      from OPEN.LDC_DEPRTATT ld
      where ld.dpttcont = 48095218)
where concepto Like '%130%'
and valornota <> 0;