select * 
from ldc_cartdiaria l , servsusc 
where sesususc = contrato and sesusafa >0
and  estado_financiero ='C' AND nro_ctas_con_saldo =0 
and tipo_producto=7014 ;
