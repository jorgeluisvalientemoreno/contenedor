SELECT to_char(((decode(esprporc, 100, esprfefi, sysdate)-esprfein)*24*60),'999,999,999.99') "Tiempo-Minutos",
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
FROM   Open.estaprog
WHERE  (esprprog like 'CERT%' )
  and esprfein>='27/05/2021'
ORDER BY esprfein desc
;

select * from dba_jobs_running jr, dba_jobs jo
where jr.job=jo.job
and what like '%GDC_BOSuspension_XNO_Cert%';



select jr.job,v.sid,v.serial#,'alter system kill session '||v.sid||','||v.serial#||''''||' immediate;' from dba_jobs_running jr, dba_jobs jo, v$session v
where jr.job=jo.job
and what like '%GDC_BOSuspension_XNO_Cert%'
and v.sid=jr.sid
