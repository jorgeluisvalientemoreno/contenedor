--Tipo de trabajo
select ott.*, rowid
  from open.or_task_type ott
 where 1 = 1
   and ott.task_type_id in
       (select otti.task_type_id
          from open.or_task_types_items otti
         where otti.items_id = &Item);

---Items  - Actividad
select gi.*, rowid
  from open.ge_items gi
 where 1 = 1
   and gi.items_id in (&Item);

--items para actividad e orden
select a.*, rowid
  from OPEN.OR_ACTIVIDAD a
 where 1 = 1
   and a.id_actividad in (&Item);

--Tipo trabajo - Actividad
select otti.*, rowid
  from open.or_task_types_items otti
 where 1 = 1
   and otti.items_id in (&Item);

--Rol
select sr.*, rowid
  from open.sa_role sr
 where sr.role_id in (select oar.id_rol
                        from open.or_actividades_rol oar
                       where 1 = 1
                         and oar.id_actividad in (&Item));

--Actividad - Rol
select oar.*, rowid
  from open.or_actividades_rol oar
 where 1 = 1
   and oar.id_actividad in (&Item);

--Regenera Actividad
select a.*, rowid
  from OPEN.OR_REGENERA_ACTIVIDA a
 where a.actividad in (&Item);

--Lista de costos x item x unidad
select a.*
  from OPEN.GE_LIST_UNITARY_COST a
 inner join open.ge_unit_cost_ite_lis b
    on b.items_id in (&Item)
   and a.list_unitary_cost_id = b.list_unitary_cost_id
 where 1 = 1
   and a.operating_unit_id = 5118
   and sysdate between a.validity_start_date and a.validity_final_date
 order by a.validity_start_date desc;

--Lista de costos x item
SELECT b.* --, rowid
  FROM open.ge_unit_cost_ite_lis b
 inner join OPEN.GE_LIST_UNITARY_COST a
    on a.list_unitary_cost_id = b.list_unitary_cost_id
 WHERE 1 = 1
   AND b.items_id in (&Item)
   and a.operating_unit_id = 5118
   and sysdate between a.validity_start_date and a.validity_final_date
 order by b.last_update_date desc;

--LDCCUAI 
select a.*, rowid
  from OPEN.LDC_ITEM_UO_LR a
 where (a.item = &Item or a.actividad = &Item);

--LDCCOITCOBUSU
select a.*, rowid from OPEN.LDC_ITEMCOUS a where a.id_items = &Item;
