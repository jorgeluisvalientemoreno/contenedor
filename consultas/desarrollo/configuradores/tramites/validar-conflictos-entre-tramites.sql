---1
with base as
 (select gi_config.config_id, 
         gi_config.external_root_id
    from open.gi_config
   where gi_config.entity_root_id = 2012
     and gi_config.config_type_id = 4)
,configxtramite as
 (select base.config_id, 
         p.package_type_id, 
         p.description
    from open.ps_package_type p
    join base
      on external_root_id = p.package_type_id)
,motivos as
 (select p.package_type_id, 
         mot.product_motive_id
    from open.ps_package_type p
    left join open.ps_prd_motiv_package mot
      on mot.package_type_id = p.package_type_id)
, atributos as (
select package_attribs_id codigo,
       package_type_id,
       display_name,
       'PACKAGE' nivel
from open.ps_package_attribs 
union all
select prod_moti_attrib_id codigo,
       package_type_id,
       display_name,
       'MOTIVE' nivel
from open.ps_prod_moti_attrib xx
left join open.ps_prd_motiv_package mot on mot.product_motive_id = xx.product_motive_id
union all
select moti_comp_attribs_id codigo,
       package_type_id,
       display_name,
       'COMPONENT' nivel 
from open.PS_PRD_MOTIV_PACKAGE pack 
inner join open.PS_PROD_MOTIVE_COMP motcomp  on pack.product_motive_id =motcomp.product_motive_id
inner join OPEN.PS_MOTI_COMP_ATTRIBS comp on motcomp.prod_motive_comp_id=comp.prod_motive_comp_id

)

, cantidad_atributos_tram as(
select package_type_id,
       count(1) cantidad
from   atributos  
group by   package_type_id
)       
, diferencias as(
 select configxtramite.package_type_id,
         configxtramite.description,
          sum((select count(1)
            from open.gi_comp_attribs cmp
            left join open.ge_entity_attributes att
              on att.entity_attribute_id = cmp.entity_attribute_id
            left join open.ge_entity ent
              on ent.entity_id = att.entity_id
           where cmp.composition_id = cc.composition_id)) cant_atr_compo,
           (select sum(cantidad) from cantidad_atributos_tram tram where tram.package_type_id=configxtramite.package_type_id) cantidad_atrib_motive
    from open.gi_frame fr
   inner join open.gi_config_comp cc
      on cc.composition_id = fr.composition_id
    join configxtramite
      on configxtramite.config_id = cc.config_id
    left join motivos m
      on m.package_type_id = configxtramite.package_type_id
   where cc.config_id not in
         (select config_id from base where external_root_id = 587)
         --and fr.order_view = 2
   group by configxtramite.package_type_id,
         configxtramite.description,      
         product_motive_id
)
select * from diferencias where cant_atr_compo != cantidad_atrib_motive;
---2
with base as(
              select gi_config.config_id,
                     gi_config.external_root_id
              from open.gi_config
              where gi_config.entity_root_id = 2012
              and   gi_config.config_type_id=4)
,configxtramite as(
                   select base.config_id,
                          p.package_type_id,
                          p.description
                     from open.ps_package_type p
                     join base on external_root_id = p.package_type_id
                   )
,motivos as(
              select p.package_type_id,
                       mot.product_motive_id
                  from open.ps_package_type p
                  left join open.ps_prd_motiv_package mot on mot.package_type_id = p.package_type_id)
, atributos as (
select package_attribs_id codigo,
       package_type_id,
       display_name,
       'PACKAGE' nivel
from open.ps_package_attribs 
union all
select prod_moti_attrib_id codigo,
       package_type_id,
       display_name,
       'MOTIVE' nivel
from open.ps_prod_moti_attrib xx
left join open.ps_prd_motiv_package mot on mot.product_motive_id = xx.product_motive_id
union all
select moti_comp_attribs_id codigo,
       package_type_id,
       display_name,
       'COMPONENT' nivel 
from open.PS_PRD_MOTIV_PACKAGE pack 
inner join open.PS_PROD_MOTIVE_COMP motcomp  on pack.product_motive_id =motcomp.product_motive_id
inner join OPEN.PS_MOTI_COMP_ATTRIBS comp on motcomp.prod_motive_comp_id=comp.prod_motive_comp_id

)
select fr.order_view,
       configxtramite.package_type_id,
       configxtramite.description,
       cc.composition_id,
       cmp.external_id,
       xx.display_name,
       xx.package_type_id,
       (select ps.description from open.ps_package_type ps where ps.package_type_id = xx.package_type_id) tramite,
       nivel
        from open.gi_frame fr
        inner join open.gi_config_comp cc on cc.composition_id = fr.composition_id
              join configxtramite on configxtramite.config_id = cc.config_id
         left join motivos m on m.package_type_id = configxtramite.package_type_id
         left join open.gi_comp_attribs cmp on cmp.composition_id =cc.composition_id
         left join open.ge_entity_attributes att on att.entity_attribute_id = cmp.entity_attribute_id
         left join open.ge_entity ent on ent.entity_id = att.entity_id
         left join atributos xx on  xx.codigo = cmp.external_id 
                               and (fr.order_view = 1 and xx.nivel='PACKAGE' or 
                                    fr.order_view = 2 and xx.nivel='MOTIVE' or
                                    fr.order_view >=3 and xx.nivel='COMPONENT')
                                                                

        where cc.config_id  not in (select config_id
                                        from base
                                        where  external_root_id = 587)
          and configxtramite.package_type_id in (100289)
          order by fr.order_view;
