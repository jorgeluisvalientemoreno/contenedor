update  master_personalizaciones set COMENTARIO = 'BORRADO'
where  NOMBRE in (
'LDC_RETORNAINTMOFI',
'LDC_CARTCASTIGADA_CIERRE_GDC',
'LDCFNCRETORNAMESLIQ'
);
commit;
/