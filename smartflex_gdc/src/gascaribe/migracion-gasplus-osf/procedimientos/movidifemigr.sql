CREATE OR REPLACE PROCEDURE      "MOVIDIFEMIGR" (NUMINICIO number, numFinal number,pbd number ) AS
  /*******************************************************************
 PROGRAMA    	    :	MOVIDIFEmigr
 FECHA		    :	21/05/2014
 AUTOR		    :	VICTOR HUGO MUNIVE ROCA
 DESCRIPCION	    :	Migra la informacion de los movimiento de Diferidos a MOVIDIFE
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
   sbDocumento         varchar2(20) := null;

   nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
   cursor cuMovidife
       Is
   SELECT /*+ parallel */
          a.MODIDIFE+nuComplementoDI    MODIDIFE,
          a.MODISUSC+nuComplementoSU    MODISUSC,
          a.MODISIGN                    MODISIGN,
          a.MODIFECH                    MODIFECH,
          a.MODIFECH                    MODIFECA,
          a.MODICUAP                    MODICUAP,
          a.MODIVACU                    MODIVACU,
      CASE
             WHEN a.MODIDOSO IS NOT NULL AND length(a.MODIDOSO)<=14 THEN
                  A.MODIDOSO
             WHEN a.MODIDOSO IS NOT NULL AND length(a.MODIDOSO)>14 THEN
                  SUBSTR(a.MODIDOSO, length(a.MODIDOSO)-14,14)
             ELSE '-1'
          END                           MODIDOSO,
          C.CACAHOMO                    MODICACA,
          'MIGRA'                       MODIUSUA,
          'MIGRA'                       MODITERM,
          'MIGRACION'                   MODIPROG,
          b.DIFENUSE+nuComplementoPR    MODINUSE,
          0                             MODIDIIN,
          b.DIFEinte                    MODIPOIN,
          0                             MODIVAIN,
          null                          MODICODO
          FROM LDC_TEMP_MOVIDIFE_sge a, LDC_TEMP_DIFERIDO_sge b,  LDC_MIG_CAUSCARG C
          where A.MODISUSC >= NUMINICIO AND
                A.MODISUSC < NUMFINAL and
                a.MODIDIFE = B.DIFECODI AND
                A.BASEDATO = pbd AND
                A.MODICACA = C.CODICACA and
                B.BASEDATO = pbd
                AND NOT EXISTS (SELECT 1 FROM MOVIDIFE V WHERE V.MODIDIFE=B.DIFECODI+nuComplementoDI and v.modivacu=a.modivacu and v.modisign=a.modisign) ;
   -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuMovidife%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
--- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
BEGIN

    pkg_constantes.COMPLEMENTO(pbd,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
    UPDATE migr_rango_procesos set raprfeIN=sysdate,raprterm='P' where raprcodi=212 and raprbase=pbd and raprrain=NUMINICIO and raprrafi=NUMFINAL;

    VPROGRAMA := 'MOVIDIFEmigr';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (212,212,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
   -- Cargar datos
   OPEN cuMovidife;
   LOOP
       --
       -- Borrar tablas     tbl_datos.
       --
       tbl_datos.delete;
       FETCH cuMovidife
       BULK COLLECT INTO TBL_DATOS
       LIMIT 1000;
       NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
       FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
           BEGIN
                vcontLec := vcontLec +1;
                sbDocumento := tbl_datos (nuindice).MODIDIFE;
                INSERT INTO MOVIDIFE VALUES tbl_datos ( nuindice);
                vcontIns := vcontIns +1;
           EXCEPTION
                WHEN OTHERS THEN
                     BEGIN
                          NUERRORES := NUERRORES + 1;
                          PKLOG_MIGRACION.prInsLogMigra ( 212,212,2,vprograma||vcontIns,0,0,'Diferido  : '||sbDocumento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                     END;
           END;
       END LOOP;
       COMMIT;
       EXIT WHEN cuMovidife%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuMovidife%ISOPEN) THEN
      --{
      CLOSE cuMovidife;
      --}
   END IF;
   
   UPDATE migr_rango_procesos set raprfeFI=sysdate,raprterm='T' where raprcodi=212 and raprbase=pbd and raprrain=NUMINICIO and raprrafi=NUMFINAL;
   COMMIT;
    --- Termina log
   PKLOG_MIGRACION.PRINSLOGMIGRA ( 212,212,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
  EXCEPTION
     WHEN OTHERS THEN
        BEGIN
           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 212,212,2,vprograma||vcontIns,0,0,'Diferido  : '||sbDocumento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
  END MOVIDIFEmigr; 
/
