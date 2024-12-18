CREATE OR REPLACE PROCEDURE PR_LECTELME1(NUMINICIO   number,
                                             numFinal    number,
                                             inudatabase number) AS

  /*******************************************************************
  PROGRAMA      :  LECTELME_C
  FECHA        :  27/09/2012
  AUTOR            :
  DESCRIPCION    :    Migra la informacion de LECTURA

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
  verror          VARCHAR2(4000);
  vcont           NUMBER;
  nuREg           NUMBER := 0;
  vcontLec        NUMBER := 0;
  vcontIns        NUMBER := 0;
  nuSuscriptor    number := 0;
  sbLectura       VARCHAR2(30) := null;

  cursor cuLecturas(nucomplemento number) IS
    SELECT /*+ PARALLEL*/
     lectcale cale,
     lectano ano,
     lectmes mes,
     d.EMSSELME LEEMELME,
     1 LEEMTCON,
     B.PEFAHOMO LEEMPEFA,
     F.OBLEHOMO LEEMOBLE,
     A.LECTANTE,
     A.LECTFEAN,
     A.LECTLECT LEEMLETO,
     A.LECTFECH LEEMFELE,
     1 Leemfame,
     null LEEMDOCU,
     A.LECTNUSE + nucomplemento LEEMSESU,
     D.EMSSCMSS LEEMCMSS,
     'S' LEEMFLCO,
     NULL LEEMCONS,
     b.PEFAHOMO LEEMPECS,
     1 LEEMPETL,
     CASE
       WHEN A.LECTCALE = 1 THEN
        'I'
       WHEN A.LECTCALE = 5 THEN
        'T'--TRABAJO
       WHEN A.LECTCALE = 7 THEN
        'R'
       WHEN A.LECTCALE = 8 THEN
        'I'
       WHEN A.LECTCALE = 11 THEN
        'T'
       WHEN A.LECTCALE = 14 THEN
        'I'
       WHEN A.LECTCALE = 16 THEN
        'T'
        --------------------------------
        WHEN A.LECTCALE = 18 AND A.BASEDATO IN (1,2,3) THEN
        'T'
	 WHEN A.LECTCALE = 8 AND A.BASEDATO IN (1,2,3) THEN
        'F'
        WHEN A.LECTCALE = 19 AND A.BASEDATO IN (1,2,3) THEN
        'T'
        WHEN A.LECTCALE = 21 AND A.BASEDATO IN (1,2,3) THEN
        'T'
         WHEN A.LECTCALE = 22 AND A.BASEDATO IN (1,2,3) THEN
        'T'
         WHEN A.LECTCALE = 24 AND A.BASEDATO IN (1,2,3) THEN
        'T'
        ----------------------------
       ELSE
        'F'
     END LEEMCLEC,
     -1 LEEMOBSB,
     -1 LEEMOBSC

      FROM LDC_TEMP_LECTURA_SGE A,
           ELMESESU             D,
           LDC_MIG_PERIFACT     B,
           LDC_MIG_OBSELECT     F
     WHERE lectsusc = 2064710
     AND LECTCALE = 5
  
       AND A.BASEDATO = B.DATABASE
       AND a.LECTPEFA = b.CODIPEFA
       and a.LECTCICL = b.CODICICL
       and a.LECTANO = b.CODIANO
       and a.LECTMES = b.CODIMES
       and d.EMSSSESU = a.Lectnuse + nucomplemento
       AND UPPER(A.LECTMEDI(+)) = D.EMSSCOEM
       AND B.DATABASE = inudatabase
       AND A.LECTOBLE = F.OBLECODI(+);
  -- AND A.LECTNUSE NOT IN (SELECT LEEMSESU FROM LECTELME WHERE LEEMSESU < 1000000);

  cursor cuobservacion(nuoblecodi number) is
    select oblecanl from obselect where oblecodi = nuoblecodi;

  sboblecanl Varchar(1);
  -- DECLARACION DE TIPOS.
  --
  TYPE tipo_cu_datos IS TABLE OF cuLecturas%ROWTYPE;

  -- DECLARACION DE TABLAS TIPOS.
  --
  tbl_datos tipo_cu_datos := tipo_cu_datos();

  nuLogError  NUMBER;
  nuTotalRegs number := 0;
  nuErrores   number := 0;
  nl          number;

