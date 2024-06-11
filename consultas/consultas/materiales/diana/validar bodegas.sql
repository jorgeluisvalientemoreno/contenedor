with base as(select distinct b3.fec_corte fecha1, (select min(b4.fec_corte) from OPEN.LDC_OSF_LDCRBAI b4 where b4.fec_corte= last_day(b3.fec_corte)+1) fecha2
  from OPEN.LDC_OSF_LDCRBAI b3

 where to_char(b3.fec_corte,'dd')='01'
  and b3.fec_corte>='01/01/2021'
 order by fec_corte)
SELECT b1.fec_corte,
       b1.cod_unid_oper, b1.cod_item, i.description, i.item_classif_id,  b1.cant_exist_bodega, b1.cant_exist_activo, b1.cant_exist_inven,
       b2.fec_corte,
       b2.cant_exist_bodega, b2.cant_exist_activo, b2.cant_exist_inven
FROM OPEN.LDC_OSF_LDCRBAI b1
inner join open.ge_items i on i.items_id=b1.cod_item
inner join OPEN.LDC_OSF_LDCRBAI b2 on b2.cod_unid_oper=b1.cod_unid_oper and b2.cod_item= b1.cod_item 
INNER JOIN base B on b.fecha1=b1.fec_corte and b.fecha2=b2.fec_corte
where b1.fec_corte >='01/01/2015'
 and trunc(b1.fec_corte) in (LAST_DAY( b1.fec_corte ), to_date('01/'||to_char(b1.fec_corte,'mm/yyyy'),'dd/mm/yyyy'))
 and b1.cod_unid_oper=2680
 and b1.cod_item=10002823
 and b1.cant_exist_bodega=(b1.cant_exist_activo+b1.cant_exist_inven)
 and b2.cant_exist_bodega!=(b2.cant_exist_activo+b2.cant_exist_inven) 
 and b2.fec_corte= last_day(b1.fec_corte)+1
