CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_PRSUSPRVSEG" (idProducto in pr_product.product_id%type)
  RETURN NUMBER IS
  /**************************************************************************
      Autor       : Daniel Valiente
      Fecha       : 2019-06-11
      Descripcion : Validar que el producto este en suspension por Revision Segura

      Parametros Entrada
        idProducto

      Valor de salida
        numero

     HISTORIA DE MODIFICACIONES
  ***************************************************************************/
  RegistrosHallados number := 0;

BEGIN

  select COALESCE((select count(*)
                    from pr_prod_suspension s
                   where s.suspension_type_id in
                         (select nvl(to_number(column_value), 0)
                    from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('LDC_TIPOSUSPRP',
                                                                                             NULL),
                                                            ',')))
                     and s.product_id = idProducto
                     and s.active = 'Y'),
                  0)
    into RegistrosHallados
    from dual;

  if RegistrosHallados > 0 then
    return 1;
  else
    return 0;
  end if;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    return - 1;
  when others then
    Errors.setError;
    return - 1;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRSUSPRVSEG', 'ADM_PERSON');
END;
/
