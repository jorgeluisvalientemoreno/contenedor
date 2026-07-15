declare 
    fecha_fin date; 
    fecha_qh  date;
    v_count   number := 0;
    
begin 

  fecha_fin :=&fecha_fin ; ----'31/12/2026'
  fecha_qh :=&fecha_qh ; -- '09/01/2026'
  
    for r in (
        select vitctaco , max(vitcfefi) max_fecha
        from open.ta_vigetaco
        where vitcfefi >= fecha_qh
          and vitcfefi <= trunc(sysdate)
          and vitcvige = 'S'
        group by vitctaco
    ) loop
    
        update open.ta_vigetaco t
        set t.vitcfefi = fecha_fin
        where t.vitctaco  = r.vitctaco
          and t.vitcfefi = r.max_fecha
          and t.vitcvige = 'S';
        
        
        v_count := v_count + sql%rowcount;
    
    end loop;

    dbms_output.put_line('Número de registros modificados: ' || v_count);

    --commit;

exception
    when others then
        rollback;
        dbms_output.put_line('Error: ' || sqlerrm);
end;
/
