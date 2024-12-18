CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUVALIPROCESPPAGO" ( inuSolicitud IN MO_PACKAGES.PACKAGE_ID%TYPE,
                                                   inuEntity  IN NUMBER)  RETURN NUMBER IS
  /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-02-15
        Ticket      : 200-2431
        Descripcion : retorna si la venta espera o no pago

        Parametros Entrada
        inuSolicitud numero de solicitud
        nuSesion   Sesion

        Valor de salida
          retorna 0 si espera pago o 1 sino espera
       sbErrorMessage mensaje de error.

        nuError  codigo del error
        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
      ***************************************************************************/

    --se valida si la venta requiere pago o espera pago
    CURSOR cuValidaEsperaPago IS
    SELECT DECODE(CF_BOSTATEMENTSWF.FSBWAITFORPAYMENT(inuSolicitud, inuEntity, 100255, 100254),'Y',1,0) +
           (SELECT  COUNT(1)
            FROM mo_gas_sale_data a, 
                 mo_packages b, 
                 CUPON C
            WHERE b.package_id = inuSolicitud
                AND b.package_id = a.package_id
                AND C.Cupodocu = TO_CHAR(B.Package_Id)
                AND C.Cupoflpa = 'N'
                AND INIT_PAY_RECEIVED = 'N'
                AND INITIAL_PAYMENT > 0 )
    FROM dual;

     nuValiEspePago NUMBER;

    nuValorEspe NUMBER := 1;

    csbCodigoCaso  constant VARCHAR2(100) := '200-2431';

BEGIN
  --se valida aplica entrega a la gasera
  IF fblAplicaEntregaxCaso(csbCodigoCaso) THEN
     -- se carga informacion de espera pago
     OPEN cuValidaEsperaPago;
     FETCH cuValidaEsperaPago INTO nuValiEspePago;
     IF cuValidaEsperaPago%NOTFOUND THEN
       RETURN nuValorEspe;
     END IF;
     CLOSE cuValidaEsperaPago;

     --se valida si espera pago o no
     IF nuValiEspePago = 2 THEN
        nuValorEspe := 1;
     ELSE
       nuValorEspe := 0;
     END IF;
  END IF;

  RETURN nuValorEspe;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 1;
END LDC_FNUVALIPROCESPPAGO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUVALIPROCESPPAGO', 'ADM_PERSON');
END;
/