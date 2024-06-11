declare

cursor cuDatos is

SELECT cu.OPERATING_UNIT_ID,open.daor_operating_unit.fsbgetname(a.operating_unit_id) , cu.ITEMS_ID,  



        a.balance, 



		(select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_act, 



		(select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_inv,



        a.total_costs, 



		(select total_costs from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id)cost_act, 



		(select total_costs from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cost_inv,



       SUM(CANTIDAD_ACTIVO) CANTIDAD_ACTIVO ,SUM(VALOR_ACTIVO) VALOR_ACTIVO,



       SUM(CANTIDAD_INV) CANTIDAD_INV ,SUM(VALOR_INVEN) VALOR_INVEN,



       SUM(CANTIDAD_X) CANTIDAD_X ,SUM(VALOR_X) VALOR_X,



       SUM(CANTIDAD_AJUSTE) CANTIDAD_AJUSTE ,SUM(VALOR_AJUSTE) VALOR_AJUSTE



FROM (



SELECT OPERATING_UNIT_ID, ITEMS_ID,  



       SUM(DECODE(CLASIFICACION, 'A', CANTIDAD,0)) CANTIDAD_ACTIVO, SUM(DECODE(CLASIFICACION, 'A', VALOR,0))  VALOR_ACTIVO,



       SUM(DECODE(CLASIFICACION, 'I', CANTIDAD,0)) CANTIDAD_INV, SUM(DECODE(CLASIFICACION, 'I', VALOR,0))  VALOR_INVEN,



       SUM(DECODE(CLASIFICACION, 'X', CANTIDAD,0)) CANTIDAD_X, SUM(DECODE(CLASIFICACION, 'X', VALOR,0))  VALOR_X,



       SUM(DECODE(CLASIFICACION, 'AJUSTE', CANTIDAD,0)) CANTIDAD_AJUSTE, SUM(DECODE(CLASIFICACION, 'AJUSTE', VALOR,0))  VALOR_AJUSTE



FROM (



SELECT O.OPERATING_UNIT_ID, ITEMS_ID, 



                       (CASE WHEN o.movement_type = 'D' 



                        AND o.item_moveme_caus_id = 4 



                        THEN



                        (SELECT tt.warehouse_type



                           FROM open.ldc_tt_tb tt, open.or_order oo



                          WHERE oo.order_id = d.documento_externo



                            AND oo.task_type_id =tt.task_type_id 



                        )



                        



                        WHEN open.daor_operating_unit.fnugetoper_unit_classif_id(o.target_oper_unit_id,null)=11 



                         AND open.daor_operating_unit.fsbgetname(o.target_oper_unit_id,null) like '%ACTIVO%' THEN 'A'



                       --



                        WHEN open.daor_operating_unit.fnugetoper_unit_classif_id(o.target_oper_unit_id,null)=11 



                         AND open.daor_operating_unit.fsbgetname(o.target_oper_unit_id,null) like '%INVENTARIO%' THEN 'I'



                        --



                        WHEN d.causal_id=3368 THEN 'A'  



                        WHEN d.causal_id=3369 THEN 'I'



                        WHEN ITEMS_ID=10004070 THEN 'I'



                        WHEN d.document_type_id=113  then



                          'AJUSTE'  



                   ELSE 'X' END   



                  ) clasificacion , 



                  sum(decode(movement_type,'D',-1,1)*o.amount) CANTIDAD, sum(decode(movement_type,'D',-1,1)*o.total_value ) VALOR



             FROM open.or_uni_item_bala_mov o  left join 



                  open.ge_items_documento   d  on (o.id_items_documento = d.id_items_documento)



            WHERE items_id not like '4%'



              AND ITEMS_ID NOT IN (100003008, 100003011)



              --and items_id=10005003



              and o.operating_unit_id in (3109,3194,1927,3113,1854,3119,3096,3019,1870,3091,1856,3098,3000,1850,3233,3331,3349,2025,3223,3116,3020,3005,1869,3083,3008,3011,

											1981,3130,3082,2344,2365,2343,2027,1878,2410,2458,2340,2228,2366,3010,3004,2155,1928,3035,2239,3039,3346,2229,3002)



              and o.movement_type in ('I','D')



group by  O.OPERATING_UNIT_ID, ITEMS_ID, o.movement_type,document_type_id, o.item_moveme_caus_id , d.causal_id,o.target_oper_unit_id, d.documento_externo, O.ID_ITEMS_DOCUMENTO

)

GROUP BY OPERATING_UNIT_ID, ITEMS_ID

UNION all

SELECT B.CUADHOMO OPERATING_UNIT_ID, I.ITEMS_ID ITEMS_ID,  

       SUM(DECODE(EIXBTIPO, 'A', EIXBDISU,0)) CANTIDAD_ACTIVO, SUM(DECODE(EIXBTIPO, 'A', EIXBVLOR,0))  VALOR_ACTIVO,

       SUM(DECODE(EIXBTIPO, 'I', EIXBDISU,0)) CANTIDAD_INV, SUM(DECODE(EIXBTIPO, 'I', EIXBVLOR,0))  VALOR_INVEN,

       SUM(DECODE(EIXBTIPO, 'X', EIXBDISU,0)) CANTIDAD_X, SUM(DECODE(EIXBTIPO, 'X', EIXBVLOR,0))  VALOR_X,

       SUM(DECODE(EIXBTIPO, 'AJUSTE', EIXBDISU,0)) CANTIDAD_AJUSTE, SUM(DECODE(EIXBTIPO, 'X', EIXBVLOR,0))  VALOR_AJUSTE

       FROM MIGRA.LDC_TEMP_EXITEBOD_SGE A, MIGRA.LDC_MIG_CUADCONT B, OPEN.GE_ITEMS I

      WHERE A.EIXBBCUA = B.CUADCODI

        AND A.BASEDATO = B.BASEDATO

        and B.CUADHOMO in (3109,3194,1927,3113,1854,3119,3096,3019,1870,3091,1856,3098,3000,1850,3233,3331,3349,2025,3223,3116,3020,

						3005,1869,3083,3008,3011,1981,3130,3082,2344,2365,2343,2027,1878,2410,2458,2340,2228,2366,3010,3004,2155,1928,3035,

						2239,3039,3346,2229,3002)

        and nvl(MIGRA.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0)=I.ITEMS_ID

GROUP BY B.CUADHOMO, I.ITEMS_ID ) cu, OPEN.OR_OPE_UNI_ITEM_BALA a 

where cu.operating_unit_id=a.operating_unit_id

and cu.items_id=a.items_id

and a.balance!=nvl((select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id), 0)+

    nvl((select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id),0)

and a.items_id not like '4%'

and a.items_id not in (100003008 , 100003011)

and a.operating_unit_id not in (799,77)

having SUM(CANTIDAD_X) =0

  and  SUM(VALOR_X) = 0

  and  SUM(CANTIDAD_AJUSTE)=0

  and SUM(VALOR_AJUSTE)=0

GROUP BY cu.OPERATING_UNIT_ID, cu.ITEMS_ID, a.balance, a.total_costs, a.items_id, a.operating_unit_id;



begin



	for reg in cuDatos loop



		update open.ldc_act_ouib a 



		   set a.balance=reg.CANTIDAD_ACTIVO, 



		       a.total_costs= reg.VALOR_ACTIVO



		 where a.operating_unit_id= reg.operating_unit_id 



		   and a.items_id=reg.items_id;



		   



		update open.ldc_inv_ouib a 



		   set a.balance=reg.CANTIDAD_INV, 



		       a.total_costs= reg.VALOR_INVEN



		 where a.operating_unit_id= reg.operating_unit_id 



		   and a.items_id=reg.items_id;



       commit;



	end loop;



end;



/



