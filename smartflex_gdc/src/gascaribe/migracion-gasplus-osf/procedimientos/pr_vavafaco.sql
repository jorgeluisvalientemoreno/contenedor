CREATE OR REPLACE PROCEDURE      PR_VAVAFACO(Numinicio number,Numfinal number,inubasedato number) AS
 /*******************************************************************
 PROGRAMA    	:	PR_VAVAFACO_C
 FECHA		    :	27/09/2012
 AUTOR		    :
 DESCRIPCION	:	Migra la informacion de los consumos de servicios
                    suscriptos a CONSSESU

 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/

   nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
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


   -- RGCALIBRACION CUCALIBRACION%ROWTYPE;

--  se cambia cursor para corregir xiomarada

--   cursor cuLecturas
--       IS
--   SELECT DISTINCT COLESUSC, COLEPRES, BASEDATO
--     FROM LDC_TEMP_COMPLECT
--     where COLEPRES <> 0
--     order by colesusc;



cursor culecturas(nucomplemento number) is SELECT
distinct a.colenuse+nucomplemento colenuse,a.colepres colepres,a.basedato basedato
FROM ldc_temp_complect_SGE a,
(SELECT colesusc,colenuse, basedato, max(colefech)  colefech
FROM  ldc_temp_complect_SGE
GROUP BY colesusc,colenuse,basedato) b
WHERE b.colesusc= a.colesusc
AND  b.colenuse=a.colenuse
AND b.colefech = a.colefech
and a.basedato=b.basedato
AND a.basedato=inubasedato;


   CURSOR CUSERVICIO (nuServ  number, nubase number)
      IS
   SELECT locahomo, sesufein
    FROM LDC_MIG_DIRECCION A, LDC_TEMP_SERVSUSC_SGE B
   WHERE B.sesunuse = NUSERV
    AND  A.predcodi = sesupred
    AND  A.DATABASE = B.BASEDATO
    AND B.BASEDATO = NUBASE;



    RGSERVICIO  CUSERVICIO%ROWTYPE;

    -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuLecturas%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();

nuLogError NUMBER;
nuTotalRegs number := 0;
nuErrores number := 0;
maxnumber number;
sbsql varchar2(800);

BEGIN

   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (194,194,1,'PR_VAVAFACO_C',0,0,'Inicia Proceso','INICIO',nuLogError);
   UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=194;
    commit;

   vcontIns := 1;
   vcontLec := 0;
    -- SECUENCIA SQ_CM_VAVAFACO_198733
    sbsql:='DROP SEQUENCE OPEN.SQ_CM_VAVAFACO_198733';

    execute immediate sbsql;

    SELECT max(vvfccons) + 1 INTO maxnumber FROM cm_vavafaco;

    if maxnumber IS null then
        maxnumber:=1;
    END if;

    sbsql:=
        'CREATE SEQUENCE OPEN.SQ_CM_VAVAFACO_198733
         START WITH '||maxnumber||'
         MAXVALUE 9999999999999999999999999999
         MINVALUE 1
         NOCYCLE
         CACHE 20
         ORDER';

    execute immediate sbsql;

    sbsql:='GRANT SELECT ON OPEN.SQ_CM_VAVAFACO_198733 TO SYSTEM_OBJ_PRIVS_ROLE';

    execute immediate sbsql;
    pkg_constantes.COMPLEMENTO(inubasedato,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);

   OPEN cuLecturas(nucomplementopr);

   LOOP
      --
        -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;

      FETCH cuLecturas
      BULK COLLECT INTO TBL_DATOS
      LIMIT 1000;

      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP

         NUREG := 1;
         nuSuscriptor := tbl_datos(nuindice).colenuse;


         BEGIN
                  vcontLec := vcontLec + 1;

                  SBLECTURA := TBL_DATOS ( NUINDICE).colenuse;


          OPEN CUSERVICIO(TBL_DATOS ( NUINDICE).colenuse-nucomplementopr, TBL_DATOS ( NUINDICE).BASEDATO);
          FETCH CUSERVICIO INTO RGSERVICIO;
          CLOSE CUSERVICIO;




               INSERT INTO CM_VAVAFACO (VVFCCONS, VVFCVAFC, VVFCFEIV, VVFCFEFV, VVFCVALO, VVFCVAPR, VVFCUBGE, VVFCSESU)
                    VALUES(SQ_CM_VAVAFACO_198733.NEXTVAL, 'PRESION_OPERACION', RGSERVICIO.SESUFEIN, TO_DATE('31/12/32','dd/mm/yy'),
                           TBL_DATOS ( NUINDICE).COLEPRES, TBL_DATOS ( NUINDICE).COLEPRES, NULL, TBL_DATOS ( NUINDICE).colenuse);
                  COMMIT;

                  vcontIns := vcontIns + 1;


            EXCEPTION
                    WHEN OTHERS
                       THEN

                  verror := 'Error en el Producto: '||nuSuscriptor||' -  Con Lectura : '||sbLectura||' - '|| SQLERRM;

                            nuErrores := nuErrores + 1;
                  PKLOG_MIGRACION.prInsLogMigra ( 194,194,2,'PR_VAVAFACO_C',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
            END;

         end loop;

     COMMIT;

         EXIT WHEN cuLecturas%NOTFOUND;


   END LOOP;

    -- Cierra CURSOR.
   IF (cuLecturas%ISOPEN)
   THEN
      --{
      CLOSE cuLecturas;
   --}
   END IF;

  -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra ( 194,194,3,'PR_VAVAFACO_C',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);
   UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=194;
    commit;
EXCEPTION
   WHEN OTHERS
   THEN
      PKLOG_MIGRACION.prInsLogMigra ( 194,194,2,'PR_VAVAFACO_C'||vcontIns,0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);

END PR_VAVAFACO; 
/
