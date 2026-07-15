--item_por_empresa
select m.material,
       i.description,
       m.empresa,
       m.habilitado,
       i.item_classif_id,
       c.description
 from personalizaciones.materiales m
 inner join ge_items  i  on i.items_id = m.material
 inner join ge_item_classif  c  on c.item_classif_id = i.item_classif_id
  where 1=1
  and m.empresa = 'GDCA'
   and exists (select null  
    from or_ope_uni_item_bala  iu 
     where iu.items_id = i.items_id and iu.operating_unit_id in (4642,4858))
   and m.material in (10000238,10000933,10003977, 10007058)
   -- and   m.habilitado = 'N'
   order by i.description
   
/*  
BEGIN
    INSERT INTO personalizaciones.materiales (MATERIAL, EMPRESA, HABILITADO)
    VALUES (10000974, 'GDGU', 'S');
END;
/*/
   
/*update personalizaciones.materiales m set m.empresa = 'GDGU' where m.material in (10000766),10000119)*/
/*update personalizaciones.materiales m set m.habilitado = 'S' where m.material in (10006517) and m.empresa = 'GDCA'*/

--and m.empresa = 'GDGU'

   --and m.empresa = 'GDCA'
   
   --and m.habilitado = 'S'
--10006535,	10004178,	10009105
--10006535,	10000119,	10002055
--10000933,	10000766,	10004204,	10002017  inventario GDCA
--10000933,	10000766, 10006967  activos GDCA
--1500764, 1500769,1500770,1500771,1500772  inventario GDGU
--1500766,1500773,1500774,1500775  activos GDGU
