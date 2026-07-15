PL/SQL Developer Test script 3.0
10
begin
  -- Call the function
  :result := personalizaciones.pkg_xml_soli_rev_periodica.getsolicitudsacrp(inumediorecepcionid => :inumediorecepcionid,
                                                                            isbcomentario => :isbcomentario,
                                                                            inuproductoid => :inuproductoid,
                                                                            inuclienteid => :inuclienteid,
                                                                            idtfechasolicitud => :idtfechasolicitud,
                                                                            inuactividadid => :inuactividadid,
                                                                            inuordenid => :inuordenid);
end;
8
result
0
5
inumediorecepcionid
0
3
isbcomentario
0
5
inuproductoid
0
4
inuclienteid
0
4
idtfechasolicitud
0
12
inuactividadid
0
4
inuordenid
0
4
0
