select *
  from open.estaprog
 where esprfein between '31-08-2023' and '31-08-2023 23:59:59'
   and esprprog like '%ICBGHE%' /* hechos economicos */
 order by esprfein desc;
