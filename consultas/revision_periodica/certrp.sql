SELECT 
ldc_certificados_oia.CERTIFICADOS_OIA_ID, 
ldc_certificados_oia.ID_CONTRATO, 
ldc_certificados_oia.ID_PRODUCTO, 
ldc_certificados_oia.FECHA_INSPECCION, 
decode(ldc_certificados_oia.TIPO_INSPECCION,1,'1-Obligatoria','2-Voluntaria') TIPO_INSPECCION, 
ldc_certificados_oia.CERTIFICADO, 
ldc_certificados_oia.ID_ORGANISMO_OIA||'-'||OPEN.DAOR_OPERATING_UNIT.FSBGETNAME(ldc_certificados_oia.ID_ORGANISMO_OIA) ID_ORGANISMO_OIA, 
ldc_certificados_oia.ID_INSPECTOR||'-'||OPEN.DAGE_PERSON.FSBGETNAME_(ldc_certificados_oia.ID_INSPECTOR) ID_INSPECTOR, 
decode(ldc_certificados_oia.RESULTADO_INSPECCION,1,'1-Certificada',2,'2-Defectos No Criticos',3,'3-Defectos Criticos','4-Sin defectos y Artefactos') RESULTADO_INSPECCION, 
ldc_certificados_oia.PACKAGE_ID, 
decode(ldc_certificados_oia.RED_INDIVIDUAL,'Y','INDIVIDUAL','MATRIZ') RED_INDIVIDUAL, 
decode(ldc_certificados_oia.STATUS_CERTIFICADO,'I','REGISTRADA','A','APROBADA','R','RECHAZADA') STATUS_CERTIFICADO, 
ldc_certificados_oia.FECHA_REGISTRO, 
ldc_certificados_oia.OBSER_RECHAZO,
ldc_certificados_oia.*
--to_char(:parent_id) parent_id
FROM open.ldc_certificados_oia
WHERE ID_PRODUCTO=1114547;
 WHERE ldc_certificados_oia.certificados_oia_id = 2;
 
 select * from open.LDC_APPLIANCE_OIA a where certificados_oia_id=2;
select * from open.LDC_CERTIFICADOS_OIA where certificados_oia_id=2  ;

select *
from open.pr_certificate
where product_id=1114547;
