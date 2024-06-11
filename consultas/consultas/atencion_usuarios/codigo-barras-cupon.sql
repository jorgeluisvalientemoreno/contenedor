            SELECT LDC_BOFORMATOFACTURA.fnuObtNCuentaSaldo (sesunuse)                        n_cuentas_saldo,
                   TO_CHAR (ADD_MONTHS (SYSDATE, -5), 'MON', 'NLS_DATE_LANGUAGE = SPANISH')  mes_6,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa, factcodi, 5)           consumo_6,
                   TO_CHAR (ADD_MONTHS (SYSDATE, -4), 'MON', 'NLS_DATE_LANGUAGE = SPANISH')  mes_5,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa, factcodi, 4)           consumo_5,
                   TO_CHAR (ADD_MONTHS (SYSDATE, -3), 'MON','NLS_DATE_LANGUAGE = SPANISH')   mes_4,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa, factcodi, 3)           consumo_4,
                   TO_CHAR (ADD_MONTHS (SYSDATE, -2), 'MON', 'NLS_DATE_LANGUAGE = SPANISH')  mes_3,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa, factcodi, 2)           consumo_3,
                   TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MON', 'NLS_DATE_LANGUAGE = SPANISH')  mes_2,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa, factcodi,  1)          consumo_2,
                   TO_CHAR (SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = SPANISH')                   mes_1,
                   LDC_BOFORMATOFACTURA.fnuGetConsumoAtras (factpefa,  factcodi, 0)          consumo_1,
                   TO_CHAR (factfege, 'dd/MON/yyyy', 'NLS_DATE_LANGUAGE = SPANISH')          fecha_facturacion,
                   ONUCUPONUME cupon_referencia,
                   CASE
                       WHEN (LDC_BOFORMATOFACTURA.fsbPagoInmediato (sesunuse) = 1) THEN 'INMEDIATO'
                       WHEN (sbInmediata = 'INMEDIATO') THEN 'INMEDIATO'
                       ELSE TO_CHAR (pefaffpa,'dd/MON/yyyy', 'NLS_DATE_LANGUAGE = SPANISH')
                   END fecha_pag_recargo,
                      '(415)' || '7707232377896' || '(8020)'
                   || LPAD (ONUCUPONUME, 10, '0') || '(3900)'
                   || LPAD (inuSaldoGen, 10, '0') || '(96)'
                   || TO_CHAR (cucofeve, 'yyyymmdd') codigo_barras,
                   fsbCaraCodiBarr128GRQ
                    ('(415)'
                       || '7707232377896' || '(8020)'
                       || LPAD (ONUCUPONUME, 10, '0')|| '(3900)'
                       || LPAD (inuSaldoGen, 10, '0')|| '(96)'
                       || TO_CHAR (cucofeve, 'yyyymmdd')
                      )  ASCII_CODIGO_BARRAS,
                   TO_CHAR ( ROUND (
                           LDC_BOFORMATOFACTURA.fnuValorPosterior ( factcodi)), 'FM999999990')  Sal_Pos_Pago,
                   TO_CHAR ( ROUND (pktblsuscripc.fnugetsuscsafa (factsusc)), 'FM999999990')    Saldo_Favor,
                   DECODE (
                       LDC_BOFORMATOFACTURA.fnuMostrarFechaSuspension (sesususc),
                       1, TO_CHAR (pefaffpa,'dd/MON/yyyy', 'NLS_DATE_LANGUAGE = SPANISH'), NULL) fecha_susp_corte,
                   LDCI_PKFACTKIOSCO_GDC.FSBCONSULTAFECHREV (sesunuse)                           fecha_prox_revi
              FROM factura,
                   servsusc,
                   perifact,
                   cuencobr
             WHERE factsusc = inuSusccodi
               AND factcodi = nuFactura
               AND sesususc = factsusc
               AND cucofact = factcodi
               AND factpefa = pefacodi
               AND ROWNUM = 1;

--ldci_pkfactkiosco_gdc.progenerafact       


SELECT codigo_1
        ,codigo_2
        ,codigo_3
        ,codigo_4
        ,CASE
          WHEN codigo_3 IS NOT NULL THEN
                '(415)' || codigo_1 || '(8020)' || codigo_2 || '(3900)' ||
                 codigo_3 || '(96)' || codigo_4
          ELSE
           NULL
          END codigo_barras
    FROM (
          SELECT '7707232377896' codigo_1
                ,lpad(cuponume, 10, '0') codigo_2
                ,lpad(round(cupovalo), 10, '0') codigo_3
                ,to_char(add_months(cucofeve, 120), 'yyyymmdd') codigo_4
            FROM factura, cuencobr, cupon
           WHERE factcodi = 2108954533
             AND cupodocu = factcodi
             AND cuponume = 213010613
             AND factcodi = cucofact
           UNION
          SELECT NULL, ' ', NULL, ' ' FROM dual
         )
   WHERE rownum = 1;