CREATE OR REPLACE PROCEDURE      "NOTASMIGR" (NUMINICIO number, numFinal number ,pbd number) AS
/*******************************************************************
 PROGRAMA        :    NOTASmigr
 FECHA            :    21/05/2014
 AUTOR            :    VICTOR HUGO MUNIVE ROCA
 DESCRIPCION    :    Migra la informacion de las notas generadas a los
                suscriptores
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
procedure notas
as   
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
   VAN NUMBER;
   vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   sbDocumento            varchar2(20) := null;
   NNOTA NUMBER;
   cursor cuNotas
       is
   SELECT /*+ parallel */ CARGCACA,ROWID,
          1 NOTANUME,
          CARGNUSE    NOTASUSC,
          CARGSIGN      CARGSIGN,
          A.CARGFECR    NOTAFECO,
          CARGCUCO      CARGCUCO,
          A.CARGFECR    NOTAFECR,
          1             NOTAUSUA,
          'MIGRA'    NOTATERM,
          70             NOTAPROG,
          'NOTA EN GASPLUS' NOTAOBSE,
          decode(a.CARGSIGN,'DB',70,71)     NOTACONS,
          NULL            NOTANUFI,
          NULL            NOTADOCU,
          NULL            NOTACONF,
          NULL            NOTAIDPR,
          CARGDOSO            NOTADOSO,
          SUBSTR(A.CARGSIGN,1,1)    NOTATINO, -- Transformar de acuerdo al valor que tenga en Gasplus
          -1               NOTAFACT,
          NULL            NOTAPREF,
          NULL            NOTACOAE,
          NULL            NOTAFEEC,
          NULL             NOTAAPMO
        FROM CARGOS a where cargcaca<>2 AND
        (CARGDOSO LIKE 'NC%' OR CARGDOSO LIKE 'ND%') AND CARGSIGN IN ('DB','CR','SA');
  -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuNotas%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
   nuLogError NUMBER;
   nuTotalRegs number := 0;
   nuErrores number := 0;
   doso varchar2(3);
