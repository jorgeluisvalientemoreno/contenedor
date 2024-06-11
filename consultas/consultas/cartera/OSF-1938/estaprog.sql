-- estado_procesos
select ep.esprprog programa,
       ep.esprporc porcentaje_de_ejecucion,
       ep.esprmesg estado,
       ep.esprfein fecha_inicio,
       ep.esprfefi fecha_final,
      round((ep.esprfefi - ep.esprfein)*24 ,2) Tiempo_horas,
       round((ep.esprfefi - ep.esprfein)*24*60,2) Tiempo_min,
       round((ep.esprfefi - ep.esprfein)*24*60*60,2) Tiempo_seg,
       sysdate,
       ep.esprtapr susc_a_procesar,
       ep.esprsupr susc_procesadas,
       ep.esprsufa susc_facturadas,
       ep.esprvalo proceso,
       ep.esprinfo informacion_adicional,
       ep.esprprpr identificador_programa,
       ep.esprpefa periodo_facturacion
  from open.estaprog ep
 where esprprog like 'PBMAFA%'
 order by esprfein desc;
