CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAULD_ASIG_SUBSIDYORDER
  after update on ld_asig_subsidy
  /**************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Trigger  :  trgauld_asig_subsidyorder

    Descripción  : Actualiza el estado de la documentación entregada
                   de los subisidios asignados asociados a una
                   misma orden de trabajo y así evitar errores de
                   tabla mutante.

    Autor  : Jonathan Consuegra
    Fecha  : 25-02-2013

    Historia de Modificaciones
    Fecha        IDEntrega             Modificación
    25-02-2013   jconsuegra.SAO156577  Creación
  **************************************************************/
declare

  Cursor cudeliverydoc (inuasigid ld_asig_subsidy.asig_subsidy_id%type,
                        inuorder  or_order.order_id%type
                       ) is

    SELECT l.asig_subsidy_id
    FROM   ld_asig_subsidy l
    WHERE  l.order_id = inuorder
    AND    l.asig_subsidy_id <> inuasigid;

  /******************************************
      Declaración de variables y Constantes
  ******************************************/
  nuIndex         number;

begin
  --{
    -- Lógica del Negocio
  --}

  nuIndex := Nvl(Ld_Boconstans.cnuAsigSubIndex, ld_boconstans.cnuonenumber);

  if Ld_Boconstans.tbld_asig_subsidy.exists(nuIndex) then

    if Ld_Boconstans.tbld_asig_subsidy(nuIndex).asig_subsidy_id is not null and
       Ld_Boconstans.tbld_asig_subsidy(nuIndex).order_id is not null then

      FOR rcdeliverydoc in cudeliverydoc (Ld_Boconstans.tbld_asig_subsidy(nuIndex).asig_subsidy_id,
                                          Ld_Boconstans.tbld_asig_subsidy(nuIndex).order_id
                                         ) Loop

        if Ld_Boconstans.cnuswupdld_asig_subsidy = ld_boconstans.cnuCero_Value then

          Ld_Boconstans.cnuswupdld_asig_subsidy := 1;

        end if;

        Dald_Asig_Subsidy.updDelivery_Doc(rcdeliverydoc.asig_subsidy_id, 'S');

      END LOOP;

    end if;

  end if;
  ----------------------------------------------------
Exception
  When ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  When others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
end TRGAULD_ASIG_SUBSIDYORDER;
/
