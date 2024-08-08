select id_certificado,
       unidad_operativa,
       tecnico_unidad,
       ge.name_,
       codigo_rufi_tec,
       fecha_ini_vig,
       fecha_fin_vig,
       id_norma,
       id_titulacion,
       flag_activo
from open.ldc_certificado c
inner join ge_person ge on person_id = tecnico_unidad
where flag_activo = 'N'
and unidad_operativa = 2839
and fecha_fin_vig > sysdate
