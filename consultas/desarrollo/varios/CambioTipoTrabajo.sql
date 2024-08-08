declare
  cursor cudatos is 
  select distinct o.order_id,a.order_activity_id, a.product_id,  o.operating_unit_id, (select name from open.or_operating_unit u where u.operating_unit_id=o.operating_unit_id) nombre,
FECHA_RECEPCION,
(select nvl(suspension_type_id,1000) from open.ldc_marca_producto m where m.id_producto=a.product_id) marca,
(select suspension_type_id from open.mo_motive m, open.mo_suspension su where su.motive_id=m.motive_id and m.package_id=a.package_id) marca_suspension,
o.task_type_id,(select description from open.or_task_type t where t.task_type_id=o.task_type_id) desc_titr,  system, order_status_id , replace(messagetext,'LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >>','') messagetext,
REAL_TASK_TYPE_ID,
(SELECT nvl(SUM(difesape),0)
    FROM open.diferido
   WHERE difenuse = product_id
     AND difeconc IN(739,755)
     AND difesape >= 1)
from open.ldci_ordenesalegalizar li, open.or_order o, open.or_order_activity a
where li.Messagecode <> 0
  and o.order_id=li.order_id
  and a.order_id=o.order_id
  and o.task_type_id in (10834, 10835, 10836, 10444, 10795, 10450, 12457)
  and messagetext not like '% El registro Personal de la Unidad de Trabajo%'
  and messagetext not like '%La fecha de generacion de cuentas debe estar dentro del rango de fechas de%'
  and messagetext not like '%el tipo de respuesta de inspeccion%'
  and messagetext not like '% BSS-ERR (ORA-20002: )%'
  and messagetext not like '%Tiene las siguientes solicitudes de%'
  and messagetext not like '%Proceso termino con errores, el codigo del certificado%'
  and messagetext not like '%No se encuentra un estado valido%'
  and messagetext not like '%deadlock detected while waiting for resource%'
  and messagetext not like '% La lectura no puede ser mayor%'
  and messagetext  like '%tiene diferidos con saldo del concepto 739 y/o 755%'
  and order_status_id not in (8,12)
  and o.task_type_id=10834;
  
  isbTaskTypeChg varchar2(4000);
  newTaskType number:=10836;
  newActivity number:=100005256;
  --oldActivity number:=100005239;
  onuErrorCode number;
  osbErrorMessage varchar2(4000);
  onuErrorCode2 number;
  osbErrorMessage2 varchar2(4000);
begin
  for reg in cudatos loop
  
    isbTaskTypeChg:='<ORDER><ORDER_ID>'||reg.order_id||'</ORDER_ID><NEW_TASK_TYPE>'||newTaskType||'</NEW_TASK_TYPE><ACTIVITIES><ACTIVITY><ACTIVITY_ID>'||newActivity||'</ACTIVITY_ID><RELATED_ACTIVITY_ID>'||reg.order_activity_id||'</RELATED_ACTIVITY_ID></ACTIVITY></ACTIVITIES></ORDER>';
    OS_CHANGE_TASKTYPE(isbTaskTypeChg, onuErrorCode, osbErrorMessage);
    if nvl(onuErrorCode,0)=0 then
      commit;
       dbms_output.put_line('CAMBI OK ORDEN '||reg.order_id);
    else
      dbms_output.put_line('ERROR ORDEN '||reg.order_id||' '||sqlerrm);
      dbms_output.put_line('ERROR ORDEN '||reg.order_id||' '||onuErrorCode||' '||osbErrorMessage);
      rollback;
    end if;
    onuErrorCode:=null;
    osbErrorMessage:=null;
  end loop;
end;
