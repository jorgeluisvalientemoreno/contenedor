begin
    if open.fblaplicaentregaxcaso('0000501') then
       dbms_output.put_line('Aplica');
    else
      dbms_output.put_line('No Aplica');
    end if;
end;
