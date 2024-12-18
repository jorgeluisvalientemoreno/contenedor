CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FUNVALIDATRANSITUNOPER" (nuOPERATING_UNIT_ID or_operating_unit.OPERATING_UNIT_ID%type) return boolean is
/**************************************************************
Propiedad intelectual de Gases del Caribe

Funcion       :  LDC_FUNVALIDATRANSITUNOPER

Descripcion   : Funcion que cuenta en la tabla or_ope_uni_item_bala cuantos registros asociados a la unidad operativa pasada por parametro
                tienen saldos en transito.

Parametros    : nuOPERATING_UNIT_ID Codigo unidad operativa

Autor         : Horbath
Fecha         : 25-06-2019

Historia de Modificaciones
Fecha        IDEntrega           Modificacion
25-06-2019   200-2584            Creación
**************************************************************/

nuregstransitsald number:=0;
begin
     -- cuenta cuantos registros en la tabla de saldos x unidad ooperativa asociado al
     select count(1)
            into nuregstransitsald
            from OR_OPE_UNI_ITEM_BALA
            where OPERATING_UNIT_ID=nuOPERATING_UNIT_ID and
                  (nvl(transit_in,0)<>0 or nvl(transit_out,0)<>0);
     if nuregstransitsald = 0 then -- no tiene saldos en transito
        return(true);
     else
        return(false);
     end if;
exception
     when others then
          return(false); -- inconvenientes para validar materiales en transito
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FUNVALIDATRANSITUNOPER', 'ADM_PERSON');
END;
/
