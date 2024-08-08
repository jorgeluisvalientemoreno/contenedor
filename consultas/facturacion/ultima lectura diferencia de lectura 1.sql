select o.order_id, p.product_id, o.operating_unit_id, O.TASK_TYPE_ID
from or_order o, or_order_activity a, pr_product p
where o.order_id=a.order_id
  and o.order_status_id=5
  and a.activity_id= 4000044
  and p.product_id=a.product_id
  and p.product_status_id=1
  AND P.PRODUCT_ID=50086028
  AND EXISTS( select         NULL
        FROM    vw_cmprodconsumptions, LECTELME, PERIFACT, ELMESESU E
            /*+ CM_BCConsumosPorServSusc.Childs_ConsByProduct */
        WHERE   LECTELME.LEEMTCON = 1
        AND     LECTELME.LEEMSESU = vw_cmprodconsumptions.cosssesu
        AND     LECTELME.LEEMPECS = vw_cmprodconsumptions.COSSPECS
        AND     vw_cmprodconsumptions.cosssesu = p.product_id
        and     LECTELME.leemelme = E.EMSSELME --819771
        AND     E.EMSSSESU=P.PRODUCT_ID
        and     cossmecc = 1
        and     LECTELME.leemclec = 'F'
        AND     pecsfecf >= pefafimo
        AND     pecsfecf <= pefaffmo
        AND     PEFAANO=2015
        AND     PEFAMES=6
        AND     PERIFACT.pefacicl = vw_cmprodconsumptions.pecscico
        )
  
  
