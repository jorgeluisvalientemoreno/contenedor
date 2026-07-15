select *
 from gasgg.contrato  cg
 where contcuad = 406
  and cg.contfete > sysdate;
  
  
  select *
  from migragg.ge_contrato
  where descripcion like '%406%'; 
  
  --Grupo contratista 2310 , 9683  ( ejemplo ) 
