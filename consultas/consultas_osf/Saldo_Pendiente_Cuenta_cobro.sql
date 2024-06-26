--Me puede ayudar con contratos que tengan   orden de suspensión ( tipo de trabajo 12526)  y con deuda en varios productos
With poblacion --Nombre de la subconsulta
 As
 ( --Seccion de la subconsulta
  select b.sesususc contrato, count(b.sesunuse) cantidad_servicios
    from open.servsusc b
   where (Select count(1)
            From Or_Order_Activity C
           where C.Subscription_Id = b.sesususc
             and c.task_type_id = 12526
             and c.status = 'R') > 0 having count(b.sesunuse) > 1
   group by b.sesususc)
--Sección en donde hacemos uso de la subconsulta
Select poblacion.contrato,
       cc.cuconuse,
       count(cc.cucocodi) Cuentas_Saldo_Pendiente
  From open.cuencobr cc
 inner join poblacion
    on cc.cuconuse in
       (select a.sesunuse
          from open.servsusc a
         where a.sesususc = poblacion.contrato)
 where cc.cucosacu > 0 having count(cc.cucocodi) > 1
 group by poblacion.contrato, cc.cuconuse;

--Saldo pendiente en corriente 
select sum(nvl(cucosacu, 0))
  from open.cuencobr, open.servsusc
 where cuconuse = sesunuse
   and sesususc = 999999
   and nvl(cucosacu, 0) > 0;

--Saldo pendiente de diferido 
select sum(nvl(difesape, 0))
  from open.diferido
 where difesusc = 999999
   and nvl(difesape, 0) > 0;
