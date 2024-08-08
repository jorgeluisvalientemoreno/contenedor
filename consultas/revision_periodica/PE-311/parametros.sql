select pr.parecodi, pr.paradesc, pr.parevanu, pr.paravast
  from open.ldc_pararepe pr
 where pr.parecodi in ('RESULTADO_INS',
                       'STATUS_CERTIFICADO',
                       'OPER_UNIT_VAL_DOCUMENTAL',
                       'CAU_LEGA_VAL_DOCUMENTAL',
                       'DATO_ADI_VAL_DOCUMENTAL',
                       'MSJ_APROBACION_AUTOMATICA')
