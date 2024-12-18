CREATE OR REPLACE PROCEDURE PR_CERTITERCE_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_CERTITERCE_ROLLOUT
 FECHA		:	22/10/2014
 AUTOR		:	OLSoftware Jennifer Giraldo
 DESCRIPCION	:	Migra la informacion de las certificaciones de terceros a la tabla LDC_CERTIFICADOS_OIA
 
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/

   vfecha_ini       DATE;
   vprograma        VARCHAR2 (100);
   nuREg            NUMBER := 0;
   vcontLec         NUMBER := 0;
   vcontIns         NUMBER := 0;
   nuSUSCRIPTOR     NUMBER := 0;
   nuCERT          NUMBER := 0;
   nuComplementoPR  NUMBER;
   nuComplementoSU  NUMBER;
   nuComplementoFA  NUMBER;
   nuComplementoCU  NUMBER;
   nuComplementoDI  NUMBER;

   CURSOR cuCertTerc IS
     SELECT /*+ parallel */
              B.SESUNUSE+nuComplementoPR PRODUCTO,
              B.SESUSUSC+nuComplementoSU CONTRATO,
              B.SESUFERE FECHA,
              SUBSTR ((A.ORTROBSE),1,2000) OBSERVACION
       FROM MIGRA.LDC_TEMP_ORDEPRP_SGE A, LDC_MIG_PARATIPO H, LDC_TEMP_SERVSUSC_SGE B
      WHERE B.SESUSUSC >= nuInicio
        AND B.SESUSUSC < nuFinal
        AND B.BASEDATO = nuBD  
        AND A.ORTRNUSE = B.SESUNUSE
        AND A.BASEDATO = B.BASEDATO
        AND A.ORTRTITR = H.PARATITA
        AND H.PARACODI = 'CERTIFICACIONES_TERCEROS';

	-- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuCertTerc%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();

   --- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;

BEGIN
   vprograma := 'PR_CERTITERCE_ROLLOUT';
   vfecha_ini := SYSDATE;
   
    PKLOG_MIGRACION.prInsLogMigra (236,236,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
    
    UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' WHERE RAPRCODI = 236 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
    COMMIT;
   
   PKG_CONSTANTES.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);

   vcontIns := 0;
   vcontLec := 0;
   
   OPEN cuCertTerc;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuCertTerc
	      BULK COLLECT INTO tbl_datos
	      LIMIT 1000;

		NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
		LOOP

		 nuReg := 1;
		 nuSUSCRIPTOR := TBL_DATOS(NUINDICE).CONTRATO;

		 BEGIN
		          vcontLec := vcontLec + 1;
			
			     nuCERT := SEQ_LDC_CERTIFICADOS_OIA.NEXTVAL;

		        INSERT INTO LDC_CERTIFICADOS_OIA (TIPO_INSPECCION,STATUS_CERTIFICADO,RESULTADO_INSPECCION,RED_INDIVIDUAL,PACKAGE_ID,OBSER_RECHAZO,
                                              ID_PRODUCTO,ID_ORGANISMO_OIA,ID_INSPECTOR,ID_CONTRATO,FECHA_REGISTRO,FECHA_INSPECCION,
                                              CERTIFICADOS_OIA_ID,CERTIFICADO)
		                                  VALUES (1,'A',1,'Y',NULL,NULL,TBL_DATOS(NUINDICE).PRODUCTO,NULL,NULL,TBL_DATOS(NUINDICE).CONTRATO,SYSDATE,
							  TBL_DATOS(NUINDICE).FECHA,nuCERT,TBL_DATOS(NUINDICE).OBSERVACION);

				  vcontIns := vcontIns + 1;
				  
		    EXCEPTION
		WHEN OTHERS THEN
                BEGIN
                   NUERRORES := NUERRORES + 1;
                    PKLOG_MIGRACION.prInsLogMigra (236,236,2,vprograma||vcontIns,0,0,'SUSCRIPTOR: '||nuSUSCRIPTOR||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                END;

          END;

		 END LOOP;

		 COMMIT;

		 EXIT WHEN cuCertTerc%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuCertTerc%ISOPEN)
   THEN
      --{
      CLOSE cuCertTerc;
   --}
   END IF;

  commit;
     --- Termina log
  PKLOG_MIGRACION.PRINSLOGMIGRA (236,236,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
  
  UPDATE MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 236 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
  COMMIT;

  EXCEPTION
     WHEN OTHERS THEN
        BEGIN

           NUERRORES := NUERRORES + 1;
			PKLOG_MIGRACION.prInsLogMigra (236,236,2,vprograma||vcontIns,0,0,' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;

END PR_CERTITERCE_ROLLOUT; 
/
