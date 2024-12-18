
  CREATE OR REPLACE PROCEDURE "OPEN"."ASIGNA_CUPO_ROLLOUT" (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	ASIGNA_CUPO_ROLLOUT
 FECHA		:	01/09/2014
 AUTOR		:	OLSoftware Jennifer Giraldo
 DESCRIPCION	:	Migra la informacion de asignacion manual de cupo a la tabla LD_MANUAL_QUOTA

 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/

   vfecha_ini       DATE;
   vprograma        VARCHAR2 (100);
   nuREg            NUMBER := 0;
   vcontLec         NUMBER := 0;
   vcontIns         NUMBER := 0;
   nuSUSCRIPTOR     NUMBER := 0;
   nuMANUAL         NUMBER := 0;
   nuComplementoPR  NUMBER;
   nuComplementoSU  NUMBER;
   nuComplementoFA  NUMBER;
   nuComplementoCU  NUMBER;
   nuComplementoDI  NUMBER;

   CURSOR cuAsig IS
    SELECT A.AFSUSUSC+nuComplementoSU SUBSCRIPTION_ID,
           A.AFSUVACU QUOTA_VALUE,
	         A.AFSUFCIN INITIAL_DATE,
           A.AFSUFCFI FINAL_DATE,
           CASE
             WHEN A.AFSUOBSE IS NULL THEN 'NO TIENE DATO EN GASPLUS'
             ELSE SUBSTR (A.AFSUOBSE,1,200)
           END OBSERVATION,
           A.AFSUIMPR PRINT_IN_BILL
     FROM MIGRA.LDC_TEMP_ASFISUSC_SGE A, SUSCRIPC B
    WHERE A.AFSUSUSC >= nuInicio
      AND A.AFSUSUSC <  nuFinal
      AND A.AFSUSUSC+nuComplementoSU = B.SUSCCODI
      AND A.BASEDATO = nuBD;

	-- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuAsig%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();

   --- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;

BEGIN
   vprograma := 'ASIGNA_CUPO_ROLLOUT';
   vfecha_ini := SYSDATE;
   
    PKLOG_MIGRACION.prInsLogMigra (508,508,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
    
    UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 508 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
    COMMIT;
   
   PKG_CONSTANTES.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);

   vcontIns := 0;
   vcontLec := 0;
   
   OPEN cuAsig;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuAsig
	      BULK COLLECT INTO tbl_datos
	      LIMIT 1000;

		NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
		LOOP

		 nuReg := 1;
		 nuSUSCRIPTOR := TBL_DATOS(NUINDICE).SUBSCRIPTION_ID;

		 BEGIN
		          vcontLec := vcontLec + 1;
			
			nuMANUAL := SEQ_LD_MANUAL_QUOTA.NEXTVAL;

		        INSERT INTO LD_MANUAL_QUOTA (MANUAL_QUOTA_ID,SUBSCRIPTION_ID,QUOTA_VALUE,INITIAL_DATE,FINAL_DATE,OBSERVATION,PRINT_IN_BILL,SUPPORT_FILE)
		              VALUES (nuMANUAL, TBL_DATOS(NUINDICE).SUBSCRIPTION_ID, TBL_DATOS(NUINDICE).QUOTA_VALUE, TBL_DATOS(NUINDICE).INITIAL_DATE,
			              TBL_DATOS(NUINDICE).FINAL_DATE, TBL_DATOS(NUINDICE).OBSERVATION, TBL_DATOS(NUINDICE).PRINT_IN_BILL, NULL);

				  vcontIns := vcontIns + 1;
				  
		    EXCEPTION
		WHEN OTHERS THEN
                BEGIN
                   NUERRORES := NUERRORES + 1;
                    PKLOG_MIGRACION.prInsLogMigra (508,508,2,vprograma||vcontIns,0,0,'SUSCRIPTOR: '||nuSUSCRIPTOR||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                END;

          END;

		 END LOOP;

		 COMMIT;

		 EXIT WHEN cuAsig%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuAsig%ISOPEN)
   THEN
      --{
      CLOSE cuAsig;
   --}
   END IF;

  commit;
     --- Termina log
  PKLOG_MIGRACION.PRINSLOGMIGRA (508,508,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
  
  UPDATE MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 508 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
  COMMIT;

  EXCEPTION
     WHEN OTHERS THEN
        BEGIN
           NUERRORES := NUERRORES + 1;
			PKLOG_MIGRACION.prInsLogMigra (508,508,2,vprograma||vcontIns,0,0,' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;

END ASIGNA_CUPO_ROLLOUT; 
/
