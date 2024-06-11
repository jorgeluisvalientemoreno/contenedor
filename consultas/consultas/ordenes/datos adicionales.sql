select *
from open.ge_attrib_set_attrib s
where s.attribute_set_id in (11718,13019,13020)
select tda.task_type_id, open.daor_task_type.fsbgetdescription(tda.task_type_id, null) desc_titr, tda.active, sete.*, a.*
from open.OR_TASKTYPE_ADD_DATA tda, open.ge_attrib_set_attrib gd, open.ge_attributes a, open.ge_attributes_set sete
where tda.attribute_set_id=gd.attribute_set_id
  and gd.attribute_id=a.attribute_id
  --and gd.attribute_set_id=140087
  and tda.task_type_id=12981  
 -- and tda.active='Y'
  and sete.attribute_set_id=tda.attribute_set_id;

select *
from open.ge_attributes
WHERE name_attribute='EXIST_VALUE';

211257816
1369436
UNIT_TYPE_283

select OPEN.ldc_fnuGetCausalTramiteReconRP(damo_component.fnugetpackage_id(26321060)) EXIST_VALUE from dual;

  select o.* --min(o.order_id) order_id
        from open.mo_packages p,
             open.or_order_activity a,
             open.or_order o
        where p.package_id = 26321060
          and p.package_id = a.package_id
          and a.order_id = o.order_id
          and p.package_id is not null
          and o.task_type_id in (select distinct i.task_type_id
                                 from open.or_task_types_items i,
                                      open.or_act_by_req_data p
                                 where i.items_id = p.item_id
                                   and P.MOTIVE_TYPE_ID = 9);
                                   
select *
from open.ge_error_log
where error_log_id=494162;
select o.causal_id, c.*
from open.or_order o, open.ge_causal c
where order_id=28967260
  and o.causal_id=c.causal_id
from dual
AND NAME_ATTRIBUTE LIKE '%PNO%';
SELECT * FROM OPEN.PS_PACK_TYPE_PARAM WHERE PACKAGE_TYPE_ID=100225;
SELECT * FROM OPEN.GE_ATTRIBUTE_CLASS;

SELECT * FROM OPEN.PS_PACK_TYPE_PARAM WHERE PACKAGE_TYPE_ID=100153;

select *
from open.OR_REQU_DATA_VALUE
where order_id in (16269870,16589155);

--EJEMPLO BUSCAR X ORDEN
select a3.package_id, 
       A.NAME_ATTRIBUTE, 
       S.CAPTURE_ORDER,
       case when CEIL(s.capture_order/20) > 1 then   
                 decode((s.capture_order-(CEIL(s.capture_order/20)*10 )),1, name_1,2,name_2,3, name_3, 4, name_4, 5,name_5, 6, name_6, 7,name_7, 8,name_8, 9,name_9,10,name_10,11,name_11,12,name_12,13, name_13, 14,name_14, 15, name_15, 16, name_16,17, name_17, 18, name_18, 19, name_19, 20,name_20, 'NA')
                else
                  decode(s.capture_order,1, name_1,2,name_2,3, name_3, 4, name_4, 5,name_5, 6, name_6, 7,name_7, 8,name_8, 9,name_9,10,name_10,11,name_11,12,name_12,13, name_13, 14,name_14, 15, name_15, 16, name_16,17, name_17, 18, name_18, 19, name_19, 20,name_20, 'NA')
               
            end ,
      
       case when CEIL(s.capture_order/20) > 1 then   
                 decode((s.capture_order-(CEIL(s.capture_order/20)*10 )),1, value_1,2,value_2,3, value_3, 4, value_4, 5,value_5, 6, value_6, 7,value_7, 8,value_8, 9,value_9,10,value_10,11,value_11,12,value_12,13, value_13, 14,value_14, 15, value_15, 16, value_16,17, value_17, 18, value_18, 19, value_19, 20,value_20, 'NA')
                else
                  decode(s.capture_order,1, value_1,2,value_2,3, value_3, 4, value_4, 5,value_5, 6, value_6, 7,value_7, 8,value_8, 9,value_9,10,value_10,11,value_11,12,value_12,13, value_13, 14,value_14, 15, value_15, 16, value_16,17, value_17, 18, value_18, 19, value_19, 20,value_20, 'NA')
               
            end 
