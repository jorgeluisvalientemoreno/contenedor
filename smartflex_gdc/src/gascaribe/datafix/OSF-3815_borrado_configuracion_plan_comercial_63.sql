begin
  --Borrado reglacion plan comercial 63 y concepto 1071.
  delete open.concplsu
   where copsconc in (1071)
     and copsplsu = 63;
  
  commit;

  dbms_output.put_line('Borrado reglacion plan comercial 63 y concepto 1071.');

exception
  when others then
    Rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
  
end;
/