-- Estado de programas
SELECT * FROM open.estaprog
 WHERE esprfein BETWEEN '30-08-2024' AND '30-08-2024 23:59:59'
   --AND esprprog LIKE 'ICB%SC%'     /* Hechos Economicos de Servicios Cumplidos */
   --AND esprprog LIKE '%FGRR%'      /* Resumen de Recaudo* /
   --AND esprprog LIKE '%ICBGHE%'    /* Hechos Economicos */
   --AND esprprog LIKE '%LISIM%'     /* Hechos Economicos LISIM*/
   AND esprprog LIKE '%ICBGRC%'    /* Generacion Registros Contables */
   --AND esprprog LIKE 'ICBGIC%'      /* Cierre de Cartera   */
   --AND esprprog LIKE '%RPHE%'
   --AND esprporc <> 100   
   --AND esprtapr <> 0
ORDER BY esprfein DESC;
/*
select * from open.concproc
 where coprfere >= '08-08-2024 06:00:00' and coprfere <= '09-08-2024 23:59:59' and coprprog = 'ICBGRC' and  coprpara like '73|%'
*/
