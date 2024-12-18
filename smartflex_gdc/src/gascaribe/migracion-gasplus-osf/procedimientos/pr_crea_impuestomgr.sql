CREATE OR REPLACE PROCEDURE "PR_CREA_IMPUESTOMGR"(ini in number,
                                                  fin in number,
                                                  PBD NUMBER) AS
  /*******************************************************************
   PROGRAMA     : pr_crea_impuestomgr
   FECHA        : 25/05/2014
   AUTOR            :    VICTOR HUGO MUNIVE ROCA
   DESCRIPCION    :    Crea los cargos de impuestos a las cuentas de cobro
   HISTORIA DE MODIFICACIONES
   AUTOR       FECHA    DESCRIPCION
  *******************************************************************/
  vfecha_ini DATE;
  vfecha_fin DATE;
  VPROGRAMA  VARCHAR2(100);
  verror     VARCHAR2(2000);
  vcont      NUMBER := 0;
  vcontLec   NUMBER := 0;
  vcontIns   NUMBER := 0;
  nuCuenta   number := null;
  nuconcepto number;
  cursor cuCuencobr(nuComplementoCU number, nuComplementoPR number) is
    Select coblconc,
           cargnuse + nucomplementopr cargnuse,
           Sum(cargiva) iva,
           cargcuco + nucomplementocu cargcuco,
           Min(cargfecr) cargfecr,
           pefahomo,
           cargsign
      From ldc_temp_cargos_sge a,
           ldc_mig_concepto g,
           (Select coblconc, coblcoba
              From concbali, concepto
             Where conccodi = coblconc
               And concticl = 4) c,
           ldc_mig_perifact d,
           ldc_temp_servsusc_sge f
     Where a.basedato = g.database
       And cargconc = codiconce
       And c.coblcoba(+) = conchomo
       And cargiva > 0
       And d.codipefa = cargpefa
       And d.codicicl = cargcicl
       And d.codiano = cargano
       And d.codimes = cargmes
       And g.database = d.database
       And g.database = pbd
       And a.cargnuse = f.sesunuse
       And f.sesususc >= ini
       And f.sesususc < fin
       And a.basedato = f.basedato
     Group By cargcuco, coblconc, cargnuse, pefahomo, cargsign;
  -- DECLARACION DE TIPOS.
  --
  TYPE tipo_cu_datos IS TABLE OF cuCuencobr%ROWTYPE;
  -- DECLARACION DE TABLAS TIPOS.
  --
  tbl_datos   tipo_cu_datos := tipo_cu_datos();
  nuLogError  NUMBER;
  nuTotalRegs number := 0;
  nuErrores   number := 0;
  IVA_NORMAL  NUMBER := 0;
  IVA_INTERE  NUMBER := 0;
  BASEDA      NUMBER;
  CC          NUMBER;
  complemento number;

  nuComplementoPR number;
  nuComplementoSU number;
  nuComplementoFA number;
  nuComplementoCU number;
  nuComplementoDI number;
BEGIN
  UPDATE migr_rango_procesos
     set raprfein = sysdate, raprterm = 'P'
   where raprcodi = 221
     and raprbase = pbd
     and raprrain = ini
     and raprrafi = fin;
  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra(221,
                                221,
                                1,
                                'PR_CREA_IMPUESTOmgr',
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                nuLogError);
  -- Cargar Registros
  pkg_constantes.COMPLEMENTO(PBD,
                             nuComplementoPR,
                             nuComplementoSU,
                             nuComplementoFA,
                             nuComplementoCU,
                             nuComplementoDI);

  OPEN cuCuencobr(nuComplementoCU, nuComplementoPR);
  LOOP
    --
    -- Borrar tablas     tbl_datos.
    --
    tbl_datos.delete;
    FETCH cuCuencobr BULK COLLECT
      INTO tbl_datos LIMIT 1000;
    FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
      BEGIN
      
        nuconcepto := tbl_datos(nuindice).coblconc;
        if nuconcepto is null then
          if pbd in (5,1,2,3,4) then
            nuconcepto := 616;
          else
            nuconcepto := 137;
          end if;
        end if;
      
        insert /*+ APPEND*/
        into cargos
          (CARGCUCO,
           CARGNUSE,
           CARGCONC,
           CARGCACA,
           CARGSIGN,
           CARGPEFA,
           CARGVALO,
           CARGDOSO,
           CARGCODO,
           CARGUSUA,
           CARGTIPR,
           CARGUNID,
           CARGFECR,
           CARGPROG,
           CARGCOLL,
           CARGPECO,
           CARGTICO,
           CARGVABL,
           CARGTACO)
        VALUES
          (tbl_datos    (nuindice).cargcuco,
           tbl_datos    (nuindice).cargnuse,
           nuconcepto,
           15,
           tbl_datos    (nuindice).cargsign,
           tbl_datos    (nuindice).pefahomo,
           tbl_datos    (nuindice).iva,
           'IVA GENERADO',
           0,
           1,
           'A',
           0,
           tbl_datos    (nuindice).cargfecr,
           161,
           NULL,
           tbl_datos    (nuindice).pefahomo,
           NULL,
           NULL,
           NULL);
        commit;
      
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            verror    := 'Error en la Cuenta de Cobro C : ' || nuCuenta ||
                         ' - ' || SQLERRM;
            nuErrores := nuErrores + 1;
            PKLOG_MIGRACION.prInsLogMigra(221,
                                          221,
                                          2,
                                          'PR_CREA_IMPUESTOmgr',
                                          0,
                                          0,
                                          'Error cargo  ' || TBL_DATOS(NUINDICE)
                                          .cargcuco || ' - ' || verror,
                                          to_char(sqlcode),
                                          nuLogError);
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
  -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra(221,
                                221,
                                3,
                                'PR_CREA_IMPUESTOmgr',
                                nuTotalRegs,
                                nuErrores,
                                'TERMINO PROCESO #regs: ' || nuTotalRegs,
                                'FIN',
                                nuLogError);
  UPDATE migr_rango_procesos
     set raprfefi = sysdate, raprterm = 'T'
   where raprcodi = 221
     and raprbase = pbd
     and raprrain = ini
     and raprrafi = fin;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    PKLOG_MIGRACION.prInsLogMigra(221,
                                  221,
                                  2,
                                  'PR_CREA_IMPUESTOmgr',
                                  0,
                                  0,
                                  'Error: ' || sqlerrm,
                                  to_char(sqlcode),
                                  nuLogError);
END PR_CREA_IMPUESTOmgr; 
/
