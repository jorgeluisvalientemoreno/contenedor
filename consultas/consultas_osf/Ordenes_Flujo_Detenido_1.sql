begin

update  OPEN.IN_INTERFACE_HISTORY I
   set i.status_id=6
where i.interface_history_id in (457280,552928,554814,939169,2165364,2085077);

 
end;
/
