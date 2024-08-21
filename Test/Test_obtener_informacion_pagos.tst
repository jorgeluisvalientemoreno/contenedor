PL/SQL Developer Test script 3.0
10
declare
 datos clob:='<?xml version="1.0" encoding="utf-8" ?><Pagos_Contrato><Contrato>1084287</Contrato><Cantidad>1</Cantidad></Pagos_Contrato>';
begin
  -- Call the procedure
  os_paymentsquery(inureferencia => :inureferencia,
                        icldatosconsultaxml => datos,
                        oclresulconsultaxml => :oclresulconsultaxml,
                        onucodigoerror => :onucodigoerror,
                        osbmensajeerror => :osbmensajeerror);
end;
5
inureferencia
1
2
4
icldatosconsultaxml
1
<CLOB>
-112
oclresulconsultaxml
1
<CLOB>
112
onucodigoerror
1
900416
4
osbmensajeerror
4
Se ha producido un error al interpretar la cadena XML ingresada. [ORA-31011: XML parsing failed
ORA-19202: Error occurred in XML processing
LPX-00104: Warning: element "Saldos_Contrato" is not declared in the DTD
Error at line 1] [1773796425]
5
0
