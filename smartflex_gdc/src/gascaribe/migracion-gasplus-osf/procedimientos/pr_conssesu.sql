CREATE OR REPLACE PROCEDURE PR_CONSSESU(NUMINICIO   number,
                                        numFinal    number,
                                        inudatabase number) AS
  /*******************************************************************
  SELECT * FROM   LDC_TEMP_consumo_SGE
   PROGRAMA        :    CONSSESU_C
   FECHA            :    27/09/2012
   AUTOR            :
   DESCRIPCION    :    Migra la informacion de los consumos de servicios
                      suscriptos a la tabla CONSSESU de OSF
  
  SELECT * FROM ldc_temp_consumo_sge
   HISTORIA DE MODIFICACIONES
   AUTOR       FECHA    DESCRIPCION
       SELECT * FROM ldc_temp_consumo_sge
       alter table  migra.ldc_temp_consumo_sge drop column consfacr
            alter table  migra.ldc_temp_consumo_sge add consfapr number(14)
   *******************************************************************/

  nuComplementoPR number;
  nuComplementoSU number;
  nuComplementoFA number;
  nuComplementoCU number;
  nuComplementoDI number;

  vfecha_ini     DATE;
  vfecha_fin     DATE;
  vprograma      VARCHAR2(100);
  verror         VARCHAR2(4000);
  vcont          NUMBER;
  nuREg          NUMBER := 0;
  vcontLec       NUMBER := 0;
  vcontIns       NUMBER := 0;
  nuSuscriptor   number := 0;
  sbLectura      VARCHAR2(30) := null;
  sbconsconsprom VARCHAR2(1) := null;

  cursor cuLocalidad(nuDepa number, nuLoca number) IS
    select COLOHOMO
      FROM LDC_MIG_LOCALIDAD
     WHERE CODIDEPA = NUDEPA
       and CODILOCA = nuLoca;

  NULOCALIDAD NUMBER(6);
  SBconscons  VARCHAR2(100);
  nuSecuencia number := 0;

  nuCalculo          number(14, 4) := 0;
  NUGRES             NUMBER;
  nuSecuenciaconsesu number;
  -- RGCALIBRACION CUCALIBRACION%ROWTYPE;

  cursor culecturas(nucomplemento number) is
    select /*+ PARALLEL */
     a.*,
     d.EMSSCMSS COMPONENTE,
     d.EMSSELME MEDIDOR,
     b.PEFAHOMO,
     c.PEFAHOMO PECSHOMO
      from LDC_TEMP_consumo_SGE a,
           elmesesu             d,
           ldc_mig_perifact     b,
           ldc_mig_perifact     c
     Where a.conssusc >= NUMINICIO
       and a.conssusc < numfinal
       and A.BASEDATO = B.DATABASE
       and B.CODIPEFA = a.CONSPEFA
       and B.CODICICL = a.CONSCICL
       and B.CODIANO = a.CONSANO
       and b.CODIMES = a.CONSMES
       AND a.conspecs = c.codipefa(+)
       AND a.cppsano = c.codiano(+)
       AND a.copsmes = c.CODIMES(+)
       and a.CONSCICL = c.codicicl(+)
       and d.EMSSSESU - nucomplemento = a.CONSNuse
       AND A.CONSMEDI = D.EMSSCOEM
       AND A.BASEDATO = C.database(+)
       AND B.DATABASE = inudatabase;

  CURSOR CUVAVAFACO(NULOCA NUMBER) IS
    SELECT *
      FROM CM_VAVAFACO
     WHERE VVFCUBGE = NULOCA
       AND VVFCVAFC = 'PRESION_ATMOSFERICA';

  rgVavafaco cuVavafaco%rowtype;

  CURSOR CUVAVAFACO_1 IS
    SELECT *
      FROM CM_VAVAFACO
     WHERE VVFCUBGE = 169
       AND VVFCVAFC = 'PRESION_OPERACION_REF';

  rgPais CUVAVAFACO_1%rowtype;
  -- DECLARACION DE TIPOS.
  --
  TYPE tipo_cu_datos IS TABLE OF cuLecturas%ROWTYPE;

  -- DECLARACION DE TABLAS TIPOS.
  --
  tbl_datos tipo_cu_datos := tipo_cu_datos();

  nuLogError  NUMBER;
  nuTotalRegs number := 0;
  nuErrores   number := 0;

