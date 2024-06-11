PL/SQL Developer Test script 3.0
8
declare
  sxmlotxml clob:='<?xml version="1.0" encoding="UTF-8"?><legalizacionOrden><orden><idOrden>105593716</idOrden><idCausal>9074</idCausal><idTecnico>15902</idTecnico><fechaIniEjec>17/08/18</fechaIniEjec><fechaFinEjec>17/08/18</fechaFinEjec><ordenesAdic><ordenAdic><idTipoTrab>10714</idTipoTrab><idActividad>100003632</idActividad><idCausal>9074</idCausal><observacion>//SE REALIZO LA GESTION COMPLETA</observacion><idTecnico>15902</idTecnico><items><item><idItem>100004422</idItem><cantidad>4.0000</cantidad></item></items></ordenAdic></ordenesAdic></orden></legalizacionOrden>';
begin
  -- Call the procedure
  ldci_botrabajoadicional.prolegalizaotxml(sxmlotxml => sxmlotxml,
                                           sbmensa => :sbmensa,
                                           error => :error);
end;
3
sxmlotxml
1
<CLOB>
-112
sbmensa
1
Orden [105593716] Registrada Correctamente en el sistema LEGO
5
error
1
0
4
0
