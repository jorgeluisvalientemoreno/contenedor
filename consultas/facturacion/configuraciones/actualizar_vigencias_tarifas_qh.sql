declare 
  fecha_fin date; 
  fecha_qh date;
  v_count number;
  
begin 
  
  fecha_fin :=&fecha_fin ; ----'31/12/2025'
  fecha_qh :=&fecha_qh ; -- fecha de actualización de  QH
  
  update open.ta_vigetaco t
  set t.vitcfefi = fecha_fin
  where t.vitcfefi >= fecha_qh
    and t.vitcfefi <= trunc(sysdate)
    and t.vitcvige = 'S';
    
  v_count := sql%rowcount; 
  
  dbms_output.put_line('número de registros modificados: ' || v_count);
  
end;
