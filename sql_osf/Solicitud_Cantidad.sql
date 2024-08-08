select mp.Package_Type_Id || ' - ' || MA.DESCRIPTION Solicitud,
       max(mp.request_date) Fecha_ultima_solicitud,
       COUNT(*) TOTAL
/*select NVL(TO_CHAR(mp.Package_Type_Id), 'TOTAL') Solicitud,
       DECODE(NVL(TO_CHAR(mp.Package_Type_Id), 'TOTAL'),
              'TOTAL',
              'TOTAL',
              NVL(MA.DESCRIPTION, 'SUBTOTAL')) Descripcion,
       COUNT(*) TOTAL
*/
  FROM open.mo_packages mp
 INNER JOIN OPEN.PS_PACKAGE_TYPE MA
    ON MP.Package_Type_Id = MA.PACKAGE_TYPE_ID
-- GROUP BY ROLLUP(mp.Package_Type_Id, MA.DESCRIPTION);
 GROUP BY mp.Package_Type_Id, MA.DESCRIPTION;
