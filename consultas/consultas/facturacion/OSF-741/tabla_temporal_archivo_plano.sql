select *
from open.ldc_tmp_fpordersdata
where ldc_tmp_fpordersdata.fecha_registro > '20/12/2022 11:30:00'
and ldc_tmp_fpordersdata.nutproductid in (50338277,50050287,50403605,50268224,50010084,51168471,1082731,50039161,1024340,1081410)
