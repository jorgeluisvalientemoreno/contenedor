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
     where iu.items_id = i.items_id and iu.operating_unit_id in (4642))
   and   m.habilitado = 'S'
   and m.material in (10000048)
   order by i.description

/*select *
from personalizaciones.materiales m
where m.material in (10000974,10004204,10000933,10011187)*/

  -- and m.material in (10000933,10000766,10004204,10002017)
     
/*  
BEGIN
    INSERT INTO personalizaciones.materiales (MATERIAL, EMPRESA, HABILITADO)
    VALUES (10000037, 'GDGU', 'S');
END;
/*/
   
/*update personalizaciones.materiales m set m.empresa = NULL where m.material in (10009105)

,10000119)*/
/*update personalizaciones.materiales m set m.habilitado = 'S' where m.material in (10006517) and m.empresa = 'GDCA'*/

--and m.empresa = 'GDGU'

   --and m.empresa = 'GDCA'
   
   --and m.habilitado = 'S'
   
--GDCA=  10000933,10000766,10004204,10002017
--GDGU=  10000037, 10005352, 10004070


--4642 GDCA
--4858 GDGU

/*
BEGIN
  UPDATE personalizaciones.materiales m 
  SET m.empresa = NULL 
  WHERE m.material = 10009105;

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;*/
