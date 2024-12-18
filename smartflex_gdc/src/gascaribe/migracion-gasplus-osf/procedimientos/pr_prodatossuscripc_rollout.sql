CREATE OR REPLACE procedure PR_PRODATOSSUSCRIPC_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_PRODATOSSUSCRIPC_ROLLOUT
 FECHA		:	25/08/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Migra la información referente a la ley 1581 a la tabla LDC_PROTECCION_DATOS
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/

   vfecha_ini          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (2000);
   vcontLec            NUMBER := 0;
   vcontIns            NUMBER := 0;
   nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
   
	   cursor cuSuscripc is
	    SELECT /*+ parallel */ DISTINCT
		    B.SUBSCRIBER_ID,
	            B.SUBSCRIBER_NAME,
	            B.SUBS_LAST_NAME,
	            B.IDENTIFICATION,
	            A.suscnomb,
	            A.suscnice,
	            A.SUSCAUIN,
	            A.SUSCFEAU
	       FROM LDC_TEMP_SUSCRIPC_SGE A, GE_SUBSCRIBER B, SUSCRIPC C
	      WHERE C.SUSCCLIE =  B.SUBSCRIBER_ID
		AND B.IDENTIFICATION = NVL(A.SUSCNICE,-1)
		AND B.SUBSCRIBER_NAME = A.SUSCNOMB
		AND B.SUBS_LAST_NAME = A.SUSCAPEL
		AND A.BASEDATO = nuBD;
        
	-- DECLARACION DE TIPOS.
	--
	TYPE tipo_cu_datos IS TABLE OF cuSuscripc%ROWTYPE;
     
        -- DECLARACION DE TABLAS TIPOS.
	--
        tbl_datos      tipo_cu_datos := tipo_cu_datos ();

	     nuLogError NUMBER;
	     nuErrores number := 0;
     
BEGIN
   vprograma := 'PR_PRODATOSSUSCRIPC_ROLLOUT';
   vfecha_ini := SYSDATE;
      
   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (506,506,1,'PR_PRODATOSSUSCRIPC_ROLLOUT',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS set RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 506 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;
   
   PKG_CONSTANTES.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
   
   -- Cargar datos

   OPEN cuSuscripc;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	FETCH cuSuscripc
	BULK COLLECT INTO tbl_datos
	LIMIT 10000;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
          LOOP
	        BEGIN
			  vcontLec := vcontLec +1;

				INSERT INTO LDC_PROTECCION_DATOS(ID_CLIENTE,COD_ESTADO_LEY,ESTADO,FECHA_CREACION,USUARIO_CREACION,PACKAGE_ID)
				     VALUES(tbl_datos(NUINDICE).subscriber_id,tbl_datos(NUINDICE).SUSCAUIN,'S',tbl_datos(NUINDICE).SUSCFEAU,'MIGRACION',4); 
				COMMIT;

		COMMIT;
	     
	        END;
	
          END LOOP;
	  
	  
      EXIT WHEN cuSuscripc%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuSuscripc%ISOPEN)
   THEN
      --{
      CLOSE cuSuscripc;
   --}
   END IF;
   
   -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra (506,506,3,'PR_PRODATOSSUSCRIPC_ROLLOUT',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);

  UPDATE MIGR_RANGO_PROCESOS  set RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 506 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra (506,506,2,'PR_PRODATOSSUSCRIPC_ROLLOUT',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
      
END PR_PRODATOSSUSCRIPC_ROLLOUT; 
/
