PL/SQL Developer Test script 3.0
9
begin
  -- Call the procedure
  ldci_pkinterfazordlec.prolegalizarorden(isbdataorder => :isbdataorder,
                                          idtinitdate => :idtinitdate,
                                          idtfinaldate => :idtfinaldate,
                                          idtchangedate => :idtchangedate,
                                          resultado => :resultado,
                                          msj => :msj);
end;
6
isbdataorder
1
119972252|3038|4124|No_PLIEGO=24023300308;FECH_PLIE_CARG=30/10/2023 12:00:00 a. m.|128595514>1;;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||3;legalizado por:VIVIAN MARCELA ROCHA CABARCA
5
idtinitdate
1
30/10/2023 10:43:45 a. m.
12
idtfinaldate
1
30/10/2023 11:03:45 a. m.
12
idtchangedate
1
30/10/2023 11:03:45 a. m.
12
resultado
1
0
4
msj
1
Legalizo correctamente
5
0
