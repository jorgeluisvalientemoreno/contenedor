PL/SQL Developer Test script 3.0
29
begin
  -- Call the procedure
  --esto es para ejecutar por plsql
  --para enviar defectos se debe enviar con la siguiente estructura
  --<Defectos><idDefecto>85</idDefecto></Defectos>;
  --para enviar artefactos se debe enviar con la siguiente estructura
  --<Artefactos><idArtefacto>9</idArtefacto></Artefactos>
  ldci_pkrevisionperiodicaweb.proregisternewcertirp(inucontratoid => :inucontratoid,
                                                    idtfechainspe => :idtfechainspe,
                                                    inutipoinspec => :inutipoinspec,
                                                    isbcertificado => :isbcertificado,
                                                    inuorganismoid => :inuorganismoid,
                                                    inuinspector => :inuinspector,
                                                    isbnombre_inspector => :isbnombre_inspector,
                                                    isbcodigosic => :isbcodigosic,
                                                    idtfechavigencia => :idtfechavigencia,
                                                    inuresultado_inspeccion => :inuresultado_inspeccion,
                                                    isbred_individual => :isbred_individual,
                                                    icuartefactos => :icuartefactos,
                                                    icudefnocritico => :icudefnocritico,
                                                    isbaprobado => :isbaprobado,
                                                    isbmatricula => :isbmatricula,
                                                    isburl => :isburl,
                                                    inuorderid => :inuorderid,
                                                    inucodigoorganismo => :inucodigoorganismo,
                                                    sbvaciointerno => :sbvaciointerno,
                                                    dtfechareg => :dtfechareg,
                                                    cumensaje => :cumensaje);
end;
21
inucontratoid
1
1510115
4
idtfechainspe
1
18/08/2022 3:17:00 p. m.
12
inutipoinspec
1
1
3
isbcertificado
1
C_233121377
5
inuorganismoid
1
2734
4
inuinspector
1
diana
5
isbnombre_inspector
1
PRUEBA
5
isbcodigosic
0
5
idtfechavigencia
1
1/01/2023
12
inuresultado_inspeccion
1
1
3
isbred_individual
1
Y
5
icuartefactos
1
<CLOB>
112
icudefnocritico
1
<CLOB>
112
isbaprobado
1
N
5
isbmatricula
0
5
isburl
0
5
inuorderid
1
233121377
4
inucodigoorganismo
1
1
3
sbvaciointerno
1
S
5
dtfechareg
0
12
cumensaje
1
<Cursor>
116
0
