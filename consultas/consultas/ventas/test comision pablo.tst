PL/SQL Developer Test script 3.0
11
declare
  -- Non-scalar parameters require additional processing 
  result open.ldc_bcsalescommission_nel.rgcommissionregister;
begin
  -- Call the function
  result := open.ldc_bcsalescommission_nel.fnugetcommissionvalue(isbtime => :isbtime,
                                                                 inupackageid => :inupackageid,
                                                                 inuaddressid => :inuaddressid,
                                                                 inuproductid => :inuproductid,
                                                                 inuoperatingunit => :inuoperatingunit);
end;
5
isbtime
1
B
5
inupackageid
1
180295804
4
inuaddressid
1
3960062
4
inuproductid
1
52300432
4
inuoperatingunit
1
4022
4
0
