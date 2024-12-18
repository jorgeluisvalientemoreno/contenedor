CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIDULD_SUBSIDYVALIDATE
  after insert or delete or update on ld_subsidy
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgaiduld_subsidyvalidate

Descripción  : Realiza las validaciones necesarias para
               registrar un subsidio correctamente y
               evitar errores de tabla mutante.

Autor  : Nombre del desarrollador
Fecha  : 05-10-2012

Historia de Modificaciones
Fecha        IDEntrega             Modificación
05-10-2012   jconsuegra.SAO156577  Creación
**************************************************************/
declare
  /******************************************
      Declaración de variables y Constantes
  ******************************************/
  --
  rcdeal               dald_deal.styLD_deal;
  --
  nuauthorize_value    ld_subsidy.authorize_value%type;
  nuauthorize_quantity ld_subsidy.authorize_quantity%type;
  nusumauthorize_value ld_subsidy.authorize_value%type;
  nuDeal_Id            ld_subsidy.deal_id%type;
  nuquantityindex      number;
  --
  nusubinidate        ld_subsidy.initial_date%type;
  nuprominidate       cc_promotion.init_offer_date%type;
  nusubfindate        ld_subsidy.final_date%type;
  nupromfindate       cc_promotion.final_offer_date%type;
  --
  sbpromodesc         cc_promotion.description%type;
  sbnewdescription    cc_promotion.description%type;
  nupromo             cc_promotion.promotion_id%type;
  nuSubOriDeal        ld_subsidy.deal_id%type;
  --

begin
  --{
    -- Lógica del Negocio
  --}

  nuquantityindex := LD_BOConstans.tbsubsidy.count;

  if INSERTING or UPDATING then
    /*Validar que el convenio poseea dinero para distribuir*/
    FOR rgSubsidy in ld_boconstans.cnuInitial_Year..nuquantityindex LOOP
      nuDeal_Id            := LD_BOConstans.tbsubsidy(rgSubsidy).deal_id;
      nusumauthorize_value := Ld_BcSubsidy.fnutotauthorize_value(nuDeal_Id);
      nuauthorize_value    := LD_BOConstans.tbsubsidy(rgSubsidy).authorize_value;
      nuauthorize_quantity := LD_BOConstans.tbsubsidy(rgSubsidy).authorize_quantity;

      /*Obtener los datos del convenio*/
      DALD_deal.getRecord (nuDeal_Id, rcdeal);

      /*Validar que la sumatoria de subsidios con valores autorizados no supere el total del convenio*/
      if nuauthorize_value is not null then

        /*Obtener la sumatoria de lo disponible de un convenio*/
        if nusumauthorize_value > rcdeal.total_value  then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La sumatoria de valores autorizados supera el valor total del convenio');
        end if;

      end if;

      /*Validar creación de un subsidio a partir de los rendimientos de otro*/
      if LD_BOConstans.tbsubsidy(rgSubsidy).origin_subsidy is not null then

        /*Obtener el código del convenio del subsidio que originó los rendimientos*/
        nuSubOriDeal := DALD_subsidy.fnuGetDeal_Id(LD_BOConstans.tbsubsidy(rgSubsidy).origin_subsidy,
                                                   null
                                                  );

        /*Validar que el convenio del nuevo subsidio y de aquél que generó los rendimientos sea el mismo*/
        if LD_BOConstans.tbsubsidy(rgSubsidy).deal_id <> nuSubOriDeal then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El convenio debe ser el mismo de aquél subsidio que generó los rendimientos');
        end if;

        if LD_BOConstans.tbsubsidy(rgSubsidy).authorize_value is null then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Para este tipo de subsidios debe ingresar en la casilla de valor autorizado el valor del rendimiento generado por el subsidio origen');
        end if;
      end if;


    END LOOP;
  end if;

  if UPDATING then

    /*Validar actualización de la promoción*/
    FOR rgSubsidy in ld_boconstans.cnuInitial_Year..nuquantityindex LOOP

      nusubinidate  := LD_BOConstans.tbsubsidy(rgSubsidy).initial_date;

      nuprominidate := dacc_promotion.fdtGetInit_Offer_Date(dald_subsidy.fnuGetPromotion_Id(LD_BOConstans.tbsubsidy(rgSubsidy).subsidy_id)
                                                            ,
                                                            null
                                                           );

      nupromo := dald_subsidy.fnuGetPromotion_Id(LD_BOConstans.tbsubsidy(rgSubsidy).subsidy_id,
                                                 null
                                                );

      /*Actualizar la fecha de inicio de la promoción*/
      if nusubinidate <> nuprominidate then

        dacc_promotion.updInit_Offer_Date(nupromo,
                                          nusubinidate
                                         );
      end if;

      nusubfindate  := LD_BOConstans.tbsubsidy(rgSubsidy).final_date;

      nupromfindate := dacc_promotion.fdtGetFinal_Offer_Date(nupromo,
                                                             null
                                                            );

      /*Actualizar la fecha de fin de la promoción*/
      if nusubfindate <> nupromfindate then

        dacc_promotion.updFinal_Offer_Date(dald_subsidy.fnuGetPromotion_Id(LD_BOConstans.tbsubsidy(rgSubsidy).subsidy_id,
                                                                          null
                                                                         ),
                                          nusubfindate
                                         );
      end if;

      /*Actualizar la descripción de la promoción*/


      if LD_BOConstans.tbsubsidy(rgSubsidy).description <> Ld_Bosubsidy.sboldsubdesc then

        sbpromodesc := dacc_promotion.fsbGetDescription(dald_subsidy.fnuGetPromotion_Id(LD_BOConstans.tbsubsidy(rgSubsidy).subsidy_id,
                                                                                        null
                                                                                       ),
                                                        null
                                                       );

        sbnewdescription := substr(sbpromodesc, 1, REGEXP_INSTR(sbpromodesc, ' ', 1, 1))||LD_BOConstans.tbsubsidy(rgSubsidy).description;

        dacc_promotion.updDescription(nupromo,
                                      sbnewdescription
                                     );
      end if;

    END LOOP;

  end if;
  ----------------------------------------------------
Exception
  When ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  When others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
end TRGAIDULD_SUBSIDYVALIDATE;
/
