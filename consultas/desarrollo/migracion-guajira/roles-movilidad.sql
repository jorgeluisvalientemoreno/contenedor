declare
  cursor cuDatos is
   with base as (
  select 5005 as ttosf, '4980, 4982, 4108, 4109, 4110, 4188, 4189, 4190, 4296, 4297, 4298, 4299, 4300, 4301, 4289, 4290, 4291, 4292, 4293, 4294, 4295, 4704, 4705, 4706' as unidades, 'movilidad-gestion-de-cartera' as movilidad from dual union all
select 10043 as ttosf, '4938,1888, 1889, 1890, 2217, 2218, 2382, 3571, 3572, 3573, 4006, 4007, 4008, 4439, 4440, 4441, 3662, 4416, 4417, 4418, 4562, 4563, 4564, 3663, 3285, 3286, 3290, 4348, 4347, 3664,1530, 1529, 1531, 1988, 1987' as unidades, 'movilidad-lecturas' as movilidad from dual union all
select 10169 as ttosf, '3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10217 as ttosf, '4916,  4921,  4922,  4923,  4928,  4931,  4939,  4941,  4942,  4944,  4945,  4946,  4948,  4949,  4950,  4951,  4952,  4954,  4955,  4956,  4960,  4962,  4963,  4964,  4966,  4967,  4968,  4969,  4972,  4974, 4416, 4417, 4418, 3285, 3286, 3290, 4347, 4348, 4559, 4560, 4561, 4565, 4566, 4567, 4117, 4550, 4552, 1928, 4332, 4333, 4334, 4335, 4336' as unidades, 'movilidad-estado-tecnico' as movilidad from dual union all
select 10273 as ttosf, 'TODAS' as unidades, 'movilidad-servicios-nuevos' as movilidad from dual union all
select 10278 as ttosf, '4977, 4416, 4417, 4418, 3285, 3286, 3290, 4347, 4348, 4559, 4560, 4561, 4565, 4566, 4567, 4117, 4550, 4552, 1928, 4332, 4333, 4334, 4335, 4336' as unidades, 'movilidad-estado-tecnico' as movilidad from dual union all
select 10450 as ttosf, '3628, 4272, 4277, 4280, 4283, 4604, 4607' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10546 as ttosf, '4977,  4978,  3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10547 as ttosf, '4977,  4978,  3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10547 as ttosf, '4977,  4978,  3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10559 as ttosf, '4977,  4978,  3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10723 as ttosf, '3628, 4272, 4277, 4280, 4283, 4604, 4607, 4926' as unidades, 'movilidad-reparaciones' as movilidad from dual union all
select 10833 as ttosf, '3628, 4272, 4277, 4280, 4283, 4604, 4607, 4926' as unidades, 'movilidad-reparaciones' as movilidad from dual union all
select 10881 as ttosf, '4977,  4978,  3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10882 as ttosf, '4977,  4978,  3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10883 as ttosf, '4977,  4978,  3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10884 as ttosf, '3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10917 as ttosf, '3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10918 as ttosf, '3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10919 as ttosf, '3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 10929 as ttosf, '1888, 1889, 1890, 2217, 2218, 2382, 3571, 3572, 3573, 4006, 4007, 4008, 4439, 4440, 4441, 3662, 4416, 4417, 4418, 4562, 4563, 4564, 3663, 3285, 3286, 3290, 4348, 4347, 3664,1530, 1529, 1531, 1988, 1987' as unidades, 'movilidad-lecturas' as movilidad from dual union all
select 10949 as ttosf, '4916,  4921,  4922,  4923,  4928,  4931,  4939,  4941,  4942,  4944,  4945,  4946,  4948,  4949,  4950,  4951,  4952,  4954,  4955,  4956,  4960,  4962,  4963,  4964,  4966,  4967,  4968,  4969,  4972,  4974, 4416, 4417, 4418, 3285, 3286, 3290, 4347, 4348, 4559, 4560, 4561, 4565, 4566, 4567, 4117, 4550, 4552, 1928, 4332, 4333, 4334, 4335, 4336' as unidades, 'movilidad-estado-tecnico' as movilidad from dual union all
select 11047 as ttosf, '4916,  4921,  4922,  4923,  4928,  4931,  4939,  4941,  4942,  4944,  4945,  4946,  4948,  4949,  4950,  4951,  4952,  4954,  4955,  4956,  4960,  4962,  4963,  4964,  4966,  4967,  4968,  4969,  4972,  4974, 3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11056 as ttosf, '4958,  4959,  3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11057 as ttosf, '4977, 3502, 3504, 3505' as unidades, 'comisiones-ventas' as movilidad from dual union all
select 11144 as ttosf, 'TODAS' as unidades, 'movilidad-servicios-nuevos' as movilidad from dual union all
select 11179 as ttosf, '4916,  4921,  4922,  4923,  4928,  4931,  4939,  4941,  4942,  4944,  4945,  4946,  4948,  4949,  4950,  4951,  4952,  4954,  4955,  4956,  4960,  4962,  4963,  4964,  4966,  4967,  4968,  4969,  4972,  4974, 3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11180 as ttosf, '4916,  4921,  4922,  4923,  4928,  4931,  4939,  4941,  4942,  4944,  4945,  4946,  4948,  4949,  4950,  4951,  4952,  4954,  4955,  4956,  4960,  4962,  4963,  4964,  4966,  4967,  4968,  4969,  4972,  4974, 3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11186 as ttosf, '4916,  4921,  4922,  4923,  4928,  4931,  4939,  4941,  4942,  4944,  4945,  4946,  4948,  4949,  4950,  4951,  4952,  4954,  4955,  4956,  4960,  4962,  4963,  4964,  4966,  4967,  4968,  4969,  4972,  4975, 4958, 4959, 3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11187 as ttosf, '4926, 3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11189 as ttosf, '4926, 3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11190 as ttosf, '4958, 4959, 3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11201 as ttosf, '3628, 4272, 4277, 4280, 4283, 4604, 4607, 4926' as unidades, 'movllidad-reparaciones' as movilidad from dual union all
select 11226 as ttosf, '1888, 1889, 1890, 2217, 2218, 2382, 3571, 3572, 3573, 4006, 4007, 4008, 4439, 4440, 4441, 3662, 4416, 4417, 4418, 4562, 4563, 4564, 3663, 3285, 3286, 3290, 4348, 4347, 3664,1530, 1529, 1531, 1988, 1987' as unidades, 'movilidad-lecturas' as movilidad from dual union all
select 11226 as ttosf, '1888, 1889, 1890, 2217, 2218, 2382, 3571, 3572, 3573, 4006, 4007, 4008, 4439, 4440, 4441, 3662, 4416, 4417, 4418, 4562, 4563, 4564, 3663, 3285, 3286, 3290, 4348, 4347, 3664,1530, 1529, 1531, 1988, 1987' as unidades, 'movilidad-lecturas' as movilidad from dual union all
select 11232 as ttosf, '4916,  4921,  4922,  4923,  4928,  4931,  4939,  4941,  4942,  4944,  4945,  4946,  4948,  4949,  4950,  4951,  4952,  4954,  4955,  4956,  4960,  4962,  4963,  4964,  4966,  4967,  4968,  4969,  4972,  4975, 4958, 4959, 3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11233 as ttosf, '4926, 3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11234 as ttosf, '4958, 4959, 3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11240 as ttosf, '4946, 4950, 3285, 3286, 3290, 4347, 4348, 4419, 4420, 4421, 4416, 4417, 4418, 4559, 4560, 4561, 4565, 4566, 4567, 799' as unidades, 'movilidad-pno' as movilidad from dual union all
select 11259 as ttosf, '4916,  4921,  4922,  4923,  4928,  4931,  4939,  4941,  4942,  4944,  4945,  4946,  4948,  4949,  4950,  4951,  4952,  4954,  4955,  4956,  4960,  4962,  4963,  4964,  4966,  4967,  4968,  4969,  4972,  4974, 3881, 4274, 4279, 4282, 4285, 4606, 4609, 4685, 4696, 4754' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 11269 as ttosf, '1888, 1889, 1890, 2217, 2218, 2382, 3571, 3572, 3573, 4006, 4007, 4008, 4439, 4440, 4441, 3662, 4416, 4417, 4418, 4562, 4563, 4564, 3663, 3285, 3286, 3290, 4348, 4347, 3664,1530, 1529, 1531, 1988, 1987' as unidades, 'movilidad-lecturas' as movilidad from dual union all
select 11302 as ttosf, '4926, 3285, 3286, 3290, 4347, 4348, 4419, 4420, 4421, 4416, 4417, 4418, 4559, 4560, 4561, 4565, 4566, 4567, 799' as unidades, 'movilidad-pno' as movilidad from dual union all
select 11303 as ttosf, '4926, 3285, 3286, 3290, 4347, 4348, 4419, 4420, 4421, 4416, 4417, 4418, 4559, 4560, 4561, 4565, 4566, 4567, 799' as unidades, 'movilidad-pno' as movilidad from dual union all
select 11308 as ttosf, '4322' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 11309 as ttosf, '4977,  4978,  3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 11309 as ttosf, '4977,  4978,  3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 11310 as ttosf, '4977,  4978,  3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 11318 as ttosf, '4946, 4950, 4958, 4959, 3285, 3286, 3290, 4347, 4348, 4419, 4420, 4421, 4416, 4417, 4418, 4559, 4560, 4561, 4565, 4566, 4567, 799' as unidades, 'movilidad-pno' as movilidad from dual union all
select 11324 as ttosf, '4946, 4950, 4958, 4959, 3285, 3286, 3290, 4347, 4348, 4419, 4420, 4421, 4416, 4417, 4418, 4559, 4560, 4561, 4565, 4566, 4567, 799' as unidades, 'movilidad-pno' as movilidad from dual union all
select 11328 as ttosf, '4947, 4957, 3285, 3286, 3290, 4347, 4348, 4419, 4420, 4421, 4416, 4417, 4418, 4559, 4560, 4561, 4565, 4566, 4567, 799' as unidades, 'movilidad-pno' as movilidad from dual union all
select 11345 as ttosf, '4685, 4926' as unidades, 'movilidad-medidores-prepago' as movilidad from dual union all
select 11356 as ttosf, '3285, 3286, 3290, 4347, 4348, 4419, 4420, 4421, 4416, 4417, 4418, 4559, 4560, 4561, 4565, 4566, 4567, 799' as unidades, 'movilidad-pno' as movilidad from dual union all
select 11357 as ttosf, '4947, 4957, 3285, 3286, 3290, 4347, 4348, 4419, 4420, 4421, 4416, 4417, 4418, 4559, 4560, 4561, 4565, 4566, 4567, 799' as unidades, 'movilidad-pno' as movilidad from dual union all
select 12141 as ttosf, '4916,  4921,  4922,  4923,  4928,  4931,  4939,  4941,  4942,  4944,  4945,  4946,  4948,  4949,  4950,  4951,  4952,  4954,  4955,  4956,  4960,  4962,  4963,  4964,  4966,  4967,  4968,  4969,  4972,  4974, 4416, 4417, 4418, 3285, 3286, 3290, 4347, 4348, 4559, 4560, 4561, 4565, 4566, 4567, 4117, 4550, 4552, 1928, 4332, 4333, 4334, 4335, 4336' as unidades, 'movilidad-estado-tecnico' as movilidad from dual union all
select 12149 as ttosf, 'TODAS' as unidades, 'movilidad-servicios-nuevos' as movilidad from dual union all
select 12150 as ttosf, '4252,4594,4595,4253,4250,4251, 4926' as unidades, 'movilidad-servicios-nuevos' as movilidad from dual union all
select 12150 as ttosf, '4252,4594,4595,4253,4250,4251, 4926' as unidades, 'movilidad-servicios-nuevos' as movilidad from dual union all
select 12150 as ttosf, '4252,4594,4595,4253,4250,4251, 4926' as unidades, 'movilidad-servicios-nuevos' as movilidad from dual union all
select 12155 as ttosf, '3628, 4272, 4277, 4280, 4283, 4604, 4607, 4926' as unidades, 'movilidad-reparaciones' as movilidad from dual union all
select 12155 as ttosf, '3628, 4272, 4277, 4280, 4283, 4604, 4607, 4926' as unidades, 'movilidad-reparaciones' as movilidad from dual union all
select 12459 as ttosf, '4416, 4417, 4418, 3285, 3286, 3290, 4347, 4348, 4559, 4560, 4561, 4565, 4566, 4567, 4117, 4550, 4552, 1928, 4332, 4333, 4334, 4335, 4336' as unidades, 'movilidad-estado-tecnico' as movilidad from dual union all
select 12486 as ttosf, '4977,  4978,   3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-verificacion-consumo' as movilidad from dual union all
select 12521 as ttosf, '4977,  4978,   3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 12523 as ttosf, '4977,  4978,   3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 12524 as ttosf, '4977,  4978,   3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 12525 as ttosf, '4977,  4978,   3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 12526 as ttosf, '4977,  4978,   3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 12526 as ttosf, '4977,  4978,   3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 12527 as ttosf, '4977,  4978,   3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 12528 as ttosf, '4977,  4978,   3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 12529 as ttosf, '4977,  4978,   3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 12530 as ttosf, '4977,  4978,   3075, 3076, 3078, 3556, 3560, 3593, 3596, 3597, 3598, 3984, 3985, 4116, 4331, 4333, 4335, 4337, 4547, 4549, 4551, 4757, 4759, 4761' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 12562 as ttosf, '4416, 4417, 4418, 3285, 3286, 3290, 4347, 4348, 4559, 4560, 4561, 4565, 4566, 4567, 4117, 4550, 4552, 1928, 4332, 4333, 4334, 4335, 4336' as unidades, 'movilidad-suspensiones-reconexiones' as movilidad from dual union all
select 12617 as ttosf, '1888, 1889, 1890, 2217, 2218, 2382, 3571, 3572, 3573, 4006, 4007, 4008, 4439, 4440, 4441, 3662, 4416, 4417, 4418, 4562, 4563, 4564, 3663, 3285, 3286, 3290, 4348, 4347, 3664,1530, 1529, 1531, 1988, 1987' as unidades, 'movilidad-lecturas' as movilidad from dual union all
select 12617 as ttosf, '1888, 1889, 1890, 2217, 2218, 2382, 3571, 3572, 3573, 4006, 4007, 4008, 4439, 4440, 4441, 3662, 4416, 4417, 4418, 4562, 4563, 4564, 3663, 3285, 3286, 3290, 4348, 4347, 3664,1530, 1529, 1531, 1988, 1987' as unidades, 'movilidad-lecturas' as movilidad from dual union all
select 12620 as ttosf, '4416, 4417, 4418, 4565, 4566, 4567' as unidades, 'movilidad-verificacion-consumo' as movilidad from dual union all
select 12620 as ttosf, '4416, 4417, 4418, 4565, 4566, 4567' as unidades, 'movilidad-verificacion-consumo' as movilidad from dual union all
select 12620 as ttosf, '2217, 2218, 2382' as unidades, 'movilidad-verificacion-consumo' as movilidad from dual union all
select 12661 as ttosf, '4977, 4416, 4417, 4418, 3285, 3286, 3290, 4347, 4348, 4559, 4560, 4561, 4565, 4566, 4567, 4117, 4550, 4552, 1928, 4332, 4333, 4334, 4335, 4336' as unidades, 'movilidad-estado-tecnico' as movilidad from dual union all
select 12669 as ttosf, '4946, 4950, 3285, 3286, 3290, 4347, 4348, 4419, 4420, 4421, 4416, 4417, 4418, 4559, 4560, 4561, 4565, 4566, 4567, 799' as unidades, 'movilidad-calidad-medicion' as movilidad from dual union all
select 12678 as ttosf, '4946, 4950, 3285, 3286, 3290, 4347, 4348, 4419, 4420, 4421, 4416, 4417, 4418, 4559, 4560, 4561, 4565, 4566, 4567, 799' as unidades, 'movilidad-pno' as movilidad from dual union all
select 12685 as ttosf, '4958, 4959, 4416, 4417, 4418, 4565, 4566, 4567' as unidades, 'movilidad-pno' as movilidad from dual union all
select 12688 as ttosf, '4958, 4959, 4416, 4417, 4418, 4565, 4566, 4567' as unidades, 'movilidad-pno' as movilidad from dual union all
select 12688 as ttosf, '4958, 4959, 4416, 4417, 4418, 4565, 4566, 4567' as unidades, 'movilidad-pno' as movilidad from dual union all
select 12689 as ttosf, '4958, 4959, 4416, 4417, 4418, 4565, 4566, 4567' as unidades, 'movilidad-pno' as movilidad from dual union all
select 12689 as ttosf, '4958, 4959, 4416, 4417, 4418, 4565, 4566, 4567' as unidades, 'movilidad-pno' as movilidad from dual union all
select 12689 as ttosf, '4958, 4959, 4416, 4417, 4418, 4565, 4566, 4567' as unidades, 'movilidad-pno' as movilidad from dual union all
select 12689 as ttosf, '4958, 4959, 4416, 4417, 4418, 4565, 4566, 4567' as unidades, 'movilidad-pno' as movilidad from dual union all
select 12831 as ttosf, '4977, 4416, 4417, 4418, 3285, 3286, 3290, 4347, 4348, 4559, 4560, 4561, 4565, 4566, 4567, 4117, 4550, 4552, 1928, 4332, 4333, 4334, 4335, 4336' as unidades, 'movilidad-estado-tecnico' as movilidad from dual 
)
    , unidades as(
    select distinct b.ttosf, trim(REGEXP_SUBSTR(unidades, '[^,]+', 1, LEVEL)) AS elemento, movilidad
    from base b
    CONNECT BY
        LEVEL <= LENGTH(b.unidades) - LENGTH(REPLACE(b.unidades, ',')) + 1
        AND PRIOR b.ttosf = b.ttosf

        AND PRIOR SYS_GUID() IS NOT NULL
    )
    ,detalle as(
    select task_type_id, description,u.operating_unit_id, u.name,movilidad, u.admin_base_id
    from unidades
    left join open.or_task_type t on t.task_type_id=ttosf
    join open.or_operating_unit u on u.operating_unit_id=to_number(elemento) and u.admin_base_id=25
    where elemento!='TODAS'
    order by movilidad, task_type_id, u.operating_unit_id
    )
    select movilidad, operating_unit_id, LISTAGG( task_type_id||',')  within group(order by movilidad, operating_unit_id) as CAMPO
    from detalle
    --where movilidad='movilidad-estado-tecnico'
    group by movilidad, operating_unit_id
    order by movilidad, campo;
    
    cursor cuExisteRol(sbNombreRol varchar2,
                       sbListaTitr varchar2) is
       with base as
      (select distinct r.role_id, r.name, task_type_id
      from open.sa_role r
      join open.or_actividades_rol ar on ar.id_rol=r.role_id
      join open.or_task_types_items ti on id_actividad=ti.items_id
      where r.name like '%'||sbNombreRol||'%'
      order by task_type_id)
      ,base2 as(
      select role_id, name, LISTAGG(task_type_id||',')  within group(order by role_id) as CAMPO
      from base
      group by role_id, name
      
      )
      select role_id
      from base2
      where campo=sbListaTitr;
      
      cursor cuExisteRolUnidad(nuUnidad number,
                               nuRol    number) is
                               
      select count(1)
      from open.or_rol_unidad_trab t
      where t.id_unidad_operativa = nuUnidad
        and t.id_rol              = nuRol;
        
    
    sbMovilidadAnte varchar2(4000):='';
    sbCampoAnte     varchar2(4000):='';
    sbCreaNuevoRol  varchar2(1);
    nuRolMovildiad  number        := 1;
    nuExisteRolUni  number;
    nuError         number;
    sbError         varchar2(4000);
    nuRolUnidadOut  number;
    
    
    
    --Variables Creación Rol
    nuRoleId      number;
    sbNameRole    varchar2(4000);
    sbDescRole    varchar2(4000);
    nuRoleType    number         := 4;
    nuUserOwner   number         := null;
    
