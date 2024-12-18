CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIDULD_SUBSIDY_DETAILVAL
  after insert or delete or update on ld_subsidy_detail
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgaiduld_subsidy_detailval

Descripción  : Realiza las validaciones necesarias para
               registrar los conceptos a subsidiar por
               un subsidio determinado y evita errores
               de tabla mutante.

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
  rcubication      dald_ubication.styLD_ubication;
  nuvaltot         ld_subsidy_detail.subsidy_value%type;
  nuquantityindex  number;
  nuValidation     number;


begin
  --{
    -- Logica del Negocio
  --}
  nuquantityindex := LD_BOConstans.tbSub_Detail.count;

  if INSERTING or UPDATING then

    /*Validar que no se supere el valor a subsidiar por población*/
    FOR rgSubdetail in ld_boconstans.cnuInitial_Year..nuquantityindex LOOP

      /*Obtener datos de la población*/
      DALD_ubication.getRecord (LD_BOConstans.tbSub_Detail(rgSubdetail).ubication_id, rcubication);

      /*Obtener la sumatoria de valores autorizados para los conceptos de la población*/
      nuvaltot := ld_bcsubsidy.fnutotalvalconc(LD_BOConstans.tbSub_Detail(rgSubdetail).ubication_id);

      if nuvaltot > rcubication.authorize_value then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La sumatoria de los valores subsidiados de los conceptos supera el valor autorizado de la población');
      end if;

      /* Se valida que la cantidad de subsidios no supere el valor total del convenio*/
      nuValidation := Ld_Bcsubsidy.fnuValTotalDeal(LD_BOConstans.tbSub_Detail(rgSubdetail).ubication_id);

      if nuValidation = ld_boconstans.cnuCero then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La sumatoria de los subsidios a distribuir supera el valor total del convenio');
      END if;

    END LOOP;
  end if;

Exception
  When ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  When others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

end TRGAIDULD_SUBSIDY_DETAILVAL;
/
