PL/SQL Developer Test script 3.0
11
begin
  -- Call the procedure
  personalizaciones.pkg_boreportes_sui_atc.prcreportesuianexoa(inuano => :inuano,
                                                               inumes => :inumes,
                                                               isbruta => :isbruta,
                                                               isbcorreo => :isbcorreo,
                                                               isbregenera => :isbregenera,
                                                               inusesion => :inusesion,
                                                               isbusuario => :isbusuario,
                                                               isbempresa => :isbempresa);
end;
8
inuano
1
2026
4
inumes
1
1
4
isbruta
1
/smartfiles/tmp
5
isbcorreo
1
jvaliente@horbath.com
5
isbregenera
1
Y
5
inusesion
1
123456789
4
isbusuario
1
JHOESC
5
isbempresa
1
GDGU
5
0
