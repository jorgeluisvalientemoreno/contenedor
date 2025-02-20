with info_dire as (
select category_ , subcategory_ subcate ,geograp_location_id
from open.ab_premise 
inner join  open.ab_address on premise_id =  estate_number 
where address_id = &address_id --Ingresar address_id 
),
conceptos_base as ( 
  select null as promotion_id,
         cotcconc as concepto_genera,
         null as concepto_aplica,
         vitcvalo as valor
    from open.ta_conftaco t
   left join open.ta_tariconc ta on cotccons = tacocotc
   left join open.ta_vigetaco on tacocons = vitctaco
   left join open.concepto c on cotcconc = c.conccodi
   left join open.ta_rangvitc on ravtvitc = vitccons
   left join info_dire on tacocr02= info_dire.subcate
   where cotcconc in (19, 30, 674)
     and cotcserv = 7014
     and cotcvige = 'S'
     and sysdate between vitcfein and vitcfefi
     and tacocr01 = &plan_come
     and tacocr02 in (info_dire.subcate, -1)
)
,
conceptos_iva as ( 
  select null as promotion_id,
         t.cotcconc as concepto_genera,
         cb.coblcoba as concepto_aplica,
         (r.ravtporc / 100) * conceptos_base.valor as valor
    from open.concbali cb
   left join open.ta_conftaco t  on cb.coblconc = t.cotcconc
   left join open.ta_tariconc ta  on cotccons = tacocotc  
   left join open.ta_vigetaco vi  on tacocons = vitctaco  
   left join conceptos_base on concepto_genera = cb.coblcoba
   left join open.ta_rangvitc r on ravtvitc = vitccons
   inner join open.concepto c on cotcconc = c.conccodi and c.concticl = 4
   where cb.coblcoba = conceptos_base.concepto_genera 
     and cotcserv = 7014 
     and cotcvige = 'S' 
     and sysdate between vitcfein and vitcfefi 
),
promociones as (
  select p.promotion_id,
         p.concept_id as concepto_genera,
         c.coblcoba as concepto_aplica,
         to_number(regexp_replace(replace(expression, 'nuValor = ', ''), '[^0-9-]', '')) as valor
    from open.cc_prom_detail p
   inner join open.gr_config_expression g on g.config_expression_id = p.config_expression_id and expression like '%nuValor =%'
   left join open.concbali c on c.coblconc = p.concept_id
   where p.promotion_id in (&promociones) --ingresar promociones y subsidios
) ,
subsidios as (
  select l.promotion_id,
         l.conccodi as concepto_genera,
         d.conccodi as concepto_aplica,
         -d.subsidy_value as valor
    from open.ld_subsidy l
   left join open.ld_ubication u  on l.subsidy_id = u.subsidy_id
   left join open.ld_subsidy_detail d  on d.ubication_id = u.ubication_id
   left join info_dire on sucacate= info_dire.category_ and sucacodi = info_dire.subcate
   where l.final_date > sysdate
     and promotion_id in (&promociones)
     and sucacate = info_dire.category_
     and sucacodi = info_dire.subcate
     and geogra_location_id = info_dire.geograp_location_id
),
conceptos_iva_sub as ( 
  select null as promotion_id,
         t.cotcconc as concepto_genera,
         cb.coblcoba as concepto_aplica,
         (r.ravtporc / 100) * subsidios.valor as valor
    from open.concbali cb
   left join open.ta_conftaco t  on cb.coblconc = t.cotcconc
   left join open.ta_tariconc ta  on cotccons = tacocotc  
   left join open.ta_vigetaco vi  on tacocons = vitctaco  
   left join subsidios on concepto_genera = cb.coblcoba
   left join open.ta_rangvitc r on ravtvitc = vitccons
   inner join open.concepto c on cotcconc = c.conccodi and c.concticl = 4
   where cb.coblcoba = subsidios.concepto_genera 
     and cotcserv = 7014 
     and cotcvige = 'S' 
     and sysdate between vitcfein and vitcfefi
)

select promotion_id, concepto_genera, concepto_aplica, valor
from conceptos_base
union all
select promotion_id, concepto_genera, concepto_aplica, valor
from conceptos_iva
union all
select promotion_id, concepto_genera, concepto_aplica, valor
from promociones
union all
select promotion_id, concepto_genera, concepto_aplica, valor
from subsidios
union all
select promotion_id, concepto_genera, concepto_aplica, valor
from conceptos_iva_sub
order by concepto_genera,concepto_aplica ;
