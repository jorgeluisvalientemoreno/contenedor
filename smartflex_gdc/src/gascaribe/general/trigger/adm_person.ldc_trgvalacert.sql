CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALACERT  BEFORE
 INSERT  ON PR_CERTIFICATE
FOR EACH ROW
  /**************************************************************************
  Proceso     : LDC_TRGVALACERT
  Autor       : Luis Javier Lopez/ Horbath
  Fecha       : 2020-12-07
  Ticket      : 337
  Descripcion : trigger para eliminar exclusion de un producto cuando ingrese un certificado

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR       DESCRIPCION
  21/10/2024    jpinedc     OSF-3450: Se migra a ADM_PERSON
  ***************************************************************************/
declare

  sbexiste VARCHAR2(1);

  nuerror  NUMBER;
  sberror  VARCHAR2(4000);

  CURSOR cuExisteExcl IS
  SELECT 'x'
  FROM LDC_PRODEXCLRP
  WHERE PRODUCT_ID = :new.PRODUCT_ID;

begin
  IF fblaplicaentregaxcaso('0000337') THEN
     IF :new.PRODUCT_ID IS NOT NULL THEN
	    OPEN cuExisteExcl;
		FETCH cuExisteExcl INTO sbexiste;
		CLOSE cuExisteExcl;

		IF sbexiste IS  NOT NULL THEN
			delete from LDC_PRODEXCLRP where PRODUCT_ID = :new.PRODUCT_ID;
	    END IF;
     END IF;
  END IF;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    ERRORS.seterror;
    RAISE EX.CONTROLLED_ERROR;
end LDC_TRGVALACERT;
/
