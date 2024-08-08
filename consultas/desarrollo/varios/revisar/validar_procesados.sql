  select procesado, count(1), decode(procesado,'Y',  count(1)-4031077, 21248177-count(1))
  from instances_to_delete_20221104 
  group by procesado 
  --4027382
  --1047 9:19
  
  
  
 ; 
 with base as(select  4027128 as min, 6683643 max from dual union all
select 6683644 as min,    9340160 max from dual union all
select 9340161   as min,  11996677 max from dual union all
select 11996678 as min,    14653194 max from dual union all
select 14653195 as min, 	 17309710 max from dual union all
select 17309711 as min, 	 19966227 max from dual union all
select 19966228 as min, 	 22622744 max from dual union all
select 22622745 as min, 	 25279261 max from dual
)
select base.min, base.max, max(id), base.max-max(id) pendiente,max(id)-base.min procesado
 from instances_to_delete_20221104 del
inner join base on del.id>=base.min and del.id<=base.max 
where del.procesado='Y'
group by base.min, base.max
