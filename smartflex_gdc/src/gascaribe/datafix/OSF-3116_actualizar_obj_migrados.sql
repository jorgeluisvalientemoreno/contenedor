update  master_personalizaciones set COMENTARIO = 'OPEN'
where  NOMBRE in (
'LDCFAAC',
'LDC_PRGEAUDPRE'
);


commit;
/