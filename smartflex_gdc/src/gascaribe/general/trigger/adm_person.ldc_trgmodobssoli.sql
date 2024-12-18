CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGMODOBSSOLI
BEFORE INSERT ON MO_PACKAGES
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
/**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2021-02-25
    Ticket      : 472
    Proceso     : LDC_TRGMODOBSSOLI
    Descripcion : trigger que coloca comentario de unidad a la obsrvacion de la solicitud

    Parametros Entrada

    Valor de salida

   HISTORIA DE MODIFICACIONES
    FECHA           AUTOR       DESCRIPCION
    21/10/2024      jpinedc     OSF-3450: Se migra a ADM_PERSON
  ***************************************************************************/
DECLARE
    sbTitrVali VARCHAR2(4000) := DALDC_PARAREPE.FSBGETPARAVAST('LDC_TITRCUNOP', NULL);
	sbNombreunidad VARCHAR2(400);

	CURSOR cuObtiNombreUnidad IS
	SELECT '['||o.OPERATING_UNIT_ID||' - '||DAOR_OPERATING_UNIT.FSBGETNAME(o.OPERATING_UNIT_ID,NULL)||'] ' nombre_unidad
	FROM or_order o, or_order_activity oa, mo_motive m
	WHERE m.package_id = :NEW.PACKAGE_ID
	  AND m.product_id = oa.product_id
			AND o.order_id = oa.order_id
			AND o.task_type_id in (SELECT to_number(regexp_substr(sbTitrVali,'[^,]+', 1, LEVEL)) AS titr
																										FROM   dual
																											CONNECT BY regexp_substr(sbTitrVali, '[^,]+', 1, LEVEL) IS NOT NULL  )
			AND o.order_status_id = 8
			AND dage_causal.fnugetCLASS_CAUSAL_ID(o.causal_id,null) = 1
		order by o.LEGALIZATION_DATE DESC;
BEGIN
  IF FBLAPLICAENTREGAXCASO('0000472') AND :NEW.PACKAGE_TYPE_ID = 100294 THEN
	   OPEN cuObtiNombreUnidad;
	   FETCH cuObtiNombreUnidad INTO sbNombreunidad;
	   IF cuObtiNombreUnidad%found THEN
		   :NEW.COMMENT_ := SUBSTR(sbNombreunidad||:NEW.COMMENT_,0,1999);
	   END IF;
	  CLOSE cuObtiNombreUnidad;

  END IF;
EXCEPTION
  WHEN OTHERS THEN
	ERRORS.SETERROR;
	RAISE ex.controlled_error;
END LDC_TRGMODOBSSOLI;
/
