PL/SQL Developer Test script 3.0
8
begin
  -- Call the procedure
  in_bofw_inrmo_pb.processhistory(isbpk => :isbpk,
                                  inucurrent => :inucurrent,
                                  inutotal => :inutotal,
                                  onuerrorcode => :onuerrorcode,
                                  osberrormess => :osberrormess);
end;
5
isbpk
1
4746045
5
inucurrent
0
4
inutotal
0
4
onuerrorcode
1
1
4
osberrormess
1
El registro Historico De Mensajes De Interfaz [1722766401] no existe, o no esta autorizado para acceder los datos. [118649358]
5
2
:NEW.TASKTYPE_ID
