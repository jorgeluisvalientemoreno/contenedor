update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in (
'LDCI_GENERAREPORTEBRILLA',
'LDCI_IFRS',
'LDCI_MAESTROMATERIAL',
'LDCI_OSS_PKGEOGRAPLOCAT',
'LDCI_PKANALISUSPENSION',
'LDCI_PKBSSCARBRILLA',
'LDCI_PKBSSCOBRO',
'LDCI_PKBSSFACTCONS',
'LDCI_PKBSSPORTALWEB',
'LDCI_PKCONEXIONU',
'LDCI_PKCRMCONSULTA',
'LDCI_PKCRMCONTRATOS',
'LDCI_PKCRMSOLICITUD',
'LDCI_PKDATACREDITOPORTAL',
'LDCI_PKFACTACTA',
'LDCI_PKFACTELECTRONICA_EMI',
'LDCI_PKFACTKIOSCO',
'LDCI_PKFACTKIOSCO_GDC',
'LDCI_PKFACTURACION',
'LDCI_PKGACTIVOENCURSO',
'LDCI_PKGESTENVORDEN',
'LDCI_PKGESTNOVORDERXTT',
'LDCI_PKINBOX',
'LDC_PRACTUALIZAORANPU',
'LDC_LEGALVISITASFNB',
'LDC_ANULASOLICITUD',
'LD_LEGALIZE',
'LDC_PROINSERTAERRPAGAUNI',
'LDC_PROLENALOGERROR'
);


commit;
/