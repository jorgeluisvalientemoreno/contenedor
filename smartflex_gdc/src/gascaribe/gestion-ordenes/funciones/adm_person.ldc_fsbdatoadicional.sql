CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBDATOADICIONAL" (inuOrden   open.or_order.order_id%type,
                                                isbNameDA  open.or_requ_data_value.name_1%type,
                                                inuGrupoDA open.or_requ_data_value.attribute_set_id%type)
/**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   LDC_FSBDATOADICIONAL
  Descripcion :   Servicio para retornar valor del dato adicional de una orden y nombre de atributo
  Autor       :   Jorval
  OSF        :   146

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  **************************************************************************/
 RETURN VARCHAR2 IS

  t_query    varchar2(2000);
  ocuCursorR constants.tyrefcursor;
  varR       varchar2(2000);
  osbValor   open.or_requ_data_value.value_1%type;

BEGIN

  osbValor := null;
  for i in 1 .. 20 loop
    t_query := 'select d.value_' || i ||
               ' from or_requ_data_value d where d.name_' || i || ' = ''' ||
               isbNameDA || ''' and d.attribute_set_id=' || inuGrupoDA ||
               ' and d.order_id = ' || inuOrden;
    open ocuCursorR for t_query;
    LOOP
      FETCH ocuCursorR
        INTO varR;
      EXIT WHEN ocuCursorR%NOTFOUND;
      if varR is not NULL then
        osbValor := varR;
      end if;
    END LOOP;
    close ocuCursorR;

    EXIT WHEN osbValor is not null;

  end loop;

  return osbValor;

exception
  when others then
    osbValor := null;
    return osbValor;

END LDC_FSBDATOADICIONAL;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBDATOADICIONAL', 'ADM_PERSON');
END;
/