from open.OR_TASKTYPE_ADD_DATA D,open.ge_attrib_set_attrib s,  open.ge_attributes a, open.or_requ_data_value r , open.or_order o, open.or_order_activity a3
where d.task_type_id=O.TASK_TYPE_ID
  AND D.ATTRIBUTE_SET_ID=s.ATTRIBUTE_SET_ID
  and s.attribute_id=a.attribute_id
--  and a.name_attribute  in ('LONG_INST_INTERNA','MATERIAL_INST_INTERNA','PTOS_ADICIONALES','PTOS_OPCIONALES','PUNTOS_CONST_INST','UBICACI�N_INST_INTERNA') 
  and r.attribute_set_id=d.attribute_set_id
and r.order_id=o.order_id
and O.order_id=52622719
and o.order_id=a3.order_id
and A.attribute_id = 5001778
--and exists(select null from or_order_activity a2 where a2.package_id=a3.package_id and status='R' and task_type_id=12135)
select *
from open.or_requ_data_value
where order_id=24680480


SELECT GR.ATTRIBUTE_SET_ID,  AT.ATTRIBUTE_ID, GR.CAPTURE_ORDER, 
       DECODE(GR.CAPTURE_ORDER-1,1, IT.NAME_1, 2,IT.NAME_2, 3, IT.NAME_3, 4, IT.NAME_4, 5,IT.NAME_5, 6, IT.NAME_6, 7,IT.NAME_7, 8,IT.NAME_8, 9,IT.NAME_9,10,IT.NAME_10,11,IT.NAME_11,12,IT.NAME_12,13, IT.NAME_13, 14,IT.NAME_14, 15, IT.NAME_15, 16, IT.NAME_16, 17, IT.NAME_17,  18, IT.NAME_18, 19, IT.NAME_19, 20,IT.NAME_20, 'NA') DATO,
       DECODE(GR.CAPTURE_ORDER-1,1, IT.VALUE_1,2,IT.VALUE_2,3, IT.VALUE_3, 4, IT.VALUE_4, 5,IT.VALUE_5, 6, IT.VALUE_6, 7,IT.VALUE_7, 8,IT.VALUE_8, 9,IT.VALUE_9,10,IT.VALUE_10,11,IT.VALUE_11,12,IT.VALUE_12,13, IT.VALUE_13, 14,IT.VALUE_14, 15, IT.VALUE_15, 16, IT.VALUE_16,17, IT.VALUE_17, 18, IT.VALUE_18, 19, IT.VALUE_19, 20,IT.VALUE_20, 'NA') VALOR,
       DECODE(GR.CAPTURE_ORDER,1, CA.NAME_1, 2,CA.NAME_2, 3, CA.NAME_3, 4, CA.NAME_4, 5,CA.NAME_5, 6, CA.NAME_6, 7,CA.NAME_7, 8,CA.NAME_8, 9,CA.NAME_9,10,CA.NAME_10,11,CA.NAME_11,12,CA.NAME_12,13, CA.NAME_13, 14,CA.NAME_14, 15, CA.NAME_15, 16, CA.NAME_16, 17, CA.NAME_17,  18, CA.NAME_18, 19, CA.NAME_19, 20,CA.NAME_20, 'NA') DATO,
