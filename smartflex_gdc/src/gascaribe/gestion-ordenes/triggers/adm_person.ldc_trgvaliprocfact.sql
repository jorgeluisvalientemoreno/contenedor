create or replace TRIGGER adm_person.LDC_TRGVALIPROCFACT BEFORE
UPDATE
  OF order_status_id ON or_order REFERENCING NEW AS NEW OLD AS OLD 
FOR EACH ROW
  WHEN
  (
    new.order_status_id = 8
  )
  /**************************************************************************
  Proceso     : LDC_TRGVALIPROCFACT
  Autor       :  Horbath
  Fecha       : 2020-11-23
  Ticket      : 461
  Descripcion : trigger para validar que no se legalice ordenes de trabajo de cambio de medidor cuando 
                existan un porceso de facturacion pendiente
  Parametros Entrada
  Parametros de salida
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       			DESCRIPCION
  17-10-2024 jpinedc				OSF-3450: Se migra a ADM_PERSON  
  ***************************************************************************/
 DECLARE
 
  
  sbTitr VARCHAR2(400) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TITRCMVPF', NULL); 
  
  nuPerioactual NUMBER;
  nuExiste NUMBER;
  sbPeriCier VARCHAR2(4);
  
  --se consulta si el periodo actual del ciclo del producto de la orden esta en proceso de facturacion
  CURSOR cuGetPerioActual IS
  SELECT pefacodi
  FROM perifact, procejec
  WHERE pefaactu = 'S'
   AND PREJCOPE = pefacodi
   AND PREJPROG = 'FCRI'
   AND pefacicl = (select sesucicl
                   from servsusc, or_order_activity oa
				   where oa.order_id = :NEW.ORDER_ID
				     AND oa.product_id = sesunuse
					);
					 
    
	CURSOR cugetExisteCierre IS
	SELECT 'X'
	FROM procejec 
	WHERE pREJCOPE = nuPerioactual
	  AND PREJPROG = 'FCPE'
	  AND PREJESPR = 'T';
	  
BEGIN
  IF FBLAPLICAENTREGAXCASO('0000461') THEN
     
	   SELECT COUNT(1) INTO nuExiste
     FROM (
            SELECT to_number(regexp_substr(sbTitr,'[^,]+', 1, LEVEL)) TITR
            FROM   dual 
            CONNECT BY regexp_substr(sbTitr, '[^,]+', 1, LEVEL) IS NOT NULL)
     WHERE TITR = :NEW.TASK_TYPE_ID;
	 
	 
     IF nuExiste > 0 THEN
         OPEN cuGetPerioActual;
         FETCH cuGetPerioActual INTO nuPerioactual;
         CLOSE cuGetPerioActual;
         
         IF nuPerioactual IS NOT NULL then
            OPEN cugetExisteCierre;
            FETCH cugetExisteCierre INTO sbPeriCier;
            CLOSE cugetExisteCierre;
         
            IF sbPeriCier IS NULL THEN
              ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No se puede legalizar orden de trabajo, ya que el producto se encuentra en proceso de facturacion.');  	  
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
END;
/