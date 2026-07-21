SELECT tarifas.PRTACONS   codigo,
       tarifas.PRTADESC   descripcion,
       tarifas.PRTAUSUA   usuario_crea,
       tarifas.PRTAFECH   fecha_crea,
       tarifas.PRTAESTA   estado_actual,
       historico.HITPFECH fecha_aprueba,
       historico.HITPESAC estado_aprobado,
       historico.HITPESAN estado_anterior,
       historico.HITPUSUA usuario_aprueba,
       historico.HITPTERM terminal
  FROM open.ta_histtrpt historico, open.ta_proytari tarifas
 WHERE tarifas.PRTACONS = historico.HITPPRTA
   AND historico.HITPFECH between '01/04/2024' and '30/04/2025'
   --and tarifas.PRTACONS = 10686
 order by PRTACONS, historico.HITPESAN asc
