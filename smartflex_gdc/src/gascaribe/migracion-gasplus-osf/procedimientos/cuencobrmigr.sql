CREATE OR REPLACE PROCEDURE      "CUENCOBRMIGR" (NUMINICIO number, numFinal number,pbd number ) AS
 /*******************************************************************
 PROGRAMA            :    CUENCOBRmigr
 FECHA            :    16/05/2014
 AUTOR            :    VICTOR HUGO MUNIVE ROCA
 DESCRIPCION        :    Migra la informacion de las cuentas de cobro de servicios
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
 vcont               NUMBER := 0;
 vcontLec            NUMBER := 0;
 vcontIns            NUMBER := 0;
 nuCuenta            number := null;
 nufactura           number :=0;
   cursor cuCuencobr
       is
   SELECT  /*+ parallel */
           a.CUCOCODI+nucomplementocu    CUCOCODI,
           b.DEPAHOMO   CUCODEPA,
           B.COLOHOMO   CUCOLOCA,
           E.PLSUHOMO   CUCOPLSU,
           G.CATEHOMO   CUCOCATE,
           G.ESTRHOMO   CUCOSUCA,
           A.CUCOVAAP   CUCOVAAP,
           A.CUCOVARE   CUCOVARE,
           a.CUCOVAAB   CUCOVAAB,
           A.CUCOVATO   CUCOVATO,
           A.CUCOFEPA   CUCOFEPA,
           A.CUCONUSE+nucomplementopr   CUCONUSE,
           A.CUCOSACU   CUCOSACU,
           0            CUCOVRAP,
           a.cucofact+nucomplementofa   CUCOFACT,
           NULL         CUCOFAAG,
           H.PEFAFEPA   CUCOFEVE,
           A.CUCOVAFA   CUCOVAFA,
           99           CUCOSIST,
           A.CUCOINAC   CUCOGRIM,
           A.CUCOVAIV   CUCOIMFA,
           k.susciddi   CUCODIIN,
           k.susccodi   SUSCCODI
        FROM LDC_TEMP_CUENCOBR_sge A, LDC_TEMP_PERIFACT_sge H, LDC_MIG_LOCALIDAD B,
             LDC_MIG_PLANSUSC E,  LDC_MIG_SUBCATEG G, suscripc k
        where A.Cucosusc     >= Numinicio
              and a.CUCOSUSC <  NUMFINAL
              AND A.CUCOPLSU = E.CODIPLSU
              AND g.codicate = A.CUCOCATE
              AND g.codisuca = A.CUCOSUCA
              and b.CODIDEPA = a.cucodepa
              and b.CODILOCA = a.cucoloca
              AND h.PEFACODI = A.CUCOPEFA
              AND h.PEFACICL = A.CUCOCICL
              AND h.PEFAANO = A.CUCOANO
              AND H.PEFAMES = A.CUCOMES
              AND H.BASEDATO = pbd
              AND E.BASEDATO = pbd
              and a.basedato = pbd
              and a.cucofact <> -1
              and k.susccodi = a.cucosusc+nucomplementosu;
   -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuCuencobr%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
   -- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
