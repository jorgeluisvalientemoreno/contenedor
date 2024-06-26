CREATE OR REPLACE PACKAGE OR_BCOperUnit_Admin
IS
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : OR_BCOperUnit_Admin
Descripcion    : Metodos usados en configuracion de unidades operativas

 Fecha        Autor                Modificacion
=========    =========           ====================
17-09-2014   Locampo.SAO273762   Se modifica <fblValidOperUnitAssign>
19-02-2014   ACastro.SAO233694   Se ajusta <fsbValidOperUnitAssign>
19-06-2013   MArteaga.SAO209275  Se agrega: <GetOperatingUnitLov>
18-04-2013   jaricapa.SAO206014  Se modifica <GetOperUnitsByBase>.
07-03-2013   ICeron.SAO203827    Se modifica el metodo <frfGetItemsClassif>
25-01-2013   juzuriaga.SAO200512 Se modifica el metodo <frfGetItemsClassif>
21-12-2012   cburbano.SAO198609  Se modifica <frfGetCommentTypesLOV>
17-12-2012   cenaviaSAO197595    Se modifica <frfGetRolesForWorkUnit>
29-11-2012   llopezSAO197153     Se modifica frfGetOperUnitItems
13-08-2012   hcruz.SAO186225     Modificacion del metodo frfGetOperUnitItems
10-05-2012   cenaviaSAO181999    Estabilizacion
04-05-2012   cenaviaSAO181117    Se modifica el metodo:
                                    <frfGetOpeUniPersonal>
                                 Se elimina la siguiente funcion:
                                    <frfGetPersonsLOV>
28-03-2012   Juzuriaga.SAO176910 Se modifica <fsbValidOperUnitAssign>.
                                             <fsbValidOpeUniSchedAssign>.
16-03-2012   jaricapa.SAO177570  Se modifica <fsbValidOperUnitAssign>.
26-12-2011   jaricapa.SAO164882  Se modifica <GetOperUnitsByBase>.
13-12-2011   cenaviaSAO168500    Estabilizacion
             AEcheverrySAO161658 Se modifica los metodos
                                    <<fsbValidOperUnitAssign>>
                                    <<fsbValidOpeUniSchedAssign>>
02-12-2010   cburbano.SAO134915  Se modifica fblValidOperUnitAssign y se adiciona
                                 fblValidOpeUniSchedAssign
29-11-2010   cburbano.SAO133936  Se adiciona fblValidOperUnitAssign
23-Sep-2010  llopezSAO125643    Se modifica <<GetDispatchUnits>>
21-09-2010   sagudeloSAO128143  Se modifica:
                                    - <frfGetExistingRules>
16-09-2010   llopezSAO126825    Se modifica <<frfGetItemsClassif>>
21-08-2010   jaricapaSAO122950  Se agrega "GetDispatchUnits".

28-Jul-2010  GPazSAO121017      Se modifican:
                                <<frfGetCommentClass>>
                                <<frfGetOpeUniComments>>
                                <<frfGetCommentTypesLOV>>
                                <<frfGetCommentsByClass>>
                                <<frfGetTaskTypeComments>>
24-06-2010   cburbanoSAO119763  Se adiciona GetOperUnitsByBase
16-06-2010   aavelezSAO119436   se elimina el metodo frfGetTaskTypeNetElems
22-May-2010  DMunoz SAO118251   Se adiciona frfObtExcActByOpeUni
21-May-2010  MArteagaSAO117612  Se agrega <<frfGetRolesForWorkUnit>>
18-May-2010  llopezSAO117734    Se modifica frfGetPersonsLOV y frfGetPersonsByType
26-04-2010   cburbanoSAO116580  Se modifica la funcion frfGetPersonsLOV y frfGetPersonsByType
26-11-2009   MArteagaSAO107945  Se modifica el metodo frfGetOperUnitItems para
                                recuperar el campo quantity_control de ge_item_classif
                                y se agrega el metodo fsbGetItemQuantityControl
19-10-2009   DMunoz SAO105151   Se adiciona frfGetOperUnitClass.
02-03-2009   gpazSAO91773       Se modifan los procedimientos: frfGetOpeUniTaTySeOp,
                                frfGetOpUnTaskTypes para que no hagan uso del campo
                                or_ope_uni_task_type.executing_last_time.
                                Se modifica el procedimiento frfGetOperatingUnitsLOV
                                para que traiga la descripcion junto con el codigo.
                                Se agregan los procedimientos:
                                - frfGetPersonType
                                - frfGetPersonsByType
                                - frfGetOperZones
                                - frfGetOperSectorsByOperZone
                                Se elimina el procedimiento:
                                - frfGetOpeUniOrdeClas
30-01-2009   cburbanoSAO89466   Se modifica el metodo frfGetOpeUniTaTyNoti
04-11-2008   gpazSAO81777       Se modifican las funciones frfGetPersonsLOV y
                                frfGetResponsableLOV.
                                Se adiciona la funcion frfGetOperZonesLOV.

20-10-2008   aavelezSAO81777    Se adiciona la funcion fnuHasSchedule

26-09-2008   gpazSAO82888       Se modifica el procedimiento frfGetNotificationTypes
                                para filtrar por las notificaciones usadas en el
                                Modulo de Ordenes.
                                Se agregan las constantes cnuMail y cnuImpresion