;

---3
with base as(
              select gi_config.config_id,
                     gi_config.external_root_id
              from open.gi_config
              where gi_config.entity_root_id = 2012
              and   gi_config.config_type_id=4)
,configxtramite as(
                   select base.config_id,
                          p.package_type_id,
                          p.description
                     from open.ps_package_type p
                     join base on external_root_id = p.package_type_id
                   )
,motivos as(
              select p.package_type_id,
                       mot.product_motive_id
                  from open.ps_package_type p
                  left join open.ps_prd_motiv_package mot on mot.package_type_id = p.package_type_id)
, atributos as (
select package_attribs_id codigo,
       package_type_id,
       display_name,
       'PACKAGE' nivel
from open.ps_package_attribs 
union all
select prod_moti_attrib_id codigo,
       package_type_id,
       display_name,
       'MOTIVE' nivel
from open.ps_prod_moti_attrib xx
left join open.ps_prd_motiv_package mot on mot.product_motive_id = xx.product_motive_id
union all
select moti_comp_attribs_id codigo,
       package_type_id,
       display_name,
       'COMPONENT' nivel 
from open.PS_PRD_MOTIV_PACKAGE pack 
inner join open.PS_PROD_MOTIVE_COMP motcomp  on pack.product_motive_id =motcomp.product_motive_id
inner join OPEN.PS_MOTI_COMP_ATTRIBS comp on motcomp.prod_motive_comp_id=comp.prod_motive_comp_id

)
, config_tram as(
select fr.order_view,
       configxtramite.package_type_id,
       configxtramite.description,
       cc.composition_id,
       cmp.external_id 
        from open.gi_frame fr
        inner join open.gi_config_comp cc on cc.composition_id = fr.composition_id
              join configxtramite on configxtramite.config_id = cc.config_id
         left join motivos m on m.package_type_id = configxtramite.package_type_id
         left join open.gi_comp_attribs cmp on cmp.composition_id =cc.composition_id
         left join open.ge_entity_attributes att on att.entity_attribute_id = cmp.entity_attribute_id
         left join open.ge_entity ent on ent.entity_id = att.entity_id
                                                                

        where cc.config_id  not in (select config_id
                                        from base
                                        where  external_root_id = 587)
          
          order by fr.order_view
)
,  atributos as (
select package_attribs_id codigo,
       package_type_id,
       display_name,
       'PACKAGE' nivel
from open.ps_package_attribs 
union all
select prod_moti_attrib_id codigo,
       package_type_id,
       display_name,
       'MOTIVE' nivel
from open.ps_prod_moti_attrib xx
left join open.ps_prd_motiv_package mot on mot.product_motive_id = xx.product_motive_id
union all
select moti_comp_attribs_id codigo,
       package_type_id,
       display_name,
       'COMPONENT' nivel 
from open.PS_PRD_MOTIV_PACKAGE pack 
inner join open.PS_PROD_MOTIVE_COMP motcomp  on pack.product_motive_id =motcomp.product_motive_id
inner join OPEN.PS_MOTI_COMP_ATTRIBS comp on motcomp.prod_motive_comp_id=comp.prod_motive_comp_id

)
select t1.order_view,
       t1.package_type_id,
       t1.description,
       t1.external_id,
       t2.package_type_id tramite_conflicto,
       t2.description desc_tramite_conflicto,
       xx.display_name,
       xx.package_type_id,
       (select ps.description from open.ps_package_type ps where ps.package_type_id = xx.package_type_id) tramite,
        nivel
from config_tram t1
join config_tram t2 on t1.order_view=t2.order_view and t1.external_id=t2.external_id and t1.package_type_id!=t2.package_type_id
left join atributos xx on  xx.codigo = t1.external_id 
                               and (t1.order_view = 1 and xx.nivel='PACKAGE' or 
                                    t1.order_view = 2 and xx.nivel='MOTIVE' or
                                    t1.order_view >=3 and xx.nivel='COMPONENT')
where t1.package_type_id in (100369);






