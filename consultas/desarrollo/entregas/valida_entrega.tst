PL/SQL Developer Test script 3.0
13
declare
  -- Boolean parameters are translated from/to integers: 
  -- 0/1/null <--> false/true/null 
  result boolean;
begin
  -- Call the function
  result := fblaplicaentrega(isbentrega => :isbentrega);
  -- Convert false/true/null to 0/1/null 
  if result then
    dbms_output.put_line('ENTRO');
  end if;
  :result := sys.diutil.bool_to_int(result);
end;
2
result
1
1
3
isbentrega
1
OSS_HT_0000167_3
5
0
