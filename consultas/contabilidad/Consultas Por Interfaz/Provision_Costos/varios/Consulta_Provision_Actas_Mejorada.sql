select l.celocebe, coprcuad, c.nombre_contratista, coprtitr, description, coprsign, sum(coprvalo) total
  from open.ldci_costprov, open.ge_contratista c, open.OR_TASK_TYPe, open.ldci_centbenelocal l
 where copranoc = 2015
   and coprmesc = 2
   and coprclco in (247,248,253,254,257,258,260,308,309,315,318,394,396,397,413,414)
   and coprcuad = id_contratista 
   and coprtitr = task_type_id
   and coprdepa = celodpto 
   and coprloca = celoloca 
group by l.celocebe, coprcuad, c.nombre_contratista, coprtitr, description, coprsign
