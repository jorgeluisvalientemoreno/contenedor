CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDC_ORDTIPTRAADI
/*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : TRG_LDC_ORDTIPTRAADI
  Descripcion    : TRIGGER QUE PERMITE VALIDAR SI LA ORDEN SELECCIONADA EN LDCTA
                  CUMPLE CON LOS ESTADOS REQUERIDOS Y PERTEENCE A LA UNIDAD
                  OPERATIVA DEL USUARIO CONECTADO.
  Autor          : Manuel Mejia
  Fecha          : 10/11/2015

  Historia de Modificaciones
    Fecha             Autor             Modificacion
  =========         =========         ====================
  28-04-2016 		KCienfuegos		  CA200151:Se modifica para validar que se ingrese la fecha inicial, final y observación.
******************************************************************/
BEFORE INSERT OR UPDATE ON LDC_ORDTIPTRAADI  REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
    ---------------
    -- Variables --
    ---------------
    sbErrMsg    ge_error_log.description%type;   -- ge_items_seriado   ldci_seriposi
    nuErrCode   NUMBER;
    nuReturn    NUMBER :=1;
    nuOorder OR_ORDER.ORDER_ID%TYPE;


    CURSOR cuValOrderExter
    IS
    SELECT *
    FROM OR_ORDER
    WHERE OPERATING_UNIT_ID IN(SELECT OP.OPERATING_UNIT_ID
            FROM ge_person GE,
            OR_OPER_UNIT_PERSONS OP
            WHERE GE.user_id = sa_bouser.fnugetuserid
            AND GE.person_id = OP.person_id)
    AND ORDER_STATUS_ID IN(DALD_PARAMETER.fnuGetNUMERIC_VALUE('COD_ESTADO_ASIGNADA_OT'),
            DALD_PARAMETER.fnuGetNUMERIC_VALUE('COD_ESTADO_OT_EJE'))
            AND order_id = nuOorder;

    CURSOR cuValOrderInter
    IS
    SELECT *
    FROM OR_ORDER
    WHERE ORDER_STATUS_ID IN(DALD_PARAMETER.fnuGetNUMERIC_VALUE('COD_ESTADO_ASIGNADA_OT'),
            DALD_PARAMETER.fnuGetNUMERIC_VALUE('COD_ESTADO_OT_EJE'))
            AND order_id = nuOorder;

    rccuValOrder cuValOrderInter%ROWTYPE;

  /* Constante para formulario LDCTA */
  csbLDCTA CONSTANT VARCHAR2(5) := 'LDCTA';
  sbProgram       VARCHAR2(100);
  nuperson            ge_person.person_id%type;
  nuOpOrder           or_order.operating_unit_id%type;
  nuTemp              number;
  nuTemp2             number := 0;
  nuTemp3             number := 0;
  nuTemp4             number := 0;
  sbes_externa        or_operating_unit.es_externa%type;
