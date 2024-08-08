select i.unit_id,
       ia.attribute_id,
       (select a.display_name from open.ge_attributes a where a.attribute_id=ia.attribute_id),
       ia.statement_id
from wf_instance_attrib atr
inner join open.wf_instance i on i.instance_id=atr.instance_id
inner join wf_unit_attribute ia on ia.unit_id=i.unit_id and ia.statement_id is not null and ia.attribute_id=atr.attribute_id
where atr.instance_id=-1777318447

---1777550272;





select *
from open.ge_statement
where statement_id=120196965
for update;

-- statement financiacion =120196955
--statement negociación = 120196965


select  sysdate + 5/(1440) from dual;

select  ut_date.fsbSTR_DATE(sysdate + 5/(1440)) from dual
