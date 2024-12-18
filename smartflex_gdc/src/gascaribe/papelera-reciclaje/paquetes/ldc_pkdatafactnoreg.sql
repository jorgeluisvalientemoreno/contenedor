CREATE OR REPLACE PACKAGE LDC_PKDATAFACTNOREG IS

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : LDC_PKDATAFACTNOREG
    Descripcion    : Paquete extractor de datos para del Formato(#263) Factura NO reguladas spool
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    20/11/2017      JBRITO              Creacion.
    ******************************************************************/

  PROCEDURE GET_DATOSCLIENTE(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_DATOSREVISION(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_SUBTOTALES(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_CARGOS(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_CUPON(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_BARCODE(orfcursor Out constants.tyRefCursor);
  PROCEDURE GET_TASASCAMBIO(orfcursor Out constants.tyRefCursor);

END LDC_PKDATAFACTNOREG;
/
CREATE OR REPLACE PACKAGE BODY LDC_PKDATAFACTNOREG
IS

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : LDC_PKDATAFACTNOREG
    Descripcion    : Paquete extractor de datos para del Formato(#263) Factura NO reguladas spool
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



  PROCEDURE GET_SUBTOTALES(orfcursor Out constants.tyRefCursor) IS

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
  END GET_SUBTOTALES;


  PROCEDURE GET_CARGOS(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsVertical('|'
                                                    ,'DESC_CONCEP1'
                                                    ,'CUOTAS78'
                                                    ,'DESC_CONCEP|SALDO_ANT|CAPITAL|INTERES|TOTAL|SALDO_DIF|CUOTAS|'
                                                    ,1
                                                    ,'ORDEN'
                                                    ,QUERYS);

        OPEN orfcursor FOR
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT 35 ETIQUETA,DESC_CONCEP,SALDO_ANT,CAPITAL,INTERES,TOTAL,SALDO_DIF,CUOTAS
          FROM testdata
          WHERE (DESC_CONCEP IS NOT NULL
          OR SALDO_ANT IS NOT NULL
          OR CAPITAL IS NOT NULL
          OR INTERES IS NOT NULL
          OR TOTAL IS NOT NULL
          OR SALDO_DIF IS NOT NULL
          OR CUOTAS IS NOT NULL)
          ORDER BY ORDEN ASC';

  EXCEPTION
    WHEN OTHERS THEN
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_CARGOS;



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


  PROCEDURE GET_TASASCAMBIO(orfcursor Out constants.tyRefCursor) IS

    QUERYS CLOB;
    CAMPOS CLOB := 'TASA_ULTIMA|TASA_PROMEDIO|';
    BEGIN
        LDC_PKDATAFIXUPDEDDOCU.splitStringsHorizont('|'
                                                    ,'TASA_ULTIMA'
                                                    ,'TASA_PROMEDIO'
                                                    ,CAMPOS
                                                    ,QUERYS);

        open orfcursor for
         'WITH testdata AS(  '||to_char(QUERYS)||'  )
          SELECT TASA_ULTIMA, TASA_PROMEDIO
          FROM testdata';

  EXCEPTION
    WHEN others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END GET_TASASCAMBIO;



END LDC_PKDATAFACTNOREG;
/
GRANT EXECUTE on LDC_PKDATAFACTNOREG to SYSTEM_OBJ_PRIVS_ROLE;
/
