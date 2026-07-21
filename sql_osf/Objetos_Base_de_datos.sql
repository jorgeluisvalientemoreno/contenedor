select g.OWNER || '.' || g.OBJECT_NAME, g.*
  from dba_objects g
 where 1 = 1
   --and g.OWNER in ('OPEN', 'PERSONALIZACIONES', 'ADM_PERSON')
   --and g.OBJECT_TYPE = 'PACKAGE'
   and (g.OBJECT_NAME like upper('%camunda%')
       /*('LDC_ATECLIREPO',
              'PKG_LDC_ATECLIREPO',
              'PKG_LDC_DETAREPOATECLI',
              'PKG_BCPBRSUI',
              'PKG_BOPBRSUI',
              'PKG_UIPBRSUI',
              'PKG_BOSOLICITUD_INTERACCION',
              'PKG_REGLAS_FLUJO_RESP_INTERAC')*/);
--g.OWNER = 'PERSONALIZACIONES'
--LDC_BO_GESTIONSUSPSEG

select g.OWNER || '.' || g.OBJECT_NAME, g.*
  from dba_objects g
 where 1 = 1
   and g.OWNER in ('OPEN', 'PERSONALIZACIONES', 'ADM_PERSON')
   and g.OBJECT_TYPE = 'PACKAGE'
   and g.OBJECT_NAME like
       upper('%LDC_ATECLIREPO%'));
--g.OWNER = 'PERSONALIZACIONES'
--LDC_BO_GESTIONSUSPSEG