begin
    for reg in cuDatos loop
      begin
        --Valida si crea nuevo rol
        nuRolUnidadOut := null;
        if sbMovilidadAnte = reg.movilidad then 
          if sbCampoAnte = reg.campo then
            sbCreaNuevoRol :='N';
          else
            sbCreaNuevoRol :='Y';
            nuRolMovildiad := nuRolMovildiad+1;
          end if;
        else 
          nuRolMovildiad := 1;
          
          if sbCampoAnte = reg.campo then
            sbCreaNuevoRol :='N';
          else
            sbCreaNuevoRol :='Y';
          end if;
        end if;
        
        --Creacion Nuevo Rol
        if sbCreaNuevoRol = 'Y' then
           
           sbNameRole:= 'GDGU_'||replace(UPPER(reg.movilidad),'MOVILIDAD-','');
           if cuExisteRol%isopen then
             close cuExisteRol;
           end if;
           open cuExisteRol(sbNameRole, reg.campo);
           fetch cuExisteRol into nuRoleId;
           if cuExisteRol%notfound then 
             
             nuRoleId  := SA_BOROLE.GETNEXTID;
             sbNameRole:= substr(sbNameRole||'_'||nuRolMovildiad,1,30);
             sbDescRole:= 'GDGU '||UPPER(reg.movilidad)||'_'||nuRolMovildiad;
             insert into sa_role(role_id, name, description, role_type_id, user_owner_id)
                 values(nuRoleId, sbNameRole, sbDescRole, nuRoleType, nuUserOwner);

             insert into or_actividades_rol(id_actividad_rol, id_rol, id_actividad) 
             with base as(
                SELECT REGEXP_SUBSTR(reg.campo, '[^,]+', 1, LEVEL) AS elemento
                FROM dual
                CONNECT BY LEVEL <= REGEXP_COUNT(reg.campo, ',') + 1
                )
                select SEQ_OR_ACTIVIDADES_ROL.Nextval,nuRoleId ,i.items_id
                from base 
                join open.or_task_types_items ti on ti.task_type_id=elemento
                join open.ge_items i on i.items_id = ti.items_id and i.item_classif_id=2
                where not exists(select null from open.ct_item_novelty n where n.items_id=i.items_id);
                commit;
             dbms_output.put_line('Se crea rol :'||nuRoleId);
           else
             dbms_output.put_line('Se usa rol :'||nuRoleId);
           end if;
           close cuExisteRol;
        end if; 
        --asociar rol a unidades
        begin
           nuExisteRolUni := 0;
           if cuExisteRolUnidad%isopen then
             close cuExisteRolUnidad;
           end if;
           open cuExisteRolUnidad(reg.operating_unit_id,nuRoleId);
           fetch cuExisteRolUnidad into nuExisteRolUni;
           close cuExisteRolUnidad;
           --dbms_output.put_line(reg.operating_unit_id||'-'||nuRoleId||'-'||nuExisteRolUni);
           if nuExisteRolUni = 0 then
                  
              OR_BORolUnidadTrab.InsertarRol(Inurol => nuRoleId, Inuunidadtrab => reg.operating_unit_id,Onurolunitrabid =>  nuRolUnidadOut);
              commit;
           end if;
        exception
         when others then
           dbms_output.put_line(reg.operating_unit_id||'|'||sqlerrm);
        end;
        
        
        sbMovilidadAnte := reg.movilidad;
        sbCampoAnte := reg.campo;
        
      exception
        when others then
          rollback;
          dbms_output.put_line('ERROR2:'||sqlerrm);
      end;
    end loop;
end;    
