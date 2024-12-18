CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRBIUGENERAL

  BEFORE INSERT OR UPDATE ON OR_ORDER_ACTIVITY

  REFERENCING OLD AS OLD NEW AS NEW

  FOR EACH ROW

when ((NEW.PRODUCT_ID IS NOT NULL ) AND (NEW.subscription_id IS NULL))
Declare

  /*****************************************************************

    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRBIUGENERAL

    Descripcion    : Actrauliza contrato con base al producto de la orden
    Autor          : Jorge Valiente
    Fecha          : 22/02/2022

    Historia de Modificaciones

      Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  Cursor cucontrato Is

    select pp.subscription_id
      from open.pr_product pp
     where pp.product_id = :NEW.PRODUCT_ID;

  nucontrato number;

  CURSOR CUEXISTE(IsbATRIBUTO number) IS
    SELECT count(1) cantidad,
           nvl(open.dald_parameter.fnuGetNumeric_Value('COD_TITR_ACTUALIZA_CONTRATO',
                                                       NULL),
               0) TODOS
      FROM DUAL
     WHERE IsbATRIBUTO IN
           (select to_number(column_value)
              from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('COD_TITR_ACTUALIZA_CONTRATO',
                                                                                                 NULL),
                                                           ',')));

  nuCUEXISTE number;

  nuCOD_TITR_ACTUALIZA_CONTRATO open.ld_parameter.numeric_value%type;

Begin

  ut_trace.trace('INICIO LDC_TRBIUGENERAL', 10);

  If FBLAPLICAENTREGAXCASO('2022020150') Then

    open cucontrato;
    fetch cucontrato
      into nucontrato;
    close cucontrato;

    open CUEXISTE(:new.task_type_id);
    fetch CUEXISTE
      into nuCUEXISTE, nuCOD_TITR_ACTUALIZA_CONTRATO;
    close CUEXISTE;

    if nuCUEXISTE > 0 then

      :new.subscription_id := nucontrato;

    else

      if nuCOD_TITR_ACTUALIZA_CONTRATO = -1 then

        :new.subscription_id := nucontrato;

      end if;
    end if;

  END IF;

  ut_trace.trace('FIN LDC_TRBIUGENERAL', 10);

Exception

  When Others Then

    errors.seterror;

End LDC_TRBIUGENERAL;
/
