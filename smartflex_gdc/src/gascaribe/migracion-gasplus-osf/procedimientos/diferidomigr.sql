CREATE OR REPLACE PROCEDURE "DIFERIDOMIGR"(NUMINICIO number,
                                           numFinal  number,
                                           pbd       number) AS
  /*******************************************************************
  PROGRAMA        :    DIFERIDOmigr
  FECHA            :    21/05/2014
  AUTOR            :    VICTOR HUGO MUNIVE ROCA
  DESCRIPCION    :    Migra la informacion de los Diferidos a DIFERIDO
  HISTORIA DE MODIFICACIONES
  AUTOR       FECHA    DESCRIPCION
  *******************************************************************/
  nuComplementoPR number;
  nuComplementoSU number;
  nuComplementoFA number;
  nuComplementoCU number;
  nuComplementoDI number;
  VFECHA_INI      DATE;
  vfecha_fin      DATE;
  vprograma       VARCHAR2(100);
  verror          VARCHAR2(4000);
  vcont           NUMBER;
  vcontLec        NUMBER := 0;
  vcontIns        NUMBER := 0;
  nuCuenta        number := null;

  cursor cuDiferido is
    SELECT /*+ index (a IDXDIFERIDO01_SGE) */ 
           a.DIFECODI + nuComplementoDI DIFECODI,
           a.DIFESUSC + nuComplementoSU DIFESUSC,
           H.CONCHOMO DIFECONC,
           a.DIFEVATD DIFEVATD,
           a.DIFEVACU DIFEVACU,
           a.DIFECUPA DIFECUPA,
           a.DIFENUCU DIFENUCU,
           a.DIFESAPE DIFESAPE,
           nvl(A.DIFENUDO, 'MIGRADO') DIFENUDO,
           100 * (POWER((1 + a.DIFEINTE / 100), 12) - 1) DIFEINTE,
           a.DIFEINAC DIFEINAC,
           a.DIFEUSUA DIFEUSUA,
           nvl(a.DIFETERM, 'MIGRA') DIFETERM,
           a.DIFESIGN DIFESIGN,
           a.DIFENUSE + nuComplementoPR DIFENUSE,
           C.TAISHOMO DIFEMECA,
           I.CONCCOIN DIFECOIN,
           nvl(a.DIFEPROG, 'MIGR') DIFEPROG,
           A.DIFEPLDI DIFEPLDI,
           nvl(a.DIFEFecr, a.difefein) DIFEFEIN,
           A.DIFEFUMO DIFEFUMO,
           0 DIFESPRE,
           nvl(a.DIFETAIN, 2) DIFETAIN,
           0 DIFEFAGR,
           a.DIFENUSE + nuComplementoPR DIFECOFI,
           'D' DIFETIRE,
           case
             when pbd = 4 then
              5079
             when pbd = 1 then
              5315
             when pbd = 2 then
              5315
             when pbd = 3 then
              5315
             else
              1
           end DIFEFUNC,
           NULL DIFELURE,
           null DIFEENRE
      FROM LDC_TEMP_DIFERIDO_sge a,
           LDC_MIG_MECADIFE      C,
           LDC_MIG_CONCEPTO      H,
           CONCEPTO              I,
           suscripc              j
     WHERE A.BASEDATO = pbd
       AND A.DIFEMECA = C.CODITAIS
       and a.DIFECONC = H.CODICONCE
       AND H.DATABASE = pbd
       AND H.CONCHOMO = I.CONCCODI
       AND A.DIFESUSC >= NUMINICIO
       and a.DIFESUSC < NUMFINAL
       and j.susccodi = a.difesusc + nuComplementoSU
       AND NOT EXISTS
     (SELECT 1
              FROM DIFERIDO V
             WHERE V.DIFECODI = A.DIFECODI + nuComplementoDI);
  -- DECLARACION DE TIPOS.
  --
  TYPE tipo_cu_datos IS TABLE OF cuDiferido%ROWTYPE;
  -- DECLARACION DE TABLAS TIPOS.
  --
  tbl_datos tipo_cu_datos := tipo_cu_datos();
  --- Control de errores
  nuLogError  NUMBER;
  NUTOTALREGS NUMBER := 0;
  NUERRORES   NUMBER := 0;
BEGIN
  UPDATE migr_rango_procesos
     set raprfeIN = sysdate, raprterm = 'P'
   where raprcodi = 209
     and raprbase = pbd
     and raprrain = NUMINICIO
     and raprrafi = NUMFINAL;
  commit;
  pkg_constantes.COMPLEMENTO(pbd,
                             nuComplementoPR,
                             nuComplementoSU,
                             nuComplementoFA,
                             nuComplementoCU,
                             nuComplementoDI);

  VPROGRAMA  := 'DIFERIDOmigr';
  vfecha_ini := SYSDATE;
  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra(209,
                                209,
                                1,
                                vprograma,
                                0,
                                0,
                                'Inicia Proceso ' || 'Basedato ' || pbd,
                                'INICIO',
                                nuLogError);
  OPEN cuDiferido;
  LOOP
    --
    -- Borrar tablas     tbl_datos.
    --
    tbl_datos.delete;
    FETCH cuDiferido BULK COLLECT
      INTO tbl_datos LIMIT 1000;
    NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
    FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
      BEGIN
        vcontLec := vcontLec + 1;
        nuCuenta := tbl_datos(nuindice).DIFECODI;
        INSERT INTO Diferido VALUES tbl_datos (nuindice);
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra(209,
                                          209,
                                          2,
                                          vprograma || vcontIns,
                                          0,
                                          0,
                                          'Basedato=' || pbd ||
                                          ' Diferido : ' || nuCuenta ||
                                          ' - Error: ' || sqlerrm,
                                          to_char(sqlcode),
                                          nuLogError);
          END;
      END;
    END LOOP;
    EXIT WHEN cuDiferido%NOTFOUND;
  END LOOP;
  -- Cierra CURSOR.
  IF (cuDiferido%ISOPEN) THEN
    --{
    CLOSE cuDiferido;
    --}
  END IF;
  UPDATE migr_rango_procesos
     set raprfeFI = sysdate, raprterm = 'T'
   where raprcodi = 209
     and raprbase = pbd
     and raprrain = NUMINICIO
     and raprrafi = NUMFINAL;
  COMMIT;
  --- Termina log
  PKLOG_MIGRACION.PRINSLOGMIGRA(209,
                                209,
                                3,
                                VPROGRAMA,
                                NUTOTALREGS,
                                NUERRORES,
                                'Basedato ' || pbd ||
                                ' TERMINO PROCESO #regs: ' || VCONTINS,
                                'FIN',
                                NULOGERROR);
EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      NUERRORES := NUERRORES + 1;
      PKLOG_MIGRACION.prInsLogMigra(209,
                                    209,
                                    2,
                                    vprograma || vcontIns,
                                    0,
                                    0,
                                    'Basedato=' || pbd || ' Diferido : ' ||
                                    nuCuenta || ' - Error: ' || sqlerrm,
                                    to_char(sqlcode),
                                    nuLogError);
    END;
END DIFERIDOmigr; 
/
