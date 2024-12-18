CREATE OR REPLACE PROCEDURE      FIX_TIPOCLIE
IS

CURSOR Cucliente
IS

SELECT distinct suscclie, sesucate
FROM suscripc, servsusc
WHERE susccodi=sesususc
and suscclie <>-1;

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
   sb_suscclie         number;

BEGIN
    vprograma:='FIX_TIPOCLIE';

    PKLOG_MIGRACION.prInsLogMigra (3602,3602,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);

    for r in  Cucliente
    loop
        BEGIN
            sb_suscclie:= r.suscclie;
            update ge_subscriber SET ident_type_id=decode(r.sesucate,1,1,110) , subscriber_type_id=decode(r.sesucate,1,1,2,1,12,1106,1107)  WHERE subscriber_id=r.suscclie and subscriber_type_id <>1106;
            commit;
        EXCEPTION
        WHEN OTHERS THEN
            BEGIN
                 NUERRORES := NUERRORES + 1;
                 PKLOG_MIGRACION.prInsLogMigra ( 3602,3602,2,vprograma||vcontIns,0,0,'Cliente : '||sb_suscclie||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

            END;
        End;
    END LOOP;

 --dbms_output.put_line('NUTOTALREGS: '||NUTOTALREGS);

    PKLOG_MIGRACION.prInsLogMigra (3602,3602,3,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);

EXCEPTION
     WHEN OTHERS THEN
        BEGIN
                IF (cuCLIENTE%ISOPEN) THEN
                    CLOSE cuCLIENTE;
                END IF;
                NUERRORES := NUERRORES + 1;
                PKLOG_MIGRACION.prInsLogMigra ( 3602,3602,2,vprograma||vcontIns,0,0,'Cliente : '||sb_suscclie||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

    END;
END FIX_TIPOCLIE;
/
