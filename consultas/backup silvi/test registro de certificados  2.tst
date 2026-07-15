PL/SQL Developer Test script 3.0
27
declare 
 --sbartefact varchar2(4000):= '<Artefactos><idArtefacto>10</idArtefacto></Artefactos>';
sbdefect varchar2(4000):= '<Defectos><idDefecto>56</idDefecto><idDefecto>68</idDefecto></Defectos>';
begin
  -- Call the procedure
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
                                                    icudefnocritico => :icudefnocritico  /*sbdefect*/,
                                                    ISBAPROBADO => :ISBAPROBADO,
                                                    iSBMatricula => :iSBMatricula,
                                                    isbUrl => :isbUrl,
                                                    inuOrderid => :inuOrderid,
                                                    inuCodigoOrganismo => :inuCodigoOrganismo,
                                                    sbVacioInterno => :sbVacioInterno,
                                                    dtFechaReg => :dtFechaReg,
                                                    cumensaje => :cumensaje);
end;
21
inucontratoid
1
67458678
4
idtfechainspe
1
24/09/2023
12
inutipoinspec
1
1
3
isbcertificado
1
c_29417097
5
inuorganismoid
1
4211
4
inuinspector
1
1007893sil
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
11/04/2025
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
ISBAPROBADO
1
S
5
iSBMatricula
0
5
isbUrl
0
5
inuOrderid
1
294170907
4
inuCodigoOrganismo
1
22
3
sbVacioInterno
1
N
5
dtFechaReg
1
8/11/2023
12
cumensaje
1
<Cursor>
116
0
