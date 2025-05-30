select c.*, rowid from open.concepto c where c.conccodi in (30);
select cbl.coblconc || ' - ' || c.concdesc Concepto,
       cbl.coblcoba || ' - ' || cbase.concdesc Concepto_Base,
       cbl.coblpoim,
       cbl.coblfivi,
       cbl.coblffvi
  from open.concbali cbl
  left join open.concepto cbase
    on cbase.conccodi = cbl.coblcoba
  left join open.concepto c
    on c.conccodi = cbl.coblconc
 WHERE cbl.coblconc in (30)
    or cbl.coblcoba in (30)
