PL/SQL Developer Test script 3.0
29
begin
  -- Call the procedure
  --esto es para ejecutar por plsql
  --para enviar defectos se debe enviar con la siguiente estructura
  --<Defectos><idDefecto>85</idDefecto></Defectos>
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
0
4
idtfechainspe
0
12
inutipoinspec
0
3
isbcertificado
0
5
inuorganismoid
0
4
inuinspector
0
5
isbnombre_inspector
0
5
isbcodigosic
0
5
idtfechavigencia
0
12
inuresultado_inspeccion
0
3
isbred_individual
0
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
0
5
isbmatricula
0
5
isburl
0
5
inuorderid
0
4
inucodigoorganismo
0
3
sbvaciointerno
0
5
dtfechareg
0
12
cumensaje
1
<Cursor>
116
0