20-08-2008   gramirezSAO79813   Creacion  OR_BCOperUnit_Admin
******************************************************************/

	-- Declaracion de Tipos de datos publicos

	-- Declaracion de variables publicas

	-- Declaracion de metodos publicos

    -- Obtiene la version del paquete.
    FUNCTION fsbVersion  return varchar2;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetNewStatusLov
    Descripcion	: Obtiene los estados diferentes al que se pasa por parametro.
    ******************************************************************/
    FUNCTION frfGetNewStatusLov
    (
        inuOldStatus in OR_OPER_UNIT_STATUS.oper_unit_status_id%type
    )
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetCausals
    Descripcion	: Obtiene las causales
    ******************************************************************/
    FUNCTION frfGetCausals
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetExistingRules
    Descripcion	: Obtiene las Reglas que hay en OR_OPUNI_TSKTYP_NOTI
    ******************************************************************/
    FUNCTION frfGetExistingRules
    (
        inuOperUnit     in  or_operating_unit.operating_unit_id%type
    )
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperatingUnits
    Descripcion	: Metodo de consulta de Unidades Operativas.
    ******************************************************************/
    FUNCTION frfGetOperatingUnits
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperatingUnit
    Descripcion	: Metodo de consulta de los datos de una Unidad Operativa.
    ******************************************************************/
    FUNCTION frfGetOperatingUnit
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperatingUnitsLOV
    Descripcion	: Metodo que obtiene la lista de valores de Unidades Operativas.
    ******************************************************************/
    FUNCTION frfGetOperatingUnitsLOV
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frcGetOpUnTaskTypes
    Descripcion	: Metodo que obtiene los tipos de trabajo de una Unidad Operativa.
    ******************************************************************/
    FUNCTION frfGetOpUnTaskTypes
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperUnitItems
    Descripcion	: Metodo que obtiene los items de una Unidad Operativa.
    ******************************************************************/
    FUNCTION frfGetOperUnitItems
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOpeUniPersonal
    Descripcion	: Metodo que obtiene el personal de una Unidad Operativa.
    ******************************************************************/
    FUNCTION frfGetOpeUniPersonal
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOpeUniComments
    Descripcion	: Metodo que obtiene los comentarios de una Unidad Operativa.
    ******************************************************************/
    FUNCTION frfGetOpeUniComments
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOpeUniTaTyNoti
    Descripcion	: Metodo que obtiene las notificaciones de los tipos de trabajo
                  de una Unidad Operativa.
    ******************************************************************/
    FUNCTION frfGetOpeUniTaTyNoti
    (
        inuTaskTypeId       in or_ope_uni_task_type.task_type_id%type,
        inuOperatingUnitId  in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOpeUniTaTySeOp
    Descripcion	: Metodo que obtiene los Sectores Operativos por Tipo de Trabajo
                  de una Unidad Operativa.
    ******************************************************************/
    FUNCTION frfGetOpeUniTaTySeOp
    (
        inuTaskTypeId       in or_ope_uni_task_type.task_type_id%type,
        inuOperatingUnitId  in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
        Propiedad intelectual de Open International Systems. (c).

        Procedure	: frfGetCommentTypesLOV
        Descripcion	: Metodo que obtiene los tipos de comentarios.
    ******************************************************************/
    FUNCTION frfGetCommentTypesLOV
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetPersonType
    Descripcion	: Metodo que obtiene los tipos de personas.
    ******************************************************************/
    FUNCTION frfGetPersonType
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetPersonsByType
    Descripcion	: Metodo que obtiene el personal por su tipo
    ******************************************************************/
    FUNCTION frfGetPersonsByType
    (
        inuPersonalType    in ge_personal_type.personal_type%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frcGetPersonsLOV
    Descripcion	: Metodo que obtiene la clasificacion de las ordenes.
    ******************************************************************/
    FUNCTION frfGetOrderClassifLOV
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaTyOpSeLOV
    Descripcion	: Metodo que obtiene los Sectores Operativos.
    ******************************************************************/
    FUNCTION frfGetTaTyOpSeLOV
    return Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetResponsableLOV
    Descripcion	: Metodo que obtiene los responsables.
    ******************************************************************/
    FUNCTION frfGetResponsableLOV
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOrganizationAreaLOV
    Descripcion	: Metodo que obtiene los Sectores Operativos.
    ******************************************************************/
    FUNCTION frfGetOrganizationAreaLOV
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperUnitClasifLOV
    Descripcion	: Metodo que obtiene las clasificaciones de las unidades operativas
    ******************************************************************/
    FUNCTION frfGetOperUnitClasifLOV
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetStatusLOV
    Descripcion	: Metodo que obtiene los estados de las unidades operativas
    ******************************************************************/
    FUNCTION frfGetStatusLOV
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetStatusLOV
    Descripcion	: Metodo que obtiene las clasificaciones de los tipos de trabajos
    ******************************************************************/
    FUNCTION frfGetTaskTypesClassif
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaskTypesByClass
    Descripcion	: Metodo que obtiene las clasificaciones de los tipos de trabajos
    ******************************************************************/
    FUNCTION frfGetTaskTypesByClass
    (
        inuTaskClassId in ge_task_class.task_class_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetNotificationTypes
    Descripcion	: Metodo que obtiene los tipos de notificaciones
    ******************************************************************/
    FUNCTION frfGetNotificationTypes
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetNotifsByNotiType
    Descripcion	: Metodo que obtiene las notificaciones por tipo de notificacion
    ******************************************************************/
    FUNCTION frfGetNotifsByNotiType
    (
        inuNotificationTypeId in ge_notification.notification_type_id%type
    )
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetItemsClassif
    Descripcion	: Metodo que obtiene las clasificaciones de items
    ******************************************************************/
    FUNCTION frfGetItemsClassif
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frcGetItemsByClassif
    Descripcion	: Metodo que obtiene los items por clasificacion
    ******************************************************************/
    FUNCTION frfGetItemsByClassif
    (
        inuItemClassifId in ge_item_classif.item_classif_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frcGetItemsByClassif
    Descripcion	: Metodo que obtiene los tipos de causales
    ******************************************************************/
    FUNCTION frfGetCausalType
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetCausalsByType
    Descripcion	: Metodo que obtiene las causales por tipo
    ******************************************************************/
    FUNCTION frfGetCausalsByType
    (
        inuCausalTypeId in ge_causal.causal_type_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetCommentClass
    Descripcion	: Metodo que obtiene las clases de comentarios
    ******************************************************************/
    FUNCTION frfGetCommentClass
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetCommentsByClass
    Descripcion	: Metodo que obtiene los comentarios por clase
    ******************************************************************/
    FUNCTION frfGetCommentsByClass
    (
        inuCommentClassId in ge_comment_type.comment_class_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperatingSectors
    Descripcion	: Metodo que obtiene los sectores operativos
    ******************************************************************/
    FUNCTION frfGetOperatingSectors
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperatingSectorLOV
    Descripcion	: Metodo que obtiene los sectores operativos
    ******************************************************************/
    FUNCTION frfGetOperatingSectorLOV
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperSecClassifLOV
    Descripcion	: Metodo que obtiene las clasificaciones de sectores operativos
    ******************************************************************/
    FUNCTION frfGetOperSecClassifLOV
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetServiceClassLOV
    Descripcion	: Metodo que obtiene las clases de servicios
    ******************************************************************/
    FUNCTION frfGetServiceClassLOV
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaskTypeData
    Descripcion	: Metodo que obtiene los datos de un tipo de trabajo
    ******************************************************************/
    FUNCTION frfGetTaskTypeData
    (
        inuTaskTypeId in or_task_type.task_type_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaskTypeNetElems
    Descripcion	: Metodo que obtiene los items de un tipo de trabajo
    ******************************************************************/
    FUNCTION frfGetTaskTypeItems
    (
        inuTaskTypeId in or_task_type.task_type_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaskTypeCausals
    Descripcion	: Metodo que obtiene las causales por tipo de trabajo
    ******************************************************************/
    FUNCTION frfGetTaskTypeCausals
    (
        inuTaskTypeId in or_task_type.task_type_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaskTypeComments
    Descripcion	: Metodo que obtiene los comentarios por tipo de trabajo
    ******************************************************************/
    FUNCTION frfGetTaskTypeComments
    (
        inuTaskTypeId in or_task_type.task_type_id%type
    )
    RETURN constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetItemCostMethod
    Descripcion	: Metodo que obtiene el metodo de costo de un item
    ******************************************************************/
    FUNCTION fsbGetItemCostMethod
    (
        itemsId in ge_items.items_id%type
    )
    RETURN ge_item_classif.cost_method%type;

    /*****************************************************************
    Unidad        : fnuHasSchedule
    Descripcion	: verifica si existe una unidad operativa registrada en
                    la tabla OR_sched_available
    ******************************************************************/
    FUNCTION fnuHasSchedule
    (
      inuOperUnitId  in or_operating_unit.operating_unit_id%type
    )
    RETURN or_sched_available.sched_available_id%type;

    /*****************************************************************
    Unidad        : frfGetOperZonesLOV
    Descripcion	:   Consulta la lista de Valores de las Zonas Operativas
    ******************************************************************/
    FUNCTION frfGetOperZonesLOV
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperZones
    Descripcion	: Metodo que obtiene las Zonas Operativas.
    ******************************************************************/
    FUNCTION frfGetOperZones
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperSectorsByOperZone
    Descripcion	: Metodo que obtiene los Sectores Operativos por Zona
    ******************************************************************/
    FUNCTION frfGetOperSectorsByOperZone
    (
        inuOperZoneId      in  or_operating_sector.operating_zone_id%type
    )
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Unidad        : GetOperUnitClass
    Descripcion	:   Da las clasificaciones asociadas, es decir las que pueden o
                    las que no pueden trabajar con items. Todo depende de la
                    clasificacion de entrada
    ******************************************************************/
    FUNCTION frfGetOperUnitClass
    (
        inuClassOperUnitId  IN  OR_operating_unit.oper_unit_classif_id%type
    )RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: fsbGetItemQuantityControl
    Descripcion	: Metodo que obtiene el metodo de control de cantidad de un item
    ******************************************************************/
    FUNCTION fsbGetItemQuantityControl
    (
        inuItemsId in ge_items.items_id%type
    )
    RETURN ge_item_classif.quantity_control%type;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetRolesForWorkUnit
    Descripcion	: Metodo que obtiene el personal por su tipo
    ******************************************************************/
    FUNCTION frfGetRolesForWorkUnit
    RETURN Constants.tyRefCursor;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfObtExcActByOpeUni
    Descripcion	: Metodo que obtiene las excepciones de actividad para una
                  unidad operativa.
    ******************************************************************/
    FUNCTION frfObtExcActByOpeUni
    (
        inuOperUnitId           IN  or_operating_unit.operating_unit_id%type
    )   RETURN Constants.tyRefCursor;


    /*****************************************************************
    Unidad   :      incAssigOrdersAmount
    Descripcion	:   Obtiene las unidades operativas de una base
    ******************************************************************/
    PROCEDURE GetOperUnitsByBase
    (
        adminBaseId     IN  OR_operating_unit.admin_base_id%type,
        orfOperUnits    OUT constants.tyRefCursor
    );

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  GetDispatchUnits
    Descripcion :  Obtiene las unidades de clase despachante
    ***************************************************************/
    PROCEDURE GetDispatchUnits
    (
        orfOperUnits    OUT constants.tyRefCursor
    );

    /**************************************************************
    Unidad      :  fblValidOperUnitAssign
    Descripcion :  Valida si la orden puede asignarse a la unidad de trabajo.
                   Si la orden es de proyecto, valida que la unidad pertenezca a
                   la proyecto
    ***************************************************************/
    FUNCTION fsbValidOperUnitAssign
    (
        ircOrder        in  daor_order.styOR_order,
        inuOperUnitId   in  OR_operating_unit.operating_unit_id%type
    )
    return varchar2;

    /**************************************************************
    Unidad      :  fblValidOpeUniSchedAssign
    Descripcion :  Valida si la orden puede asignarse a la unidad de trabajo de agenda.
                   Si la orden es de proyecto, valida que la unidad pertenezca a
                   la proyecto
    ***************************************************************/
    FUNCTION fsbValidOpeUniSchedAssign
    (
        ircOrder        in  daor_order.styOR_order,
        inuOperUnitId   in  OR_operating_unit.operating_unit_id%type
    )
    return varchar2;

    /**************************************************************
    Unidad      :  frfGetOperUnitAssType
    Descripcion :  CURSOR referenciado con los tipos de asignaciones
                   permitidos para una unidad operativa
    ***************************************************************/
    FUNCTION frfGetOperUnitAssType
    return Constants.tyRefCursor;

    /**************************************************************
    Unidad      :  GetOperatingUnitLov
    Descripcion :  Lista de unidades de trabajo del usuario, si no se
                   tiene ninguna asociada se muestran todas. Se toma de
                   ORCAO
    ***************************************************************/
    PROCEDURE GetOperatingUnitLov(orfCursor out constants.tyRefCursor);

END OR_BCOperUnit_Admin;
/
CREATE OR REPLACE PACKAGE BODY OR_BCOperUnit_Admin
IS
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : OR_BCOperUnit_Admin
Descripcion    : Metodos usados en configuracion de unidades operativas

 Fecha        Autor                Modificacion
=========    =========           ====================
17-09-2014   Locampo.SAO273762   Se modifica <fblValidOperUnitAssign>
19-02-2014   ACastro.SAO233694   Se ajusta <fsbValidOperUnitAssign>
19-06-2013   MArteaga.SAO209275  Se agrega: <GetOperatingUnitLov>
18-04-2013   jaricapa.SAO206014  Se modifica <GetOperUnitsByBase>.
07-03-2013   ICeron.SAO203827    Se modifica el metodo <frfGetItemsClassif>
25-01-2013   juzuriaga.SAO200512 Se modifica el metodo <frfGetItemsClassif>
17-12-2012   cenaviaSAO197595    Se modifica <frfGetRolesForWorkUnit>
29-11-2012   llopezSAO197153     Se modifica frfGetOperUnitItems
13-08-2012   hcruz.SAO186225     Modificacion del metodo frfGetOperUnitItems
10-05-2012   cenaviaSAO181999    Estabilizacion
04-05-2012   cenaviaSAO181117    Se modifica el metodo:
                                    <frfGetOpeUniPersonal>
                                 Se elimina la siguiente funcion:
                                    <frfGetPersonsLOV>
28-03-2012   Juzuriaga.SAO176910 Se modifican <fsbValidOperUnitAssign>.
                                              <fsbValidOpeUniSchedAssign>.
16-03-2012   jaricapa.SAO177570  Se modifica <fsbValidOperUnitAssign>.
26-12-2011   jaricapa.SAO164882  Se modifica <GetOperUnitsByBase>.
13-12-2011   cenaviaSAO168500    Estabilizacion
             AEcheverrySAO161658 Se modifica los metodos
                                    <<fsbValidOperUnitAssign>>
                                    <<fsbValidOpeUniSchedAssign>>
02-12-2010   cburbano.SAO134915  Se modifica fblValidOperUnitAssign y se adiciona
                                 fblValidOpeUniSchedAssign
29-11-2010   cburbano.SAO133936  Se adiciona fblValidOperUnitAssign
23-Sep-2010  llopezSAO125643    Se modifica <<GetDispatchUnits>>
21-09-2010   sagudeloSAO128143  Se modifica:
                                    - <frfGetExistingRules>
16-09-2010   llopezSAO126825    Se modifica <<frfGetItemsClassif>>
21-08-2010   jaricapaSAO122950  Se agrega "GetDispatchUnits".

28-Jul-2010  GPazSAO121017      Se modifican:
                                <<frfGetCommentClass>>
                                <<frfGetOpeUniComments>>
                                <<frfGetCommentTypesLOV>>
                                <<frfGetCommentsByClass>>
                                <<frfGetTaskTypeComments>>
24-06-2010   cburbanoSAO119763  Se adiciona GetOperUnitsByBase
16-06-2010   aavelezSAO119436   se elimina el metodo frfGetTaskTypeNetElems
22-May-2010  DMunoz SAO118251   Se adiciona frfObtExcActByOpeUni
21-May-2010  MArteagaSAO117612  Se agrega <<frfGetRolesForWorkUnit>>
18-May-2010  llopezSAO117734    Se modifica frfGetPersonsLOV y frfGetPersonsByType
26-04-2010   cburbanoSAO116580  Se modifica la funcion frfGetPersonsLOV y frfGetPersonsByType
26-11-2009   MArteagaSAO107945  Se modifica el metodo frfGetOperUnitItems para
                                recuperar el campo quantity_control de ge_item_classif
                                y se agrega el metodo fsbGetItemQuantityControl
19-10-2009   DMunoz SAO105151   Se adiciona frfGetOperUnitClass.
02-03-2009   gpazSAO91773       Se modifan los procedimientos: frfGetOpeUniTaTySeOp,
                                frfGetOpUnTaskTypes para que no hagan uso del campo
                                or_ope_uni_task_type.executing_last_time.
                                Se modifica el procedimiento frfGetOperatingUnitsLOV
                                para que traiga la descripcion junto con el codigo.
                                Se agregan los procedimientos:
                                - frfGetPersonType
                                - frfGetPersonsByType
                                - frfGetOperZones
                                - frfGetOperSectorsByOperZone
                                Se elimina el procedimiento:
                                - frfGetOpeUniOrdeClas
30-01-2009   cburbanoSAO89466   Se modifica el metodo frfGetOpeUniTaTyNoti
04-11-2008   gpazSAO81777       Se modifican las funciones frfGetPersonsLOV y
                                frfGetResponsableLOV.
                                Se adiciona la funcion frfGetOperZonesLOV.

20-10-2008   aavelezSAO81777    Se adiciona la funcion fnuHasSchedule

26-09-2008   gpazSAO82888       Se modifica el procedimiento frfGetNotificationTypes
                                para filtrar por las notificaciones usadas en el
                                Modulo de Ordenes.
                                Se agregan las constantes cnuMail y cnuImpresion
20-08-2008   gramirezSAO79813   Creacion  OR_BCOperUnit_Admin
******************************************************************/


    ---------------------------------------
    -- constantes
    ---------------------------------------
    -- Declaracion de cosntantes privados del paquete
    csbVersion          CONSTANT VARCHAR2(20) := 'SAO273762';
    cnuMail             CONSTANT NUMBER(4)    := 2;
    cnuImpresion        CONSTANT NUMBER(4)    := 3;
    csbASSIGN_TYPE      CONSTANT ge_entity_attributes.technical_name%type := 'ASSIGN_TYPE';
    csbOR_OPERATING_UNIT CONSTANT ge_entity.name_%type := 'OR_OPERATING_UNIT';

    -- Clasificacion de items para actividades:= 2
    cnuITEMS_CLASS_TO_ACTIVITY CONSTANT ge_items.item_classif_id%type
    := OR_boConstants.cnuITEMS_CLASS_TO_ACTIVITY;

    -- Clasificacion Actividades Administrativas:= 12
    cnuADMIN_ACTIV_CLASSIF CONSTANT ge_items.item_classif_id%type
    := OR_boConstants.cnuADMIN_ACTIV_CLASSIF;

    -- Clasificacion Herramienta Seriada :=13
    cnuITEM_CLASS_SERIAL_TOOL  CONSTANT ge_items.item_classif_id%type
    := OR_boConstants.cnuITEM_CLASS_SERIAL_TOOL;

    -- Clasificacion  Equipos y Accesorios := 21
    cnuITEM_CLASS_EQUP_ACC  CONSTANT ge_item_classif.item_classif_id%type
    := or_bcconstants.cnuITEM_CLASS_EQUP_ACC;

    -- Clasificacion Accesorios (Esta clasificacion se creo para Openmobile SAO103756) :=22
    cnuITEM_CLASS_ACCESSORY CONSTANT ge_item_classif.item_classif_id%type
    := or_bcconstants.cnuITEM_CLASS_ACCESSORY;

    -- Constante Y
    csbYes CONSTANT VARCHAR2(3):= ge_boconstants.csbYES;

    ---------------------------------------
    -- Funciones y Procedimientos publico
    ---------------------------------------
    --  retorna  la version del SAO
    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    END;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetNewStatusLov
    Descripcion	: Obtiene los estados diferentes al que se pasa por parametro.

    Parametros	:	    Descripcion
    inuOldStatus        Estado anterior

    Autor	: Cesar Pantoja
    Fecha	: 03-09-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    03-09-2008      cpantojaSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetNewStatusLov
    (
        inuOldStatus in OR_OPER_UNIT_STATUS.oper_unit_status_id%type
    )
    RETURN constants.tyRefCursor
	IS
        orfCursor constants.tyRefCursor;
	BEGIN
        open orfCursor for
            SELECT ALL oper_unit_status_id id, description
            FROM or_oper_unit_status
            WHERE oper_unit_status_id not in (inuOldStatus);

        return orfCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetNewStatusLov;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetCausals
    Descripcion	: Obtiene las causales

    Parametros	:	    Descripcion

    Autor	: Cesar Pantoja
    Fecha	: 03-09-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    03-09-2008      cpantojaSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetCausals
    RETURN constants.tyRefCursor
	IS
        orfCursor constants.tyRefCursor;
    BEGIN
        open orfCursor for
            SELECT opeuni_stchg_caus_id id, description
            FROM or_opeuni_stchg_caus;

        return orfCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetCausals;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetExistingRules
    Descripcion	: Obtiene las Reglas que hay en OR_OPUNI_TSKTYP_NOTI

    Parametros	:	    Descripcion
    inuOperUnit         Identificador de la unidad de trabajo

    Autor	: Gustavo Adolfo Paz
    Fecha	: 02-09-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    21-09-2010      sagudeloSAO128143   Se adiciona la Unidad de Trabajo
    02-08-2008      gpazSAO79813        Creacion
    ******************************************************************/
    FUNCTION frfGetExistingRules
    (
        inuOperUnit     in  or_operating_unit.operating_unit_id%type
    )
    RETURN constants.tyRefCursor
    IS
        RefCursor   constants.tyRefCursor;
    BEGIN
        OPEN RefCursor FOR
            SELECT  DISTINCT B.CONFIG_EXPRESSION_ID,
                    B.DESCRIPTION DESCRIPTION
            FROM    OR_OPUNI_TSKTYP_NOTI A,
                    GR_CONFIG_EXPRESSION B
            WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
            AND     A.OPERATING_UNIT_ID = inuOperUnit;
        return RefCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if RefCursor%isopen THEN
                close RefCursor;
            end if;
            raise ex.CONTROLLED_ERROR;
        when others THEN
            if RefCursor%isopen THEN
                close RefCursor;
            end if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperatingUnits
    Descripcion	: Metodo de consulta de Unidades Operativas.

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOperatingUnits
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT or_operating_unit.*
            FROM or_operating_unit;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperatingUnits;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperatingUnit
    Descripcion	: Metodo de consulta de los datos de una Unidad Operativa.

    Parametros	:	    Descripcion
    inuOperatingUnitId  Id de la Unidad Operativa

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOperatingUnit
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT or_operating_unit.*
            FROM or_operating_unit
            WHERE operating_unit_id = inuOperatingUnitId;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperatingUnit;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperatingUnitsLOV
    Descripcion	: Metodo que obtiene la lista de valores de Unidades Operativas.

    Parametros	:	    Descripcion
    inuOperatingUnitId  Id de la Unidad Operativa a no incluir en el LOV

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    02-03-2009      gpazSAO91773        Se modifica para que traiga la
                                        descripcion junto con el codigo.
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOperatingUnitsLOV
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        sbquery varchar2(1000);
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        if (inuOperatingUnitId is null) then
            open orfDataCursor FOR SELECT operating_unit_id CODE,
                                          name ||' ('||operating_unit_id||')' DESCRIPTION
                                  FROM or_operating_unit;
        else
            sbquery := 'SELECT operating_unit_id CODE,name DESCRIPTION'||chr(10)||
                       'FROM or_operating_unit'||chr(10)||
                       'WHERE operating_unit_id != :inuOperatingUnitId';
                       open orfDataCursor for sbquery using inuOperatingUnitId;
        end if;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperatingUnitsLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frcGetOpUnTaskTypes
    Descripcion	: Metodo que obtiene los tipos de trabajo de una Unidad Operativa.

    Parametros	:	    Descripcion
    inuOperatingUnitId  Id de la Unidad Operativa

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    02-03-2009      gpazSAO91773        Se modifan para que no haga uso del campo
                                        or_ope_uni_task_type.executing_last_time
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOpUnTaskTypes
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_ope_uni_task_type.task_type_id) task_type_id,
                   or_ope_uni_task_type.task_type_id || ' - ' ||or_task_type.description description,
                   or_ope_uni_task_type.average_time average_time,
                   to_char(or_ope_uni_task_type.orders_amount) orders_amount,
                   to_char(or_ope_uni_task_type.qualification) qualification,
                   or_ope_uni_task_type.time_factor time_factor,
                   to_char(or_ope_uni_task_type.operating_unit_id) operating_unit_id
            FROM or_ope_uni_task_type,
                 OR_task_type
            WHERE or_ope_uni_task_type.operating_unit_id = inuOperatingUnitId
              AND or_ope_uni_task_type.task_type_id = OR_task_type.task_type_id;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOpUnTaskTypes;

    ----------------------------------------------------------------------------

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperUnitItems
    Descripcion	: Metodo que obtiene los items de una Unidad Operativa.

    Parametros	:	    Descripcion
    inuOperatingUnitId  Id de la Unidad Operativa

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    29-11-2012      llopezSAO197153     Se modifica para obtener la cuota ocacional
    13-08-2012      hcruzSAO186225      1 - Eliminacion del id en la descripcion y
                                            adicion del Code en el mismo.
    06-11-2009      MArteagaSAO106890   Se modifica para recuperar el campo
                                        quantity_control de ge_item_classif
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOperUnitItems
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_ope_uni_item_bala.operating_unit_id) operating_unit_id,
                   to_char(or_ope_uni_item_bala.items_id) items_id,
                   ge_items.code||' - '||ge_items.description item_description,
                   to_char(or_ope_uni_item_bala.quota) quota,
                   to_char(or_ope_uni_item_bala.balance) balance,
                   to_char(or_ope_uni_item_bala.total_costs) total_costs,
                   to_char(ge_item_classif.cost_method) cost_method,
                   TO_char(ge_item_classif.quantity_control) quantity_control,
                   to_char(nvl(or_ope_uni_item_bala.occacional_quota, 0)) OCCASIONAL_QUOTA
            FROM or_ope_uni_item_bala,
                 ge_items,
                 ge_item_classif /*+ OR_BCOperUnit_Admin.frfGetOperUnitItems SAO197153 */
            WHERE or_ope_uni_item_bala.operating_unit_id = inuOperatingUnitId
              AND or_ope_uni_item_bala.items_id = ge_items.items_id
              AND ge_items.item_classif_id = ge_item_classif.item_classif_id;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperUnitItems;

     /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOpeUniPersonal
    Descripcion	: Metodo que obtiene el personal de una Unidad Operativa.

    Parametros	:	    Descripcion
    inuOperatingUnitId  Id de la Unidad Operativa

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    10-05-2012      cenaviaSAO181999    Estabilizacion
    04-05-2012      cenaviaSAO181117    Se modifica para que tambien obtenga el id
                                        del personal concatenado con el nombre de
                                        la persona.
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOpeUniPersonal
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_oper_unit_persons.person_id) person_id,
                   to_char(or_oper_unit_persons.operating_unit_id) operating_unit_id,
                   to_char(ge_person.person_id)||' - '||to_char(ge_person.name_) phantom_column
            FROM or_oper_unit_persons,
                 ge_person
            /*+ OR_BCOperUnit_Admin.frfGetOpeUniPersonal SAO181999 */
            WHERE or_oper_unit_persons.operating_unit_id = inuOperatingUnitId
              AND or_oper_unit_persons.person_id = ge_person.person_id;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOpeUniPersonal;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOpeUniComments
    Descripcion	: Metodo que obtiene los comentarios de una Unidad Operativa.

    Parametros	:	    Descripcion
    inuOperatingUnitId  Id de la Unidad Operativa

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    28-07-2010      gpazSAO121017       Se excluye la clase de comentario 23
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOpeUniComments
    (
        inuOperatingUnitId in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_oper_unit_comment.operating_unit_id) operating_unit_id,
                   to_char(or_oper_unit_comment.comment_type_id) comment_type_id,
                   to_char(or_oper_unit_comment.comments) comments,
                   or_oper_unit_comment.comment_date comment_date,
                   to_char(or_oper_unit_comment.user_id) user_id,
                   to_char(or_oper_unit_comment.terminal) terminal
            FROM or_oper_unit_comment,
                 ge_comment_type
            WHERE or_oper_unit_comment.operating_unit_id = inuOperatingUnitId
              AND or_oper_unit_comment.comment_type_id = ge_comment_type.comment_type_id
              AND ge_comment_type.comment_class_id <> SA_BOConstant.cnuUSERS_COMMENT_CLASS;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOpeUniComments;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOpeUniTaTyNoti
    Descripcion	: Metodo que obtiene las notificaciones de los tipos de trabajo
                  de una Unidad Operativa.

    Parametros	:	    Descripcion
    inuTaskTypeId       Id del Tipo de Trabajo
    inuOperatingUnitId  Id de la Unidad Operativa

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    30-01-2009      cburbanoSAO89466    Se adiciona a la consulta el campo
                                        orders_per_page
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOpeUniTaTyNoti
    (
        inuTaskTypeId       in or_ope_uni_task_type.task_type_id%type,
        inuOperatingUnitId  in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_opuni_tsktyp_noti.task_type_id) task_type_id,
                   to_char(or_opuni_tsktyp_noti.notification_id) notification_id,
                   or_opuni_tsktyp_noti.notification_id||' - '||ge_notification.description notification_description,
                   to_char(or_opuni_tsktyp_noti.config_expression_id) config_expression_id,
                   to_char(or_opuni_tsktyp_noti.operating_unit_id) operating_unit_id,
                   to_char(or_opuni_tsktyp_noti.orders_per_page) orders_per_page
            FROM or_opuni_tsktyp_noti,
                 ge_notification
            WHERE or_opuni_tsktyp_noti.operating_unit_id = inuOperatingUnitId
              AND or_opuni_tsktyp_noti.task_type_id = inuTaskTypeId
              AND or_opuni_tsktyp_noti.notification_id = ge_notification.notification_id;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOpeUniTaTyNoti;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOpeUniTaTySeOp
    Descripcion	: Metodo que obtiene los Sectores Operativos por Tipo de Trabajo
                  de una Unidad Operativa.

    Parametros	:	    Descripcion
    inuTaskTypeId       Id del Tipo de Trabajo
    inuOperatingUnitId  Id de la Unidad Operativa

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    02-03-2009      gpazSAO91773        Se modifan para que no haga uso del campo
                                        or_ope_uni_task_type.executing_last_time
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOpeUniTaTySeOp
    (
        inuTaskTypeId       in or_ope_uni_task_type.task_type_id%type,
        inuOperatingUnitId  in or_operating_unit.operating_unit_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_opse_opunt_tsktyp.task_type_id) task_type_id,
                   to_char(or_opse_opunt_tsktyp.operating_unit_id) operating_unit_id,
                   to_char(or_opse_opunt_tsktyp.operating_sector_id) operating_sector_id,
                   to_char(or_opse_opunt_tsktyp.orders_amount) orders_amount,
                   or_opse_opunt_tsktyp.average_time average_time,
                   or_opse_opunt_tsktyp.time_factor time_factor,
                   to_char(or_opse_opunt_tsktyp.qualification) qualification
            FROM or_opse_opunt_tsktyp,
                 or_operating_sector
            WHERE or_opse_opunt_tsktyp.operating_unit_id = inuOperatingUnitId
              AND or_opse_opunt_tsktyp.task_type_id = inuTaskTypeId
              AND or_opse_opunt_tsktyp.operating_sector_id = or_operating_sector.operating_sector_id;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOpeUniTaTySeOp;

    /*****************************************************************
        Propiedad intelectual de Open International Systems. (c).

        Procedure	: frfGetCommentTypesLOV
        Descripcion	: Metodo que obtiene los tipos de comentarios.

        Parametros	:	    Descripcion

        Autor	: Gerardo Ramirez
        Fecha	: 20-08-2008

        Historia de Modificaciones
        Fecha       Autor               Modificacion
        =========== =================== ====================
        21-12-2012  cburbano.SAO198609  Se modifica para no enviar la descripcion concatenada con
                                        identificador del tipo de comentario
        28-07-2010  gpazSAO121017       Se excluye la clase de comentario 23
        20-08-2008  gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetCommentTypesLOV
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(ge_comment_type.comment_type_id) code,
                   ge_comment_type.description description
            FROM ge_comment_type  /*+ OR_BCOperUnit_Admin.frfGetCommentTypesLOV SAO198609 */
            WHERE ge_comment_type.comment_class_id <> SA_BOConstant.cnuUSERS_COMMENT_CLASS;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetCommentTypesLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetPersonType
    Descripcion	: Metodo que obtiene los tipos de personas.

    Parametros	:	    Descripcion

    Autor	: Gustavo Adolfo Paz
    Fecha	: 10-03-2009

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    10-03-2009      gpazSAO91773        Creacion
    ******************************************************************/
    FUNCTION frfGetPersonType
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT ge_personal_type.personal_type code,
                   ge_personal_type.description description
            FROM ge_personal_type;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetPersonType;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetPersonsByType
    Descripcion	: Metodo que obtiene el personal por su tipo

    Parametros	:	    Descripcion

    Autor	: Gustavo Adolfo Paz
    Fecha	: 10-03-2009

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    18-May-2010     llopezSAO117734     Se elimina como parametro de entrada la OU
    26-04-2010      cburbanoSAO116580   Se permite que una misma persona este
                                        en mas de una Unidad Operativa.
    10-03-2009      gpazSAO91773        Creacion
    ******************************************************************/
    FUNCTION frfGetPersonsByType
    (
        inuPersonalType    in ge_personal_type.personal_type%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT ge_person.person_id,
                   ge_person.name_
            FROM ge_person
            WHERE ge_person.personal_type = inuPersonalType ;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetPersonsByType;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOrderClassifLOV
    Descripcion	: Metodo que obtiene la clasificacion de las ordenes.

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOrderClassifLOV
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_order_classif.order_classif_id) code,
                   or_order_classif.order_classif_id ||' - '||
                   or_order_classif.description description
            FROM or_order_classif;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOrderClassifLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaTyOpSeLOV
    Descripcion	: Metodo que obtiene los Sectores Operativos.

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetTaTyOpSeLOV
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_operating_sector.operating_sector_id) code,
                   or_operating_sector.operating_sector_id ||' - '||
                   or_operating_sector.description description
            FROM or_operating_sector;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetTaTyOpSeLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetResponsableLOV
    Descripcion	: Metodo que obtiene los responsables.

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    04-11-2008      gpazSAO81777        Se cambia la manera como se selecciona
                                        el Responsable de una Unidad Operativa
                                        para permitir que una misma persona este
                                        a cargo de mas de una Unidad Operativa
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetResponsableLOV
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT ge_person.person_id code,
                   ge_person.person_id ||' - '||
                   ge_person.name_ NAME
            FROM ge_person;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetResponsableLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOrganizationAreaLOV
    Descripcion	: Metodo que obtiene los Sectores Operativos.

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOrganizationAreaLOV
    RETURN constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(ge_organizat_area.organizat_area_id) code,
                   ge_organizat_area.name_ description
            FROM ge_organizat_area;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOrganizationAreaLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperUnitClasifLOV
    Descripcion	: Metodo que obtiene las clasificaciones de las unidades operativas

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOperUnitClasifLOV
    RETURN constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_oper_unit_classif.oper_unit_classif_id) code,
                   or_oper_unit_classif.description description
            FROM or_oper_unit_classif;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperUnitClasifLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetStatusLOV
    Descripcion	: Metodo que obtiene los estados de las unidades operativas

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetStatusLOV
    RETURN constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_oper_unit_status.oper_unit_status_id) code,
                   or_oper_unit_status.description description
            FROM or_oper_unit_status;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetStatusLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetStatusLOV
    Descripcion	: Metodo que obtiene las clasificaciones de los tipos de trabajos

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetTaskTypesClassif
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT ge_task_class.task_class_id CODE,
                   ge_task_class.description
            FROM ge_task_class;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetTaskTypesClassif;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaskTypesByClass
    Descripcion	: Metodo que obtiene las clasificaciones de los tipos de trabajos

    Parametros	:	    Descripcion
    inuTaskClassId      Id de la Clasificacion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetTaskTypesByClass
    (
        inuTaskClassId in ge_task_class.task_class_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT or_task_type.*
            FROM or_task_type
            WHERE task_type_classif = nvl(inuTaskClassId,task_type_classif);


        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetTaskTypesByClass;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetNotificationTypes
    Descripcion	: Metodo que obtiene los tipos de notificaciones

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    26-09-2008      gpazSAO82888        Se modifica el procedimiento para filtrar
                                        por las notificaciones usadas en el
                                        Modulo de Ordenes.
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetNotificationTypes
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT notification_type_id CODE,
                   description
            FROM ge_notification_type
            WHERE ge_notification_type.notification_type_id = cnuMail
               OR ge_notification_type.notification_type_id = cnuImpresion;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetNotificationTypes;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetNotifsByNotiType
    Descripcion	: Metodo que obtiene las notificaciones por tipo de notificacion

    Parametros	:	      Descripcion
    inuNotificationTypeId Id del tipo de notificacion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetNotifsByNotiType
    (
        inuNotificationTypeId in ge_notification.notification_type_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT ge_notification.*
            FROM ge_notification
            WHERE origin_module_id = 4
              AND target_module_id = 4
              AND notification_type_id = nvl(inuNotificationTypeId,notification_type_id);

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetNotifsByNotiType;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetItemsClassif
    Descripcion	: Metodo que obtiene las clasificaciones de items

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    07-03-2013      ICeron.SAO203827    Se modifica para que la consulta filtre
                                        unicamente por los que manejan QUOTA.
    25-01-2013      juzuriaga.SAO200512 Se modifica para que en la consulta
                                        se excluyan las clasificaciones 22,21,13
                                        que se excluian por codigo en .Net
    16-09-2010      llopezSAO126825     Se modifica para que NO recupere
                                        las actividades administrativas
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetItemsClassif
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN

        open orfDataCursor for
           SELECT item_classif_id code,
                   description
            FROM ge_item_classif
                 /*+ OR_BCOperUnit_Admin.frfGetItemsClassif */
            WHERE quota = csbYes;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetItemsClassif;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frcGetItemsByClassif
    Descripcion	: Metodo que obtiene los items por clasificacion

    Parametros	:	    Descripcion
    inuItemClassifId    Id de la clasificacion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetItemsByClassif
    (
        inuItemClassifId in ge_item_classif.item_classif_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT ge_items.*
            FROM ge_items
            WHERE item_classif_id = nvl(inuItemClassifId,item_classif_id);

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetItemsByClassif;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frcGetItemsByClassif
    Descripcion	: Metodo que obtiene los tipos de causales

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetCausalType
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT ge_causal_type.causal_type_id code,
                   ge_causal_type.description
            FROM ge_causal_type;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetCausalType;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetCausalsByType
    Descripcion	: Metodo que obtiene las causales por tipo

    Parametros	:	    Descripcion
    inuCausalTypeId     Id del Tipo de causal

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetCausalsByType
    (
        inuCausalTypeId in ge_causal.causal_type_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT ge_causal.*
            FROM ge_causal
            WHERE causal_type_id = nvl(inuCausalTypeId,causal_type_id);

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetCausalsByType;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetCommentClass
    Descripcion	: Metodo que obtiene las clases de comentarios

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    28-07-2010      gpazSAO121017       Se excluye la clase de comentario 23
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetCommentClass
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT ge_comment_class.comment_class_id code,
                   ge_comment_class.description
            FROM ge_comment_class
            WHERE ge_comment_class.comment_class_id <> SA_BOConstant.cnuUSERS_COMMENT_CLASS;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetCommentClass;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetCommentsByClass
    Descripcion	: Metodo que obtiene los comentarios por clase

    Parametros	:	    Descripcion
    inuCommentClassId   Id de la clase de comentario

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    28-07-2010      gpazSAO121017       Se excluye la clase de comentario 23
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetCommentsByClass
    (
        inuCommentClassId   in ge_comment_type.comment_class_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT ge_comment_type.*
            FROM ge_comment_type
            WHERE comment_class_id = nvl(inuCommentClassId,comment_class_id)
            AND ge_comment_type.comment_class_id <> SA_BOConstant.cnuUSERS_COMMENT_CLASS;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetCommentsByClass;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperatingSectors
    Descripcion	: Metodo que obtiene los sectores operativos

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOperatingSectors
    RETURN constants.tyRefCursor
    IS
        orfDataCursor constants.tyRefCursor;
    BEGIN
        open orfdatacursor for
            SELECT or_operating_sector.*
            FROM or_operating_sector;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperatingSectors;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperatingSectorLOV
    Descripcion	: Metodo que obtiene los sectores operativos

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOperatingSectorLOV
    RETURN constants.tyRefCursor
    IS
        orfDataCursor constants.tyRefCursor;
    BEGIN
        open orfdatacursor for
            SELECT or_operating_sector.operating_sector_id code,
                   or_operating_sector.description
            FROM or_operating_sector;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperatingSectorLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperSecClassifLOV
    Descripcion	: Metodo que obtiene las clasificaciones de sectores operativos

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetOperSecClassifLOV
    RETURN constants.tyRefCursor
    IS
        orfDataCursor constants.tyRefCursor;
    BEGIN
        OPEN orfDataCursor FOR
            SELECT ge_opera_sec_classif.opera_sec_classif_id code,
                   ge_opera_sec_classif.description
            FROM ge_opera_sec_classif;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperSecClassifLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetServiceClassLOV
    Descripcion	: Metodo que obtiene las clases de servicios

    Parametros	:	    Descripcion

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetServiceClassLOV
    RETURN constants.tyRefCursor
    IS
        orfDataCursor constants.tyRefCursor;
    BEGIN
        open orfdatacursor for
            SELECT ge_service_class.class_service_id code,
                   ge_service_class.description
            FROM ge_service_class;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetServiceClassLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaskTypeData
    Descripcion	: Metodo que obtiene los datos de un tipo de trabajo

    Parametros	:	    Descripcion
    inuTaskTypeId       Id del Tipo de Trabajo

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetTaskTypeData
    (
        inuTaskTypeId in or_task_type.task_type_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT or_task_type.*
            FROM or_task_type
            WHERE task_type_id = inuTaskTypeId;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetTaskTypeData;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaskTypeNetElems
    Descripcion	: Metodo que obtiene los items de un tipo de trabajo

    Parametros	:	    Descripcion
    inuTaskTypeId       Id del Tipo de Trabajo

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetTaskTypeItems
    (
        inuTaskTypeId in or_task_type.task_type_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_task_types_items.task_type_id) task_type_id,
                   to_char(or_task_types_items.items_id) items_id,
                   or_task_types_items.items_id || ' - ' || ge_items.description description,
                   to_char(or_task_types_items.display_order) display_order,
                   to_char(or_task_types_items.is_legalize_visible) is_legalize_visible,
                   to_char(or_task_types_items.item_amount) item_amount,
                   to_char(or_task_types_items.item_amount) item_amount
            FROM or_task_types_items,
                 ge_items
            WHERE or_task_types_items.task_type_id = inuTaskTypeId
              AND ge_items.items_id = or_task_types_items.items_id;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetTaskTypeItems;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaskTypeCausals
    Descripcion	: Metodo que obtiene las causales por tipo de trabajo

    Parametros	:	    Descripcion
    inuTaskTypeId       Id del Tipo de Trabajo

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetTaskTypeCausals
    (
        inuTaskTypeId in or_task_type.task_type_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_task_type_causal.causal_id) causal_id,
                   to_char(or_task_type_causal.task_type_id) task_type_id,
                   or_task_type_causal.causal_id || ' - ' || ge_causal.description description
            FROM or_task_type_causal,
                 ge_causal
            WHERE or_task_type_causal.task_type_id = inuTaskTypeId
              AND ge_causal.causal_id = or_task_type_causal.causal_id;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetTaskTypeCausals;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetTaskTypeComments
    Descripcion	: Metodo que obtiene los comentarios por tipo de trabajo

    Parametros	:	    Descripcion
    inuTaskTypeId       Id del Tipo de Trabajo

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    28-07-2010      gpazSAO121017       Se excluye la clase de comentario 23
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION frfGetTaskTypeComments
    (
        inuTaskTypeId in or_task_type.task_type_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT to_char(or_task_type_comment.comment_type_id) comment_type_id,
                   to_char(or_task_type_comment.task_type_id) task_type_id,
                   or_task_type_comment.comment_type_id || ' - ' || ge_comment_type.description description
            FROM or_task_type_comment,
                 ge_comment_type
            WHERE or_task_type_comment.task_type_id = inuTaskTypeId
              AND ge_comment_type.comment_type_id = or_task_type_comment.comment_type_id
              AND ge_comment_type.comment_class_id <> SA_BOConstant.cnuUSERS_COMMENT_CLASS;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetTaskTypeComments;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetItemCostMethod
    Descripcion	: Metodo que obtiene el metodo de costo de un item

    Parametros	:	    Descripcion
    itemsId             Id del item

    Autor	: Gerardo Ramirez
    Fecha	: 20-08-2008

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-08-2008      gramirezSAO79813    Creacion
    ******************************************************************/
    FUNCTION fsbGetItemCostMethod
    (
        itemsId in ge_items.items_id%type
    )
    RETURN ge_item_classif.cost_method%type
    IS
        sbCostMethod ge_item_classif.cost_method%type;
    BEGIN
        SELECT ge_item_classif.cost_method
        INTO sbCostMethod
        FROM ge_item_classif,
             ge_items
        WHERE ge_items.items_id = itemsId
        AND ge_item_classif.item_classif_id = ge_items.item_classif_id;
        return sbCostMethod;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbGetItemCostMethod;

    /*****************************************************************
    Unidad        : fnuHasSchedule
    Descripcion	: verifica si existe una unidad operativa registrada en
                    la tabla OR_sched_available

    Parametros          Descripcion
    ============        ===================
    Entrada:
      inuOperUnitId     Identificador de la Unidad Operativa

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-10-2008      aavelezSAO81777       Creacion
    ******************************************************************/
    FUNCTION fnuHasSchedule
    (
      inuOperUnitId  in or_operating_unit.operating_unit_id%type
    )
    RETURN or_sched_available.sched_available_id%type
    IS
       nuSched_Available_Id or_sched_available.sched_available_id%type;

       CURSOR cuSchedAvailable (inuOpeUni in number)
       IS
       SELECT or_sched_available.sched_available_id
       FROM or_sched_available
       WHERE or_sched_available.operating_unit_id = inuOpeUni
       AND rownum = 1;

    BEGIN

        open cuSchedAvailable(inuOperUnitId);
        fetch cuSchedAvailable INTO nuSched_Available_Id;
        close cuSchedAvailable;

        return nuSched_Available_Id;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END fnuHasSchedule;

    /*****************************************************************
    Unidad        : frfGetOperZonesLOV
    Descripcion	:   Consulta la lista de Valores de las Zonas Operativas

    Parametros          Descripcion
    ============        ===================
    Entrada:
      Ninguno

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    05-11-2008      gpazSAO81777        Creacion
    ******************************************************************/
    FUNCTION frfGetOperZonesLOV
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT or_operating_zone.operating_zone_id zone,
                   or_operating_zone.operating_zone_id ||' - '|| or_operating_zone.description description
            FROM or_operating_zone;
        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperZonesLOV;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperZones
    Descripcion	: Metodo que obtiene las Zonas Operativas.

    Parametros	:	    Descripcion

    Autor	: Gustavo Adolfo Paz
    Fecha	: 25-09-2009

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    25-09-2009      gpazSAO91773        Creacion
    ******************************************************************/
    FUNCTION frfGetOperZones
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT or_operating_zone.operating_zone_id code,
                   or_operating_zone.description description
            FROM or_operating_zone;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperZones;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetOperSectorsByOperZone
    Descripcion	: Metodo que obtiene los Sectores Operativos por Zona

    Parametros	:	    Descripcion

    Autor	: Gustavo Adolfo Paz
    Fecha	: 25-09-2009

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    25-09-2009      gpazSAO91773        Creacion
    ******************************************************************/
    FUNCTION frfGetOperSectorsByOperZone
    (
        inuOperZoneId      in  or_operating_sector.operating_zone_id%type
    )
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT or_operating_sector.operating_sector_id,
                   or_operating_sector.description
            FROM or_operating_sector
            WHERE or_operating_sector.operating_zone_id = inuOperZoneId;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperSectorsByOperZone;

    /*****************************************************************
    Unidad        : GetOperUnitClass
    Descripcion	:   Da las clasificaciones asociadas, es decir las que pueden o
                    las que no pueden trabajar con items. Todo depende de la
                    clasificacion de entrada

    Parametros          Descripcion
    ============        ===================
    Entrada:
      inuClassOperUnitId     Identificador de la clase de la unidad operativa

    Salida:
      orfDataCursor          clasificaicones

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    26-10-2009      SMunoz SAO105151     Entrega por homologacion
    04-06-2009      sagudeloSAO98081     Creacion
    ******************************************************************/
    FUNCTION frfGetOperUnitClass
    (
        inuClassOperUnitId  IN  OR_operating_unit.oper_unit_classif_id%type
    )RETURN Constants.tyRefCursor
    IS
        orfDataCursor   Constants.tyRefCursor;
        sbSelect        VARCHAR2(1000);
        sbWhere         VARCHAR2(1000);
    BEGIN
            sbSelect := 'SELECT  oper_unit_classif_id Id,
                                 description
                         FROM    OR_OPER_UNIT_CLASSIF';
            IF (
                inuClassOperUnitId = ge_boitemsconstants.cnuUNID_OP_CENTRO_REPARA or
                inuClassOperUnitId = ge_boitemsconstants.cnuUNID_OP_DISTRIBUIDORA or
                inuClassOperUnitId = ge_boitemsconstants.cnuUNID_OP_PROVEEDORA or
                inuClassOperUnitId = ge_boitemsconstants.cnuUNID_OP_TIENDA
                )
            THEN
                sbWhere := 'Where   oper_unit_classif_id IN (' ||
                                            ge_boitemsconstants.cnuUNID_OP_CENTRO_REPARA || ', ' ||
                                            ge_boitemsconstants.cnuUNID_OP_DISTRIBUIDORA || ', ' ||
                                            ge_boitemsconstants.cnuUNID_OP_PROVEEDORA || ', ' ||
                                            ge_boitemsconstants.cnuUNID_OP_TIENDA || ' )';
            ELSE
                sbWhere := 'Where   oper_unit_classif_id NOT IN (' ||
                                            ge_boitemsconstants.cnuUNID_OP_CENTRO_REPARA || ', ' ||
                                            ge_boitemsconstants.cnuUNID_OP_DISTRIBUIDORA || ', ' ||
                                            ge_boitemsconstants.cnuUNID_OP_PROVEEDORA || ', ' ||
                                            ge_boitemsconstants.cnuUNID_OP_TIENDA || ' )';
            END IF;

            open orfDataCursor FOR sbSelect || ' ' || sbWhere;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperUnitClass;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: fsbGetItemQuantityControl
    Descripcion	: Metodo que obtiene el metodo de control de cantidad de un item

    Parametros	:	    Descripcion
    itemsId             Id del item

    Autor	: Cesar Pantoja
    Fecha	: 06-11-2009

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    26-11-2009      MArteagaSAO107945   Estabilizacion 7.2
    ******************************************************************/
    FUNCTION fsbGetItemQuantityControl
    (
        inuItemsId in ge_items.items_id%type
    )
    RETURN ge_item_classif.quantity_control%type
    IS
        sbQuantityControl ge_item_classif.quantity_control%type;
    BEGIN
        SELECT ge_item_classif.quantity_control
        INTO sbQuantityControl
        FROM ge_item_classif,
             ge_items
        WHERE ge_items.items_id = inuItemsId
        AND ge_item_classif.item_classif_id = ge_items.item_classif_id;
        return sbQuantityControl;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbGetItemQuantityControl;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfGetRolesForWorkUnit
    Descripcion	: Metodo que obtiene el personal por su tipo

    Parametros	:	    Descripcion

    Autor	: MArteaga
    Fecha	: 20-05-2010

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    17-12-2012      cenaviaSAO197595    Se modifica para no usar el parametro del
                                        tipo de rol para una unidad sino la constante
    20-05-2010      MArteagaSAO117894   Creacion
    ******************************************************************/
    FUNCTION frfGetRolesForWorkUnit
    RETURN Constants.tyRefCursor
    IS
        orfDataCursor Constants.tyRefCursor;
    BEGIN
        open orfDataCursor for
            SELECT  /*+
                        INDEX(sa_role IDX_SA_ROLE_01)
                    */
                sa_role.role_id,
                sa_role.name
            FROM    sa_role
            /*+ OR_BCOperUnit_Admin.frfGetRolesForWorkUnit SAO197595 */
            WHERE sa_role.role_type_id = sa_boconstant.fnuGetRol_Unidad_Trabajo;

        return orfDataCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetRolesForWorkUnit;

    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Procedure	: frfObtExcActByOpeUni
    Descripcion	: Metodo que obtiene las excepciones de actividad para una
                  unidad operativa.

    Parametros	:	    Descripcion
    orfDataCursor       CURSOR referenciado con el personal

    Autor	: DMunoz
    Fecha	: 22-05-2010

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    22-05-2010      DMunoz SAO118251    Creacion
    ******************************************************************/
    FUNCTION frfObtExcActByOpeUni
    (
        inuOperUnitId           IN  or_operating_unit.operating_unit_id%type
    )   RETURN Constants.tyRefCursor
    IS
        curfGetData   Constants.tyRefCursor;
    BEGIN

        OPEN curfGetData FOR
        SELECT  or_excep_act_unitrab.id_excep_act_unitrab,
                or_excep_act_unitrab.id_unidad_operativa,
                or_excep_act_unitrab.id_actividad,
                or_excep_act_unitrab.id_actividad || ' - ' || ge_items.description description
          FROM  or_excep_act_unitrab,
                ge_items
         WHERE  or_excep_act_unitrab.id_actividad = ge_items.items_id
           AND  or_excep_act_unitrab.id_unidad_operativa = inuOperUnitId
      ORDER BY  or_excep_act_unitrab.id_actividad;

        RETURN curfGetData;

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END;


    /*****************************************************************
    Unidad   :      incAssigOrdersAmount
    Descripcion	:   Obtiene las unidades operativas de una base

    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOperating_unit   Id de la unidad operativa
        inuCount            Cantidad de ordenes a incrementar. default 1

    Historia de Modificaciones
    Fecha           Autor                  Modificacion
    ============    ===================  ====================
    18-04-2013      jaricapa.SAO206014   Se modifica para obtener el tipo de asignacion.
    26-12-2011      jaricapa.SAO164882   Se obtiene unidades con tipo
                                         de asignacion <R=Por Ruta>
    23-Jun-2010     cburbanoSAO119763    Creacion.
    ******************************************************************/
    PROCEDURE GetOperUnitsByBase
    (
        adminBaseId   IN  OR_operating_unit.admin_base_id%type,
        orfOperUnits    OUT constants.tyRefCursor
    )
    IS
    BEGIN

        OPEN orfOperUnits FOR
        SELECT  /*+ INDEX (OR_operating_unit IDX_OR_OPERATING_UNIT_04) */
                OR_operating_unit.operating_unit_id,
                OR_operating_unit.name,
                OR_operating_unit.oper_unit_status_id,
                OR_operating_unit.assign_type
        FROM    OR_operating_unit
                /*+ Ubicacion: OR_BCOperUnit_Admin.GetOperUnitsByBase */
        WHERE   OR_operating_unit.assign_type in (or_bcsched.csbASSIGN_WITH_SCHEDULE,
                                                  OR_BCOrderOperatingunit.csbASSIGN_ROUTE)

        AND     OR_operating_unit.admin_base_id = adminBaseId;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END GetOperUnitsByBase;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  GetDispatchUnits
    Descripcion :  Obtiene las unidades de clase despachante

    Autor       :  Jose Luis Aricapa M.
    Fecha       :  21-08-2010
    Parametros  :  -

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    23-Sep-2010  llopezSAO125643    Se modica el nombre de la constante que
                                    almacena el tipo de UdT despachante
    21-08-2010   jaricapa.SAO122950  Creacion
    ***************************************************************/
    PROCEDURE GetDispatchUnits
    (
        orfOperUnits    OUT constants.tyRefCursor
    )
    IS
    BEGIN

        OPEN orfOperUnits FOR
            SELECT or_operating_unit.operating_unit_id , or_operating_unit.name
            FROM  or_operating_unit
            WHERE or_operating_unit.oper_unit_classif_id = Or_BcSched.gnuClasDispatch;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END GetDispatchUnits;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fblValidOperUnitAssign
    Descripcion :  Valida si la orden puede asignarse a la unidad de trabajo.
                   Si la orden es de proyecto, valida que la unidad pertenezca a
                   la proyecto

    Autor       :  Cesar Burbano
    Fecha       :  22-11-2010
    Parametros          Descripcion
    ============        ===================
    inuOrder            Codigo de la orden
    ionuOperUnit        Codigo de la Unidad de trabajo


    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    17-09-2014   Locampo.SAO273762   Se incluye el CURSOR para que si no encuntra por capacidad
                                     busque por demanda para hacer la asignacion de ordenes.
    28-03-2012   Juzuriaga.SAO176910 Se valida que la unidad de trabajo sea valida
                                     para asignar.
    16-03-2012   jaricapa.SAO177570  Se modifica para excluir unidades con tipo de asignacion
                                     por ruta.
    13-12-2011   cenaviaSAO168500    Estabilizacion
                 AEcheverrySAO161658 Se eliminan referencias a la vista OR_ACTIVIDAD_UNITRAB
                                     Se modifica la logica para que la validacion de roles se realice
                                     en otra sentencia y mejorar el rendimiento. se modifica el CURSOR
                                     cuValidOperUnitAssign para no validar roles se elimina el CURSOR cuValidProjectUnit
    02-12-2010   cburbano.SAO134915  Se elimina el sector como parametro de entrada
                                     ya que se puede obtener de la orden
    29-11-2010   cburbano.SAO133936   Creacion
    ***************************************************************/
    FUNCTION fsbValidOperUnitAssign
    (
        ircOrder        in  daor_order.styOR_order,
        inuOperUnitId   in  OR_operating_unit.operating_unit_id%type
    )
    return varchar2
    IS

        sbValidAssign           varchar2(1);
        nuProjectId             pm_project.project_id%type;

        -- Validad si la unidad puede es valida para asignacion de la orden por Capacidad
        CURSOR cuValidOperUnitAssign_C
        IS
            SELECT /*+ ordered
                       index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
                       index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
                       index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
                       index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
                 or_boconstants.csbSI
            FROM ge_sectorope_zona, or_operating_unit, or_oper_unit_status,
                 or_ope_uni_task_type
                  /*+ OR_BCOperUnit_Admin.fsbValidOperUnitAssign SAO168500 */
            WHERE or_oper_unit_status.oper_unit_status_id = or_operating_unit.oper_unit_status_id
              AND or_operating_unit.operating_zone_id = ge_sectorope_zona.id_zona_operativa
              AND or_ope_uni_task_type.operating_unit_id = or_operating_unit.operating_unit_id
              AND or_operating_unit.operating_unit_id = inuOperUnitId
              AND or_ope_uni_task_type.task_type_id = ircOrder.task_type_id
              AND ge_sectorope_zona.id_sector_operativo = ircOrder.operating_sector_id
              AND or_oper_unit_status.valid_for_assign = or_boconstants.csbSI
              AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
              AND or_operating_unit.assign_type not in (or_bcorderoperatingunit.csbASSIGN_SCHED,
                                                        or_bcorderoperatingunit.csbASSIGN_ROUTE
                                                        )
              AND OR_BcActividad_Unitrab.fsbIsValidActOrder(ircOrder.order_id,inuOperUnitId)
              = or_boconstants.csbSI;

        -- Validad si la unidad puede es valida para asignacion de la orden por demanda
        CURSOR cuValidOperUnitAssign_D
        IS
            SELECT /*+ ordered
                       index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
                       index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
                       index(OR_ZONA_BASE_ADM IDX_OR_ZONA_BASE_ADM_02 )
                       index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
                       index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
                 or_boconstants.csbSI
            FROM ge_sectorope_zona, or_zona_base_adm, or_operating_unit, or_oper_unit_status,
                 or_ope_uni_task_type
                  /*+ OR_BCOperUnit_Admin.fsbValidOperUnitAssign SAO168500 */
            WHERE or_oper_unit_status.oper_unit_status_id = or_operating_unit.oper_unit_status_id
              AND or_operating_unit.admin_base_id = or_zona_base_adm.id_base_administra
              AND or_zona_base_adm.operating_zone_id = ge_sectorope_zona.id_zona_operativa
              AND or_ope_uni_task_type.operating_unit_id = or_operating_unit.operating_unit_id
              AND or_operating_unit.operating_unit_id = inuOperUnitId
              AND or_ope_uni_task_type.task_type_id = ircOrder.task_type_id
              AND ge_sectorope_zona.id_sector_operativo = ircOrder.operating_sector_id
              AND or_oper_unit_status.valid_for_assign = or_boconstants.csbSI
              AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
              AND or_operating_unit.assign_type not in (or_bcorderoperatingunit.csbASSIGN_SCHED,
                                                        or_bcorderoperatingunit.csbASSIGN_ROUTE
                                                        )
              AND OR_BcActividad_Unitrab.fsbIsValidActOrder(ircOrder.order_id,inuOperUnitId)
              = or_boconstants.csbSI;
    BEGIN

        ut_trace.trace('INICIO - OR_BCOperUnit_Admin.fsbValidOperUnitAssign',12);

        sbValidAssign := or_boconstants.csbNO;

        ut_trace.trace('ircOrder.stage_id := '||ircOrder.stage_id,12);
        --  se valida si la unidad esta asociada al proyecto
        if ( ircOrder.stage_id IS not null ) then

            -- Obtengo el identificador del proyecto
            nuProjectId := dapm_stage.fnuGetProject_id( ircOrder.stage_id );

            ut_trace.trace('nuProjectId := '||nuProjectId,12);

            if not dapm_unit_by_project.fblexist(nuProjectId,inuOperUnitId) then
                return sbValidAssign;
            END if;
        END if;

        -- Se valida si la unidad trabaja sobre el sector de la orden por Capacidad
        open    cuValidOperUnitAssign_C;
        fetch   cuValidOperUnitAssign_C INTO sbValidAssign;
        close   cuValidOperUnitAssign_C;

        ut_trace.trace('Asigna por Capacidad :'||sbValidAssign,12);
        -- Si la unidad de trabajo no trabaja por Capacidad se analiza si trabaja por demanda
        IF sbValidAssign = or_boconstants.csbNO THEN

        -- Se valida si la unidad trabaja sobre el sector de la orden por demanda
        open    cuValidOperUnitAssign_D;
        fetch   cuValidOperUnitAssign_D INTO sbValidAssign;
        close   cuValidOperUnitAssign_D;
        ut_trace.trace('Asigna por Demanda :'||sbValidAssign,12);
        END IF;

        ut_trace.trace('FIN - OR_BCOperUnit_Admin.fsbValidOperUnitAssign',12);

        return sbValidAssign;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbValidOperUnitAssign;

    /**************************************************************
    Unidad      :  fsbValidOpeUniSchedAssign
    Descripcion :  Valida si la orden puede asignarse a la unidad de trabajo de agenda.
                   Si la orden es de proyecto, valida que la unidad pertenezca a
                   la proyecto. Se copian los cursores del metodo fsbValidOperUnitAssign
                   pero se quita la validacion de unidades que no sean de agenda

    Autor       :  Cesar Burbano
    Fecha       :  22-11-2010
    Parametros          Descripcion
    ============        ===================
    inuOrder            Codigo de la orden
    ionuOperUnit        Codigo de la Unidad de trabajo


    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    28-03-2012   juzuriaga.SAO176910 Se valida que la unidad de trabajo sea valida
                                     para asignar.
    13-12-2011   cenaviaSAO168500    Estabilizacion.
                 AEcheverrySAO161658  Se eliminan referencias a la vista OR_ACTIVIDAD_UNITRAB
                                     Se modifica la logica para que la validacion
                                     de roles se realice en otra sentencia y mejorar el rendimiento.
                                     se modifica el CURSOR cuValidOperUnitAssign para no validar roles
                                     se elimina el CURSOR cuValidProjectUnit
    02-12-2010   cburbano.SAO134915  Creacion
    ***************************************************************/

    FUNCTION fsbValidOpeUniSchedAssign
    (
        ircOrder        in  daor_order.styOR_order,
        inuOperUnitId   in  OR_operating_unit.operating_unit_id%type
    )
    return varchar2
    IS

        sbValidAssign           varchar2(1);
        nuProjectId             pm_project.project_id%type;

        -- Validad si la unidad valida para la asignacion de la orden
        CURSOR cuValidOperUnitAssign
        IS
            SELECT /*+ ordered
                       index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
                       index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
                       index(OR_ZONA_BASE_ADM IDX_OR_ZONA_BASE_ADM_02 )
                       index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
                       index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
                 or_boconstants.csbSI
            FROM ge_sectorope_zona, or_zona_base_adm, or_operating_unit, or_oper_unit_status,
                 or_ope_uni_task_type
                 /*+ OR_BCOperUnit_Admin.fsblValidOpeUniSchedAssign SAO168500 */
            WHERE or_oper_unit_status.oper_unit_status_id = or_operating_unit.oper_unit_status_id
              AND or_operating_unit.admin_base_id = or_zona_base_adm.id_base_administra
              AND or_zona_base_adm.operating_zone_id = ge_sectorope_zona.id_zona_operativa
              AND or_ope_uni_task_type.operating_unit_id = or_operating_unit.operating_unit_id
              AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
              AND or_operating_unit.operating_unit_id = inuOperUnitId
              AND or_ope_uni_task_type.task_type_id = ircOrder.task_type_id
              AND ge_sectorope_zona.id_sector_operativo = ircOrder.operating_sector_id
              AND or_oper_unit_status.valid_for_assign = or_boconstants.csbSI
              AND OR_BcActividad_Unitrab.fsbIsValidActOrder(ircOrder.order_id,inuOperUnitId)
              = or_boconstants.csbSI;
    BEGIN

        ut_trace.trace('INICIO - OR_BCOperUnit_Admin.fsblValidOpeUniSchedAssign',12);

        sbValidAssign := or_boconstants.csbNO;

        ut_trace.trace('ircOrder.stage_id := '||ircOrder.stage_id,12);

        -- se valida si la unidad esta asociada al proyecto
        if ( ircOrder.stage_id is not null ) then

            -- Obtengo el identificador del proyecto
            nuProjectId := dapm_stage.fnuGetProject_id( ircOrder.stage_id );

            ut_trace.trace('nuProjectId := '||nuProjectId,12);

            if not dapm_unit_by_project.fblexist(nuProjectId,inuOperUnitId) then
                return sbValidAssign;
            END if;
        END if;

        -- Se valida si la unidad trabaja sobre el sector de la orden
        open    cuValidOperUnitAssign;
        fetch   cuValidOperUnitAssign INTO sbValidAssign;
        close   cuValidOperUnitAssign;

        ut_trace.trace('FIN - OR_BCOperUnit_Admin.fsbValidOpeUniSchedAssign',12);

        return sbValidAssign;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbValidOpeUniSchedAssign;

    /**************************************************************
    Unidad      :  frfGetOperUnitAssType
    Descripcion :  CURSOR referenciado con los tipos de asignaciones
                   permitidos para una unidad operativa

    Autor       :  Luis Alberto Lopez Agudelo
    Fecha       :  30-Mar-2011

    Historia de Modificaciones
    Fecha       Autor               Modificacion
    =========   =========           ====================
    30-Mar-2011 llopezSAO136093     Creacion
    ***************************************************************/
    FUNCTION frfGetOperUnitAssType
    RETURN constants.tyRefCursor
	IS
        orfCursor constants.tyRefCursor;
	BEGIN
        open orfCursor for
            SELECT ge_attr_allowed_values.*, ge_attr_allowed_values.rowid
              FROM ge_entity, ge_entity_attributes, ge_attr_allowed_values
             WHERE ge_attr_allowed_values.entity_attribute_id = ge_entity_attributes.entity_attribute_id
               AND ge_entity_attributes.entity_id = ge_entity.entity_id
               AND ge_entity_attributes.technical_name = csbASSIGN_TYPE
               AND ge_entity.name_ = csbOR_OPERATING_UNIT;

        return orfCursor;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfGetOperUnitAssType;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  GetOperatingUnitLov
    Descripcion :  Lista de unidades de trabajo del usuario, si no se
                   tiene ninguna asociada se muestran todas. Se toma de
                   ORCAO

    Autor       :  Milton H. Arteaga S.
    Fecha       :  04-06-2013
    Parametros  :
                   orfCursor        CURSOR con los datos encontrados

    Historia de Modificaciones
    Fecha       Autor               Modificacion
    =========   =========           ====================
    04-06-2013  MArteaga.SAO209275  Creacion.
    ***************************************************************/
    PROCEDURE GetOperatingUnitLov(orfCursor out constants.tyRefCursor)
    IS
        nuOperUnitId    or_operating_unit.operating_unit_id%type := GE_BOUTILITIES.FNUGETAPPLICATIONNULL;
        nuPersonId      ge_person.person_id%type := ge_bopersonal.fnuGetPersonId;
    BEGIN
        ut_trace.trace('Inicia OR_BCOperUnit_Admin.GetOperatingUnitLov',15);

        if (or_bcoperunitperson.fsbExistUniOperByPers(ge_bopersonal.fnuGetPersonId) IS null) then
            open orfCursor for
            SELECT  /*+ full(or_operating_unit) */
                    operating_unit_id id, name description
            FROM    or_operating_unit
            WHERE   /*+ Ubicacion: OR_BCOperUnit_Admin.GetOperatingUnitLov_1 SAO209275 */
                    operating_unit_id <> nuOperUnitId;
        else
            open orfCursor for
            SELECT  /*+ ordered
                        index(or_oper_unit_persons IDX_OR_OPER_UNIT_PERSONS_01)
                        index(or_operating_unit pk_or_operating_unit)
                    */
                    or_operating_unit.operating_unit_id id, or_operating_unit.name description
            FROM    or_oper_unit_persons, or_operating_unit
            WHERE   /*+ Ubicacion: OR_BCOperUnit_Admin.GetOperatingUnitLov_2 SAO209275 */
                    or_operating_unit.operating_unit_id =  or_oper_unit_persons.operating_unit_id
            AND     or_oper_unit_persons.person_id = nuPersonId;
        end if;

        ut_trace.trace('Finaliza OR_BCOperUnit_Admin.GetOperatingUnitLov',15);

    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            ut_trace.trace('Error : ex.CONTROLLED_ERROR',15);
            raise;

        when others THEN
            ut_trace.trace('Error : others',15);
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

END OR_BCOperUnit_Admin;
/
