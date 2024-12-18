CREATE OR REPLACE PROCEDURE      "PERIFACTMIGR" (NUMINICIO NUMBER,NUMFINAL NUMBER,pbd number) is
 /*******************************************************************
 PROGRAMA            :    perifactmigr
 FECHA            :    16/05/2014
 AUTOR            :    VICTOR HUGO MUNIVE ROCA
 DESCRIPCION        :    LLena la tabla de perifact de OSF basado en los
                        perifact extraidos y acorde a la homologacion de
                        ciclos
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
   maxnumber           number:=0;
   i                   number;
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   Vprograma           Varchar2 (100);
   verror              VARCHAR2 (2000);
   vcont               NUMBER;
   vcontIns            NUMBER;
   pe number;
    nuErrorCode       NUMBER;
   vcontLec            NUMBER;
   SBERRORMESSAGE    VARCHAR2 (4000);
   nuSecuencia        number;
   sbsql varchar2(800);
   blPeriodoValido     boolean:= FALSE;


   Cursor cuPerifacttmp
      IS
   SELECT DISTINCT PEFACICL, PEFAANO, PEFAMES, CICLHOMO
     FROM ldc_temp_perifact_sge A, LDC_MIG_CICLO B
    WHERE A.BASEDATO = B.DATABASE
      AND A.PEFACICL = B.CODICICL
      AND A.BASEDATO = pbd
    ORDER BY PEFACICL, PEFAANO, PEFAMES, CICLHOMO;


   CURSOR CUPERIODOtmp (NUCICLO NUMBER, NUANO NUMBER, NUMES NUMBER)
      is
   Select *
     FROM ldc_temp_perifact_sge
     where basedato = pbd
      and pefacicl = nuCiclo
      and pefaano = nuAno
      AND PEFAMES = NUMES
    order by pefacodi  ;


   cursor cuPerifact       IS
          SELECT DISTINCT PEFAHOMO
                 FROM LDC_MIG_PERIFACT
                 where database = pbd
                 ORDER BY pefahomo;
   cursor cuPeriodo (nuPeriodo number) is
          SELECT C.PEFAHOMO    PEFACODI,
                 A.PEFAANO      PEFAANO,
                 a.PEFAMES     PEFAMES,
                 A.PEFASACA    PEFASACA,
                 A.PEFAFIMO     PEFAFIMO,
                 A.PEFAFFMO    PEFAFFMO,
                 a.PEFAFECO    PEFAFECO,
                 A.PEFAFEPA    PEFAFEPA,
                 a.PEFAFEPA+1   PEFAFFPA,
                 A.PEFAFEGE       PEFAFEGE,
                 '-'        PEFAOBSE,
                 B.CICLHOMO    PEFACICL,
                 A.PEFADESC    PEFADESC,
                 A.PEFAFECO    PEFAFCCO,
                 null        PEFAFGCI,
                 A.PEFAACTU    PEFAACTU,
                 NULL           PEFAFEEM,
                 C.CODICICL     CICLGASPLUS
          FROM ldc_temp_perifact_sge a,  LDC_MIG_CICLO b, LDC_MIG_PERIFACT C
          WHERE A.PEFACODI =  C.CODIPEFA
                AND A.PEFACICL  = C.CODICICL
                AND A.PEFAANO   = C.CODIANO
                AND A.PEFAMES   = C.CODIMES
                AND C.CODICICL = B.CODICICL
                and b.database = pbd
                AND C.DATABASE = pbd
                AND A.BASEDATO = pbd
                AND A.PEFACODI > -1
                AND C.PEFAHOMO = NUPERIODO
          order by a.pefacodi;
     RGPERIODO CUPERIODO%ROWTYPE;
     RGsIGUIENTE CUPERIODO%ROWTYPE;
   -- DECLARACION DE TIPOS.
     --
     TYPE tipo_cu_datos IS TABLE OF cuPerifact%ROWTYPE;
     -- DECLARACION DE TABLAS TIPOS.
     --
     tbl_datos      tipo_cu_datos := tipo_cu_datos ();
     -- DECLARACION DE TIPOS.
     --
     TYPE tipo_cu_datostmp IS TABLE OF cuPerifacttmp%ROWTYPE;
     -- DECLARACION DE TABLAS TIPOS.
     --
     tbl_datostmp      tipo_cu_datostmp := tipo_cu_datostmp ();
     --- Control de Errores
     nuLogError NUMBER;
     NUTOTALREGS NUMBER := 0;
     NUERRORES NUMBER := 0;
     -----------------------------------------------------------------------------
     --FUNCIONES Y PROCEDURES INTERNOS DEL PROCESO
     -----------------------------------------------------------------------------
     FUNCTION  fsbValidaPeriodo (nuanio number, numes number, nuciclo number, nufimo date,
               nuffmo date,periencontrado out number) return boolean IS
        CURSOR cuPeriodoExiste
        IS
            SELECT pefacodi
                FROM perifact
            WHERE   pefaano = nuanio
            AND     pefames = numes
            AND     pefacicl = nuciclo;
           -- AND     pefafimo = nufimo
           -- AND     pefaffmo = nuffmo;
        nuPefacodi number;
     BEGIN
        OPEN cuPeriodoExiste;
        FETCH cuPeriodoExiste INTO nuPefacodi ;
        CLOSE cuPeriodoExiste;
        if nuPefacodi IS not null then
            periencontrado:=nupefacodi;
            return FALSE;
        else
            return TRUE;
        END if;
     EXCEPTION
        when LOGIN_DENIED then
             pkErrors.Pop;
             raise LOGIN_DENIED;
        when pkConstante.exERROR_LEVEL2 then
             pkErrors.Pop;
             raise pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
             BEGIN
                NUERRORES := NUERRORES + 1;
                PKLOG_MIGRACION.prInsLogMigra ( 151,151,2,vprograma||vcontIns,0,0,'Periodo : '||nuErrorCode||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
             END;
     END fsbValidaPeriodo;
      procedure proActPericose(bd number) is
         cursor cuPeriodosOSF is
         select distinct pefahomo, codicicl, codiano, codimes
                from ldc_mig_perifact
                where database = bd and
                      pefahomo in (select pecscons from pericose);
         cursor cuPeriodosGASplus (nuAno number,nuCicl number, nuMes number) is
         select pefafein, pefafefi
                from ldc_temp_perifact_SGE
                where pefaano = nuAno
                      and pefacicl = nuCicl
                      and pefames = nuMes
                      and pefacodi = 1
                      and basedato = bd;
         dtFechIni date;
         dtFechFin date;
         nuLogError number;
      begin
           for rtPefaOSF in cuPeriodosOSF loop
               open cuPeriodosGASplus (rtPefaOSF.codiano,rtPefaOSF.codicicl,rtPefaOSF.codimes);
               fetch cuPeriodosGASplus into dtFechIni, dtFechFin;
               if cuPeriodosGASplus%found then
                  update pericose
                         set PECSFECI = dtFechIni,
                             PECSFECF = dtFechFin,
                             PECSFEAI = dtFechIni,
                             PECSFEAF = dtFechFin
                         where PECSCONS = rtPefaOSF.pefahomo;
                  commit;
               end if;
               close cuPeriodosGASplus;
            end loop;
      exception
            when others then
                 null;
      end proActPericose;
BEGIN
    update migr_rango_procesos set raprfein=sysdate,RAPRTERM='P' where raprcodi=149 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
    COMMIT;
    -- Borra log del proceso
    COMMIT;
    vprograma := 'perifactmigr';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (149,149,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
    -- LLENA LA TABLA DE LDC_MIG_PERIFACT
    -- Extraer Datos y cargarlos
    --nuContador := 2; --Se inicia en 2 porque el codigo 1 es un registro comodin
    OPEN cuPerifacttmp;
    LOOP
        -- Borrar tablas     tbl_datos.
        --
        tbl_datostmp.delete;
        FETCH cuPerifacttmp
        BULK COLLECT INTO tbl_datostmp
        LIMIT 1000;
        NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
        FOR nuindice IN 1 .. tbl_datostmp.COUNT LOOP
            BEGIN
                 nuSecuencia := SQ_perifact_pefacodi.NEXTVAL;
                 for rgDatostmp in cuPeriodotmp (TBL_DATOStmp (NUINDICE).PEFACICL, TBL_DATOStmp (NUINDICE).PEFAANO, TBL_DATOStmp (NUINDICE).PEFAMES) loop
                     VCONTLEC := VCONTLEC + 1;
                     BEGIN
                          SBERRORMESSAGE := rgDatostmp.PEFACODI||' - '||TBL_DATOStmp (NUINDICE).PEFACICL||' - '||TBL_DATOStmp (NUINDICE).PEFAANO||' - '||TBL_DATOStmp (NUINDICE).PEFAMES;
                          INSERT INTO LDC_MIG_PERIFACT (CODIPEFA, PEFAHOMO, CODICICL, CODIANO, CODIMES, BASEDATO, DATABASE)
                                  values (RGdATOStmp.pefacodi, nuSecuencia, tbl_datostmp (nuindice).PEFACICL, tbl_datostmp (nuindice).PEFAANO,
                        TBL_DATOStmp (NUINDICE).PEFAMES, 'BASE DATO='||TO_CHAR(PBD),pbd);
                          VCONTINS := VCONTINS + 1;
                     EXCEPTION
                          WHEN OTHERS THEN
                               BEGIN
                                   NUERRORES := NUERRORES + 1;
                                   PKLOG_MIGRACION.prInsLogMigra ( 149,149,2,vprograma||vcontIns,0,0,'Periodo : '||nuSecuencia||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                               END;
                     end;
                 END LOOP;
             EXCEPTION
           WHEN OTHERS THEN
                BEGIN
                     NUERRORES := NUERRORES + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 149,149,2,vprograma||vcontIns,0,0,'Periodo : '||nuSecuencia||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                END;
           end;
        END LOOP;
        COMMIT;
        EXIT WHEN cuPerifacttmp%NOTFOUND;
    END LOOP;
    -- Cierra CURSOR.
   IF (cuPerifactTMP%ISOPEN) THEN
      --{
      CLOSE cuPerifactTMP;
      --}
   END IF;
   -- TERMINA DE LLENAR LA TABLA LDC_MIG_PERIFACT
   -- CON BASE EN LO LLENADO EN LDC_MIG_PERIFACT AHORA LLENA LA INFORMACION EN PERIFACT
   OPEN cuPerifact;
   LOOP
      --
      -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;
      FETCH cuPerifact
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;
      NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
          BEGIN
               vcontLec := vcontLec + 1;
               nuErrorCode := NULL;
               sbErrorMessage := NULL;
               RGsIGUIENTE:=null;
               RGPERIODO:=null;
               nuErrorCode := tbl_datos (nuindice).PEFAHOMO;
               open cuPeriodo (tbl_datos (nuindice).PEFAHOMO);
               FETCH CUPERIODO INTO RGPERIODO;
               if CUPERIODO%found then
                  CLOSE CUPERIODO;
                  i:=0;
                  FOR RGDATOS IN CUPERIODO(tbl_datos (nuindice).PEFAHOMO) LOOP
                      if i>0 then
                        RGsIGUIENTE := RGDATOS;
                      END if;
                      i:=i+1;
                  END LOOP;
                  --Entra a validar si ya existe un periodo con el mismo año, mes, ciclo, fecha inicio y fecha fin.
                  blPeriodoValido := fsbValidaPeriodo(RGPERIODO.PEFAANO,RGPERIODO.PEFAMES,rgPeriodo.PEFACICL,
                                                      rgPeriodo.PEFAFIMO,RGsIGUIENTE.PEFAFFMO,pe);
                  --Insertar el periodo si es valido, es decir si no existe ya un periodo con el mismo año, mes, ciclo.
                  if blPeriodoValido then
                     INSERT INTO PERIFACT (PEFACODI, PEFAANO, PEFAMES, PEFASACA, PEFAFIMO, PEFAFFMO, PEFAFECO,
                                           PEFAFEPA, PEFAFFPA, PEFAFEGE,PEFAOBSE, PEFACICL, PEFADESC, PEFAFCCO,
                                           PEFAFGCI, PEFAACTU, PEFAFEEM)
                                   VALUES (TBL_DATOS (NUINDICE).PEFAHOMO, RGPERIODO.PEFAANO, RGPERIODO.PEFAMES,
                                           RGPERIODO.PEFASACA+nvl(RGsIGUIENTE.PEFASACA,0),trunc(rgPeriodo.PEFAFIMO), trunc(nvl(RGsIGUIENTE.PEFAFFMO,RGPERIODO.PEFAFFMO))+23.9998/24, nvl(RGsIGUIENTE.PEFAFECO,RGPERIODO.PEFAFECO),
                                           rgPeriodo.PEFAFEPA,rgPeriodo.PEFAFFPA, rgPeriodo.PEFAFEGE, rgPeriodo.PEFAOBSE,
                                           rgPeriodo.PEFACICL,nvl(RGsIGUIENTE.PEFADESC,RGPERIODO.PEFADESC), nvl(RGsIGUIENTE.PEFAFCCO,RGPERIODO.PEFAFCCO), rgPeriodo.PEFAFGCI,
                                           nvl(RGsIGUIENTE.PEFAACTU,RGPERIODO.PEFAACTU),nvl(RGsIGUIENTE.PEFAFEEM,RGPERIODO.PEFAFEEM));
                  ELSE
                     UPDATE LDC_MIG_PERIFACT SET PEFAHOMO=pe where codicicl=rgperiodo.ciclgasplus and codiano=rgperiodo.pefaano and codimes=rgperiodo.pefames;
                  END if;
                  VCONTINS := VCONTINS + 1;
               ELSE
                  CLOSE CUPERIODO;
               end if;
          EXCEPTION
               WHEN OTHERS THEN
                    BEGIN
                         NUERRORES := NUERRORES + 1;
                         PKLOG_MIGRACION.prInsLogMigra ( 149,149,2,vprograma||vcontIns,0,0,'Periodo : '||nuErrorCode||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                    END;
          END;
      END LOOP;
      vfecha_fin := SYSDATE;
      COMMIT;
      EXIT WHEN cuPerifact%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuPerifact%ISOPEN) THEN
      --{
      CLOSE cuPerifact;
      --}
   END IF;
   -- AJUSTA FECHAS DE PERIODOS DE FACTURACION DE SMARTFLEX
      -- se comenta en los rollouts mientras se define que hacer con las fechas de los periodos y se termina de homologar los ciclos
   -- PR_AJUSTA_PERIFACT_SMARTFLEX;
   -- CREA PERIODOS DE CONSUMO BASADOS EN LOS PERIODOS DE FACTURACION CREADOS
      IF pbd = 4 THEN

       INSERT INTO pericose
         SELECT pefacodi AS PECSCONS,
            pefafimo AS PECSFECI,
            pefaffmo AS PECSFECF,
            'S' AS PECSPROC,
            'MIGRACION' AS PECSUSER,
            'MIGRACION' AS PECSTERM,
            'MIGRACION' AS PECSPROG,
            pefacicl AS PECSCICO,
            'S' AS PECSFLAV,
            pefafimo AS PECSFEAI,
            pefaffmo AS PECSFEAF
            FROM PERIFACT
            WHERE PEFACODI > -1
            AND PEFACODI NOT IN (SELECT PECSCONS FROM PERICOSE )
            --and pefafimo >= ADD_MONTHS(trunc (SYSDATE, 'mm'), -24) EDWAR INDICA QUE SE HAGA EL CAMBIO 05/12/2014 3:35 PM 
            ORDER BY 2;
           -- AJUSTA LAS FECHAS DE LOS PERIODOS DE CONSUMI
           proActPericose(pbd);
           -- TERMINA PROCESO DE PERIODOS
           -- Termina Log
      END IF;

   execute immediate 'drop sequence OPEN.SQ_PERICOSE_PECSCONS';
   SELECT nvl(max(PECSCONS),0) + 2 INTO maxnumber FROM PERICOSE;
   execute immediate '
      CREATE SEQUENCE OPEN.SQ_PERICOSE_PECSCONS
      START WITH '||maxnumber||'
      MAXVALUE 9999999999999999999999999999
      MINVALUE 1
      NOCYCLE
      CACHE 20
      ORDER';

   migra.statperifact;   
   UPDATE migr_rango_procesos set raprfefi=sysdate,raprterm='T' where raprcodi=149 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
   COMMIT;
   PKLOG_MIGRACION.PRINSLOGMIGRA ( 149,149,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
   EXCEPTION
     WHEN OTHERS THEN
        BEGIN
           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 149,149,2,vprograma||vcontIns,0,0,'Periodo : '||nuSecuencia||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
  END perifactmigr; 
/
