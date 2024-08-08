PL/SQL Developer Test script 3.0
11
Declare
  sxmlotxml clob;
begin
  -- Call the procedure
  sxmlotxml:='<legalizacion_ordenes><orden><numero_orden>13048115</numero_orden><causal_ot_padre>9595</causal_ot_padre><tecnico_ot_padre>15902</tecnico_ot_padre><ordenes_adicionales><orden_adicional><tipo_trabajo_adic>12187</tipo_trabajo_adic><actividad_adic>4000087</actividad_adic><causal_ot_adic>9595</causal_ot_adic><observacion_ot_adic>SE REALIZO REPARACION EN CENTRO DE MEDICION  SE REALIZO EXCAVACION PARA HACER PEGA DE TUBERIA DE POL. DE 1/2 CTS SE CAMBIO REGULADOR YA QUE ANTERIOR PRESENTA FUGA EN VENTEO SE ADECUO PRO DE CONSUMO DE CENTRO DE MEDICION SE CAMBIO VALVULA DE INTERNA POR FUGA EN COSTURAS Y SE ADUCO PRO DE CONSUMO YA QUE NO CUMPLIA LA NORMAS SE REINSTALO ESTUFA DE 2 QM  Y MANGUERA FLEXIBLE EN BUEN ESTADO SE PINTARON ACCESORIOS GALV.  QUEDO TRABAJO OK </observacion_ot_adic><tecnico_ot_adic>15902</tecnico_ot_adic><items><item><item_trabajo_adicional>100000681</item_trabajo_adicional><cantidad_item_trab_adic>100</cantidad_item_trab_adic></item><item><item_trabajo_adicional>100004422</item_trabajo_adicional><cantidad_item_trab_adic>1</cantidad_item_trab_adic></item><item><item_trabajo_adicional>100004426</item_trabajo_adicional><cantidad_item_trab_adic>1</cantidad_item_trab_adic></item></items></orden_adicional><orden_adicional><tipo_trabajo_adic>12189</tipo_trabajo_adic><actividad_adic>4000089</actividad_adic><causal_ot_adic>9595</causal_ot_adic><observacion_ot_adic>SE REALIZO REPARACION EN CENTRO DE MEDICION  SE REALIZO EXCAVACION PARA HACER PEGA DE TUBERIA DE POL. DE 1/2 CTS SE CAMBIO REGULADOR YA QUE ANTERIOR PRESENTA FUGA EN VENTEO SE ADECUO PRO DE CONSUMO DE CENTRO DE MEDICION SE CAMBIO VALVULA DE INTERNA POR FUGA EN COSTURAS Y SE ADUCO PRO DE CONSUMO YA QUE NO CUMPLIA LA NORMAS SE REINSTALO ESTUFA DE 2 QM  Y MANGUERA FLEXIBLE EN BUEN ESTADO SE PINTARON ACCESORIOS GALV.  QUEDO TRABAJO OK </observacion_ot_adic><tecnico_ot_adic>15902</tecnico_ot_adic><items><item><item_trabajo_adicional>100004424</item_trabajo_adicional><cantidad_item_trab_adic>1</cantidad_item_trab_adic></item></items></orden_adicional><orden_adicional><tipo_trabajo_adic>12190</tipo_trabajo_adic><actividad_adic>4000090</actividad_adic><causal_ot_adic>9595</causal_ot_adic><observacion_ot_adic>SE REALIZO REPARACION EN CENTRO DE MEDICION  SE REALIZO EXCAVACION PARA HACER PEGA DE TUBERIA DE POL. DE 1/2 CTS SE CAMBIO REGULADOR YA QUE ANTERIOR PRESENTA FUGA EN VENTEO SE ADECUO PRO DE CONSUMO DE CENTRO DE MEDICION SE CAMBIO VALVULA DE INTERNA POR FUGA EN COSTURAS Y SE ADUCO PRO DE CONSUMO YA QUE NO CUMPLIA LA NORMAS SE REINSTALO ESTUFA DE 2 QM  Y MANGUERA FLEXIBLE EN BUEN ESTADO SE PINTARON ACCESORIOS GALV.  QUEDO TRABAJO OK </observacion_ot_adic><tecnico_ot_adic>15902</tecnico_ot_adic><items><item><item_trabajo_adicional>100000681</item_trabajo_adicional><cantidad_item_trab_adic>50</cantidad_item_trab_adic></item><item><item_trabajo_adicional>100004423</item_trabajo_adicional><cantidad_item_trab_adic>1</cantidad_item_trab_adic></item><item><item_trabajo_adicional>100004557</item_trabajo_adicional><cantidad_item_trab_adic>1</cantidad_item_trab_adic></item></items></orden_adicional></ordenes_adicionales></orden></legalizacion_ordenes>';
  ldc_botrabajoadicional.prolegalizaotxml(sxmlotxml => sxmlotxml,
                                          sbmensa => :sbmensa,
                                          error => :error);
end;


3
sxmlotxml
1
<CLOB>
-112
sbmensa
1
ITEM[100000681] - El total de items adicionales[750000] es diferente al total de item cotizado[500000] en su legalizacion
5
error
1
-1
4
3
i.activadic
i.itemtrabadi
rfculistatemcotizado.itemtrabadi
