CREATE OR REPLACE procedure PR_COPRSUCA (NUMINICIO number, numFinal number,INUBASEDATO number) as
/*******************************************************************
 PROGRAMA    	:	DAT-GDOV-BSS-PM-V01-130228-COPRSUCA
 FECHA		    :	28/02/2013
 AUTOR		    :
 DESCRIPCION	:	Migra la informacion de los Consumos promedios
                    por SUBCATEGORIA


 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

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
       is
   select b.CATEGORY_ID CPSCCATE,
          b.SUBCATEGORY_ID CPSCSUCA,
          A.COSSTCON CPSCTCON,
          c.geograp_location_id   CPSCUBGE,
          pefaano CPSCANCO,
          pefames CPSCMECO,
          COUNT(distinct product_id) CPSCPROD,
          sum(nvl(COSSCOCA,0)) CPSCCOTO
     from conssesu a, pr_product b, ab_address c,perifact d
    WHERE COSSSESU = PRODUCT_ID
    and c.address_id = b.address_id
    and a.cossmecc in (1)
    AND a.cosspefa=pefacodi
    and b.product_type_id=7014
    GROUP BY B.CATEGORY_ID, B.SUBCATEGORY_ID,A.COSSTCON, C.geograp_location_id,d.pefaano, d.pefames;



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
    VPROGRAMA := 'COPRSUCA';
--    vprograma := 'PREDIO';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (239,239,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=239;
    commit;



   vcontIns := 1;
   VCONTLEC := 0;
   OPEN CUdATOS;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH CUdATOS
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

    NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP

		 nuReg := 1;
		 nuSuscriptor := tbl_datos(nuindice).CPSCCATE;


		 BEGIN
		          vcontLec := vcontLec + 1;

				  --sblectura := tbl_datos ( nuindice).PEFAHOMO;

		         INSERT INTO COPRSUCA (CPSCCATE, CPSCSUCA, CPSCTCON, CPSCUBGE, CPSCANCO, CPSCMECO, CPSCCONS, CPSCPROD, CPSCPRDI, CPSCCOTO)
		              VALUES (tbl_datos ( nuindice).CPSCCATE, tbl_datos ( nuindice).CPSCSUCA, tbl_datos ( nuindice).CPSCTCON,
					          tbl_datos ( nuindice).CPSCUBGE,   tbl_datos ( nuindice).CPSCANCO,  tbl_datos ( nuindice).CPSCMECO,
							  SQ_COPRSUCA_198726.NEXTVAL,  tbl_datos ( nuindice).CPSCPROD,   tbl_datos ( nuindice).CPSCCOTO/30,
							   tbl_datos ( nuindice).CPSCCOTO);

				  vcontIns := vcontIns + 1;


		   EXCEPTION
           WHEN OTHERS THEN
              BEGIN

                 NUERRORES := NUERRORES + 1;
                  PKLOG_MIGRACION.prInsLogMigra ( 239,239,2,vprograma||vcontIns,0,0,'PROMEDIO  : '||nuSuscriptor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

              END;

        END;

		 end loop;

     COMMIT;

		 EXIT WHEN CUdATOS%NOTFOUND;


   END LOOP;

    -- Cierra CURSOR.
   IF (CUdATOS%ISOPEN)
   THEN
      --{
      CLOSE CUdATOS;
   --}
   END IF;

   COMMIT;
    --- Termina log
  PKLOG_MIGRACION.PRINSLOGMIGRA ( 239,239,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
  UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=239;
  commit;

  EXCEPTION
     WHEN OTHERS THEN
        BEGIN

           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 239,239,2,vprograma||vcontIns,0,0,'PROMEDIO  : '||nuSuscriptor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

        END;

  END PR_COPRSUCA; 
/
