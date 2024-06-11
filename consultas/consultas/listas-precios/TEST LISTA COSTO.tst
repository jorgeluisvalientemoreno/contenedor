PL/SQL Developer Test script 3.0
12
begin
  -- Call the procedure
  "OPEN".ge_bccertcontratista.obtenercostoitemlista(inuiditem => :inuiditem,
                                             inufechaassignacion => :inufechaassignacion,
                                             inugeolocationid => :inugeolocationid,
                                             inucontratista => :inucontratista,
                                             inuunidadoper => :inuunidadoper,
                                             inucontract => :inucontract,
                                             onuidlistacosto => :onuidlistacosto,
                                             onucostoitem => :onucostoitem,
                                             onuprecioventaitem => :onuprecioventaitem);
end;
9
inuiditem
1
100004433
4
inufechaassignacion
1
30/11/2019
12
inugeolocationid
1
95
3
inucontratista
0
3
inuunidadoper
1
3032
4
inucontract
0
4
onuidlistacosto
1
3077
3
onucostoitem
1
4000
4
onuprecioventaitem
1
5000
4
0
