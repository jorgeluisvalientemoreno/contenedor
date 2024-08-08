PL/SQL Developer Test script 3.0
12
declare
  -- Non-scalar parameters require additional processing 
  ircorden daor_order.styOr_order;

begin
  -- Call the procedure
  daor_order.getrecord( 156845264, ircorden);


  ge_bonotifmesgalert.procstaorderforalert(ircorden => ircorden,
                                           inuestadoini => :inuestadoini);
end;
1
inuestadoini
1
5
3
1
TBALERTAS(NUINDEX).MESG_ALERT_ID
