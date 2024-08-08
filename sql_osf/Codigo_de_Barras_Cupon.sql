SELECT codigo_1,
       codigo_2,
       codigo_3,
       codigo_4,
       CASE
         WHEN codigo_3 IS NOT NULL THEN
          '(415)' || codigo_1 || '(8020)' || codigo_2 || '(3900)' ||
          codigo_3 || '(96)' || codigo_4
         ELSE
          NULL
       END codigo_barras
  FROM (SELECT /*sbcodigoean*/
         dald_parameter.fsbGetValue_Chain('COD_EAN_CODIGO_BARRAS') codigo_1,
         lpad(cuponume, 10, '0') codigo_2,
         lpad(round(cupovalo), 10, '0') codigo_3,
         to_char(add_months(cucofeve, 120), 'yyyymmdd') codigo_4
          FROM factura, cuencobr, cupon
         WHERE factcodi = 328692661 --sbFactcodi
           AND cupodocu = factcodi
           AND cuponume = 604940996 --pkbobillprintheaderrules.fsbgetcoupon()
           AND factcodi = cucofact
        UNION
        SELECT NULL, ' ', NULL, ' '
          FROM dual)
 WHERE rownum = 1;
--cupon con factura tipo FA
select t.*, t.rowid from cupon t
