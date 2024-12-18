create or replace TRIGGER adm_person.LDC_TRGVALIPLESPCART
BEFORE INSERT OR UPDATE ON GC_DEBT_NEGOTIATION 
FOR EACH ROW 
WHEN (NEW.PAYMENT_METHOD = 'T') 
 /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: LDC_TRGVALIPLESPCART
    Descripcion:        trigger para validar finaciaciones especiales en pago total

    Autor    : Horbath
    Fecha    : 22/12/2021

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
	07-02-2023 	 cgonzalez				OSF-784: Se modifica servicio RAISE_APPLICATION_ERROR por GE_BOERRORS.SETERRORCODEARGUMENT
	14-02-2023 	 cgonzalez				OSF-899: Se modifica consulta para hacer uso de expresion regular al consultar informacion del 
										parametro SPECIALS_PLAN
	17-10-2024 	 jpinedc				OSF-3450: Se migra a ADM_PERSON
 ******************************************************************/
DECLARE
	sbPlanEspecial VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('SPECIALS_PLAN',NULL);
	nuExistePlan NUMBER;
	
	CURSOR cuExistePlan(inuPlan IN NUMBER) IS
		SELECT	count(1)
		FROM 	((SELECT TO_NUMBER(regexp_substr(sbPlanEspecial,'[^|,]+', 1, level)) as plan_id
				FROM DUAL A
				CONNECT BY regexp_substr(sbPlanEspecial, '[^|,]+', 1, level) IS NOT NULL))
		WHERE 	TO_NUMBER(plan_id) = inuPlan;

BEGIN
  IF FBLAPLICAENTREGAXCASO('OSF-105') THEN
     
	 OPEN cuExistePlan(:new.PAYM_AGREEM_PLAN_ID);
	 FETCH cuExistePlan INTO nuExistePlan;
	 CLOSE cuExistePlan;

     IF nuExistePlan > 0 THEN
         prAnulaSoliNego(:new.package_id);
		 GE_BOERRORS.SETERRORCODEARGUMENT(-20101, 'No se puede registrar financiacion pago total con un plan de diferido especial, la solicitud sera anulada.');
        
     END IF;

  END IF;
EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      RAISE EX.CONTROLLED_ERROR;
    WHEN others THEN
      errors.seterror;
      RAISE EX.CONTROLLED_ERROR;
END;
/