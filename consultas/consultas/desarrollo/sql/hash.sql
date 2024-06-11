SELECT distinct n.notification_id, n.description, x.xsl_template_id, x.description, --x.template_source, x.template_xsl, s.statement_id, s.description, s.statement,
sys.dbms_crypto.hash(template_source, 3), 
sys.dbms_crypto.hash(template_xsl, 3) 
--sys.dbms_crypto.hash(utl_raw.cast_to_raw(s.statement), 3)
FROM open.ge_xsl_template x, open.ge_notification n, open.ge_statement s, open.ge_notifi_statement ns--, open.or_notif_tipo_traba tt
WHERE --tt.id_tipo_trabajo =:TT AND 
--tt.id_notificacion = n.notification_id AND 
ns.notification_id = n.notification_id AND ns.statement_id = s.statement_id AND x.xsl_template_id(+) = n.xsl_template_id  
AND n.description IN('LDC_CONSTRUCCION DE INTERNAS','LDC_INSP_CERT_NUEVAS')
;
