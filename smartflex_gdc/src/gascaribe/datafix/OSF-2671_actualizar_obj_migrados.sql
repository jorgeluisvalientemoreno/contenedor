update  master_personalizaciones set COMENTARIO = 'BORRADO'
where  NOMBRE in 
(
'LDC_PRBLOQUEAORDEN',
'LDC_PROCCUADREBODEGA',
'LDC_PROVALIPERMORDINTCONS',
'LDC_PRVALUSERLEGA',
'PRC_SEGUIMIENTO_COBOL',
'LDC_PR_MUESTRA_DE_CONSUMOS',
'LDCPALICANOTCREDCOMPEN',
'LDC_PROCCREAREGSERGPROGRAMA',
'OS_BILLINGINFO',
'LDC_BUSCADEUDORORI',
'LDC_PROGENERANOVELTYCARTERA_C',
'LDC_SUSPENDACOMCONTR',
'LDC_ACTCONCCEROULTPLAFI2_TEMP',
'LDC_VALLISTPRECVIGUNITOFER',
'LDC_SETVALIDUSERLEGA'
);

update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in 
(
'LOG_CERTIFICADOS_OIA',
'LDC_CHANG_CONTRACT_ORDER',
'LDC_VAL_TIEMP_FIN_EJE_ORD',
'PROCOSTOORDEN',
'LDC_ASSIGN_ORDER',
'LDC_VALIDARFECHACIERREMASIVO',
'LDC_PROREGISTRAPAGOACTA',
'ASSIGNORDERACTION',
'LDC_EXECACTIONBYTRYLEG',
'LDC_PROVALIDAITEMSLEGUONL',
'LDCBI_LOG'
);

commit;
/