DECODE(GR.CAPTURE_ORDER,1, CA.VALUE_1,2,CA.VALUE_2,3, CA.VALUE_3, 4, CA.VALUE_4, 5,CA.VALUE_5, 6, CA.VALUE_6, 7,CA.VALUE_7, 8,CA.VALUE_8, 9,CA.VALUE_9,10,CA.VALUE_10,11,CA.VALUE_11,12,CA.VALUE_12,13, CA.VALUE_13, 14,CA.VALUE_14, 15, CA.VALUE_15, 16, CA.VALUE_16,17, CA.VALUE_17, 18, CA.VALUE_18, 19, CA.VALUE_19, 20,CA.VALUE_20, 'NA') VALOR
FROM OPEN.OR_REQU_DATA_VALUE IT, OPEN.OR_REQU_DATA_VALUE CA, OPEN.GE_ATTRIB_SET_ATTRIB GR, OPEN.GE_ATTRIBUTES AT
WHERE IT.ORDER_ID=CA.ORDER_ID
  AND CA.ORDER_ID=&ORDEN
  AND CA.ATTRIBUTE_SET_ID=IT.ATTRIBUTE_SET_ID
  AND GR.ATTRIBUTE_SET_ID=IT.ATTRIBUTE_SET_ID
  AND GR.ATTRIBUTE_SET_ID =&inuAttributeSetId
  AND GR.ATTRIBUTE_ID=AT.ATTRIBUTE_ID
  AND MOD(GR.CAPTURE_ORDER,2)=0
  AND DECODE(GR.CAPTURE_ORDER-1,1, IT.NAME_1, 2,IT.NAME_2, 3, IT.NAME_3, 4, IT.NAME_4, 5,IT.NAME_5, 6, IT.NAME_6, 7,IT.NAME_7, 8,IT.NAME_8, 9,IT.NAME_9,10,IT.NAME_10,11,IT.NAME_11,12,IT.NAME_12,13, IT.NAME_13, 14,IT.NAME_14, 15, IT.NAME_15, 16, IT.NAME_16, 17, IT.NAME_17,  18, IT.NAME_18, 19, IT.NAME_19, 20,IT.NAME_20, 'NA')!='NA';


  select r.order_id,
          atrxgr.attribute_set_id codigo_grupo,
          gr.description,
          r.name_11,
          atrxgr.attribute_id,
          atr.name_attribute,
          case when nvl(r.name_1,'-1')= nvl(atr.name_attribute,'-2') then r.value_1
               when nvl(r.name_2,'-1')= nvl(atr.name_attribute,'-2') then r.value_2
               when nvl(r.name_3,'-1')= nvl(atr.name_attribute,'-2') then r.value_3
               when nvl(r.name_4,'-1')= nvl(atr.name_attribute,'-2') then r.value_4
               when nvl(r.name_5,'-1')= nvl(atr.name_attribute,'-2') then r.value_5                                    
               when nvl(r.name_6,'-1')= nvl(atr.name_attribute,'-2') then r.value_6                 
               when nvl(r.name_7,'-1')= nvl(atr.name_attribute,'-2') then r.value_7            
               when nvl(r.name_8,'-1')= nvl(atr.name_attribute,'-2') then r.value_8
               when nvl(r.name_9,'-1')= nvl(atr.name_attribute,'-2') then r.value_9
               when nvl(r.name_10,'-1')= nvl(atr.name_attribute,'-2') then r.value_10
               when nvl(r.name_11,'-1')= nvl(atr.name_attribute,'-2') then r.value_11
               when nvl(r.name_12,'-1')= nvl(atr.name_attribute,'-2') then r.value_12
               when nvl(r.name_13,'-1')= nvl(atr.name_attribute,'-2') then r.value_13
               when nvl(r.name_14,'-1')= nvl(atr.name_attribute,'-2') then r.value_14
               when nvl(r.name_15,'-1')= nvl(atr.name_attribute,'-2') then r.value_15
               when nvl(r.name_16,'-1')= nvl(atr.name_attribute,'-2') then r.value_16
               when nvl(r.name_17,'-1')= nvl(atr.name_attribute,'-2') then r.value_17
               when nvl(r.name_18,'-1')= nvl(atr.name_attribute,'-2') then r.value_18
               when nvl(r.name_19,'-1')= nvl(atr.name_attribute,'-2') then r.value_19                                                                                                                                                                                                           
      when nvl(r.name_20,'-1')= nvl(atr.name_attribute,'-2') then r.value_20                                                                                                                                                                                                           
         end valor
   from open.or_requ_data_value r
   inner join ge_attrib_set_attrib atrxgr on atrxgr.attribute_set_id = r.attribute_set_id  
   inner join ge_attributes_set gr on gr.attribute_set_id = r.attribute_set_id 
   inner join ge_attributes atr on atr.attribute_id=atrxgr.attribute_id and (
   nvl(r.name_1,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_2,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_3,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_4,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_5,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_6,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_7,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_8,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_9,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_10,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_11,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_12,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_13,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_14,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_15,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_16,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_17,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_18,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_19,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_20,'-1')= nvl(atr.name_attribute,'-2') 
   )
   where r.order_id=294146051
     



