-- fecha_anulacion_solicitud
select b.init_pay_expiration, sysdate
from cc_financing_request b
where b.package_id = 206975993
