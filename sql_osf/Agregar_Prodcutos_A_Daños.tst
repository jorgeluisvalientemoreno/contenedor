PL/SQL Developer Test script 3.0
7
begin
  -- Call the procedure
  os_addprodtooutage(inufaultid => :inufaultid,
                     isbaffectedprods => :isbaffectedprods,
                     onuerrorcode => :onuerrorcode,
                     osberrormessage => :osberrormessage);
end;
4
inufaultid
1
186548862
4
isbaffectedprods
1
1155258|1999619|50542153|2064600|50608410
5
onuerrorcode
1
1
4
osberrormessage
1
El registro Solicitudes [186548862] no existe, o no esta autorizado para acceder los datos. [976525675]
5
0
