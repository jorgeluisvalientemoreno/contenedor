declare
cursor cudatos is
with error as
(select *
from open.LDC_LOGERRLEORRESU e2
  where (order_id,FECHGENE) in (select e.order_id, max(e.FECHGENE)
from open.LDC_LOGERRLEORRESU e
group by order_id))

select distinct lo.geo_loca_father_id,(select de.description from open.ge_geogra_location de where de.geograp_location_id=lo.geo_loca_father_id) desc_depa,
       lo.geograp_location_id, lo.description,
       o.created_date,
       r.order_id, 
       o.order_status_id,
       a.package_id,
       o.task_type_id,
(select description from open.or_task_type t where t.task_type_id=o.task_type_id) desc_titr,
 product_status_id, p.product_id,
 r.ordepadre orden_padre,
 (select ot.task_type_id from open.or_order ot where ot.order_id=r.ordepadre) titr_padre,
 (select ot.execution_final_date from open.or_order ot where ot.order_id=r.ordepadre) fecha_fina,
(select ot.operating_unit_id ||'-'|| open.daor_operating_unit.fsbgetname(ot.operating_unit_id) from open.or_order ot where ot.order_id=r.ordepadre) unidad,
(select error.menserror from error where error.order_id=r.order_id),
(select value_1 from open.or_requ_data_value where order_id=r.ordepadre   and name_1='LDC_LECTTOMSUSP') lectura
from open.LDC_LOGERRLEORRESU r, open.or_order o, open.or_order_activity a, open.pr_product p, open.ab_address di, open.ge_geogra_location lo
where r.order_id= o.order_id
and o.order_status_id not in (8, 12)
and a.order_id=o.order_id
and a.product_id=p.product_id
and di.address_id=p.address_id
and di.geograp_location_id=lo.geograp_location_id
and o.order_status_id=0
and (select error.menserror from error where error.order_id=r.order_id)  like '%OS_ASSIGN_ORDER:%';


procedure  ldcprocactualizamarcaprodtra(nuproducto pr_product.product_id%TYPE,numarca ldc_marca_producto.suspension_type_id%TYPE) AS
numarcaantes ldc_marca_producto.suspension_type_id%TYPE;
numarcasuspe pr_prod_suspension.suspension_type_id%TYPE;
numarcanew   pr_prod_suspension.suspension_type_id%TYPE;

 cursor cuSuspProd(nuProducto number) is
  select comp_suspension_id, co.component_id
      from open.pr_comp_suspension c, open.pr_component co
      where co.component_id=c.component_id
        and product_id=nuProducto
    and active='Y';  
    
  cursor cuSuspension2(componente number,  application_date date) is
   SELECT l.*
     FROM open.mo_component l, open.mo_suspension s
    WHERE l.component_id_prod  = componente
      and l.motive_id=s.motive_id
      and trunc(register_date)= trunc(application_date)
;
    
    cursor cuSuspension3(componentte number) is
     select *
      from open.MO_SUSPENSION_COMP
      where component_id=componentte;
sbtexto      VARCHAR2(100);
fecha		 DATE;
BEGIN
 -- Obtenemos marca actual del producto
 numarcaantes := ldc_fncretornamarcaprod(nuproducto);

 -- Obtenemos marca suspension
 BEGIN
   SELECT suspension_type_id INTO numarcasuspe
     FROM(
          SELECT sp.*
            FROM pr_prod_suspension sp
           WHERE sp.product_id = nuproducto
             AND sp.active     IN('Y','y')
           ORDER BY sp.register_date DESC
          )
    WHERE rownum <= 1;

  EXCEPTION
   WHEN no_data_found THEN
    RAISE ex.controlled_error;
  END;

 sbtexto := 'Marca de suspension : '||to_char(numarcasuspe);
 numarcanew := -1;
 -- Verificamos si el tramite envia marca de producto
 IF nvl(numarca,-1) <> -1 THEN
    numarcanew := nvl(numarca,-1);
 END IF;
 ut_trace.trace('Ejecucion ldcprocactualizamarcaprodtra numarcanew => ' ||
                     numarcanew,
                     10);
 -- Verificamos si la marca producto es diferente a la marca de suspension
 IF nvl(numarca,-1) = -1 AND numarcaantes <> numarcasuspe THEN
  numarcanew := numarcasuspe;
 END IF;

 -- Actualizamos marca
 IF numarcanew <> -1 THEN
   ldc_prmarcaproductolog(nuproducto,numarcaantes, numarcanew , 'Datafix CA - 300-28240');
   ldcprocinsactumarcaprodu(nuproducto,numarcanew,NULL);
   -- Actualizamos marca en PR_COMP_SUSPENSION
   
   for reg2 in cuSuspProd(nuproducto) loop
	  update pr_prod_suspension 
	     set suspension_type_id=numarca
		where product_id=nuproducto
		  and active='Y';
		  
      update open.PR_COMP_SUSPENSION
         set suspension_type_id=numarca
        where COMP_SUSPENSION_ID=reg2.COMP_SUSPENSION_ID;
        
		begin
		select register_date
		  into fecha
		from open.pr_prod_suspension
		where product_id=nuproducto
		  and active='Y';
		EXCEPTION
		when others then
			fecha :=null;
		end;
        for reg3 in cuSuspension2(reg2.component_id, fecha) loop
        update mo_suspension
            set suspension_type_id=numarca
         where motive_id= reg3.motive_id;
         
        for reg4 in cuSuspension3 (reg3.component_id) loop
          update mo_suspension_comp set suspension_type_id=numarca
          where component_id=reg4.component_id;
        end loop;
        end loop;
    end loop;
   
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  errors.seterror;
  RAISE ex.controlled_error;
END;
begin
	for reg in cudatos loop
		if reg.titr_padre=10795 and reg.task_type_id=10835 then 
			update or_order set task_type_id=10836,real_task_type_id=10836 where order_id=reg.order_id;
			update or_order_activity set task_type_id=10836, activity_id=100005256 where order_id=reg.order_id;
			update or_order_items set items_id=100005256 where order_id=reg.order_id;
			ldcprocactualizamarcaprodtra(reg.product_id,103);
			commit;
		end if;
	end loop;
end;
/

