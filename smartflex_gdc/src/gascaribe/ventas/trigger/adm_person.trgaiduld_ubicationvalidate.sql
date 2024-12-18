CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIDULD_UBICATIONVALIDATE
  after insert or delete or update on ld_ubication
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgaiduld_ubicationvalidate

Descripción  : Realiza las validaciones necesarias para
               registrar correctamente las poblaciones
               que serán beneficiadas por un subsidio y
               evita errores de tabla mutante.

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
  --blexist     boolean;
  rcsubsidy   dald_subsidy.styLD_subsidy;
  --
  nusumauthorize_value ld_subsidy.authorize_value%type;
  nuexisttotal         number(4);
  nusw                 number(1) := LD_BOConstans.cnuCero_Value;
  nuSubsidy            ld_subsidy.subsidy_id%type;
  nusumvaluedetail     ld_subsidy_detail.subsidy_value%type;
  nuquantityindex      number;
begin

  --{
    -- Logica del Negocio
  --}
  nuquantityindex := LD_BOConstans.tbubisubsidy.count;

  if INSERTING or UPDATING then
    /*Validar que el convenio poseea dinero para distribuir*/
    FOR rgUbication in ld_boconstans.cnuInitial_Year..nuquantityindex LOOP
      nuSubsidy            := LD_BOConstans.tbubisubsidy(rgUbication).subsidy_id;

      /*Obtener los datos del subsidio*/
      DALD_Subsidy.getRecord (nuSubsidy, rcsubsidy);

      /*Validar que la sumatoria de los valores autorizados en el detalle del subsidio no supere el valor autorizado para el subsidio*/
      if LD_BOConstans.tbubisubsidy(rgUbication).authorize_value is not null then
        nuexisttotal         := Ld_BcSubsidy.fnuexiststotaldetail(nuSubsidy);

        if nuexisttotal > LD_BOConstans.cnuCero_Value then
          nusumauthorize_value := Ld_BcSubsidy.fnutotalvaluedetail(nuSubsidy);

          if nusumauthorize_value > rcsubsidy.authorize_value then
            nusw := LD_BOConstans.cnuonenumber;
            exit;
          end if;
        end if;
      end if;

      /*Validar que la sumatoria de las cantidades autorizadas en el detalle del subsidio no supere la cantidad autorizada para el subsidio*/
      if LD_BOConstans.tbubisubsidy(rgUbication).authorize_quantity is not null then
        nuexisttotal         := Ld_BcSubsidy.fnuexistsquantitydetail(nuSubsidy);
        if nuexisttotal > LD_BOConstans.cnuCero_Value then
          nusumauthorize_value := Ld_BcSubsidy.fnutotquantidetail(nuSubsidy);
          if nusumauthorize_value > rcsubsidy.authorize_quantity then
            nusw := LD_BOConstans.cnutwonumber;
            exit;
          end if;
        end if;
      end if;

     /*Validar que no se pueda disminuir el valor autorizado con respecto a la sumatoria de los valores a subsidiar de los conceptos*/
     nusumvaluedetail := Ld_BcSubsidy.fnutotalvalconc(LD_BOConstans.tbubisubsidy(rgUbication).ubication_id);

     if nvl(nusumvaluedetail, LD_BOConstans.cnuCero_Value) > LD_BOConstans.tbubisubsidy(rgUbication).authorize_value then
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor autorizado de la población es menor que la sumatoria de los valores autorizados para los conceptos a subsidiar');
     end if;

    END LOOP;

    if nusw = LD_BOConstans.cnuonenumber then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La sumatoria de valores autorizados por población supera el valor registrada para el subsidio');
    end if;

    if nusw = LD_BOConstans.cnutwonumber then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La sumatoria de las cantidades autorizadas por población supera la cantidad autorizada registrada para el subsidio');
    end if;
  end if;
  ----------------------------------------------------

Exception
  When ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  When others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
end TRGAIDULD_UBICATIONVALIDATE;
/
