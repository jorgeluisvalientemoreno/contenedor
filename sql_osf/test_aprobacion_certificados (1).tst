PL/SQL Developer Test script 3.0
10
begin
  -- Call the procedure
  LDCI_PROUPDOBSTATUSCERTOIAWS(inuCertiOia => :inuCertiOia,
                               IsbStatus => :IsbStatus,
                               IsbObser => :IsbObser,
                               IdtFechapro => :IdtFechapro,
                               OnuCodigo => :OnuCodigo,
                               OsbMensaje => :OsbMensaje);
                               --4677140
end;
6
inuCertiOia
1
4677140
4
IsbStatus
1
A
5
IsbObser
1
SE APRUEBA CERTIFICADO DE INSPECCION JESSICA
5
IdtFechapro
1
10/11/2025
12
OnuCodigo
1
0
4
OsbMensaje
1
El estado de la inspecci?n 123456780 fue cambiado a  APROBADO. 
5
0
