select a.*, rowid
  from OPEN.GE_XSL_TEMPLATE a
 where 1 = 1
   AND A.XSL_TEMPLATE_ID = 2166
--and upper(a.template_source) like upper('%genera%orden%')
;
select gs.*, rowid
  from open.ge_statement gs
 where 1 = 1
   and upper(gs.description) like upper('%LDC_AL_DISENO_REALIZADO%')
--and upper(gs.statement) like upper('%roles%')
;
select a.*, rowid
  from OPEN.GE_NOTIFICATION a
 where 1 = 1
      --AND A.NOTIFICATION_ID = 100490
   and a.xsl_template_id = 2166
--upper(a.description) like upper('%roles%')
;
--select a.*, rowid from OPEN.GE_NOTIFI_STATEMENT a where a. like upper('%generado%tipo%roles%');
select a.*, rowid
  from OPEN.GE_MESG_ALERT a
 where upper(a.name) like upper('%roles%');

select a.*, rowid from OPEN.GE_PERSON_ALERT a where a.;

select a.*, rowid from OPEN.GE_MESG_ALERT a where a. =;

select a.*, rowid from OPEN.GE_NOTIFICATION a where a. =;

select a.*, rowid
  from OPEN.GE_NOTIFICATION_LOG a
 where upper(a.output_text) like upper('%roles%')
   and trunc(a.date_) = '16/01/2026';

select *
  from open.GE_NOTIFICATION_LOG t
 where t.input_data = 'NUORDER_ID=389935733';

select a.*, rowid from OPEN.GE_MESG_ALERT a where a. =;

select a.*, rowid from OPEN.GE_NOTIFICATION a where a. =;

select a.*, rowid
  from OPEN.GE_NOTIFICATION_LOG a
 where upper(a.output_text) like upper('%roles%')
   and trunc(a.date_) = '16/01/2026';

select *
  from open.GE_NOTIFICATION_LOG t
 where t.input_data = 'NUORDER_ID=389935733'
