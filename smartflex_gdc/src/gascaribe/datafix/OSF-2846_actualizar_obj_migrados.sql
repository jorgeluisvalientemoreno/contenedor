update  master_personalizaciones set COMENTARIO = 'BORRADO'
where  NOMBRE in (
'IC_BSLISIMPROVREV',
'LDC_ACTUCIERRE',
'LDC_BCCREG_B',
'LDC_BCCREG_B2',
'LDC_BCCREG_B3',
'LDC_BCCREG_BVENTA',
'LDC_BCCREG_B_ESP',
'LDC_DSSNAPSHOTCREG_B',
'LDC_BCCREG_C',
'LDC_PRGEAUDPRE',
'LDRPCRE',
'PRACTMATERIALES',
'VENPS',
'LDACRE',
'LDCFAAC',
'TRG_GC_DEBT_NEGOT_CHARGE_BI',
'LDC_PKCARGAVOLUMENFACT'
);

update  master_personalizaciones set COMENTARIO = 'OPEN'
where  NOMBRE in (
'LDC_PKFAAC',
'LDC_PKFAPC'
);


commit;
/