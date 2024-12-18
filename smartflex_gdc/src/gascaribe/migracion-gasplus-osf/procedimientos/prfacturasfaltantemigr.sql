CREATE OR REPLACE PROCEDURE PRFACTURASFALTANTEMIGR(numinicio number,
                                                   numfinal  number,
                                                   PBD       NUMBER) AS
  /*******************************************************************
  PROGRAMA         :   PRFACTURASFALTANTEMIGR
  FECHA        : 25/05/2014
  AUTOR        : VICTOR HUGO MUNIVE ROCA
  DESCRIPCION      : crea las facturas faltantes
  HISTORIA DE MODIFICACIONES
  AUTOR       FECHA    DESCRIPCION
  *******************************************************************/
  nuComplementoPR number;
  nuComplementoSU number;
  nuComplementoFA number;
  nuComplementoCU number;
  nuComplementoDI number;
  vfecha_ini      DATE;
  vfecha_fin      DATE;
  vprograma       VARCHAR2(100);
  Verror          Varchar2(2000);
  SBSQL           VARCHAR2(800);
  vcont           NUMBER := 0;
  vcontLec        NUMBER := 0;
  vcontIns        NUMBER := 0;
  nuFactura       number := 0;
  nf              number;

  JobNo user_jobs.job%TYPE;
  WHAT  VARCHAR2(4000);
  TABLA VARCHAR2(100);

  CURSOR cuFactura IS
    SELECT /*+ PARALLEL */
     NULL FACTCODI,
     A.CUCOSUSC FACTSUSC,
     d.PEFAHOMO FACTPEFA,
     b.DEPAHOMO FACTDEPA,
     b.COLOHOMO FACTLOCA,
     0 FACTVAAP,
     H.PEFAFIMO FACTFEGE,
     'MIGRA' FACTTERM,
     1 FACTUSUA,
     123 FACTPROG,
     114 FACTCONS,
     NULL FACTNUFI,
     NULL FACTCONF,
     NULL FACTPREF,
     NULL FACTCOAE,
     NULL FACTVCAE,
     C.SUSCIDDI FACTDICO,
     A.CUCOCODI CUENTA,
     A.CUCOCODI + NUCOMPLEMENTOCU CUENTA_OSF,
     G.CATEHOMO CUCOCATE,
     G.ESTRHOMO CUCOSUCA,
     A.CUCOVAAP CUCOVAAP,
     A.CUCOVARE CUCOVARE,
     A.CUCOVAAB CUCOVAAB,
     a.cucovato CUCOVATO,
     A.CUCOFEPA CUCOFEPA,
     A.CUCONUSE + nuCOMPLEMENTOpr CUCONUSE,
     A.CUCOSACU CUCOSACU,
     0 CUCOVRAP,
     NULL CUCOFAAG,
     H.PEFAFEPA CUCOFEVE,
     0 CUCOVAFA,
     99 CUCOSIST,
     A.CUCOINAC CUCOGRIM,
     A.CUCOVAIV CUCOIMFA,
     F.PLSUHOMO CUCOPLSU
      FROM LDC_TEMP_CUENCOBR_SGE A,
           LDC_MIG_LOCALIDAD     B,
           SUSCRIPC              C,
           LDC_MIG_PERIFACT      D,
           LDC_MIG_PLANSUSC      F,
           LDC_MIG_SUBCATEG      G,
           LDC_TEMP_PERIFACT_SGE H
     WHERE B.CODIDEPA = A.CUCODEPA
       AND B.CODILOCA = A.CUCOLOCA
       AND A.CUCOPEFA = D.CODIPEFA
       AND A.CUCOCICL = D.CODICICL
       AND A.CUCOANO = D.CODIANO
       AND A.CUCOMES = D.CODIMES
       AND A.CUCOSUSC = C.SUSCCODI - nuCOMPLEMENTOsu
       AND A.CUCOPLSU = F.CODIPLSU
       AND G.CODICATE = A.CUCOCATE
       AND G.CODISUCA = A.CUCOSUCA
       AND h.PEFACODI = A.CUCOPEFA
       AND h.PEFACICL = A.CUCOCICL
       AND h.PEFAANO = A.CUCOANO
       AND H.PEFAMES = A.CUCOMES
       AND nvl(A.CUCOFACT, -1) = -1
       AND H.BASEDATO = PBD
       and d.DATABASE = PBD
       AND A.BASEDATO = PBD
       AND F.BASEDATO = PBD;
  -- DECLARACION DE TIPOS.
  --
  TYPE tipo_cu_datos IS TABLE OF cuFactura%ROWTYPE;
  -- DECLARACION DE TABLAS TIPOS.
  --
  tbl_datos   tipo_cu_datos := tipo_cu_datos();
  nuLogError  NUMBER;
  nuTotalRegs number := 0;
  nuErrores   number := 0;
  MAXNUMBER   NUMBER;
