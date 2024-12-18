CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_DATO_ADIC_NOTI_VENTAS" (inupackage_id OPEN.MO_PACKAGES.PACKAGE_ID%type,
                                                          inusetattrib OPEN.GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_SET_ID%type,
                                                          inuorderId OPEN.OR_ORDER_ACTIVITY.ORDER_ID%type,
                                                          isbnomdato OPEN.GE_ATTRIBUTES.NAME_ATTRIBUTE%type,
                                                          inuConsulta number )
RETURN varchar2 IS
/**************************************************************************
  Autor       : Jhon Jairo Soto
  Fecha       : 2013-11-12
  Descripcion : Obtiene el dato adicional de una orden pasados los parametros
                Se usa en las notificaciones de ventas

  Parametros Entrada
  inupackage_id OPEN.MO_PACKAGES.PACKAGE_ID%type, Paquete al cual pertenece la orden, en la cual voy a buscar los datos adicionales
  inusetattrib OPEN.GE_ATTRIB_SET_ATTRIB.ATTRIBUTE_SET_ID%type,  Grupo de atributos de los datos adicionales
  inuorderId OPEN.OR_ORDER_ACTIVITY.ORDER_ID%type,   orden que se esta imprimiendo
  isbnomdato OPEN.GE_ATTRIBUTES.NAME_ATTRIBUTE%type  Nombre del atributo que se debe retornar
  nuConsulta Para poder implementar varias consultas en la misma funcion

  Valor de Retorno
    Valor del dato adicional

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  20-11-2013    sergiom     No Conformidad 884 y 885. Se modifica para que obtenga
                            la orden de gestion de datos y documentos mas reciente
                            en el escenario en que la solicitud tenga dos o mas ordenes
                            de este tipo.
  10-12-2013    sergiom     No Conformidad 2080. Se agrega la lógica para obtener los datos
                            adicionales de la orden de DEFINICION DE COSTOS DE SOLICITUD
                            DE RED(T.T 10047).
***************************************************************************/
    sbdato  varchar2(4000);
    nuTaskTypeId    or_task_type.task_type_id%type;
    nuOrderId       OR_order.order_id%type;
    nuCategory      mo_motive.category_id%type;

    type tyrcTemp    IS record (
      package_id        MO_PACKAGES.PACKAGE_ID%type,
      task_type_id      or_task_type.task_type_id%type,
      oder_id           OR_order.order_id%type
    );

    rcOrderTemp tyrcTemp;

    -- Obtine las ordenes del tipo taskTypeId en la solicitud packageId ordenadas descendentement por fecha de creación
    CURSOR cuCursor(packageId   mo_packages.package_id%type, taskTypeId or_task_type.task_type_id%type) IS
        SELECT O.ORDER_id
        FROM OR_order_activity A, OR_order O
        WHERE O.order_id = A.order_id
        AND A.PACKAGE_id = packageId
        AND O.task_type_id = taskTypeId
        ORDER BY created_date desc;

BEGIN

    -- Consulta 1
    if inuConsulta = 1 then
        -- Obtiene la categoria
        nuCategory := TO_NUMBER(open.LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('MO_MOTIVE', 'PACKAGE_ID', 'CATEGORY_ID', inupackage_id));

        -- Dependiendo de la categoria obtiene el tipo de trabajo de getion de datos y documentos
        if  nuCategory = 1 then
            nuTaskTypeId := 12657;   -- residencial
        elsif nuCategory = 2 then
            nuTaskTypeId := 10161;   -- comercial
        else
            nuTaskTypeId := 10299;   -- industrial
        END if;

    elsif inuConsulta = 2 then
        --DEFINICION DE COSTOS DE SOLICITUD DE RED
        nuTaskTypeId := 10047;
    end if;

    -- Valida si esta en cache
    IF rcOrderTemp.package_id = inupackage_id
        AND rcOrderTemp.task_type_id =nuTaskTypeId
    then
        nuOrderId := rcOrderTemp.oder_id;
    else
        OPEN cuCursor(inupackage_id, nuTaskTypeId);
        fetch cuCursor INTO nuOrderId;      -- Obtiene la orden más reciente
        close cuCursor;
    END if;


    if nuOrderId IS null then
          nuOrderId := -1;
    END if;

    -- Obtiene el dato adicional
    sbdato := LDC_BOORDENES.FnugetValorOTbyDatAdd(  nuTaskTypeId,   inusetattrib,   isbnomdato, nuOrderId);
    return sbdato;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DATO_ADIC_NOTI_VENTAS', 'ADM_PERSON');
END;
/