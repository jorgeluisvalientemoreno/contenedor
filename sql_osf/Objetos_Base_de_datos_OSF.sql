select B.OWNER         ESQUEMA,
       B.OBJECT_NAME   NOMBRE,
       B.OBJECT_TYPE   TIPO,
       B.CREATED       FECHA_CREACION,
       B.LAST_DDL_TIME FECHA_ULTIMA_ACTUALIZACION,
       B.status        ESTADO,
       B.TEMPORARY     TEMPORAL
  from dba_objects b
 where b.OBJECT_NAME like (upper('%fnu_baseliquidacion%'))
   --and b.OWNER = 'OPEN'
   ---and b.OBJECT_TYPE = 'TABLE'
 order by B.OBJECT_NAME;

/*select distinct a.owner, a.name, b.OBJECT_TYPE
  from dba_source a, dba_objects b
 where --upper(a.text) like '%LDC_BOASIGAUTO%'
--and a.name = b.OBJECT_NAME
 and a.name in ('FNU_VALIDATIPOEXENCION',
            'FNU_VALIDATIPOEXENCIONSOLICITUD',
            'LDC_FNURETTIPOEXCEP');*/
