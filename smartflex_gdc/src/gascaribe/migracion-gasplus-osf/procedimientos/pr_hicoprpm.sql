CREATE OR REPLACE PROCEDURE      PR_HICOPRPM (NUMINICIO number, numFinal number,inubasedato number) AS
/*******************************************************************
 PROGRAMA    	:	DAT-GDO-BSS-PM-V01-130228-HICOPRPM
 FECHA		    :	28/02/2013
 AUTOR		    :
 DESCRIPCION	:	Migra la informacion de los Consumos promedios
                    por servicio suscrito


 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION

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


   cursor cuDatos(nucomplemento NUMBER, nucomplementocu number)
       is
   select /*+ parallel */ A.DCSENUSE+nucomplemento  HCPPSESU,
          1           HCPPTICO,
          A.DCSECOPR  HCPPCOPR,
          C.FACTPEFA  HCPPPECO
     from LDC_TEMP_DACOSERV_SGE a, cuencobr b, factura c
    where a.DCSENUSE + nucomplemento = B.CUCONUSE
      AND A.DCSECUCO+nucomplementocu = B.CUCOCODI
      AND B.CUCOFACT = C.FACTCODI
      and a.basedato = inubasedato;


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
    VPROGRAMA := 'HICOPRPM';
--    vprograma := 'PREDIO';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (301,301,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=301;
    commit;

   pkg_constantes.COMPLEMENTO(inubasedato,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);

   vcontIns := 1;
   vcontLec := 0;
   OPEN cuDatos(nucomplementopr,nucomplementocu);

   LOOP
      --
        -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;

      FETCH cuDatos
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

    NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP

         nuReg := 1;
         nuSuscriptor := tbl_datos(nuindice).HCPPSESU;


         BEGIN
                  vcontLec := vcontLec + 1;

                  --sblectura := tbl_datos ( nuindice).PEFAHOMO;

                 INSERT INTO HICOPRPM (HCPPSESU, HCPPTICO, HCPPCOPR, HCPPPECO, HCPPCONS)
                      VALUES (tbl_datos ( nuindice).HCPPSESU, tbl_datos ( nuindice).HCPPTICO, tbl_datos ( nuindice).HCPPCOPR,
                              tbl_datos ( nuindice).HCPPPECO, SQ_HICOPRPM_198722.NEXTVAL );



                  vcontIns := vcontIns + 1;


           EXCEPTION
           WHEN OTHERS THEN
              BEGIN

                 NUERRORES := NUERRORES + 1;
                  PKLOG_MIGRACION.prInsLogMigra ( 301,301,2,vprograma||vcontIns,0,0,'PROMEDIO  : '||nuSuscriptor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

              END;

        END;

         end loop;

        COMMIT;

         EXIT WHEN cuDatos%NOTFOUND;


   END LOOP;

    -- Cierra CURSOR.
   IF (cuDatos%ISOPEN)
   THEN
      --{
      CLOSE cuDatos;
   --}
   END IF;

   COMMIT;
    --- Termina log
  PKLOG_MIGRACION.PRINSLOGMIGRA ( 301,301,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
  UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=301;
   commit;

  EXCEPTION
     WHEN OTHERS THEN
        BEGIN

           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 301,301,2,vprograma||vcontIns,0,0,'PROMEDIO  : '||nuSuscriptor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

        END;

  END PR_HICOPRPM; 
/
