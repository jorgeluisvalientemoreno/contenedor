PL/SQL Developer Test script 3.0
12
declare
  -- Boolean parameters are translated from/to integers: 
  -- 0/1/null <--> false/true/null 
  result boolean;
begin
  -- Call the function
  result := ldc_pe_bogestlist.fblvaltipoinc(inuidcontrato => :inuidcontrato,
                                            inuoperatingunit => :inuoperatingunit,
                                            isbtipoinc => :isbtipoinc);
  -- Convert false/true/null to 0/1/null 
  :result := sys.diutil.bool_to_int(result);
end;
4
result
1
0
3
inuidcontrato
1
8001
4
inuoperatingunit
1
3357
4
isbtipoinc
1
I
5
0
