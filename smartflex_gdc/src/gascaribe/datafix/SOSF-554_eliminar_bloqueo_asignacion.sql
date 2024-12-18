Begin
 
  delete open.LDC_BLOQ_LEGA_SOLICITUD so
  where so.package_id_gene in (188883389);
  commit;
 Exception
   When others then
     Rollback;
     dbms_output.put_line(sqlerrm);
End;
/