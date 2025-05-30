CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_BIUD_BODEGAUNIDAD
BEFORE INSERT OR DELETE  OR UPDATE OF QUOTA,OCCACIONAL_QUOTA  ON OR_OPE_UNI_ITEM_BALA
/*******************************************************************************
    Propiedad intelectual de CSC

    Trigger     : LDC_TRG_BIUD_BODEGAUNIDAD

    Descripcion : Trigger que verifica que el responsable de la unidad operativa
                  haya sido ingresado obligatoriamente en el momento actualizar
				  unidad operativa

    Autor      : Eduardo Ceron
    Fecha      : 15/01/2019

    Historia de Modificaciones
    Fecha   ID Entrega
    Modificacion

*******************************************************************************/
FOR EACH ROW

DECLARE

  sbEntrega varchar2(100) := '200_2322';
  sbValueParam varchar2(100) := dald_parameter.fsbGetValue_Chain('CLASSIF_UNIT_PERSON',0);
  sbexecutable open.ld_parameter.value_chain%type;


  CURSOR cuValidaOr IS
  SELECT person_in_charge
  FROM or_operating_unit o
  WHERE o.operating_unit_id = :new.operating_unit_id;


  cursor curDatos(inuDato IN VARCHAR2) is
    select regexp_substr(inuDato,'[^,]+', 1, level) as valores
    from   dual
    connect by regexp_substr(inuDato, '[^,]+', 1, level) is not null;

  nuResponsable open.or_operating_unit.person_in_charge%type;

  erValidacion EXCEPTION;
  rwDatos curDatos%rowtype;
  nuFlagValida NUMBER := 0;
  nuPerson     NUMBER;

BEGIN
    ut_trace.Trace('Inicio: LDC_TRG_BIUD_BODEGAUNIDAD', 10);

    OPEN curDatos(sbValueParam);
    LOOP
    FETCH curDatos INTO rwDatos;
    EXIT WHEN curDatos%NOTFOUND;

        IF TO_CHAR(open.daor_operating_unit.fnugetoper_unit_classif_id(nvl(:new.operating_unit_id, :old.operating_unit_id),null)) = TO_CHAR(rwDatos.VALORES) THEN

            nuFlagValida := 1;

        END IF;

    END LOOP;
    CLOSE curDatos;



    IF fblaplicaentregaxcaso(sbEntrega) AND nuFlagValida = 1 THEN

		Begin
			sbexecutable := ut_session.getmodule; --sa_boexecutable.getexecutablename;
		Exception
		When Others Then
			sbexecutable := Null;
		End;

		IF INSTR(DALD_PARAMETER.FSBGETVALUE_CHAIN('EXEC_VAL_RESPON_SALDOS_UNIDAD',NULL), UPPER(sbexecutable))>0 THEN

		  OPEN cuValidaOr;
		  FETCH cuValidaOr INTO nuResponsable;
		  IF nuResponsable is null THEN
			 CLOSE cuValidaOr;
			 ut_trace.Trace('El responsable de la unidad debe ser ingresado obligatoriamente', 10);
			   RAISE erValidacion;
		  END IF;
		  CLOSE cuValidaOr;
		END IF;
    END IF;

  ut_trace.Trace('Fin: LDC_TRG_BIUD_BODEGAUNIDAD', 10);

EXCEPTION
  WHEN erValidacion THEN
      errors.seterror(2741, 'El campo responsable debe ser ingresado obligatoriamente en la unidad: '||:new.operating_unit_id);
      RAISE EX.CONTROLLED_ERROR;
   WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;
    WHEN others THEN
          errors.seterror;
          RAISE EX.CONTROLLED_ERROR;

END LDC_TRG_BIUD_BODEGAUNIDAD;
/
