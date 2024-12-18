CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBURLD_ASIG_SUBSIDYORDER
  before update on ld_asig_subsidy
  referencing old as old new as new for each row

 WHEN (new.delivery_doc = 'S') declare


  /******************************************
      Declaración de variables y Constantes
  ******************************************/

begin
  --{
    -- Lógica del Negocio
  --}

  if Ld_Boconstans.cnuswupdld_asig_subsidy = ld_boconstans.cnuCero_Value then

    Ld_Boconstans.cnuAsigSubIndex := ld_boconstans.cnuonenumber;

    Ld_Boconstans.tbld_asig_subsidy(Ld_Boconstans.cnuAsigSubIndex).order_id := :new.order_id;

    Ld_Boconstans.tbld_asig_subsidy(Ld_Boconstans.cnuAsigSubIndex).asig_subsidy_id := :new.asig_subsidy_id;

  elsif Ld_Boconstans.cnuswupdld_asig_subsidy = ld_boconstans.cnuonenumber then

    Ld_Boconstans.tbld_asig_subsidy(Ld_Boconstans.cnuAsigSubIndex).order_id := null;

    Ld_Boconstans.tbld_asig_subsidy(Ld_Boconstans.cnuAsigSubIndex).asig_subsidy_id := null;

  end if;


Exception
  When ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  When others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
end TRGBURLD_ASIG_SUBSIDYORDER;
/
