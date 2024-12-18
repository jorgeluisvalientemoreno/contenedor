CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_PRODSUSPEND" (idProducto in servsusc.sesunuse%type)
  RETURN NUMBER IS
  /**************************************************************************
      Autor       : Daniel Valiente
      Fecha       : 2019-06-11
      Descripcion : Validar que el proceso de inclusión no está en estado de producto suspendido por otra area

      Parametros Entrada
        idProducto

      Valor de salida
        numero

     HISTORIA DE MODIFICACIONES
  ***************************************************************************/
  RegistrosHallados number := 0;

BEGIN

  select COALESCE((select count(*)
                    from servsusc s
                   where s.sesuesco in
                         (to_number(dald_parameter.fsbGetValue_Chain('ESTAD_SUSP_PRODUCT')))
                     and s.sesunuse = idProducto),
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
    pkg_utilidades.prAplicarPermisos('LDC_PRODSUSPEND', 'ADM_PERSON');
END;
/