BEGIN

  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra(197,
                                197,
                                1,
                                'PR_LECTELME_C',
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                nuLogError);
  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'P', RAPRFEIN = sysdate
   WHERE raprbase = inudatabase
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 197;
  commit;
  commit;

  vcontIns := 1;
  vcontLec := 0;
  pkg_constantes.COMPLEMENTO(inudatabase,
                             nuComplementoPR,
                             nuComplementoSU,
                             nuComplementoFA,
                             nuComplementoCU,
                             nuComplementoDI);

  OPEN cuLecturas(nucomplementoPR);

  LOOP
    --
    -- Borrar tablas     tbl_datos.
    --
    tbl_datos.delete;

    FETCH cuLecturas BULK COLLECT
      INTO tbl_datos LIMIT 1000;

    FOR nuindice IN 1 .. tbl_datos.COUNT LOOP

      nuReg        := 1;
      nuSuscriptor := tbl_datos(nuindice).LEEMELME;

      BEGIN
        vcontLec  := vcontLec + 1;
        sblectura := tbl_datos(nuindice).LEEMELME;
        nl        := 0;

        if nl = 0 then

          open cuobservacion(tbl_datos(nuindice).LEEMOBLE);
          fetch cuobservacion
            into sboblecanl;
          close cuobservacion;

          if (tbl_datos(nuindice).LEEMLETO = 0 and sboblecanl = 'S') then
            tbl_datos(nuindice).LEEMLETO := null;
          end if;

          INSERT INTO LECTELME
            (LEEMELME,
             LEEMTCON,
             LEEMPEFA,
             LEEMOBLE,
             LEEMLEAN,
             LEEMFELA,
             LEEMLETO,
             LEEMFELE,
             LEEMFAME,
             LEEMDOCU,
             LEEMSESU,
             LEEMCMSS,
             LEEMFLCO,
             LEEMCONS,
             LEEMPECS,
             LEEMPETL,
             LEEMCLEC,
             LEEMOBSB,
             LEEMOBSC)
          VALUES
            (tbl_datos(nuindice).LEEMELME,
             tbl_datos(nuindice).LEEMTCON,
             tbl_datos(nuindice).LEEMPEFA,
             tbl_datos(nuindice).LEEMOBLE,
             tbl_datos(nuindice).LECTANTE,
             tbl_datos(nuindice).LECTFEAN,
             tbl_datos(nuindice).LEEMLETO,
             tbl_datos(nuindice).LEEMFELE,
             tbl_datos(nuindice).LEEMFAME,
             tbl_datos(nuindice).LEEMDOCU,
             tbl_datos(nuindice).LEEMSESU,
             tbl_datos(nuindice).LEEMCMSS,
             tbl_datos(nuindice).LEEMFLCO,
             SQ_LECTELME_LEEMCONS.NEXTVAL,
             tbl_datos(nuindice).LEEMPECS,
             tbl_datos(nuindice).LEEMPETL,
             tbl_datos(nuindice).LEEMCLEC,
             tbl_datos(nuindice).LEEMOBSB,
             tbl_datos(nuindice).LEEMOBSC);
          COMMIT;
        end if;

        vcontIns := vcontIns + 1;

      EXCEPTION
        WHEN OTHERS THEN
          Begin
            verror := 'Error en la Lectura C : ' || nuSuscriptor || ' - ' ||
                      SQLERRM;

            nuErrores := nuErrores + 1;
            PKLOG_MIGRACION.prInsLogMigra(197,
                                          197,
                                          2,
                                          'PR_LECTELME_C',
                                          0,
                                          0,
                                          'Error: ' || verror,
                                          to_char(sqlcode),
                                          nuLogError);
          END;
      END;

    end loop;

    COMMIT;

    EXIT WHEN cuLecturas%NOTFOUND;

  END LOOP;

  -- Cierra CURSOR.
  IF (cuLecturas%ISOPEN) THEN
    --{
    CLOSE cuLecturas;
    --}
  END IF;

  -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra(197,
                                197,
                                3,
                                'PR_LECTELME_C',
                                vcontIns,
                                nuErrores,
                                'TERMINO PROCESO #regs: ' || vcontIns,
                                'FIN',
                                nuLogError);
  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'T', RAPRFEFI = sysdate
   WHERE raprbase = inudatabase
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 197;
  commit;

EXCEPTION
  WHEN OTHERS THEN
    PKLOG_MIGRACION.prInsLogMigra(197,
                                  197,
                                  2,
                                  'PR_LECTELME_C',
                                  0,
                                  0,
                                  'Error: ' || sqlerrm,
                                  to_char(sqlcode),
                                  nuLogError);

END PR_LECTELME1; 
/