BEGIN

   -- Obtiene el programa
   sbProgram := ut_session.getmodule();

   IF((UPDATING OR INSERTING) AND sbProgram IN (csbLDCTA) ) THEN
    --Obtiene el codigo de la orden
    nuOorder :=   :new.ORDER_ID;

    -- Se consulta la persona conectada al Sistema
    nuperson := ge_bopersonal.fnuGetPersonId;
    -- Se consulta la UO de la Orden
    nuOpOrder := daor_order.fnugetoperating_unit_id(nuOorder);

    ut_trace.Trace('Persona '||nuperson||' Orden '||nuOorder||' Unidad Operativa '||nuOpOrder,1);

    --Validacion si es externo o no
    BEGIN

        select count(1) into nuTemp2
        from ge_person
        where person_id=nuperson
        and organizat_area_id is not null;

        select to_number(column_value) into nuTemp4
        from table(ldc_boutilities.splitstrings
        (dald_parameter.fsbgetvalue_chain('COD_AREA_ORGANIZACIONAL_EX',null),','))
        where rownum=1;

        -- Si la persona tiene area organizacional
        IF (nuTemp2 > 0 and nuTemp4 IS NOT NULL)THEN

            -- Consulta si la persona conectada al sistema pertenece a una Area Organizacional Externa
            SELECT Count(1) INTO nuTemp3
            FROM ge_person
            WHERE person_id=nuperson
            AND organizat_area_id IN (SELECT To_Number(column_value)
                                FROM TABLE(ldc_boutilities.splitstrings
                                (dald_parameter.fsbgetvalue_chain('COD_AREA_ORGANIZACIONAL_EX',null),',')))
            AND ROWNUM=1;

            IF (nuTemp3 > 0) THEN
            -- En esta condicion no retorna por que posteriormente se valida si la UO de la orden pertence a las UO asignada a la persona
                sbes_externa := 'Y';
            ELSE
                sbes_externa := 'N';
            END IF;

        ELSE
          sbes_externa := 'Y';
        END IF;

    EXCEPTION
        WHEN No_Data_Found THEN
            sbes_externa := 'Y';
        WHEN OTHERS THEN
            sbes_externa := 'Y';
    END;

    IF(sbes_externa = 'Y')THEN
      --Valida que la orden esten los estados 5 o 7
      --Valida que la orden pertenezca a la unidad  operativa
      --del usuario conectado
      OPEN cuValOrderExter;
      FETCH cuValOrderExter INTO rccuValOrder;
      IF(cuValOrderExter%NOTFOUND)THEN
        nuReturn := -1;
      END IF;
      CLOSE cuValOrderExter;
    ELSE
      --Valida que la orden esten los estados 5 o 7
      --del usuario conectado
      OPEN cuValOrderInter;
      FETCH cuValOrderInter INTO rccuValOrder;
      IF(cuValOrderInter%NOTFOUND)THEN
        nuReturn := -1;
      END IF;
      CLOSE cuValOrderInter;
    END IF;

    IF(nuReturn = -1 AND fsbaplicaentrega('OSS_ARA_8388') = 'S')THEN
      Errors.SetError( 2741,
                       'La orden ['||nuOorder||'] no se encuentra en estado asignada o ejecutadas o no pertenece al usuario que está realizando el proceso.'
                     );
      RAISE ex.controlled_error;
    END IF;

    IF(fblaplicaentrega('OSS_OYM_KCM_200151_1'))THEN
      IF(UPDATING) THEN

        IF (:OLD.EXEC_INITIAL_DATE IS NOT NULL AND NVL(:OLD.REGISTER_BY_XML,'N')='Y') THEN
          IF (:OLD.EXEC_INITIAL_DATE <> :NEW.EXEC_INITIAL_DATE) THEN
             Errors.SetError( 2741, 'Para la orden ['||nuOorder||'] no se debe modificar la fecha inicial de ejecución, puesto que ya fue establecida desde los móviles');
             RAISE ex.controlled_error;
          END IF;
        END IF;

        IF (:OLD.EXEC_FINAL_DATE IS NOT NULL AND NVL(:OLD.REGISTER_BY_XML,'N')='Y') THEN
          IF (:OLD.EXEC_FINAL_DATE <> :NEW.EXEC_FINAL_DATE) THEN
             Errors.SetError( 2741, 'Para la orden ['||nuOorder||'] no se debe modificar la fecha final de ejecución, puesto que ya fue establecida desde los móviles');
             RAISE ex.controlled_error;
          END IF;
        END IF;

        IF (:NEW.EXEC_INITIAL_DATE IS NULL) THEN
             Errors.SetError( 2741, 'Debe ingresar la fecha inicial.');
             RAISE ex.controlled_error;
        END IF;

        IF (:NEW.EXEC_FINAL_DATE IS NULL) THEN
             Errors.SetError( 2741, 'Debe ingresar la fecha final.');
             RAISE ex.controlled_error;
        END IF;

        IF (:NEW.Order_Comment IS NULL) THEN
             Errors.SetError( 2741, 'Debe ingresar la observación de la orden');
             RAISE ex.controlled_error;
        END IF;

      END IF;

      IF(INSERTING)THEN

        IF(:NEW.EXEC_INITIAL_DATE IS NULL OR :NEW.EXEC_FINAL_DATE IS NULL OR :NEW.ORDER_COMMENT IS NULL AND (NVL(:NEW.REGISTER_BY_XML,'N')<>'Y')) THEN
          Errors.SetError( 2741, 'La fecha inicial, fecha final y la observación de la orden son requeridos. Por favor verifique.');
          RAISE ex.controlled_error;
        END IF;

      END IF;
    END IF;
   END IF;

EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
            pkErrors.Pop;
            RAISE;
    WHEN OTHERS THEN
    	pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);
END TRG_LDC_ORDTIPTRAADI;
/
