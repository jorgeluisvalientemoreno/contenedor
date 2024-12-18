CREATE OR REPLACE PACKAGE LDC_PKDATAFACTREG IS

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : LDC_PKDATAFACTREG
    Descripcion    : Paquete extractor de datos para del Formato(#262) Factura reguladas spool
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    20/11/2017      JBRITO              Creacion.
    ******************************************************************/

  PROCEDURE GET_DATOSCLIENTE(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_BRILLA(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_CONSUMOHISTO(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_DATOSLECTURA(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_DATOSCONSUMOS(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_DATOSREVISION(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_TOTALES(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_CARGOS(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_RANGOS(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_RANGOS_DOS(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_COMPCOST(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_CUPON(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_BARCODE(orfcursor Out constants.tyRefCursor);


END LDC_PKDATAFACTREG;
/
CREATE OR REPLACE PACKAGE BODY LDC_PKDATAFACTREG
IS

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : LDC_PKDATAFACTREG
    Descripcion    : Paquete extractor de datos para del Formato(#262) Factura reguladas spool
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    20/11/2017      JBRITO              Creacion.
    ******************************************************************/

  PROCEDURE GET_DATOSCLIENTE(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'FAC_NO|F_D_EMISON|MES_FAC|PERIODO_FACT|F_D_VENC|DIAS_CONSUMO|'||
                    'COD_DE_SERVICIO|CUPON|NOMBRE_SUSC|DIR_ENTREGA|LOCALIDAD|USO|ESTRATO|'||
                    'CICLO|RUTA|MESES_DEUDA|NUM_CONTROL|PERIODO_CONSUMO|SALDO_A_FAVOR|SALDO_ANT|'||
                    'FECHA_SUSPENSION|VALOR_RECL|TOTAL_A_PAGAR|PAGO_SIN_RECARGO|'||
                    'CONDICION_PAGO|IDENTIFICA|TIPO_DE_PRODUCTO|';
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsHorizont('|'
                                                    ,'FAC_NO'
                                                    ,'TIPO_DE_PRODUCTO'
                                                    ,CAMPOS
                                                    ,QUERYS);

        OPEN orfcursor FOR
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT FAC_NO, F_D_EMISON, MES_FAC, PERIODO_FACT, F_D_VENC, DIAS_CONSUMO, COD_DE_SERVICIO,
                  CUPON, NOMBRE_SUSC, DIR_ENTREGA, LOCALIDAD, USO, ESTRATO, CICLO, RUTA, MESES_DEUDA, NUM_CONTROL,
                  PERIODO_CONSUMO, SALDO_A_FAVOR, SALDO_ANT, FECHA_SUSPENSION, VALOR_RECL, TOTAL_A_PAGAR,
                  PAGO_SIN_RECARGO, CONDICION_PAGO, IDENTIFICA, TIPO_DE_PRODUCTO
          FROM testdata';


  EXCEPTION
    WHEN OTHERS THEN
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_DATOSCLIENTE;

  PROCEDURE GET_BRILLA(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'CUPO_DISPONIBLE|';
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsHorizont('|'
                                                    ,'CUPO_DISPONIBLE'
                                                    ,'CUPO_DISPONIBLE'
                                                    ,CAMPOS
                                                    ,QUERYS);

        OPEN orfcursor FOR
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT CUPO_DISPONIBLE FROM testdata';

  EXCEPTION
    WHEN OTHERS THEN
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_BRILLA;

  PROCEDURE GET_CONSUMOHISTO(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'CONSUMO|MES|';
    BEGIN
       LDC_PKDATAFIXUPDEDDOCU.splitStringsVertical('|'
                                                    ,'CONSUMO1'
                                                    ,'MES6'
                                                    ,CAMPOS
                                                    ,1
                                                    ,'ORDEN'
                                                    ,QUERYS);

        open orfcursor for
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT CONSUMO, MES
          FROM testdata
          ORDER BY ORDEN DESC';

  EXCEPTION
    WHEN OTHERS THEN
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_CONSUMOHISTO;

  PROCEDURE GET_DATOSLECTURA(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'NO_MEDIDOR|LEC_ANT|LEC_ACTUAL|CAUSA_N_LEC|';
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsHorizont('|'
                                                    ,'NO_MEDIDOR'
                                                    ,'CAUSA_N_LEC'
                                                    ,CAMPOS
                                                    ,QUERYS);

        OPEN orfcursor FOR
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT NO_MEDIDOR,LEC_ANT,LEC_ACTUAL,CAUSA_N_LEC
          FROM testdata';

  EXCEPTION
    WHEN others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_DATOSLECTURA;

  PROCEDURE GET_DATOSCONSUMOS(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'CONSUMO|F_CORREC|CONSUMO1|MES1|CONSUMO2|MES2|CONSUMO3|MES3|'||
                    'CONSUMO4|MES4|CONSUMO5|MES5|CONSUMO6|MES6|'||
                    'PROM_CONSUMO|TEMPERATURA|PRESION|CONS_KW|CALCULO_CONS|';
    BEGIN
       LDC_PKDATAFIXUPDEDDOCU.splitStringsHorizont('|'
                                                    ,'CONSUMO'
                                                    ,'CALCULO_CONS'
                                                    ,CAMPOS
                                                    ,QUERYS);

        open orfcursor for
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT CONSUMO, F_CORREC, CONSUMO1, MES1, CONSUMO2, MES2, CONSUMO3, MES3,
                CONSUMO4, MES4, CONSUMO5, MES5, CONSUMO6, MES6, PROM_CONSUMO, TEMPERATURA,
                PRESION, CONS_KW, CALCULO_CONS
          FROM testdata';

  EXCEPTION
    WHEN others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_DATOSCONSUMOS;

  PROCEDURE GET_DATOSREVISION(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'TIPO_NOTI|MENSGNRAL1|FECH_MAXIMA|FECH_SUSP|';
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsHorizont('|'
                                                    ,'TIPO_NOTI'
                                                    ,'FECH_SUSP'
                                                    ,CAMPOS
                                                    ,QUERYS);

        open orfcursor for
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT TIPO_NOTI,MENSGNRAL1,FECH_MAXIMA,FECH_SUSP
          FROM testdata';

  EXCEPTION
    WHEN others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_DATOSREVISION;


  PROCEDURE GET_TOTALES(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'TOTAL|IVA|SUBTOTAL|CARGOSMES|CANTIDAD_CONC|';
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsHorizont('|'
                                                    ,'TOTAL'
                                                    ,'CANTIDAD_CONC'
                                                    ,CAMPOS
                                                    ,QUERYS);

        OPEN orfcursor FOR
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT TOTAL, IVA, SUBTOTAL, CARGOSMES, CANTIDAD_CONC
          FROM testdata';

  EXCEPTION
    WHEN OTHERS THEN
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_TOTALES;

  PROCEDURE GET_CARGOS(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsVertical('|'
                                                    ,'DESC_CONCEP1'
                                                    ,'CUOTAS78'
                                                    ,'DESC_CONCEP|SALDO_ANT|CAPITAL|INTERES|TOTAL|SALDO_DIF|CUOTAS|'
                                                    ,1
                                                    ,'ETIQUETA'
                                                    ,QUERYS);

        OPEN orfcursor FOR
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT ETIQUETA,DESC_CONCEP,SALDO_ANT,CAPITAL,INTERES,TOTAL,SALDO_DIF,CUOTAS
          FROM testdata
          WHERE DESC_CONCEP IS NOT NULL
          ORDER BY ETIQUETA ASC';

  EXCEPTION
    WHEN OTHERS THEN
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_CARGOS;

  PROCEDURE GET_RANGOS(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'LIM_INFERIOR|LIM_SUPERIOR|VALOR_UNIDAD|RCONSUMO|VAL_CONSUMO|';
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsVertical('|'
                                                    ,'LIM_INFERIOR1'
                                                    ,'VAL_CONSUMO7'
                                                    ,CAMPOS
                                                    ,1
                                                    ,'ORDEN'
                                                    ,QUERYS);

        open orfcursor for
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT LIM_INFERIOR, LIM_SUPERIOR, VALOR_UNIDAD, RCONSUMO, VAL_CONSUMO
          FROM testdata
          ORDER BY ORDEN ASC';

  EXCEPTION
    WHEN others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_RANGOS;

  PROCEDURE GET_RANGOS_DOS(orfcursor Out constants.tyRefCursor) IS

    BEGIN
        open orfcursor for
         SELECT ' ' LIM_INFERIOR1,
                   ' ' LIM_SUPERIOR1,
                   ' ' VALOR_UNIDAD1,
                   ' ' CONSUMO1,
                   ' ' VAL_CONSUMO1,
                   ' ' LIM_INFERIOR2,
                   ' ' LIM_SUPERIOR2,
                   ' ' VALOR_UNIDAD2,
                   ' ' CONSUMO2,
                   ' ' VAL_CONSUMO2,
                   ' ' LIM_INFERIOR3,
                   ' ' LIM_SUPERIOR3,
                   ' ' VALOR_UNIDAD3,
                   ' ' CONSUMO3,
                   ' ' VAL_CONSUMO3,
                   ' ' LIM_INFERIOR4,
                   ' ' LIM_SUPERIOR4,
                   ' ' VALOR_UNIDAD4,
                   ' ' CONSUMO4,
                   ' ' VAL_CONSUMO4,
                   ' ' LIM_INFERIOR5,
                   ' ' LIM_SUPERIOR5,
                   ' ' VALOR_UNIDAD5,
                   ' ' CONSUMO5,
                   ' ' VAL_CONSUMO5,
                   ' ' LIM_INFERIOR6,
                   ' ' LIM_SUPERIOR6,
                   ' ' VALOR_UNIDAD6,
                   ' ' CONSUMO6,
                   ' ' VAL_CONSUMO6,
                   ' ' LIM_INFERIOR7,
                   ' ' LIM_SUPERIOR7,
                   ' ' VALOR_UNIDAD7,
                   ' ' CONSUMO,
                   ' ' VAL_CONSUMO7
            FROM   dual;

  EXCEPTION
    WHEN others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_RANGOS_DOS;

  PROCEDURE GET_COMPCOST(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'COMPCOST|VALORESREF|VALCALC|';
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsHorizont('|'
                                                    ,'COMPCOST'
                                                    ,'VALCALC'
                                                    ,CAMPOS
                                                    ,QUERYS);

        open orfcursor for
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT COMPCOST,VALORESREF,VALCALC
          FROM testdata';

  EXCEPTION
    WHEN others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_COMPCOST;

  PROCEDURE GET_CUPON(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'CODIGO_1|CODIGO_2|CODIGO_3|CODIGO_4|CODIGO_BARRAS|';
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsHorizont('|'
                                                    ,'CODIGO_1'
                                                    ,'CODIGO_BARRAS'
                                                    ,CAMPOS
                                                    ,QUERYS);

        open orfcursor for
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT CODIGO_1,CODIGO_2,CODIGO_3,CODIGO_4,CODIGO_BARRAS
          FROM testdata';

  EXCEPTION
    WHEN others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_CUPON;

  PROCEDURE GET_BARCODE(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'CODIGO_1|CODIGO_2|CODIGO_3|CODIGO_4|';
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsHorizont('|'
                                                    ,'CODIGO_1'
                                                    ,'CODIGO_4'
                                                    ,CAMPOS
                                                    ,QUERYS);

        open orfcursor for
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT TO_CHAR(415) || CODIGO_1 || TO_CHAR(820) || CODIGO_2 || chr(200) || TO_CHAR(3900) || CODIGO_3 || chr(200) || TO_CHAR(96) || CODIGO_4 CODE,
                   NULL IMAGE
          FROM testdata';

  EXCEPTION
    WHEN others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_BARCODE;


END LDC_PKDATAFACTREG;
/
GRANT EXECUTE on LDC_PKDATAFACTREG to SYSTEM_OBJ_PRIVS_ROLE;
/
