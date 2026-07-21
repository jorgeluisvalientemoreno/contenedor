select mmitcodi,
       mmitnudo,
       mmitesta,
       mmitfesa,
       sum(decode(i.mmitnatu, '+', 1, '-', -1, 0) * dmitcoun * dmitcant) valor,
       di.operating_unit_id,
       u.name,
       (select p.person_id || '-' || p.name_
          from open.ge_person p
         where p.person_id = u.person_in_charge) responsable
  from open.ldci_intemmit i
 inner join open.ldci_dmitmmit d
    on d.dmitmmit = i.mmitcodi
  left join open.ge_items_documento di
    on di.id_items_documento = i.mmitnudo
  left join open.or_operating_unit u
    on u.operating_unit_id = di.operating_unit_id
 where mmitfesa >= to_Date(&Fecha_ini, 'dd/mm/yyyy')
   and mmitfesa < to_Date(&Fecha_fin, 'dd/mm/yyyy') + 1
   --and mmitnudo is not null
   --and mmitdsap is not null
   --and mmitesta = 1
   --and mmitinte < 9 
   --having sum(decode(i.mmitnatu, '+', 1, '-', -1, 0) * dmitcoun * dmitcant) <> 0
 group by mmitcodi,
          mmitnudo,
          mmitesta,
          mmitfesa,
          di.operating_unit_id,
          u.name,
          u.person_in_charge
