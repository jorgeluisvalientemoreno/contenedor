select  *
from  open.ldc_certificados_oia t
where not exists (select null from open.ldc_certificados_oia r
                 where r.certificados_oia_id = t.certificados_oia_id
                 and  status_certificado not in ( 'A','R'))