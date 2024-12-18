CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALUSUSINMED  BEFORE UPDATE  ON LECTELME
FOR EACH ROW
WHEN (NEW.LEEMFELE IS NOT NULL and NEW.LEEMCLEC='F')
  /**************************************************************************
  Proceso     : LDC_TRGVALUSUSINMED
  Autor       : Luis Javier Lopez/ Horbath
  Fecha       : 2020-12-07
  Ticket      : 337
  Descripcion : trigger para generar actividad cuando s einserte una lectura

    Parametros Entrada
    Parametros de salida
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    17/05/2021  horbath     CA 693 se valide que el producto no tenga una orden en proceso
                            y cambiar comentario de generacion de la orden
    21/10/2024  jpinedc     OSF-3450: Se migra a ADM_PERSON
  ***************************************************************************/
declare
  nuActividad   number := daldc_pararepe.fnugetparevanu('ACT_VISITA_TECNICAXSUSP', null);
  sbObsLectExcl VARCHAR2(400) := Daldc_pararepe.fsbGetPARAVAST('OBSLEC_EXC_RP', null);
  sbComeLega    VARCHAR2(400) := Daldc_pararepe.fsbGetPARAVAST('COMENT_ORD_AUTO_VISTA_TEC', null);
  sbMotiSinMe   VARCHAR2(400) := Daldc_pararepe.fsbGetPARAVAST('MOTIEXCLU_SINMEDIRP', null);


   OnuOrderId     NUMBER;
  OnuOrderActivityId NUMBER;
  sbexiste VARCHAR2(1);

  nuerror  NUMBER;
  sberror  VARCHAR2(4000);

  CURSOR cuExisteExcl IS
  SELECT 'x'
  FROM LDC_PRODEXCLRP
  WHERE PRODUCT_ID = :new.LEEMSESU
   AND MOTIVO = sbMotiSinMe
   and (:new.LEEMOBLE not in ( SELECT TO_NUMBER(COLUMN_VALUE)
							 FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS(sbObsLectExcl, ',')))
        or
        :new.leemoble is null);

  cursor cuValdemo is
  SELECT address_id , PRODUCT_ID, SUBSCRIPTION_ID, suscclie
  FROM pr_product , suscripc
  WHERE SUBSCRIPTION_ID = susccodi
    and PRODUCT_ID = :new.LEEMSESU;

 regProd cuValdemo%rowtype;

  --INICIO CA 693
  CURSOR cuValidaOrden(inuproducto IN NUMBER) IS
  SELECT 'X'
  FROM or_order o, or_order_activity oa
  WHERE o.order_id = oa.order_id
   AND OA.ACTIVITY_ID = nuActividad
   AND oa.product_id = inuproducto
   AND o.order_status_id NOT IN (SELECT e.order_status_id
                                   FROM or_order_status e
                                   WHERE E.IS_FINAL_STATUS = 'Y');

  sbExisteOrd VARCHAR2(1);
  sbObservacion VARCHAR2(4000);
  --FIN CA 693

begin
  IF fblaplicaentregaxcaso('0000337') THEN
     IF :new.LEEMSESU IS NOT NULL THEN
        OPEN cuExisteExcl;
        FETCH cuExisteExcl INTO sbexiste;
        CLOSE cuExisteExcl;

       IF sbexiste IS  NOT NULL THEN
          OPEN cuValdemo;
          FETCH cuValdemo INTO regProd;
          CLOSE cuValdemo;
          --INICIO CA 693
          IF FBLAPLICAENTREGAXCASO('0000693') THEN
              OPEN cuValidaOrden(regProd.product_id);
              FETCH cuValidaOrden INTO sbExisteOrd;
              CLOSE cuValidaOrden;
              sbObservacion := 'GENERADO DESDE LDC_TRGVALUSUSINMED, POR MOVIMIENTOS EN LA LECTURAS DEL PRODUCTO, FAVOR VALIDAR EXISTENCIA DE MEDIDOR';
          ELSE
             sbObservacion := sbComeLega;
          END IF;


          IF sbExisteOrd IS NULL THEN
             or_boorderactivities.CreateActivity(nuActividad,
                              null, --inuPackage,
                              null, --nuMotive,
                              null,
                              null,
                              regProd.address_id,
                              null,
                              regProd.suscclie,
                              regProd.subscription_id,
                              regProd.product_id,
                              null,
                              null,
                              null,
                              null,
                              sbObservacion,
                              null,
                              null,
                              OnuOrderId,
                              OnuOrderActivityId,
                              null,
                              null,
                              null,
                              null,
                              null,
                              null,
                              null,
                              null,
                              null);
          END IF;
       END IF;
     END IF;
  END IF;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    ERRORS.seterror;
    RAISE EX.CONTROLLED_ERROR;
end LDC_TRGVALUSUSINMED;
/
