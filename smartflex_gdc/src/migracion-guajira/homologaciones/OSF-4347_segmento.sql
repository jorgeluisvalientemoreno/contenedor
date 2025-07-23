begin
    insert into LDCI_SEGMENTO values('GDGU06100','Negocio GAS Gases del Caribe');
    commit;
exception
  when others then
    rollback;
    dbms_output.put_line('Error '||sqlerrm);


end;
/