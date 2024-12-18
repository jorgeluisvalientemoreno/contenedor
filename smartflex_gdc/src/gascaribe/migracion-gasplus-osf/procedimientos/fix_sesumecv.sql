CREATE OR REPLACE PROCEDURE      FIX_SESUMECV(NUMINICIO number, numFinal number ,inubasedato number)
IS

CURSOR Cuservsusc
IS
SELECT sesunuse
FROM servsusc
WHERE sesuserv<>7014;

/* Pendiente de modificar */

CURSOR CuIndustriasefigas
IS
SELECT sesunuse
FROM servsusc
WHERE sesucate=3
and sesucicl in (1791, 6391,6691) ;

CURSOR CuIndustrias
IS
SELECT sesunuse
FROM servsusc
WHERE sesucate=3;

  --- Control de Errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
   
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (2000);
   vcontLec            NUMBER := 0;
   vcontIns            NUMBER := 0;
   nuErrorCode         NUMBER := NULL;
   nuContador          number := 0;
   sbErrorMessage      VARCHAR2 (2000) := NULL;
   blError             boolean := false;
   sb_sesunuse         number;
   
BEGIN
    vprograma:='FIX_SESUMECV';

    PKLOG_MIGRACION.prInsLogMigra (3601,3601,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=3601;
      
    for r in  Cuservsusc
    loop
        BEGIN
            update servsusc SET sesumecv=3  WHERE sesunuse=r.sesunuse;
            commit;
            
        EXCEPTION
        WHEN OTHERS THEN
            BEGIN
                 NUERRORES := NUERRORES + 1;
                 PKLOG_MIGRACION.prInsLogMigra ( 3601,3601,2,vprograma||vcontIns,0,0,'Segmento : '||r.sesunuse||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

            END;
        End;
    END LOOP;
    
    if   inubasedato=5 then
        for r in  CuIndustriasefigas
        loop
            BEGIN
                update servsusc SET sesumecv=4  WHERE sesunuse=r.sesunuse;
                commit;
            EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                     NUERRORES := NUERRORES + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 3601,3601,2,vprograma||vcontIns,0,0,'Segmento : '||r.sesunuse||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                END;
            End;
        END LOOP;
    ELSE


    for r in  CuIndustrias
        loop
            BEGIN
                update servsusc SET sesumecv=4  WHERE sesunuse=r.sesunuse AND sesumecv<>2;
                commit;
            EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                     NUERRORES := NUERRORES + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 3601,3601,2,vprograma||vcontIns,0,0,'Segmento : '||r.sesunuse||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                END;
            End;
        END LOOP;

    END if;

     --dbms_output.put_line('NUTOTALREGS: '||NUTOTALREGS);

    PKLOG_MIGRACION.prInsLogMigra (3601,3601,3,vprograma,0,0,'Termina Proceso','FIN',nuLogError);
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=3601;
    
EXCEPTION
     WHEN OTHERS THEN
        BEGIN
                IF (cuservsusc%ISOPEN) THEN
                    CLOSE cuservsusc;
                END IF;
                NUERRORES := NUERRORES + 1;
                PKLOG_MIGRACION.prInsLogMigra ( 3601,3601,2,vprograma||vcontIns,0,0,'Segmento : '||sb_sesunuse||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

    END;
END FIX_SESUMECV; 
/
