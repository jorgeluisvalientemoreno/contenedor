PL/SQL Developer Test script 3.0
5
begin
  -- Call the function
  :result := pkholidaymgr.fnugetnumofdaynonholiday(idtfechaini => :idtfechaini,
                                                   idtfechafin => :idtfechafin);
end;
3
result
1
1
4
idtfechaini
1
4/08/2020
12
idtfechafin
1
5/08/2020
12
0
