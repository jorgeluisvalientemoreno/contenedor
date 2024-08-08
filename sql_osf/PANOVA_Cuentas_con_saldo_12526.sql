select ott.*, rowid
  from open.or_task_type ott
 where ott.task_type_id = 12526;
With poblacion --Nombre de la subconsulta
 As
 ( --Seccion de la subconsulta
  select b.sesususc contrato, count(b.sesunuse) cantidad_servicios
    from open.servsusc b
  having count(b.sesunuse) > 1
   group by b.sesususc)
--Sección en donde hacemos uso de la subconsulta
Select c.order_id, Vt.*
  From Or_Order_Activity C
 Inner Join poblacion Vt
    On C.Subscription_Id = Vt.contrato
   and c.task_type_id = 12526
   and c.status = 'R'
   and (select sum(a.cucosacu)
          from open.cuencobr a
         where a.cuconuse = c.product_id) > 0;
