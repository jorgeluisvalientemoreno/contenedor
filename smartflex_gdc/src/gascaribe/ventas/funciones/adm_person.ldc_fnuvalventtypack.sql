CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUVALVENTTYPACK" (inupack in mo_packages.package_id%type)
  RETURN NUMBER IS
  /**************************************************************************************
  Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : LDC_FNUVALVENTTYPACK
  Descripcion :  Esta funci?n se crea para obterner el valor de la venta teniendo en cuenta los siguientes
                 aspectos:
                 o  si el tr?mite es 271 se debe modificar su valor a  cc_sales_financ_cond.value_to_finance
                  + cc_sales_financ_cond.initial_payment
                 o  Si es 100229 traiga el valor de la cotizaci?n aceptada relacionada a la venta,
                 teniendo en cuenta las tablas  CC_QUOTATION y CC_QUOTATION_ITEM
                 o  Si es 100271 debe salir el campo valor venta en 0.

  Autor       : Karem Baquero
  Fecha       : 20-10-2017

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  nuvengasfor     ld_parameter.numeric_value%TYPE;
  nuvengasvencoti ld_parameter.numeric_value%TYPE;
  nupackvenMIG    ld_parameter.numeric_value%TYPE;
  nuresp          number;
  nutipack        number;

  cursor cuvalvent is
    select nvl(t.value_to_finance + initial_payment, 0)
      from open.Cc_Sales_Financ_Cond t
     where t.package_id = inupack;

       cursor cuvalventcoti is
     select nvl(total_items_value  ,0)--*
      from CC_QUOTATION  c
where c.package_id=inupack;--57713596


BEGIN

  nuvengasfor     := dald_parameter.fnugetnumeric_value('COD_VENTA_GAS_FORM');
  nuvengasvencoti := dald_parameter.fnugetnumeric_value('COD_VENTA_COTIZADA');
  nupackvenMIG    := dald_parameter.fnugetnumeric_value('COD_VENTA_GAS_FORMULARIO_MIGRA');

  nutipack := damo_packages.fnugetpackage_type_id(inupack);

  if nutipack = nuvengasfor then


  open cuvalvent;
    fetch cuvalvent
      into nuresp;
    close cuvalvent;

  elsif nutipack = nuvengasvencoti then
open cuvalventcoti;
    fetch cuvalventcoti
      into nuresp;
    close cuvalventcoti;

  elsif nutipack = nupackvenMIG then

    nuresp := 0;
    else
          nuresp := 0;
  end if;

  RETURN nuresp;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUVALVENTTYPACK', 'ADM_PERSON');
END;
/