BEGIN
   DELETE FROM LDC_MIG_NOTA_FACTURA;
   COMMIT;
   -- Inserta registro de inicio en el log
   UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=pbd AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=213;
   commit;
   PKLOG_MIGRACION.prInsLogMigra (213,213,1,'NOTASmigr',0,0,'Inicia Proceso','INICIO',nuLogError);
   VAN:=0;
   FOR CNOTA IN cuNotas LOOP
       DECLARE
          SUSC    NUMBER;
          FACTUR  NUMBER;
       BEGIN
            vcontLec := vcontLec +1;
            IF (CNOTA.cargcaca <>2) and (CNOTA.CARGSIGN='DB' OR CNOTA.CARGSIGN='CR' or CNOTA.CARGSIGN='SA') AND
               (SUBSTR(CNOTA.NOTADOSO,1,2)='ND' OR SUBSTR(CNOTA.NOTADOSO,1,2)='NC') THEN
               BEGIN
                    SELECT SESUSUSC INTO SUSC FROM SERVSUSC WHERE SESUNUSE=CNOTA.NOTASUSC;
                    SELECT CUCOFACT INTO FACTUR FROM CUENCOBR WHERE CUCOCODI=CNOTA.CARGCUCO;
                    BEGIN
                           SELECT NOTA INTO NNOTA FROM LDC_MIG_NOTA_FACTURA WHERE FACTURA=FACTUR;
                    EXCEPTION
                            WHEN OTHERS THEN
                              select sq_notas_notanume.nextval into nnota from dual;
                              if SUBSTR(CNOTA.NOTADOSO,1,2)='ND' then
                                 doso:='ND-';
                              ELSE
                                 DOSO:='NC-';
                              END IF;
                              INSERT INTO notas (NOTANUME,NOTASUSC,NOTAFECO,NOTAFECR,NOTAUSUA,NOTATERM,NOTAPROG,NOTAOBSE,
                                 NOTACONS,NOTANUFI,NOTADOCU,NOTACONF,NOTAIDPR,NOTADOSO,NOTATINO,NOTAFACT,
                                 NOTAPREF,NOTACOAE,NOTAFEEC,NOTAAPMO)
                                 VALUES (NNOTA,SUSC,CNOTA.NOTAFECO,CNOTA.NOTAFECR,CNOTA.NOTAUSUA,CNOTA.NOTATERM,CNOTA.NOTAPROG,
                                  CNOTA.NOTAOBSE,CNOTA.NOTACONS,NULL,NULL,NULL,NULL,DOSO||TO_CHAR(NNOTA),CNOTA.NOTATINO,
                                  FACTUR,CNOTA.NOTAPREF,CNOTA.NOTACOAE,CNOTA.NOTAFEEC,CNOTA.NOTAAPMO);
                              INSERT INTO LDC_MIG_NOTA_FACTURA VALUES(NNOTA,FACTUR);
                    END;
                    update cargos set cargtipr='P',cargprog=70,CARGDOSO=DOSO||TO_CHAR(NNOTA),cargcodo=nnota where rowid=cnota.rowid;
                    IF VAN=1000 THEN
                       COMMIT;
                       VAN:=0;
                    ELSE
                      VAN:=VAN+1;
                   END IF;
                   nuTotalRegs := nuTotalRegs + 1;
               EXCEPTION
                   WHEN OTHERS THEN
                        nuErrores := nuErrores + 1;
                        PKLOG_MIGRACION.prInsLogMigra (213,213,2,'NOTASmigr',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                        exit;
               END;
            END IF;
        exception
            when others then
                nuErrores := nuErrores + 1;
                PKLOG_MIGRACION.prInsLogMigra (213,213,2,'NOTASmigr',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
   END LOOP;
   COMMIT;
   -- Termina Log
   UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=pbd AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=213;
   commit;
   PKLOG_MIGRACION.prInsLogMigra (213,213,3,'NOTASmigr',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);
EXCEPTION
   WHEN OTHERS
   THEN
      PKLOG_MIGRACION.prInsLogMigra (213,213,2,'NOTASmigr',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
END NOTAS;

procedure notassurti
as   
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
   VAN NUMBER;
   vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   sbDocumento            varchar2(20) := null;
   NNOTA NUMBER;
   cursor cuNotas
       is
   SELECT /*+ parallel */ CARGCACA,ROWID,
          1 NOTANUME,
          CARGNUSE    NOTASUSC,
          CARGSIGN      CARGSIGN,
          A.CARGFECR    NOTAFECO,
          CARGCUCO      CARGCUCO,
          A.CARGFECR    NOTAFECR,
          1             NOTAUSUA,
          'MIGRA'    NOTATERM,
          70             NOTAPROG,
          'NOTA EN GASPLUS' NOTAOBSE,
          decode(a.CARGSIGN,'DB',70,71)     NOTACONS,
          NULL            NOTANUFI,
          NULL            NOTADOCU,
          NULL            NOTACONF,
          NULL            NOTAIDPR,
          CARGDOSO            NOTADOSO,
          SUBSTR(A.CARGSIGN,1,1)    NOTATINO, -- Transformar de acuerdo al valor que tenga en Gasplus
          -1               NOTAFACT,
          NULL            NOTAPREF,
          NULL            NOTACOAE,
          NULL            NOTAFEEC,
          NULL             NOTAAPMO
        FROM CARGOS a where cargcaca<>2 AND
        (CARGDOSO LIKE 'NC%' OR CARGDOSO LIKE 'ND%') AND CARGSIGN IN ('DB','CR','SA');
  -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuNotas%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
   nuLogError NUMBER;
   nuTotalRegs number := 0;
   nuErrores number := 0;
   doso varchar2(3);
BEGIN
   DELETE FROM LDC_MIG_NOTA_FACTURA;
   COMMIT;
   -- Inserta registro de inicio en el log
   UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=pbd AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=213;
   commit;
   PKLOG_MIGRACION.prInsLogMigra (213,213,1,'NOTASmigr',0,0,'Inicia Proceso','INICIO',nuLogError);
   VAN:=0;
   FOR CNOTA IN cuNotas LOOP
       DECLARE
          SUSC    NUMBER;
          FACTUR  NUMBER;
       BEGIN
            vcontLec := vcontLec +1;
            IF (CNOTA.cargcaca not in (51,2)) and (CNOTA.CARGSIGN='DB' OR CNOTA.CARGSIGN='CR' or CNOTA.CARGSIGN='SA') AND
               (SUBSTR(CNOTA.NOTADOSO,1,2)='ND' OR SUBSTR(CNOTA.NOTADOSO,1,2)='NC') THEN
               BEGIN
                    SELECT SESUSUSC INTO SUSC FROM SERVSUSC WHERE SESUNUSE=CNOTA.NOTASUSC;
                    SELECT CUCOFACT INTO FACTUR FROM CUENCOBR WHERE CUCOCODI=CNOTA.CARGCUCO;
                    BEGIN
                           SELECT NOTA INTO NNOTA FROM LDC_MIG_NOTA_FACTURA WHERE FACTURA=FACTUR;
                    EXCEPTION
                            WHEN OTHERS THEN
                              select sq_notas_notanume.nextval into nnota from dual;
                              if SUBSTR(CNOTA.NOTADOSO,1,2)='ND' then
                                 doso:='ND-';
                              ELSE
                                 DOSO:='NC-';
                              END IF;
                              INSERT INTO notas (NOTANUME,NOTASUSC,NOTAFECO,NOTAFECR,NOTAUSUA,NOTATERM,NOTAPROG,NOTAOBSE,
                                 NOTACONS,NOTANUFI,NOTADOCU,NOTACONF,NOTAIDPR,NOTADOSO,NOTATINO,NOTAFACT,
                                 NOTAPREF,NOTACOAE,NOTAFEEC,NOTAAPMO)
                                 VALUES (NNOTA,SUSC,CNOTA.NOTAFECO,CNOTA.NOTAFECR,CNOTA.NOTAUSUA,CNOTA.NOTATERM,CNOTA.NOTAPROG,
                                  CNOTA.NOTAOBSE,CNOTA.NOTACONS,NULL,NULL,NULL,NULL,DOSO||TO_CHAR(NNOTA),CNOTA.NOTATINO,
                                  FACTUR,CNOTA.NOTAPREF,CNOTA.NOTACOAE,CNOTA.NOTAFEEC,CNOTA.NOTAAPMO);
                              INSERT INTO LDC_MIG_NOTA_FACTURA VALUES(NNOTA,FACTUR);
                    END;
                    update cargos set cargtipr='P',cargprog=70,CARGDOSO=DOSO||TO_CHAR(NNOTA),cargcodo=nnota where rowid=cnota.rowid;
                    IF VAN=1000 THEN
                       COMMIT;
                       VAN:=0;
                    ELSE
                      VAN:=VAN+1;
                   END IF;
                   nuTotalRegs := nuTotalRegs + 1;
               EXCEPTION
                   WHEN OTHERS THEN
                        nuErrores := nuErrores + 1;
                        PKLOG_MIGRACION.prInsLogMigra (213,213,2,'NOTASmigr',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                        exit;
               END;
            END IF;
        exception
            when others then
                nuErrores := nuErrores + 1;
                PKLOG_MIGRACION.prInsLogMigra (213,213,2,'NOTASmigr',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
   END LOOP;
   COMMIT;
   -- Termina Log
   UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=pbd AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=213;
   commit;
   PKLOG_MIGRACION.prInsLogMigra (213,213,3,'NOTASmigr',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);
EXCEPTION
   WHEN OTHERS
   THEN
      PKLOG_MIGRACION.prInsLogMigra (213,213,2,'NOTASmigr',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
END NOTASSURTI;

BEGIN
    if pbd <>4 then
        notas;
    else
        notassurti;
        NOTASCASTMIGR;
    end if;
        
END NOTASmigr; 
/
