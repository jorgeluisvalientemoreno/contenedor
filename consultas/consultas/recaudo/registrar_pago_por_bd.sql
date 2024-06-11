DECLARE
    onuErrorCode NUMBER;
    osbErrorMessage VARCHAR(2000);
    osbxmlcoupons VARCHAR(2000);
BEGIN
    "OPEN".LDCI_PKBSSRECA.proPaymentRegister(1, '<?xml version="1.0" encoding="utf-8" ?><Pago_Cupon><Cupon>216404046</Cupon></Pago_Cupon>', '<?xml version="1.0" encoding="utf-8" ?>
<Informacion_Pago>
  <Conciliacion>
    <Cod_Conciliacion></Cod_Conciliacion>
    <Entidad_Conciliacion>700</Entidad_Conciliacion>
    <Fecha_Conciliacion>19-07-2023</Fecha_Conciliacion>
  </Conciliacion>
  <Entidad_Recaudo>700</Entidad_Recaudo>
  <Punto_Pago>1</Punto_Pago>
  <Valor_Pagado>250000</Valor_Pagado>
  <Fecha_Pago>19-07-2023</Fecha_Pago>
  <No_Transaccion>1</No_Transaccion>
  <Forma_Pago>EF</Forma_Pago>
  <Clase_Documento></Clase_Documento>
  <No_Documento></No_Documento>
  <Ent_Exp_Documento></Ent_Exp_Documento>
  <No_Autorizacion></No_Autorizacion>
  <No_Meses></No_Meses>
  <No_Cuenta></No_Cuenta>
  <Programa>OS_PAYMENT</Programa>
  <Terminal>Desconocida</Terminal>
</Informacion_Pago>', osbxmlcoupons, onuErrorCode, osbErrorMessage);
    DBMS_OUTPUT.PUT_LINE('Output: ' || onuErrorCode || ': ' || osbErrorMessage || ' - ' || osbxmlcoupons);
    COMMIT;
END;