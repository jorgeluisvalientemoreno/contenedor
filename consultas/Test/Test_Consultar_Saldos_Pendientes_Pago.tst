PL/SQL Developer Test script 3.0
10
declare
 datos clob:='<?xml version = "1.0" encoding="utf-8"?><Saldos_Contrato><Cod_Contrato>2176412</Cod_Contrato></Saldos_Contrato>';
begin
  -- Call the procedure
  os_balancetopay(inureference => :inureference,
                       inureferenceparam => datos,
                       osbunpaiddebt => :osbunpaiddebt,
                       onuerrorcode => :onuerrorcode,
                       osberrormessage => :osberrormessage);
end;
5
inureference
1
2
4
inureferenceparam
1
<CLOB>
-112
osbunpaiddebt
1
<CLOB>
112
onuerrorcode
1
0
4
osberrormessage
0
5
0
