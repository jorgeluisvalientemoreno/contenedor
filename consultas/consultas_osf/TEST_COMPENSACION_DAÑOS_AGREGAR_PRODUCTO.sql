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
50542153|2064600|50608410
5
onuerrorcode
1
0
4
osberrormessage
0
5
0