alter session set current_schema=open;
with base as(  select r.order_id,
          r.read_date,
          r.task_type_id,
          atrxgr.attribute_set_id codigo_grupo,
          gr.description,
          r.name_11,
          atrxgr.attribute_id,
          atr.name_attribute,
          case when nvl(r.name_1,'-1')= nvl(atr.name_attribute,'-2') then r.value_1
               when nvl(r.name_2,'-1')= nvl(atr.name_attribute,'-2') then r.value_2
               when nvl(r.name_3,'-1')= nvl(atr.name_attribute,'-2') then r.value_3
               when nvl(r.name_4,'-1')= nvl(atr.name_attribute,'-2') then r.value_4
               when nvl(r.name_5,'-1')= nvl(atr.name_attribute,'-2') then r.value_5                                    
               when nvl(r.name_6,'-1')= nvl(atr.name_attribute,'-2') then r.value_6                 
               when nvl(r.name_7,'-1')= nvl(atr.name_attribute,'-2') then r.value_7            
               when nvl(r.name_8,'-1')= nvl(atr.name_attribute,'-2') then r.value_8
               when nvl(r.name_9,'-1')= nvl(atr.name_attribute,'-2') then r.value_9
               when nvl(r.name_10,'-1')= nvl(atr.name_attribute,'-2') then r.value_10
               when nvl(r.name_11,'-1')= nvl(atr.name_attribute,'-2') then r.value_11
               when nvl(r.name_12,'-1')= nvl(atr.name_attribute,'-2') then r.value_12
               when nvl(r.name_13,'-1')= nvl(atr.name_attribute,'-2') then r.value_13
               when nvl(r.name_14,'-1')= nvl(atr.name_attribute,'-2') then r.value_14
               when nvl(r.name_15,'-1')= nvl(atr.name_attribute,'-2') then r.value_15
               when nvl(r.name_16,'-1')= nvl(atr.name_attribute,'-2') then r.value_16
               when nvl(r.name_17,'-1')= nvl(atr.name_attribute,'-2') then r.value_17
               when nvl(r.name_18,'-1')= nvl(atr.name_attribute,'-2') then r.value_18
               when nvl(r.name_19,'-1')= nvl(atr.name_attribute,'-2') then r.value_19                                                                                                                                                                                                           
      when nvl(r.name_20,'-1')= nvl(atr.name_attribute,'-2') then r.value_20                                                                                                                                                                                                           
         end valor
   from open.or_requ_data_value r
   inner join ge_attrib_set_attrib atrxgr on atrxgr.attribute_set_id = r.attribute_set_id  
   inner join ge_attributes_set gr on gr.attribute_set_id = r.attribute_set_id 
   inner join ge_attributes atr on atr.attribute_id=atrxgr.attribute_id and (
   nvl(r.name_1,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_2,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_3,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_4,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_5,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_6,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_7,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_8,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_9,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_10,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_11,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_12,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_13,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_14,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_15,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_16,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_17,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_18,'-1')= nvl(atr.name_attribute,'-2')
or nvl(r.name_19,'-1')= nvl(atr.name_attribute,'-2') 
or nvl(r.name_20,'-1')= nvl(atr.name_attribute,'-2') 
   )
   where r.task_type_id in (12669,12669,12669,12671,12671,12671,12672,12672,12672,12678,12678,12678,12667,12668,12669,12667,12667,12667,12668,12668,12668,10349,12671,12672,12678)
    and r.read_date>='01/01/2023'
    --and r.attribute_id=5001382
    )
    
select *
from base
where attribute_id=5001382
     