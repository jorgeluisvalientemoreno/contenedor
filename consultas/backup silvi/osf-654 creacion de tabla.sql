CREATE TABLE infopuerto (    
       cosssesu  number(10),
       cosspefa number(6),
       cosspecs number(15),
       cosscoca number(16),
       cossfere  date,
       legalization_date date,
       task_type_id number(10),
       cossmecc  number(4),
       cossidre number(10),
       cosscavc number(4),
       order_id number(15) ,
       value1  varchar(2000),
       value2 varchar(2000),
       exec_initial_date date, 
       execution_final_date date) 
       
       
INSERT INTO infopuerto  (cosssesu, 
                     cosspefa, 
                     cosspecs,
                     cosscoca ,
                     cossfere ,
                     legalization_date ,
                     task_type_id ,
                     cossmecc ,
                     cossidre ,
                     cosscavc ,
                     order_id ,
                     value1  ,
                     value2 ,
                     exec_initial_date , 
                     execution_final_date ) 
SELECT c.cosssesu,
       c.cosspefa,
       c.cosspecs,
       c.cosscoca,
       c.cossfere,
       ac.legalization_date,
       ac.task_type_id,
       c.cossmecc,
       c.cossidre,
       c.cosscavc,
       ac.order_id,
       ac.value1 ,
       ac.value2 ,
       ac.exec_initial_date , 
       ac.execution_final_date 
from open.conssesu@osfpl c
inner join open.perifact@osfpl p on p.pefacodi=c.cosspefa and p.pefaano=2022 and p.pefames=10 and trunc(c.cossfere) between trunc(p.pefafimo) and trunc(p.pefaffmo)
inner join open.pericose@osfpl ct on ct.pecscons=c.cosspecs
left join( select o.order_id, o.task_type_id, o.legalization_date, a.product_id, a.value1, a.value2 ,o.exec_initial_date  , o.execution_final_date
           from open.or_order_activity@osfpl a
           inner join open.or_order@osfpl o on o.order_id=a.order_id
           and o.task_type_id in (12617, 10043,12619)
          ) ac  on ac.product_id=c.cosssesu and to_char(ac.legalization_date,'dd/mm/yyyy hh24:mi')= to_char(c.cossfere,'dd/mm/yyyy hh24:mi')
where c.cosspecs in( 102267,102159)
 and cossmecc in (1,3)
 and cosscavc <> 9 
 and not exists(select null from open.elmesesu@osfpl e where e.emsssesu=c.cosssesu and e.emssfein between p.pefafimo and p.pefaffmo)
 ; 
