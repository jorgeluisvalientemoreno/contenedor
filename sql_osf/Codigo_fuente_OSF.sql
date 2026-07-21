select s.owner, s.name, s.TYPE
  from dba_source s
 where 1 = 1
   and upper(s.TEXT) like upper('%SEVAASAU%')
--and upper(s.name) like upper('%ADIC%')
--and s.TYPE = 'TRIGGER'
 group by s.owner, s.name, s.TYPE;
--ADM_PERSON.LDC_TRG_DEFINED_CONTRAC

select s.owner, s.name, s.TYPE
  from dba_source s
 where 1 = 1
   and upper(s.TEXT) like upper('%SEVAASAU%')
      --and upper(s.name) like upper('%ADIC%')
      --and s.TYPE = 'TRIGGER'
   and (select count(1)
          from dba_jobs a
         where a.WHAT like '%' || s.name || '%') > 0
 group by s.owner, s.name, s.TYPE;
--ADM_PERSON.LDC_TRG_DEFINED_CONTRAC
--pValidaActividadVSI
