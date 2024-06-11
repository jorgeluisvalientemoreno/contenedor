select to_char(((decode(esprporc, 100, esprfefi, sysdate)-esprfein)*24*60),'999,999,999.99') "Tiempo-Minutos",
       to_char(esprsupr/((decode(esprporc, 100, esprfefi, decode(esprporc, 100, esprfefi, sysdate))-esprfein)*24*60),'999,999,999.99') "Registros x Minuto" ,
      to_char((esprtapr-esprsupr)/(esprsupr/((decode(esprporc, 100, esprfefi, sysdate)-esprfein)*24*60)),'999,999,999.99') "Estimado Faltante x Minuto" ,
      decode(esprporc, 100, esprfefi, sysdate)+(esprtapr-esprsupr)/(esprsupr/(decode(esprporc,100,esprfefi, sysdate)-esprfein)) "Hora Estimada Final" ,
       esprprog "Programa",
       esprporc "% Avance",
       esprfein "Fecha inicial proceso",
       esprfefi "Fecha final proceso",
       esprtapr "A procesar",
       esprsupr "Procesados",
       esprmesg "Mensaje estado proceso"
  from open.estaprog
 where (esprprog like '%CERT%')
 order by esprfein desc;
