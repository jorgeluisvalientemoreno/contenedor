CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNC_GETCUADREPFAC" (inususc open.pr_product.subscription_id%type)
                                                   return varchar2 is
/**************************************************************************
  Autor       : Francisco Castro
  Fecha       : 2015-05-27
  Descripcion : Funcion que retorna la cuadrilla de reparto de factura de un contrato

  Parametros Entrada
    inususc contrato


  Valor de salida
    cuadrilla de reparto (codigo concatenado con el nombre)


 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION


***************************************************************************/


sbCuadrilla varchar2(200);

cursor cuCuadrilla is
select a.operating_unit_id || ' - ' || op.name
from (select operating_unit_id
        from (select a.operating_unit_id, a.register_Date
                from open.or_order_activity a
               where a.task_type_id = 12626
                 and a.subscription_id = inususc
             order by a.order_activity_id desc)
        where rownum=1) a, OPEN.OR_OPERATING_UNIT OP
where OP.OPERATING_UNIT_ID = a.OPERATING_UNIT_ID   ;

begin
  open cuCuadrilla;
  fetch cuCuadrilla into sbCuadrilla ;
  if cuCuadrilla%notfound then
     sbCuadrilla := 'NO HA TENIDO REPARTO DE FACTURA';
  end if;
  close cuCuadrilla;
  return (sbCuadrilla);
exception when others then
   return ('Error en ldc_fnc_getcuadrepfac: (Contrato ' || inususc || ': ' || sqlerrm);
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNC_GETCUADREPFAC', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_FNC_GETCUADREPFAC TO REPORTES;
/