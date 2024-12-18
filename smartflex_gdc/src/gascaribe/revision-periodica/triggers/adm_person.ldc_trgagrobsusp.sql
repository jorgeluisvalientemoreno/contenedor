CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGAGROBSUSP
BEFORE INSERT ON MO_PACKAGES
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
 /**************************************************************************
  Proceso     : LDC_TRGAGROBSUSP
  Autor       : Horbath
  Fecha       : 2020-01-22
  Ticket      : 176
  Descripcion : inserta en observacion de las solicitudes de RP

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
DECLARE
  sbTipoTramRp VARCHAR2(4000) :=DALDC_PARAREPE.fsbGetPARAVAST('LDC_CODTRAMRPPR', null); --se almacenan tramites de RP
  sbDescActiv VARCHAR2(4000); --se almacena descripcion de la actividad
  nuExiste NUMBER;

  --se consulta descripcion de actividdad
  CURSOR cuGetActividad IS
  SELECT DAGE_ITEMS.FSBGETDESCRIPTION(OA.ACTIVITY_ID,NULL) DESC_ACTI
  FROM MO_MOTIVE p, LDC_PRODRERP PR, OR_ORDER_ACTIVITY OA
  WHERE P.PACKAGE_ID = :new.PACKAGE_ID
    AND P.PRODUCT_ID = PR.PRREPROD
    AND OA.ORDER_ACTIVITY_ID = PR.PRREACTI ;

   --se consulta descripcion de actividdad por cliente
  CURSOR cuGetActividadC IS
  SELECT DAGE_ITEMS.FSBGETDESCRIPTION(OA.ACTIVITY_ID,NULL) DESC_ACTI
  FROM SUSCRIPC p, servsusc se, LDC_PRODRERP PR, OR_ORDER_ACTIVITY OA
  WHERE p.SUSCCLIE = :new.SUBSCRIBER_ID
    AND P.susccodi = se.sesususc
    AND se.sesunuse = PR.PRREPROD
    AND OA.ORDER_ACTIVITY_ID = PR.PRREACTI ;

BEGIN
 IF FBLAPLICAENTREGAXCASO('0000176') THEN
    SELECT COUNT(1) INTO nuExiste
    FROM (
          SELECT to_number(regexp_substr(sbTipoTramRp,'[^,]+', 1, LEVEL)) AS tipotram
          FROM dual
          CONNECT BY regexp_substr(sbTipoTramRp, '[^,]+', 1, LEVEL) IS NOT NULL)
    WHERE tipotram =:NEW.PACKAGE_TYPE_ID;

    IF nuExiste > 0 THEN
       OPEN cuGetActividad;
       FETCH cuGetActividad INTO sbDescActiv;
       IF cuGetActividad%NOTFOUND THEN
          OPEN cuGetActividadC;
          FETCH cuGetActividadC INTO sbDescActiv;
          CLOSE cuGetActividadC;
       END IF;
       CLOSE cuGetActividad;

       IF sbDescActiv IS NOT NULL THEN
         :NEW.COMMENT_ := SUBSTR('['||sbDescActiv||'] '||:NEW.COMMENT_,1,1999);
       END IF;
    END IF;

 END IF;

EXCEPTION
  When Others Then
      null;
END LDC_TRGAGROBSUSP;
/
