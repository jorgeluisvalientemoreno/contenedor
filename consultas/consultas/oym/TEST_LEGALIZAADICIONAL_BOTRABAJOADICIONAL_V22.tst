PL/SQL Developer Test script 3.0
6
begin
  -- Call the procedure
  ldc_botrabajoadicional.prolegalizaotxml(sxmlotxml => '',
                                          sbmensa => :sbmensa,
                                          error => :error);
end;
3
sxmlotxml
1
<CLOB>
-112
sbmensa
1
Corrija la fecha inicial de ejecución de la orden, la cual debe ser: 18/05/2017 [852775312] [852775313]
5
error
1
2741
4
1
xmlotxml2
