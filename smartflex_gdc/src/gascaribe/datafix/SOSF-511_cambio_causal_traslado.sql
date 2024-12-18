begin
    update ge_items_documento
       set causal_id=3369
     where id_items_documento = 463358 ;
     commit;
exception
  when others then
    rollback;
    dbms_output.put_line(sqlerrm);
end;
/