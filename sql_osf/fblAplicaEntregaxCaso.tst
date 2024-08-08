PL/SQL Developer Test script 3.0
10
declare
  -- Boolean parameters are translated from/to integers: 
  -- 0/1/null <--> false/true/null 
  result boolean;
begin
  -- Call the function
  result := fblaplicaentregaxcaso(isbnumerocaso => :isbnumerocaso);
  -- Convert false/true/null to 0/1/null 
  :result := sys.diutil.bool_to_int(result);
end;
2
result
1
1
3
isbnumerocaso
1
0000472
5
0
