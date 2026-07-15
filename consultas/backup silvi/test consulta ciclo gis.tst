PL/SQL Developer Test script 3.0
9
begin
  -- Call the procedure
  personalizaciones.ldci_pkg_bointegragis.prcobtenerciclo(inudepartamento => :inudepartamento,
                                                          inucategoria => :inucategoria,
                                                          inusubcategoria => :inusubcategoria,
                                                          oclrespuesta => :oclrespuesta,
                                                          onucodigoerror => :onucodigoerror,
                                                          osbmensajeerror => :osbmensajeerror);
end;
6
inudepartamento
1
3
4
inucategoria
1
3
4
inusubcategoria
1
1
4
oclrespuesta
1
<CLOB>
112
onucodigoerror
1
0
4
osbmensajeerror
1
SUCCESS - "CICLO":1801
5
1
sbParametro
