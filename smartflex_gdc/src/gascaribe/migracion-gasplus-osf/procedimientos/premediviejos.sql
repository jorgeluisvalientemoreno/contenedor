CREATE OR REPLACE PROCEDURE      PREMEDIVIEJOS (NUMINICIO NUMBER,NUMFINAL NUMBER,inubasedato number) AS

   nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
   vfecha_ini          DATE;
   VFECHA_FIN          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
   vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   sbMedidor          varchar2(50);
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0; 
   sbsql varchar2(800);
    maxnumber number;
   
BEGIN
   UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=800;
   commit;
      

   PKLOG_MIGRACION.prInsLogMigra (800,800,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);

   pkg_constantes.Complemento(inubasedato,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);

   -- Medidores Cali   
   insert into ldc_mig_mediviejos 
   select distinct lectnuse,basedato,lectmedi 
   from ldc_temp_lectura_SGE a
   where basedato=inubasedato 
   --and   exists (select 1 from ldc_temp_servsusc_Sge where sesumedi=lectmedi)
   and   not exists (select 1 from elmesesu where upper(emsscoem)=upper(lectmedi) and emsssesu=lectnuse+nuComplementoPR)
   and not exists (select 1 from ldc_mig_mediviejos b where nuse=lectnuse and a.basedato=b.basedato and upper(b.medi)=upper(a.lectmedi));
   commit;

-- Se actualiza la secuencia de SQELEMMEDI al maximo de los ge_items_seriado
   --------------------------------
   BEGIN
   -- SECUENCIA SQELEMMEDI
    sbsql:='DROP SEQUENCE OPEN.SQELEMMEDI';

    execute immediate sbsql;

    SELECT max(id_items_seriado) + 1 INTO maxnumber FROM GE_ITEMS_SERIADO where id_items_seriado not in (999999999999999,999999);

    sbsql:=
    'CREATE SEQUENCE OPEN.SQELEMMEDI
      START WITH '||maxnumber||'
      MAXVALUE 9999999999999999999999999999
      MINVALUE 1
      NOCYCLE
      CACHE 20
      ORDER';
      
      execute immediate sbsql;
    END;
    --------------------------------

   PKLOG_MIGRACION.prInsLogMigra (800,800,3,vprograma,0,0,'Inicia Proceso','FIN',nuLogError);

    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=800;
   commit;     
   
end; 
/
