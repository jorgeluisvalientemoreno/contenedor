-- Estado de programas
SELECT * FROM open.estaprog
 WHERE esprfein BETWEEN '05/10/2015 00:00:00' AND '05/10/2015 23:59:59'
   --AND esprprog LIKE '%FGRR%'    /* Resumen de Recaudo* /
   --AND esprprog LIKE '%ISC%'     /* Hechos Economicos de Servicios Cumplidos */
   --AND esprprog LIKE '%ICBGHE%'  /* Hechos Economicos */
   --AND esprprog LIKE '%FPH%'       /* Hechos Provision Facturacion */
   AND esprprog LIKE '%ICBGRC%'  /* Generacion Registros Contables */
   --AND esprporc <> 100   --AND esprtapr <> 0
ORDER BY esprfein DESC;
