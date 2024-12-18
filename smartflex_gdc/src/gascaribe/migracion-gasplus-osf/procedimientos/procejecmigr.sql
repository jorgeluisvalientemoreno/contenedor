CREATE OR REPLACE PROCEDURE      "PROCEJECMIGR" (INI NUMBER, FIN NUMBER, PBD NUMBER) AS
/*******************************************************************
 PROGRAMA            :    PRocejecmigr
 FECHA            :    04/06/2014
 AUTOR            :    VICTOR HUGO MUNIVE ROCA
 DESCRIPCION        :    Migra la informacion de los Periodos de facturación y los incluye en
                la tabla PROCEJEC
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
   nuREg               NUMBER := 0;
   vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   nuSuscriptor        number := 0;
   sbLectura           VARCHAR2(30) := null;
   cursor cuDatos
       IS
   SELECT PEFACODI    PREJCOPE,
          'FCRI'      PREJPROG,
          PEFAFFMO    PREJFECH,
          'MIGRACION' PREJUSUA,
          'MIGRACION' PREJTERM,
          -1          PREJINAD,
          CASE
          WHEN PEFAACTU = 'N' THEN
          'T'
          ELSE
           'E'
          END PREJESPR,
          null        PREJSEEJ,
          NULL        PREJPRID,
          null         PREJIDPR,
          null        PREJPRPR
     FROM PERIFACT
     WHERE PEFAACTU = 'N';
    -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuDatos%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
--- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
PROCEDURE FIX_PROCEJEC 
AS
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
   nuREg               NUMBER := 0;
   vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   nuSuscriptor        number := 0;
   sbLectura           VARCHAR2(30) := null;
   cursor cuDatos
       IS
   SELECT PEFACODI    PREJCOPE,
          'FCRI'      PREJPROG,
          PEFAFFMO    PREJFECH,
          'MIGRACION' PREJUSUA,
          'MIGRACION' PREJTERM,
          -1          PREJINAD,
          'T' PREJESPR,
          null        PREJSEEJ,
          NULL        PREJPRID,
          null         PREJIDPR,
          1        PREJPRPR
     FROM PERIFACT
     WHERE  not exists (select 'y' FROM procejec WHERE pefacodi = prejcope);
    cursor cuFCRI
       IS
     SELECT *
    FROM procejec
    WHERE prejprog = 'FCRI'
    and prejfech > sysdate;
    -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuDatos%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
--- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
BEGIN
    VPROGRAMA := 'FIX_PROCEJEC';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (276,276,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
   vcontIns := 1;
   vcontLec := 0;
   OPEN cuDatos;
   LOOP
      --
        -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;
      FETCH cuDatos
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;
     NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         nuReg := 1;
         nuSuscriptor := tbl_datos(nuindice).PREJCOPE;
         BEGIN
                  vcontLec := vcontLec + 1;
                  --sblectura := tbl_datos ( nuindice).PEFAHOMO;
             tbl_datos ( nuindice).PREJIDPR := SQ_PROCEJEC_PREJIDPR.nextval;
                 INSERT INTO PROCEJEC
                      VALUES tbl_datos ( nuindice);
                  vcontIns := vcontIns + 1;
            EXCEPTION
           WHEN OTHERS THEN
              BEGIN
                 NUERRORES := NUERRORES + 1;
                  PKLOG_MIGRACION.prInsLogMigra ( 276,276,2,vprograma||vcontIns,0,0,'Periodo  : '||nuSuscriptor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
              END;
        END;
         end loop;
     COMMIT;
         EXIT WHEN cuDatos%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuDatos%ISOPEN)
   THEN
      --{
      CLOSE cuDatos;
   --}
   END IF;
    commit;
   for r in cuFCRI
   loop
         update  procejec SET PREJESPR='E' WHERE prejcope=r.prejcope;
         commit;
   END loop;
    --- Termina log
  PKLOG_MIGRACION.PRINSLOGMIGRA ( 276,276,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
  EXCEPTION
     WHEN OTHERS THEN
        BEGIN
           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 276,276,2,vprograma||vcontIns,0,0,'Periodo  : '||nuSuscriptor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
END FIX_PROCEJEC;
BEGIN
    update migr_rango_procesos set raprterm='P',raprfein=sysdate where raprcodi=276 and raprbase=pbd and raprrain=ini and raprrafi=fin;
    VPROGRAMA := 'PROCEJEC';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (1021,1021,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
   vcontIns := 1;
   vcontLec := 0;
   OPEN cuDatos;
   LOOP
      --
        -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;
      FETCH cuDatos
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;
      NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
      nuReg := 1;
          nuSuscriptor := tbl_datos(nuindice).PREJCOPE;
          BEGIN
               vcontLec := vcontLec + 1;
               --sblectura := tbl_datos ( nuindice).PEFAHOMO;
               tbl_datos ( nuindice).PREJIDPR := SQ_PROCEJEC_PREJIDPR.nextval;
               INSERT INTO PROCEJEC VALUES tbl_datos ( nuindice);
               vcontIns := vcontIns + 1;
          EXCEPTION
               WHEN OTHERS THEN
                    BEGIN
                         NUERRORES := NUERRORES + 1;
                         PKLOG_MIGRACION.prInsLogMigra ( 1021,1021,2,vprograma||vcontIns,0,0,'Periodo  : '||nuSuscriptor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                    END;
          END;
       end loop;
       COMMIT;
       EXIT WHEN cuDatos%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
    IF (cuDatos%ISOPEN)
       THEN
       --{
       CLOSE cuDatos;
       --}
    END IF;
    COMMIT;
    FIX_PROCEJEC;
    update migr_rango_procesos set raprterm='T',raprfeFI=sysdate where raprcodi=276 and raprbase=pbd and raprrain=ini and raprrafi=fin;
    COMMIT;
    --- Termina log
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 1021,1021,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
    EXCEPTION
        WHEN OTHERS THEN
             BEGIN
                  NUERRORES := NUERRORES + 1;
                  PKLOG_MIGRACION.prInsLogMigra ( 1021,1021,2,vprograma||vcontIns,0,0,'Periodo  : '||nuSuscriptor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
    END;
END PRocejeCmigr; 
/
