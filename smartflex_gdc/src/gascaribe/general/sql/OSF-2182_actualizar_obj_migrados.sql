update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in 
(
'LDC_FNUREALIZAVENTA',
'LDC_FNUREALIZAVENTAWEB',
'LDC_FNUULOTPRODUCTO',
'LDC_FNUUNITRACONECOATCI',
'LDC_FNUVISUALIZAORPLO',
'LDC_FSBDATOADICIONAL',
'LDC_FSBDEPTOPERIFACT',
'LDC_FSBGETORDERCOMENTS',
'LDC_FSBGETPENDORDERSCM',
'LDC_FSBVALIDAACTIV_BLOQ',
'LDC_FUNVALIDATRANSITUNOPER',
'LDC_GETVALUERP',
'LDCPRBLOPORVAL',
'LDC_PRO_ESTA_REFINANCIADO',
'LDC_RET_FECHA_ATEN_ANUL'
);


commit;
/