BEGIN
    update migr_rango_procesos set raprfein=sysdate,RAPRTERM='P' where raprcodi=207 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
    COMMIT;
    pkg_constantes.COMPLEMENTO(pbd,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);   
 
   VPROGRAMA := 'CUENCOBRmigr';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (207,207,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
    -- Cargar Registros
    OPEN cuCuencobr;
    lOOP
        --
        -- Borrar tablas     tbl_datos.
        --
        tbl_datos.delete;
        FETCH cuCuencobr
        BULK COLLECT INTO tbl_datos
        LIMIT 1000;
        NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
        FOR nuindice IN 1 .. tbl_datos.COUNT
        LOOP
            BEGIN
                 vcontLec := vcontLec + 1;
                 nuCuenta:= tbl_datos(nuindice).CUCOCODI;
                 nufactura:=null;
                 
                 if tbl_datos(nuindice).CUCOFACT IS null then
                      SELECT open.sq_factura_factcodi.NEXTVAL INTO nufactura FROM DUAL;
                      INSERT INTO factura_nueva VALUES ( tbl_datos ( nuindice).CUCOCODI-nucomplementocu,tbl_datos ( nuindice).CUCOCODI, nufactura,pbd);
                      INSERT INTO factura VALUES (nufactura, tbl_datos ( nuindice).SUSCCODI,-1,-1,-1,-1,SYSDATE,'MIGRA-CREADA',-1,123,66,-1,NULL,NULL,NULL,NULL,1);

                      INSERT /*+ APPEND*/ INTO CUENCOBR
                      VALUES (tbl_datos ( nuindice).cucocodi,tbl_datos ( nuindice).CUCODEPA,tbl_datos ( nuindice).CUCOLOCA,tbl_datos ( nuindice).CUCOPLSU,tbl_datos ( nuindice).CUCOCATE,tbl_datos ( nuindice).CUCOSUCA,tbl_datos ( nuindice).CUCOVAAP, tbl_datos ( nuindice).CUCOVARE, tbl_datos ( nuindice).CUCOVAAB,tbl_datos ( nuindice).CUCOVATO, tbl_datos ( nuindice).CUCOFEPA,tbl_datos ( nuindice).CUCONUSE,tbl_datos ( nuindice).CUCOSACU,tbl_datos ( nuindice).CUCOVRAP,NUFACTURA,tbl_datos ( nuindice).CUCOFAAG,tbl_datos ( nuindice).CUCOFEVE,tbl_datos ( nuindice).CUCOVAFA,tbl_datos ( nuindice).CUCOSIST,tbl_datos ( nuindice).CUCOGRIM, tbl_datos ( nuindice).CUCOIMFA,tbl_datos ( nuindice).CUCODIIN);
                 ELSE
                 
                     INSERT /*+ APPEND*/ INTO CUENCOBR
                     VALUES (tbl_datos ( nuindice).cucocodi,tbl_datos ( nuindice).CUCODEPA,tbl_datos ( nuindice).CUCOLOCA,tbl_datos ( nuindice).CUCOPLSU,tbl_datos ( nuindice).CUCOCATE,tbl_datos ( nuindice).CUCOSUCA,tbl_datos ( nuindice).CUCOVAAP, tbl_datos ( nuindice).CUCOVARE, tbl_datos ( nuindice).CUCOVAAB,tbl_datos ( nuindice).CUCOVATO, tbl_datos ( nuindice).CUCOFEPA,tbl_datos ( nuindice).CUCONUSE,tbl_datos ( nuindice).CUCOSACU,tbl_datos ( nuindice).CUCOVRAP,tbl_datos ( nuindice).CUCOFACT,tbl_datos ( nuindice).CUCOFAAG,tbl_datos ( nuindice).CUCOFEVE,tbl_datos ( nuindice).CUCOVAFA,tbl_datos ( nuindice).CUCOSIST,tbl_datos ( nuindice).CUCOGRIM, tbl_datos ( nuindice).CUCOIMFA,tbl_datos ( nuindice).CUCODIIN);

                 END if;


                 INSERT INTO LDC_HOMO_CUENCOBR (CUCOGASPLUS,CUCOOSF,BASEDATO)
                        VALUES(tbl_datos(nuindice).CUCOCODI,tbl_datos(nuindice).CUCOCODI,pbd);
                 VCONTINS := VCONTINS + 1;

            EXCEPTION
                     WHEN OTHERS THEN
                          BEGIN
                               NUERRORES := NUERRORES + 1;
                               PKLOG_MIGRACION.prInsLogMigra ( 207,207,2,vprograma||vcontIns,0,0,'Cuenta de Cobro  : '||nuCuenta||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                          END;
            END;
        END LOOP;
        commit;
        EXIT WHEN cuCuencobr%NOTFOUND;
     END LOOP;
    -- Cierra CURSOR.
    IF (cuCuencobr%ISOPEN) THEN
       --{
       CLOSE cuCuencobr;
       --}
    END IF;
    COMMIT;
    --- Termina log
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 207,207,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
      UPDATE migr_rango_procesos set raprfefi=sysdate,raprterm='T' where raprcodi=207 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
    COMMIT;
    EXCEPTION
             WHEN OTHERS THEN
                  BEGIN
                       NUERRORES := NUERRORES + 1;
                       PKLOG_MIGRACION.prInsLogMigra ( 207,207,2,vprograma||vcontIns,0,0,'Cuenta de Cobro   : '||nuCuenta||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                  END;
  END CUENCOBRmigr; 
/
