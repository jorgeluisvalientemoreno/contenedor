select esprprog "Programa",
       esprporc "% Avance",
       esprfein "Fecha inicial proceso",
       esprfefi "Fecha final proceso",
       esprtapr "A procesar",
       esprsupr "Procesados",
       esprmesg "Mensaje estado proceso"
  from open.estaprog 
 where (esprprog like '%CERT%')
 order by esprfein desc;


select *
from open.estaproc  e
where e.proceso like '%JOB_SUSPENSION_XNO_CERT_GDC%'
order by e.fecha_inicial_ejec
