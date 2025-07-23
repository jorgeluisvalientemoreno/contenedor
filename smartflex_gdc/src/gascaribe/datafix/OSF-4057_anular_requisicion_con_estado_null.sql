begin
  update open.LDCI_TRANSOMA t
     set t.trsmesta = 4
   where t.trsmcodi in (245071, 245104);
  commit;
  dbms_output.put_line('Las requisiones 245071 y 245104 fueron colocadas en estado 4 - ANULADAS');
exception
  when OTHERS then
    rollback;
    dbms_output.put_line('No se actualizo estado de las requisiones 245071 y 245104 fueron colocadas a estado 4 - ANULADAS - ' ||
                         SQLERRM);
end;
/