select m.fecha_recepcion,
       m.fecha_procesado,
       L.order_id, legalizado,  
       to_char(l.exec_initial_date,'dd/mm/yyyy hh24:mi:ss') fecha_ini_lego, 
       to_char(l.exec_final_date ,'dd/mm/yyyy hh24:mi:ss') fecha_fin_lego, 
       extractvalue(XMLTYPE.createXML(m.xml_solicitud),'legalizacionOrden/orden/fechaIniEjec') fecha_ini,
       extractvalue(XMLTYPE.createXML(m.xml_solicitud),'legalizacionOrden/orden/fechaFinEjec') fecha_fin,
       to_char(o.exec_initial_date,'dd/mm/yyyy hh24:mi:ss'),
       to_char(o.execution_final_date,'dd/mm/yyyy hh24:mi:ss')
from open.Ldc_Otlegalizar l,open.LDCI_INFGESTOTMOV m, open.or_order o
where m.order_id=l.order_id
  and o.order_status_id not in (8,12)
  and l.legalizado='N'
  and m.sistema_id='WS_LUDYREPXREV'
  and o.order_id=m.order_id;
