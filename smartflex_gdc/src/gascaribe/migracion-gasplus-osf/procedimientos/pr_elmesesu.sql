CREATE OR REPLACE procedure      PR_ELMESESU (NUMINICIO number, numFinal number ,inubasedato number)  as
/*******************************************************************
 PROGRAMA    	:
 FECHA		    :	27/09/2012
 AUTOR		    :
 DESCRIPCION	:	Migra la informacion de los medidores por suscriptor
                a ELMESESU

 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA    DESCRIPCION

 *******************************************************************/
    nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   VPROGRAMA           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
    vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   sbMedidor          varchar2(50);

   Cursor Cuelemmedi(nucomplemento number)
      is
 Select  /*+index (d IX_COMPSESU01) index (e LDC_MIG_MEDIDOR_HOMO_INDEX1) INDEX(C) */
        C.Elmeidem Emsselme,
         UPPER(c.elmecodi) emsscoem,
           trunc(e.FEChcone) EMSSFEIN,
           to_date('4731/01/01','yyyy/mm/dd')       EMSSFERE,
           d.cmssidco emsscmss,
           e.sesunuse emsssesu,
           7014       emssserv,
           e.susccodi emsssspr
     from compsesu d, elemmedi c,ge_items_seriado g,ge_items h, ldc_mig_medidor_homo e
    WHERE c.elmeidem = e.medihomo
    AND e.BASEDATO = inubasedato
    and d.cmsssesu = e.sesunuse
    and g.serie=c.ELMECODI
    and g.items_id=h.items_id
    and h.ID_ITEMS_TIPO=20   
      And D.Cmsstcom = 7039
      AND C.ELMECODI <> '-----------'
    AND E.SUSCCODI >= NUMINICIO
   and e.susccodi < Numfinal;




     -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuElemmedi%ROWTYPE;



   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();

--- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;

   

BEGIN
    VPROGRAMA := 'ELMESESU';
--    vprograma := 'PREDIO';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (178,178,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=178;
    commit;
   -- Extraer Datos
   vcont := 0;

    pkg_constantes.COMPLEMENTO(inubasedato,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);


   OPEN cuElemmedi(nucomplementopr);

   LOOP
      --
        -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;

      FETCH cuElemmedi
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

      NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP

         BEGIN
              vcontLec := vcontLec + 1;
              sbMedidor := tbl_datos ( nuindice).EMSSSESU;


             INSERT INTO ELMESESU
                  Values tbl_datos (nuindice);


          vcontIns := vcontIns + 1;


        EXCEPTION
           WHEN OTHERS THEN
              BEGIN

                 NUERRORES := NUERRORES + 1;
                  PKLOG_MIGRACION.prInsLogMigra ( 178,178,2,vprograma||vcontIns,0,0,'Medidor : '||sbMedidor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

              END;

        END;
      END LOOP;

      COMMIT;

        EXIT WHEN cuElemmedi%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuElemmedi%ISOPEN)
   THEN
      --{
      CLOSE cuElemmedi;
   --}
   End If;

  COMMIT;
    --- Termina log
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 178,178,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=178;
    commit;

  EXCEPTION
     WHEN OTHERS THEN
        BEGIN

           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 178,178,2,vprograma||vcontIns,0,0,'Medidor : '||sbMedidor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

        END;


  END PR_ELMESESU; 
/
