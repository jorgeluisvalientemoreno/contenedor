select *
  from open.estaprog
 where esprfein >= '02/01/2024'
 and esprprog like '%ICBGHE%'  --hechos economicos 
 order by esprfein desc;
