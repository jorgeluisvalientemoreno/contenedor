update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in (
'CANCELPOLICYBYAGE', 
'GENERATEFILEDEBITAUTO',
'LDC_ACTFORMULARIO',
'LDC_ACTIVA_HILOS_CARTLINEA',
'LDC_BOGENERATECHARGEORDER', 
'LDC_BOPROCESSLDCLT',
'LDC_BOUPDATELASTSUSPEN', 
'LDC_BOVALEXECUTIONDATES', 
'LDC_BOVALLASTREGEN', --OK
'LDC_CREA_ORDEN_ENV_SSPD', 
'LDC_CREATRAMITESUSPACOMET', 
'LDC_GENERA_SERV_PENDIENTES',
'LDC_GENEVERPREFIN', 
'LDC_GENOTINTERACCIONJOB', 
'LDC_GETORDERS_SUPPLIER_INFO', 
'LDC_INSERTSUSPCONE', 
'LDC_JOB_DELETE_ALL_INSTANCES', 
'LDC_LLENACOSTOINGRESOSOCIERRE' 
);

update  master_personalizaciones set COMENTARIO = 'CIERRE COMERCIAL'
where  NOMBRE in (
'LDC_ACTCONCCEROULTPLAFI_X'
);

update  master_personalizaciones set COMENTARIO = 'BORRADO'
where  NOMBRE in (
'LDC_INSERT_SERV_PENDIENTES'
);



commit;
/