--validar_cierre_comercial
select cc.tipo_producto,
       cc.nuano,
       cc.numes,
       cc.contrato,
       cc.producto,
       cc.edad_deuda,
       cc.nro_ctas_con_saldo,
       cc.flag_valor_reclamo,
       cc.sesusape,
       cc.valor_reclamo,
       cc.deuda_corriente_vencida,
       cc.deuda_no_corriente,
       cc.deuda_diferida_corriente,
       cc.deuda_diferida_no_corriente,
       cc.saldo_favor
from ldc_osf_sesucier  cc
where cc.nuano = 2024
and   cc.numes = 8
and   cc.producto in (1058785,1061866,1062663,1147674)

--and   cc.edad_deuda > 90
/*and   cc.nro_ctas_con_saldo >= 3
order by cc.contrato, cc.edad_deuda*/


--and   cc.producto in (50557303,50013948,52565629,50343029,50958050,8093482,50060700,50035747,50466703,50788051,17120835)
