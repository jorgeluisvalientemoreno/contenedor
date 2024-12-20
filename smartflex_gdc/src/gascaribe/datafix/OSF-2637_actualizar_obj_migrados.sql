update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in (
'LDC_PRFILLTABLONBASE', 
'LDC_PRLIQUIDACONTRA',
'LDC_ATIENDESOLICITUD',
'LDC_PROGENERANOVELTYRANGOXASIG',
'LDC_PROGENERANOVELTYREDESPOS', 
'LDC_PROGENERANOVELTYREDES', 
'LDC_PRDEPURALISTAMATERIALES',
'LDCI_VALID_METRAJE',
'LDC_UNLOCK_ORDERS', 
'LDC_PRGENERAOTNOTI'
);


update  master_personalizaciones set COMENTARIO = 'BORRADO'
where  NOMBRE in (
'GENIFRS_DUMMY',
'LDC_PRLDC_ORDEELDORCD_ACT',
'GDC_PRREPARACIONRP',
'LDCBI_DESBLOQUEAR',
'LDCBI_GRANTINNOVACION',
'LDC_RECUPERAATRIBUTOSCOPIA2',
'LDC_RECUPERAATRIBUTOSCOPIA',
'LDC_JOB_FLUJO_NUMERACION_VENTA',
'LDC_ANULARERRORFLUJO',
'LDC_PRFINALIZAPERIODOGRACIA'
);



commit;
/