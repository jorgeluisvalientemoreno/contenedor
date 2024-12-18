CREATE OR REPLACE PROCEDURE PR_MIGRA_GE_ITEMS_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS 
/*******************************************************************
 PROGRAMA    	:	PR_MIGRA_GE_ITEMS_ROLLOUT
 FECHA		:	15/05/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Migra la informacion de ITEMS a GE_ITEMS	
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/

   vcontLec            NUMBER := 0;
   vcontIns            NUMBER := 0;
     
   cursor cuItems is
	SELECT 	distinct TO_NUMBER(A.ITEMCOSA)   ITEMS_ID,
		SUBSTR (A.ITEMDESC,1,100) DESCRIPTION,
		case
			when FNUEXISTE_MEDIDOR_ROLLOUT(A.ITEMCODI,A.BASEDATO) = 1 then 21
			else
			B.CLINHOMO
		end ITEM_CLASSIF_ID,
		C.UNMEHOMO MEASURE_UNIT_ID,
		NULL TECH_CARD_ITEM_ID,
		null CONCEPT,
		null OBJECT_ID,
		null USE_,
		null ELEMENT_TYPE_ID,
		null ELEMENT_CLASS_ID,
		0 STANDARD_TIME,
		0 WARRANTY_DAYS,
		null DISCOUNT_CONCEPT,
		case
			when FNUEXISTE_MEDIDOR_ROLLOUT(A.ITEMCODI,A.BASEDATO) = 1 then 20
			else
			NULL
		 end ID_ITEMS_TIPO,
		'N' OBSOLETO,
		'N' PROVISIONING_TYPE,
		null PLATFORM,
		'N' RECOVERY,
		null RECOVERY_ITEM_ID,
		1 INIT_INV_STATUS_ID,
		'N' SHARED,
		REPLACE(A.ITEMCOSA,'-','') CODE,
		 A.ITEMCODI Item
	FROM  LDC_TEMP_ITEMS_SGE A, LDC_MIG_CLASINVE B,  LDC_MIG_UNIDMEDI C
	WHERE A.ITEMUNME = C.UNMECODI
	  AND A.ITEMTIIT = B.CLASINVE
	  AND A.ITEMCOSA is not null 
	  AND isnumber(A.ITEMCOSA) = 1
	  AND NOT EXISTS (select 1 from ge_items where items_id = A.ITEMCOSA)
	  AND A.BASEDATO = nuBD;

     -- DECLARACION DE TIPOS.
    TYPE tipo_cu_datos IS TABLE OF cuItems%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
 
   nuLogError number;

BEGIN
   
   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (1001,1001,1,'MIGRA_ITEMS',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   update migr_rango_procesos set RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 1001 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

   -- Cargar Registros

   vcontIns := 1;

   OPEN cuItems;

   LOOP
     	-- Borrar tablas tbl_datos.
        tbl_datos.delete;

	  FETCH cuItems
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
	 
	 /*Se debe desactivar el trigger para poder insertar en GE_ITEMS*/
        --EXECUTE IMMEDIATE 'ALTER TRIGGER CSE.TRG_GE_ITEMS DISABLE';
						
          vcontLec := vcontLec + 1;
		      
          INSERT INTO GE_ITEMS (ITEMS_ID, DESCRIPTION, ITEM_CLASSIF_ID, MEASURE_UNIT_ID, TECH_CARD_ITEM_ID, CONCEPT, OBJECT_ID, USE_, ELEMENT_TYPE_ID,
                                ELEMENT_CLASS_ID, STANDARD_TIME, WARRANTY_DAYS, DISCOUNT_CONCEPT, ID_ITEMS_TIPO, OBSOLETO, PROVISIONING_TYPE, PLATFORM,
                                RECOVERY, RECOVERY_ITEM_ID, INIT_INV_STATUS_ID, SHARED, CODE)
              VALUES (tbl_datos ( nuindice).ITEMS_ID, tbl_datos ( nuindice).DESCRIPTION, tbl_datos ( nuindice).ITEM_CLASSIF_ID, tbl_datos ( nuindice).MEASURE_UNIT_ID,
		      tbl_datos ( nuindice).TECH_CARD_ITEM_ID, tbl_datos ( nuindice).CONCEPT, tbl_datos ( nuindice).OBJECT_ID, tbl_datos ( nuindice).USE_,
		      tbl_datos ( nuindice).ELEMENT_TYPE_ID, tbl_datos ( nuindice).ELEMENT_CLASS_ID, tbl_datos ( nuindice).STANDARD_TIME,
		      tbl_datos ( nuindice).WARRANTY_DAYS, tbl_datos ( nuindice).DISCOUNT_CONCEPT, tbl_datos ( nuindice).ID_ITEMS_TIPO,
		      tbl_datos ( nuindice).OBSOLETO, tbl_datos ( nuindice).PROVISIONING_TYPE, tbl_datos ( nuindice).PLATFORM, tbl_datos ( nuindice).RECOVERY,
		      tbl_datos ( nuindice).RECOVERY_ITEM_ID, tbl_datos ( nuindice).INIT_INV_STATUS_ID, tbl_datos ( nuindice).SHARED, tbl_datos ( nuindice).CODE);

          COMMIT;

		  vcontIns := vcontIns + 1;

      EXCEPTION
            WHEN OTHERS THEN
              
              PKLOG_MIGRACION.prInsLogMigra ( 1001,1001,2,'MIGRA_ITEMS'||vcontIns,0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);

        END;
      END LOOP;

      EXIT WHEN cuItems%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuItems%ISOPEN)
   THEN
     
      CLOSE cuItems;
   
   END IF;
     
   -- Termina Log
   PKLOG_MIGRACION.prInsLogMigra ( 1001,1001,3,'MIGRA_ITEMS'||vcontIns,0,0,'TERMINO PROCESO ','FIN',nuLogError);
   
   update migr_rango_procesos set RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 1001 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
    PKLOG_MIGRACION.prInsLogMigra ( 1001,1001,2,'MIGRA_ITEMS'||vcontIns,0,0,'Error: '||sqlerrm,to_char(SqlCode),nuLogError);

End PR_MIGRA_GE_ITEMS_ROLLOUT; 
/
