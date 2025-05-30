/*SELECT *
  FROM (select owner PROPIETARIO,
               name NOMBRE,
               DECODE(TYPE, 'PACKAGE BODY', 'PACKAGE', TYPE) TIPO
          from dba_source
         where upper(TEXT) like upper('%LD_DETAIL_LIQUI_SELLER%')) A,
       (select owner PROPIETARIO,
               name NOMBRE,
               decode(type, 'PACKAGE BODY', 'PACKAGE', type) TIPO
          from all_dependencies
         where referenced_name = '.LD_DETAIL_LIQUI_SELLER') B
 where A.PROPIETARIO = B.PROPIETARIO
   and A.NOMBRE = B.NOMBRE
   and A.TIPO = B.TIPO;*/

with objetos_codigo as
 (select owner PROPIETARIO,
         name NOMBRE,
         decode(type, 'PACKAGE BODY', 'PACKAGE', type) TIPO
    from dba_source
   where upper(TEXT) like '%LD_DETAIL_LIQUI_SELLER%')
select * from objetos_codigo group by PROPIETARIO, NOMBRE, TIPO;

SELECT C.CONSTRAINT_Name FORANEA,
       C.TABLE_NAME      ENTIDAD,
       CC.COLUMN_NAME    COLUMNA
  FROM ALL_CONSTRAINTS C, All_Cons_colUMNs CC
 WHERE C.Constraint_Name = CC.Constraint_Name
   AND R_CONSTRAINT_NAME in
       (SELECT CONSTRAINT_NAME
          FROM ALL_CONSTRAINTS
         WHERE TABLE_NAME like UPPER('%LD_DETAIL_LIQUI_SELLER%'));

/*with objetos_dependientes as
 (select owner PROPIETARIO,
         name NOMBRE,
         decode(type, 'PACKAGE BODY', 'PACKAGE', type) TIPO
    from all_dependencies
   where referenced_name = 'LD_DETAIL_LIQUI_SELLER')
select * from objetos_dependientes group by PROPIETARIO, NOMBRE, TIPO;
*/
/*SELECT *
  FROM DBA_OBJECTS a
 WHERE upper(a.OBJECT_NAME) = upper('LD_DETAIL_LIQUI_SELLER');
*/
/*select *
  from dba_dependencies a
 where upper(a.REFERENCED_NAME) = upper('LD_DETAIL_LIQUI_SELLER'); --PKG_GESTION_PRODUCTO*/

/*select *
  from dba_dependencies a
 where upper(a.name) = upper('LD_DETAIL_LIQUI_SELLER'); --PKG_GESTION_PRODUCTO*/

/*
select owner PROPIETARIO,
         name NOMBRE,
         decode(type, 'PACKAGE BODY', 'PACKAGE', type) TIPO
    from all_dependencies
   where referenced_name = 'LD_DETAIL_LIQUI_SELLER'
left join 
select owner PROPIETARIO,
       name NOMBRE,
       decode(type, 'PACKAGE BODY', 'PACKAGE', type) TIPO
  from dba_source
 where upper(TEXT) like '%LD_DETAIL_LIQUI_SELLER%';
*/

/*select a.owner, a.name, a.TYPE
  from dba_source a
 where upper(a.TEXT) like upper('%LD_DETAIL_LIQUI_SELLER%')
--and a.TYPE = 'TRIGGER'
 group by a.owner, a.name, a.TYPE;*/
/*
select *
  from dba_jobs a, (select upper(a.name) nombre
          from dba_source a
         where upper(a.TEXT) like upper('%LD_DETAIL_LIQUI_SELLER%')
         group by a.name) objeto
 where upper(a.WHAT) like '%' || objeto.nombre || '%'
--like upper('%LD_DETAIL_LIQUI_SELLER%')
;
*/

select a.*
  from OPEN.GE_OBJECT a,
       (select upper(a.name) nombre
          from dba_source a
         where upper(a.TEXT) like upper('%LD_DETAIL_LIQUI_SELLER%')
         group by a.name) objeto
 where upper(a.name_) like '%' || objeto.nombre || '%'
--like upper('%LD_DETAIL_LIQUI_SELLER%')

;
/*
select gps.*, dj.*
  from open.ge_process_schedule gps,
       dba_jobs dj,
       (select g.object_id
          from open.ge_object g
         where upper(g.name_) in
               (select a.name
                  from dba_source a
                 where upper(a.TEXT) like upper('%LD_DETAIL_LIQUI_SELLER%')
                 group by a.name)
        --like upper('%LD_DETAIL_LIQUI_SELLER%')
        ) gobject
 where gps.parameters_ like '%' || gobject.object_id || '%'
   and gps.job != -1
   and gps.job = dj.JOB;
*/
select gs.*, rowid
  from open.ge_statement gs
 where upper(gs.statement) like upper('%LD_DETAIL_LIQUI_SELLER%');

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
