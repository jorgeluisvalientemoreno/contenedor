CREATE OR REPLACE TRIGGER ADM_PERSON.TGR_IA_OPERATING_UNIT
BEFORE UPDATE OF
	OPER_UNIT_CODE,
	NAME,
	LEGALIZE_PASSWORD,
	ASSIGN_TYPE,
	ADDRESS,
	PHONE_NUMBER,
	E_MAIL,
	WORK_DAYS,
	FATHER_OPER_UNIT_ID,
	OPER_UNIT_STATUS_ID,
	OPERATING_SECTOR_ID,
	OPER_UNIT_CLASSIF_ID,
	ORGA_AREA_ID,
	PASSWORD_REQUIRED,
	AIU_VALUE_ADMIN,
	AIU_VALUE_UTIL,
	AIU_VALUE_UNEXPECTED,
	GEOCODE,
	ES_EXTERNA,
	ES_INSPECCIONABLE,
	CONTRACTOR_ID,
	ADMIN_BASE_ID,
	UNIT_TYPE_ID,
	ADD_VALUE_ORDER,
	OPERATING_CENTER_ID,
	COMPANY_ID,
	STARTING_ADDRESS,
	UNASSIGNABLE,
	NOTIFICABLE,
	ASSO_OPER_UNIT,
	GEN_ADMIN_ORDER,
	OPERATING_ZONE_ID,
	VALID_FOR_ASSIGN,
	SUBSCRIBER_ID
ON OR_OPERATING_UNIT
/*******************************************************************************
    Propiedad intelectual de CSC

    Trigger     : TGR_IA_OPERATING_UNIT

    Descripcion : Trigger que verifica que el responsable de la unidad operativa
                  haya sido ingresado obligatoriamente en el momento de crear
                  dicha unidad operativa.

    Autor      : Eduardo Ceron
    Fecha      : 15/01/2019

    Historia de Modificaciones
    Fecha       ID Entrega  Modificacion
    21/10/2024  OSF-3450    Se migra a ADM_PERSON
*******************************************************************************/
FOR EACH ROW

DECLARE

  sbEntrega varchar2(100) := '200_2322';
  sbValueParam varchar2(100) := dald_parameter.fsbGetValue_Chain('CLASSIF_UNIT_PERSON',0);


  CURSOR cuValidaOr IS
  SELECT 'X'
  FROM or_operating_unit o
  WHERE o.operating_unit_id = :new.operating_unit_id;

  cursor cuPerson
  IS
    select  count(1)
    from    or_oper_unit_persons
    where   or_oper_unit_persons.operating_unit_id = :new.operating_unit_id;

  cursor curDatos(inuDato IN VARCHAR2) is
    select regexp_substr(inuDato,'[^,]+', 1, level) as valores
    from   dual
    connect by regexp_substr(inuDato, '[^,]+', 1, level) is not null;

  sbDato VARCHAR2(1);

  erValidacion EXCEPTION;
  rwDatos curDatos%rowtype;
  nuFlagValida NUMBER := 0;
  nuPerson     NUMBER;

BEGIN
    ut_trace.Trace('Inicio: TGR_IA_OPERATING_UNIT', 10);

    OPEN curDatos(sbValueParam);
    LOOP
    FETCH curDatos INTO rwDatos;
    EXIT WHEN curDatos%NOTFOUND;

        IF TO_CHAR(:new.OPER_UNIT_CLASSIF_ID) = TO_CHAR(rwDatos.VALORES) THEN

            nuFlagValida := 1;

        END IF;

    END LOOP;
    CLOSE curDatos;

    /*open cuPerson;
    fetch cuPerson INTO nuPerson;
    CLOSE cuPerson;*/

    IF fblaplicaentregaxcaso(sbEntrega) AND nuFlagValida = 1 /*AND nuPerson > 0*/ THEN

      IF  :new.PERSON_IN_CHARGE is null Then --and :new.USED_ASSIGN_CAP=:old.USED_ASSIGN_CAP THEN
        ut_trace.Trace('El responsable debe ser ingresado obligatoriamente en la unidad :'||:new.operating_unit_id, 10);
        RAISE erValidacion;
      END IF;
    END IF;

  ut_trace.Trace('Fin: TGR_IA_OPERATING_UNIT', 10);

EXCEPTION
  WHEN erValidacion THEN
      errors.seterror(2741, 'El campo responsable debe ser ingresado obligatoriamente en la unidad: '||:new.operating_unit_id);
      RAISE EX.CONTROLLED_ERROR;
   WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;
    WHEN others THEN
          errors.seterror;
          RAISE EX.CONTROLLED_ERROR;

END TGR_IA_OPERATING_UNIT;
/
