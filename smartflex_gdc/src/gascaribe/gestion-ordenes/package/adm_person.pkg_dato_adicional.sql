create or replace package ADM_PERSON.PKG_DATO_ADICIONAL IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_DATO_ADICIONAL
    Descripcion     : Paquete para contener servicio realcioandos a la entidad SERVSUSC
    Autor           : Jorge Valiente
    Fecha           : 29-06-2023
  
    Parametros de Entrada
      isbProceso    nombre del proceso
      inuTotalRegi  total de registros a procesar
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/

  /**************************************************************************
  Propiedad Intelectual de PETI
  
  Funcion     :   FSBVALORDATOADICIONAL
  Descripcion :   Servicio para retornar valor del dato adicional de una orden y nombre de atributo
  Autor       :   Jorval
  OSF         :   1248
  
  Argumentos  :
  inuOrden    Codigo de la orden legalizada
  isbNameDA   Nombre del datos adicional
  inuGrupoDA  Codigo del grupo al que pertenece el dato adicional
  
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  **************************************************************************/
  FUNCTION FSBVALORDATOADICIONAL(inuOrden   IN or_order.order_id%type,
                                 isbNameDA  IN or_requ_data_value.name_1%type,
                                 inuGrupoDA IN or_requ_data_value.attribute_set_id%type)
    RETURN VARCHAR2;

END PKG_DATO_ADICIONAL;
/
create or replace package body ADM_PERSON.PKG_DATO_ADICIONAL IS

  /**************************************************************************
  Propiedad Intelectual de PETI
  
  Funcion     :   FSBVALORDATOADICIONAL
  Descripcion :   Servicio para retornar valor del dato adicional de una orden y nombre de atributo
  Autor       :   Jorval
  OSF         :   1248
  
  Argumentos  :
  inuOrden    Codigo de la orden legalizada
  isbNameDA   Nombre del datos adicional
  inuGrupoDA  Codigo del grupo al que pertenece el dato adicional
  
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  **************************************************************************/
  FUNCTION FSBVALORDATOADICIONAL(inuOrden   IN or_order.order_id%type,
                                 isbNameDA  IN or_requ_data_value.name_1%type,
                                 inuGrupoDA IN or_requ_data_value.attribute_set_id%type)
    RETURN VARCHAR2 IS
  
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : FSBVALORDATOADICIONAL
        Descripcion     : Servicio para obtener el valor del dato adcional legalizado en la orden
        Autor           : Jorge Valiente
        Fecha           : 15-07-2023
    
        Parametros de Entrada          
          inuOrden                Orden
          isbNameDA               Nombre del atributo
          inuGrupoDA              Codigo del grupo del atributo
        Parametros de Salida
    
    
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
  
    sbQuery              VARCHAR2(2000); --Obtiene el cadena SQL dinamica para recorrer los 20 Datos Adicionales
    cuCursorQuery        constants_per.tyrefcursor; --Tipo referencia Cursor 
    sbValorDatoAdicional open.or_requ_data_value.value_1%type; --Valor registrado del dato adicional
    sbValorCursor        VARCHAR2(2000); --Valor resultado del cursor dinamico
    onuErrorCodigo       NUMBER;
    osbErrorMensaje      VARCHAR2(2000);
  
  BEGIN
  
    PKG_ERROR.prInicializaError(onuErrorCodigo, osbErrorMensaje);
  
    sbValorDatoAdicional := null;
    --Recorrido de 20 datos adcionales de una orden legalizada
    for i in 1 .. 20 loop
      --cadena dinamica
      sbQuery := 'select d.value_' || i ||
                 ' from or_requ_data_value d where d.name_' || i || ' = ''' ||
                 isbNameDA || ''' and d.attribute_set_id=' || inuGrupoDA ||
                 ' and d.order_id = ' || inuOrden;
      open cuCursorQuery for sbQuery;
      LOOP
        FETCH cuCursorQuery
          INTO sbValorCursor;
        EXIT WHEN cuCursorQuery%NOTFOUND;
        if sbValorCursor is not NULL then
          sbValorDatoAdicional := sbValorCursor;
        end if;
      END LOOP;
      close cuCursorQuery;
    
      EXIT WHEN sbValorDatoAdicional is not null;
    
    end loop;
  
    return sbValorDatoAdicional;
  
  exception
    when others then
      Pkg_Error.seterror;
      Pkg_Error.getError(onuErrorCodigo, osbErrorMensaje);
      sbValorDatoAdicional := null;
      return sbValorDatoAdicional;
    
  END FSBVALORDATOADICIONAL;

END PKG_DATO_ADICIONAL;
/
begin
  pkg_utilidades.prAplicarPermisos('PKG_DATO_ADICIONAL', 'ADM_PERSON');
end;
/