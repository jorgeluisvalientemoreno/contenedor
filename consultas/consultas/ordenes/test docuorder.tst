PL/SQL Developer Test script 3.0
8
DECLARE
  sbdefect varchar2(4000):= '<estadoDocOrden><idExterno>24116073</idExterno><idOrden>11150124</idOrden><estado>AR</estado><fechaEstado>05/04/2018 04:14:00 p.m.</fechaEstado></estadoDocOrden>';
begin
  -- Call the procedure
  porupdatestatusdocord(cxml => sbdefect,
                        onuerrorcode => :onuerrorcode,
                        osberrormessage => :osberrormessage);
end;
3
cxml
1
<CLOB>
-112
onuerrorcode
1
-1
4
osberrormessage
3
Error en el proceso PORUPDATESTATUSDOCORD ORA-20001: La orden 11150124 No se encuentra en estado terminal. [1043356006]
ORA-06512: at "OPEN.LDC_TRG_BIDOCUORDER", line 18
ORA-04088: error during execution of trigger 'OPEN.LDC_TRG_BIDOCUORDER'
5
0
