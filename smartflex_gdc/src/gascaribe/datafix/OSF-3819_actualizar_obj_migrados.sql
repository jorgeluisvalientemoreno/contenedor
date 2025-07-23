update  master_personalizaciones set COMENTARIO = 'BORRADO'
where  NOMBRE in (
'LDCINTACTAS'
);

commit;
/