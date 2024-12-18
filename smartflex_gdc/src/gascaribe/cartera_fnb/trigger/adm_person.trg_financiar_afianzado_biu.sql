CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_FINANCIAR_AFIANZADO_BIU
/*******************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Trigger     :   trg_financiar_afianzado_biu
    Descripcion  :  No permite financiar productos creados en una venta con plan Afianzado
                    si existe en la entidad ldc_afianzado y el campo block esta en Y

    Autor       :   Jorge Valiente
    CASO        :   OSF-569

    Historia de Modificaciones
    Autor                   Fecha            Descripcion
    --------------------    --------------   ---------------------------------

*******************************************************************************/
  BEFORE INSERT OR UPDATE ON OPEN.CC_TMP_BAL_BY_CONC
  FOR EACH ROW
DECLARE

  NUSALDO NUMBER;

  --Curasor para consultar prodcutos generados en venta con plan afianzado y con block en Y
  cursor cuAfianzado is
    select *
      from ldc_afianzado
     where ldc_afianzado.product_id = :new.product_id
       and ldc_afianzado.block = 'Y';

  rfcuAfianzado cuAfianzado%rowtype;

BEGIN
  ut_trace.Trace('Inicio trg_financiar_afianzado_biu', 15);

  --Valida producto de afianzado
  open cuAfianzado;
  fetch cuAfianzado
    into rfcuAfianzado;
  if cuAfianzado%found then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'No se puede financiar el prodcuto ' ||
                                     :new.product_id ||
                                     ', este producto fue generado de una venta con PLAN AFIANZADOS');
    raise ex.CONTROLLED_ERROR;
  end if;
  close cuAfianzado;

  ut_trace.Trace('Fin trg_financiar_afianzado_biu', 15);

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

END trg_financiar_afianzado_biu;

/
