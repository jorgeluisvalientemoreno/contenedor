update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in (
'LDC_PRCONDEFRP', 
'LDC_PRFILLOTREVCERTIFIDDET',
'LDC_PRFINANORDRP',
'LDC_PRGAPYCAR',
'LDC_PRGETINFOSUBSIDIO', 
'LDC_PRGETPACKAGERP', 
'LDC_PRINSERTESTADPDP',
'LDC_PRJOBINTERACCIONSINFLUJO', 
'LDC_PRLEGORDENSACRP',
'LDC_PRMARCAPRODUCTO', 
'LDC_PROANULAREQUISICION', 
'LDC_PROCERRARACTASABIERTAS',
'LDC_PROCESA_ITERACION', 
'LDC_PROGENERANOVELTYCARTERA', 
'LDC_LLENACOSTOINGRESOSOCIERRE'
);


update  master_personalizaciones set COMENTARIO = 'BORRADO'
where  NOMBRE in (
'LDC_PRENVIASMS',
'LDC_PROACTSERIALTERMCONT',
'LDC_PROC_EJEC_ATEN_REV_PER_AUT'
);



commit;
/