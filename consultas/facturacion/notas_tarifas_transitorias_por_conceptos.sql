select dpttcont contrato,
       dpttsesu producto,
       concepto,
       sum((valornota * -1)) valornota
from (select   (select c.conccodi || ' - ' || c.concdesc
      from OPEN.concepto c
      where c.conccodi = ld.dpttconc) concepto,ld.dpttcont,ld.dpttsesu,
      decode(ld.dpttsign, 'DB', ld.dpttvano, -ld.dpttvano) valornota 
      from OPEN.LDC_DEPRTATT ld
      where ld.dpttcont = 17197692)
group by dpttcont,dpttsesu,concepto;