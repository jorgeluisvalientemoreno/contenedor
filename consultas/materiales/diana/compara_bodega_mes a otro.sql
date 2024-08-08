SELECT b1.cod_unid_oper, b1.cod_item, b1.cant_exist_bodega, b1.cant_exist_activo, b1.cant_exist_inven,
                                      b2.cant_exist_bodega, b2.cant_exist_activo, b2.cant_exist_inven
FROM OPEN.LDC_OSF_LDCRBAI b1
inner join OPEN.LDC_OSF_LDCRBAI b2 on b2.cod_unid_oper=b1.cod_unid_oper and b2.cod_item= b1.cod_item and b2.fec_corte='01/04/2022'
where b1.fec_corte in ('01/05/2022')
 and b1.costo_bodega>0
 and b1.cant_exist_bodega=(b1.cant_exist_activo+b1.cant_exist_inven)
 and b2.cant_exist_bodega!=(b2.cant_exist_activo+b2.cant_exist_inven) 
