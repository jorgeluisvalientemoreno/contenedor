update  master_personalizaciones set COMENTARIO = 'BORRADO'
where  NOMBRE in (
'LDC_CUADREBODEGASACTIVO',
'LDC_FILLTABLE',
'LDC_FTABLE',
'LDCI_PREPLICACECOLOCA',
'LDC_LLENAPROVISIONCOSTO',
'LDC_LLENAREPORTECONSUMVALUNI',
'LDC_OS_REVOKEORDER',
'LDC_PKCALIDADCARTERA',
'LDC_PROCLLENAINDICADORCARTERA',
'LDC_PROGENPROCARTERA',
'LDC_REVOCAR_ORDEN',
'LDC_SEARCHFILE_SENDEMAIL',
'PRO_GRABA_LOG_HILOS',
'PRREGFACPORPROD'
);

update  master_personalizaciones set COMENTARIO = 'BORRADO - FRAMEWORK OPEN'
where  NOMBRE in 
(
'LDCIREPLICACECO',
'LDC_PROCCONUNI',
'LDC_PROCPVCO',
'LDCPROVCART',
'LDREFA',
'LDCALCAR'
);

update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in (
'LDC_PRGENERECOACRP');
commit;
/