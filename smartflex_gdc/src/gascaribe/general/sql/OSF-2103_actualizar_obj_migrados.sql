update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in (
'LDC_FVATELSUBSCRIBER',
'LDC_GETFINANVALSBYPKGTYPE',
'LDC_IMPORTEENLETRAS',
'LDC_PLAN_PRIO_FINAN',
'LDC_PRO_CANTI_REFINANCIADO',
'LDC_PROCCONSULTAACTASABIERTAS',
'LDC_PROCCONSULTAPRODOTSPNO',
'LDC_PRODSUSPEND',
'LDC_PRSUSPRVSEG',
'LDC_PRUOCERTIFICACION',
'LDC_PRVALIDAUOCERT',
'LDC_RETORACOBRORECONEX',
'LDC_RETORACTASSALDOSUSP',
'LDC_RETORADEDUAAFECHA',
'LDC_RETORADEUDAPRESENMES');
commit;
/