select a.operating_unit_id || ' - ' || oou.name unidad_operativa,
       a.person_id || ' - ' || a1.name_ funcional
  from OPEN.OR_OPER_UNIT_PERSONS a
 inner join open.or_operating_unit oou
    on oou.operating_unit_id = a.operating_unit_id
 inner join OPEN.GE_PERSON a1
    on a1.person_id = a.person_id
 where a.operating_unit_id = 5112
 order by a.person_id ;
select a.*, rowid from OPEN.GE_PERSON a where a.person_id = 39816;
select oou.*
  from open.or_operating_unit oou
 where oou.operating_unit_id = 5112;
--El registro Personal de la Unidad de Trabajo [5112,39816] no existe, o no esta autorizado para acceder los datos. [538037346]
