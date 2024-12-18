create or replace PROCEDURE                   PERSONALIZACIONES.OAL_CERTIFICADO_DANO_PRODUCTO(inuOrden            IN NUMBER,
                                                                            inuCausal           IN NUMBER,
                                                                            inuPersona          IN NUMBER,
                                                                            idtFechIniEje       IN DATE,
                                                                            idtFechaFinEje      IN DATE,
                                                                            isbDatosAdic        IN VARCHAR2,
                                                                            isbActividades      IN VARCHAR2,
                                                                            isbItemsElementos   IN VARCHAR2,
                                                                            isbLecturaElementos IN VARCHAR2,
                                                                            isbComentariosOrden IN VARCHAR2) IS
  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : OAL_CERTIFICADO_DANO_PRODUCTO
      Descripcion     : Servicio para generar registro de da?o a prodcuto en caso de se legalizice la orden con
                        una certificacion detecta un defecto en CDM
      Autor           : Jorge Valiente
      Fecha           : 29-06-2023

      Parametros de Entrada
        inuOrden              numero de orden
        inuCausal             causal de legalizacion
        inuPersona            persona que legaliza
        idtFechIniEje         fecha de inicio de ejecucion
        idtFechaFinEje        fecha fin de ejecucion
        isbDatosAdic          datos adicionales
        isbActividades        actividad principal y de apoyo
        isbItemsElementos     items a legalizar
        isbLecturaElementos   lecturas
        isbComentariosOrden   comentario de la orden
      Parametros de Salida


      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso      Descripcion
      jsoto       03/10/2023  OSF-1672  Reemplazo api Api_Registrodanoproductoxml por el paq pkg_xml_soli_emerg
  ***************************************************************************/

  --Variables de ingreso
  inuContact_Id          NUMBER;
  inuCausal_Id           NUMBER;
  isbComment_            VARCHAR2(2000);
  inuTipo_De_Producto    NUMBER;
  inuNumero_Producto     NUMBER;
  inuNumero_Del_Servicio NUMBER;
  inuParser_Address_Id   NUMBER;

  --Variables de salida
  onuSolicitud    NUMBER;
  onuMotivo       NUMBER;
  onuErrorCodigo  NUMBER;
  osbErrorMensaje VARCHAR2(4000);

  --Parametros
  --Codigo del grupo que contiene los datos adicionales para identificar el defecto en centro de medicion en una certificacion.
  nuGDA_DEFECTO_EN_CDM_RP NUMBER := pkg_parametros.fnuGetValorNumerico('GRUPO_DATO_ADICIONAL_DEFECTO_EN_CDM_RP');
  --Nombre Dato Adicional defecto en centro de medicion en una certificacion.
  sbDA_DEFECTO_EN_CDM_RP VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('DATO_ADICIONAL_DEFECTO_EN_CDM_RP');
  --Nombre Dato Adicional que manejara la observacion del defecto en centro de medicion en una certificacion.
  sbDA_DEF_CDM_DESCRIPCION VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('DATO_ADICIONAL_OBSERVACION_DEFECTO_CDM');
  --Causal 292 Controlado Escape en centro de medicion Para establecer en el registro de da?o a producto.
  nuCAUSAL_CECM NUMBER := pkg_parametros.fnuGetValorNumerico('CAUSAL_CONTROLADO_ESCAPE_CENTRO_MEDICION');
  --Medio de recepcion establecer en el registro de da?o a producto.
  inuMedioRecepcion NUMBER := pkg_parametros.fnuGetValorNumerico('MEDIO_RECEPCION_DEFECTO_CDM');

  --Variables
  --Contener respuesta SI o NO
  sbValorDatoAdicional VARCHAR2(4000);
  --Contener observacion legalizacion del defecto en el dato adicional
  sbValorObservacion VARCHAR2(4000);

  --Cursor para obtener Identificador Del Cliente
  CURSOR cuIdentificadorCliente IS
    select suscripc.suscclie, pr_product.product_type_id, or_order_activity.PRODUCT_ID, or_order_activity.ADDRESS_ID, SERVICE_NUMBER
      from open.suscripc, open.or_order_activity, open.pr_product 
     where suscripc.susccodi = or_order_activity.subscription_id
       and or_order_activity.order_id = inuOrden
       and PR_PRODUCT.PRODUCT_ID = OR_ORDER_ACTIVITY.PRODUCT_ID;

  tblDatosAdicionales pkg_gestionordenes.tytblRegiDatoAdici;
  
  inuPuntoAtencion NUMBER;
  sbCadenaXML  CONSTANTS_PER.TIPO_XML_SOL%TYPE;

BEGIN

  UT_TRACE.TRACE('INICIO OAL_CERTIFICADO_DANO_PRODUCTO', 5);

  PKG_ERROR.prInicializaError(onuErrorCodigo, osbErrorMensaje);

  --Se crea tabla pl de datos adicionales para obtener la respuesta de si encontro o no defecto en la certificacion
  pkg_gestionordenes.prGetTblDatosAdic(IsbDatosAdic, tblDatosAdicionales);

  --se consulta valor de atributo
  sbValorDatoAdicional := pkg_gestionordenes.fsbGetValorAtributo(tblDatosAdicionales,
                                                                 sbDA_DEFECTO_EN_CDM_RP);

  --vALIDA SI LA RESPUESTA DE ENCONTRAR O NO DEFECTO EN LA CERTIFICACION
  IF UPPER(sbValorDatoAdicional) IN ('SI', 'S') THEN

    --Observacion del defecto critico encontrado
    sbValorObservacion := pkg_gestionordenes.fsbGetValorAtributo(tblDatosAdicionales,
                                                                 sbDA_DEF_CDM_DESCRIPCION);

    open cuIdentificadorCliente;
    fetch cuIdentificadorCliente
      into inuContact_Id,
           inuTipo_De_Producto,
           inuNumero_Producto,
           inuParser_Address_Id,
           inuNumero_Del_Servicio;
    close cuIdentificadorCliente;

    inuCausal_Id := nuCAUSAL_CECM;

    isbComment_ := substr(sbValorObservacion || ' - ' ||
                          isbComentariosOrden,
                          0,
                          1999);
                          
    inuPuntoAtencion := pkg_bopersonal.fnuGetPuntoAtencionId(inuPersona);

    --Servcio para crear registro de da?o a producto
    sbCadenaXML :=  pkg_xml_soli_emerg.getDanoProducto(inuContact_Id,
                                                       inuPuntoAtencion,
                                                       inuMedioRecepcion,
                                                       inuCausal_Id,
                                                       isbComment_,
                                                       inuTipo_De_Producto,
                                                       inuNumero_Producto,
                                                       inuNumero_Del_Servicio,
                                                       inuParser_Address_Id);
    
      /*Ejecuta el XML creado*/
  api_registerRequestByXml(sbCadenaXML,
                           onuSolicitud,
                           onuMotivo,
                           onuErrorCodigo,
                           osbErrorMensaje);

  END IF; --Fin de logica de validacion de la variable sbVALORDATOADICIONAL

  UT_TRACE.TRACE('FIN OAL_CERTIFICADO_DANO_PRODUCTO', 5);

EXCEPTION
  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    raise;
  WHEN others THEN
    Pkg_Error.seterror;
    Pkg_Error.getError(onuErrorCodigo, osbErrorMensaje);
    raise PKG_ERROR.CONTROLLED_ERROR;

END OAL_CERTIFICADO_DANO_PRODUCTO;
/
begin
  pkg_utilidades.prAplicarPermisos('OAL_CERTIFICADO_DANO_PRODUCTO', 'PERSONALIZACIONES');
end;
/