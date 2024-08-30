with base as (
select distinct 
       c.promotion_id,
       c.description desc_promotion,
       c.prom_type_id,
       c.init_apply_date,
       c.final_apply_date,
       d.concept_id,
       (select concdesc from open.concepto co where co.conccodi=d.concept_id) desc_conc_desc,
       s.subsidy_id,
       s.description desc_subsidio,
       sd.conccodi,
       (select concdesc from open.concepto co where co.conccodi=sd.conccodi) desc_conc_ini,
       nvl((select 'S' from open.concbali cb where cb.coblconc=d.concept_id and cb.coblcoba=sd.conccodi),'N') base_descontable,
       (select ccb.conccodi
         from open.concbali cb 
         inner join open.concepto ccb on ccb.conccodi=cb.coblconc and ccb.concticl=4
        where cb.coblcoba = sd.conccodi ) concepto_iva1,
       (select ccb.conccodi
         from open.concbali cb 
         inner join open.concepto ccb on ccb.conccodi=cb.coblconc and ccb.concticl=4
        where cb.coblcoba = d.concept_id ) concepto_iva2
from open.cc_promotion  c
left join open.cc_prom_detail d on d.promotion_id=c.promotion_id
left join open.ld_subsidy s on s.promotion_id = c.promotion_id
left join open.ld_ubication u on u.subsidy_id=s.subsidy_id
left join open.ld_subsidy_detail sd on sd.ubication_id=u.ubication_id
--where c.promotion_id in (451,450,458,457,461,460,470,469)
)
, tarifa as(
select  co.conccodi,
        co.concdesc,
        ta_rangvitc.ravtporc
 from open.concepto co 
 inner join open.ta_conftaco t on t.cotcconc = co.conccodi and cotcserv =7014  and cotcvige = 'S'
 left join open.ta_tariconc ta on cotccons= tacocotc
 left join  open.ta_vigetaco on tacocons = vitctaco
 left join open.concepto c on cotcconc = c.conccodi
 left join open.ta_rangvitc on ravtvitc = vitccons
 where co.concticl=4
  and sysdate between vitcfein and vitcfefi)
, cfinal as(
select base.promotion_id,
       base.desc_promotion,
       base.prom_type_id,
       base.init_apply_date,
       base.final_apply_date,
       base.concept_id,
       base.desc_conc_desc,
       base.subsidy_id,
       base.desc_subsidio,
       base.conccodi,
       base.desc_conc_ini,
       base.base_descontable,
       base.concepto_iva1,
       t.concdesc des_conc_iva1,
       t.ravtporc porcentaje_iva1,
       base.concepto_iva2,
       t2.concdesc des_conc_iva2,
       t2.ravtporc porcentaje_iva2
from base
left join tarifa t on t.conccodi=concepto_iva1
left join tarifa t2 on t2.conccodi=concepto_iva2)
select f.promotion_id,
       f.desc_promotion,
       f.prom_type_id,
       f.init_apply_date,
       f.final_apply_date,
       f.concept_id,
       f.desc_conc_desc,
       f.subsidy_id,
       f.desc_subsidio,
       f.conccodi,
       f.desc_conc_ini,
       f.concepto_iva1,
       f.des_conc_iva1,
       f.porcentaje_iva1,
       f.concepto_iva2,
       f.des_conc_iva2,
       f.porcentaje_iva2,
       case when f.base_descontable = 'S' and porcentaje_iva1 is not null and porcentaje_iva1=porcentaje_iva2 then
         'S'
       else
         'N'
       end descuento
from cfinal f
