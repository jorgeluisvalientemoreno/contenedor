SELECT *
  FROM DBA_OBJECTS a
 WHERE upper(a.OBJECT_NAME) = upper('LD_BOCONSTANS');

select *
  from dba_dependencies a
 where upper(a.REFERENCED_NAME) = upper('LD_BOCONSTANS'); --PKG_GESTION_PRODUCTO

select *
  from dba_dependencies a
 where upper(a.name) = upper('LD_BOCONSTANS'); --PKG_GESTION_PRODUCTO

select a.name, a.TYPE
  from dba_source a
 where upper(a.TEXT) like upper('%LD_BOCONSTANS%')
--and a.TYPE = 'TRIGGER'
 group by a.name, a.TYPE;

select *
  from dba_jobs a
 where upper(a.WHAT) in (select a.name
                           from dba_source a
                          where upper(a.TEXT) like upper('%LD_BOCONSTANS%')
                          group by a.name)
--like upper('%LD_BOCONSTANS%')
;

select a.*, rowid
  from OPEN.GE_OBJECT a --where upper(a.name_) like upper('%LDC%Interacci%')
 where upper(a.name_) in (select a.name
                            from dba_source a
                           where upper(a.TEXT) like upper('%LD_BOCONSTANS%')
                           group by a.name)
--like upper('%LD_BOCONSTANS%')

;
select gps.*, dj.*
  from open.ge_process_schedule gps,
       dba_jobs dj,
       (select g.object_id
          from open.ge_object g
         where upper(g.name_) in
               (select a.name
                  from dba_source a
                 where upper(a.TEXT) like upper('%LD_BOCONSTANS%')
                 group by a.name)
        --like upper('%LD_BOCONSTANS%')
        ) gobject
 where gps.parameters_ like '%' || gobject.object_id || '%'
   and gps.job != -1
   and gps.job = dj.JOB;

select gs.*, rowid
  from open.ge_statement gs
 where upper(gs.statement) like upper('%LD_BOCONSTANS%');

/*select *
  from dba_dependencies a
 where upper(a.REFERENCED_NAME) in
       ('GE_SUBS_WORK_RELAT',
        'GE_SUBS_HOUSING_DATA',
        'LDC_ENERGETICO_ANT',
        'LDC_DAADVENTA',
        'GE_SUBS_PHONE',
        'MO_MOT_PROMOTION',
        'MO_GAS_SALE_DATA')
   and type = 'SYNONYM'
   and a.OWNER in ('OPEN', 'PERSONALIZACIONES', 'ADM_PERSON')*/
--and upper(a.NAME) = upper('LDC_fnuRetTipoExcep');
