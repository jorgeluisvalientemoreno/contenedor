PL/SQL Developer Test script 3.0
4
begin
  -- Call the function
  :result := "LD_BOCONSTANS".frfSentence(isbSelect => :isbSelect);
end;
2
result
1
<Cursor>
116
isbSelect
1
select servicio_origen, servicio_destino from homologacion_servicios where servicio_origen is not null group by servicio_origen, servicio_destino
5
0
