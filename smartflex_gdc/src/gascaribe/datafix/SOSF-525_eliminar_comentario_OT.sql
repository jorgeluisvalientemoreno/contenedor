Begin
 delete open.or_order_comment c
  where c.order_id = 253696517;
  commit;
 Exception
   When others then
     Rollback;
     dbms_output.put_line(sqlerrm);
End;
/