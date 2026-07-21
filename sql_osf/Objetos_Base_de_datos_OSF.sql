select B.OWNER         ESQUEMA,
       B.OBJECT_NAME   NOMBRE,
       comments        Descripcion,
       B.OBJECT_TYPE   TIPO,
       B.CREATED       FECHA_CREACION,
       B.LAST_DDL_TIME FECHA_ULTIMA_ACTUALIZACION,
       B.status        ESTADO,
       B.TEMPORARY     TEMPORAL
  from dba_objects b
  LEFT join all_tab_comments
    on table_name = b.OBJECT_NAME
 where 1 = 1
      --and upper(b.OBJECT_NAME) like (upper('%pkg_boGestionSolicitudes%'))
   and b.OWNER in
       ('OPEN', 'ADM_PERSON', 'PESONALIZACIONES', 'MULTIEMPRESA')
   and b.OBJECT_TYPE in ('TABLE') --'PACKAGE', 'PROCEDURE', 'FUNCTION', 'TRIGGER')
--and not exists (select 1 from PERSONALIZACIONES.HOMOLOGACION_SERVICIOS a where upper(a.servicio_origen) like '%' || upper(b.OBJECT_NAME) || '%')
--and upper(b.OBJECT_NAME) like upper('%LDC_PRLIQUIDACONTRA%')
---and b.OBJECT_TYPE = 'TABLE'
 order by B.OBJECT_NAME;

/*select distinct a.owner, a.name, b.OBJECT_TYPE
  from dba_source a, dba_objects b
 where --upper(a.text) like '%LDC_BOASIGAUTO%'
--and a.name = b.OBJECT_NAME
 and a.name in ('FNU_VALIDATIPOEXENCION',
            'FNU_VALIDATIPOEXENCIONSOLICITUD',
            'LDC_FNURETTIPOEXCEP');*/
