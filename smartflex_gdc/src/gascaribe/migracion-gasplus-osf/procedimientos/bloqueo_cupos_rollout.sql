CREATE OR REPLACE PROCEDURE BLOQUEO_CUPOS_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	BLOQUEO_CUPOS_ROLLOUT
 FECHA		:	01/09/2014
 AUTOR		:	OLSoftware Jennifer Giraldo
 DESCRIPCION	:	Migra la informacion de los bloqueos de cupo a la tabla LD_QUOTA_BLOCK

 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/

   vfecha_ini       DATE;
   vprograma        VARCHAR2 (100);
   nuREg            NUMBER := 0;
   vcontLec         NUMBER := 0;
   vcontIns         NUMBER := 0;
   nuSUSCRIPTOR     NUMBER := 0;
   nuQUOTA          NUMBER := 0;
   nuComplementoPR  NUMBER;
   nuComplementoSU  NUMBER;
   nuComplementoFA  NUMBER;
   nuComplementoCU  NUMBER;
   nuComplementoDI  NUMBER;

   CURSOR cuBlock IS
     SELECT A.BFSUSUSC+nuComplementoSU SUBSCRIPTION_ID,
            A.BFSUFECH REGISTER_DATE,
            A.BFSUOBSE OBSERVATION
     FROM MIGRA.LDC_TEMP_BLFISUSC_SGE A, SUSCRIPC B
    WHERE A.BFSUESTA = 'S'
      AND A.BFSUSUSC >= nuInicio
      AND A.BFSUSUSC <  nuFinal
      AND A.BFSUSUSC+nuComplementoSU = B.SUSCCODI
      AND A.BASEDATO = nuBD;

	-- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuBlock%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();

   --- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;

BEGIN
   vprograma := 'BLOQUEO_CUPOS_ROLLOUT';
   vfecha_ini := SYSDATE;
   
    PKLOG_MIGRACION.prInsLogMigra (507,507,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
    
    UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 507 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
    COMMIT;
   
   PKG_CONSTANTES.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);

   vcontIns := 0;
   vcontLec := 0;
   
   OPEN cuBlock;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuBlock
	      BULK COLLECT INTO tbl_datos
	      LIMIT 1000;

		NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
		LOOP

		 nuReg := 1;
		 nuSUSCRIPTOR := TBL_DATOS(NUINDICE).SUBSCRIPTION_ID;

		 BEGIN
		          vcontLec := vcontLec + 1;
			
			nuQUOTA := SEQ_LD_QUOTA_BLOCK.NEXTVAL;

		        INSERT INTO LD_QUOTA_BLOCK (QUOTA_BLOCK_ID,BLOCK,SUBSCRIPTION_ID,CAUSAL_ID,REGISTER_DATE,OBSERVATION,USERNAME,TERMINAL)
		              VALUES (nuQUOTA, 'Y', TBL_DATOS(NUINDICE).SUBSCRIPTION_ID, 129,
			      TBL_DATOS(NUINDICE).REGISTER_DATE, TBL_DATOS(NUINDICE).OBSERVATION, 'MIGRACION', 'MIGRACION');

				  vcontIns := vcontIns + 1;
				  
		    EXCEPTION
		WHEN OTHERS THEN
                BEGIN
                   NUERRORES := NUERRORES + 1;
                    PKLOG_MIGRACION.prInsLogMigra (507,507,2,vprograma||vcontIns,0,0,'SUSCRIPTOR: '||nuSUSCRIPTOR||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                END;

          END;

		 END LOOP;

		 COMMIT;

		 EXIT WHEN cuBlock%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuBlock%ISOPEN)
   THEN
      --{
      CLOSE cuBlock;
   --}
   END IF;

  commit;
     --- Termina log
  PKLOG_MIGRACION.PRINSLOGMIGRA (507,507,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
  
  UPDATE MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 507 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
  COMMIT;

  EXCEPTION
     WHEN OTHERS THEN
        BEGIN

           NUERRORES := NUERRORES + 1;
			PKLOG_MIGRACION.prInsLogMigra (507,507,2,vprograma||vcontIns,0,0,' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;

END BLOQUEO_CUPOS_ROLLOUT; 
/
