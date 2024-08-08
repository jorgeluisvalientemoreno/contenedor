  select ld.dpttfact factura,
           (select pf.pefacodi || ' - ' || pf.pefadesc
            from OPEN.perifact pf
             where pf.pefacodi = ld.dpttperi) periodo,
           ld.dpttcuco cuenta,
           (select c.conccodi || ' - ' || c.concdesc
            from OPEN.concepto c
             where c.conccodi = ld.dpttconc) concepto,
           (select ccg.cacacodi || ' - ' || ccg.cacadesc
            from OPEN.causcarg ccg
             where ccg.cacacodi = ld.dpttcaca) causalcargo,
           ld.dpttnume nota,
           ld.dpttfere fecharegistro,
           ld.dpttsign signonota,
           ld.dpttvano valornota
from open.ldc_deprtatt ld
order by ld.dpttfere desc;