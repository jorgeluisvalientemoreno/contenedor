select *
from open.cc_causal
where causal_id=444;
select *
from open.cc_causal_type
where causal_type_id=97 ;

select *
from dba_sequences
where sequence_name='SEQ_CC_CAUSAL_184373';

select open.SEQ_CC_CAUSAL_184373.nextval from dual

select *
from dba_sequences
where sequence_name='SEQ_CC_CAUSAL_TYPE_184374';

select *
from dba_sequences
where sequence_name='SQPS_PACKAGE_CAUSALTYP';


select *
from dba_sequences
where sequence_name='SEQ_OR_ACT_BY_REQ_DATA';

select open.SEQ_OR_ACT_BY_REQ_DATA.nextval from dual


select *
from dba_sequences s
where s.SEQUENCE_NAME like '%SEQ_GR_CONFIG_EXPRESSION%'




select e.entity_attribute_id,e.display_name, e.init_expression_id,(select code from open.gr_config_expression s where s.config_expression_id=e.init_expression_id)
from open.ge_entity a, open.ge_entity_attributes e
where a.entity_id=e.entity_id
and a.name_=upper('or_act_by_req_data');
