update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in (
'LDCFNU_VENANODIREC',
'LDC_FNVNOMBRECONTRA',
'LDC_FRFLISTCONTRACTOR',
'LDC_FRFLISTOPERATINGUNITY',
'LDC_FSBASIGNAUTOMATICAREVPER',
'LDC_FSBCOMMENORDER',
'LDC_FSBESTRATOVALIDO',
'LDC_FSBEXCLUIROT',
'LDC_FSBGETINFOBYCRIT',
'LDC_FSBGETNEWNAMELODPD',
'LDC_FSBNUMFORMULARIO',
'LDC_FSBOBTORDHIJA',
'LDC_FSBTTPROCESOCORREO',
'LDC_FSBVALIDAEXPRESION_IC',
'LDC_FVARETCONSUMOS');
commit;
/