Begin
  update migr_rango_procesos
     set raprfein = sysdate, RAPRTERM = 'P'
   where raprcodi = 269
     and raprbase = pbd
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  COMMIT;
  pkg_constantes.COMPLEMENTO(pbd,
                             nuComplementoPR,
                             nuComplementoSU,
                             nuComplementoFA,
                             nuComplementoCU,
                             nuComplementoDI);

  vprograma  := 'PRFACTURASFALTANTEMIGR';
  vfecha_ini := SYSDATE;
  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra(269,
                                269,
                                1,
                                vprograma,
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                nuLogError);
  -- Cargar Registros
  vcontLec := 0;
  vcontIns := 1;
  OPEN cuFactura;
  LOOP
    --
    -- Borrar tablas     tbl_datos.
    --
    tbl_datos.delete;
    FETCH cuFactura BULK COLLECT
      INTO TBL_DATOS LIMIT 1000;
    nuTotalRegs := nuTotalRegs + tbl_datos.COUNT;
    FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
      BEGIN
        VCONTLEC := VCONTLEC + 1;
        NUFACTURA := SQ_FACTURA_FACTCODI.NEXTVAL;
        TBL_DATOS(NUINDICE).FACTCODI := NUFACTURA;
        TBL_DATOS(NUINDICE).FACTNUFI := NUFACTURA;
        INSERT INTO FACTURA
          (FACTCODI,
           FACTSUSC,
           FACTPEFA,
           FACTDEPA,
           FACTLOCA,
           FACTVAAP,
           FACTFEGE,
           FACTTERM,
           FACTUSUA,
           FACTPROG,
           FACTCONS,
           FACTNUFI,
           FACTCONF,
           FACTPREF,
           FACTCOAE,
           FACTVCAE,
           FACTDICO)
        VALUES
          (TBL_DATOS(NUINDICE).FACTCODI,
           TBL_DATOS(NUINDICE).FACTSUSC + nuCOMPLEMENTOsu,
           TBL_DATOS(NUINDICE).FACTPEFA,
           TBL_DATOS(NUINDICE).FACTDEPA,
           TBL_DATOS(NUINDICE).FACTLOCA,
           TBL_DATOS(NUINDICE).FACTVAAP,
           TBL_DATOS(NUINDICE).FACTFEGE,
           TBL_DATOS(NUINDICE).FACTTERM,
           TBL_DATOS(NUINDICE).FACTUSUA,
           TBL_DATOS(NUINDICE).FACTPROG,
           TBL_DATOS(NUINDICE).FACTCONS,
           TBL_DATOS(NUINDICE).FACTNUFI,
           TBL_DATOS(NUINDICE).FACTCONF,
           TBL_DATOS(NUINDICE).FACTPREF,
           TBL_DATOS(NUINDICE).FACTCOAE,
           TBL_DATOS(NUINDICE).FACTVCAE,
           TBL_DATOS(NUINDICE).FACTDICO);
        INSERT INTO FACTURA_NUEVA
          (CUENCOBR_GDO, CUENCOBR_OSF, FACTURA_OSF, BASEDATO)
        VALUES
          (TBL_DATOS(NUINDICE).CUENTA,
           TBL_DATOS(NUINDICE).CUENTA_OSF,
           NUFACTURA,
           PBD);
        INSERT INTO CUENCOBR
          (CUCOCODI,
           CUCODEPA,
           CUCOLOCA,
           CUCOPLSU,
           CUCOCATE,
           CUCOSUCA,
           CUCOVAAP,
           CUCOVARE,
           CUCOVAAB,
           CUCOVATO,
           CUCOFEPA,
           CUCONUSE,
           CUCOSACU,
           CUCOVRAP,
           CUCOFACT,
           CUCOFAAG,
           CUCOFEVE,
           CUCOVAFA,
           CUCOSIST,
           cucoimfa,
           cucodiin)
        VALUES
          (TBL_DATOS(NUINDICE).CUENTA_OSF,
           TBL_DATOS(NUINDICE).FACTDEPA,
           TBL_DATOS(NUINDICE).FACTLOCA,
           TBL_DATOS(NUINDICE).CUCOPLSU,
           TBL_DATOS(NUINDICE).CUCOCATE,
           TBL_DATOS(NUINDICE) . CUCOSUCA,
           TBL_DATOS(NUINDICE).CUCOVAAP,
           TBL_DATOS(NUINDICE).CUCOVARE,
           TBL_DATOS(NUINDICE).CUCOVAAB,
           TBL_DATOS(NUINDICE).CUCOVATO,
           TBL_DATOS(NUINDICE).CUCOFEPA,
           TBL_DATOS(NUINDICE).CUCONUSE,
           TBL_DATOS(NUINDICE).CUCOSACU,
           TBL_DATOS(NUINDICE).CUCOVRAP,
           nufactura,
           TBL_DATOS(NUINDICE).CUCOFAAG,
           TBL_DATOS(NUINDICE).CUCOFEVE,
           TBL_DATOS(NUINDICE).CUCOVAFA,
           TBL_DATOS(NUINDICE).CUCOSIST,
           0,
           TBL_DATOS(NUINDICE).FACTDICO);
        insert into ldc_homo_cuencobr
        values
          (tbl_datos(nuindice).cuenta, tbl_datos(nuindice).cuenta_osf, PBD);
        commit;
        vcontIns := vcontIns + 1;
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            nuErrores := nuErrores + 1;
            PKLOG_MIGRACION.prInsLogMigra(269,
                                          269,
                                          2,
                                          vprograma || vcontIns,
                                          0,
                                          0,
                                          'Error en cuenta ' ||
                                           TBL_DATOS(NUINDICE)
                                          .CUENTA_OSF || ' - ' || sqlerrm,
                                          to_char(sqlcode),
                                          nuLogError);
          END;
      END;
    END LOOP;
    COMMIT;
    EXIT WHEN cuFactura%NOTFOUND;
  END LOOP;
  -- Cierra CURSOR.
  IF (cuFactura%ISOPEN) THEN
    --{
    CLOSE cuFactura;
    --}
  END IF;

  if PBD in (1, 4, 5) then
    ---GENERA ESTADISTICA A FACTURA
    tablA := 'FACTURA';
    WHAT  := 'BEGIN PKG_CONSTANTES.PRGeneEsTAiN(' || CHR(39) || tablA ||
             CHR(39) || '); END;';
    DBMS_JOB.SUBMIT(JobNo, WHAT, SYSDATE);
    COMMIT;
  end if;
  ---GENERA ESTADISTICA A CUENCOBR
  tablA := 'CUENCOBR';
  WHAT  := 'BEGIN PKG_CONSTANTES.PRGeneEsTAiN(' || CHR(39) || tablA ||
           CHR(39) || '); END;';
  DBMS_JOB.SUBMIT(JobNo, WHAT, SYSDATE);
  COMMIT;

  -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra(269,
                                269,
                                3,
                                vprograma,
                                nuTotalRegs,
                                nuErrores,
                                'TERMINO PROCESO #regs: ' || vcontIns,
                                'FIN',
                                nuLogError);
  UPDATE migr_rango_procesos
     set raprfefi = sysdate, raprterm = 'T'
   where raprcodi = 269
     and raprbase = pbd
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  commit;
EXCEPTION
  WHEN OTHERS THEN
    nuErrores := nuErrores + 1;
    PKLOG_MIGRACION.prInsLogMigra(269,
                                  269,
                                  2,
                                  vprograma || vcontIns,
                                  0,
                                  0,
                                  'Error: ' || sqlerrm,
                                  to_char(sqlcode),
                                  nuLogError);
END PRFACTURASFALTANTEMIGR; 
/
