PL/SQL Developer Test script 3.0
5
begin
  -- Call the procedure
  execute immediate 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
  ldc_bometrologia.valcertificaelemento;
end;
0
3
sbValorMedio
nuItemSeriado
