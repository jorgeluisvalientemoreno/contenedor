with conceptos_tt as  (select   ld.dpttcont CONTRATO, ld.dpttsesu producto,(select c.conccodi || ' - ' || c.concdesc  from OPEN.concepto c   where c.conccodi = ld.dpttconc) concepto,
                            decode(ld.dpttsign, 'DB', -ld.dpttvano, ld.dpttvano) valornota
                            from OPEN.LDC_DEPRTATT ld
                            left join servsusc se on LD.dpttcont= se.sesususc and ld.dpttsesu= sesunuse
                            where ld.dpttconc = 130
                            and se.sesususc = 1004120)
    , nota_total as ( select CONTRATO , ( select (sum( valornota))   from conceptos_tt group by  concepto,CONTRATO, producto) valornota  from  conceptos_tt  group by CONTRATO  )
select * from nota_total 