CREATE OR REPLACE PACKAGE adm_person.ldc_pkanarefinanosf
AS
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  18/06/2024   Adrianavg   OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
    PROCEDURE LDC_PRAnaRefinanOSF;

END LDC_PKAnaRefinanOSF;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKAnaRefinanOSF
AS
  PROCEDURE LDC_PRAnaRefinanOSF
  IS

  nucarini  NUMBER(15,2);
  nucardif  NUMBER(15,2);
  nudifre   NUMBER(13,2);
  nudifplq  NUMBER(4);
  nuvalcap  NUMBER(13,2);
  nuvalfin  NUMBER(13,2);
  nuvalcon  NUMBER(13,2);
  nuvalom3  NUMBER(15,4);
  nuvalcar  NUMBER(13,2);
  nuvalcot  NUMBER(13,2);
  nuvaliva  NUMBER(13,2);
  nuvalmor  NUMBER(13,2);
  nuvalsub  NUMBER(13,2);
  nuvalpag  NUMBER(13,2);
  nuvalndb  NUMBER(13,2);
  nuvalncr  NUMBER(13,2);
  nucarfin  NUMBER(15,2);
  nucarfind NUMBER(15,2);
  nusersus  NUMBER(10);
  nuvalnref NUMBER(14);
  nuvaldfnb NUMBER(13,2);
  nuvaldrnx NUMBER(13,2);
  nuvaldsev NUMBER(13,2);
  nuvalpoli NUMBER(14);
  nuCont    NUMBER;                                     --Conteo de registros para saber cada cuanto registros hago commit
  nuperini  NUMBER;
  nuperfin  NUMBER;
  nusession NUMBER;                                     --Numero de sesion
  sbMens    VARCHAR2(2000);
  dtFecini  DATE;
  nucarmar  NUMBER;

  CURSOR cuRefinan IS
    SELECT C.CARENUSE,
           C.CAREDATE,
           C.CAREPLAN,
           C.CAREINIC,
           C.SESUSUSC,
           C.CAREMARC,
           C.CARENREF
    FROM OPEN.TMP_USUAREFI C;
    /*SELECT C.CARENUSE,
           C.CAREDATE,
           C.CAREPLAN,
           C.CAREINIC,
           NULL SESUSUSC,
           C.CAREMARC,
           C.CARENREF
    FROM OPEN.CARTREFI C
    WHERE C.CAREMARC = 1
    UNION ALL
    SELECT S.SESUNUSE CARENUSE,
           RF.RECORD_DATE CAREDATE,
           RF.FINANCING_PLAN_ID CAREPLAN,
           RF.VALUE_TO_FINANCE CAREINIC,
           S.SESUSUSC,
           3 CAREMARC,
           0 CARENREF
    FROM OPEN.CC_FINANCING_REQUEST RF,
         OPEN.SERVSUSC S
    WHERE RF.RECORD_DATE >= to_date(to_char(to_date('08/02/2015'),'dd/mm/yyyy') || ' 00:00:00','dd/mm/yyyy hh24:mi:ss')
    AND RF.RECORD_PROGRAM = 'GCNED'
    AND S.SESUSUSC = RF.SUBSCRIPTION_ID
    AND S.SESUSERV = 7014
    AND RF.RECORD_DATE = (SELECT MIN(RF1.RECORD_DATE)
                          FROM OPEN.CC_FINANCING_REQUEST RF1
                          WHERE RF1.SUBSCRIPTION_ID = RF.SUBSCRIPTION_ID
                          AND RF1.RECORD_DATE >= to_date(to_char(to_date('08/02/2015'),'dd/mm/yyyy') || ' 00:00:00','dd/mm/yyyy hh24:mi:ss'))
    AND NOT EXISTS(SELECT 'X'
                   FROM OPEN.CARTREFI CR
                   WHERE CR.CARENUSE = S.SESUNUSE
                   AND CR.CAREMARC IN (1,2));*/

  TYPE tytbData IS TABLE OF cuRefinan%ROWTYPE INDEX BY BINARY_INTEGER;    --Tomo el tipo del cursor de Refinanciados
  tbData        tytbData;                                                 --Variable tipo tabla basado en el cursor de Refinanciados

  BEGIN
    --ut_trace.trace(SYSDATE||' INICIA LDC_PRAnaRefinanOSF', 15);
    DELETE FROM OPEN.TMP_USUAREFI;
    INSERT INTO OPEN.TMP_USUAREFI
                                 (
                                  carenuse,
                                  caredate,
                                  careplan,
                                  careinic,
                                  sesususc,
                                  caremarc,
                                  carenref
                                  )
    SELECT C.CARENUSE,
           C.CAREDATE,
           C.CAREPLAN,
           C.CAREINIC,
           NULL SESUSUSC,
           C.CAREMARC,
           C.CARENREF
    FROM OPEN.CARTREFI C
    WHERE C.CAREMARC = 1
    UNION ALL
    SELECT S.SESUNUSE CARENUSE,
           RF.RECORD_DATE CAREDATE,
           RF.FINANCING_PLAN_ID CAREPLAN,
           RF.VALUE_TO_FINANCE CAREINIC,
           S.SESUSUSC,
           3 CAREMARC,
           0 CARENREF
    FROM OPEN.CC_FINANCING_REQUEST RF,
         OPEN.SERVSUSC S
    WHERE RF.RECORD_DATE >= to_date(to_char(to_date('08/02/2015'),'dd/mm/yyyy') || ' 00:00:00','dd/mm/yyyy hh24:mi:ss')
    AND RF.RECORD_PROGRAM = 'GCNED'
    AND S.SESUSUSC = RF.SUBSCRIPTION_ID
    AND S.SESUSERV = 7014
    AND RF.RECORD_DATE = (SELECT MIN(RF1.RECORD_DATE)
                          FROM OPEN.CC_FINANCING_REQUEST RF1
                          WHERE RF1.SUBSCRIPTION_ID = RF.SUBSCRIPTION_ID
                          AND RF1.RECORD_DATE >= to_date(to_char(to_date('08/02/2015'),'dd/mm/yyyy') || ' 00:00:00','dd/mm/yyyy hh24:mi:ss'))
    AND NOT EXISTS(SELECT 'X'
                   FROM OPEN.CARTREFI CR
                   WHERE CR.CARENUSE = S.SESUNUSE
                   AND CR.CAREMARC IN (1,2));

    COMMIT;

    SELECT userenv('sessionid') INTO nusession FROM dual;
    DELETE FROM OPEN.ldc_osf_estaproc
    WHERE proceso = 'LDC_PRAnaRefinanOSF';
    DELETE FROM OPEN.LDC_OSF_PROERROR;
    COMMIT;
    ldc_proinsertaestaprog(to_number(to_char(sysdate,'YYYY')),to_number(to_char(sysdate,'MM')),'LDC_PRAnaRefinanOSF','Inicia ejecucion..',nusession,USER);

    --ut_trace.trace(SYSDATE||' USO ldc_proinsertaestaprog', 15);

    --Inicializamos el contador para realizar commit cada 300 registros
    nuCont := 0;

    --Limpiamos la tabla de resultados para usarla
    DELETE FROM OPEN.CARTREFI C
    WHERE C.CAREMARC <> 1;
    COMMIT;

    OPEN cuRefinan;
    LOOP

    tbData.delete;

    FETCH cuRefinan BULK COLLECT INTO tbData LIMIT 10;

    IF(tbData.count > 0)THEN
          FOR nuIndex IN tbData.first..tbData.last LOOP
            --ut_trace.trace(SYSDATE||' ENTRO cuRefinan', 15);
            ------------------------------------------------------------------------------------------------------------
            --Determinamos los periodos sobre los que se busca la informacion pertinente a cartera y cargos
            If tbData(nuIndex).CAREMARC = 3 Then
               nuperini := to_char(tbData(nuIndex).CAREDATE,'yyyy')||to_char(tbData(nuIndex).CAREDATE,'mm');
               dtFecini := tbData(nuIndex).CAREDATE;
            Else
               nuperini := to_char(to_date('08/02/2015'),'yyyy')||to_char(to_date('08/02/2015'),'mm');
               dtFecini := to_date(to_char(to_date('08/02/2015'),'dd/mm/yyyy') || ' 00:00:00','dd/mm/yyyy hh24:mi:ss');
            End If;

            Select Max(rh.nuano||lpad(rh.numes, 2, 0)) Into nuperfin
              From OPEN.LDC_OSF_SESUCIER rh
             Where rh.producto = tbData(nuIndex).CARENUSE
               And Exists(Select 'x'
                            From OPEN.LDC_CIERCOME f2
                           Where f2.cicoano = rh.nuano
                             And f2.cicomes = rh.numes
                             And f2.cicoesta = 'S');

            --ut_trace.trace(SYSDATE||' SELECT MAX nuperfin', 15);

            If nuperfin Is Null Then
                  INSERT INTO OPEN.LDC_OSF_PROERROR
                                             (
                                              perini,
                                              perfin,
                                              producto,
                                              contrato,
                                              numcaso
                                              )
                                        VALUES(
                                               nuperini
                                              ,nuperfin
                                              ,tbData(nuIndex).CARENUSE
                                              ,tbData(nuIndex).SESUSUSC
                                              ,1
                                              );
                  COMMIT;
                  --ut_trace.trace(SYSDATE||' INSERT ERROR 1', 15);
                  GOTO SALTAR;
            End If;

            If (nuperfin < nuperini) Then
                  INSERT INTO OPEN.LDC_OSF_PROERROR
                                             (
                                              perini,
                                              perfin,
                                              producto,
                                              contrato,
                                              numcaso
                                              )
                                        VALUES(
                                               nuperini
                                              ,nuperfin
                                              ,tbData(nuIndex).CARENUSE
                                              ,tbData(nuIndex).SESUSUSC
                                              ,2
                                              );
                  COMMIT;
                  --ut_trace.trace(SYSDATE||' INSERT ERROR 2', 15);
                  GOTO SALTAR;
            End if;
            ------------------------------------------------------------------------------------------------------------
            --ut_trace.trace(SYSDATE||' ANTES DE SELECT CARTERA', 15);
            BEGIN
            Select nuse,
                   cartera_inicial,
                   cartera_inicial_diferida,
                   diferidos_reinstalacion,
                   diferidos_plan_quinquenal,
                   capital,
                   financiacion,
                   consumo,
                   m3,
                   cargo_basico,
                   contribucion,
                   iva,
                   mora,
                   subsidio,
                   pagos,
                   notas_debito,
                   notas_credito_cargos,
                   cartera_final,
                   cartera_final_diferida
              Into nusersus,
                   nucarini,
                   nucardif,
                   nudifre,
                   nudifplq,
                   nuvalcap,
                   nuvalfin,
                   nuvalcon,
                   nuvalom3,
                   nuvalcar,
                   nuvalcot,
                   nuvaliva,
                   nuvalmor,
                   nuvalsub,
                   nuvalpag,
                   nuvalndb,
                   nuvalncr,
                   nucarfin,
                   nucarfind
              From (

                    Select nuse,
                            ano,
                            mes,
                            dia,
                            cartera_inicial,
                            cartera_inicial_diferida,
                            diferidos_reinstalacion,
                            diferidos_plan_quinquenal,
                            capital,
                            financiacion,
                            consumo,
                            m3,
                            cargo_basico,
                            contribucion,
                            iva,
                            mora,
                            subsidio,
                            pagos,
                            notas_debito,
                            notas_credito_cargos,
                            cartera_final,
                            cartera_final_diferida,
                            cartera_final_calculada,
                            cartera_final_dif_calculada,
                            (cartera_final - cartera_final_calculada) cartera_final_diferencia,
                            (cartera_final_diferida - cartera_final_dif_calculada) cartera_final_dif_diferencia
                      From (Select nuse,
                                    ano,
                                    mes,
                                    dia,
                                    cartera_inicial,
                                    cartera_inicial_diferida,
                                    diferidos_reinstalacion,
                                    diferidos_plan_quinquenal,
                                    capital,
                                    financiacion,
                                    consumo,
                                    m3,
                                    cargo_basico,
                                    contribucion,
                                    iva,
                                    mora,
                                    subsidio,
                                    pagos,
                                    notas_debito,
                                    notas_credito_cargos,
                                    cartera_final,
                                    cartera_final_diferida,
                                    (cartera_inicial + capital + financiacion +
                                    consumo + cargo_basico + contribucion + iva +
                                    subsidio - pagos + notas_debito -
                                    notas_credito_cargos) cartera_final_calculada,
                                    (cartera_inicial_diferida +
                                    diferidos_reinstalacion +
                                    diferidos_plan_quinquenal - capital) cartera_final_dif_calculada
                               From (

                                     Select nuse,
                                             ano,
                                             mes,
                                             dia,
                                             nvl(cartera_inicial, 0) cartera_inicial,
                                             nvl(cartera_inicial_diferida, 0) cartera_inicial_diferida,
                                             nvl(diferidos_reinstalacion, 0) diferidos_reinstalacion,
                                             nvl(diferidos_plan_quinquenal, 0) diferidos_plan_quinquenal,
                                             nvl(capital, 0) capital,
                                             nvl(financiacion, 0) financiacion,
                                             nvl(consumo, 0) consumo,
                                             nvl(m3, 0) m3,
                                             nvl(cargo_basico, 0) cargo_basico,
                                             nvl(contribucion, 0) contribucion,
                                             nvl(iva, 0) iva,
                                             nvl(mora,0) mora,
                                             nvl(subsidio, 0) subsidio,
                                             nvl(pagos, 0) pagos,
                                             nvl(notas_debito, 0) notas_debito,
                                             nvl(notas_credito_cargos, 0) notas_credito_cargos,
                                             nvl(cartera_final, 0) cartera_final,
                                             nvl(cartera_final_diferida, 0) cartera_final_diferida
                                       From (

                                               Select  ss.sesunuse   nuse,
                                                       f_sig.cicoano ano,
                                                       f_sig.cicomes mes,
                                                       to_char(f_sig.cicofech,'dd') dia,
                                                       -- Cartera inicial
                                                       /*(Select nvl(ct.deuda_corriente_no_vencida,0) + nvl(ct.deuda_corriente_vencida,0)
                                                          From open.ldc_osf_sesucier ct
                                                         Where ct.nuano = f_act.cicoano
                                                           And ct.numes = f_act.cicomes
                                                           And ct.producto = ss.sesunuse
                                                           And rownum = 1)*/ 0 cartera_inicial,
                                                       -- Cartera inicial diferida
                                                       /*(Select nvl(ct.deuda_no_corriente,0)
                                                          From open.ldc_osf_sesucier ct
                                                         Where ct.nuano = f_act.cicoano
                                                           And ct.numes = f_act.cicomes
                                                           And ct.producto = ss.sesunuse
                                                           And rownum = 1)*/ 0 cartera_inicial_diferida,
                                                       -- Diferidos reinstalacion
                                                       (Select Sum(difevatd) dif_cargados
                                                          From diferido df
                                                         Where df.difenuse = ss.sesunuse
                                                           And df.difefein >= dtFecini
                                                           And df.difefein < f_sig.cicofech
                                                           And df.difeprog <> 'GCNED') diferidos_reinstalacion,
                                                       -- diferidos plan quinquenal
                                                       0 diferidos_plan_quinquenal,
                                                       -- Capital
                                                       (Select Sum(decode(substr(cargdoso,
                                                                                 1,
                                                                                 2),
                                                                          'DF',
                                                                          decode(cargsign,
                                                                                 'DB',
                                                                                 (cargvalo),
                                                                                 (cargvalo) * -1))) capital
                                                          From cargos, concepto
                                                         Where CARGFECR >= dtFecini
                                                           And CARGFECR < f_sig.cicofech
                                                           And cargnuse = ss.sesunuse
                                                           And cargconc = conccodi
                                                           And substr(cargdoso,1,2) = 'DF'
                                                           And cargprog = 5) capital,
                                                       (Select Sum(decode(substr(cargdoso,
                                                                                 1,
                                                                                 2),
                                                                          'ID',
                                                                          decode(cargsign,
                                                                                 'DB',
                                                                                 (cargvalo),
                                                                                 (cargvalo) * -1))) capital
                                                          From cargos, concepto
                                                         Where CARGFECR >= dtFecini
                                                           And CARGFECR < f_sig.cicofech
                                                           And cargnuse = ss.sesunuse
                                                           And cargconc = conccodi
                                                           And substr(cargdoso,1,2) = 'ID'
                                                           And cargprog = 5) financiacion,
                                                       (Select Sum(decode(substr(cargdoso,
                                                                                 1,
                                                                                 2),
                                                                          'CO',
                                                                          decode(cargsign,
                                                                                 'DB',
                                                                                 (cargvalo),
                                                                                 (cargvalo) * -1),
                                                                          0))
                                                          From cargos, concepto
                                                         Where CARGFECR >= dtFecini
                                                           And CARGFECR < f_sig.cicofech
                                                           And cargnuse = ss.sesunuse
                                                           And cargconc = conccodi
                                                           And cargprog = 5
                                                           And cargconc = 31
                                                           And substr(cargdoso,1,2) = 'CO') consumo,

                                                       (Select Sum(decode(substr(cargdoso,
                                                                                 1,
                                                                                 2),
                                                                          'CO',
                                                                          decode(cargsign,
                                                                                 'DB',
                                                                                 (CARGUNID),
                                                                                 (CARGUNID) * -1),
                                                                          0))
                                                          From cargos, concepto
                                                         Where CARGFECR >= dtFecini
                                                           And CARGFECR < f_sig.cicofech
                                                           And cargnuse = ss.sesunuse
                                                           And cargconc = conccodi
                                                           And cargprog = 5
                                                           And cargconc = 31
                                                           And substr(cargdoso,1,2) = 'CO') m3,

                                                       (Select Sum(decode(substr(cargdoso,
                                                                                 1,
                                                                                 2),
                                                                          'CB',
                                                                          decode(cargsign,
                                                                                 'DB',
                                                                                 (cargvalo),
                                                                                 (cargvalo) * -1),
                                                                          0))
                                                          From cargos, concepto
                                                         Where CARGFECR >= dtFecini
                                                           And CARGFECR < f_sig.cicofech
                                                           And cargnuse = ss.sesunuse
                                                           And cargconc = conccodi
                                                           And cargprog = 5
                                                           And cargconc = 17
                                                           And substr(cargdoso,1,2) = 'CB') cargo_basico,
                                                       (Select Sum(decode(substr(cargdoso,
                                                                                 1,
                                                                                 2),
                                                                          'CN',
                                                                          decode(cargsign,
                                                                                 'DB',
                                                                                 (cargvalo),
                                                                                 (cargvalo) * -1),
                                                                          0))
                                                          From cargos, concepto
                                                         Where CARGFECR >= dtFecini
                                                           And CARGFECR < f_sig.cicofech
                                                           And cargnuse = ss.sesunuse
                                                           And cargconc = conccodi
                                                           And cargprog = 5
                                                           And cargconc = 37
                                                           And substr(cargdoso,1,2) = 'CN') contribucion,
                                                       (Select Sum(decode(cargconc,
                                                                          137,
                                                                          decode(cargsign,
                                                                                 'DB',
                                                                                 (cargvalo),
                                                                                 (cargvalo) * -1),
                                                                          0))
                                                          From cargos, concepto
                                                         Where CARGFECR >= dtFecini
                                                           And CARGFECR < f_sig.cicofech
                                                           And cargnuse = ss.sesunuse
                                                           And cargconc = conccodi
                                                           And cargprog = 5
                                                           And cargconc = 137) iva,

                                                       (Select Sum(decode(cargconc,
                                                                          156,
                                                                          decode(cargsign,
                                                                                 'DB',
                                                                                 (cargvalo),
                                                                                 (cargvalo) * -1),
                                                                          0))
                                                          From cargos, concepto
                                                         Where CARGFECR >= dtFecini
                                                           And CARGFECR < f_sig.cicofech
                                                           And cargnuse = ss.sesunuse
                                                           And cargconc = conccodi
                                                           And cargprog = 5
                                                           And cargconc = 156) mora,

                                                       (Select Sum(decode(substr(cargdoso,
                                                                                 1,
                                                                                 2),
                                                                          'SU',
                                                                          decode(cargsign,
                                                                                 'DB',
                                                                                 (cargvalo),
                                                                                 (cargvalo) * -1),
                                                                          0))
                                                          From cargos, concepto
                                                         Where CARGFECR >= dtFecini
                                                           And CARGFECR < f_sig.cicofech
                                                           And cargnuse = ss.sesunuse
                                                           And cargconc = conccodi
                                                           And cargprog = 5
                                                           And cargconc = 196
                                                           And substr(cargdoso,1,2) = 'SU') subsidio,
                                                       -- pagos
                                                       (Select Sum(cargvalo) pagos
                                                          From cargos
                                                         Where cargsign = 'PA'
                                                           And cargnuse = ss.sesunuse
                                                           And CARGFECR >= dtFecini
                                                           And CARGFECR < f_sig.cicofech) pagos,
                                                       -- Notas Debito Notas Debito
                                                       (Select Sum(c.cargvalo) notas_debito
                                                          From open.cargos c
                                                         Where c.cargnuse = ss.sesunuse
                                                           And c.cargfecr >= dtFecini
                                                           And substr(c.cargdoso,1,2) = 'ND'
                                                           And c.cargcaca Not In (20,23,46,50,51,56,73)
                                                           And c.cargprog <> 2016) notas_debito,
                                                       -- Notas crédito cargos
                                                       (Select Sum(c.cargvalo) notas_credito
                                                          From open.cargos c
                                                         Where c.cargnuse = ss.sesunuse
                                                           And c.cargfecr >= dtFecini
                                                           And substr(c.cargdoso,1,2) = 'NC'
                                                           And c.cargcaca Not In (20,23,46,50,51,56,73)
                                                           And c.cargprog <> 2016) notas_credito_cargos,
                                                       -- Cartera Final
                                                       (Select nvl(ct.deuda_corriente_no_vencida,0) + nvl(ct.deuda_corriente_vencida,0)
                                                          From open.ldc_osf_sesucier ct
                                                         Where ct.nuano = f_sig.cicoano
                                                           And ct.numes = f_sig.cicomes
                                                           And ct.producto = ss.sesunuse
                                                           And rownum = 1) cartera_final,
                                                       -- Cartera Final diferida
                                                       (Select nvl(ct.deuda_no_corriente,0)
                                                          From open.ldc_osf_sesucier ct
                                                         Where ct.nuano = f_sig.cicoano
                                                           And ct.numes = f_sig.cicomes
                                                           And ct.producto = ss.sesunuse
                                                           And rownum = 1) cartera_final_diferida
                                                 From  OPEN.LDC_CIERCOME f_sig,
                                                       OPEN.servsusc ss
                                                Where f_sig.cicoesta = 'S'
                                             And ss.sesunuse = tbData(nuIndex).CARENUSE
                                             And f_sig.cicoano || lpad(f_sig.cicomes, 2, 0) =
                                                 nuperfin))));
            EXCEPTION
             WHEN OTHERS THEN
                  sbMens := ' Error: ' || sqlerrm;
                  --ldc_proactualizaestaprog(nusession,SUBSTR('FALLO CONSULTA CARTERA - PRODUCTO: '||tbData(nuIndex).CARENUSE||sbMens,1,2000),'LDC_PRAnaRefinanOSF','con Error');
                  INSERT INTO OPEN.LDC_OSF_PROERROR
                   (perini, perfin, producto, contrato, numcaso, mensaje)
                  VALUES
                   (nuperini, nuperfin, tbData(nuIndex).CARENUSE, tbData(nuIndex).SESUSUSC, 3, sbMens);

                  GOTO SALTAR;
            END;
            --ut_trace.trace(SYSDATE||' SELECT CARTERA', 15);
            ------------------------------------------------------------------------------------------------------------
            If tbData(nuIndex).CAREMARC = 3 Then
              BEGIN
                  SELECT COUNT(RF.FINANCING_REQUEST_ID) INTO nuvalnref
                  FROM OPEN.CC_FINANCING_REQUEST RF,
                       OPEN.SERVSUSC S
                  WHERE RF.RECORD_DATE > dtFecini
                  AND RF.RECORD_PROGRAM = 'GCNED'
                  AND S.SESUSUSC = RF.SUBSCRIPTION_ID
                  AND S.SESUSERV = 7014
                  AND S.SESUNUSE = tbData(nuIndex).CARENUSE;
              EXCEPTION
                WHEN OTHERS THEN
                  nuvalnref := 0;
              END;
              --ut_trace.trace(SYSDATE||' SELECT nuvalnref 1', 15);
            Else
              BEGIN
                  SELECT COUNT(RF.FINANCING_REQUEST_ID) INTO nuvalnref
                  FROM OPEN.CC_FINANCING_REQUEST RF,
                       OPEN.SERVSUSC S
                  WHERE RF.RECORD_DATE >= dtFecini
                  AND RF.RECORD_PROGRAM = 'GCNED'
                  AND S.SESUSUSC = RF.SUBSCRIPTION_ID
                  AND S.SESUSERV = 7014
                  AND S.SESUNUSE = tbData(nuIndex).CARENUSE;
              EXCEPTION
                WHEN OTHERS THEN
                  nuvalnref := 0;
              END;
              --ut_trace.trace(SYSDATE||' SELECT nuvalnref 2', 15);
              nuvalnref := nvl(nuvalnref,0) + nvl(tbData(nuIndex).CARENREF,0);
            End If;
            ------------------------------------------------------------------------------------------------------------
            BEGIN
              SELECT SUM(NVL(DF.DIFEVATD,0)) DIFEVATD INTO nuvaldfnb
              FROM OPEN.DIFERIDO DF, OPEN.SERVSUSC S
              WHERE S.SESUNUSE = DF.DIFENUSE
              AND S.SESUSERV IN (7055,7056)
              AND DF.DIFENUSE = tbData(nuIndex).CARENUSE
              AND DF.DIFEFEIN > dtFecini;
            EXCEPTION
              WHEN OTHERS THEN
                nuvaldfnb := 0;
            END;
            --ut_trace.trace(SYSDATE||' SELECT nuvaldfnb', 15);
            ------------------------------------------------------------------------------------------------------------
            BEGIN
              SELECT SUM(NVL(DF.DIFEVATD,0)) DIFEVATD INTO nuvaldrnx
              FROM OPEN.DIFERIDO DF, OPEN.SERVSUSC S
              WHERE S.SESUNUSE = DF.DIFENUSE
              AND S.SESUSERV IN (7055,7056)
              AND DF.DIFECONC IN (169,159)
              AND DF.DIFENUSE = tbData(nuIndex).CARENUSE
              AND DF.DIFEFEIN > dtFecini;
            EXCEPTION
              WHEN OTHERS THEN
                nuvaldrnx := 0;
            END;
            ------------------------------------------------------------------------------------------------------------
            BEGIN
              SELECT SUM(NVL(DF.DIFEVATD,0)) DIFEVATD INTO nuvaldsev
              FROM OPEN.DIFERIDO DF, OPEN.SERVSUSC S
              WHERE S.SESUNUSE = DF.DIFENUSE
              AND S.SESUSERV IN (7055,7056)
              AND DF.DIFECONC IN (174,192,193,203,739)
              AND DF.DIFENUSE = tbData(nuIndex).CARENUSE
              AND DF.DIFEFEIN > dtFecini;
            EXCEPTION
              WHEN OTHERS THEN
                nuvaldsev := 0;
            END;
            ------------------------------------------------------------------------------------------------------------
            BEGIN
              SELECT COUNT(POL.POLICY_ID) POLICY_ID INTO nuvalpoli
              FROM OPEN.LD_POLICY POL
              WHERE POL.PRODUCT_ID = tbData(nuIndex).CARENUSE
              AND POL.STATE_POLICY IN (1,9)
              AND POL.DTCREATE_POLICY >= to_date(to_char(to_date('08/02/2015'),'dd/mm/yyyy') || ' 00:00:00','dd/mm/yyyy hh24:mi:ss');
            EXCEPTION
              WHEN OTHERS THEN
                nuvalpoli := 0;
            END;
            --ut_trace.trace(SYSDATE||' SELECT nuvalpoli', 15);
            ------------------------------------------------------------------------------------------------------------
            If tbData(nuIndex).CAREMARC = 1 Then
              nucarmar := 2;
            Elsif tbData(nuIndex).CAREMARC = 3 Then
              nucarmar := 3;
            End If;
            ------------------------------------------------------------------------------------------------------------
            --ut_trace.trace(SYSDATE||' ANTES DE INSERT CARTREFI', 15);
            BEGIN
              --Se inserta el registro en la tabla de resultados
              INSERT INTO OPEN.CARTREFI(
                CARENUSE,
                CAREDATE,
                CAREPLAN,
                CAREINIC,
                CAREDIFE,
                CARECAPI,
                CAREFINA,
                CARECONS,
                CARECOM3,
                CAREBASI,
                CARECONT,
                CARECIVA,
                CAREMORA,
                CARESUBS,
                CAREPAGO,
                CARENTDB,
                CARENTCR,
                CAREVENC,
                CAREFDIF,
                CARENREF,
                CAREDFNB,
                CAREPOLI,
                CAREMARC,
                CAREDIRE,
                CAREVARI
              )
              VALUES(
                tbData(nuIndex).CARENUSE,
                tbData(nuIndex).CAREDATE,
                tbData(nuIndex).CAREPLAN,
                tbData(nuIndex).CAREINIC,
                nudifre,
                nuvalcap,
                nuvalfin,
                nuvalcon,
                nuvalom3,
                nuvalcar,
                nuvalcot,
                nuvaliva,
                nuvalmor,
                nuvalsub,
                nuvalpag,
                nuvalndb,
                nuvalncr,
                nucarfin,
                nucarfind,
                nuvalnref,
                nuvaldfnb,
                nuvalpoli,
                nucarmar,
                nuvaldrnx,
                nuvaldsev
              );
              EXCEPTION
                WHEN OTHERS THEN
                  sbMens := ' Error: ' || sqlerrm;
                  --ldc_proactualizaestaprog(nusession,SUBSTR('FALLO INSERCION: '||sbMens,1,2000),'LDC_PRAnaRefinanOSF','con Error');
                  INSERT INTO OPEN.LDC_OSF_PROERROR
                   (perini, perfin, producto, contrato, numcaso, mensaje)
                  VALUES
                   (nuperini, nuperfin, tbData(nuIndex).CARENUSE, tbData(nuIndex).SESUSUSC, 4, sbMens);

                  GOTO SALTAR;
              END;
              --ut_trace.trace(SYSDATE||' INSERT CARTREFI', 15);
              --Control de commit cada 100 registros
              nuCont := nuCont + 1;
              IF (nuCont >= 300) THEN
                COMMIT;
                nuCont := 0;
              END IF;

          <<SALTAR>>
          NULL;

          END LOOP;
    END IF;
    EXIT WHEN (cuRefinan%notfound);
    END LOOP;
    CLOSE cuRefinan ;

    COMMIT;

    ldc_proactualizaestaprog(nusession,'Finalizo correctamente','LDC_PRAnaRefinanOSF','OK');

  --ut_trace.trace(SYSDATE||' FIN', 15);
  EXCEPTION
    WHEN OTHERS THEN
        sbMens := ' Error: ' || sqlerrm;
        ldc_proactualizaestaprog(nusession,SUBSTR('FALLO GENERAL: '||sbMens,1,2000),'LDC_PRAnaRefinanOSF','con Error');

  END;

END LDC_PKAnaRefinanOSF;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKANAREFINANOSF
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKANAREFINANOSF', 'ADM_PERSON'); 
END;
/  
