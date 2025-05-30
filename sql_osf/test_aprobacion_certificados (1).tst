PL/SQL Developer Test script 3.0
9
begin
  -- Call the procedure
  LDCI_PROUPDOBSTATUSCERTOIAWS(inuCertiOia => :inuCertiOia,
                               IsbStatus => :IsbStatus,
                               IsbObser => :IsbObser,
                               IdtFechapro => :IdtFechapro,
                               OnuCodigo => :OnuCodigo,
                               OsbMensaje => :OsbMensaje);
end;
6
inuCertiOia
1
4497813
4
IsbStatus
1
A
5
IsbObser
1
SE APRUEBA CERTIFICADO DE INSPECCION ANDRES ANGULO
5
IdtFechapro
1
17/12/2024 11:41:55 a. m.
12
OnuCodigo
1
0
4
OsbMensaje
1
El estado de la inspecci?n 1100322700 fue cambiado a  APROBADO. 
5
0
