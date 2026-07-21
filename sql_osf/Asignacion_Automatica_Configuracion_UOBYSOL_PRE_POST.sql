select distinct t.items_id || ' - ' || gi.description Actividad,
                decode(t.catecodi,
                       -1,
                       t.catecodi || ' - Todos',
                       t.catecodi || ' - ' || c.catedesc) Categoria,
                t.procesopre SERVICIO_PRE,
                t.procesopost SERVICIO_POST,
                t.operating_unit_id || ' - ' || oou.name Unidad_Operativa
  from open.LDC_PACKAGE_TYPE_OPER_UNIT t
 inner join open.or_operating_unit oou
    on oou.operating_unit_id = t.operating_unit_id
 inner join open.ge_items gi
    on gi.items_id = t.items_id
  left join open.categori c
    on c.catecodi = t.catecodi
 where 1 = 1
   and (t.procesopre is not null or t.procesopost is not null)
   and (t.procesopre like '%LDC_BOTRASLADO_PAGO%' or
       t.procesopost like '%LDC_BOTRASLADO_PAGO%')
--FSBRPTRAMITES
--adm_person.pkg_or_order
