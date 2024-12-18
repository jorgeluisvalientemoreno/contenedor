CREATE OR REPLACE PROCEDURE PR_OR_ROUTE(inubasedato number)
AS
 /*******************************************************************
 PROGRAMA    	:	DAT-GDO-OSS-PM-V01-130211-OR_ROUTE
 FECHA		    :	11/02/2013
 AUTOR		    :
 DESCRIPCION	:	Migra la informacion de las rutas y sus predios

 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/

PROCEDURE  PR_OR_ROUTE_E(inubasedato number)
as
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
   vcontLec            NUMBER := 0;
   vcontIns            NUMBER := 0;
   sbMedidor           varchar2(30);
   nuruta              number := 0;
   nuciclogdo          number := 0;
   nuciclopredio       number := 0;

   cursor cuPredio
      is
    select distinct B.CICLHOMO||(SUBSTR(a.PREDRUTL,1,3)) RUTA,B.CICLHOMO CICLO
     from 	ldc_temp_predio_SGE a, ldc_mig_ciclo b
	where a.basedato = inubasedato
  and a.predcicl = b.codicicl
   and b.database = inubasedato;

   cursor cuCiclo (nuCiclo number)
      is
    select ciclhomo
      from ldc_mig_ciclo
     where codicicl = nuCiclo
   and basedato = inubasedato;

  cursor cuZona (nuCiclo number) is
  select zona_osf
  from ldc_mig_zonas
  where ciclo_osf = nuCiclo;

  nuZona number;
  nuSeqIdZona number;

     -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuPredio%ROWTYPE;

  -- rtRuta  cuRuta%rowtype;


   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();

    --- Control de Errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;

   sbsql varchar2(2000);

BEGIN
   vprograma := 'OR_ROUTE';
   vfecha_ini := SYSDATE;

   -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (141,141,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);

   -- Cargar Registros

   vcontIns := 1;

   OPEN cuPredio;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuPredio
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

    NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
          vcontlec := vcontlec + 1;

         nuruta := tbl_datos ( nuindice).ruta;

          INSERT INTO OR_ROUTE (ROUTE_ID, NAME, SHAPE, DEDICATED_ROUTE)
              VALUES (nuruta, 'RUTA : '||nuruta, NULL, 'N');

          -- Se asocia la zona a la ruta creada
          open cuZona (tbl_datos ( nuindice).ciclo);
          fetch cuZona into nuZona;
          if cuZona%found then

             nuSeqIdZona := SEQ_OR_ROUTE_ZONE_136259.nextval;

             INSERT INTO OR_ROUTE_ZONE (ROUTE_ZONE_ID,OPERATING_ZONE_ID,ROUTE_ID)
               VALUES (nuSeqIdZona,nuZona,nuruta);

          end if;
          close cuZona;

		  vcontins := vcontins + 1;

		  vfecha_fin := SYSDATE;


      EXCEPTION
         WHEN OTHERS THEN
            BEGIN

               NUERRORES := NUERRORES + 1;
               PKLOG_MIGRACION.prInsLogMigra ( 141,141,2,vprograma||vcontIns,0,0,'Ruta : '||nuruta||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

            END;

        END;
      END LOOP;

	    COMMIT;
      EXIT WHEN cuPredio%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuPredio%ISOPEN)
   THEN
      --{
      CLOSE cuPredio;
   --}
   END IF;

    -- Termina Log
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 141,141,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);

EXCEPTION
 WHEN OTHERS THEN
    BEGIN

       NUERRORES := NUERRORES + 1;
       PKLOG_MIGRACION.prInsLogMigra ( 141,141,2,vprograma||vcontIns,0,0,'Ruta : '||nuruta||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

    END;



END PR_OR_ROUTE_E;
---------------------------------------------------------------------------------


PROCEDURE  PR_OR_ROUTE_G(inubasedato number)
as
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
   vcontLec            NUMBER := 0;
   vcontIns            NUMBER := 0;
   sbMedidor           varchar2(30);
   nuruta              number := 0;
   nuciclogdo          number := 0;
   nuciclopredio       number := 0;

   cursor cuPredio
      is
    select distinct B.CICLHOMO||c.codihomo RUTA,B.CICLHOMO CICLO
     from 	ldc_temp_predio_SGE a, ldc_mig_ciclo b, ldc_mig_sectoper c
	where a.basedato = b.database
    and a.predcicl = b.codicicl
    AND a.predseop=c.codisect
    AND a.preddepa=c.codidepa
    AND a.predloca=c.codiloca
    and b.database = inubasedato;

   cursor cuCiclo (nuCiclo number)
      is
    select ciclhomo
      from ldc_mig_ciclo
     where codicicl = nuCiclo
   and basedato = inubasedato;

  cursor cuZona (nuCiclo number) is
  select zona_osf
  from ldc_mig_zonas
  where ciclo_osf = nuCiclo;

  nuZona number;
  nuSeqIdZona number;

     -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuPredio%ROWTYPE;

  -- rtRuta  cuRuta%rowtype;


   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();

    --- Control de Errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;

   sbsql varchar2(2000);

BEGIN

   COMMIT;
   -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (141,141,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);

   -- Cargar Registros

   vcontIns := 1;

   OPEN cuPredio;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuPredio
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

    NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
          vcontlec := vcontlec + 1;

         nuruta := tbl_datos ( nuindice).ruta;

          INSERT INTO OR_ROUTE (ROUTE_ID, NAME, SHAPE, DEDICATED_ROUTE)
              VALUES (nuruta, 'RUTA : '||nuruta, NULL, 'N');

          -- Se asocia la zona a la ruta creada
          open cuZona (tbl_datos ( nuindice).ciclo);
          fetch cuZona into nuZona;
          if cuZona%found then

             nuSeqIdZona := SEQ_OR_ROUTE_ZONE_136259.nextval;

             INSERT INTO OR_ROUTE_ZONE (ROUTE_ZONE_ID,OPERATING_ZONE_ID,ROUTE_ID)
               VALUES (nuSeqIdZona,nuZona,nuruta);

          end if;
          close cuZona;

		  vcontins := vcontins + 1;

		  vfecha_fin := SYSDATE;


      EXCEPTION
         WHEN OTHERS THEN
            BEGIN

               NUERRORES := NUERRORES + 1;
               PKLOG_MIGRACION.prInsLogMigra ( 141,141,2,vprograma||vcontIns,0,0,'Ruta : '||nuruta||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

            END;

        END;
      END LOOP;

	    COMMIT;
      EXIT WHEN cuPredio%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuPredio%ISOPEN)
   THEN
      --{
      CLOSE cuPredio;
   --}
   END IF;

    -- Termina Log
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 141,141,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);

EXCEPTION
 WHEN OTHERS THEN
    BEGIN

       NUERRORES := NUERRORES + 1;
       PKLOG_MIGRACION.prInsLogMigra ( 141,141,2,vprograma||vcontIns,0,0,'Ruta : '||nuruta||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

    END;



END PR_OR_ROUTE_G;

BEGIN

    if inubasedato=5 then
         PR_OR_ROUTE_E(inubasedato);
    else
        if  inubasedato in (1,2,3) then
         PR_OR_ROUTE_G(inubasedato);
        Else
            if inubasedato=4 then
         PR_OR_ROUTE_G(inubasedato);
            END if;
        END if;
    END if;

END; 
/
