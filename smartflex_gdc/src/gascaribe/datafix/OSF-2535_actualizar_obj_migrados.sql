update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in (
'XLOGPNO_EHG', 
'PROCREASIGORECA_HILOS', 
'PROCREASIGORECA',
'CAMBIOCATEGORIAPROD',
'PRVALLDCREASCO', 
'REPROGRAMORDERACTION',
'UPDPROPIEDADSERIADO', 
'SENDMAILCONCEPT', 
'XINSERTFGRCR'
);


update  master_personalizaciones set COMENTARIO = 'BORRADO'
where  NOMBRE in (
'TEMP',
'PRVALIDACAUSALCORRDEFRP',
'FINANPRIORITYGDC',
'LDC_ATENTESOLOTFINREVPER',
'PRUSUPROMPORPERIODO'
);



commit;
/