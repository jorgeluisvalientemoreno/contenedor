CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUVALVENTCOMI" (inupack  in mo_packages.package_id%type) RETURN NUMBER IS
/**************************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

Funcion     : LDC_FNUVALVENTCOMI
Descripcion : a esta funci?n tiene como parametros el valor del tipo de paquete y los valores de comisi?n
              devuelva uno (1) si los valores son mayores que  0, o cero (0) si los valores no son
              mayores que  0.
Autor       : Karem Baquero
Fecha       : 20-10-2017

Historia de Modificaciones
  Fecha               Autor                Modificacion
=========           =========          ====================
***************************************************************************************/
nuvengasfor ld_parameter.numeric_value%TYPE;
nuvengasvencoti ld_parameter.numeric_value%TYPE;
nupackvenMIG  ld_parameter.numeric_value%TYPE ;
nuresp number;
inuvalcomi1053 number;
inuvalcomi1054 number;
inuvalcomi1055 number;
inuvalcomi1056 number;
nupackaddres number;
nutipack number;

cursor cuvalcomi (nuaddres   in mo_packages.package_id%type) is
select   nvl(sum(decode(oa.task_type_id, 10553, oa.value_reference)),0) ValCom10553,
              nvl(sum(decode(oa.task_type_id, 10554, oa.value_reference)),0) ValCom10554,
                nvl(sum(decode(oa.task_type_id, 10555, oa.value_reference)),0) ValCom10555,
               nvl(sum(decode(oa.task_type_id, 10556, oa.value_reference)),0) ValCom10556 from or_order_activity oa
where address_id=nuaddres--305590
          and oa.task_type_id in (10555, 10553, 10554, 10556);


BEGIN

 nuvengasfor := dald_parameter.fnugetnumeric_value('COD_VENTA_GAS_FORM');
 nuvengasvencoti := dald_parameter.fnugetnumeric_value('COD_VENTA_COTIZADA');
 nupackvenMIG:= dald_parameter.fnugetnumeric_value('COD_VENTA_GAS_FORMULARIO_MIGRA');

 nupackaddres:=damo_packages.fnugetaddress_id(inupack);

 nutipack:=damo_packages.fnugetpackage_type_id(inupack);

   open cuvalcomi(nupackaddres);
    fetch cuvalcomi
      into inuvalcomi1053,inuvalcomi1054,inuvalcomi1055,inuvalcomi1056;
    close cuvalcomi;


 if nutipack=nuvengasfor and inuvalcomi1053>0 and inuvalcomi1055 >0 then
 nuresp:=1;
 elsif nutipack=nuvengasvencoti and inuvalcomi1056>0  then

  nuresp:=1;
  elsif nutipack=nupackvenMIG and inuvalcomi1056>0  then
     nuresp:=1;
     else
         nuresp:=0;
 end if;

 RETURN nuresp;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUVALVENTCOMI', 'ADM_PERSON');
END;
/
