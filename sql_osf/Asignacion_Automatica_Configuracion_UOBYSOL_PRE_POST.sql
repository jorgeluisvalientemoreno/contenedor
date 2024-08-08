select t.items_id, t.catecodi, t.procesopre, t.procesopost
  from open.LDC_PACKAGE_TYPE_OPER_UNIT t
 where (t.procesopre is not null or t.procesopost is not null)
   and (t.procesopre like '%LDC_BOTRASLADO_PAGO%' or
       t.procesopost like '%LDC_BOTRASLADO_PAGO%')
 group by t.items_id, t.catecodi, t.procesopre, t.procesopost
--FSBRPTRAMITES
--adm_person.pkg_or_order
