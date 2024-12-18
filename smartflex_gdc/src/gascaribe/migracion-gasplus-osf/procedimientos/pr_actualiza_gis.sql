CREATE OR REPLACE PROCEDURE      PR_ACTUALIZA_GIS (NUMINICIO number,NUMFINAL number,INUBASEDATO NUMbeR) AS
/*******************************************************************
 PROGRAMA    	:	PRACTUALIZA_TMP_PREDIO_GIS
 FECHA            :    11/02/2013
 AUTOR            :
 DESCRIPCION    :    Actualiza la tabla de predios para el GIS

 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION

 *******************************************************************/


   vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (2000);
   vcont               NUMBER;
   vcontLec            NUMBER := 0;
   vcontIns            NUMBER := 0;
   nuCuenta            number := null;
   nuConcepto          number := null;
   nuAnterior          number := 0;
   nuValor             number := 0;

   CURSOR cu_data
      IS
      SELECT a.PREDCODI,ADDRESS_ID, b.SEGMENT_ID SEGMENTO, d.ROUTE_ID, c.Consecutive CONSECUTIVO, C.PREMISE_ID,d.block_id,e.PREDDEPA,e.PREDLOCA,e.PREDZOCA,e.PREDSECA,e.PREDMACA,e.PREDNUPR,e.PREDNUME,e.PREDCONS PREDCONS,e.BASEDATO
      FROM ldc_MIG_DIRECCION a, ab_address b, ab_premise c,ab_segments d, ldc_temp_predio_sge e
      WHERE a.predhomo=b.address_id
      AND   b.estate_number=c.premise_id
      AND   b.segment_id=d.segments_id
      AND   e.PREDCODI=a.PREDCODI
      AND   a.database=e.basedato
      AND   e.BASEDATO=INUBASEDATO;
      



   --
   TYPE tipo_cu_data IS TABLE OF cu_data%ROWTYPE;

   --
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_data := tipo_cu_data ();
   nuLogError NUMBER;

BEGIN
   -- SI APLICA, CREAR TABLA DE DATOS QUE NO SE BORRAN
   -- Abre CURSOR.
   UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=243;
    commit;
   PKLOG_MIGRACION.prInsLogMigra (243,243,1,'PR_ACTUALIZA_GIS',0,0,'Inicia Proceso','INICIO',nuLogError);
   OPEN cu_data;

   LOOP
      --
      -- Borrar tablas PL.
      --
      tbl_datos.delete;

      -- Cargar registros.
      --
      FETCH cu_data
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         Begin
             vcontLec := vcontLec + 1;
             

             update migra.gis_temp_predio_SGE
               SET PREDHOMO = Tbl_Datos (Nuindice).ADDRESS_ID,
                   PREDSEGM = Tbl_Datos (Nuindice).SEGMENTO,
                   RUTASEGM = TBL_DATOS (NUINDICE).ROUTE_ID,
                   CONSRUTA = to_number(TBL_DATOS (NUINDICE).consecutivo),
                   PREDABPR = to_number(TBL_DATOS (NUINDICE).PREMISE_ID),
                   PREDBLOQ = to_number(TBL_DATOS (NUINDICE).BLOCK_ID)
             WHERE PREDDEPA=TBL_DATOS (NUINDICE).PREDDEPA
               AND PREDLOCA=TBL_DATOS (NUINDICE).PREDLOCA
               AND PREDZOCA=TBL_DATOS (NUINDICE).PREDZOCA
               AND PREDSECA=TBL_DATOS (NUINDICE).PREDSECA
               AND PREDMACA=TBL_DATOS (NUINDICE).PREDMACA
               AND PREDNUPR=TBL_DATOS (NUINDICE).PREDNUPR
               AND PREDNUME=TBL_DATOS (NUINDICE).PREDNUME
               AND PREDCONS=TBL_DATOS (NUINDICE).PREDCONS
               AND BASEDATO =  Tbl_Datos (Nuindice).BASEDATO;

           vcontIns := vcontIns + 1;
         EXCEPTION
            WHEN OTHERS THEN
               PKLOG_MIGRACION.prInsLogMigra (243,243,2,'PR_ACTUALIZA_GIS',0,0,'Error en predio '||Tbl_Datos (Nuindice).PREDCODI||' - '||sqlerrm,to_char(sqlcode),nuLogError);
               null;

         COMMIT;
         END;
      END LOOP;

     vfecha_fin := SYSDATE;

        COMMIT;


      EXIT WHEN cu_data%NOTFOUND;

      COMMIT;
   END LOOP;



   -- Cierra CURSOR.

   IF (cu_data%ISOPEN)
   THEN
      CLOSE cu_data;
   END IF;

   -- SI APLICA, RECUPERAR DATOS QUE NO SE BORRAR DE LA TABLA CREADA PREVIAMENTE.


   vfecha_fin := SYSDATE;

    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=243;
    PKLOG_MIGRACION.prInsLogMigra (243,243,3,'PR_ACTUALIZA_GIS',0,0,'Termina Proceso','FIN',nuLogError);
    COMMIT;
EXCEPTION
   WHEN OTHERS THEN
   PKLOG_MIGRACION.prInsLogMigra (243,243,2,'PR_ACTUALIZA_GIS',0,0,'Error '||sqlerrm,to_char(sqlcode),nuLogError);
      BEGIN
         verror := SQLCODE || SQLERRM;

         INSERT INTO migrar_errmigrs
                     (erminopr, ermiidta, ermidesc, ermifech
                     )
              VALUES (vprograma, 'CUPON_C', verror, SYSDATE
                     );

         COMMIT;
      END;


eND PR_ACTUALIZA_GIS; 
/