BEGIN

  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra(195,
                                195,
                                1,
                                'PR_CONSSESU_C',
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
     AND raprcodi = 195;
  commit;

  pkg_constantes.COMPLEMENTO(inudatabase,
                             nuComplementoPR,
                             nuComplementoSU,
                             nuComplementoFA,
                             nuComplementoCU,
                             nuComplementoDI);

  vcontIns := 1;
  vcontLec := 0;
  OPEN cuLecturas(nucomplementopr);

  LOOP
    --
    -- Borrar tablas     tbl_datos.
    --
    tbl_datos.delete;
  
    FETCH cuLecturas BULK COLLECT
      INTO TBL_DATOS LIMIT 1000;
  
    FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
    
      nuReg        := 1;
      nuSuscriptor := tbl_datos(nuindice).CONSNUSE;
    
      BEGIN
      
        SBLECTURA          := TBL_DATOS(NUINDICE).PEFAHOMO;
        nuSecuencia        := SQ_CM_FACOCOSS_198741.NEXTVAL;
        nuSecuenciaconsesu := SQ_CARGOS_CARGCODO.NEXTVAL;
      
        OPEN CULOCALIDAD(TBL_DATOS(NUINDICE).CONSDNOT,
                         TBL_DATOS(NUINDICE).CONSLNOT);
        FETCH CULOCALIDAD
          INTO NULOCALIDAD;
        close cuLocalidad;
      
        OPEN CUVAVAFACO(NULOCALIDAD);
        FETCH CUVAVAFACO
          INTO RGVAVAFACO;
        CLOSE CUVAVAFACO;
      
        OPEN CUVAVAFACO_1;
        FETCH CUVAVAFACO_1
          INTO RGPAIS;
        CLOSE CUVAVAFACO_1;
      
        INSERT INTO CM_FACOCOSS
          (FCCOCONS,
           FCCOPECS,
           FCCOUBGE,
           FCCOSESU,
           FCCOFACO,
           FCCOFAPR,
           FCCOFATE,
           FCCOFASC,
           FCCOFAPC,
           FCCOFACM)
        VALUES
          (nuSecuencia,
           TBL_DATOS(NUINDICE).PEFAHOMO,
           nuLocalidad,
           TBL_DATOS(NUINDICE).CONSNUSE + nuComplementoPR,
           TBL_DATOS(NUINDICE).CONSFACO,
           TBL_DATOS(NUINDICE).CONSFAPR,
           TBL_DATOS(NUINDICE).CONSFATE,
           1,
           TBL_DATOS(NUINDICE).CONSPOCA,
           null);
      
        IF (TBL_DATOS(NUINDICE).CONSPROM = 'S') then
        
          IF TBL_DATOS(NUINDICE).CONSTICP = 'PCE' THEN
            SBconscons := 'OBTECOPS - Obtener conscons Promedio Subcategoría';
          
            INSERT INTO CONSSESU
              (COSSSESU,
               COSSTCON,
               COSSPEFA,
               COSSCOCA,
               COSSNVEC,
               COSSELME,
               COSSMECC,
               COSSFLLI,
               COSSPFCR,
               COSSDICO,
               COSSIDRE,
               COSSCMSS,
               COSSFERE,
               COSSFUFA,
               COSSCAVC,
               COSSFUNC,
               COSSPECS,
               COSSCONS,
               COSSFCCO)
            VALUES
              (TBL_DATOS(NUINDICE).CONSNUSE+ nuComplementoPR,
               1,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               TBL_DATOS(NUINDICE).conscons,
               0,
               tbl_datos(nuindice).medidor,
               tbl_datos(nuindice).consmeca,
               'N',
               null,
               tbl_datos(nuindice).CONSDIAS,
               null,
               TBL_DATOS(NUINDICE).COMPONENTE,
               TBL_DATOS(NUINDICE).CONSFECH,
               SBconscons,
               1,
               NULL,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               null,
               NUSECUENCIA);
          END IF;
        
          IF TBL_DATOS(NUINDICE).CONSTICP = 'PSU' THEN
            SBconscons := 'OBTECOPP - Obtener conscons Promedio Individual de los ÿltimos Meses Parametrizados';
            INSERT INTO CONSSESU
              (COSSSESU,
               COSSTCON,
               COSSPEFA,
               COSSCOCA,
               COSSNVEC,
               COSSELME,
               COSSMECC,
               COSSFLLI,
               COSSPFCR,
               COSSDICO,
               COSSIDRE,
               COSSCMSS,
               COSSFERE,
               COSSFUFA,
               COSSCAVC,
               COSSFUNC,
               COSSPECS,
               COSSCONS,
               COSSFCCO)
            VALUES
              (TBL_DATOS(NUINDICE).CONSNUSE+ nuComplementoPR,
               1,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               TBL_DATOS(NUINDICE).conscons,
               0,
               tbl_datos(nuindice).medidor,
               tbl_datos(nuindice).consmeca,
               'N',
               null,
               tbl_datos(nuindice).CONSDIAS,
               null,
               TBL_DATOS(NUINDICE).COMPONENTE,
               TBL_DATOS(NUINDICE).CONSFECH,
               SBconscons,
               1,
               NULL,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               null,
               NUSECUENCIA);
          END IF;
        
          IF TBL_DATOS(NUINDICE)
          .consticp NOT IN ('PSU', 'PCE') OR TBL_DATOS(NUINDICE)
          .CONSTICP IS NULL THEN
            SBconscons := 'OBTECOPP - Obtener conscons Promedio Individual de los ÿltimos Meses Parametrizados';
            INSERT INTO CONSSESU
              (COSSSESU,
               COSSTCON,
               COSSPEFA,
               COSSCOCA,
               COSSNVEC,
               COSSELME,
               COSSMECC,
               COSSFLLI,
               COSSPFCR,
               COSSDICO,
               COSSIDRE,
               COSSCMSS,
               COSSFERE,
               COSSFUFA,
               COSSCAVC,
               COSSFUNC,
               COSSPECS,
               COSSCONS,
               COSSFCCO)
            VALUES
              (TBL_DATOS(NUINDICE).CONSNUSE+ nuComplementoPR,
               1,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               TBL_DATOS(NUINDICE).conscons,
               0,
               tbl_datos(nuindice).medidor,
               tbl_datos(nuindice).consmeca,
               'N',
               null,
               tbl_datos(nuindice).CONSDIAS,
               null,
               TBL_DATOS(NUINDICE).COMPONENTE,
               TBL_DATOS(NUINDICE).CONSFECH,
               SBconscons,
               1,
               NULL,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               null,
               NUSECUENCIA);
          end if;
        
        ELSE
        
          SBconscons := 'CONSDLFC - conscons por Diferencia de Lecturas aplicando Factor de Corrección';
          if (tbl_datos(nuindice).consmeca in (2, 5)) then
            INSERT INTO CONSSESU
              (COSSSESU,
               COSSTCON,
               COSSPEFA,
               COSSCOCA,
               COSSNVEC,
               COSSELME,
               COSSMECC,
               COSSFLLI,
               COSSPFCR,
               COSSDICO,
               COSSIDRE,
               COSSCMSS,
               COSSFERE,
               COSSFUFA,
               COSSCAVC,
               COSSFUNC,
               COSSPECS,
               COSSCONS,
               COSSFCCO)
            values
              (TBL_DATOS(NUINDICE).CONSNUSE+ nuComplementoPR,
               1,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               decode(tbl_datos(nuindice).consmeca,2,-TBL_DATOS(NUINDICE).conscons,TBL_DATOS(NUINDICE).conscons),
               0,
               tbl_datos(nuindice).medidor,
               tbl_datos(nuindice).consmeca,
               'N',
               null,
               tbl_datos(nuindice).CONSDIAS,
               null,
               TBL_DATOS(NUINDICE).COMPONENTE,
               TBL_DATOS(NUINDICE).CONSFECH,
               SBconscons,
               1,
               NULL,
               TBL_DATOS(NUINDICE).PECSHOMO,
               null,
               NUSECUENCIA);
          else
            INSERT INTO CONSSESU
              (COSSSESU,
               COSSTCON,
               COSSPEFA,
               COSSCOCA,
               COSSNVEC,
               COSSELME,
               COSSMECC,
               COSSFLLI,
               COSSPFCR,
               COSSDICO,
               COSSIDRE,
               COSSCMSS,
               COSSFERE,
               COSSFUFA,
               COSSCAVC,
               COSSFUNC,
               COSSPECS,
               COSSCONS,
               COSSFCCO)
            values
              (TBL_DATOS(NUINDICE).CONSNUSE+ nuComplementoPR,
               1,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               TBL_DATOS(NUINDICE).conscons,
               0,
               tbl_datos(nuindice).medidor,
               tbl_datos(nuindice).consmeca,
               'N',
               null,
               tbl_datos(nuindice).CONSDIAS,
               null,
               TBL_DATOS(NUINDICE).COMPONENTE,
               TBL_DATOS(NUINDICE).CONSFECH,
               SBconscons,
               1,
               NULL,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               null,
               NUSECUENCIA);
          END if;
        END IF;
      
        if TBL_DATOS(NUINDICE).conscons <> 0 then
        
          if (tbl_datos(nuindice).consmeca in (2, 5)) then
            INSERT INTO CONSSESU
              (COSSSESU,
               COSSTCON,
               COSSPEFA,
               COSSCOCA,
               COSSNVEC,
               COSSELME,
               COSSMECC,
               COSSFLLI,
               COSSPFCR,
               COSSDICO,
               COSSIDRE,
               COSSCMSS,
               COSSFERE,
               COSSFUFA,
               COSSCAVC,
               COSSFUNC,
               COSSPECS,
               COSSCONS,
               COSSFCCO)
            VALUES
              (TBL_DATOS(NUINDICE).CONSNUSE+ nuComplementoPR,
               1,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               decode(tbl_datos(nuindice).consmeca,2,-TBL_DATOS(NUINDICE).conscons,TBL_DATOS(NUINDICE).conscons),
               0,
               tbl_datos(nuindice).medidor,
               4,
               'S',
               null,
               tbl_datos(nuindice).CONSDIAS,
               null,
               TBL_DATOS(NUINDICE).COMPONENTE,
               TBL_DATOS(NUINDICE).CONSFECH,
               NULL,
               1,
               NULL,
               TBL_DATOS(NUINDICE).PECSHOMO,
               nuSecuenciaconsesu,
               nuSecuencia);
          else
            INSERT INTO CONSSESU
              (COSSSESU,
               COSSTCON,
               COSSPEFA,
               COSSCOCA,
               COSSNVEC,
               COSSELME,
               COSSMECC,
               COSSFLLI,
               COSSPFCR,
               COSSDICO,
               COSSIDRE,
               COSSCMSS,
               COSSFERE,
               COSSFUFA,
               COSSCAVC,
               COSSFUNC,
               COSSPECS,
               COSSCONS,
               COSSFCCO)
            values
              (TBL_DATOS(NUINDICE).CONSNUSE+ nuComplementoPR,
               1,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               TBL_DATOS(NUINDICE).conscons,
               0,
               tbl_datos(nuindice).medidor,
               4,
               'S',
               null,
               tbl_datos(nuindice).CONSDIAS,
               null,
               TBL_DATOS(NUINDICE).COMPONENTE,
               TBL_DATOS(NUINDICE).CONSFECH,
               NULL,
               1,
               NULL,
               TBL_DATOS(NUINDICE).PEFAHOMO,
               nuSecuenciaconsesu,
               NUSECUENCIA);
          
          END if;
        end if;
      
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            verror := 'Error en el SUSCRIPTOR: ' || nuSuscriptor ||
                      ' -  Con Lectura : ' || sbLectura || ' - ' || SQLERRM;
          
            nuErrores := nuErrores + 1;
            PKLOG_MIGRACION.prInsLogMigra(195,
                                          195,
                                          2,
                                          'PR_CONSSESU_C',
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
  PKLOG_MIGRACION.prInsLogMigra(195,
                                195,
                                3,
                                'PR_CONSSESU_C',
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
     AND raprcodi = 195;
  commit;

EXCEPTION
  WHEN OTHERS THEN
    PKLOG_MIGRACION.prInsLogMigra(195,
                                  195,
                                  2,
                                  'PR_CONSSESU_C',
                                  0,
                                  0,
                                  'Error: ' || sqlerrm,
                                  to_char(sqlcode),
                                  nuLogError);
  
END PR_CONSSESU; 
/
