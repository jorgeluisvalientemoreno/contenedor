--Planes comerciales 
select * /*a.commercial_plan_id id,
       a.description , 
       a.name,
       tag_name */ 
from open.cc_commercial_plan a
where a.initial_date <= sysdate
and a.final_date >= sysdate
and a.package_type_id = 587
and a.product_type_id = 7014 
and a.commercial_plan_id in ( 4 ) ; 
   
   
   
--Planes financieros

select * /*pldicodi id,
       pldidesc description ,
       pldifein , 
       pldifefi  ,*/
       
from plandife
where (sysdate between pldifein and pldifefi)
and pldipmaf = 100
and pldicodi in ( 23/*,24,26,28,31,64,142*/)
order by pldicodi;


--Identificar direccion que no esté asociado a ningún contrato
select a.address_id, 
       a.address, 
       a.geograp_location_id
from ab_address a
where (select count(1) from suscripc b where b.susciddi = a.address_id) = 0
and a.address not in ('kr mtto cl mtto - 0',
                      'recaudo pago nacional',
                      'kr generica cl generica - 0')
and a.address_id = 279130; 
                         
--numero formulario disponible
select *
from (select a.*
      from fa_histcodi a
      where a.hicdunop is not null
      and a.hicdcore is null
      and a.hicdfebl is null
      and upper(a.hicdobse) = upper('asignar')) a1
where a1.hicdunop = 4021 ; 
 
  
 ---cotizacion vigente
select  a.subscriber_id,
        f.address_id , 
        f.subscription_id ,
        a.register_person_id,
        a.package_id ,
        a.quotation_id ,
        a.description ,
        initial_payment ,
        total_items_value , 
        a.rowid ,
        a.end_date ,
        f.operating_unit_id 
from cc_quotation a
inner join or_order_activity f on a.package_id = f.package_id
where a.status = cc_boquotationutil.fsbgetquotationattstat
and trunc(a.end_date) >= trunc(sysdate)
group by ( a.quotation_id ,a.description ,a.subscriber_id ,a.package_id , 
initial_payment ,total_items_value,a.rowid , f.address_id ,
f.subscription_id,a.end_date,a.register_person_id, f.operating_unit_id ) 
order by a.end_date desc   ;



SELECT /*+ index( a IDX_CC_QUOTATION01 ) */
 a.*, a.rowid
  FROM /*+ CC_BCQuotation.cuAttValidQuotByPack */ cc_quotation a
 WHERE a.status = CC_BOQuotationUtil.fsbGetQuotationAttStat
--AND Initial_payment >0
AND trunc(a.end_date) >= trunc(sysdate)
 order by end_date desc ;
   pr product 
   
   select *
   from pr_product
   where subscription_id = 67253324
   --for update
cc cotizacion


select *
from open.LDC_FINAN_COND
select * 
from open.cc_sales_financ_cond
where financing_plan_id = 23
and package_id = 192684049 
