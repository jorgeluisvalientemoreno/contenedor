update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in (
'GDC_BOSUSPENSION_XNO_CERT',
'LD_BOLASTSUSPENSIONDATA',
'LD_BOQUERYPOLICY',
'LD_BOQUOTATRANSFER',
'LD_FA_REPORTGRAFICCR',
'LDC_API_PREDIO',
'LDC_ASIGDIRCONTRUCTORAS',
'LDC_BCLEGALORDENVENTAS',
'LDC_BCNOTIFICACIONESCRITICA',
'LDC_BOASOCIADOS',
'LDC_BOASSINGORDER',
'LDC_BOCONSPARAM',
'LDC_BONOTYCONSREC',
'LDC_BOREGISTERNOVELTY',
'LDC_CA_NOTI',
'LDC_CRMPAZYSALVO',
'LDC_ESTADOCUENTA',
'LDC_ESTADOCUENTACASTIGADA',
'LDC_PK_CARTERA_DIARIA'
);


commit;
/