PL/SQL Developer Test script 3.0
12
begin
  -- Call the procedure
  "OPEN".ct_boliquidationsupport.getlistitemvalue(inuitemid => :inuitemid,
                                           idtdate => :idtdate,
                                           inuoperatingunit => :inuoperatingunit,
                                           inucontract => :inucontract,
                                           inucontractor => :inucontractor,
                                           inugeolocation => :inugeolocation,
                                           isbtype => :isbtype,
                                           onupricelistid => :onupricelistid,
                                           onuvalue => :onuvalue);
end;
9
inuitemid
1
100004670
4
idtdate
1
28/08/2019
12
inuoperatingunit
1
2753
4
inucontract
0
4
inucontractor
0
3
inugeolocation
1
136
3
isbtype
1
1
4
onupricelistid
1
2792
3
onuvalue
1
5000
4
0
