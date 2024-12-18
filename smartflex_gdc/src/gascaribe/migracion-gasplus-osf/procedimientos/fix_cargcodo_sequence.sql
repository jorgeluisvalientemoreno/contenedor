CREATE OR REPLACE PROCEDURE      FIX_CARGCODO_SEQUENCE (NUMINICIO number, numFinal number, INUBASEDATO number) AS
  /*******************************************************************
 PROGRAMA        :    CONSSESU_C
 FECHA            :    27/09/2012
 AUTOR            :
 DESCRIPCION    :    Migra la informacion de los consumos de servicios
                    suscriptos a la tabla CONSSESU de OSF

 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION

 *******************************************************************/

maxnumber number;
sbsql varchar2(800);
nuLogError number;
BEGIN

    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra ( 3612,3612,1,'FIX_CARGCODO_SEQUENCE',0,0,'INICIA PROCESO','INICIA',nuLogError);
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrain=NUMFINAL AND raprcodi=3612;
    commit;
    -- SECUENCIA SEQ_GE_SUBSCRIBER
    sbsql:='DROP SEQUENCE OPEN.SQ_CARGOS_CARGCODO';

    execute immediate sbsql;

    SELECT max(cargcodo) + 1 into  maxnumber FROM cargos;

    sbsql:=
    'CREATE SEQUENCE OPEN.SQ_CARGOS_CARGCODO
     START WITH '||maxnumber||'
     MAXVALUE 9999999999999999999999999999
     MINVALUE 1
     NOCYCLE
     CACHE 20
     ORDER';

    execute immediate sbsql;

    sbsql:='GRANT SELECT ON OPEN.SQ_CARGOS_CARGCODO TO SYSTEM_OBJ_PRIVS_ROLE';

    execute immediate sbsql;

    -- Termina Log

    PKLOG_MIGRACION.prInsLogMigra (3612,3612,3,'FIX_CARGCODO_SEQUENCE',0,0,'TERMINA PROCESO','FIN',nuLogError);
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=3612;
    commit;
EXCEPTION
   WHEN OTHERS
   THEN
      PKLOG_MIGRACION.prInsLogMigra (3612,3612,2,'FIX_CARGCODO_SEQUENCE',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);

END FIX_CARGCODO_SEQUENCE; 
/
