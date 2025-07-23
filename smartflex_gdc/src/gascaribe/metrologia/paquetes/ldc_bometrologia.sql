CREATE OR REPLACE PACKAGE LDC_BOmetrologia AS

    /**************************************************************************
    Propiedad intelectual de Gases de Occidente.

    Nombre del Paquete: LDC_BOmetrologia
    Descripcion : PACKAGE para manejo RNP 492 Mterologia.

    Autor       : Maria J. Mesa.
    Fecha       : 13 Marzo de 2013

    Historia de Modificaciones
      Fecha             Autor                Modificaci?n
    =========         =========          ====================
    02/07/2025        jpinedc           OSF-4555: * Se modifica prGenerarDatosNotificacion
                                        * Se modifica fsbGetAddressByQuotation
    18-08-2015        Llozada [ARA 6347] Se modifica el método <<fsbgetDivicEscaElement>>
    15-07-2015        Llozada [ARA 6347] Se modifican los métodos <<fsbGetIncertiEquivPresion>>,
                                         <<fsbGetIncerEquivPresion_AJ>>, <<fnugetDifMaxConver_Ajus>>,
                                         <<fsbgetIncertidumbreConver>>,<<fsbGetIncertiEquivPresion>>
    28-04-2015        Llozada [ARA 6869] Se crean los metodos:
                                         <<fnugetUBHisteresis>>,
                                         <<fsbgetSecuenciaExactitud>>,
                                         <<fsbGetTMax>>,
                                         <<fsbGetTMin>>,
                                         <<fsbGetHMax>>,
                                         <<fsbGetHMin>>,
                                         <<fsbGetDiferenciaAltura>>,
                                         <<fsbGetPosicion>>,
                                         <<fnugetTipoElementoPatron>>
    28-04-2015        Llozada [ARA 6869] Se modifican los metodos:
                                         <<fnugetUB_DeltaH_Sub1>>,
                                         <<fnugetUB_Repetibilidad>>,
                                         <<fnugetUB_DesvCero>>,
                                         <<prGenerarDatosNotificacion>>,
                                         <<fnugetDiferenciaMax>>,
                                         <<fnugetHisteresisMax>>
    17-02-2015        Llozada [ARA 6248] se modifica el método <<fsbCifrasDeci>>
    23-01-2015        Llozada [NC 3976] se modifica el método <<temperatura>>
    18-10-2014        Llozada NC 2328   se modifica el método <<fnugetPorErroMax>>
    13-03-2013         MMesa            Creaci?n.

   **************************************************************************/

   nuFlagPersonaQueRevisa       number(2) := 0;
   sbPersonaQueRevisaIENCO      varchar2(2000) := null;
   sbFlagNotical                varchar2(1) := null;
   sbFlagIenco                  varchar(1) := null;


    -- Obtiene la Version actual del Paquete
    FUNCTION FSBVERSION RETURN VARCHAR2;
    --------------------------------------------------------------------------
    --Tabla PL para el manejo de valores de Repetibilidad.
    --------------------------------------------------------------------------


    --------------------------------------------------------------------------
    -- Metodos publicos del PACKAGE
    --------------------------------------------------------------------------
    /* Devuelve el valor de la incertidumbre en Dos cifras Significativas */
    FUNCTION fsbCifrasSignif(inuNumero number)
    return varchar2;

    /* Devuelve un numero con decimales, que tiene la catidad que tenga el valor de incertidumbre */
    FUNCTION fsbCifrasDeci(isbValor varchar2, inuNumero NUMBER)
    return varchar2;

    /* Funcion que retorna la incertidumbre con 2 Cifras significativas
     para aplicar el numero de decimales a los campos DIFERENCIA_MAX y DIFERENCIA_MAX_AJUSTE */
    FUNCTION fsbGetIncertCifrasSig(inuOrderId or_order.order_id%type)
    return varchar2;

    /* Funcion que retorna la incertidumbre Equivalente con 2 Cifras significativas
     para aplicar el numero de decimales a los campos DIFERENCIA_CONVER y DIFERENCIA_CONVER_AJ */
    FUNCTION fsbGetIncertEquivCifrasSig
    (
        inuOrderId  in  OR_order.order_id%type
    )
    RETURN varchar2;

    -- Devuelve el Factor de Convercion configurado en EQUILAB
    FUNCTION fnuGetFactorConversion(inuOrderId  OR_order.order_id%type)
    return LDC_EQUILAB_.factor_conversion%type;

     --Obtiene el nombre de la Unidad de medida configurada en EQUILAB
    FUNCTION fsbGetNombreUnidad(inuOrderId  OR_order.order_id%type)
    return LDC_EQUILAB_.nombre_unidad%type;

    -- Devuelve la unidad de Equivalencia
    FUNCTION fsbGetUnidadEquiv(inuOrderId    OR_order.order_id%type)
    RETURN LDC_EQUILAB_.unidad_equivalente%type;

    --Obtiene el nombre de la Unidad de Equivalencia configurada en EQUILAB
    FUNCTION fsbGetNombreUnidadEquiv(inuOrderId    OR_order.order_id%type)
    return LDC_EQUILAB_.nom_uni_equi%type;

    /*Devuelve el Item Seriado dada la orden*/
    FUNCTION fnugetItemSeriadOrden
     (
       inuOrderId       in      OR_order.order_id%type
     )
    return OR_order_activity.serial_items_id%type;

     procedure getVacecodiVacevaat
     (
       isbValAttri       in      ldc_varicert.vacedesc%type,
       onuVacecodi       out     ldc_varicert.vacecodi%type,
       osbVaceVaat       out     ldc_varicert.vacevaat%type
     );

       /*Obtiene el Tipo de Laboratorio que se realizo*/
    FUNCTION fnugetTipoLab
    (
      inuOrderId        in      OR_order.order_id%type
    ) return varchar2;

     FUNCTION fnugetIdPlanilla
    (
       inuOrderId       in      OR_order.order_id%type
    ) return number;

    PROCEDURE  validaFechaFin
   (
    idtFechafin        in        date
   );

       /*Valida que la fecha Fin sea mayor o igual a la fecha de inicio*/
  PROCEDURE  validaFechaInicio
   (
    idtFechaInicio        in        date
   );

     FUNCTION fnugetIdentifVariAttrib
     (
       inuVaricert       in      ldc_varicert.vacedesc%type ,
       inuPlanTemp       in      ldc_variattr.vaatcodi%type
     )  return ldc_varicert.vacecodi%type ;

    /*DEvuelve el valor de una variable dada la orden y la variable */
    FUNCTION fsbgetValueVariable
     (
       inuOrderId        in     OR_order.order_id%type ,
       inuVariableId     in     ge_variable.variable_id%type
     )
    return VARCHAR2  ;

    FUNCTION fsbgetValorProfundidad
     (
       inuOrderId       in       OR_order.order_id%type
     )return number;

     function    fsbgetDirQuienSolicita
    (
     inuOrderId         in      OR_order.order_id%type
   )return VARCHAR2  ;


    /**Obtiene el valor de un atributo dado la ordern y el id del atributo***/
    FUNCTION fsbgetValorAtributo
     (
       inuOrderId       in     OR_order.order_id%type,
       inuAttribute_id  in     ge_entity_attributes.entity_attribute_id %type
     )
    return VARCHAR2;

     /*Devuelve el nombre del laboratorio*/
    FUNCTION fsbgetNombreLaboratorio
     (
       inuOrderId       in     OR_order.order_id%type
     )
    return VARCHAR2;

    /*Devuelve LA MARCA del Elemento*/
    FUNCTION fsbgetMarcaElemento
     (
       inuOrderId       in     OR_order.order_id%type
     )
    return VARCHAR2;

    /*Devuelve el VALOR MEDIO del Elemento*/
    FUNCTION fsbgetValorMedio
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return number;

    /*Devuelve el MODELO del Elemento*/
    FUNCTION fsbgetModeloElemento
     (
       inuOrderId       in      OR_order.order_id%type
     )
    return VARCHAR2;

    /*Devuelve la descripci?n del RANGO MEDICI?N del Elemento */
    FUNCTION fsbgetRangMedicElemento
     (
       inuOrderId       in      OR_order.order_id%type
     )
    return VARCHAR2 ;

    /*Devuelve el DIVISI?N ESCALA del Elemento */
    FUNCTION fsbgetDivicEscaElement
    (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2 ;

    /*Devuelve la EXACTITUD del Elemento */
    FUNCTION fsbgetExactitudElement
    (
       inuOrderId       in      OR_order.order_id%type
     )
    return VARCHAR2 ;

    FUNCTION fnugetExactitudPatron
    (
    inuOrderId              in          OR_order.order_id%type
    )
    return  number;

    /* Validaci?n de la exactitud calculada respecto a los intervalos*/
    FUNCTION fnugetExactitudIntervalo
    (
    inuOrderId              in          OR_order.order_id%type
    )return number;

     /*Devuelve la Norma configurada para el ?tem*/
    FUNCTION getNorma(inuOrder_id in or_order.order_id%type)
    return varchar2;

    /*Devuelve la persona que revisa */
    FUNCTION fsbgetPersonaQRevisa
    (
       inuOrderId       in      OR_order.order_id%type
     )
    return VARCHAR2 ;

    /* Devuelve  el tipo de Elemento 1 si es Analogo y 0 si es Digital*/
    FUNCTION fnugetTipoElemento
    (
      inuOrderId        in      OR_order.order_id%type
    )
    return number  ;

    /*Retorna el Id_items_Seriado del equipo Patron*/
    FUNCTION fnugetElemntoPatron
    (
      inuOrderId        in     OR_order.order_id%type
    ) return ge_items_seriado.id_items_seriado%type  ;

   /* FUNCI?N QUE devuelve el valor de un atributo dado el item_seriado y el IdAtributo*/
    FUNCTION fsbgetValAttribute
    (
      inuItemSeriado           in        ge_items_seriado.id_items_seriado%type,
      inuAttributeId           in        ge_entity_attributes.entity_attribute_id%type

    ) return ge_items_tipo_at_val.valor%type;

    /*Retorna el valor de UB_Exactitud */
    FUNCTION fnugetUB_Exactitud
    (
    inuOrderId          in      OR_order.order_id%type
    ) return  number;

    /*Devuelve la descripci?n del MEDIO utilizado para la calibraci?n del Elemento   */
    FUNCTION fsbgetDescrMedio
     (
       inuOrderId      in      OR_order.order_id%type
     )return VARCHAR2;

      FUNCTION fsbgetPreCiclo
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2;

    --  Obtiene el valor de Condicion del Instrumento
     FUNCTION fsbgetCondInstru
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2;

   /*Obtiene le Tipo de Cliente para imprimir el Certificado Correpondiente
   I : Interno , E : externo , C : Contratista*/
   FUNCTION fsbTipoClienteCertif
  (
    inuOrderId         in      OR_order.order_id%type
   )return varchar2;

    /*Retorna el valor de UB_Repetibilidad */
    FUNCTION fnugetUB_Repetibilidad
    (
      inuOrderId       in      OR_order.order_id%type
    ) return number;


   /*Retorna el valor de UB_Resolucion */
    FUNCTION fnugetUB_Resolucion
    (
      inuOrderId        in     OR_order.order_id%type
    ) return  number;

    /*DEVUELVE el DELTA de alturas  (Subn Item Vs Patron)*/
    FUNCTION fnugetDeltaSubVsPatron
    (
      inuOrderId        in     OR_order.order_id%type,
      inuVariable1      in     ge_variable.variable_id%type
    )return  number;

     /*    Obtener el mayor valor absoluto entre los Errores de subida, Errores de bajada
   */
    FUNCTION fnugetHisteresisMax
    (
      inuOrderId         in        OR_order.order_id%type
    )return  number;

    /*DEVUELVE el DELTA de alturas  (Subn Item Vs Patron).. Preguntar si solo  SUB1 ???
     que pasa con las SUB 2 EN QUE CASO APLICA LA SUB2*/
    FUNCTION fnugetUB_DeltaH_Sub1
    (
      inuOrderId        in      OR_order.order_id%type
    )return  number;

    /* FALTA DEFINIR DE DONDE SALE ESTE VALOR  , QUE ES C2 Y QUE ES X1???
        UB (Desv.Cero)=  Max (X2,0 - X 1,0) / 2 3
    */
    FUNCTION fnugetUB_DesvCero
    (
      inuOrderId        in       OR_order.order_id%type
    )return  number;

    /*Obtiene la diferencia Maxima entre error de Bajada y error de subida*/
    FUNCTION fnugetDiferenciaMax
    (
      inuOrderId        in       OR_order.order_id%type
    )return  number;

    /*Devuelve TRUE si el elemento pasa la certificaci?n*/
    FUNCTION fblCertificaElemento
    (
      inuOrderId        in       OR_order.order_id%type
    )
    return boolean ;
    /**/
    PROCEDURE valCertificaElemento;

    /*CREA Orden de Ajuste*/
    PROCEDURE sendOrderAjuste  ;

    /** funci?n que obtiene la unidad operativa de quien solicita*/
    FUNCTION  fsbgetQuienSolicita
    (
      inuOrderId        in      OR_order.order_id%type
    )
    return varchar2;

    function    fsbgetDirCompany
    (
     inuOrderId         in      OR_order.order_id%type
   )
   return varchar2;

   /*OBTIENE la fecha de recepci?n del elemento cuando llega a el laboratori*/
   FUNCTION fdtgetFechaRecepcion
   (
     inuOrderId         in      OR_order.order_id%type
   )return varchar2  ;

   /*OBTIENE la persona que calibra*/
   FUNCTION fsbGetCalibradoPor
   (
    inuOrderId          in      OR_order.order_id%type
   ) return varchar2    ;

   /*Obtiene el numero interno del elemento */
   FUNCTION fnugetNumeroElemento
   (
    inuOrderId          in      OR_order.order_id%type
   ) return varchar2 ;

   /*OBTIENE el codigo del Elemento*/
   FUNCTION fnugetCodigoElemento
   (
    inuOrderId          in      OR_order.order_id%type
   ) return varchar2 ;

   /*Calcula la incertidumbre*/
    FUNCTION fnugetUexp_Incertidumbre
    (
      inuOrderId        in      OR_order.order_id%type
     )return  number;

   /*Obtiene le Rango de un Elemeneto dado el Item Seriado y la Orden */
    FUNCTION fsbgetDescRangodelElemento
    (
      inuOrderId        in      OR_order.order_id%type,
      inuItemSeriado    in      ge_items_seriado.id_items_seriado%type
    )  return varchar2  ;

   /*OBTIENE la diferencia del  rango de Medici?n (n?mero) dado el Item Seriado y la Orden */
    FUNCTION fnugetRangoMedicion
    (
      inuOrderId        in      OR_order.order_id%type ,
      inuItemSeriado    in      ge_items_seriado.id_items_seriado%type
    ) return number   ;

    /*Obtiene las observaci?n de la planilla */
    FUNCTION fnugetObservacion
    (
      inuOrderId        in      OR_order.order_id%type
    )return varchar2;

    /*OBTIENE el porcentaje de Errror Maximo*/
    FUNCTION fnugetPorErroMax
    (
      inuOrderId         in      OR_order.order_id%type
    )return number;

    /* Devuelve la unidad de medida de Elemento */
    FUNCTION fsbgetUnidadMedida
    (
      inuOrderId       in       OR_order.order_id%type
    ) return varchar2;

    /*Devuelve la fecha de Calibraci?n */
    FUNCTION fsbgetFechaCalibrac
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2;

     /*
      Obtiene el promedio de concentraci?n de Gas del patron,
      es necesario para determinar la incertidumbre */
    FUNCTION fnugetPromePatronConc
    (
      inuOrderId         in        OR_order.order_id%type
    )return  number;

       /*
      Obtiene el promedio de concentraci?n de Gas del Equipo que se calibro,
       es necesario para determinar  la incertidumbre */
    FUNCTION fnugetPromeConcentr
    (
      inuOrderId         in        OR_order.order_id%type
    )return  number;


       /*
      Obtiene el promedio del error de cada uno de los puntos tomados en Concentraci?n
        es necesario para determinar  la incertidumbre */
    FUNCTION fnugetPromeErrorConc
    (
      inuOrderId         in        OR_order.order_id%type
    )return  number;

    /*Obtiene Orden dado el numero del Certificado del equipo*/
    FUNCTION getOrderByNumCert
    (
       isbNumCert   or_order_act_var_det.value%type
    )return number ;

    /* Valida si es una orden de ajuste  */
     FUNCTION valCertAjuste
    (
       inuOrderId   in   OR_order.order_id%type
    )return number;

    FUNCTION fnugetUB_ResolucionPatron
    (
      inuOrderId            in       OR_order.order_id%type
    )return number;

        /*
       Obtiene la orden anterior que requiere ajuste*/
    FUNCTION getFrecuencia
    (
        nuOrderId            in           or_order.order_id%type
    ) return number;

    procedure temperatura (inuOrderId OR_order.order_id%type);

     FUNCTION fnugetIdCertificado
    (
      inuOrderId        in      OR_order.order_id%type
    ) return number;

    FUNCTION frfgetOrdenesMante
    RETURN constants.tyRefCursor;

    PROCEDURE processOrdenesMant (inuOrderId     IN or_order.order_id%type,
                              inuRegistro   IN  number,
                              inuTotal      IN  number,
                              onuErrorCode  OUT number,
                              osbErrorMess  OUT varchar2);
    function  convertirDecimal
   (
    sbNumber        in        varchar2
   )
   return number;

   /*Valida si el equipo es Bimetalico o Electrico*/
    FUNCTION tipoItemTemperatura(inuorderId OR_order.order_id%type)
    return varchar2;

       /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  fsbObtValorParametro
    Descripcion :
    Autor       : llozada
    Fecha       : 11-11-2013

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    11-11-2013          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fnuObtValorParametro(isbparamecodi in ld_parameter.parameter_id%type)
    RETURN number;


    FUNCTION fsbGetIncertiEquivPresion(
        inuOrderId             in         OR_order.order_id%type
    )return varchar2;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  getIdPlantilla
    Descripcion : Se le envia la Orden para saber que plantilla es la que tiene asignada la orden
    Autor       : llozada
    Fecha       : 12-02-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    12-02-2014          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION getIdPlantilla(nuOrderId OR_order.order_id%type)
    return varchar2;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  generaInformeNoConformes
    Descripcion : Levanta la forma de Equipo No Conforme mediante la Forma IENCO
    Autor       : llozada
    Fecha       : 13-02-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    13-02-2014          llozada              Creaci?n.
  **************************************************************************/
    PROCEDURE generaInformeNoConformes;

    /*Capacidad para los certificados de Orificios*/
    FUNCTION fsbgetCapacidad(inuOrder_id OR_order.order_id%type)
    return varchar2;

    FUNCTION fsbGetCargoPersona(inuOrder_id or_order.order_id%type)
    return varchar2;

    FUNCTION getFechaNoConformes
    return date;

    FUNCTION fnugetDifMaxConversion(inuOrderId         in        OR_order.order_id%type)
    return number;

    FUNCTION fsbgetIncertidumbreConver(inuOrderId         in        OR_order.order_id%type)
    return varchar2;

    FUNCTION fnugetHisteresisConver(inuOrderId         in        OR_order.order_id%type)
    return number;

    FUNCTION fnugetDifMaxAjuste(inuOrderId         in        OR_order.order_id%type)
    return number;

    FUNCTION fnugetDifMaxConver_Ajus(inuOrderId         in        OR_order.order_id%type)
    return number;

    FUNCTION fnugetPorErrorMaxAjus(inuOrderId       in      OR_order.order_id%type)
   return number;

   FUNCTION fnugetExactitudInterAjus (inuOrderId              in          OR_order.order_id%type)
    return number;

    FUNCTION fnugetIncertidumbre_AJ
    (
      inuOrderId             in         OR_order.order_id%type
     )return  number;

     FUNCTION fsbGetIncerEquivPresion_AJ(
        inuOrderId             in         OR_order.order_id%type
    )return varchar2;

    PROCEDURE prGenerarDatosNotificacion
    (
        inuOrder_id     OR_order.order_id%type
    );

    FUNCTION fsbGetPrecargas(inuOrderId    OR_order.order_id%type)
    return varchar2;

    procedure prPlantillaXSL(inuOrderId    OR_order.order_id%type);

    /* Devuelve la unidad de medida del Patron */
    FUNCTION fsbgetUnidadMedidaPatron
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2;

     /*Obtiene el ID de la unidad operativa quien solicita*/
   function    fnugetIDQuienSolicita
    (
     inuOrderId         in      OR_order.order_id%type
   )return number;

   function fsbGetIncertidumbreSig(order_id or_order.order_id%type)
    return varchar2;

    function fsbGetIncertidumbreConverSig(order_id or_order.order_id%type)
    return varchar2;

    function fnuGetEquivalenciaTemp(inuNum    number)
    return number;

    function fnuGetEquivCorrecion(inupatron number, inuInstru number)
    return number;

    FUNCTION fsbGetIncertidumbreConcNomi(inuOrderId in OR_order.order_id%type)
    return varchar2;

    FUNCTION fsbgetIncertidumbreConcNomi_AJ(inuOrderId  in OR_order.order_id%type)
    return  varchar2;

        /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  generaInformeNoConformes
    Descripcion : Actualiza la propiedad del item seriado
    Autor       : llozada
    Fecha       : 05-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    05-08-2014          llozada              Creaci?n.
    **************************************************************************/
    PROCEDURE actualizaPropiedadCliente (inumotiveid mo_motive.motive_id%type);

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fnuGetPromedioPlancha
    Descripcion : Devuelve el promedio de los puntos de calibración de una plancha termofusión
    Autor       : llozada
    Fecha       : 14-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    14-08-2014          llozada              Creaci?n.
    **************************************************************************/
    FUNCTION fnuGetPromedioPlancha(inuOrderId or_order.order_id%type)
    return number;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fsbGetCargoCalibradoPor
    Descripcion : Devuelve el cargo de la persona que calibra el equipo
    Autor       : llozada
    Fecha       : 15-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    15-08-2014          llozada              Creaci?n.
    **************************************************************************/
   FUNCTION fsbGetCargoCalibradoPor
   (
    inuOrderId          in      OR_order.order_id%type
   ) return varchar2;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fsbGetTemperaturaCA
    Descripcion : Devuelve las condiciones ambientales para la temperatura
    Autor       : llozada
    Fecha       : 14-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    14-08-2014          llozada              Creaci?n.
    **************************************************************************/
    FUNCTION fsbGetTemperaturaCA(inuOrderId or_order.order_id%type)
    return varchar2;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fsbGetHumedadCA
    Descripcion : Devuelve las condiciones ambientales para la humedad
    Autor       : llozada
    Fecha       : 14-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    14-08-2014          llozada              Creaci?n.
    **************************************************************************/
    FUNCTION fsbGetHumedadCA(inuOrderId or_order.order_id%type)
    return varchar2;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fsbGetNormaByItem
    Descripcion : Devuelve la norma de acuerdo al ítem
    Autor       : llozada
    Fecha       : 27-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    27-08-2014          llozada              Creaci?n.
    **************************************************************************/
    function fsbGetNormaByItem(inuIdCotizacion    cc_quotation.quotation_id%type)
    return varchar2;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fsbGetAddressByQuotation
    Descripcion : Devuelve la dirección del laboratorio o de la empresa.
    Autor       : llozada
    Fecha       : 27-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    27-08-2014          llozada              Creaci?n.
    **************************************************************************/
    function fsbGetAddressByQuotation(inuIdCotizacion    cc_quotation.quotation_id%type)
    return varchar2;

        /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbgetSecuenciaExactitud
    Descripcion : Devuelve el valor para la secuencia dependiendo de la exactitud
                  del instrumento, así:

                  Secuencia A : Exactitud Instrumento < 0,1

                  Secuencia B : 0,1 < Exactitud Instrumento < 0,6

                  Secuencia C : Exactitud Instrumento > 0,6

    Autor       : llozada
    Fecha       : 14-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    14-04-2015          llozada              Creaci?n.
  **************************************************************************/
  FUNCTION fsbgetSecuenciaExactitud(inuOrder_id or_order.order_id%type)
  RETURN VARCHAR2;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetTMax
    Descripcion : Devuelve el valor para el atributo TMAX

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetTMax(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2;

        /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetTMin
    Descripcion : Devuelve el valor para el atributo TMIN

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetTMin(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2;

        /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetHMax
    Descripcion : Devuelve el valor para el atributo HMAX

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetHMax(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2;

        /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetHMin
    Descripcion : Devuelve el valor para el atributo HMIN

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetHMin(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2;

        /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetDiferenciaAltura
    Descripcion : Devuelve el valor para el atributo HMIN

    Autor       : llozada
    Fecha       : 23-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    23-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetDiferenciaAltura(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2;

        /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetPosicion
    Descripcion : Devuelve el valor para el atributo TMAX

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetPosicion(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2;

        /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fnugetUBHisteresis
    Descripcion : Devuelve el valor para histeresis en el calculo de la incertidumbre

    Autor       : llozada
    Fecha       : 16-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    16-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fnugetUBHisteresis
    (
      inuOrderId             in         OR_order.order_id%type
     )
     RETURN  NUMBER;
 END LDC_BOmetrologia;
/

CREATE OR REPLACE PACKAGE BODY LDC_BOmetrologia AS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    -- Declaracion de variables y tipos globales privados del paquete

    ---------------------------------------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    ---------------------------------------------------------------------------
    CSBVERSION                        CONSTANT   varchar2(40)  := 'OSF-4555';
    csbWORK_INSTANCE                  CONSTANT   varchar2(20)  := 'WORK_INSTANCE';
    csbSeqLDC_CERTMETR                CONSTANT   varchar2(100) := 'SEQ_LDC_CERTMETR';
    csbK                              CONSTANT   varchar2(100) := 'CONSTANTE_K'  ;  -- Constante de Veff*
    csbEquiFrecuencia                 CONSTANT   varchar2(100) := 'EQUIVALENCIA_FRECUENCIA_ITEM'  ;
    csbEQUI_EQUIPOS_TEMPERA           CONSTANT   varchar2(100) := 'EQUI_EQUIPOS_TEMPERATURA'  ;
    csbEquiNorma                      CONSTANT   varchar2(100) := 'LDC_EQUI_NORMA_MET'  ;

    cnu0                              CONSTANT   number := 0   ;  -- Constante 0
    cnu3                              CONSTANT   number := 3   ;  -- Constante 3
    cnu2                              CONSTANT   number := 2   ;  -- Constante 2
    cnu100                            CONSTANT   number := 100 ;  -- Constante 100
    cnug                              CONSTANT   number := dald_parameter.fnuGetNumeric_Value('GRAVEDAD_METROLOGIA'); --9.78;  -- Gravedad --> g = 9,78 m/s?  [*PARAMETRO
    cnuTaskTypeLab                    CONSTANT   number := 209; --  209 --> ASEGURAMIENTO METROLOGICO
    cnuConversionPA                   CONSTANT   number := dald_parameter.fnuGetNumeric_Value('CONVERSION_PA_MET'); -- 0.00015; --Conversión a Pascal  [*PARAMETRO
    cnuConversionINH2                 CONSTANT   number := dald_parameter.fnuGetNumeric_Value('CONVERSION_INH2_MET'); -- 0.00401 --Conversión a Pascal  [*PARAMETRO
    cnuConstante2                     CONSTANT   number := -2;
    cnuConstante3                     CONSTANT   number := 20;
    cnuConstante4                     CONSTANT   number := 273.15;
    cnuK1                             CONSTANT   number := 0.34844;
    cnuK2                             CONSTANT   number := -0.00252;
    cnuK3                             CONSTANT   number := 0.020582;

    cnuVariNumCert                    CONSTANT   ge_variable.variable_id%type := 2;

    cnuStatusOrderAnten               CONSTANT   or_order_status.order_status_id%type := 8; -- Orden Cerrada

    csbPresion                        CONSTANT   LDC_PLANTEMP.pltelabo%TYPE := 'PRESION';
    csbPlanchas                       CONSTANT   LDC_PLANTEMP.pltelabo%TYPE := 'PLANCHAS';
    csbAjuste                         CONSTANT   LDC_PLANTEMP.pltelabo%type := 'AJUSTE';
    csbConcentracion                  CONSTANT   LDC_PLANTEMP.pltelabo%TYPE := 'CONCENTRACION';
    csbOrificios                      CONSTANT   LDC_PLANTEMP.pltelabo%TYPE := 'ORIFICIOS';
    csbTemperatura                    CONSTANT   LDC_PLANTEMP.pltelabo%TYPE := 'TEMPERATURA';

    csbVarLaboratorio                 CONSTANT   ldc_varicert.vacedesc%type := 'LABORATORIO';          -- Laboratorio que se realiz?, Presi?n , Temp, Planc, Orifi, Concentraci?n
    csbVarPersonRevisa                CONSTANT   ldc_varicert.vacedesc%type := 'PERSONA_REVISA' ;      -- Persona que Revisa , Responsable del Laboratorio
    cnuVaceTempInstru                 CONSTANT   ldc_varicert.vacedesc%type := 'TEMPERATURA_INSTRUM';  -- Temperatura Instrumento ** Planchas
    csbDescrMedio                     CONSTANT   ldc_varicert.vacedesc%type := 'MEDIO';                -- Medio de Calibraci?n
    csbObservacion                    CONSTANT   ldc_varicert.vacedesc%type := 'OBSERVACION';          -- Atributo OBSERVACION del Instrumento
    csbMarca                          CONSTANT   ldc_varicert.vacedesc%type := 'FABRICANTE';           -- Atributo MARCA del Instrumento
    csbModelo                         CONSTANT   ldc_varicert.vacedesc%type := 'MODELO';               -- Atributo MODELO del Instrumento
    csbVarDifAltura                   CONSTANT   ldc_varicert.vacedesc%type := 'DIFERENCIA_DE_ALTURA';
    csbRangoMediDesc                  CONSTANT   ldc_varicert.vacedesc%type := 'DESC_RANGO_MEDICION';  -- Atributo RANGO DE MEDICI?N -> Descripci?n del Instrumento
    csbDivisionEscal                  CONSTANT   ldc_varicert.vacedesc%type := 'DIVISION_ESCALA';      -- Atributo DIVISI?N ESCA -LA del Instrumento
    csbExactitud                      CONSTANT   ldc_varicert.vacedesc%type := 'EXACTITUD';            -- Atributo EXACTITUD del Instrumento
    csbResolucion                     CONSTANT   ldc_varicert.vacedesc%type := 'RESOLUCION';           -- Atributo RESOLUCI?N del Instrumento
    csbRangInic                       CONSTANT   ldc_varicert.vacedesc%type := 'RANGO_INICIAL';              -- Atributo MAX_VALOR - DIFERENCIA -> R_inicial y el R_final del Instrumento
    csbRangFinal                      CONSTANT   ldc_varicert.vacedesc%type := 'RANGO_FINAL';
    csbTipoElemento                   CONSTANT   ldc_varicert.vacedesc%type := 'TIPO_ELEMENTO';        -- Tipo de Elemento.
    csbCodigoElement                  CONSTANT   ldc_varicert.vacedesc%type := 'CODIGO_INTERNO';       -- C?digo del Elemento Interno.
    csbNumeroCertifi                  CONSTANT   ldc_varicert.vacedesc%type := 'NUMERO_CERT';          -- N?mero de Certificado.
    csbInforme                        CONSTANT   ldc_varicert.vacedesc%type := 'INFORME';
    csbUnidadMedida                   CONSTANT   ldc_varicert.vacedesc%type := 'UNIDAD_MEDIDA';        -- Unidad de Medida del Elemento
    csbFechaCalibrac                  CONSTANT   ldc_varicert.vacedesc%type := 'FECHA_CALIRACION' ;    -- Fecha Calibracion
    csbBaja_1                         CONSTANT   ldc_varicert.vacedesc%type := 'BAJADA_1' ;            -- Bajada_1
    csbBaja_2                         CONSTANT   ldc_varicert.vacedesc%type := 'BAJADA_2' ;            -- Bajada_2
    csbSubi_1                         CONSTANT   ldc_varicert.vacedesc%type := 'SUBIDA_1' ;            --  Subida_1
    csbSubi_2                         CONSTANT   ldc_varicert.vacedesc%type := 'SUBIDA_2' ;            --  Subida_2
    csbConcEquipo                     CONSTANT   ldc_varicert.vacedesc%type := 'CONC_EQUIPO';
    csbUbPatron                       CONSTANT   ldc_varicert.vacedesc%type := 'INCERTIDUMBRE_PATRON';
    csbTempNom1                       CONSTANT   ldc_varicert.vacedesc%type := 'NOMINAL_1';
    csbTempNom2                       CONSTANT   ldc_varicert.vacedesc%type := 'NOMINAL_2';
    csbTempNom3                       CONSTANT   ldc_varicert.vacedesc%type := 'NOMINAL_3';
    csbSubNom1                        CONSTANT   ldc_varicert.vacedesc%type := 'SUB_NOM_1';
    csbSubNom2                        CONSTANT   ldc_varicert.vacedesc%type := 'SUB_NOM_2';
    csbSubNom3                        CONSTANT   ldc_varicert.vacedesc%type := 'SUB_NOM_3';
    csbSubNom4                        CONSTANT   ldc_varicert.vacedesc%type := 'SUB_NOM_4';
    csbSubNom5                        CONSTANT   ldc_varicert.vacedesc%type := 'SUB_NOM_5';
    csbBajNom1                        CONSTANT   ldc_varicert.vacedesc%type := 'BAJ_NOM_1';
    csbBajNom2                        CONSTANT   ldc_varicert.vacedesc%type := 'BAJ_NOM_2';
    csbBajNom3                        CONSTANT   ldc_varicert.vacedesc%type := 'BAJ_NOM_3';
    csbBajNom4                        CONSTANT   ldc_varicert.vacedesc%type := 'BAJ_NOM_4';
    csbBajNom5                        CONSTANT   ldc_varicert.vacedesc%type := 'BAJ_NOM_5';
    csbInsNom1                        CONSTANT   ldc_varicert.vacedesc%type := 'INST_NOM_1';
    csbInsNom2                        CONSTANT   ldc_varicert.vacedesc%type := 'INST_NOM_2';
    csbInsNom3                        CONSTANT   ldc_varicert.vacedesc%type := 'INST_NOM_3';
    csbInsNom4                        CONSTANT   ldc_varicert.vacedesc%type := 'INST_NOM_4';
    csbInsNom5                        CONSTANT   ldc_varicert.vacedesc%type := 'INST_NOM_5';
    csbDeriva                         CONSTANT   ldc_varicert.vacedesc%type := 'DERIVA';
    csbEstabi                         CONSTANT   ldc_varicert.vacedesc%type := 'ESTABILIDAD';
    csbHomoRadial                     CONSTANT   ldc_varicert.vacedesc%type := 'HOMOGENEIDAD_RADIAL';
    csbHomoAxial                      CONSTANT   ldc_varicert.vacedesc%type := 'HOMOGENEIDAD_AXIAL';
    csbNumeroCargas                   CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PRECARGAS_MET';
    csbINCERTIDUMBRE_PATRON_MEDIO     CONSTANT   ldc_varicert.vacedesc%type := 'INCERTIDUMBRE_PATRON_MEDIO';
    csbINCERTIDUMBRE_GAS_PATRON       CONSTANT   ldc_varicert.vacedesc%type := 'INCERTIDUMBRE_GAS_PATRON';
    --
    csbINCERTIDUMBRE_GAS_PATRON_2     CONSTANT   ldc_varicert.vacedesc%type := 'INCERTIDUMBRE_GAS_PATRON_2';
    --
    csbSubConcentracion               CONSTANT   ldc_varicert.vacedesc%type := 'SUBCONCENTRACION';
    csbPATRON_ORIFICIO                CONSTANT   ldc_varicert.vacedesc%type := 'PATRON_ORIFICIO';
    csbProfunidadInmersion            CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PROFUNDIDAD_INMERSION';
    csbTemplateCalibracion            CONSTANT   ldc_varicert.vacedesc%type := 'LDC_TEMPLATE_CALIBRACION';
    csbPlantillaExternoINH2O          CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAEXTERNAINH2O';
    csbPlantillaInternoINH2O          CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAINTERNOINH2O';
    csbPlantillaExternoAjINH2O        CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAEXTERNAAJINH2O';
    csbPlantillaInternoAjINH2O        CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAINTERNAAJINH2O';
    csbPlantillaExternoF              CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAEXTERNAF';
    csbPlantillaInternoF              CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAINTERNOIF';
    csbPlantillaExternoAjF            CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAEXTERNAAJF';
    csbPlantillaInternoAjF            CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAINTERNAAJF';
    csbPreCiclo                       CONSTANT   ldc_varicert.vacedesc%type := 'PRECICLO';
    -- Aranda 3397
    csbCondInstrumento                CONSTANT   ldc_varicert.vacedesc%type := 'CONDICION_DEL_INSTRUMENTO';
    --
    csbConcentracionNom1              CONSTANT   ldc_varicert.vacedesc%type := 'LDC_CONCENTRACION_NOMINAL_1';
    csbConcentracionNom2              CONSTANT   ldc_varicert.vacedesc%type := 'LDC_CONCENTRACION_NOMINAL_2';
    csbItemIdMultigas                 CONSTANT   ldc_varicert.vacedesc%type := 'LDC_ITEM_ID_MULTIGAS';
    csbPlantillaMultigas              CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLA_MULTIGAS';
    csbPlantillaNoConformes           CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLA_NO_CONFORMES';
    csbIntervalos                     CONSTANT   ld_parameter.value_chain%type := 'INTERVALOS_EXACTITUD';
    csbCodRelaAjuste                  CONSTANT   ld_parameter.value_chain%type := 'LDC_AJUSTE_METROLOGIA';
    csbReporteNumero                  CONSTANT   ld_parameter.value_chain%type := 'LDC_REPORTE_NUMERO';

    csbItemPesoMuerto                 CONSTANT   ld_parameter.value_chain%type := 'ITEM_PESO_MUERTO_MET';
    csbP_Certif                       CONSTANT   ld_parameter.value_chain%type := 'P_CERTIF_MET';
    csbAlfa                           CONSTANT   ld_parameter.value_chain%type := 'ALFA_MET';
    csbIncerTempMax                   CONSTANT   ld_parameter.value_chain%type := 'INCER_TEMP_MAX_MET';
    csbTempSistema                    CONSTANT   ld_parameter.value_chain%type := 'TEMP_SISTEMA_MET';
    csbIncerCoefTerm                  CONSTANT   ld_parameter.value_chain%type := 'INCER_COEF_TERM_MET';
    csbIncertGravedad                 CONSTANT   ld_parameter.value_chain%type := 'INCERTIDUMBRE_GRAVEDAD_MET';
    csbCoefMecanico                   CONSTANT   ld_parameter.value_chain%type := 'COEF_MECANICO_MET';
    csbPAtm                           CONSTANT   ld_parameter.value_chain%type := 'PRESION_ATM_MET';
    csbHR                             CONSTANT   ld_parameter.value_chain%type := 'HUMEDAD_RELATIVA_MET';
    csbTempAmbiente                   CONSTANT   ld_parameter.value_chain%type := 'TEMP_AMBIENTE_MET';
    csbIncertidumbreAire              CONSTANT   ld_parameter.value_chain%type := 'INCERT_AIRE_MET';
    csbIncertidumbreAceite            CONSTANT   ld_parameter.value_chain%type := 'INCERT_ACEITE_MET';
    csbIncertidumbreCalibracion       CONSTANT   ld_parameter.value_chain%type := 'INCERT_CALIBRACION_MET';
    csbNominalPlancha                 CONSTANT   ld_parameter.value_chain%type := 'TIPO_PLANCHA_MET';
    csbSocket                         CONSTANT   ld_parameter.value_chain%type := 'PLANCHA_SOCKET_MET';
    csbTope                           CONSTANT   ld_parameter.value_chain%type := 'PLANCHA_TOPE_MET';
    csbRangoSocket                    CONSTANT   ld_parameter.value_chain%type := 'RANGO_SOCKET_MET';
    csbRangoTope                      CONSTANT   ld_parameter.value_chain%type := 'RANGO_TOPE_MET';
    csbPuntosPlancha                  CONSTANT   ld_parameter.value_chain%type := 'PUNTOS_PLANCHA_MET';
    csbTemperaturaCAPlanchas          CONSTANT   ld_parameter.value_chain%type := 'CA_PLANCHAS_TEMPERATURA_MET';
    csbHumedadCAPlanchas              CONSTANT   ld_parameter.value_chain%type := 'CA_PLANCHAS_HUMEDAD_MET';
    csbTemperaturaCAPresion           CONSTANT   ld_parameter.value_chain%type := 'CA_PRESION_TEMPERATURA_MET';
    csbHumedadCAPresion               CONSTANT   ld_parameter.value_chain%type := 'CA_PRESION_HUMEDAD_MET';
    csbTemperaturaCATemp              CONSTANT   ld_parameter.value_chain%type := 'CA_TEMP_TEMPERATURA_MET';
    csbHumedadCATemp                  CONSTANT   ld_parameter.value_chain%type := 'CA_TEMP_HUMEDAD_MET';
    csbTemperaturaCACGas              CONSTANT   ld_parameter.value_chain%type := 'CA_CONCEN_TEMPERATURA_MET';
    csbHumedadCACGas                  CONSTANT   ld_parameter.value_chain%type := 'CA_CONCEN_HUMEDAD_MET';
    csbTemperaturaCAOri               CONSTANT   ld_parameter.value_chain%type := 'CA_ORIF_TEMPERATURA_MET';
    csbHumedadCAOri                   CONSTANT   ld_parameter.value_chain%type := 'CA_ORIF_HUMEDAD_MET';

    csbLaboratorio                    CONSTANT   ld_parameter.value_chain%type := 'UNIDAD_TRABAJO_LAB';
    csbServicioTecExt                 CONSTANT   ld_parameter.value_chain%type := 'SERVICIO_TECNICO_EXT_MET';
    csbMasOMenos                      CONSTANT   ld_parameter.value_chain%type := 'MASOMENOS_MET';

    sbNombreEntrega                   CONSTANT   varchar2(100) := 'OSS_LUL_RQ_40';
    sbNombreEntrega526                CONSTANT   varchar2(100) := 'OSS_LUL_RQ_526';
    sbNombreEntrega534                CONSTANT   varchar2(100) := 'OSS_LUL_RQ_534';
    sbNombreEntrega2328               CONSTANT   varchar2(100) := 'OSS_LUL_NC_2328';

    /*14-04-2015 Llozada [ARA 6869]*/
    sbNuevasFormulas                  CONSTANT   varchar2(100) := 'OSS_MET_LUL_145871';
    csbMaxDeriva                      CONSTANT   ld_parameter.value_chain%type := 'MAX_DERIVA_MET';
    csbFluctuacionPatron              CONSTANT   ld_parameter.value_chain%type := 'FLUCTUACION_PATRON_MET';
    csbFluctuacionInstrumento         CONSTANT   ld_parameter.value_chain%type := 'FLUCTUACION_INSTRUMENTO_MET';
    csbTMax                           CONSTANT   ld_parameter.value_chain%type := 'TMAX_MET';
    csbTMin                           CONSTANT   ld_parameter.value_chain%type := 'TMIN_MET';
    csbHMax                           CONSTANT   ld_parameter.value_chain%type := 'HMAX_MET';
    csbHMin                           CONSTANT   ld_parameter.value_chain%type := 'HMIN_MET';
    csbPosicion                       CONSTANT   ld_parameter.value_chain%type := 'POSICION_MET';
    csbTipoElementoPatron             CONSTANT   ld_parameter.value_chain%type := 'TIPO_ELEMENTO_PATRON_MET';
    csbElementoAnalogo                CONSTANT   ld_parameter.value_chain%type := 'ANALOGO_MET';

    nuIncertidumbreGas2               number;

    /*
      Funci?n que devuelve la versi?n del pkg*/
    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
      return CSBVERSION;
    END FSBVERSION;


    /* Devuelve el valor de la incertidumbre en Dos cifras Significativas */
    FUNCTION fsbCifrasSignif(inuNumero NUMBER)
    return  varchar2 IS

        nuCifras    NUMBER(2)       :=0;
        sbCadena    VARCHAR2(100);
        sbFormato   VARCHAR2(20)    := 'FM';
        nuDecimales NUMBER(2)       := 0;
        nuFinal     NUMBER          := 0;
        sbFinal     VARCHAR2(20);
        sbString    VARCHAR2(20)    := '1';

    BEGIN

        if inuNumero is null then
            return null;
        end if;

        IF (inuNumero < 0) THEN
            sbCadena := to_char(inuNumero * (-1));
        ELSE
            sbCadena := to_char(inuNumero);
        END IF;

        IF (to_number(sbCadena) >= 10 OR to_number(sbCadena) = 0) THEN
            RETURN to_char(ROUND(inuNumero));
        END IF;

        FOR i IN 1..LENGTH(sbCadena) LOOP

            IF (SUBSTR(sbCadena,i,1) = '0' AND nuCifras > 0) THEN
                nuCifras := nuCifras + 1;
            ELSIF (SUBSTR(sbCadena,i,1) != '0' AND SUBSTR(sbCadena,i,1) != '.' AND SUBSTR(sbCadena,i,1) != ',') THEN
                nuCifras := nuCifras + 1;
            END IF;

            IF (nuCifras = 2) THEN
                nuDecimales := i - INSTR(sbCadena,'.',1);
            EXIT;
            END IF;

        END LOOP;

        IF (nuCifras = 2) THEN
            nuFinal := ROUND(inuNumero, nuDecimales);
        ELSE
             nuFinal := inuNumero;
        END IF;

        nuCifras := 0;

        IF (nuFinal < 0) THEN
            sbFinal := to_char(nuFinal * (-1));
        ELSE
            sbFinal := to_char(nuFinal);
        END IF;

        IF (to_number(sbFinal) >= 10 OR to_number(sbFinal) = 0) THEN
            RETURN to_char(ROUND(nuFinal));
        END IF;

        FOR i IN 1..LENGTH(sbFinal) LOOP

            IF (SUBSTR(sbFinal,i,1) != ',' AND SUBSTR(sbFinal,i,1) != '.') THEN
                sbFormato := sbFormato || '9';
            ELSE
                IF (i = 1) THEN
                    sbFormato := sbFormato || '0D';
                ELSE
                    sbFormato := sbFormato || 'D';
                END IF;
            END IF;

            IF (SUBSTR(sbFinal,i,1) = '0' AND nuCifras > 0) THEN
                nuCifras := nuCifras + 1;
            ELSIF (SUBSTR(sbFinal,i,1) != '0' AND (SUBSTR(sbFinal,i,1) != '.' AND SUBSTR(sbFinal,i,1) != ',')) THEN
                nuCifras := nuCifras + 1;
            END IF;

            IF (nuCifras = 2) THEN
                EXIT;
            END IF;

        END LOOP;

        IF (nuCifras = 1) THEN
            IF (LENGTH(sbFinal) = 1) THEN
                sbFormato := sbFormato || 'D0';
            ELSE
                sbFormato := sbFormato || '0';
            END IF;
        END IF;

        --RETURN REPLACE(to_char(nuFinal,sbFormato),'.',',');
        RETURN to_char(nuFinal,sbFormato);

    END fsbCifrasSignif;



    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fsbCifrasDeci
    Descripcion :Devuelve un numero con decimales, que tiene la catidad que tenga el valor de incertidumbre
    Autor       : Oscar Parra
    Fecha       : 27-05-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    17-02-2015          Llozada [ARA 6248] Se trunca el valor que ingresa a 7 decimales
    27-05-2014          Oscar Parra        Creaci?n.
    18-09-2014          llozada            Se aumenta el rango para el redondeo entre 0.95 y -0.95
    **************************************************************************/
    FUNCTION fsbCifrasDeci(isbValor varchar2, inuNumero number)
    return varchar2
    IS
        nuNumero    number;
        posicion1   NUMBER(2):=0;
        posicion2   NUMBER(2):=0;
        decimales1  NUMBER(2):=0;
        decimales2  NUMBER(2):=0;
        variabl     VARCHAR2(30);
        sbFormato   VARCHAR2(30):='FM';
        nuTrNumero number;

    BEGIN
        /*17-02-2015 Llozada [ARA 6248]: Se trunca a 7 decimales para evitar que oracle genere una excepción*/
        nuTrNumero := trunc(inuNumero,7);

        --18-09-2014 : llozada
        if mod(nuTrNumero,1) >= 0.95 or mod(nuTrNumero,1) <= -0.95 then
            nuNumero := round(nuTrNumero);
            variabl := to_char(nuNumero);
        else
            variabl := to_char(nuTrNumero);
        end if;

        --Convierte el n?mero en isbValor de caracteres
        --variabl := to_char(inuNumero);

        --Obtiene la posicion del punto que indica el inicio de las cifras decimales
        posicion1 := INSTR(variabl,'.',1);

        if (posicion1 = 0) then
            variabl := variabl||'.0';
        end if;

        posicion1 := INSTR(variabl,'.',1);

        --Obtiene el n?mero de decimales que tiene el n?mero
        decimales1 := LENGTH(variabl) - posicion1;

        --Obtiene la posici?n del punto que indica el inicio de las cifras decimales de la incertidumbre
        --posicion2 := INSTR(isbValor,',',1);
        posicion2 := INSTR(isbValor,'.',1);
        --Obtiene el n?mero de decimales que tiene el n?mero
        decimales2 := LENGTH(isbValor) - posicion2;

        if (posicion2 = 0) then
            return to_char(round(nuTrNumero));
        end if;

        if (posicion1 = 0) then

            for i in 1..LENGTH(variabl) loop
                sbFormato := sbFormato||'0';
            end loop;

            sbFormato := sbFormato||'D';

            for j in 1..decimales2 loop
                sbFormato := sbFormato||'0';
            end loop;

            return to_char(nuTrNumero,sbFormato);
        end if;

        if (nuTrNumero < 1 and nuTrNumero > -1) then
            sbFormato := sbFormato||'0D';

            for i in 1..decimales2 loop
                sbFormato := sbFormato||'0';
            end loop;

        else
            if (nuTrNumero < 0) then
                for i in 1..(posicion1-2) loop
                    sbFormato := sbFormato||'9';
                end loop;
            else
                for i in 1..(posicion1-1) loop
                    sbFormato := sbFormato||'9';
                end loop;
                sbFormato := sbFormato||'9';
            end if;

            sbFormato := sbFormato||'D';

            for i in 1..decimales2 loop
                sbFormato := sbFormato||'0';
            end loop;

        end if;

        if (decimales1 > decimales2) then
            return to_char(round(nuTrNumero,decimales2),sbFormato);
        else
            return to_char(nuTrNumero,sbFormato);
        end if;

        EXCEPTION
            when others then
                return '';

    END fsbCifrasDeci;


     --Obtiene el valor del factor de conversion configurado en EQUILAB
    FUNCTION fnuGetFactorConversion(inuOrderId    OR_order.order_id%type)
    return LDC_EQUILAB_.factor_conversion%type
    IS
        cursor cuFactor(sbLab       LDC_EQUILAB_.laboratorio%type,
                        sbUnidad_   LDC_EQUILAB_.unidad%type)
        is
            select FACTOR_CONVERSION
            from LDC_EQUILAB_
            where laboratorio = sbLab
            and trim(REGEXP_REPLACE(upper(unidad), '  *', ' ')) = sbUnidad_
            and activo = 'Y';

        nuFactor       LDC_EQUILAB_.factor_conversion%type := 0;
        sbLaboratorio  LDC_EQUILAB_.laboratorio%type;
        sbUnidad       LDC_EQUILAB_.unidad%type;
        sbLab          LDC_EQUILAB_.laboratorio%type := null;

    BEGIN

        sbLaboratorio := ldc_bometrologia.fnugetTipoLab (inuOrderId); --ldc_bometrologia.FSBGETNOMBRELABORATORIO(inuOrderId);
        sbUnidad      := trim(REGEXP_REPLACE(upper(ldc_bometrologia.fsbgetUnidadMedida(inuOrderId)), '  *', ' '));
         --upper(ldc_bometrologia.fsbgetUnidadMedida(inuOrderId));

        if sbLaboratorio like csbPresion||'%' THEN
            sbLab := csbPresion;
        elsif sbLaboratorio like csbTemperatura||'%' then
            sbLab := csbTemperatura;
        end if;

        if sbLab is not null then
            open cuFactor(sbLab, sbUnidad);
            fetch cuFactor into nuFactor;
            close cuFactor;

            if nuFactor is null then
                ge_boerrors.seterrorcodeargument (2741,'Debe configurar la equivalencia de unidades en el'||
                                                        ' Maestro Detalle EQUILAB ['||sbLab||' - '||sbUnidad||']');
            end if;
        end if;

        return nuFactor;

    END fnuGetFactorConversion;

     --Obtiene el nombre de la Unidad de medida configurada en EQUILAB
    FUNCTION fsbGetNombreUnidad
    (
        inuOrderId    OR_order.order_id%type
    )
    return LDC_EQUILAB_.nombre_unidad%type
    IS
        cursor cuName(sbLab       LDC_EQUILAB_.laboratorio%type,
                      sbUnidad_   LDC_EQUILAB_.unidad%type)
        is
            select nombre_unidad
            from LDC_EQUILAB_
            where laboratorio = sbLab
            and trim(REGEXP_REPLACE(upper(unidad), '  *', ' ')) = sbUnidad_
            and activo = 'Y';

        sbNameUnidad    LDC_EQUILAB_.nombre_unidad%type := null;
        sbLaboratorio   LDC_EQUILAB_.laboratorio%type;
        sbUnidad        LDC_EQUILAB_.unidad%type;
        sbLab           LDC_EQUILAB_.laboratorio%type := null;

    BEGIN

        sbLaboratorio := ldc_bometrologia.fnugetTipoLab (inuOrderId); --ldc_bometrologia.FSBGETNOMBRELABORATORIO(inuOrderId);
        sbUnidad      := trim(REGEXP_REPLACE(upper(ldc_bometrologia.fsbgetUnidadMedida(inuOrderId)), '  *', ' '));

        if sbLaboratorio like csbPresion||'%' THEN
            sbLab := csbPresion;
        elsif sbLaboratorio like csbTemperatura||'%' then
            sbLab := csbTemperatura;
        end if;

        if sbLab is not null then
            open cuName(sbLab, sbUnidad);
            fetch cuName into sbNameUnidad;
            close cuName;

            if sbNameUnidad is null then
                ge_boerrors.seterrorcodeargument (2741,'Debe configurar la equivalencia de unidades en el'||
                                                        ' Maestro Detalle EQUILAB ['||sbLab||' - '||sbUnidad||']');
            end if;
        end if;

        return sbNameUnidad;

    END fsbGetNombreUnidad;


    -- Devuelve la unidad de Equivalencia
    FUNCTION fsbGetUnidadEquiv(inuOrderId    OR_order.order_id%type)
    RETURN LDC_EQUILAB_.unidad_equivalente%type
    IS
        cursor cuUnid(sbLab       LDC_EQUILAB_.laboratorio%type,
                      sbUnidad_   LDC_EQUILAB_.unidad%type)
        is
            select UNIDAD_EQUIVALENTE
            from LDC_EQUILAB_
            where laboratorio = sbLab
            and trim(REGEXP_REPLACE(upper(unidad), '  *', ' ')) = sbUnidad_
            and activo = 'Y';

        sbUnidadEquiv   LDC_EQUILAB_.unidad_equivalente%type := null;
        sbLaboratorio   LDC_EQUILAB_.laboratorio%type;
        sbUnidad        LDC_EQUILAB_.unidad%type;
        sbLab          LDC_EQUILAB_.laboratorio%type := null;

    BEGIN

        sbLaboratorio := ldc_bometrologia.fnugetTipoLab (inuOrderId); --ldc_bometrologia.FSBGETNOMBRELABORATORIO(inuOrderId);
        sbUnidad      := trim(REGEXP_REPLACE(upper(ldc_bometrologia.fsbgetUnidadMedida(inuOrderId)), '  *', ' '));

        if sbLaboratorio like csbPresion||'%' THEN
            sbLab := csbPresion;
        elsif sbLaboratorio like csbTemperatura||'%' then
            sbLab := csbTemperatura;
        end if;

        if sbLab is not null then
            open cuUnid(sbLab, sbUnidad);
            fetch cuUnid into sbUnidadEquiv;
            close cuUnid;

            if sbUnidadEquiv is null then
                ge_boerrors.seterrorcodeargument (2741,'Debe configurar la equivalencia de unidades en el'||
                                                        ' Maestro Detalle EQUILAB ['||sbLab||' - '||sbUnidad||']');
            end if;
        end if;

        return sbUnidadEquiv;

    END fsbGetUnidadEquiv;

    --Obtiene el nombre de la Unidad de Equivalencia configurada en EQUILAB
    FUNCTION fsbGetNombreUnidadEquiv
    (
        inuOrderId    OR_order.order_id%type
    )
    return LDC_EQUILAB_.nom_uni_equi%type
    IS
        cursor cuName(sbLab       LDC_EQUILAB_.laboratorio%type,
                      sbUnidad_   LDC_EQUILAB_.unidad%type)
        is
            select nom_uni_equi
            from LDC_EQUILAB_
            where laboratorio = sbLab
            and trim(REGEXP_REPLACE(upper(unidad), '  *', ' ')) = sbUnidad_
            and activo = 'Y';

        sbNameUndEquiv  LDC_EQUILAB_.nombre_unidad%type := null;
        sbLaboratorio   LDC_EQUILAB_.laboratorio%type;
        sbUnidad        LDC_EQUILAB_.unidad%type;
        sbLab          LDC_EQUILAB_.laboratorio%type := null;

    BEGIN

        sbLaboratorio := ldc_bometrologia.fnugetTipoLab (inuOrderId); --ldc_bometrologia.FSBGETNOMBRELABORATORIO(inuOrderId);
        sbUnidad      := trim(REGEXP_REPLACE(upper(ldc_bometrologia.fsbgetUnidadMedida(inuOrderId)), '  *', ' '));

        if sbLaboratorio like csbPresion||'%' THEN
            sbLab := csbPresion;
        elsif sbLaboratorio like csbTemperatura||'%' then
            sbLab := csbTemperatura;
        end if;

        if sbLab is not null then
            open cuName(sbLab, sbUnidad);
            fetch cuName into sbNameUndEquiv;
            close cuName;

            if sbNameUndEquiv is null then
                ge_boerrors.seterrorcodeargument (2741,'Debe configurar la equivalencia de unidades en el'||
                                                        ' Maestro Detalle EQUILAB ['||sbLab||' - '||sbUnidad||']');
            end if;
        end if;

        return sbNameUndEquiv;

    END fsbGetNombreUnidadEquiv;

    --


    /* Devuelve siguiente valor de la secuencia SEQ_LDC_CERTMETR */
    FUNCTION fnunextLDC_CERTMETR
    RETURN NUMBER
    IS
      NUNEXT NUMBER;
      NUFOUND NUMBER;
    BEGIN
      LOOP
         NUNEXT := SEQ.GETNEXT( csbSeqLDC_CERTMETR );
         SELECT COUNT(1)
         INTO NUFOUND
         FROM LDC_CERTMETR
         WHERE CEMECODI = NUNEXT;
         EXIT WHEN NUFOUND = 0;
      END LOOP;
      RETURN NUNEXT;
    END fnunextLDC_CERTMETR;

    /*Devuelve el Item Seriado dada la orden*/
    FUNCTION fnugetItemSeriadOrden
     (
       inuOrderId       in      OR_order.order_id%type
     )
    return OR_order_activity.serial_items_id%type

    IS

      nuItemSeriado     ge_items_seriado.id_items_seriado%type;
      -- Almacena el item seriado Asociado dada la orden
      CURSOR cuItemSeriado (inuOrderId in number) IS
        SELECT act.serial_items_id FROM OR_order_activity act
        WHERE ORDER_id = inuOrderId
        AND rownum = 1;

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fnugetItemSeriadOrden',8);

      for item in cuItemSeriado(inuOrderId) loop
        nuItemSeriado := item.serial_items_id;
        --.trace ('Item Seriado asociado a la Orden ['||item.serial_items_id||']',8) ;
      end loop;

      return nuItemSeriado;

      --.trace ('Finaliza LDC_BOmetrologia.fnugetItemSeriadOrden',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when NO_DATA_FOUND then
      pkErrors.pop;
       return '-';
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);


    END fnugetItemSeriadOrden;


    /* */
    procedure getVacecodiVacevaat
     (
       isbValAttri       in      ldc_varicert.vacedesc%type,
       onuVacecodi       out     ldc_varicert.vacecodi%type,
       osbVaceVaat       out     ldc_varicert.vacevaat%type
     )

    IS
      nuIdVariAttr  ldc_varicert.vacecodi%type;
      --
      CURSOR cuLdc_varicert(isbValAttrib ldc_varicert.vacedesc%type)
      IS
        SELECT vc.vacecodi,vc.vacevaat
        FROM ldc_varicert vc
         WHERE vc.vacedesc=isbValAttrib
         AND rownum = 1;

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
      nuErrorAttribu                      number := 0;

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.getVacecodiVacevaat',8);

      for v in cuLdc_varicert(isbValAttri) loop
        nuErrorAttribu := 1;
        onuVacecodi := v.vacecodi;
        osbVaceVaat := v.vacevaat;
        --.trace ('Retorna  ['||v.vacecodi||']  ['||osbVaceVaat||']',8) ;
      end loop;

                  /*Error Personalizado*/
      if nuErrorAttribu = 0 then
        ge_boerrors.seterrorcodeargument (2741,'No se ha configurado la Variable o Atributo '||upper(isbValAttri)||' '
                                ||', en el Maestro Detalle VACELAB - ALMACENA LAS VARIABLES UTILIZADAS PARA LOS CERTIFICADOS. ') ;
      end if;
      --.trace ('Finaliza LDC_BOmetrologia.getVacecodiVacevaat',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when NO_DATA_FOUND then
      pkErrors.pop;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END getVacecodiVacevaat;

     /*
      OBTIENE el id de ORDER_ACTIVITY asociado a la orden*/
   FUNCTION getIdOrderActivity
   (
     inuOrderId       in      OR_order.order_id%type
   )
   return number
   is
     nuExistOrder         number := 0;
     nuIdOrderActivity    OR_order_activity.order_activity_id%type;

     -- CURSOR
      CURSOR cuOrderActivity(inuOrderId in OR_order.order_id%type ) IS
        select ORDER_activity_id  FROM OR_order_activity
        where ORDER_id  = inuOrderId
        AND ORDER_activity_id IS not null;

   BEGIN
     for exac in cuOrderActivity(inuOrderId) loop
       nuExistOrder :=1;
       nuIdOrderActivity := exac.ORDER_activity_id;
     END loop;

     return  nuIdOrderActivity;

   END getIdOrderActivity;

  /*
     Obtiene el Id de la Unidad Operativa quien Solicita*/

    function    fsbgetOperUnitQSolicita
    (
     inuOrderId         in      OR_order.order_id%type
   )
   return number
   IS

     nuItemSeriado              ge_items_seriado.id_items_seriado%type;
     nuOrderActivity            OR_order_activity.order_activity_id%type;
     nuOperUnitId               OR_order_activity.operating_unit_id%type;
     dtFechaRegOrd              OR_order.created_date%type;
     onuQuienSolici             varchar2(200) := -1;
     nuExistMov                 number:=0;  -- no existen movimientos de inventario para ese item
     nuSolicitud                number:=0;

     --  Variables para manejo de Errores
     exCallService               EXCEPTION;
     sbCallService               varchar2(2000);
     sbErrorMessage              varchar2(2000);
     nuErrorCode                 number;

     -- Causa de movimiento de inventario Transito
     inuCausaMovimiento ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('LDC_MET_CAUSA_MOV_INV');

     -- CURSOR que obtiene la unidad operativa que solicita
     CURSOR cuMovInventa(inuItemSeriado     in      ge_items_seriado.id_items_seriado%type,
                            idtFechaRegOrd  in      OR_order.created_date%type) IS
       /*select oper.operating_unit_id  ID_QUIENSOLIC
       FROM OR_uni_item_bala_mov mov, or_operating_unit oper
       where oper.operating_unit_id = mov.operating_unit_id
       AND oper.oper_unit_classif_id <> 18 -- Que sea diferente a una unidad de laboratorio
       AND mov.id_items_seriado =  inuItemSeriado
       AND trunc(mov.move_date) <= trunc(idtFechaRegOrd);*/

       select oper.operating_unit_id  ID_QUIENSOLIC
       FROM open.OR_uni_item_bala_mov mov, open.or_operating_unit oper
       where mov.id_items_seriado = inuItemSeriado
       and item_moveme_caus_id = inuCausaMovimiento
       --and oper.oper_unit_classif_id <> 18 -- Que sea diferente a una unidad de laboratorio
       and mov.target_oper_unit_id = (select operating_unit_id
                                    from open.or_operating_unit a
                                    where mov.target_oper_unit_id = a.operating_unit_id
                                    and a.oper_unit_classif_id = 18)
       and oper.operating_unit_id = mov.operating_unit_id
       order by mov.move_date asc;

       cursor cuClienteExterno(inuOrder_id number) IS
       select package_id
       from or_order_activity
       where order_id = inuOrder_id;

   BEGIN

     open cuClienteExterno(inuOrderId);
     fetch cuClienteExterno into nuSolicitud;
     close cuClienteExterno;

     if  nuSolicitud is not null then
         return dage_subscriber.fsbgetsubscriber_name(
                ldc_boutilities.fsbgetvalorcampotabla('MO_PACKAGES','PACKAGE_ID','SUBSCRIBER_ID',nuSolicitud))
                ||' '||dage_subscriber.fsbgetsubs_last_name (
                ldc_boutilities.fsbgetvalorcampotabla('MO_PACKAGES','PACKAGE_ID','SUBSCRIBER_ID',nuSolicitud));
     else
         --.trace('Inicia LDC_BOmetrologia.getQuienSolicita',9);
         nuItemSeriado  := fnugetItemSeriadOrden(inuOrderId);
         --.trace('Item Seriado [' ||nuItemSeriado||']',9) ;
         nuOrderActivity:= getIdOrderActivity(inuOrderId);
         --.trace('Order_Activity_id [' ||nuOrderActivity||']',9) ;
         nuOperUnitId   := daor_order_activity.fnugetoperating_unit_id(nuOrderActivity);
         --.trace('Oper_unit_id dada la orden [' ||nuOperUnitId||']',9) ;
         dtFechaRegOrd  := daor_order.fdtgetcreated_date(inuOrderId);
         --.trace('Fecha de creaci?n de la Orden [' ||dtFechaRegOrd||']',9) ;

         for exac in cuMovInventa(nuItemSeriado,dtFechaRegOrd) loop
           nuExistMov:=1;
           onuQuienSolici := exac.ID_QUIENSOLIC;
         END loop;

         if nuExistMov <> 1 then
            ge_boerrors.seterrorcodeargument(2741,'No hay movimientos de inventario para el Item Seriado: '||nuItemSeriado
                                                  ||'. No se encuentra traslado de una unidad operativa a LABORATORIO. '
                                                  ||'Verifique los traslados del equipo.' );
         end if;

         --.trace('return ['||onuQuienSolici||']',9);
        return onuQuienSolici;
     end if;
     --.trace('finaliza LDC_BOmetrologia.getQuienSolicita',9);

   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

   END fsbgetOperUnitQSolicita;


   /*Obtiene le Tipo de Cliente para imprimir el Certificado Correpondiente
      I : Interno , E : externo , C : Contratista*/
   FUNCTION fsbTipoClienteCertif
  (
    inuOrderId       in      OR_order.order_id%type
   )return varchar2
   IS
      nuPackageId                      OR_order_activity.package_id%type;
      nuOrderActivity                  or_order_activity.order_activity_id%type;
      nuOperUnit                        or_operating_unit.operating_unit_id%type;
      sbes_externa                     or_operating_unit.es_externa%type;
       --  Variables para manejo de Errores
      exCallService                    EXCEPTION;
      sbCallService                    varchar2(2000);
      nuErrorCode                      number;
      sbErrorMessage                   varchar2(2000);
   BEGIN
     --.trace('Inicia LDC_BOmetrologia.fsbTipoClienteCertif');

       -- Obtiene el identificador de OR_orde_activity dada la orden
       nuOrderActivity:= getIdOrderActivity(inuOrderId);
       --.trace('fsbTipoClienteCertif Order_Activity_id [' ||nuOrderActivity||']',9) ;
       -- Obtiene el PACKAGE_id asociado a la orden
       nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivity);
       --.trace('fsbTipoClienteCertif Package_id [' ||nuPackageId||']',9) ;
       -- Si la orden no fue generada desde un tr?mite
       if nuPackageId IS null then
        /*En caso de que la orden no tenga asociado un pkg_id se
           verifica que la unidad operativa que solicita la calibraci?n*/
           -- Obtiene el Id de la unidad operativa que Solicita
           nuOperUnit := fsbgetOperUnitQSolicita(inuOrderId);

           if ( nuOperUnit = -1 ) then
             sbes_externa := 'N';
           else
             -- Obtiene si la unidad operativa es Externa o Interna
             sbes_externa := daor_operating_unit.fsbgetes_externa( nuOperUnit);
           end if;


           -- Si la unidad operativa es un Contratista  (Externa)
           /*Los contratistas aunque no quema solicitud se les debe imprimir un certificado Externo*/
           if sbes_externa = 'Y'then
             return 'E' ;
           else
             return 'I' ; -- Cliente  interno
           END if;
       ELSE
       --.trace('fsbTipoClienteCertif retorna EEEEE [:(]',9) ;
         return 'E' ;
       END if ;

    --.trace('Finaliza LDC_BOmetrologia.fsbTipoClienteCertif');

   EXCEPTION
     when others  then
       return 'I'; -- Cliente Interno
       raise;
   END fsbTipoClienteCertif;

   /*
     Obtiene el Id de la Variable o del atributo seg?n corresponda */
    FUNCTION fnugetIdentifVariAttrib
     (
       inuVaricert       in      ldc_varicert.vacedesc%type ,
       inuPlanTemp       in      ldc_variattr.vaatcodi%type
     )  return ldc_varicert.vacecodi%type
    IS
      nuIdVariAttr  ldc_varicert.vacecodi%type;
      sbVacedesc    varchar2(2000);
      sbPlanilla    varchar2(2000);

      -- Almacena el item seriado Asociado dada la orden
      CURSOR cuLdc_variattr (inuVaricert ldc_variattr.vaatvace%type,     -- ldc_plantemp
                             inuPlanTemp ldc_variattr.vaatcodi%type) IS
        SELECT va.vaatvaat FROM ldc_variattr va
         WHERE va.vaatvace = inuVaricert
         AND vaatplte = inuPlanTemp
         AND rownum = 1;

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
      nuErrorAttribu                      number := 0;

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fnugetIdentifVariAttrib',8);

      select vacedesc into sbVacedesc
      from ldc_varicert
      where vacecodi = inuVaricert;

      for v in cuLdc_variattr(inuVaricert,inuPlanTemp) loop
        nuErrorAttribu := 1;
        nuIdVariAttr := v.vaatvaat;
        --.trace ('Identificador de la Variable o de Atributo ['||v.vaatvaat||']',8) ;
      end loop;

       /*Error Personalizado*/
      if nuErrorAttribu = 0 then
        sbPlanilla := OPEN.LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA ('GE_VARIABLE_TEMPLATE',
                        'VARIABLE_TEMPLATE_ID','DESCRIPTION',inuPlanTemp);

        ge_boerrors.seterrorcodeargument (2741,'No se ha configurado la Homologaci?n de la Variable o Atributo '||upper(sbVacedesc)
                                ||', en el Maestro Detalle CEVAPLA - ALMACENA LAS VARIABLES O ATRIBUTOS POR PLANILLA, '
                                ||'para la PLANTILLA '||inuPlanTemp||' - '||upper(sbPlanilla)||'. ') ;
      end if;

      return nuIdVariAttr;

      --.trace ('Finaliza LDC_BOmetrologia.fnugetIdentifVariAttrib',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when NO_DATA_FOUND then
      pkErrors.pop;
       return '-';
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);
    END fnugetIdentifVariAttrib;


    /*
      Obtiene la planilla Utiliza para despu?s seleccionar el Certificado correspondiente*/
    FUNCTION fnugetIdPlanilla
    (
      inuOrderId       in      OR_order.order_id%type
    ) return number
    IS

      nuItemId     ge_items.items_id%type;
      nuItemSe     ge_items_seriado.id_items_seriado%type;
      nuIdPlanilla ge_lab_template.variable_template_id%type;  -- ge_variable_template
      nuTipoCl     ldc_plantemp.pltetipo%type;
      nuActivity   or_order_activity.activity_id%type;
      --  Variables para manejo de Errores
      nuNoDatFou                          number := 0;
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);

      CURSOR cuPlanilla (inuItemId in ge_items.items_id%type, inuActivity or_order_activity.activity_id%type) is
        SELECT gl.variable_template_id
          FROM ge_items_gama_item gi, ge_lab_template  gl
          WHERE gl.activity_id = inuActivity
          and gl.items_id = inuItemId
          and gi.items_id = gl.items_id;
          --AND rownum = 1 ;
     BEGIN
       --.trace('Inicia ldc_bometrologia.fnugetIdPlanilla',9);
       -- Obtiene el Item_seriado_id
       nuItemSe := fnugetItemSeriadOrden(inuOrderId) ;
       nuItemId := dage_items_seriado.fnugetitems_id(nuItemSe) ;
       nuActivity := OPEN.LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA ('OR_ORDER_ACTIVITY',
                    'ORDER_ID','ACTIVITY_ID',inuOrderId);

       for g in cuPlanilla  ( nuItemId, nuActivity ) loop
         nuNoDatFou :=1;
         nuIdPlanilla :=  g.variable_template_id;
       END loop;

       if nuNoDatFou = 0 then
         ge_boerrors.seterrorcodeargument(2741,'El Item_Id no tiene Asociada una Planilla,'||
                                             ' por favor verificar la Configuraci?n Previa ');
       else

         return nuIdPlanilla;

       END if;
        --.trace('Finaliza ldc_bometrologia.fnugetIdPlanilla',9);
     EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when NO_DATA_FOUND then
      pkErrors.pop;
       return '-';
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END;


   /*
     Devuelve el valor de una variable dada la orden y la variable */
    FUNCTION fsbgetValueVariable
     (
       inuOrderId          in           OR_order.order_id%type ,
       inuVariableId       in           ge_variable.variable_id%type
     )
    return VARCHAR2
     IS

       nuValRet                         or_order_act_var_det.value%TYPE := 0;
       sbDescVar                        ge_variable.display_name%type;
       sbNamePersRev                    ge_variable.variable_id%type;
       --  Variables para manejo de Errores
       exCallService                    EXCEPTION;
       sbCallService                    varchar2(2000);
       nuErrorCode                      number;
       sbErrorMessage                   varchar2(2000);
       nuErrorValVari                   number := 0;

       /* CURSOR que almacena todas las variables de una orden (Planilla) */
       CURSOR cuVariablesOrden (inuOrderId      in  number,
                                inuVariableId   in  ge_variable.variable_id%type) IS
         select  *
           from  OR_order_act_var_det
           where ORDER_id = inuOrderId
           AND variable_id = inuVariableId;

     BEGIN
       --.trace ('Inicia LDC_BOmetrologia.fsbgetRevisadoPor');

       for gvarO in cuVariablesOrden  ( inuOrderId, inuVariableId ) loop
         nuErrorValVari  := 1;
         nuValRet :=  gvarO.value;
         --.trace ('Valor Variable '|| gvarO.variable_id ||'['||gvarO.value||']',8) ;
       END loop;

       if nuErrorValVari = 0 then
         sbDescVar:= upper(dage_variable.fsbgetdisplay_name(inuVariableId));
         ge_boerrors.seterrorcodeargument(2741,
                              'No existe valor para la variable No comparable ['||inuVariableId||
                              ' - '||sbDescVar||
                              ']. Debe configurarla a la plantilla y luego en la orden.');
       END if;

       return  nuValRet;
       --.trace ('Finaliza LDC_BOmetrologia.fsbgetRevisadoPor') ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
     raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END  fsbgetValueVariable;


    /*
      Devuelve la Persona que Revisa */
    FUNCTION fsbgetPersonaQRevisa
     (
       inuOrderId            in           OR_order.order_id%type
     )
    return VARCHAR2
     IS
       sbPersRevi                         ge_variable.ALLOWED_VALUES%type;
       nuPlanTemp                         ldc_variattr.vaatcodi%type;
       nuVaceCodi                         ldc_variattr.vaatvaat%type;
       onuVacecodi                        ldc_varicert.vacecodi%type;
       osbVaceVaat                        ldc_varicert.vacevaat%type;

       --  Variables para manejo de Errores
       exCallService                       EXCEPTION;
       sbCallService                       varchar2(2000);
       sbErrorMessage                      varchar2(2000);
       nuErrorCode                         number;
       nuPos                               number;
       nombre_instancia                    varchar2(4000);

     BEGIN

       --.trace ('Inicia LDC_BOmetrologia.fsbgetRevisadoPor');

       nombre_instancia := ut_session.getmodule;

       ut_trace.trace('---------- instancia  ['||nombre_instancia||']',1);
       ut_trace.trace('---------- nuFlagPersonaQueRevisa  ['||nuFlagPersonaQueRevisa||']',1);
       ut_trace.trace('---------- sbPersonaQueRevisaIENCO  ['||sbPersonaQueRevisaIENCO||']',1);

       if nombre_instancia = 'IENCO' and nuFlagPersonaQueRevisa > 0 then
            return sbPersonaQueRevisaIENCO;
       elsif nombre_instancia = 'IENCO' and nuFlagPersonaQueRevisa = 0 then
            nuPos := instr(sbPersonaQueRevisaIENCO,'-');
            ut_trace.trace('---------- nombre_instancia = ''IENCO'' and nuFlagPersonaQueRevisa = 0  ['||substr(sbPersonaQueRevisaIENCO,nuPos+1,length(sbPersonaQueRevisaIENCO)-nuPos)||']',1);
            return substr(sbPersonaQueRevisaIENCO,nuPos+1,length(sbPersonaQueRevisaIENCO)-nuPos);
       end if;

       nuPlanTemp :=fnugetIdPlanilla(inuOrderId);
       ldc_bometrologia.getVacecodiVacevaat(csbVarPersonRevisa ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
       --              ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);
       -- Obtiene el valor de la variable Persona que Revisa
       sbPersRevi := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;

       if nuFlagPersonaQueRevisa > 0 then
            sbPersonaQueRevisaIENCO := null;
            nuFlagPersonaQueRevisa := 0;
            return sbPersRevi;
       else
            nuPos := instr(sbPersRevi,'-');
            return substr(sbPersRevi,nuPos+1,length(sbPersRevi)-nuPos);
       END if;


       --.trace ('Finaliza LDC_BOmetrologia.fsbgetRevisadoPor') ;

     EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END  fsbgetPersonaQRevisa;



    /*************************************************************************
    Devuelve el nombre del laboratorio*/

    FUNCTION fsbgetNombreLaboratorio
     (
       inuOrderId         in       OR_order.order_id%type
     )
    return VARCHAR2
     IS
       sbLaborato                         ge_variable.ALLOWED_VALUES%type;
       nuPlanTemp                         ldc_variattr.vaatcodi%type;
       nuVaceCodi                         ldc_variattr.vaatvaat%type;
       onuVacecodi                        ldc_varicert.vacecodi%type;
       osbVaceVaat                        ldc_varicert.vacevaat%type;

       --  Variables para manejo de Errores
       exCallService                EXCEPTION;
       sbCallService                varchar2(2000);
       sbErrorMessage               varchar2(2000);
       nuErrorCode                  number;

     BEGIN
       --.trace ('Inicia LDC_BOmetrologia.fsbgetNombreLaboratorio',8);

       nuPlanTemp :=fnugetIdPlanilla(inuOrderId);
       ldc_bometrologia.getVacecodiVacevaat(csbVarLaboratorio ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
       --                ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);
       -- Obtiene el valor de la variable Laboratorio
       sbLaborato := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;

       return sbLaborato;

     --.trace ('Finaliza LDC_BOmetrologia.fsbgetNombreLaboratorio',8) ;
     EXCEPTION
       when ex.CONTROLLED_ERROR then
         raise ex.CONTROLLED_ERROR;
       when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
         pkErrors.pop;
         raise;
       when NO_DATA_FOUND then
       pkErrors.pop;
         return '-';
       when OTHERS then
         pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);

       raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END  fsbgetNombreLaboratorio;


    /*obtiene  el valor del atributo dada la orden y el atributo*/
    FUNCTION fsbgetValorAtributo
     (
       inuOrderId           in      OR_order.order_id%type,
       inuAttribute_id      in      ge_entity_attributes.entity_attribute_id %type
     )
    return VARCHAR2

    IS
      valRet                        varchar2(4000);
      sbDescAttribute               ge_entity_attributes.display_name%type;
      --  Variables para manejo de Errores
      exCallService                 EXCEPTION;
      sbCallService                 varchar2(2000);
      sbErrorMessage                varchar2(2000);
      nuErrorCode                   number;
      nuErrorAttribu                number := 0;

      -- CURSOR Almacena el el valor del atributo a la Orden
      CURSOR cuValorAtributo (inuOrderId in number) IS
        SELECT v.valor FROM OR_order_activity act,
            ge_items_tipo_at_val v,ge_items_tipo_atr atr
        WHERE ORDER_id = inuOrderId
        AND act.serial_items_id =  v.id_items_seriado
        AND v.id_items_tipo_atr = atr.id_items_tipo_atr
        AND atr.entity_attribute_id = inuAttribute_id;

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fsbgetValorAtributo',8);
      --.trace (inuAttribute_id) ;

      select display_name  into sbDescAttribute
      from ge_entity_attributes
      where entity_attribute_id = inuAttribute_id;

      for vatt in cuValorAtributo(inuOrderId) loop
        nuErrorAttribu :=1;
        valRet := vatt.valor;
        --.trace ('['||inuAttribute_id|| '] Valor Atributo ['||vatt.valor||']',8) ;
        exit;
      end loop;

            /*Error Personalizado*/
      if nuErrorAttribu = 0 then
        ge_boerrors.seterrorcodeargument (2741,'No existe un Valor configurado para el atributo '||upper(sbDescAttribute)||' ['
                                || inuAttribute_id||']. ') ;
                                                                          -- -*- ge_items_tipo_at_val -*-
      end if;

      return valRet;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetValorAtributo',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when NO_DATA_FOUND then
      pkErrors.pop;
       return null;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);


    END fsbgetValorAtributo;


    /*
      Devuelve LA MARCA del Elemento*/
    FUNCTION fsbgetMarcaElemento
     (
       inuOrderId               in       OR_order.order_id%type
     )
    return VARCHAR2

    IS
      sbMarca                            ge_items_tipo_at_val.valor%type;
      inuPlanTemp                        ldc_variattr.vaatcodi%type;
      nuVaceCodi                         ldc_variattr.vaatvaat%type;
      onuVacecodi                        ldc_varicert.vacecodi%type;
      osbVaceVaat                        ldc_varicert.vacevaat%type;
      --  Variables para manejo de Errores
      exCallService                      EXCEPTION;
      sbCallService                      varchar2(2000);
      sbErrorMessage                     varchar2(2000);
      nuErrorCode                        number;

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fsbgetMarcaElemento',8);


       ldc_bometrologia.getVacecodiVacevaat(csbMarca ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
       --              ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       -- Obtiene el id q identifica que tipo de certificado debe imprimir
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
       dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');

       if  osbVaceVaat = 'V' then -- si es una variable
         sbMarca := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else
         sbMarca := fsbgetValorAtributo(inuOrderId,nuVaceCodi)  ;
       END if;
      --.trace ('Marca = Fabricante ['||sbMarca||']',8) ;

      return sbMarca;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetMarcaElemento',8) ;

     EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;

      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetMarcaElemento;

   /*
     Devuelve el MODELO del Elemento*/
    FUNCTION fsbgetModeloElemento
     (
       inuOrderId           in       OR_order.order_id%type
     )
    return VARCHAR2
    IS

      sbModelo                       ge_items_tipo_at_val.valor%type;
      inuPlanTemp                    ge_variable_template.variable_template_id%type;
      nuVaceCodi                     ldc_variattr.vaatvaat%type;
      onuVacecodi                    ldc_varicert.vacecodi%type;
      osbVaceVaat                    ldc_varicert.vacevaat%type;
      --  Variables para manejo de Errores
      exCallService                  EXCEPTION;
      sbCallService                  varchar2(2000);
      sbErrorMessage                 varchar2(2000);
      nuErrorCode                    number;

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fsbgetModeloElemento',8);

       ldc_bometrologia.getVacecodiVacevaat(csbModelo ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
       --              ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       -- Obtiene tipo de Laboratorio que se realizo
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId);
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
       dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');

       if  osbVaceVaat = 'V' then -- si es una variable
         sbModelo := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else
       -- llamar obtener atributos**
         sbModelo := fsbgetValorAtributo(inuOrderId,nuVaceCodi)  ;
       END if;

      return  sbModelo;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetModeloElemento',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);

      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetModeloElemento;


    /*
      Devuelve la descripci?n del RANGO MEDICI?N del Elemento */
    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  fsbgetRangMedicElemento
    Descripcion :
    Autor       : llozada
    Fecha       : 08-08-2013

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    23-07-2014          llozada            Se adiciona la validación para Notical,
                                           en caso de que el flag de Notica este activo
                                           debe retornar el rango.
    30-07-2014          llozada            Se adiciona la validación de la forma de donde se llama
                                           la función, para el caso de la notificación de
                                           mantenmiento de equipos, se llama desde ORCAO.
  **************************************************************************/
    FUNCTION fsbgetRangMedicElemento
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2
    IS

      sbRangoMedicion                         varchar2(2000); --ge_items_tipo_at_val.valor%type;
      inuPlanTemp                             ge_variable_template.variable_template_id%type;
      nuVaceCodi                              ldc_variattr.vaatvaat%type;
      onuVacecodi                             ldc_varicert.vacecodi%type;
      osbVaceVaat                             ldc_varicert.vacevaat%type;
      nuFactorC                               number;
      sbTipoLab                               varchar2(2000);
      sbUnidad                                varchar2(2000);
      sbUnidadEquiv                           varchar2(2000);
      rangoNormal                             varchar2(2000);
      rangoConver                             varchar2(2000);
      sbEspacio                               varchar2(50)  := '   ';

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);

      CURSOR cuTokens(sbVar varchar2)
      IS
        SELECT column_value
        from table (ldc_boutilities.SPLITstrings(sbVar,' '));

    BEGIN
        ----.init;
    ----.setlevel(99);
    ----.setoutput(--.fntrace_output_db);
      --.trace ('Inicia LDC_BOmetrologia.fsbgetRangoMedicion',8);

       ldc_bometrologia.getVacecodiVacevaat(csbRangoMediDesc ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
       --              ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       -- Obtiene el ID de certificado que se debe imprimir.
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
       dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');

       if  osbVaceVaat = 'V' then -- si es una variable
         --                   ID DE LA VARIABLE, ID DE LA PLANILLA UTILIZAD
         sbRangoMedicion := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else
       -- llamar obtener atributos**
         sbRangoMedicion := fsbgetValorAtributo(inuOrderId,nuVaceCodi)  ;
       END if;

       --23-07-2014,Llozada
       if sbFlagNotical = 'Y' then
            sbFlagNotical := null;
            return sbRangoMedicion;
       end if;

       --23-07-2014,Llozada
       if sbFlagIenco = 'Y' then
            sbFlagIenco := null;
            return sbRangoMedicion;
       end if;

       ut_trace.TRACE('---- ut_session.getmodule: '||ut_session.getmodule,8);
       --30-07-2014, llozada
       if ut_session.getmodule = 'ORCAO' then
            return sbRangoMedicion;
       end if;

      -- Obtiene la unidad de medida y equivalencia
      sbUnidadEquiv      := fsbgetUnidadEquiv(inuOrderId);
      sbUnidad           := fsbgetUnidadMedida(inuOrderId)||chr(9) ||chr(9);

      -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId); -- FSBGETNOMBRELABORATORIO(inuOrderId); --
      ----.TRACE('[METROLOGIA] {LDC_BOmetrologia.fsbgetDescrMedio} sbTipoLab: '||sbTipoLab,8);
     -- --.TRACE('---- [METROLOGIA]  sbRangoMedicion: '||sbRangoMedicion,8);

      IF sbTipoLab like '%'||csbPresion||'%' THEN
          --if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%PSI%' then
            for rc in cuTokens(sbRangoMedicion) loop
                if ldc_boutilities.IS_NUMBER(rc.column_value) = 'Y' then
                    dbms_output.put_Line('-- PRESION PSI Paso 1. rc.column_value: '||rc.column_value||', '||upper(fsbgetUnidadMedida(inuOrderId)));

                        /*if to_number(rc.column_value) = 0 then
                            rangoNormal := rangoNormal||' '||to_number(rc.column_value)||' '||sbUnidad;
                            rangoConver := rangoConver||' '||to_number(rc.column_value)||' '||sbUnidadEquiv;
                        else */
                            nuFactorC   := fnugetFactorConversion(inuOrderId);
                            --rangoNormal := rangoNormal||' '||to_number(rc.column_value)||' '||sbUnidad;
                            rangoConver := rangoConver||' '||to_char((to_number(rc.column_value) * nuFactorC),'999G999990D00'); --||' '||sbUnidadEquiv;
                        --END if;
                else
                    --rangoNormal :=  rangoNormal||' '||rc.column_value;
                    rangoConver :=  rangoConver||' '||rc.column_value;
                END if;

                dbms_output.put_Line('-- PRESION PSI Paso 2. rangoConver: '||rangoConver);
            end loop;

            --sbRangoMedicion := rangoNormal||' '||upper(sbUnidad)||'               ('||REGEXP_REPLACE(rangoConver, '  *', ' ')||' kPa)';
            --sbRangoMedicion := rangoNormal||' '||upper(sbUnidad)||'               ('||rangoConver||' '||sbUnidadEquiv||')';
            sbRangoMedicion := '('||sbRangoMedicion||') '||sbUnidad||chr(9)||' ('||rangoConver||') '||sbUnidadEquiv;

          /*elsif upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%H2%' then
            for rc in cuTokens(sbRangoMedicion) loop
                if ldc_boutilities.IS_NUMBER(rc.column_value) = 'Y' then
                    dbms_output.put_Line('-- PRESION INH Paso 1. rc.column_value: '||rc.column_value||', '||upper(fsbgetUnidadMedida(inuOrderId)));

                       /* if to_number(rc.column_value) = 0 then
                            rangoNormal := rangoNormal||' '||to_number(rc.column_value)||' '||sbUnidad;
                            rangoConver := rangoConver||' '||to_number(rc.column_value)||' '||sbUnidadEquiv;
                        else */
                           /* nuFactorC   := fnugetFactorConversion(inuOrderId);
                            --rangoNormal := rangoNormal||' '||to_number(rc.column_value)||' '||sbUnidad;
                            rangoConver := rangoConver||' '||to_char((to_number(rc.column_value) * nuFactorC),'999G999990D00'); --||' '||sbUnidadEquiv;
                        --END if;
                else
                    --rangoNormal :=  rangoNormal||' '||rc.column_value;
                    rangoConver :=  rangoConver||' '||rc.column_value;
                END if;

                dbms_output.put_Line('-- PRESION INH Paso 2. rangoConver: '||rangoConver);
            end loop;

            --sbRangoMedicion := sbRangoMedicion||' '||upper(fsbgetUnidadMedida(inuOrderId))||'               ('||REGEXP_REPLACE(rangoConver, '  *', ' ')||' kPa)';
            --sbRangoMedicion := rangoNormal||' '||upper(sbUnidad)||'               ('||rangoConver||' '||sbUnidadEquiv||')';
            sbRangoMedicion := '('||sbRangoMedicion||') '||sbUnidad||chr(9)||' ('||rangoConver||') '||sbUnidadEquiv; */
          /*else
            sbRangoMedicion := '('||sbRangoMedicion||') '||fsbgetUnidadMedida(inuOrderId);
          END if;*/
      END if;

         ----.TRACE('---- [METROLOGIA] fin  rangoConver : '||rangoConver||', upper(fsbgetUnidadMedida(inuOrderId)): '||upper(fsbgetUnidadMedida(inuOrderId)),8);
        dbms_output.put_Line('---- PRESION PASO 3.  rangoConver : '||rangoConver||', upper(fsbgetUnidadMedida(inuOrderId)): '||upper(fsbgetUnidadMedida(inuOrderId)));

      IF sbTipoLab like '%'||csbTemperatura||'%' THEN
        if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%F%' then
            for rc in cuTokens(sbRangoMedicion) loop
               if ldc_boutilities.IS_NUMBER(rc.column_value) = 'Y' then

                    /*if to_number(rc.column_value) = 100 then
                        rangoNormal := rangoNormal||' '||to_number(rc.column_value)||' '||sbUnidad;
                        rangoConver := rangoConver||' '||to_char(((to_number(rc.column_value) - 32)*(5/9)),'999G999990D00')||' '||sbUnidadEquiv;
                    else */
                        --rangoNormal := rangoNormal||' '||to_number(rc.column_value)||' '||sbUnidad;
                        rangoConver := rangoConver||' '||to_char(((to_number(rc.column_value) - 32)*(5/9)),'999G999990D00'); --||' '||sbUnidadEquiv;
                    --END if;
                else
                    --rangoNormal :=  rangoNormal||' '||rc.column_value;
                    rangoConver :=  rangoConver||' '||rc.column_value;

                end if;

            end loop;

            --sbRangoMedicion := sbRangoMedicion||' '||upper(fsbgetUnidadMedida(inuOrderId))||'  ('||REGEXP_REPLACE(rangoConver, '  *', ' ')||' '||replace(upper(fsbgetUnidadMedida(inuOrderId)),'F','C')||')';
            --sbRangoMedicion := rangoNormal||' '||sbUnidad||'               ('||rangoConver||' '||sbUnidadEquiv||')';
            sbRangoMedicion := '('||sbRangoMedicion||') '||sbUnidad||chr(9)||' ('||rangoConver||') '||sbUnidadEquiv;

        elsif upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%C%' then
            -- Es grados Celsius

            --sbRangoMedicion := rangoNormal||' '||upper(sbUnidad);
            sbRangoMedicion := '('||sbRangoMedicion||') '||sbUnidad;
        end if;
      END if;

      --dbms_output.put_Line('-- TEMPERATURA Paso 5. rangoConver: '||rangoConver||'. sbRangoMedicion: '||sbRangoMedicion);
      if sbRangoMedicion is null then
        sbRangoMedicion := '';
      end if;

      return  sbRangoMedicion;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetRangoMedicion',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetRangMedicElemento;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetIncertiEquivPresion
    Descripcion : Devuelve el DIVISI?N ESCALA del Elemento

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    18-08-2015          Llozada [Ara 6347] Se adicionan un décimal a la división escala
    15-07-2015          Llozada            Se comenta la condición que valida la unidad de medida
                                           para PRESION.
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbgetDivicEscaElement
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2
    IS

      sbDivisionEscal                         ge_items_tipo_at_val.valor%type;
      inuPlanTemp                             ge_variable_template.variable_template_id%type;
      nuVaceCodi                              ldc_variattr.vaatvaat%type;
      onuVacecodi                             ldc_varicert.vacecodi%type;
      osbVaceVaat                             ldc_varicert.vacevaat%type;
      sbTipoLab                               varchar2(2000);
      rangoConver                             varchar2(2000);
      sbUnidadEquiv                           varchar2(2000);
      nuFactorConver                           number;

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fsbgetDivicEscaElement',8);

       ldc_bometrologia.getVacecodiVacevaat(csbDivisionEscal ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
       --              ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       -- Obtiene tipo de Certificado que se debe imprimir
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId);
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
       dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');

       if  osbVaceVaat = 'V' then -- si es una variable
         sbDivisionEscal := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else
         sbDivisionEscal := fsbgetValorAtributo(inuOrderId,nuVaceCodi)  ;
       END if;

             -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId); --FSBGETNOMBRELABORATORIO(inuOrderId); --
      --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fsbgetDescrMedio} sbTipoLab: '||sbTipoLab,8);

      dbms_output.put_line('[METROLOGIA] {LDC_BOmetrologia.fsbgetDescrMedio} sbTipoLab: '||sbTipoLab);

        IF sbTipoLab like '%'||csbPresion||'%' THEN
            -- Obtiene la unidad de medida y equivalencia
            sbUnidadEquiv   := fsbgetUnidadEquiv(inuOrderId);
            nuFactorConver  := fnuGetFactorConversion(inuOrderId);

          --if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%PSI%' then

           -- if to_number(sbDivisionEscal) = 0 then
           --     rangoConver := rangoConver||' '||to_number(sbDivisionEscal);
           -- else
           --     rangoConver := rangoConver||' '||to_char((to_number(sbDivisionEscal) * 6.8949),'999G999990D0');
           -- END if;

           -- sbDivisionEscal := sbDivisionEscal||' '||upper(fsbgetUnidadMedida(inuOrderId))||'  ('||REGEXP_REPLACE(rangoConver, '  *', ' ')||' kPa)';

          --elsif upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%H2%' then
            if to_number(sbDivisionEscal) = 0 then
                rangoConver := rangoConver||' '||to_number(sbDivisionEscal);
            else
                rangoConver := rangoConver||' '||to_char((to_number(sbDivisionEscal) * nuFactorConver),'999G999990D00');
            END if;

            sbDivisionEscal := sbDivisionEscal||' '||upper(fsbgetUnidadMedida(inuOrderId))||'  ('||REGEXP_REPLACE(rangoConver, '  *', ' ')||' '||sbUnidadEquiv||')';
          --else
          --  sbDivisionEscal := sbDivisionEscal||' '||upper(fsbgetUnidadMedida(inuOrderId));
          --END if;
      END if;

         ----.TRACE('---- [METROLOGIA] fin  rangoConver : '||rangoConver||', upper(fsbgetUnidadMedida(inuOrderId)): '||upper(fsbgetUnidadMedida(inuOrderId)),8);
        dbms_output.put_Line('---- PRESION PASO 3.  rangoConver : '||rangoConver||', upper(fsbgetUnidadMedida(inuOrderId)): '||upper(fsbgetUnidadMedida(inuOrderId)));

      IF sbTipoLab like '%'||csbTemperatura||'%' THEN
        if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%F%' then
            if to_number(sbDivisionEscal) = 0 then
                rangoConver := rangoConver||' '||to_number(sbDivisionEscal);
            else
                if to_number(sbDivisionEscal) < 32 then
                    rangoConver := rangoConver||' '||to_char((to_number(sbDivisionEscal)  * (5/9)),'999G999990D00');
                else
                    rangoConver := rangoConver||' '||to_char(((to_number(sbDivisionEscal) - 32) * (5/9)),'999G999990D00');
                END if;
            END if;

            sbDivisionEscal := sbDivisionEscal||' '||upper(fsbgetUnidadMedida(inuOrderId))||'  ('||REGEXP_REPLACE(rangoConver, '  *', ' ')||' '||replace(upper(fsbgetUnidadMedida(inuOrderId)),'F','C')||')';
        else
            sbDivisionEscal := sbDivisionEscal||' '||upper(fsbgetUnidadMedida(inuOrderId));
        END if;
      END if;

      return  sbDivisionEscal;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetDivicEscaElement',8) ;

    EXCEPTION
     when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);
    END fsbgetDivicEscaElement;


    /*
       Devuelve la descripci?n del MEDIO utilizado para la calibraci?n del Elemento   */
    FUNCTION fsbgetDescrMedio
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2
    IS

      sbValorMedio                            OR_order_act_var_det.value%TYPE ;
      sbDescMedio                             OR_order_act_var_det.value%TYPE ;
      inuPlanTemp                             ge_variable_template.variable_template_id%type;
      nuVaceCodi                              ldc_variattr.vaatvaat%type;
      onuVacecodi                             ldc_varicert.vacecodi%type;
      osbVaceVaat                             ldc_varicert.vacevaat%type;
      sbTipoLab                               varchar2(2000);
      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
    BEGIN

       -- --.init;
       -- --.setlevel(99);
       -- --.setoutput(--.fntrace_output_db);
      --.trace ('Inicia LDC_BOmetrologia.fsbgetDescrMedio',8);

      -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId); --FSBGETNOMBRELABORATORIO(inuOrderId); --
      --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fsbgetDescrMedio} sbTipoLab: '||sbTipoLab,8);

      IF sbTipoLab like csbConcentracion||'%' THEN
        RETURN null;
      END IF;

      -- Obtiene el valor de la variable Medio.
      ldc_bometrologia.getVacecodiVacevaat(csbDescrMedio ,onuVacecodi,osbVaceVaat)  ;
      --.trace('Identificador interno ldc_varicert ['||onuVacecodi
      --               ||'] Es una variable (V) o un Atributo (A)  ['||osbVaceVaat||']',9);
      -- Obtiene el id del certificado que se debe imprimir
      inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;

      if  osbVaceVaat = 'V' then -- si es una variable
        nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
        dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');
        sbValorMedio := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi);
      else
       -- llamar obtener atributos**
        null;
      END if;

      IF sbTipoLab like '%'||csbPresion||'%' THEN
            -- Obtiene la descripci?n del Medio.
            sbDescMedio:= substr(sbValorMedio, 1,(instr(sbValorMedio,',')-1));
      else
            sbDescMedio := sbValorMedio;
      END if;

      return  sbDescMedio;
      --.trace ('Finaliza LDC_BOmetrologia.fsbgetDescrMedio',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise;
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetDescrMedio;


    FUNCTION fsbgetPreCiclo
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2
    IS

      sbValorMedio                            OR_order_act_var_det.value%TYPE ;
      sbDescMedio                             OR_order_act_var_det.value%TYPE ;
      inuPlanTemp                             ge_variable_template.variable_template_id%type;
      nuVaceCodi                              ldc_variattr.vaatvaat%type;
      onuVacecodi                             ldc_varicert.vacecodi%type;
      osbVaceVaat                             ldc_varicert.vacevaat%type;
       sbTipoLab                               varchar2(2000);
      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
    BEGIN

        ----.init;
        ----.setlevel(99);
        ----.setoutput(--.fntrace_output_db);
      --.trace ('Inicia LDC_BOmetrologia.fsbgetPreCiclo',8);

      -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId); -- FSBGETNOMBRELABORATORIO(inuOrderId); --
      --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fsbgetPreCiclo} sbTipoLab: '||sbTipoLab,8);

      IF sbTipoLab like '%'||csbTemperatura||'%' THEN
        --if(tipoItemTemperatura(inuOrderId) = 'B') then
            sbValorMedio := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,
                fnuObtValorParametro(csbPreCiclo));
            return  sbValorMedio;
        --END if;
      END IF;

      return null;
      --.trace ('Finaliza LDC_BOmetrologia.fsbgetPreCiclo',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise;
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetPreCiclo;

    -- Funcion para consultar el valor de la variable CONDICION DEL INSTRUMENTO
    FUNCTION fsbgetCondInstru
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2
    IS

      sbValorMedio                            OR_order_act_var_det.value%TYPE ;
      sbDescMedio                             OR_order_act_var_det.value%TYPE ;
      inuPlanTemp                             ge_variable_template.variable_template_id%type;
      nuVaceCodi                              ldc_variattr.vaatvaat%type;
      onuVacecodi                             ldc_varicert.vacecodi%type;
      osbVaceVaat                             ldc_varicert.vacevaat%type;
       sbTipoLab                               varchar2(2000);
      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);

    BEGIN
        ----.init;
        ----.setlevel(99);
        ----.setoutput(--.fntrace_output_db);
      --.trace ('Inicia LDC_BOmetrologia.fsbgetCondInstru',8);

      -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId); -- FSBGETNOMBRELABORATORIO(inuOrderId); --
      --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fsbgetCondInstru} sbTipoLab: '||sbTipoLab,8);

      IF sbTipoLab like csbTemperatura||'%' OR sbTipoLab like csbPresion||'%' THEN
        --if(tipoItemTemperatura(inuOrderId) = 'B') then
            sbValorMedio := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,
                fnuObtValorParametro(csbCondInstrumento));

            return  sbValorMedio;
        --END if;
      END IF;

      return null;
      --.trace ('Finaliza LDC_BOmetrologia.fsbgetCondInstru',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise;
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetCondInstru;
    ------


    FUNCTION fsbgetValorMedio
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return number
    IS

      sbValorMedio                            OR_order_act_var_det.value%TYPE ;
      sbDescMedio                             OR_order_act_var_det.value%TYPE ;
      inuPlanTemp                             ge_variable_template.variable_template_id%type;
      nuVaceCodi                              ldc_variattr.vaatvaat%type;
      onuVacecodi                             ldc_varicert.vacecodi%type;
      osbVaceVaat                             ldc_varicert.vacevaat%type;
      sbTipoLab                               varchar2(2000);
      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
      nuError                             number := -1;
    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fsbgetDescrMedio',8);

      sbTipoLab := fnugetTipoLab(inuOrderId); -- FSBGETNOMBRELABORATORIO(inuOrderId); --

      if  sbTipoLab like csbPresion||'%' then

          -- Obtiene el valor de la variable Medio.
          ldc_bometrologia.getVacecodiVacevaat(csbDescrMedio ,onuVacecodi,osbVaceVaat)  ;
          --.trace('Identificador interno ldc_varicert ['||onuVacecodi
          --               ||'] Es una variable (V) o un Atrivuto (A)  ['||osbVaceVaat||']',9);
          -- Obtiene el id del certificado que se debe imprimir
          inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
          if  osbVaceVaat = 'V' then -- si es una variable
            nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
            dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');
            sbValorMedio := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
          else
           -- llamar obtener atributos**
            null;
          END if;
          -- Obtiene la descripci?n del Medio.
          sbValorMedio := substr(sbValorMedio, instr(sbValorMedio,',')+1,length(sbValorMedio));
          --sbDescMedio:= substr(sbValorMedio, 1,(instr(sbValorMedio,',')-1));
          nuError := 0;

          return convertirDecimal(sbValorMedio) ;
      else

         sbValorMedio := convertirDecimal(LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,
                fnuObtValorParametro(csbINCERTIDUMBRE_PATRON_MEDIO)));

         return convertirDecimal(sbValorMedio);
      end if;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetDescrMedio',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise;
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
      when OTHERS then
        if(nuError = -1) then
            sbErrorMessage := 'ERROR, No se encuentra un valor para el MEDIO.';
        end if;
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetValorMedio;

    FUNCTION fsbgetValorProfundidad
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return number
    IS

      sbValorMedio                            number;
      sbDescMedio                             OR_order_act_var_det.value%TYPE ;
      inuPlanTemp                             ge_variable_template.variable_template_id%type;
      nuVaceCodi                              ldc_variattr.vaatvaat%type;
      onuVacecodi                             ldc_varicert.vacecodi%type;
      osbVaceVaat                             ldc_varicert.vacevaat%type;
      sbTipoLab                               varchar2(2000);
      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
      nuError                             number := -1;
    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fsbgetValorProfundidad',8);

      sbTipoLab := fnugetTipoLab(inuOrderId); --FSBGETNOMBRELABORATORIO(inuOrderId); --

      if  sbTipoLab like '%'||csbTemperatura||'%' then

            sbValorMedio := convertirDecimal(LDC_BOmetrologia.fsbgetValorAtributo(inuOrderId,
                fnuObtValorParametro(csbProfunidadInmersion))) ;

          return sbValorMedio;
      else

         return null;
      end if;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetValorProfundidad',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise;
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
      when OTHERS then
        if(nuError = -1) then
            sbErrorMessage := 'ERROR, No se encuentra un valor para el MEDIO.';
        end if;
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetValorProfundidad;


    /*
      Devuelve LA EXACTITUD del Elemento   */
    FUNCTION fsbgetExactitudElement
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2
    IS
      inuPlanTemp                         ge_variable_template.variable_template_id%type;
      sbExactitud                         ge_items_tipo_at_val.valor%type;
      nuVaceCodi                          ldc_variattr.vaatvaat%type;
      onuVacecodi                         ldc_varicert.vacecodi%type;
      osbVaceVaat                         ldc_varicert.vacevaat%type;

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
      nuError                             number := -1;
    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fsbgetExactitudElement',8);

       ldc_bometrologia.getVacecodiVacevaat(csbExactitud ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
       --              ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       -- Obtiene el Id del Certificado que se debe imprimir
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

       if  osbVaceVaat = 'V' then -- si es una variable
         sbExactitud := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else
         sbExactitud := fsbgetValorAtributo(inuOrderId,nuVaceCodi)  ;
       END if;
      nuError := 0;

      sbExactitud :=  convertirDecimal(sbExactitud);

      --.trace ('Exactitud ['||sbExactitud ||']',8) ;
      dbms_output.put_Line('---- Exactitud ['||sbExactitud ||']');
      return  sbExactitud;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetExactitudElement',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        if(nuError = -1) then
            sbErrorMessage := 'ERROR, No se encuentra un valor para la EXACITUD del elemento a calibrar.';
        end if;
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetExactitudElement;


    FUNCTION fnugetExactitudPatron
    (
    inuOrderId              in          OR_order.order_id%type
    )
    return  number
    IS
      inuPlanTemp                       ge_variable_template.variable_template_id%type;
      nuItSeriPatron                    ge_items_seriado.id_items_seriado%type;
      nuVaceCodi                        ldc_variattr.vaatvaat%type;
      nuVaceCodiDR                      ldc_variattr.vaatvaat%type;
      onuVacecodi                       ldc_varicert.vacecodi%type;
      onuVacecodiDR                     ldc_varicert.vacecodi%type;
      osbVaceVaat                       ldc_varicert.vacevaat%type;
      osbVaceVaatDR                     ldc_varicert.vacevaat%type;
      nuExctPatt                        number;
      nuDifRang                         number;
      UB_ExactPatt                      number;
      nuRangoFinal                        ldc_varicert.vacecodi%type;
      --  Variables para manejo de Errores
      exCallService                     EXCEPTION;
      sbCallService                     varchar2(2000);
      nuErrorCode                       number;
      sbErrorMessage                    varchar2(2000);
      nuErrorExactitudPatron            number:=-1;  -- -1 Error Exactitud

    BEGIN

      --.TRACE('Inicia  LDC_BOmetrologia.fnugetExactitudPatron',8);

      --  Obtiene el Item Patron.
      nuItSeriPatron := LDC_BOmetrologia.fnugetElemntoPatron(inuOrderId);
      --.trace('Item  Seriado Patron '||nuItSeriPatron );
      -- Obtiene  la exactitud del equipo patron.
       ldc_bometrologia.getVacecodiVacevaat(csbExactitud ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
       --              ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);

       inuPlanTemp :=fnugetIdPlanilla(inuOrderId);
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
       dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');

       if  osbVaceVaat = 'V' then -- si es una variable
        --.TRACE('---------- Es variable!!',8);
         nuExctPatt := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else
         --.TRACE('-------- Es Atributo!!!: '||LDC_BOmetrologia.fsbgetValAttribute (nuItSeriPatron,nuVaceCodi),8);

            nuExctPatt :=  convertirDecimal(LDC_BOmetrologia.fsbgetValAttribute (nuItSeriPatron,nuVaceCodi));
       END if;
       --.TRACE('-------- FIN nuExctPatt!!!: '||nuExctPatt,8);
       --.TRACE('Finaliza  LDC_BOmetrologia.fnugetExactitudPatron',8);

      return nuExctPatt;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
    END fnugetExactitudPatron;

    /* Devuelve 1 si es Analogo y 0 si es Digital
     remplazar por funci?n real cuando se defina como clasificar los items en
    an?logos y digitales ***************************************************/
    FUNCTION fnugetTipoElemento
    (
      inuOrderId          in        OR_order.order_id%type
    )
    return number
    IS

      inuPlanTemp                   ge_variable_template.variable_template_id%type;
      nuItemsSeriado                ge_items_seriado.id_items_seriado%type;
      nuItemsGamaId                 ge_items_gama_item.id_items_gama%type;
      sbTipoElem                    or_order_act_var_det.value%type;
      nuTipoItem                    ge_items.id_items_tipo%type;
      nuVaceCodi                    ldc_variattr.vaatvaat%type;
      onuVacecodi                   ldc_varicert.vacecodi%type;
      osbVaceVaat                   ldc_varicert.vacevaat%type;
      nuItemId                      ge_items.items_id%type;
      nuTipoElem                    number :=1;
      nuAndi                        number;
      sbParaElem                    varchar2(100);

    BEGIN

       ldc_bometrologia.getVacecodiVacevaat(csbTipoElemento ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
       --              ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       /*Obtiene el Id del certificado q se debe imprimir*/
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
       dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');

       if  osbVaceVaat = 'V' then -- si es una variable
         sbTipoElem := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else
         sbTipoElem := fsbgetValorAtributo(inuOrderId,nuVaceCodi)  ;
       END if;

       sbParaElem := dald_parameter.fsbgetvalue_chain(csbElementoAnalogo);

      IF sbParaElem <> sbTipoElem THEN
        nuTipoElem := 0; -- Digital
      END IF ;

      return nuTipoElem;

    EXCEPTION
      -- SI la orden no tiene sociado un ItemSeriado
      WHEN NO_DATA_FOUND THEN
          nuTipoElem := 1; -- Por defecto An?logo

    END fnugetTipoElemento;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fnugetTipoElementoPatron
    Descripcion : Devuelve el tipo del elemento para el patrón

    Autor       : llozada
    Fecha       : 28-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    28-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fnugetTipoElementoPatron
    (
      inuOrderId          in        OR_order.order_id%type
    )
    return number
    IS

      inuPlanTemp                   ge_variable_template.variable_template_id%type;
      nuItemsSeriado                ge_items_seriado.id_items_seriado%type;
      nuItemsGamaId                 ge_items_gama_item.id_items_gama%type;
      sbTipoElem                    or_order_act_var_det.value%type;
      nuTipoItem                    ge_items.id_items_tipo%type;
      nuVaceCodi                    ldc_variattr.vaatvaat%type;
      onuVacecodi                   ldc_varicert.vacecodi%type;
      osbVaceVaat                   ldc_varicert.vacevaat%type;
      nuItemId                      ge_items.items_id%type;
      nuTipoElem                    number :=1;
      nuAndi                        number;

    BEGIN

       nuVaceCodi := fnuObtValorParametro(csbTipoElementoPatron);

       dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');

       sbTipoElem := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;

      IF csbElementoAnalogo <> sbTipoElem THEN
        nuTipoElem := 0; -- Digital
      END IF ;

      return nuTipoElem;

    EXCEPTION
      -- SI la orden no tiene sociado un ItemSeriado
      WHEN NO_DATA_FOUND THEN
          nuTipoElem := 1; -- Por defecto An?logo

    END fnugetTipoElementoPatron;

    /*
       Valida que la Orden sea de Laboratorio .*/

    PROCEDURE valOrdenLaboratorio
   (
     inuOrderId  OR_order.order_id%type
   )
    IS
      nuTaskType or_task_type.task_type_id%type;
      nuTaskClas or_task_type.task_type_classif%type;

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
    BEGIN
      --.trace('Inicia ldc_bometrologia.valOrdenLaboratorio',9);

      nuTaskType := daor_order.fnugettask_type_id(inuOrderId);
      nuTaskClas := daor_task_type.fnugettask_type_classif(nuTaskType) ;

      IF cnuTaskTypeLab <> nuTaskClas THEN
        ge_boerrors.seterrorcodeargument(2741,'El n?mero de Orden Ingresado no corresponde '
                                     ||' a una Orden de Laboratorio,  Por favor verificar.');


      END IF;

      --.trace('Finaliza ldc_bometrologia.valOrdenLaboratorio',9);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END valOrdenLaboratorio;


      /*Obtiene el Tipo de Laboratorio que se realizo*/
    FUNCTION fnugetTipoLab
    (
      inuOrderId        in      OR_order.order_id%type
    ) return varchar2
    IS

      nuPlan                    ldc_plantemp.pltevate%type;
      sbTiCl                    ldc_plantemp.pltetipo%type;
      nuTipoLab                 ldc_plantemp.pltelabo%type;
      --  Variables para manejo de Errores
      exCallService             EXCEPTION;
      sbCallService             varchar2(2000);
      sbErrorMessage            varchar2(2000);
      nuErrorCode               number;
      nuOrderAj                 number;

      -- CURSOR
      CURSOR cuCertifica(inuPlan in ldc_plantemp.pltevate%type,
                         inTipoCl in ldc_plantemp.pltetipo%type) IS
        select PLTELABO FROM  ldc_plantemp
        WHERE  pltevate = nuPlan
        AND pltetipo =  inTipoCl
         AND pltelabo not like '%'||csbAjuste
        AND rownum  = 1;

      CURSOR cuCertificaAju(inuPlan in ldc_plantemp.pltevate%type,
                         inTipoCl in ldc_plantemp.pltetipo%type)   IS
        select PLTELABO FROM  ldc_plantemp
        WHERE  pltevate = nuPlan
        AND pltetipo =  inTipoCl
        AND pltelabo LIKE  '%'||csbAjuste
        AND rownum  = 1;

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fnugetIdCertificado ',8) ;
      -- Obtiene la planilla que se utilizo
      nuPlan := ldc_bometrologia.fnugetIdPlanilla(inuOrderId);
      sbTiCl := ldc_bometrologia.fsbTipoClienteCertif(inuOrderId);

      -- Valida si el Certificado tiene una orden de ajuste
      nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

      if nuOrderAj <> 0 then
        for e in cuCertificaAju(nuPlan,sbTiCl) loop
          nuTipoLab := e.PLTELABO;
        end loop;
      else
        for e in cuCertifica(nuPlan,sbTiCl) loop
          nuTipoLab := e.PLTELABO;
        end loop;
      END if;

      return nuTipoLab;
      --.trace ('Finaliza LDC_BOmetrologia.fnugetIdCertificado ',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetTipoLab;


  /***************************************************************************
   Obtiene el Elemento patron dado la orden */
    FUNCTION fnugetElemntoPatron
    (
      inuOrderId        in      OR_order.order_id%type
    ) return ge_items_seriado.id_items_seriado%type

    IS

      nuItemPatt         ge_items_seriado.id_items_seriado%type;

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
      nuErrorNoData                       number := 0;
      sbTipoLab                           varchar2(100);
      sbPatron                            varchar2(100);
      nuPos                               number;
      string                              varchar2(100);
      sbSerie                             varchar2(100);

      -- CURSOR que busca el Item Patron
      CURSOR cuItemPatt (inuOrderId in number) IS
        SELECT m.item_pattern_id FROM OR_order_act_measure m
          WHERE ORDER_id = inuOrderId
          AND rownum = 1;

      CURSOR cuItemSeriado(sbSerie_ ge_items_seriado.serie%type)
      IS
        SELECT ge_items_seriado.id_items_seriado
        FROM ge_items_seriado
        WHERE serie = sbSerie_;

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetElemntoPatron',8);

      sbTipoLab := fnugetTipoLab(inuOrderId); -- FSBGETNOMBRELABORATORIO(inuOrderId); --

      if sbTipoLab = csbOrificios then
            sbPatron := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,    --'PATRON MEDIDOR (95W475653)';
                DALD_parameter.fnuGetNumeric_Value('PATRON_ORIFICIO'));

            nuPos := instr(sbPatron,'(');
            sbSerie := substr(sbPatron,nuPos+1,length(sbPatron)-(nuPos+1));

            dbms_output.put_Line('ORIFICIOS: '||sbSerie);

            open cuItemSeriado(sbSerie);
            fetch cuItemSeriado INTO nuItemPatt;
            close cuItemSeriado;

            if nuItemPatt > 0 then
                return nuItemPatt;
            END if;

            ge_boerrors.seterrorcodeargument (2741,'La serie configurada para el patron de Orificios [ '
                                || sbSerie||' ], No existe en la Base de Datos. Por Favor Validar.')  ;

      END if;

      -- buscando el equipo patron
      for patt in cuItemPatt(inuOrderId) loop
        nuErrorNoData := 1;
        nuItemPatt:= patt.item_pattern_id;
      end loop;
      --.TRACE('Item Patron [ '||nuItemPatt||' ]',8);

      if nuErrorNoData = 0 then
        /* raise_application_error(pkConstante.nuERROR_LEVEL2, 'No existe Item Patron asociado a la orden , ORDER_id [ '
                                || inuOrderId||' ], OR_order_act_measure');    */
         ge_boerrors.seterrorcodeargument (2741,'No existe Item Patron asociado a la orden , ORDER_id [ '
                                || inuOrderId||' ], OR_order_act_measure')  ;
      END if ;

      return  nuItemPatt;

      --.TRACE('Inicia  LDC_BOmetrologia.fnugetElemntoPatron',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);
    END;


   /* FUNCI?N QUE devuelve el valor de un atributo dado el item_seriado y el IdAtributo*/
    FUNCTION fsbgetValAttribute
    (
      inuItemSeriado           in        ge_items_seriado.id_items_seriado%type,
      inuAttributeId           in        ge_entity_attributes.entity_attribute_id%type

    ) return ge_items_tipo_at_val.valor%type

    IS

      nuValorAttribute                   ge_items_tipo_at_val.valor%type;
      sbDescAttribute                    ge_entity_attributes.display_name%type;
      sbSerie                            ge_items_seriado.serie%type;
      --  Variables para manejo de Errores
      exCallService                      EXCEPTION;
      sbCallService                      varchar2(2000);
      sbErrorMessage                     varchar2(2000);
      nuErrorAttribu                     number := 0;
      nuErrorCode                        number;

      -- CURSOR que devuelve el valor de un atributo dado el item_seriado y el IdAtributo
      CURSOR cuValAttrItem (inuItemSeriado in ge_items_seriado.id_items_seriado%type,
                        inuAttributeId in ge_entity_attributes.entity_attribute_id%type)
        IS
          SELECT v.valor FROM ge_items_tipo_at_val v,ge_items_tipo_atr atr
          WHERE v.id_items_seriado = inuItemSeriado
          AND v.id_items_tipo_atr = atr.id_items_tipo_atr
          AND atr.entity_attribute_id = inuAttributeId;

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fsbgetValAttribute',8);

      select display_name  into sbDescAttribute
      from ge_entity_attributes
      where entity_attribute_id = inuAttributeId;

      select serie INTO sbSerie
      from ge_items_seriado
      where id_items_seriado = inuItemSeriado;

      -- Obtiene el valor del atributo dado el Item Seriado
      /*for exac in cuValAttrItem(inuItemSeriado,inuAttributeId) loop
        nuErrorAttribu :=1;
        nuValorAttribute := exac.valor;
      end loop;*/

      OPEN cuValAttrItem(inuItemSeriado,inuAttributeId);
      FETCH  cuValAttrItem INTO nuValorAttribute;
      CLOSE cuValAttrItem;
      --.TRACE('['||inuAttributeId ||'] Valor Atributo [ '||nuValorAttribute||' ]',8);

      /*Error Personalizado*/
      --if nuErrorAttribu = 0 then
      IF nuValorAttribute IS not NULL THEN
            return  nuValorAttribute;
      END if ;
    --.TRACE('Inicia  LDC_BOmetrologia.fsbgetValAttribute',8);

    EXCEPTION
      when OTHERS then
        ge_boerrors.seterrorcodeargument (2741,'No existe un Valor configurado para el atributo '||upper(sbDescAttribute)||' ['
                                || inuAttributeId||'], SERIE EQUIPO: '||sbSerie||' [' ||inuItemSeriado ||'] o el Atributo no existe!. ')  ;
    END;

   /*Calculando Varaibles que se utilizara en la formula:

    " PRIMER ESCENARIO:  Si el instrumento es de tipo BOURDON o AN?LOGO
    (Registrado en el sistema como MANOMETRO DE CARATULA)
    /* Calculando
     Uexp = sqrt( k  x     UB(Exactitud)? + UB(Repetibilidad)? +UB(Resoluci?n)? + UB(DELTA_h)? +UB (Desv.cero)? + UB(Hist?resis)?)
    *****************************************************************************

     UB (Exactitud): Es la incertidumbre por exactitud del equipo patr?n
     UB (Exactitud) = ((Exactitud  x Rango)/100) /  3 */
    FUNCTION fnugetUB_Exactitud
    (
    inuOrderId              in          OR_order.order_id%type
    )
    return  number
    IS
      inuPlanTemp                       ge_variable_template.variable_template_id%type;
      nuItSeriPatron                    ge_items_seriado.id_items_seriado%type;
      nuVaceCodi                        ldc_variattr.vaatvaat%type;
      nuVaceCodiDR                      ldc_variattr.vaatvaat%type;
      onuVacecodi                       ldc_varicert.vacecodi%type;
      onuVacecodiDR                     ldc_varicert.vacecodi%type;
      osbVaceVaat                       ldc_varicert.vacevaat%type;
      osbVaceVaatDR                     ldc_varicert.vacevaat%type;
      nuExctPatt                        number;
      nuDifRang                         number;
      UB_ExactPatt                      number;
      nuRangoFinal                        ldc_varicert.vacecodi%type;
      --  Variables para manejo de Errores
      exCallService                     EXCEPTION;
      sbCallService                     varchar2(2000);
      nuErrorCode                       number;
      sbErrorMessage                    varchar2(2000);
      nuErrorExactitudPatron            number:=-1;  -- -1 Error Exactitud

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetUB_Exactitud',8);

      --  Obtiene el Item Patron.
      nuItSeriPatron := LDC_BOmetrologia.fnugetElemntoPatron(inuOrderId);
      --.trace('Item  Seriado Patron '||nuItSeriPatron );
      -- Obtiene  la exactitud del equipo patron.
       ldc_bometrologia.getVacecodiVacevaat(csbExactitud ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
      --               ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);

       inuPlanTemp :=fnugetIdPlanilla(inuOrderId);
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
       dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');

       if  osbVaceVaat = 'V' then -- si es una variable              -- Se divide en 100 porque es Export.
         nuExctPatt := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else

         nuExctPatt := convertirDecimal(LDC_BOmetrologia.fsbgetValAttribute (nuItSeriPatron,nuVaceCodi));

       END if;

       --.trace('Exactitud del Patron [ '||nuExctPatt||' ]' );

       nuErrorExactitudPatron := -2; -- -2 ERROR Rango

       /*Obtiene el Rango del Patron*/
       nuVaceCodi := fnuObtValorParametro(csbRangInic); --ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
       nuRangoFinal := fnuObtValorParametro(csbRangFinal);

       /*if  osbVaceVaatDR = 'V' then -- si es una variable
         nuDifRang := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodiDR) ;
       else
         nuDifRang  :=  to_number(LDC_BOmetrologia.fsbgetValAttribute (nuItSeriPatron,nuVaceCodiDR));
       END if;*/

       nuDifRang  :=  to_number(LDC_BOmetrologia.fsbgetValAttribute (nuItSeriPatron,nuVaceCodi));
       nuRangoFinal := to_number(LDC_BOmetrologia.fsbgetValAttribute (nuItSeriPatron,nuRangoFinal));

        -- Obtiene el rango del Elemento que se esta calibrando
       nuDifRang:= nuRangoFinal - nuDifRang;

       --.trace('Rango Patron'||nuDifRang );

      /* UB (Exactitud) = ((Exactitud  x Rango)/100) /  3 */
      UB_ExactPatt :=  ((nuExctPatt*nuDifRang)/cnu100)/sqrt(cnu3);

      nuErrorExactitudPatron := 0;

      return UB_ExactPatt;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetUB_Exactitud',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then

        if (nuErrorExactitudPatron = -1) then
            sbErrorMessage:= 'ERROR, No existe un valor configurado para la EXACTITUD del patr?n.
                              Valide la configuraci?n.';
        end if;

        if (nuErrorExactitudPatron = -2) then
            sbErrorMessage:= 'ERROR, No existe un valor configurado para el RANGO del patr?n.
                              Valide la configuraci?n.';
        end if;

        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetUB_Exactitud;

    /* Validaci?n de la exactitud calculada respecto a los intervalos*/
       FUNCTION fnugetExactitudIntervalo
    (
    inuOrderId              in          OR_order.order_id%type
    )
    return  number
    IS
          nuExactitud     number;
          sbIntervalos    varchar2(4000);
                --  Variables para manejo de Errores
          exCallService                     EXCEPTION;
          sbCallService                     varchar2(2000);
          nuErrorCode                       number;
          sbErrorMessage                    varchar2(2000);
          sbTipoLab                        ldc_plantemp.pltelabo%type;

          CURSOR cuTokens(sbVar varchar2)
          IS
             SELECT column_value
             from table (ldc_boutilities.SPLITstrings(sbVar,'|'));

    BEGIN
    ----.init;
    ----.setlevel(99);
    ----.setoutput(--.fntrace_output_db);
          --.TRACE('Inicia  LDC_BOmetrologia.fnugetExactitudIntervalo',8);

          -- Obtiene el tipo de Laboratorio
          sbTipoLab := FSBGETNOMBRELABORATORIO(inuOrderId); --fnugetTipoLab (inuOrderId);

          if sbTipoLab <> csbPresion then
                return null;
          END if;

          nuExactitud :=abs(convertirDecimal(LDC_BOMETROLOGIA.FNUGETPORERROMAX(inuOrderId))); --fnugetUB_Exactitud(inuOrderId));
          --.TRACE('-- INTERVALOS nuExactitud: '||nuExactitud,8);

          sbIntervalos := dald_parameter.fsbGetValue_Chain(csbIntervalos);
          --.TRACE('INTERVALOS  sbIntervalos: '||sbIntervalos,8);

          for rc in cuTokens(sbIntervalos) loop
              --.TRACE('INTERVALOS  nuExactitud: '||nuExactitud||' | convertirDecimal(rc.column_value): '||convertirDecimal(rc.column_value),8);
              if nuExactitud <= convertirDecimal(rc.column_value) then
                    nuExactitud := convertirDecimal(rc.column_value);
                    exit;
              END if;
          END loop;

          --.TRACE('-- INTERVALOS FIN nuExactitud: '||nuExactitud,8);
          return nuExactitud;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetExactitudIntervalo;

    FUNCTION fnugetExactitudInterAjus (inuOrderId              in          OR_order.order_id%type)
    return number
    IS
        nuOrderAj       OR_order.order_id%type;
        nuExactitud     number;
        sbIntervalos    varchar2(4000);
        sbTipoLab       ldc_plantemp.pltelabo%type;

        CURSOR cuTokens(sbVar varchar2)
          IS
             SELECT column_value
             from table (ldc_boutilities.SPLITstrings(sbVar,'|'));
    BEGIN

         -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

        if nuOrderAj > 0 then
                -- Obtiene el tipo de Laboratorio
              sbTipoLab := FSBGETNOMBRELABORATORIO(nuOrderAj); --fnugetTipoLab (inuOrderId);

              if sbTipoLab <> csbPresion  then
                    return null;
              END if;

              nuExactitud :=abs(convertirDecimal(LDC_BOMETROLOGIA.fnugetPorErrorMaxAjus(inuOrderId))); --fnugetUB_Exactitud(inuOrderId));
              --.TRACE('-- INTERVALOS nuExactitud: '||nuExactitud,8);

              sbIntervalos := dald_parameter.fsbGetValue_Chain(csbIntervalos);
              --.TRACE('INTERVALOS  sbIntervalos: '||sbIntervalos,8);

              for rc in cuTokens(sbIntervalos) loop
                  --.TRACE('INTERVALOS  nuExactitud: '||nuExactitud||' | convertirDecimal(rc.column_value): '||convertirDecimal(rc.column_value),8);
                  if nuExactitud <= convertirDecimal(rc.column_value) then
                        nuExactitud := convertirDecimal(rc.column_value);
                        exit;
                  END if;
              END loop;

              --.TRACE('-- INTERVALOS FIN nuExactitud: '||nuExactitud,8);
              return nuExactitud;
        else
            return null;
        END if;

    END fnugetExactitudInterAjus;


    /*Funci?n que obtiene la repetibilidad */
    /*UB(Repetibilidad):
          Es la m?xima incertidumbre por la repetibilidad, que se calcula tomando el valor m?ximo
          entre la diferencia de los dos valores de bajada, este valor se divide por 2xSqrt(3)  */

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fnugetUB_Repetibilidad
    Descripcion : Devuelve el valor para la repetibilidad

    Autor       : llozada
    Fecha       : 16-04-2013

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    28-04-2015          Llozada [ARA 6869] Se modifica la lógica para que se tomen las nuevas formulas
                                           para presión.
    16-04-2013          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fnugetUB_Repetibilidad
    (
      inuOrderId        in      OR_order.order_id%type
    )
    return number

    IS

     -- Declaraci?n de Tablas PL
     type VarBajada1 IS RECORD (pp   number, PPBaj_1    number);
       type tyVarBajada1 IS TABLE OF VarBajada1 INDEX BY BINARY_INTEGER;

     type VarBajada2 IS RECORD (pp   number, PPBaj_2   number);
       type tyVarBajada2 IS TABLE OF VarBajada2 INDEX BY BINARY_INTEGER;

     type DiferBajadas IS RECORD (pp   number, PPBaj_1 number,PPBaj_2 number, DiferBaj   number);
      tytbVarBajada2            tyVarBajada2;
       type tyDiferBajadas IS TABLE OF DiferBajadas INDEX BY BINARY_INTEGER;

      tytbVarBajada1              tyVarBajada1;
      tytbDiferBajadas            tyDiferBajadas;
      -- Declaraci?n de variables
      nuRepetibilidad             number;
      nuContador                  number ;
      nuDiferBajadas              number;
      nuDeltaBajadas              number :=0;
      nuPlanTemp                  ge_variable_template.variable_template_id%type;
      nuVaceCodiB1                ldc_variattr.vaatvaat%type;
      nuVaceCodiB2                ldc_variattr.vaatvaat%type;
      onuVacecodiB2               ldc_varicert.vacecodi%type;
      onuVacecodiB1               ldc_varicert.vacecodi%type;
      onuVacecodiS1               ldc_varicert.vacecodi%type;
      onuVacecodiS2               ldc_varicert.vacecodi%type;
      osbVaceVaatB1               ldc_varicert.vacevaat%type;
      osbVaceVaatB2               ldc_varicert.vacevaat%type;
      osbVaceVaatS1               ldc_varicert.vacevaat%type;
      osbVaceVaatS2               ldc_varicert.vacevaat%type;
      nuBaja2                     ge_variable.variable_id%type;
      nuBaja1                     ge_variable.variable_id%type;
      nuSubi1                     ge_variable.variable_id%type;
      nuSubi2                     ge_variable.variable_id%type;
      maxSubidas                  NUMBER;
      maxBajadas                  NUMBER;
      sbSecuenciaExactitud        VARCHAR2(1);
      --  Variables para manejo de Errores
      exCallService               EXCEPTION;
      sbCallService               varchar2(2000);
      sbErrorMessage              varchar2(2000);
      nuErrorCode                 number;

      CURSOR cuDatosB(inuOrderId in number ,
                         nuSub2  in number ,
                         nuSub1  in number)
      IS
            SELECT  MAX(ABS(Sub2.item_value - Sub1.item_value)) maximo
            FROM  or_order_act_measure Sub2, or_order_act_measure Sub1
            WHERE Sub2.ORDER_id = inuOrderId
            AND Sub2.variable_id = nuSub2
            AND Sub1.variable_id = nuSub1
            AND Sub2.order_id = Sub1.order_id
            AND Sub2.measure_number =Sub1.measure_number;

    BEGIN
      -- Obtiene el Id de la planilla (Presion , Temperatura, Orificios, Planchas
      -- , Concentraci?n Seg?n la que corresponda.
      nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;

      /*Obtener el valor de la variable bajada1 */
      ldc_bometrologia.getVacecodiVacevaat(csbBaja_1 ,onuVacecodiB1,osbVaceVaatB1)  ;
      nuBaja1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiB1,nuPlanTemp);

       /*Obtener el valor de la variable bajada2 */
      ldc_bometrologia.getVacecodiVacevaat(csbBaja_2 ,onuVacecodiB2,osbVaceVaatB2);
      nuBaja2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiB2,nuPlanTemp);

      ldc_bometrologia.getVacecodiVacevaat(csbSubi_1 ,onuVacecodiS1,osbVaceVaatS1)  ;
      nuSubi1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS1,nuPlanTemp);

      ldc_bometrologia.getVacecodiVacevaat(csbSubi_2 ,onuVacecodiS2,osbVaceVaatS2)  ;
      nuSubi2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS2,nuPlanTemp);

      -- Selecciona  los registros de bajada 1
      SELECT pattern_value , Item_value bulk collect INTO tytbVarBajada1
      FROM OR_order_act_measure where  ORDER_id = inuOrderId
      AND variable_id in (nuBaja1) ORDER BY pattern_value ASC ;

      -- Selecciona  los registros de bajada 2
      SELECT pattern_value PP,Item_value bulk collect INTO tytbVarBajada2
      FROM OR_order_act_measure  where  ORDER_id = inuOrderId
      AND variable_id in (nuBaja2) ORDER BY pattern_value ASC  ;

      -- Verifica que las tablas PL tengas regstros
      if tytbVarBajada1.first IS not null and tytbVarBajada2.first IS not null then

        dbms_output.put_Line('||  PP   ||    ||PP(Baj1) ||     ||PP(Baj2)||    || DELTA ||');

        if tytbVarBajada1.COUNT  =  tytbVarBajada2.COUNT then
          -- La Cantidda de registros de la baj1 debe ser iguales a los de las baj2 **
          for nuContador in tytbVarBajada1.first .. tytbVarBajada1.last loop
            -- Para ordenar la data de acuerdo a los datos del patron PP
            IF  tytbVarBajada1(nuContador).pp =  tytbVarBajada2(nuContador).pp  THEN
              tytbDiferBajadas(nuContador).pp := tytbVarBajada1(nuContador).pp;
              tytbDiferBajadas(nuContador).PPBaj_1  := tytbVarBajada1(nuContador).PPBaj_1;
              tytbDiferBajadas(nuContador).PPBaj_2 := tytbVarBajada2(nuContador).PPBaj_2;
              nuDiferBajadas := tytbVarBajada2(nuContador).PPBaj_2 - tytbVarBajada1(nuContador).PPBaj_1;
              nuDiferBajadas := abs(nuDiferBajadas);
              tytbDiferBajadas(nuContador).DiferBaj :=nuDiferBajadas;
              dbms_output.put_Line('||  ' ||tytbDiferBajadas(nuContador).pp || '  ||    ||   '|| tytbDiferBajadas(nuContador).PPBaj_1
              || '   ||     || '|| tytbDiferBajadas(nuContador).PPBaj_2 || '    ||    ||'|| tytbDiferBajadas(nuContador).DiferBaj||'     ||');
            END IF ;
          end loop;

          -- Se recorre la nueva tabla para encontrar el delta M?ximo de bajadas**
          if tytbDiferBajadas.first IS not null  then
            dbms_output.put_Line('Entro tytbDiferBajadas, count: '||tytbDiferBajadas.count||', nuDeltaBajadas: '||nuDeltaBajadas);

            for nuContador in tytbDiferBajadas.first .. tytbDiferBajadas.last loop
              begin
                  -- Asigna el valor m?x de la diferencia de los registros de bajadas**
                  --ut_trace.trace('--PASO 3.4. tytbDiferBajadas(nuContador).DiferBaj: cont: '||nuContador||': '||tytbDiferBajadas(nuContador).DiferBaj,2);
                  if nuDeltaBajadas < tytbDiferBajadas(nuContador).DiferBaj then
                    nuDeltaBajadas := tytbDiferBajadas(nuContador).DiferBaj;
                  END if ;

              exception
                when others then
                    ut_trace.trace('--PASO 3.5. EXCEPTION. nuDeltaBajadas: '||nuDeltaBajadas||', nuContador: '||nuContador,2);
              end;
            end loop;
           -- ut_trace.trace('--PASO 3.6. sale del loop',2);
          END if;
        ELSE  -- Si el n?mero de registros de la variable Baj1 es diferente a los registros de la variable Baj2
          ge_boerrors.seterrorcodeargument(2741,'El n?mero de registros de la variable Baj1 es diferente a el n?mero '
                        ||' de registros de la variable Baj2, No es Imposible Calcular UB_repetibilidad , por favor verificar los datos de la planilla ');
        END if;
       -- ut_trace.trace('--PASO 3.6. ',2);
      END if;

      --13-04-2015 Llozada: Aplicación de las nuevas fórmulas de presión  [ARA 6869]
      IF LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbNuevasFormulas)
      OR LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbNuevasFormulas)
      OR LDC_CONFIGURACIONRQ.aplicaParaGDC(sbNuevasFormulas)
      OR LDC_CONFIGURACIONRQ.aplicaParaGDO(sbNuevasFormulas) THEN

            sbSecuenciaExactitud := fsbgetSecuenciaExactitud(inuOrderId);

            IF sbSecuenciaExactitud = 'C' THEN

                nuRepetibilidad := 0;

            ELSIF sbSecuenciaExactitud = 'B' THEN

                OPEN cuDatosB(inuOrderId, nuSubi2, nuSubi1);
                FETCH cuDatosB INTO maxSubidas;
                CLOSE cuDatosB;

                nuRepetibilidad := trunc(maxSubidas / (2 * SQRT(3)),6);

            ELSIF sbSecuenciaExactitud = 'A' THEN

                OPEN cuDatosB(inuOrderId, nuBaja2, nuBaja1);
                FETCH cuDatosB INTO maxBajadas;
                CLOSE cuDatosB;

                OPEN cuDatosB(inuOrderId, nuSubi2, nuSubi1);
                FETCH cuDatosB INTO maxSubidas;
                CLOSE cuDatosB;

                IF maxBajadas IS NOT NULL AND maxSubidas IS NOT NULL THEN
                    IF maxBajadas >= maxSubidas THEN
                        nuRepetibilidad := maxBajadas / (2 * SQRT(3));
                    ELSE
                        nuRepetibilidad := maxSubidas / (2 * SQRT(3));
                    END IF;
                ELSE
                    ge_boerrors.seterrorcodeargument(2741,'Recuerde que para la secuencia A [clase menor a 0,1], deben existir 2 subidas y 2 bajadas.'||
                                                          ' Valide los datos ingresados en la legalización.');
                END IF;
            END IF;
      ELSE
          -- Si no existe bajada2 la UB_repetibilidad es cero ..
          if tytbVarBajada1.first IS not null and tytbVarBajada2.first IS null  then
            ge_boerrors.seterrorcodeargument(2741,'No existe registros  para bajada2 NO se puede calcular UB_repetibilidad');
          END if;
          -- Si no Existen registros de las bajada1 ni la bajada2
          if tytbVarBajada1.first IS null and tytbVarBajada2.first IS null  then
             ge_boerrors.seterrorcodeargument(2741,'No existe registros  para bajada1 ni para Bajada2 NO se puede calcular UB_repetibilidad');
          END if;
          if tytbVarBajada1.first IS null and tytbVarBajada2.first IS not null  then
             ge_boerrors.seterrorcodeargument(2741,'No existe registros  para bajada1 NO se puede calcular UB_repetibilidad');
          END if;

          /*C?lculando  UB(Repetibilidad):
          Es la m?xima incertidumbre por la repetibilidad, que se calcula tomando el valor m?ximo
          entre la diferencia de los dos valores de bajada, este valor se divide por 2xSqrt(3)  */
          -- Calcula la repetibilidad...
          nuRepetibilidad :=  trunc(nuDeltaBajadas /( cnu2* sqrt(cnu3) ),6);
          ut_trace.trace('--PASO 5. nuRepetibilidad: '||nuRepetibilidad,2);
      END IF;

      -- Retorna el valor de la repetibilidad.
      return  nuRepetibilidad;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END;


    /*UB (Resoluci?n): Es la incertidumbre debida a la resoluci?n del instrumento
      a calibrar, por tanto, para instrumentos de presi?n an?logos este valor se divide sobre sqrt(3)
      y para instrumentos de presi?n digitales  este valor se divide sobre 2* sqrt(3)  ..*/
    FUNCTION fnugetUB_Resolucion
    (
      inuOrderId            in       OR_order.order_id%type
    )

    return  number
    IS

      inuPlanTemp                    ge_variable_template.variable_template_id%type;
      nuVaceCodi                     ldc_variattr.vaatvaat%type;
      onuVacecodi                    ldc_varicert.vacecodi%type;
      osbVaceVaat                    ldc_varicert.vacevaat%type;
      UB_Resolucion                  number;
      nuTipoItem                     number;
      nuResolucion                   number;
      --  Variables para manejo de Errores
      exCallService                  EXCEPTION;
      sbCallService                  varchar2(2000);
      sbErrorMessage                 varchar2(2000);
      nuErrorCode                    number;
      nuError                        number := -1;

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetUB_Resolucion',8);

      --.trace('Antes de TipoItem ',8) ;
      nuTipoItem := fnugetTipoElemento(inuOrderId);
      --.trace('TipoItem ['||nuTipoItem||']') ;

       ldc_bometrologia.getVacecodiVacevaat(csbResolucion ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
      --               ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       -- Obtiene el Id del tipo de Certificado que se debe imprimir
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
       dbms_output.put_Line('----------------- osbVaceVaat: '||osbVaceVaat);
       if  osbVaceVaat = 'V' then -- si es una variable
         nuResolucion := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else
        dbms_output.put_Line('----------------- nuResolucion: '||LDC_BOmetrologia.fsbgetValorAtributo(inuOrderId,nuVaceCodi));

            nuResolucion :=  convertirDecimal(LDC_BOmetrologia.fsbgetValorAtributo(inuOrderId,nuVaceCodi));
       END if;

       nuError := 0;

      -- Si el Instrumentos es An?logo / tipo de elemento = 1
     -- if nuTipoItem = 1 then
      /* UB (Resolucion) = Resolucion / sqrt(3)*/
      --  UB_Resolucion :=  (nuResolucion)/sqrt(cnu3);
      ----else -- Si el Instrumento es Digital
      /* UB (Resolucion) = Resolucion / 2*sqrt(3)*/
       -- UB_Resolucion :=  (nuResolucion)/( cnu2* sqrt(cnu3));
     -- END if;

      --.trace('Retorna -> UB (Resolucion) = '||UB_Resolucion);

      return nuResolucion;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetUB_Resolucion',8);
    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        if(nuError = -1) then
            sbErrorMessage := 'ERROR, No existe valor configurado para RESOLUCION.
                               Valide la configuraci?n.';
        end if;
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetUB_Resolucion;

    /*UB (Resoluci?n): Es la incertidumbre debida a la resoluci?n del Patron
      a calibrar, por tanto, para instrumentos de presi?n an?logos este valor se divide sobre sqrt(3)
      y para instrumentos de presi?n digitales  este valor se divide sobre 2* sqrt(3)  ..*/
    FUNCTION fnugetUB_ResolucionPatron
    (
      inuOrderId            in       OR_order.order_id%type
    )
    return  number
    IS

      inuPlanTemp                    ge_variable_template.variable_template_id%type;
      nuVaceCodi                     ldc_variattr.vaatvaat%type;
      onuVacecodi                    ldc_varicert.vacecodi%type;
      osbVaceVaat                    ldc_varicert.vacevaat%type;
      UB_Resolucion                  number;
      nuTipoItem                     number;
      nuResolucion                   number;
      --  Variables para manejo de Errores
      exCallService                  EXCEPTION;
      sbCallService                  varchar2(2000);
      sbErrorMessage                 varchar2(2000);
      nuErrorCode                    number;
      nuError                        number := -1;

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetUB_ResolucionPatron',8);

      --.trace('Antes de TipoItem ',8) ;
      nuTipoItem := fnugetElemntoPatron(inuOrderId);
      --.trace('TipoItem ['||nuTipoItem||']') ;

       ldc_bometrologia.getVacecodiVacevaat(csbResolucion ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
        --             ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       -- Obtiene el Id del tipo de Certificado que se debe imprimir
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

       nuResolucion := convertirDecimal(LDC_BOmetrologia.fsbgetValAttribute (nuTipoItem,nuVaceCodi));

       nuError := 0;

      -- Si el Instrumentos es An?logo / tipo de elemento = 1
     -- if nuTipoItem = 1 then
      /* UB (Resolucion) = Resolucion / sqrt(3)*/
      --  UB_Resolucion :=  (nuResolucion)/sqrt(cnu3);
      ----else -- Si el Instrumento es Digital
      /* UB (Resolucion) = Resolucion / 2*sqrt(3)*/
       -- UB_Resolucion :=  (nuResolucion)/( cnu2* sqrt(cnu3));
     -- END if;

      --.trace('Retorna -> UB (Resolucion) = '||UB_Resolucion);

      return nuResolucion;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetUB_ResolucionPatron',8);
    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        if(nuError = -1) then
            sbErrorMessage := 'ERROR, No existe valor configurado para RESOLUCION.
                               Valide la configuraci?n.';
        end if;
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetUB_ResolucionPatron;

    /*DEVUELVE el DELTA de alturas  (Subn Item Vs Patron)*/
    FUNCTION fnugetDeltaSubVsPatron
    (
      inuOrderId           in       OR_order.order_id%type,
      inuVariable1         in       ge_variable.variable_id%type
    )return  number
    IS
      nuPlanTemp                    ge_variable_template.variable_template_id%type;
      sbValorMedio                  OR_order_act_var_det.value%TYPE ;
      sbDescMedio                   OR_order_act_var_det.value%TYPE ;
      onuVacecodiS1                 ldc_varicert.vacecodi%type;
      osbVaceVaatS1                 ldc_varicert.vacevaat%type;
      nuSubi1                       ldc_variattr.vaatvaat%type;
      nuDensidadMedio               number;
      nuErrorMax                    number;

      --  Variables para manejo de Errores
      exCallService                 EXCEPTION;
      sbCallService                 varchar2(2000);
      sbErrorMessage                varchar2(2000);
      nuErrorCode                   number;

      -- CURSOR que obtiene el m?ximo valor de las diferencias entre la subidas del Item y el patron.
      CURSOR cuErrorSub1(inuOrderId      in    number,
                         inuVariable1    in    number ) IS
        select  max(error) MaxError
        from  or_order_act_measure
        where ORDER_id = inuOrderId
        AND variable_id IN (inuVariable1);

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetDeltaSubVsPatron',8);

      -- Obtiene el numero de identificador de la planilla que se utiliza en el proceso
      nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;

      -- Obtiene el Identificador de la varoble de subida
      ldc_bometrologia.getVacecodiVacevaat(csbSubi_1 ,onuVacecodiS1,osbVaceVaatS1)  ;
      nuSubi1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS1,nuPlanTemp);
       /*DELTA DE ALTURAS  SubX vs  Patron, se toma el m?x valor entre las diferencia de las alturas */
      for exac in cuErrorSub1(inuOrderId,nuSubi1) loop
        nuErrorMax := exac.MaxError;
      end loop;
      dbms_output.put_Line('M?x Error = '|| nuErrorMax);

      return  nuErrorMax;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetDeltaSubVsPatron',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;

      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetDeltaSubVsPatron;



    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fnugetUB_DeltaH_Sub1
    Descripcion : Devuelve el valor para la diferencia de altura

    Autor       : llozada
    Fecha       : 16-04-2013

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    28-04-2015          Llozada [ARA 6869]   Se modifica la lógica para que dependiendo de la unidad de medida
                                             se tome el factor de conversión correspondiente:
                                             Para PSI, el factor es 0,00015 [Parametro CONVERSION_PA_MET]
                                             Para INH2O, el factor es 0,00401 [Parametro CONVERSION_INH2_MET]
    16-04-2013          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fnugetUB_DeltaH_Sub1
    (
      inuOrderId             in        OR_order.order_id%type
    )return  number
    IS
      nuPlanTemp                       ge_variable_template.variable_template_id%type;
      sbValorMedio                     OR_order_act_var_det.value%TYPE ;
      sbDescMedio                      OR_order_act_var_det.value%TYPE ;
      nuVaceCodi                       ldc_variattr.vaatvaat%type;
      onuVacecodi                      ldc_varicert.vacecodi%type;
      osbVaceVaat                      ldc_varicert.vacevaat%type;
      onuVacecodiS1                    ldc_varicert.vacecodi%type;
      osbVaceVaatS1                    ldc_varicert.vacevaat%type;
      nuSubi1                          ldc_variattr.vaatvaat%type;
      nuDensidadMedio                  number;
      nuDifAltura                      number;
      nuDeltaH                         number;
      UB_DeltaH                        number;
      --  Variables para manejo de Errores
      exCallService                    EXCEPTION;
      sbCallService                    varchar2(2000);
      sbErrorMessage                   varchar2(2000);
      nuErrorCode                      number;

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetUB_DeltaH_Sub1',8);

      ldc_bometrologia.getVacecodiVacevaat(csbDescrMedio ,onuVacecodi,osbVaceVaat);
      --.trace('Var Descripcion Medio ['||onuVacecodi
        --             ||'] Es una variable (V) o un Atrivuto (A)  ['||osbVaceVaat||']',9);

      --.trace('Antes de la Planilla',9);
      -- Obtiene el Id del Tipo de Certificado que se debe imprimir
      nuPlanTemp :=fnugetIdPlanilla(inuOrderId);
      --.trace('nuPlanTempa ['||nuPlanTemp||']',9);

      --.trace('Despu?s de la planilla',9);

      -- Obtiene el Identificador de la variable de subida
      ----.trace('Inicia csbSubi_1 ',9);
      --ldc_bometrologia.getVacecodiVacevaat(csbSubi_1 ,onuVacecodiS1,osbVaceVaatS1)  ;
      ----.trace('Antes de onuVacecodiS1 , osbVaceVaatS1 [ '||onuVacecodiS1||']',9);
      --nuSubi1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS1,nuPlanTemp);
      ----.trace('Pasooooooooooooooooooooooooooooooooooooooooo por aquiiiiiiiiiiiiiiii',9);

      if  osbVaceVaat = 'V' then -- si es una variable
        --                   ID DE LA VARIABLE, ID DE LA PLANILLA UTILIZADA
        nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);
        sbValorMedio := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi);
        --.trace('sbValorMedio ['||sbValorMedio||']',9);
      else
       -- llamar obtener atributos**
        null;
      END if;

      --.trace('sbValorMedio afuera del if ['||sbValorMedio||']',9);

      ldc_bometrologia.getVacecodiVacevaat(csbVarDifAltura ,onuVacecodi,osbVaceVaat)  ;
      --.trace('Var Descripcion Altura ['||onuVacecodi
        --             ||'] Es una variable (V) o un Atrivuto (A)  ['||osbVaceVaat||']',9);

      if  osbVaceVaat = 'V' then -- si es una variable
        --                   ID DE LA VARIABLE, ID DE LA PLANILLA UTILIZADA
        nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);
        nuDifAltura := convertirDecimal(LDC_BOmetrologia.fsbgetValueVariable(inuOrderId ,nuVaceCodi));
        --to_number(LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi)) ;
        --.trace('nuDifAltura ['||nuDifAltura||']',9);
      else
       -- llamar obtener atributos**
        null;
      END if;

      --.trace('nuDifAltura afuera del if ['|| nuDifAltura ||']',8);
      -- Obtiene la densidad del Fluido Utilizado seg?n la orden
      begin
       --10-12-2015
       --SAO.358555
       --Mmejia
       --Se modifica para que utilice la funcion  convertirDecimalal convertir una cadena a numero
       -- nuDensidadMedio := to_number(substr(sbValorMedio,(instr(sbValorMedio,',')+1)));
        nuDensidadMedio := LDC_BOmetrologia.convertirDecimal(substr(sbValorMedio,(instr(sbValorMedio,',')+1)));
      exception
        when others then
            ge_boerrors.seterrorcodeargument(2741,'La DENSIDAD NO esta configurada en el MEDIO.');
      end;

      -- Obtiene le deltaH de sub1  vs Patron
      --nuDeltaH := LDC_BOmetrologia.fnugetDeltaSubVsPatron(inuOrderId,nuSubi1);
      /*   UB (DELTA(h))=  DELTA(P) / sqrt(3) = (DENSIDAD)( g )( DELTA(h) ) / sqrt(3) */
      IF upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%PSI%' THEN
            UB_DeltaH :=  (nuDensidadMedio*cnug*nuDifAltura*cnuConversionPA)/sqrt(cnu3);
      ELSE
            UB_DeltaH :=  (nuDensidadMedio*cnug*nuDifAltura*cnuConversionINH2)/sqrt(cnu3);
      END IF;
      --.trace('UB_DeltaH ['|| UB_DeltaH ||']',8) ;
      dbms_output.put_Line('UB_DeltaH = '||nuDensidadMedio||'*'||cnug||'*'||cnuConversionPA||'/sqrt(3) ='||UB_DeltaH);
      return  UB_DeltaH;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetUB_DeltaH_Sub1',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetUB_DeltaH_Sub1;


    /*UB (Desv .cero): Es la m?xima incertidumbre por desviaci?n de cero la cual
     se establece antes de cada ciclo de medici?n, que consiste en un aumento y
     una disminuci?n de la serie de puntos de calibraci?n, y debe ser registrado
     antes y despu?s de cada ciclo de medici?n.
        UB (Desv.Cero)=  Max (X2,0 - X 1,0) / 2 3
    * 21/03/2013 en Reuni?n con Remesis G?mez, se llama a Geovana y ella nos dice uqe
             X2 es Baja1 y X1 Subida1  cuando el patron es cero. */


    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fnugetUB_DesvCero
    Descripcion : Devuelve el valor para la desviación cero

    Autor       : llozada
    Fecha       : 16-04-2013

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    28-04-2015          Llozada [ARA 6869] Se modifica la lógica para que tome las nuevas formulas
                                           para presión.
    16-04-2013          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fnugetUB_DesvCero
    (
      inuOrderId        in       OR_order.order_id%type
    )return  number
    IS

      cursor cuExactitudSub(inuOrderId in number ,
                         nuBaja1  in number ,
                         nuSubi1  in number) IS
        select  abs(a.item_value - b.item_value) MaxErrorSubidas
        from  or_order_act_measure a, or_order_act_measure b
        where a.ORDER_id = inuOrderId
        AND a.variable_id = nuBaja1
        and b.variable_id = nuSubi1
        and a.measure_number = 1
        and b.measure_number = 1
        and a.order_id = b.order_id;

        cursor cuExactitudBaj(inuOrderId in number ,
                         nuBaja2  in number ,
                         nuSubi2  in number  ) IS
        select  abs(a.item_value - b.item_value) MaxErrorBajadas
        from  or_order_act_measure a, or_order_act_measure b
        where a.ORDER_id = inuOrderId
        AND a.variable_id = nuBaja2
        and b.variable_id = nuSubi2
        and a.measure_number = 1
        and b.measure_number = 1
        and a.order_id = b.order_id;

        CURSOR cuMayor(inuOrderId in number ,
                         nuBaja1  in number ,
                         nuSubi1  in number) IS
        select  abs(a.item_value - b.item_value) MaxErrorSubidas
        from  or_order_act_measure a, or_order_act_measure b
        where a.ORDER_id = inuOrderId
        and a.measure_number = 1
        and b.measure_number = 1
        AND a.variable_id = nuBaja1
        and b.variable_id = nuSubi1
        and a.order_id = b.order_id;

      nuBaja1                      number;
      nuBaja2                      number;
      nuSubi1                      ldc_variattr.vaatvaat%type;
      nuSubi2                      number;
      nuClase                      number;
      sbTipoLab                    ldc_plantemp.pltelabo%type;
      nuErrorMaxBaj                number;
      nuErrorMaxSub                number;
      nuPlanTemp                   ge_variable_template.variable_template_id%type;
      nuDesvCero                   NUMBER;

      onuVacecodiB1                ldc_varicert.vacecodi%type;
      osbVaceVaatB1                ldc_varicert.vacevaat%type;
      onuVacecodiB2                ldc_varicert.vacecodi%type;
      osbVaceVaatB2                ldc_varicert.vacevaat%type;
      onuVacecodiS1                ldc_varicert.vacecodi%type;
      onuVacecodiS2                ldc_varicert.vacecodi%type;
      osbVaceVaatS1                ldc_varicert.vacevaat%type;
      osbVaceVaatS2                ldc_varicert.vacevaat%type;
      sbSecuenciaExactitud         VARCHAR2(1);

      --  Variables para manejo de Errores
      exCallService                     EXCEPTION;
      sbCallService                     varchar2(2000);
      nuErrorCode                       number;
      sbErrorMessage                    varchar2(2000);

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetUB_DesvCero',8);
      -- Obtiene el Id de la planilla utilizada en el proceso
      nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;

      -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId); -- FSBGETNOMBRELABORATORIO(inuOrderId); --
      --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetUB_DesvCero} sbTipoLab: '||sbTipoLab,8);

      nuClase:= fsbgetExactitudElement(inuOrderId);
      --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetUB_DesvCero} nuClase: '||nuClase,8);

      ldc_bometrologia.getVacecodiVacevaat(csbBaja_1 ,onuVacecodiB1,osbVaceVaatB1)  ;
      nuBaja1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiB1,nuPlanTemp);
       /*Obtener el valor de la variable bajada2 */
      ldc_bometrologia.getVacecodiVacevaat(csbBaja_2 ,onuVacecodiB2,osbVaceVaatB2)  ;
      nuBaja2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiB2,nuPlanTemp);

      ldc_bometrologia.getVacecodiVacevaat(csbSubi_1 ,onuVacecodiS1,osbVaceVaatS1)  ;
      nuSubi1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS1,nuPlanTemp);

      ldc_bometrologia.getVacecodiVacevaat(csbSubi_2 ,onuVacecodiS2,osbVaceVaatS2)  ;
      nuSubi2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS2,nuPlanTemp);


      IF sbTipoLab LIKE '%'||csbPresion||'%' THEN

      --13-04-2015 Llozada: Aplicación de las nuevas fórmulas de presión  [ARA 6869]
          IF LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaGDC(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaGDO(sbNuevasFormulas) THEN

                sbSecuenciaExactitud := fsbgetSecuenciaExactitud(inuOrderId);

                IF sbSecuenciaExactitud = 'B' OR sbSecuenciaExactitud = 'C' THEN

                    --Se obtiene la resta de la bajada 1 menos la subida 1, en el punto cero y esto en valor absoluto.
                    OPEN cuMayor(inuOrderId,nuBaja1,nuSubi1);
                    FETCH cuMayor INTO nuErrorMaxSub;
                    CLOSE cuMayor;

                    IF nuErrorMaxSub IS NULL THEN
                       ge_boerrors.seterrorcodeargument (2741,'La EXACTITUD ['||nuClase||'] es MAYOR a [0,1]'||
                                                         ' recuerde que deben existir 1 SUBIDA y 1 BAJADA.'||
                                                         ' Verifique los datos ingresados en la Legalizaci?n.');
                    END IF;

                    nuDesvCero :=  nuErrorMaxSub/(2 * sqrt(3));

                ELSIF sbSecuenciaExactitud = 'A' THEN

                    --Se obtiene la resta de la bajada 1 menos la subida 1, en el punto cero y esto en valor absoluto.
                    OPEN cuExactitudSub(inuOrderId,nuBaja1,nuSubi1);
                    FETCH cuExactitudSub into nuErrorMaxSub;
                    CLOSE cuExactitudSub;

                    IF nuErrorMaxSub IS NULL THEN
                       ge_boerrors.seterrorcodeargument (2741,'La EXACTITUD ['||nuClase||'] es menor que [0,1],'||
                                                         ' recuerde que deben existir 2 SUBIDAS y 2 BAJADAS.'||
                                                         ' Verifique los datos ingresados en la Legalizaci?n.');
                    END IF;

                    --Se obtiene la resta de la bajada 2 menos la subida 2, en el punto cero y esto en valor absoluto.
                    OPEN cuExactitudBaj(inuOrderId,nuBaja2,nuSubi2);
                    FETCH cuExactitudBaj INTO nuErrorMaxBaj;
                    CLOSE cuExactitudBaj;

                    IF nuErrorMaxBaj IS NULL THEN
                       ge_boerrors.seterrorcodeargument (2741,'La EXACTITUD ['||nuClase||'] es menor que [0,1],'||
                                                         ' recuerde que deben existir 2 SUBIDAS y 2 BAJADAS.'||
                                                         ' Verifique los datos ingresados en la Legalizaci?n.');
                    END IF;

                    IF nuErrorMaxBaj >= nuErrorMaxSub THEN
                        nuDesvCero :=  nuErrorMaxBaj/(2 * sqrt(3));
                    ELSE
                        nuDesvCero :=  nuErrorMaxSub/(2 * sqrt(3));
                    END IF;
                END IF;
          ELSIF nuClase <= 0.6 THEN

                    --Se obtiene la resta de la bajada 1 menos la subida 1, en el punto cero y esto en valor absoluto.
                    OPEN cuExactitudSub(inuOrderId,nuBaja1,nuSubi1);
                    FETCH cuExactitudSub INTO nuErrorMaxSub;
                    CLOSE cuExactitudSub;

                    IF nuErrorMaxSub IS NULL THEN
                       ge_boerrors.seterrorcodeargument (2741,'La EXACTITUD ['||nuClase||'] es menor que [0,6],'||
                                                         ' recuerde que deben existir 1 SUBIDA y 1 BAJADA.'||
                                                         ' Verifique los datos ingresados en la Legalizaci?n.');
                    END IF;

                    --Se obtiene la resta de la bajada 2 menos la subida 2, en el punto cero y esto en valor absoluto.
                    OPEN cuExactitudBaj(inuOrderId,nuBaja2,nuSubi2);
                    FETCH cuExactitudBaj INTO nuErrorMaxBaj;
                    CLOSE cuExactitudBaj;

                    IF nuErrorMaxBaj IS NULL THEN
                       ge_boerrors.seterrorcodeargument (2741,'La EXACTITUD ['||nuClase||'] es menor que [0,6],'||
                                                         ' recuerde que deben existir 1 SUBIDA y 1 BAJADA.'||
                                                         ' Verifique los datos ingresados en la Legalizaci?n.');
                    END IF;

                    IF nuErrorMaxBaj >= nuErrorMaxSub THEN
                        nuDesvCero :=  nuErrorMaxBaj/(2 * sqrt(3));
                    ELSE
                        nuDesvCero :=  nuErrorMaxSub/(2 * sqrt(3));
                    END IF;
              ELSE
                    --Se obtiene la resta de la bajada 1 menos la subida 1, en el punto cero y esto en valor absoluto.
                    OPEN cuMayor(inuOrderId,nuBaja1,nuSubi1);
                    FETCH cuMayor INTO nuErrorMaxSub;
                    CLOSE cuMayor;

                    IF nuErrorMaxSub IS NULL THEN
                       ge_boerrors.seterrorcodeargument (2741,'La EXACTITUD ['||nuClase||'] es mayor que [0,6],'||
                                                         ' recuerde que deben existir 1 SUBIDA y 1 BAJADA.'||
                                                         ' Verifique los datos ingresados en la Legalizaci?n.');
                    END IF;

                    nuDesvCero :=  nuErrorMaxSub/(2 * sqrt(3));
              END IF;

          --RETURN nuDesvCero;
      END IF;

      /*Por definir ???????????????????????????????????????????????????????*/
      /* Se calcual la desv cero , tomando el valor de todas las medidas cuando
        el patron es cero */

      RETURN  nuDesvCero;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetUB_DesvCero',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetUB_DesvCero;


    /*
      Obtiene el promedio de concentraci?n de Gas del Equipo que se calibro,
       es necesario para determinar  la incertidumbre */
    FUNCTION fnugetPromeConcentr
    (
      inuOrderId         in        OR_order.order_id%type
    )return  number
    IS

      nuPlanTemp                 ge_variable_template.variable_template_id%type;
      onuVacecodi                ldc_varicert.vacecodi%type;
      osbVaceVaat                ldc_varicert.vacevaat%type;
      nuVarConcEqui              ldc_variattr.vaatvaat%type;
      nuPromeConc                number;
      --  Variables para manejo de Errores
      exCallService                EXCEPTION;
      sbCallService                varchar2(2000);
      sbErrorMessage               varchar2(2000);
      nuErrorCode                  number;

      -- CURSOR que obtiene el m?ximo  Error entre Sub y bajadas.
      CURSOR cuPromeConcent(inuOrderId     in   OR_order.order_id%type ,
                            nuVarConcEqui  in   ldc_variattr.vaatvaat%type) IS
        select  avg(item_value) PromedioConc
        from  or_order_act_measure
        where ORDER_id = inuOrderId
        AND variable_id IN (nuVarConcEqui);

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetPromeConcentr',8);
      -- Obtiene el Id de la planilla utilizada en el proceso
       nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       ldc_bometrologia.getVacecodiVacevaat(csbConcEquipo ,onuVacecodi,osbVaceVaat)  ;
       nuVarConcEqui := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);

      /*Obtiene el promedio de concentraci?n */
      for exac in cuPromeConcent(inuOrderId,
                                 nuVarConcEqui   ) loop
        nuPromeConc := exac.PromedioConc;
      end loop;
      dbms_output.put_Line('Promedio  = '|| nuPromeConc);

      return  nuPromeConc;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetPromeConcentr',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;


        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetPromeConcentr;


    /*
      Obtiene el promedio de concentraci?n de Gas del patron,
      es necesario para determinar la incertidumbre */
    FUNCTION fnugetPromePatronConc
    (
      inuOrderId         in        OR_order.order_id%type
    )return  number
    IS

      nuPlanTemp                 ge_variable_template.variable_template_id%type;
      onuVacecodi                ldc_varicert.vacecodi%type;
      osbVaceVaat                ldc_varicert.vacevaat%type;
      nuVarConcEqui              ldc_variattr.vaatvaat%type;
      nuPromeConc                number;
      --  Variables para manejo de Errores
      exCallService                EXCEPTION;
      sbCallService                varchar2(2000);
      sbErrorMessage               varchar2(2000);
      nuErrorCode                  number;

      -- CURSOR que obtiene el m?ximo  Error entre Sub y bajadas.
      CURSOR cuPromeConcent(inuOrderId     in   OR_order.order_id%type ,
                            nuVarConcEqui  in   ldc_variattr.vaatvaat%type) IS
        select  avg(pattern_value) PromedioConc
        from  or_order_act_measure
        where ORDER_id = inuOrderId
        AND variable_id IN (nuVarConcEqui);

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetPromePatronConc',8);
      -- Obtiene el Id de la planilla utilizada en el proceso
       nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       ldc_bometrologia.getVacecodiVacevaat(csbConcEquipo ,onuVacecodi,osbVaceVaat)  ;
       nuVarConcEqui := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);

      /*Obtiene el promedio de concentraci?n */
      for exac in cuPromeConcent(inuOrderId,
                                 nuVarConcEqui   ) loop
        nuPromeConc := exac.PromedioConc;
      end loop;
      dbms_output.put_Line('Promedio   = '|| nuPromeConc);

      return  nuPromeConc;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetPromePatronConc',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;


        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetPromePatronConc;


       /*
      Obtiene el promedio del error de cada uno de los puntos tomados en Concentraci?n
        es necesario para determinar  la incertidumbre */
    FUNCTION fnugetPromeErrorConc
    (
      inuOrderId         in        OR_order.order_id%type
    )return  number

    IS

      nuPlanTemp                 ge_variable_template.variable_template_id%type;
      onuVacecodi                ldc_varicert.vacecodi%type;
      osbVaceVaat                ldc_varicert.vacevaat%type;
      nuVarConcEqui              ldc_variattr.vaatvaat%type;
      nuPromeConc                number;
      --  Variables para manejo de Errores
      exCallService                EXCEPTION;
      sbCallService                varchar2(2000);
      sbErrorMessage               varchar2(2000);
      nuErrorCode                  number;

      -- CURSOR que obtiene el m?ximo  Error entre Sub y bajadas.
      CURSOR cuPromeConcent(inuOrderId     in   OR_order.order_id%type ,
                            nuVarConcEqui  in   ldc_variattr.vaatvaat%type) IS
        select  avg(error) PromedioConc
        from  or_order_act_measure
        where ORDER_id = inuOrderId
        AND variable_id IN (nuVarConcEqui);

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetPromePatronConc',8);
      -- Obtiene el Id de la planilla utilizada en el proceso
       nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       ldc_bometrologia.getVacecodiVacevaat(csbConcEquipo ,onuVacecodi,osbVaceVaat)  ;
       nuVarConcEqui := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);

      /*Obtiene el promedio de concentraci?n */
      for exac in cuPromeConcent(inuOrderId,
                                 nuVarConcEqui   ) loop
        nuPromeConc := exac.PromedioConc;
      end loop;
      dbms_output.put_Line('Promedio  error  = '|| nuPromeConc);

      return  nuPromeConc;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetPromePatronConc',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;


        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetPromeErrorConc ;





      /*
      Obtiene la incertidunbre del Patron */
    FUNCTION fngetUB_Patron
    (
      inuOrderId         in        OR_order.order_id%type
    )return  number
    IS

      nuPlanTemp                 ge_variable_template.variable_template_id%type;
      onuVacecodi                ldc_varicert.vacecodi%type;
      osbVaceVaat                ldc_varicert.vacevaat%type;
      nuVarUbPatron              ldc_variattr.vaatvaat%type;
      nuUB_Patron                number;
      sbTipoLab                               varchar2(2000);
      --  Variables para manejo de Errores
      exCallService                EXCEPTION;
      sbCallService                varchar2(2000);
      sbErrorMessage               varchar2(2000);
      nuErrorCode                  number;


    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fngetUB_Patron',8);

      sbTipoLab := fnugetTipoLab(inuOrderId); --FSBGETNOMBRELABORATORIO(inuOrderId); --

      if  sbTipoLab like csbConcentracion||'%' then
          nuUB_Patron:=  convertirDecimal(LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,
                fnuObtValorParametro(csbINCERTIDUMBRE_GAS_PATRON))) ;
      else
         -- Obtiene el Id de la planilla utilizada en el proceso
           nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;

           ldc_bometrologia.getVacecodiVacevaat(csbUbPatron ,onuVacecodi,osbVaceVaat)  ;
           nuVarUbPatron := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);

           nuUB_Patron := convertirDecimal(LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVarUbPatron)) ;
      end if;

      return  nuUB_Patron;

      --.TRACE('Finaliza  LDC_BOmetrologia.fngetUB_Patron',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fngetUB_Patron ;

   /*Obtiene la icnertidumbre tipo A*/
   FUNCTION fnugetUA_Concent
    (
      inuOrderId         in        OR_order.order_id%type
    )return  number
    IS

      nuPlanTemp                 ge_variable_template.variable_template_id%type;
      onuVacecodi                ldc_varicert.vacecodi%type;
      osbVaceVaat                ldc_varicert.vacevaat%type;
      nuVarConcEqui              ldc_variattr.vaatvaat%type;
      nuItemId                   ge_items.items_id%type;
      nuItemSe                   ge_items_seriado.id_items_seriado%type;
      nuUA_Conc                  number;
      --  Variables para manejo de Errores
      exCallService                EXCEPTION;
      sbCallService                varchar2(2000);
      sbErrorMessage               varchar2(2000);
      nuErrorCode                  number;

      -- CURSOR que obtiene el m?ximo  Error entre Sub y bajadas.
      CURSOR cuUA_Concent(inuOrderId     in   OR_order.order_id%type ,
                            nuVarConcEqui  in   ldc_variattr.vaatvaat%type) IS
        select  STDDEV(item_value) UA
        from  or_order_act_measure
        where ORDER_id = inuOrderId
        AND variable_id IN (nuVarConcEqui);


    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetUA_Concent',8);
      -- Obtiene el Id de la planilla utilizada en el proceso
       nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       ldc_bometrologia.getVacecodiVacevaat(csbConcEquipo ,onuVacecodi,osbVaceVaat)  ;
       nuVarConcEqui := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);

       nuItemSe := fnugetItemSeriadOrden(inuOrderId) ;
       nuItemId := dage_items_seriado.fnugetitems_id(nuItemSe) ;

       -- Se verifica que el ITEM sea MULTIGAS
       if nuItemId = fnuObtValorParametro(csbItemIdMultigas) then
            nuVarConcEqui :=  fnuObtValorParametro(csbConcentracionNom1);
       END if;

      /*Obtiene el la desviaci?n estandar de concentraci?n */
      for exac in cuUA_Concent(inuOrderId,
                               nuVarConcEqui   ) loop
        nuUA_Conc := exac.UA;
      end loop;

      dbms_output.put_Line('UA  concentraci?n = '|| nuUA_Conc);

      return  nuUA_Conc;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetUA_Concent',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetUA_Concent ;








    /*Calculando incertidumbre
    Laboratorio de presi?n__

    " PRIMER ESCENARIO:  Si el instrumento es de tipo BOURDON o AN?LOGO
    (Registrado en el sistema como MANOMETRO DE CARATULA)
     Uexp = sqrt(k x UB(Exactitud)? + UB(Repetibilidad)? +UB(Resoluci?n)? + UB(DELTA_h)? +UB (Desv_cero)? + UB(Hist?resis)?)


      sqrt(k x UB(Exactitud)? + UB(Repetibilidad)? +UB(Resoluci?n)? + UB(DELTA_h)? +UB (Desv_cero)? + UB(Reproducibilidad)? )
     SEGUNDO ESCENRIO: "  Si el instrumento es de tipo ELECTRICO
      (Registrado en el sistema como MANOMENTRO DIGITAL o TRANSMISION DE PRESION CON INDICADOR,
       TRANSDUCTOR DE PRESION CORRECTOR)



     Laboratorio Concentraci?n de Gas__

      UExp =  k x sqrt( UA? + UB(Patron)? +UB(Resoluci?n)?



     Laboratorio Tempearatura__

       UExp = K x sqrt( UA? + UB (Patr?n)?  + UB (Medio)?  + UB (Resoluci?n)?  + UB (Hist?resis)?

     */

      /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : fnugetUexp_Incertidumbre
      Descripcion    : Calcula la incertidumbre para el equipo que se esta calibrando

      Autor          : Llozada
      Fecha          : 14/07/2013

      Parametros              Descripcion
      ============         ===================
      inuOrderId           Codigo de la orden

      Historia de Modificaciones
      Fecha             Autor           Modificacion
      =========         =========       ====================
      28-04-2015        Llozada [ARA 6869] Se modifica la lógica para que tome las nuevas formulas de presión.
      16-07-2014        llozada         Se adiciona el calculo de la incertidumbre de Presion para
                                        equipos calibrados con el patrón de Peso Muerto.
    ******************************************************************/
    FUNCTION fnugetUexp_Incertidumbre
    (
      inuOrderId             in         OR_order.order_id%type
     )return  number
    IS
      cnuK                 number;  -- Constante K
      UB_Exactitud         number;
      UB_Repetibilidad     number;
      UB_Histeresis        number;
      UB_Resolucion        number;
      UB_DeltaH1           number;
      UB_DesvCero          number;
      UB_Reproducibilidad  number;
      UB_Exp               number ;
      sbTipoLab            ldc_plantemp.pltelabo%type;
      UB_Patron            number ; -- Valor incertidumbre tipo A
      UA_concet            number ;
      UA_medio             number;
      nuTipoElemento       number;
      nuP_certif           number;
      nuItSeriPatron       number;
      nuRangoFinal         number;
      nuIncerTempMax       number;
      nuAlfa               number;
      nuTempSistema        number;
      nuCoefTermico        number;
      nuIncerGravedad      number;
      nuCoefMecanico       number;
      nuP_Atm              number;
      nuHR                 number;
      nuT_Amb              number;
      nuIncerAire          number;
      nuIncerAceite        number;
      nuCal_Cert           number;
      nuDensidadAire       number;
      nuDifDensidad        number;
      Utemp                number;
      Ualfa                number;
      Ug                   number;
      Ulanda               number;
      Udif_densidad        number;
      Udetg                number;
      UdetAh               number;
      nuPlanTemp           number;
      nuVaceCodi           number;
      onuVacecodi          number;
      nuDifAltura          number;
      nuDensidadAceite     number;
      osbVaceVaat          varchar2(100);
      sbValorMedio         varchar2(200);
      UB_Deriva_Patron     NUMBER;
      nuValDeriva          NUMBER;
      nuMaxDeriva          NUMBER;
      nuResolPat           NUMBER;
      nuFluctPat           NUMBER;
      nuResolInst          NUMBER;
      nuFluctInst          NUMBER;
      UB_Resolucion_Patron NUMBER;

       --  Variables para manejo de Errores
      exCallService        EXCEPTION;
      sbCallService        varchar2(2000);
      sbErrorMessage       varchar2(2000);
      nuErrorCode          number;

    BEGIN

        ----.init;
        ----.setlevel(99);
        ----.setoutput(--.fntrace_output_db);

     --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetUexp_Incertidumbre} ',8);

      -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId); -- FSBGETNOMBRELABORATORIO(inuOrderId); --
      nuTipoElemento := fnugetTipoElemento(inuOrderId);

      -- Obtiene el valor de la constante K
      cnuK := fnuObtValorParametro(csbK);

      -- Formulas para Laboratorio de  Presi?n*
      if sbTipoLab like '%'||csbPresion||'%' then
        --.trace ('Laboratorio de ['||csbPresion||']'||
            --                'Tipo de Laboratorio ['||sbTipoLab||']' ) ;
          UB_Exactitud := fnugetUB_Exactitud(inuOrderId) ;
          ut_trace.trace(' *****-----******-----******* PASO 1. UB_Exactitud valor['|| UB_Exactitud ||']',8) ;
          UB_Repetibilidad := fnugetUB_Repetibilidad(inuOrderId) ;
          ut_trace.trace(' *****-----******-----******* PASO 2. UB_Repetibilidad valor['|| UB_Repetibilidad ||']',8) ;
          UB_Resolucion := fnugetUB_Resolucion(inuOrderId);

          if nuTipoElemento = 1 then --ANALOGO
                UB_Resolucion := UB_Resolucion/sqrt(3);
          else --DIGITAL
                UB_Resolucion := UB_Resolucion/(2*sqrt(3));
          end if;

          ut_trace.trace(' *****-----******-----******* PASO 3. UB_Resolucion valor['|| UB_Resolucion ||']',8) ;
          UB_DeltaH1 := fnugetUB_DeltaH_Sub1(inuOrderId);
          ut_trace.trace(' *****-----******-----******* PASO 4. UB_DeltaH1 valor['|| UB_DeltaH1 ||']',8) ;
          UB_DesvCero := fnugetUB_DesvCero (inuOrderId);
          ut_trace.trace('*****-----******-----******* PASO 5. UB_DesvCero valor['|| UB_DesvCero ||']',8) ;
          /*Si el Instrumento es An?logo
              Uexp = sqrt(k*UB(Exactitud)? + UB(Repetibilidad)? +UB(Resoluci?n)? + UB(DELTA(h))? +UB (Desv_Cero)? + UB(Hist?resis)?) */
          UB_Histeresis := cnu0;  /* se asume cero debido a que las series ascendente y descendente se
                                   reportan por separado y no se reporta un valor promedio para cada punto de calibraci?n. */

          /*Si el instrumento es Digital
             Uexp =  k* sqrt(UB(Exactitud)? + UB(Repetibilidad)? +UB(Resoluci?n)? + UB(DELTA(h))? +UB (Desv_cero)? + UB(Reproducibilidad)?)*/
          UB_Reproducibilidad := cnu0; /*  se asume cero debido a que las condiciones de calibraci?n se mantienen constantes.*/

          /*Por lo anterior, si se revisan las expresiones de incertidumbre definidas en los numerales anteriores
            se puede afirmar que para la estimaci?n de incertidumbre para los instrumentos
            de presi?n se determina a partir de la siguiente expresi?n:
               Uexp =  k  x sqrt(UB(Exactitud)? + UB(Repetibilidad)? +UB(Resoluci?n)? + UB(DELTA(h))? +UB (Desv.cero)?)
          */

          UB_Exp := cnuk* (sqrt(power(UB_Exactitud,2)+ power(UB_Repetibilidad,2)+power(UB_Resolucion,2)
                           + power(UB_DeltaH1,2)+ power(UB_DesvCero,2)));

          --13-04-2015 Llozada: Aplicación de las nuevas fórmulas de presión  [ARA 6869]
          IF LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaGDC(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaGDO(sbNuevasFormulas) THEN

            /*La nueva fórmula de presión es la siguiente:
              Uexp = K * RAIZ_CUADRADA( UB(exact_pat)^2 + UB(deriva_pat)^2 + UB(resol_pat)^2 + UB(dif_altura)^2+
                                        UB(resol_inst)^2 + UB(dev_cero)^2 + UB(repetibilidad)^2 + UB(histeresis)^2 )

              Donde:

              La secuencia se determina de la siguiente manera:

                  Secuencia A : Exactitud Instrumento < 0,1

                  Secuencia B : 0,1 < Exactitud Instrumento < 0,6

                  Secuencia C : Exactitud Instrumento > 0,6

              UB(exact_pat)     = [(exactitud X rango)/100] / RAIZ_CUADRADA(3)
              UB(deriva_pat)    = max_deriva / (2 * RAIZ_CUADRADO(3) ) [El valor de max_deriva se incluye en la legalización]
              UB(resol_pat)     =[ resol_pat + (fluctuacion_pat / 2) ] / ( 2 * RAIZ_CUADRADA(3)) El valor de la fluctuación se
                                                                                                 ingresa en la legalización.
                                                                                                 Para los Pat analogos se divide
                                                                                                 en raiz de 3
              UB(dif_altura)    = ( Pmedio X gravedad X dif_altura ) / RAIZ_CUADRADA(3)  La dif_altura es ingresada en la
                                                                                         legalización
              UB(resol_inst)    = [ resol_inst + (fluct_inst / 2)] / (2 * RAIZ_CUADRADA(3))  El valor de la fluctuación se
                                                                                                 ingresa en la legalización.
                                                                                                 Para los Pat analogos se divide
                                                                                                 en raiz de 3
              UB(desv_cero)     = de acuerdo a la exactitud del instrumento:
                                  Si la secuencia es B y C, entonces:

                                  ABS( X2,0 - X1,0) / (2 * RAIZ_CUADRADA(3))

                                  Si la secuencia es A, entonces:

                                  MAX[ ABS( X2,0 - X1,0) ; ABS( X4,0 - X3,0)] / (2 * RAIZ_CUADRADA(3)) NOTA: Se toman los valores
                                                                                                             del primer punto
              UB(repetibilidad) = Si al secuencia es C, entonces:

                                  CERO

                                  Si la secuencia es B, entonces:

                                  MAX{ ABS(X3,0 - X1,0) ; ABS(X3,1 - X1,1) ; ABS(X3,2 - X1,2) ; ... ABS(X3,j - X1,j)}
                                  / (2 * RAIZ_CUADRADA(3))

                                  Si la secuencia es A, entonces:

                                  MAX {ABS(X3,0) ; ABS(X4,0 - X2,0) ; ABS(X3,1 - X1,1) ; ABS(X4,1 - X2,1) ... ABS(X3,j - X1,j);
                                       ABS(X4,j - X2,j) } / (2 * RAIZ_CUADRADA(3))

               UB(histeresis)   = Si la secuencia es B y C, entonces:

                                  MAX [ ABS( X2,j - X1,J)] / (2 * RAIZ_CUADRADA(3))

                                  Si la secuencia es A, entonces:

                                  [(1/2) * MAX{ABS(X2,j - X1,j) + ABS(X4,j - X3,j)}] / (2 * RAIZ_CUADRADA(3))

                                  Nota: La formula para instrumentos eléctricos es igual debido a que la reproducibilidad es cero
                                  porque el instrumento se monta una sola vez y no se realiza la serie M5 y M6. Según comentario
                                  de Geovanna Calero
              */
              --  Obtiene el Item Patron.
              nuItSeriPatron := LDC_BOmetrologia.fnugetElemntoPatron(inuOrderId);
              nuValDeriva := fnuObtValorParametro(csbMaxDeriva);
              --10-12-2015
              --SAO.358555
              --Mmejia
              --Se modifica para que utilice la funcion  convertirDecimalal convertir una cadena a numero
              --nuMaxDeriva :=to_number(LDC_BOmetrologia.fsbgetValAttribute (nuItSeriPatron,nuValDeriva));
              nuMaxDeriva :=LDC_BOmetrologia.convertirDecimal(LDC_BOmetrologia.fsbgetValAttribute (nuItSeriPatron,nuValDeriva));

              UB_Deriva_Patron := nuMaxDeriva / (2 * SQRT(3));

              nuResolPat := fnugetUB_ResolucionPatron(inuOrderId);
              nuFluctPat := fsbgetValueVariable(inuOrderId, fnuObtValorParametro(csbFluctuacionPatron));

              nuResolInst := fnugetUB_Resolucion(inuOrderId);
              nuFluctInst := fsbgetValueVariable(inuOrderId, fnuObtValorParametro(csbFluctuacionInstrumento));

              /*Instrumento*/
              IF nuTipoElemento = 1 THEN --ANALOGO
                    UB_Resolucion := (nuResolInst + (nuFluctInst / 2)) / SQRT(3);
              ELSE --DIGITAL
                    UB_Resolucion := (nuResolInst + (nuFluctInst / 2)) / (2 * SQRT(3));
              END IF;

              nuTipoElemento := fnugetTipoElementoPatron(inuOrderId);

              /*Patrón*/
              IF nuTipoElemento = 1 THEN --ANALOGO
                    UB_Resolucion_Patron := (nuResolPat + (nuFluctPat / 2)) / SQRT(3);
              ELSE --DIGITAL
                    UB_Resolucion_Patron := (nuResolPat + (nuFluctPat / 2)) / (2 * SQRT(3));
              END IF;

              UB_Histeresis := fnugetUBHisteresis(inuOrderId);

              dbms_output.put_Line('UB_Exactitud: '||UB_Exactitud);
              dbms_output.put_Line('UB_Deriva_Patron: '||UB_Deriva_Patron);
              dbms_output.put_Line('UB_Resolucion_Patron: '||UB_Resolucion_Patron);
              dbms_output.put_Line('UB_DeltaH1: '||UB_DeltaH1);
              dbms_output.put_Line('UB_Resolucion: '||UB_Resolucion);
              dbms_output.put_Line('UB_DesvCero: '||UB_DesvCero);
              dbms_output.put_Line('UB_Repetibilidad: '||UB_Repetibilidad);
              dbms_output.put_Line('UB_Histeresis: '||UB_Histeresis);

              UB_Exp := cnuk * SQRT(POWER(UB_Exactitud,2)     + POWER(UB_Deriva_Patron,2) + POWER(UB_Resolucion_Patron,2) +
                                    POWER(UB_DeltaH1,2)       + POWER(UB_Resolucion,2)    + POWER(UB_DesvCero,2)          +
                                    POWER(UB_Repetibilidad,2) + POWER(UB_Histeresis,2) );
              dbms_output.put_Line('UB_Exp: '||UB_Exp);
          END IF;

          --llozada, 16-07-2014: Incertidumbre para Balanza de Peso Muerto.
          if LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbNombreEntrega)
          or LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbNombreEntrega)
          or LDC_CONFIGURACIONRQ.aplicaParaGDC(sbNombreEntrega)
          or LDC_CONFIGURACIONRQ.aplicaParaGDO(sbNombreEntrega) then
          ut_trace.trace('*****-----******-----******* PASO 6. APLICA PARA GASERA',8) ;
                if dage_items_seriado.fnugetitems_id(LDC_BOmetrologia.fnugetElemntoPatron(inuOrderId)) =
                    dald_parameter.fnuGetNumeric_Value(csbItemPesoMuerto) THEN

                        ut_trace.trace('*****-----******-----******* PASO 6.0 IF PESO MUERTO',8) ;
                        nuPlanTemp      := fnugetIdPlanilla(inuOrderId);
                        ut_trace.trace('*****-----******-----******* PASO 6.1 nuPlanTemp: '||nuPlanTemp,8);
                        ldc_bometrologia.getVacecodiVacevaat(csbDescrMedio ,onuVacecodi,osbVaceVaat);
                        nuVaceCodi      := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);
                        sbValorMedio    := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi);
                        ut_trace.trace('*****-----******-----******* PASO 6.3 sbValorMedio: '||sbValorMedio,8) ;
                        ldc_bometrologia.getVacecodiVacevaat(csbVarDifAltura ,onuVacecodi,osbVaceVaat);
                        nuVaceCodi      := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);
                        ut_trace.trace('*****-----******-----******* PASO 6.4 nuVaceCodi: '||nuVaceCodi,8) ;
                        nuDifAltura     := convertirDecimal(LDC_BOmetrologia.fsbgetValueVariable(inuOrderId ,nuVaceCodi));
                        ut_trace.trace('*****-----******-----******* PASO 6.5 nuDifAltura: '||nuDifAltura,8) ;

                        begin
                            nuDensidadAceite := to_number(substr(sbValorMedio,(instr(sbValorMedio,',')+1)));
                        exception
                            when others then
                                ge_boerrors.seterrorcodeargument(2741,'La DENSIDAD NO esta configurada en el MEDIO.');
                        end;

                        /*nuP_certif        : Incertidumbre por certificado del patron
                          nuAlfa            : Coeficiente Lineal Termico
                          nuIncerTempMax    : Incertidumbre maxima termohigrometro
                          nuT_Amb           : Temperatura ambiente
                          nuCoefMecanico    : Incertidumbre Coeficiente de Presion
                          nuCoefTermico     : Incertidumbre Coeficiente termico
                          nuIncerGravedad   : Incertidumbre por gravedad
                          nuIncerAire       : Incertidumbre densidad aire
                          nuIncerAceite     : INCERTIDUMBRE ACEITE
                          nuCal_Cert        : INCERTIDUMBRE POR CALIBRACI?N DEL CALIBRADOR*/

                        nuP_certif      := fsbgetValueVariable(inuOrderId, fnuObtValorParametro(csbP_Certif));
                        ut_trace.trace('*****-----******-----******* PASO 7. nuP_certif: '||nuP_certif,8) ;
                        nuItSeriPatron  := LDC_BOmetrologia.fnugetElemntoPatron(inuOrderId);
                        nuRangoFinal    := to_number(LDC_BOmetrologia.fsbgetValAttribute(nuItSeriPatron,fnuObtValorParametro(csbRangFinal)));
                        ut_trace.trace('*****-----******-----******* PASO 7.1 nuRangoFinal: '||nuRangoFinal,8) ;
                        nuIncerTempMax  := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbIncerTempMax));
                        ut_trace.trace('*****-----******-----******* PASO 8. nuIncerTempMax: '||nuIncerTempMax,8) ;
                        nuAlfa          := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbAlfa));
                        ut_trace.trace('*****-----******-----******* PASO 9. nuAlfa: '||nuAlfa,8) ;
                        nuCoefTermico   := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbIncerCoefTerm));
                        ut_trace.trace('*****-----******-----******* PASO 10. nuCoefTermico: '||nuCoefTermico,8) ;
                        nuIncerGravedad := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbIncertGravedad));
                        ut_trace.trace('*****-----******-----******* PASO 11. nuIncerGravedad: '||nuIncerGravedad,8) ;
                        nuCoefMecanico  := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbCoefMecanico));
                        ut_trace.trace('*****-----******-----******* PASO 12. nuCoefMecanico: '||nuCoefMecanico,8) ;
                        nuP_Atm         := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbPAtm));
                        ut_trace.trace('*****-----******-----******* PASO 13. nuP_Atm: '||nuP_Atm,8) ;
                        nuHR            := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbHR));
                        ut_trace.trace('*****-----******-----******* PASO 14. nuHR: '||nuHR,8) ;
                        nuT_Amb         := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbTempAmbiente));
                        ut_trace.trace('*****-----******-----******* PASO 15. nuT_Amb: '||nuT_Amb,8) ;
                        nuIncerAire     := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbIncertidumbreAire));
                        ut_trace.trace('*****-----******-----******* PASO 16. nuIncerAire: '||nuIncerAire,8) ;
                        nuIncerAceite   := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbIncertidumbreAceite));
                        ut_trace.trace('*****-----******-----******* PASO 17. nuIncerAceite: '||nuIncerAceite,8) ;
                        nuCal_Cert      := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbIncertidumbreCalibracion));
                        ut_trace.trace('*****-----******-----******* PASO 18. nuCal_Cert: '||nuCal_Cert,8) ;

                        nuDensidadAire  := (cnuK1 * nuP_Atm + nuHR * (cnuK2 * nuT_Amb + cnuK3)) / (nuT_Amb + cnuConstante4);
                        --ut_trace.trace('*****-----******-----******* PASO 19. nuDensidadAire: '||nuDensidadAire,8) ;
                        nuDifDensidad   := nuDensidadAceite - nuDensidadAire;
                        --ut_trace.trace('*****-----******-----******* PASO 20. nuDifDensidad: '||nuDifDensidad,8) ;

                        UB_Patron       := nuP_certif/cnuK;
                        --ut_trace.trace('*****-----******-----******* PASO 21. UB_Patron: '||UB_Patron,8) ;
                        UB_DesvCero     := 0;
                        Utemp           := (cnuConstante2 * nuAlfa * nuRangoFinal) * (nuIncerTempMax / sqrt(3));
                        --ut_trace.trace('*****-----******-----******* PASO 22. Utemp: '||Utemp,8) ;
                        Ualfa           := (cnuConstante2 * nuRangoFinal) * (nuT_Amb - cnuConstante3) * (nuCoefTermico / sqrt(3));
                        --ut_trace.trace('*****-----******-----******* PASO 23. Ualfa: '||Ualfa,8) ;
                        Ug              := ((nuIncerGravedad / sqrt(3)) * (nuRangoFinal / cnug));
                        --ut_trace.trace('*****-----******-----******* PASO 24. Ug: '||Ug,8) ;
                        Ulanda          := (nuCoefMecanico / sqrt(3)) * (- power(nuRangoFinal,2));
                        --ut_trace.trace('*****-----******-----******* PASO 25. Ulanda: '||Ulanda,8) ;
                        Udif_densidad   := (((sqrt(power(nuIncerAire,2) + power(nuIncerAceite,2)))/(sqrt(3))) * cnug * nuDifAltura) * cnuConversionPA;
                        --ut_trace.trace('*****-----******-----******* PASO 26. Udif_densidad: '||Udif_densidad,8) ;
                        Udetg           := ((nuIncerGravedad/sqrt(3)) * (nuDifDensidad * nuDifAltura)) * cnuConversionPA;
                        --ut_trace.trace('*****-----******-----******* PASO 27. Udetg: '||Udetg,8) ;
                        UdetAh          := ((nuCal_Cert/cnuk) * (nuDifDensidad * cnug)) * cnuConversionPA;
                        --ut_trace.trace('*****-----******-----******* PASO 28. UdetAh: '||UdetAh,8) ;

                        UB_Exp := cnuk * (sqrt(power(UB_Patron,2) + power(UB_Resolucion,2) + power(UB_Repetibilidad,2)+
                           + power(UB_DeltaH1,2) + power(UB_DesvCero,2) + power(UB_Histeresis,2) + power(Utemp,2)
                           + power(Ualfa,2) + power(Ug,2) + power(Ulanda,2) + power(Udif_densidad,2)
                           + power(Udetg,2) + power(UdetAh,2) ));
                        --ut_trace.trace('*****-----******-----******* PASO 29. UB_Exp: '||UB_Exp,8) ;
                END IF;
          end if;
       END if;

       -- Formulas para Laboratorio de concentraci?n de Gas*
       if sbTipoLab like '%'||csbConcentracion||'%'  then
         --.trace ('Laboratorio de ['||csbConcentracion||']'||'Tipo de Laboratorio ['||sbTipoLab||']' ) ;

          /* Se puede afirmar que para la estimaci?n de incertidumbre para los instrumentos
            de Concentraci?n de Gas se determina a partir de la siguiente expresi?n:

             UB_Exp = k x sqrt( UA? + UB(Patron)? +UB(Resoluci?n)?  */

           -- Obtiene la incertidumbre tipo A  (UA)
           UA_concet := fnugetUA_Concent(inuOrderId)/sqrt(3);
           -- Obtiene la UB(Patron)

           -- Se realiza este cambio de acuerdo al excel Calibraci?n Detectores CO_Hoja Calculo_V1.xlsx
           -- Calibraci?n Detectores CH4_Hoja Calculo_V1.xlsx
           if upper(fsbgetUnidadMedida(inuOrderId)) like '%CO' then
               -- UB_Patron := (0.02 * fngetUB_Patron(inuOrderId))/2; -- Seg?n las formulas de Excel
               UB_Patron :=  fngetUB_Patron(inuOrderId); --/2;
           else
                UB_Patron := fngetUB_Patron(inuOrderId); --fngetUB_Patron(inuOrderId)/2;
                        --((2* (2*fngetUB_Patron(inuOrderId)/100) )*fngetUB_Patron(inuOrderId)
                          --      /(2*fngetUB_Patron(inuOrderId)/100)) /2;   --Seg?n las formulas de excel
           END if;

           -- Obtiene la  UB(Resoluci?n)
           UB_Resolucion := fnugetUB_Resolucion(inuOrderId);  -- /(2*sqrt(3));

           if nuTipoElemento = 1 then --ANALOGO
                UB_Resolucion := UB_Resolucion/sqrt(3);
           else --DIGITAL
                UB_Resolucion := UB_Resolucion/(2*sqrt(3));
           end if;


            /* UB_Exp = k x sqrt( UA? + UB(Patron)? +UB(Resoluci?n)?  */
           UB_Exp := cnuk* (sqrt(power(UA_concet,2)+ power(UB_Patron,2)+power(UB_Resolucion,2)));

       END if;

       -- Formulas de Laboratorio de Temperatura.
       if sbTipoLab like '%'||csbTemperatura||'%' then
          --.trace ('Laboratorio de ['||csbOrificios||']'||
             --               'Tipo de Laboratorio ['||sbTipoLab||']' ) ;
         -- Obtiene --
         /* UExp = K x sqrt( UA? + UB (Patr?n)?  + UB (Medio)?  + UB (Resoluci?n)?  + UB (Hist?resis)? */

          /* UA_medio := fsbgetValorMedio(inuOrderId);
           -- Obtiene la UB(Patron)
           UB_Patron := fngetUB_Patron(inuOrderId);
           -- Obtiene la  UB(Resoluci?n)
           UB_Resolucion := fnugetUB_Resolucion(inuOrderId);

           UB_Histeresis := cnu0;

            UB_Exp := cnuk* sqrt( power(UB_Patron,2)+power(UA_medio,2)+power(UB_Resolucion,2)+ power(UB_Histeresis,2));
            */
           begin
               select incertidumbre into UB_Exp
               from LDC_FORMTEMP
               where  order_id = inuOrderId
               and rownum < 2;

           exception
                when no_data_found then
                    UB_Exp := 0;
                    ge_boerrors.seterrorcodeargument (2741,'El calculo de la INCERTIDUMBRE devolvió "cero",'||
                                                     ' revisar si se ingresaron correctamente las mediciones.');
           end;

       END if;


    -- Retorna el valor de la incertidumbre
    return UB_Exp;

    --.TRACE('Finaliza  LDC_BOmetrologia.fnugetUexp_Incertidumbre',8);
    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetUexp_Incertidumbre;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fnugetUBHisteresis
    Descripcion : Devuelve el valor para histeresis en el calculo de la incertidumbre

    Autor       : llozada
    Fecha       : 16-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    16-04-2015          llozada [ARA 6869]  Creaci?n.
  **************************************************************************/
    FUNCTION fnugetUBHisteresis
    (
      inuOrderId             in         OR_order.order_id%type
     )
     RETURN  NUMBER
     IS
          nuBaja1                      number;
          nuBaja2                      number;
          nuSubi1                      ldc_variattr.vaatvaat%type;
          nuSubi2                      number;
          nuPlanTemp                   ge_variable_template.variable_template_id%type;
          onuVacecodiB1                ldc_varicert.vacecodi%type;
          onuVacecodiB2                ldc_varicert.vacecodi%type;
          onuVacecodiS1                ldc_varicert.vacecodi%type;
          onuVacecodiS2                ldc_varicert.vacecodi%type;
          osbVaceVaatB1                ldc_varicert.vacevaat%type;
          osbVaceVaatB2                ldc_varicert.vacevaat%type;
          osbVaceVaatS1                ldc_varicert.vacevaat%type;
          osbVaceVaatS2                ldc_varicert.vacevaat%type;
          sbSecuenciaExactitud         VARCHAR2(1);
          nuBajSub1                    NUMBER;
          nuHisteresisMax              NUMBER;
          nuMaxSuma                    NUMBER;
          sbErrorMessage               VARCHAR2(1000);

          CURSOR cuDatos(inuOrderId in number ,
                         nuSub2  in number ,
                         nuSub1  in number)
          IS
                SELECT  MAX(ABS(Sub2.item_value - Sub1.item_value)) maximo
                FROM  or_order_act_measure Sub2, or_order_act_measure Sub1
                WHERE Sub2.ORDER_id = inuOrderId
                AND Sub2.variable_id = nuSub2
                AND Sub1.variable_id = nuSub1
                AND Sub2.order_id = Sub1.order_id
                AND Sub2.measure_number =Sub1.measure_number;

          CURSOR cuMaxSuma(inuOrderId in number ,
                         nuSub1  in number ,
                         nuSub2  in number,
                         nuBaj1  in number ,
                         nuBaj2  in number)
          IS
                SELECT MAX(A.resta + B.resta)
                FROM (
                SELECT  Sub1.measure_number ID,ABS(Baj1.item_value - Sub1.item_value) resta
                FROM  or_order_act_measure Sub1, or_order_act_measure Baj1
                WHERE Sub1.ORDER_id = inuOrderId
                AND Sub1.variable_id = nuSub1
                AND Baj1.variable_id = nuBaj1
                AND Sub1.order_id = Baj1.order_id
                AND Sub1.measure_number =Baj1.measure_number) A ,
                (
                SELECT  Sub2.measure_number ID,ABS(Baj2.item_value - Sub2.item_value) resta
                FROM  or_order_act_measure Sub2, or_order_act_measure Baj2
                WHERE Sub2.ORDER_id = inuOrderId
                AND Sub2.variable_id = nuSub2
                AND Baj2.variable_id = nuBaj2
                AND Sub2.order_id = Baj2.order_id
                AND Sub2.measure_number =Baj2.measure_number) B
                WHERE A.ID = B.ID;
     BEGIN
          -- Obtiene el Id de la planilla utilizada en el proceso
          nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;

          ldc_bometrologia.getVacecodiVacevaat(csbBaja_1 ,onuVacecodiB1,osbVaceVaatB1);
          nuBaja1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiB1,nuPlanTemp);
           /*Obtener el valor de la variable bajada2 */
          ldc_bometrologia.getVacecodiVacevaat(csbBaja_2 ,onuVacecodiB2,osbVaceVaatB2);
          nuBaja2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiB2,nuPlanTemp);

          ldc_bometrologia.getVacecodiVacevaat(csbSubi_1 ,onuVacecodiS1,osbVaceVaatS1);
          nuSubi1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS1,nuPlanTemp);

          ldc_bometrologia.getVacecodiVacevaat(csbSubi_2 ,onuVacecodiS2,osbVaceVaatS2);
          nuSubi2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS2,nuPlanTemp);

          sbSecuenciaExactitud := fsbgetSecuenciaExactitud(inuOrderId);

          IF sbSecuenciaExactitud in ('B','C') THEN
                OPEN cuDatos(inuOrderId,nuBaja1,nuSubi1);
                FETCH cuDatos INTO nuBajSub1;
                CLOSE cuDatos;

                IF nuBajSub1 IS NOT NULL THEN
                    nuHisteresisMax := nuBajSub1 / (2 * SQRT(3));
                END IF;
          ELSIF sbSecuenciaExactitud = 'A' THEN
                OPEN cuMaxSuma(inuOrderId,nuSubi1,nuSubi2,nuBaja1,nuBaja2);
                FETCH cuMaxSuma INTO nuMaxSuma;
                CLOSE cuMaxSuma;

                IF nuMaxSuma IS NOT NULL THEN
                    nuHisteresisMax := ((1 / 2) * nuMaxSuma) / (2 * SQRT(3));
                ELSE
                    ge_boerrors.seterrorcodeargument (2741,'La EXACTITUD es menor que [0,1],'||
                                                         ' recuerde que deben existir 2 SUBIDAS y 2 BAJADAS.'||
                                                         ' Verifique los datos ingresados en la Legalizaci?n.');
                END IF;
          END IF;

          RETURN nuHisteresisMax;

     EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
           RAISE ex.CONTROLLED_ERROR;
        WHEN LOGIN_DENIED or pkConstante.exERROR_LEVEL2 THEN
           pkErrors.pop;
           RAISE;
        WHEN OTHERS THEN
           pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
         pkErrors.pop;
         raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);
     END fnugetUBHisteresis;

    FUNCTION fnugetIncertidumbre_AJ
    (
      inuOrderId             in         OR_order.order_id%type
     )return  number
     IS
            nuOrderAj   OR_order.order_id%type;
     BEGIN
             -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

        if nuOrderAj > 0 then
            return ldc_bometrologia.fnugetUexp_Incertidumbre(nuOrderAj);
        else
            return 0;
        END if;

     END fnugetIncertidumbre_AJ;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbgetIncertidumbreConver
    Descripcion : Devuelve la equivalencia para la incertidumbre

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    15-07-2015          Llozada            Se comenta la condición que valida la unidad de medida
                                           para PRESION
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbgetIncertidumbreConver(inuOrderId         in        OR_order.order_id%type)
    return varchar2
    IS
        nuIncertidumbre  number;
        sbConversion        varchar2(100) := null;
        sbTipoLab           varchar2(100);
        nuFactorConver      number;
        sbUnidadEquiv       varchar2(2000);
    BEGIN
        nuIncertidumbre := fnugetUexp_Incertidumbre(inuOrderId);
        nuFactorConver  := fnuGetFactorConversion(inuOrderId);
        -- Obtiene la unidad de medida equivalente
        sbUnidadEquiv      := fsbgetUnidadEquiv(inuOrderId);

        -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId);  --FSBGETNOMBRELABORATORIO(inuOrderId);
      ----.TRACE('[METROLOGIA] {LDC_BOmetrologia.fsbgetDescrMedio} sbTipoLab: '||sbTipoLab,8);
     -- --.TRACE('---- [METROLOGIA]  sbRangoMedicion: '||sbRangoMedicion,8);

      IF sbTipoLab like '%'||csbPresion||'%' THEN
          --if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%PSI%' then
          --   sbConversion := '( +/- '||to_char((to_number(nuIncertidumbre) * 6.8949),'999G999990D00')||' kPa)';
          --elsif upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%H2%' then
          sbConversion := '( +/- '||to_char((to_number(nuIncertidumbre) * nuFactorConver),'999G999990D00')||' '||sbUnidadEquiv||')';
          --END if;

          sbConversion := REGEXP_REPLACE(sbConversion, '  *', ' ');
      elsif sbTipoLab like '%'||csbTemperatura||'%' then
          if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%F%' then
               sbConversion := '( +/- '||to_char(((to_number(nuIncertidumbre) - 32)*(5/9)),'999G999990D00')||' '||replace(upper(fsbgetUnidadMedida(inuOrderId)),'F','C')||')';
          END if;

          sbConversion := REGEXP_REPLACE(sbConversion, '  *', ' ');
      END if;

      return sbConversion;

    END fsbgetIncertidumbreConver;

    /*OBTIENE la diferencia m?xima entre
    P(Instrumento) - P(Patr?n) = Diferencia m?xima
    La formula debe aplicarse a cada uno de los registros del resultado de
     la calibraci?n y de estos valores obtener el mayor.

     Obtener el mayor valor absoluto entre los Errores de subida, Errores de bajada

    -- Se corrige error en la formula  TS 2369
   */
    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fnugetDiferenciaMax
    Descripcion : Devuelve el valor para la diferencia máxima

    Autor       : llozada
    Fecha       : 16-04-2013

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    28-04-2015          Llozada [ARA 6869] Se modifica la lógica para que tome las nuevas formulas
                                           para presión.
    16-04-2013          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fnugetDiferenciaMax
    (
      inuOrderId         in        OR_order.order_id%type
    )return  number
    IS

      sbValorMedio                 OR_order_act_var_det.value%TYPE ;
      sbDescMedio                  OR_order_act_var_det.value%TYPE ;
      nuPlanTemp                   ge_variable_template.variable_template_id%type;
      onuVacecodiB1                ldc_varicert.vacecodi%type;
      osbVaceVaatB1                ldc_varicert.vacevaat%type;
      onuVacecodiB2                ldc_varicert.vacecodi%type;
      osbVaceVaatB2                ldc_varicert.vacevaat%type;
      onuVacecodiS1                ldc_varicert.vacecodi%type;
      onuVacecodiS2                ldc_varicert.vacecodi%type;
      osbVaceVaatS1                ldc_varicert.vacevaat%type;
      osbVaceVaatS2                ldc_varicert.vacevaat%type;
      nuDensidadMedio              number;
      nuBaja1                      number;
      nuBaja2                      number;
      nuSubi1                      ldc_variattr.vaatvaat%type;
      nuSubi2                      number;
      nuDensidadMedio              number;
      nuErrorMaxBaj                number;
      nuErrorMaxSub                number;
      nuErrorMinBaj                number;
      nuErrorMaxSub2                number;
      nuErrorMinSub2                number;
      nuErrorMinSub                number;
      sbTipoLab                         ldc_plantemp.pltelabo%type;
      nuClase                       number;
      nuOrderAj                    number;
      sbSecuenciaExactitud         VARCHAR2(1);

      --  Variables para manejo de Errores
      exCallService                EXCEPTION;
      sbCallService                varchar2(2000);
      sbErrorMessage               varchar2(2000);
      nuErrorCode                  number;

      -- CURSOR que obtiene el m?ximo  Error entre Sub y bajadas.
        CURSOR cuErrorBaj1(inuOrderId in number ,
                         nuBaja1  in number ,
                         nuBaja2  in number  ) IS
        select  max(item_value - pattern_value),min(item_value - pattern_value)
        from  or_order_act_measure
        where ORDER_id = inuOrderId
        AND variable_id IN ( nuBaja1, nuBaja2);

        CURSOR cuErrorSub1(inuOrderId in number ,
                         nuSubi1  in number ,
                         nuSubi2  in number) IS
        select  max(item_value - pattern_value),min(item_value - pattern_value)
        from  or_order_act_measure
        where ORDER_id = inuOrderId
        AND variable_id IN (nuSubi1,nuSubi2);


        -- Se corrige calculo de Exactitud TS 2369
        cursor cuExactitudSub(inuOrderId in number ,
                         nuSubi1  in number ,
                         nuSubi2  in number) IS
        select  max(((a.item_value + b.item_value)/2) - a.pattern_value),
                min(((a.item_value + b.item_value)/2) - a.pattern_value)
        from  or_order_act_measure a, or_order_act_measure b
        where a.ORDER_id = inuOrderId
        AND a.variable_id = nuSubi1
        and b.variable_id = nuSubi2
        and a.order_id = b.order_id
        and a.pattern_value = b.pattern_value;

        -- Se corrige calculo de Exactitud TS 2369
        cursor cuExactitudBaj(inuOrderId in number ,
                         nuBaja1  in number ,
                         nuBaja2  in number  ) IS
        select  max(((a.item_value + b.item_value)/2) - a.pattern_value),
                min(((a.item_value + b.item_value)/2) - a.pattern_value)
        from  or_order_act_measure a, or_order_act_measure b
        where a.ORDER_id = inuOrderId
        AND a.variable_id = nuBaja1
        and b.variable_id = nuBaja2
        and a.order_id = b.order_id
        and a.pattern_value = b.pattern_value;

        cursor cuExactitudMayorSub(inuOrderId in number ,
                         nuSubi1  in number) IS
        select  max(item_value - pattern_value),min(item_value - pattern_value)
        from  or_order_act_measure
        where ORDER_id = inuOrderId
        AND variable_id IN (nuSubi1);

        cursor cuExactitudMayorBaj(inuOrderId in number ,
                         nuBaja1  in number) IS
        select  max(item_value - pattern_value), min(item_value - pattern_value)
        from  or_order_act_measure
        where ORDER_id = inuOrderId
        AND variable_id IN (nuBaja1);

        CURSOR cuErrorSeqA(inuOrderId in number,
                           nuBaja1  in number ,
                           nuBaja2  in number,
                           nuSubi1  in number ,
                           nuSubi2  in number )
        IS
             SELECT MAX(((((sub1.item_value + subida_2.item_value)/2) + ((baja1.item_value + baja2.item_value)/2))/2) - baja1.pattern_value),
                    MIN(((((sub1.item_value + subida_2.item_value)/2) + ((baja1.item_value + baja2.item_value)/2))/2) - baja1.pattern_value)
             FROM open.OR_order_act_measure  baja1 , --ob1
             open.OR_order_act_measure baja2, --ob2,
             open.OR_order_act_measure sub1 --os1
             left join
             open.OR_order_act_measure subida_2
             ON sub1.pattern_value = subida_2.pattern_value
              and subida_2.variable_id = nuSubi2
               and sub1.order_id = subida_2.order_id
             WHERE  baja1.Order_id = inuOrderId
              AND baja1.variable_id = nuBaja1
             AND baja2.variable_id = nuBaja2
             AND sub1.variable_id = nuSubi1
             and baja1.pattern_value = baja2.pattern_value
             AND baja2.pattern_value = sub1.pattern_value
             AND baja1.order_id = baja2.order_id
             AND baja2.order_id = sub1.order_id;

       CURSOR cuErrorSeqB(inuOrderId in number,
                           nuBaja1  in number ,
                           nuSubi1  in number ,
                           nuSubi2  in number )
        IS
             SELECT MAX(((((sub1.item_value + subida_2.item_value)/2) + baja1.item_value)/2) - baja1.pattern_value),
                    MIN(((((sub1.item_value + subida_2.item_value)/2) + baja1.item_value)/2) - baja1.pattern_value)
             FROM open.OR_order_act_measure  baja1 , --ob1
             open.OR_order_act_measure sub1 --os1
             left join
             open.OR_order_act_measure subida_2
             ON sub1.pattern_value = subida_2.pattern_value
              and subida_2.variable_id = nuSubi2
               and sub1.order_id = subida_2.order_id
             WHERE  baja1.Order_id = inuOrderId
              AND baja1.variable_id = nuBaja1
              AND sub1.variable_id = nuSubi1
              and baja1.pattern_value = sub1.pattern_value
             AND baja1.order_id = sub1.order_id;

         CURSOR cuErrorSeqC(inuOrderId in number ,
                         nuSubi1  in number,
                         nuBaja1  in number
                           )
         IS
            select  MAX(((subi1.item_value + baja1.item_value)/2) - baja1.pattern_value),
                    MIN(((subi1.item_value + baja1.item_value)/2) - baja1.pattern_value)
            from  or_order_act_measure baja1, --a
                  or_order_act_measure subi1 --b
            where baja1.ORDER_id = inuOrderId
            AND baja1.variable_id = nuBaja1
            and subi1.variable_id = nuSubi1
            and baja1.order_id = subi1.order_id
            and baja1.pattern_value = subi1.pattern_value;


        /*CURSOR cuPlanchas(inuOrderId in number ,
                         nuBaja1  in number)
        IS
            select  avg(item_value - pattern_value)
            from  or_order_act_measure
            where ORDER_id = inuOrderId
            AND variable_id = nuPunto;*/

    BEGIN

        ----.init;
        ----.setlevel(99);
        ----.setoutput(--.fntrace_output_db);

      --.TRACE('[METROLOGIA] Inicia  LDC_BOmetrologia.fnugetDiferenciaMax',8);
      -- Obtiene el Id de la planilla utilizada en el proceso
      nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;

      -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId);  --FSBGETNOMBRELABORATORIO(inuOrderId);
      --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetDiferenciaMax} sbTipoLab: '||sbTipoLab,8);

      nuClase:= fsbgetExactitudElement(inuOrderId);
      --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetDiferenciaMax} nuClase: '||nuClase,8);

      ldc_bometrologia.getVacecodiVacevaat(csbBaja_1 ,onuVacecodiB1,osbVaceVaatB1)  ;
      nuBaja1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiB1,nuPlanTemp);
       /*Obtener el valor de la variable bajada2 */
      ldc_bometrologia.getVacecodiVacevaat(csbBaja_2 ,onuVacecodiB2,osbVaceVaatB1)  ;
      nuBaja2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiB2,nuPlanTemp);

      ldc_bometrologia.getVacecodiVacevaat(csbSubi_1 ,onuVacecodiS1,osbVaceVaatS2)  ;
      nuSubi1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS1,nuPlanTemp);

      ldc_bometrologia.getVacecodiVacevaat(csbSubi_2 ,onuVacecodiS2,osbVaceVaatS2);
      nuSubi2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS2,nuPlanTemp);

      IF sbTipoLab like '%'||csbPresion||'%' then  -- PRESION
                  --13-04-2015 Llozada: Aplicación de las nuevas fórmulas de presión  [ARA 6869]
          IF LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaGDC(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaGDO(sbNuevasFormulas) THEN
                sbSecuenciaExactitud := fsbgetSecuenciaExactitud(inuOrderId);
                 IF sbSecuenciaExactitud = 'A' THEN
                    OPEN cuErrorSeqA(inuOrderId,nuBaja1,nuBaja2,nuSubi1,nuSubi2);
                    FETCH cuErrorSeqA INTO nuErrorMaxSub, nuErrorMaxBaj;
                    CLOSE cuErrorSeqA;
                 ELSIF sbSecuenciaExactitud = 'B' THEN
                    OPEN cuErrorSeqB(inuOrderId,nuBaja1,nuSubi1,nuSubi2);
                    FETCH cuErrorSeqB INTO nuErrorMaxSub,nuErrorMaxBaj;
                    CLOSE cuErrorSeqB;
                 ELSE
                    OPEN cuErrorSeqC(inuOrderId,nuSubi1,nuBaja1);
                    FETCH cuErrorSeqC INTO nuErrorMaxSub,nuErrorMaxBaj;
                    CLOSE cuErrorSeqC;
                 END IF;

            ELSIF nuClase <= 0.6 THEN
                --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetDiferenciaMax} EXACTITUD < 06',8);

                open cuExactitudSub(inuOrderId,nuSubi1,nuSubi2);
                fetch cuExactitudSub INTO nuErrorMaxSub, nuErrorMinSub;
                close cuExactitudSub;

                if nuErrorMaxSub is null then
                   ge_boerrors.seterrorcodeargument (2741,'La EXACTITUD ['||nuClase||'] es menor que [0,6],'||
                                                     ' recuerde que deben existir 2 SUBIDAS y 2 BAJADAS ya que la '||
                                                     'f?rmula es la siguiente MAX(((SUBIDA_1 + SUBIDA_2)/2) - PATRON,((BAJADA_1 + BAJADA_2)/2) - PATRON).'||
                                                     ' Verifique los datos ingresados en la Legalizaci?n.');
                end if;

                if abs(nuErrorMinSub) > nuErrorMaxSub then
                        nuErrorMaxSub := nuErrorMinSub;
                  end if;

                --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetDiferenciaMax} [EXACTITUD < 06] nuErrorMaxSub: '||nuErrorMaxSub,8);

                open cuExactitudBaj(inuOrderId,nuBaja1,nuBaja2);
                fetch cuExactitudBaj INTO nuErrorMaxBaj,nuErrorMinBaj;
                close cuExactitudBaj;

                if nuErrorMaxBaj is null then
                   ge_boerrors.seterrorcodeargument (2741,'La EXACTITUD ['||nuClase||'] es menor que [0,6],'||
                                                     ' recuerde que deben existir 2 SUBIDAS y 2 BAJADAS ya que la '||
                                                     'f?rmula es la siguiente MAX(((SUBIDA_1 + SUBIDA_2)/2) - PATRON,((BAJADA_1 + BAJADA_2)/2) - PATRON).'||
                                                     ' Verifique los datos ingresados en la Legalizaci?n.');
                end if;

                if abs(nuErrorMinBaj) > nuErrorMaxBaj then
                        nuErrorMaxBaj := nuErrorMinBaj;
                  end if;

                --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetDiferenciaMax} [EXACTITUD < 06] nuErrorMaxBaj: '||nuErrorMaxBaj,8);
             else
                --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetDiferenciaMax} EXACTITUD > 06',8);
                 open cuExactitudMayorBaj(inuOrderId,nuBaja1);
                  fetch cuExactitudMayorBaj INTO nuErrorMaxBaj,nuErrorMinBaj;
                  close cuExactitudMayorBaj;

                   if nuErrorMaxBaj is null or nuErrorMinBaj is null then
                       ge_boerrors.seterrorcodeargument (2741,'La EXACTITUD ['||nuClase||'] es menor que [0,6],'||
                                                         ' recuerde que debe existir 1 SUBIDA y 1 BAJADA ya que la '||
                                                         'f?rmula es la siguiente MAX(SUBIDA_1 - PATRON, BAJADA_1 - PATRON).'||
                                                         ' Verifique los datos ingresados en la Legalizaci?n.');
                    end if;

                  if abs(nuErrorMinBaj) > nuErrorMaxBaj then
                        nuErrorMaxBaj := nuErrorMinBaj;
                  end if;

                  --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetDiferenciaMax} [EXACTITUD > 06] nuErrorMaxBaj: '||nuErrorMaxBaj,8);

                  open cuExactitudMayorSub(inuOrderId,nuSubi1);
                  fetch cuExactitudMayorSub INTO nuErrorMaxSub,nuErrorMinSub;
                  close cuExactitudMayorSub;

                   if nuErrorMaxSub is null or nuErrorMinSub is null then
                       ge_boerrors.seterrorcodeargument (2741,'La EXACTITUD ['||nuClase||'] es menor que [0,6],'||
                                                         ' recuerde que debe existir 1 SUBIDA y 1 BAJADA ya que la '||
                                                         'f?rmula es la siguiente MAX(SUBIDA_1 - PATRON, BAJADA_1 - PATRON).'||
                                                         ' Verifique los datos ingresados en la Legalizaci?n.');
                    end if;

                  if abs(nuErrorMinSub) > nuErrorMaxSub then
                        nuErrorMaxSub := nuErrorMinSub;
                end if;
             END IF;

      -- FIN PRESION
      ELSIF sbTipoLab like '%'||csbConcentracion||'%' then -- CONCENTRACION DE GAS
            --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetDiferenciaMax} CONCENTRACION GAS',8);

            open cuExactitudMayorSub(inuOrderId,fnuObtValorParametro(csbSubConcentracion));
              fetch cuExactitudMayorSub INTO nuErrorMaxSub,nuErrorMinSub;
              close cuExactitudMayorSub;

               if nuErrorMaxSub is null then
                   ge_boerrors.seterrorcodeargument (2741,'No se encontraron resultados para el instrumento.'||
                                                     ' Verifique los datos ingresados en la Legalizaci?n.');
                end if;

              if abs(nuErrorMinSub) > nuErrorMaxSub then
                    nuErrorMaxSub := nuErrorMinSub;
              end if;

              /*29-01-2015 Llozada: Se debe calcular también el error máximo del segundo gas y retornar el mayor*/
              open cuExactitudMayorSub(inuOrderId,fnuObtValorParametro(csbConcentracionNom2));
              fetch cuExactitudMayorSub INTO nuErrorMaxSub2,nuErrorMinSub2;
              close cuExactitudMayorSub;

              /*29-01-2015 Llozada: Se debe calcular también el error máximo del segundo gas y retornar el mayor*/
              if nuErrorMaxSub2 is not null then
                  if abs(nuErrorMinSub2) > nuErrorMaxSub2 then
                        nuErrorMaxSub2 := nuErrorMinSub2;
                  end if;

                  if abs(nuErrorMaxSub2) > nuErrorMaxSub then
                      nuErrorMaxSub := nuErrorMaxSub2;
                  end if;
              end if;


            --.TRACE('[METROLOGIA] [CONCENTRACION] nuErrorMaxSub: '||nuErrorMaxSub,8);
            return  nuErrorMaxSub;
      -- FIN CONCENTRACION DE GAS
      ELSIF sbTipoLab like '%'||csbTemperatura||'%' then -- TEMPERATURA
            --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetDiferenciaMax} TEMPERATURA',8);

           select max(abs(errorindicacion)) into nuErrorMaxSub
           from LDC_FORMTEMP
           where  order_id = inuOrderId;

           --.TRACE('[METROLOGIA] [TEMPERATURA] nuErrorMaxSub: '||nuErrorMaxSub,8);
            return  nuErrorMaxSub;
      -- FIN TEMPERATURA
      ELSIF sbTipoLab like csbPlanchas||'%' then --PLANCHAS
         -- Valida si el Certificado tiene una orden de ajuste
         nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

         if nuOrderAj > 0 then
            return fnuGetPromedioPlancha(nuOrderAj);
         else
            return fnuGetPromedioPlancha(inuOrderId);
         end if;
      END IF;

      /*Obtiene la diferencia m?xima */
      /*for exac in cuErrorSub1(inuOrderId,
                         nuBaja1  ,
                         nuBaja2  ,
                         nuSubi1  ,
                         nuSubi2 ) loop
        nuErrorMax := exac.MaxError;
      end loop;*/

      --.TRACE('nuErrorMaxBaj: '||nuErrorMaxBaj||', nuErrorMaxSub'||nuErrorMaxSub,8);

      if abs(nuErrorMaxBaj) >= abs(nuErrorMaxSub) then
        --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetDiferenciaMax} MAYOR nuErrorMaxBaj: '||nuErrorMaxBaj,8);
        return  nuErrorMaxBaj;
      else
        --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetDiferenciaMax} MAYOR nuErrorMaxSub: '||nuErrorMaxSub,8);
        return  nuErrorMaxSub;
      end if;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetDiferenciaMax',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;


        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetDiferenciaMax;

    FUNCTION fnugetDifMaxAjuste(inuOrderId  in  OR_order.order_id%type)
    return number
    IS
        nuOrderAj   OR_order.order_id%type;
    BEGIN
        -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

        if nuOrderAj > 0 then
            return ldc_bometrologia.fnugetDiferenciaMax(nuOrderAj);
        else
            return 0;
        END if;
    END fnugetDifMaxAjuste;

    -- funcion Devuelve la diferencia maxima convertida a la unidad de equivalencia
  /*30-04-2015 Llozada: Se elimina la validación de la unidad de medida.*/
    FUNCTION fnugetDifMaxConversion(inuOrderId  in  OR_order.order_id%type)
    return number
    IS
        nuConversion        varchar2(100) := null;
        sbTipoLab           varchar2(100);
        nuDiferenciaMaxima  number;
        nuFactorConver      number;

    BEGIN
        nuDiferenciaMaxima  := fnugetDiferenciaMax(inuOrderId);
        nuFactorConver      := fnuGetFactorConversion(inuOrderId);

        -- Obtiene el tipo de Laboratorio
        sbTipoLab := fnugetTipoLab (inuOrderId); --FSBGETNOMBRELABORATORIO(inuOrderId);
        ----.TRACE('[METROLOGIA] {LDC_BOmetrologia.fsbgetDescrMedio} sbTipoLab: '||sbTipoLab,8);
        -- --.TRACE('---- [METROLOGIA]  sbRangoMedicion: '||sbRangoMedicion,8);

        IF sbTipoLab like '%'||csbPresion||'%' THEN
            --if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%PSI%' then
                --sbConversion := '('||to_char((to_number(nuDiferenciaMaxima) * 6.8949),'999G999990D00')||' kPa)';
            nuConversion := nuDiferenciaMaxima * nuFactorConver;

            --elsif upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%H2%' then
                --sbConversion := '('||to_char((to_number(nuDiferenciaMaxima) * 0.2491),'999G999990D00')||' kPa)';
                --nuConversion := nuDiferenciaMaxima * nuFactorConver;
            --END if;

            --sbConversion := REGEXP_REPLACE(sbConversion, '  *', ' ');
        ELSIF sbTipoLab like '%'||csbTemperatura||'%' then
            if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%F%' then
                --sbConversion := '('||to_char(((to_number(nuDiferenciaMaxima) - 32)*(5/9)),'999G999990D00')||' '||replace(upper(fsbgetUnidadMedida(inuOrderId)),'F','C')||')';
                --sbConversion := REGEXP_REPLACE(sbConversion, '  *', ' ');
                nuConversion := (nuDiferenciaMaxima - 32)*(5/9);
            END if;
        END if;

        return nuConversion;

    END fnugetDifMaxConversion;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fnugetDifMaxConver_Ajus
    Descripcion : Funcion que retorna la diferencia maxima de una orden de ajuste,
                  convertida a la unidad de equivalencia

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    15-07-2015          Llozada            Se comenta la condición que valida la unidad de medida
                                           para PRESION
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fnugetDifMaxConver_Ajus(inuOrderId in  OR_order.order_id%type)
    return number
    IS
        nuDiferenciaMaxima  number;
        nuFactorConver      number;
        nuConversion        varchar2(100) := null;
        sbTipoLab           varchar2(100);
        nuOrderAj           OR_order.order_id%type;

    BEGIN
         -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj       := ldc_bometrologia.valCertAjuste(inuOrderId);
        nuFactorConver  := fnuGetFactorConversion(inuOrderId);

        IF nuOrderAj > 0 then
            nuDiferenciaMaxima := ldc_bometrologia.fnugetDiferenciaMax(nuOrderAj);

            -- Obtiene el tipo de Laboratorio
            sbTipoLab := fnugetTipoLab (inuOrderId); --FSBGETNOMBRELABORATORIO(nuOrderAj); --
            ----.TRACE('[METROLOGIA] {LDC_BOmetrologia.fsbgetDescrMedio} sbTipoLab: '||sbTipoLab,8);
            -- --.TRACE('---- [METROLOGIA]  sbRangoMedicion: '||sbRangoMedicion,8);

            IF sbTipoLab like '%'||csbPresion||'%' THEN
                --if upper(fsbgetUnidadMedida(nuOrderAj)) LIKE '%PSI%' then
                    --sbConversion := '('||to_char((to_number(nuDiferenciaMaxima) * 6.8949),'999G999990D00')||' kPa)';
                --    nuConversion := nuDiferenciaMaxima * nuFactorConver;

                --elsif upper(fsbgetUnidadMedida(nuOrderAj)) LIKE '%H2%' then
                    --sbConversion := '('||to_char((to_number(nuDiferenciaMaxima) * 0.2491),'999G999990D00')||' kPa)';
                nuConversion := nuDiferenciaMaxima * nuFactorConver;
                --end if;
                    --sbConversion := REGEXP_REPLACE(sbConversion, '  *', ' ');
            ELSIF sbTipoLab like '%'||csbTemperatura||'%' then
                if upper(fsbgetUnidadMedida(nuOrderAj)) LIKE '%F%' then
                    --sbConversion := '('||to_char(((to_number(nuDiferenciaMaxima) - 32)*(5/9)),'999G999990D00')||' '||replace(upper(fsbgetUnidadMedida(inuOrderId)),'F','C')||')';
                    nuConversion := (nuDiferenciaMaxima - 32)*(5/9);
                    --sbConversion := REGEXP_REPLACE(sbConversion, '  *', ' ');
                end if;
            END if;

            return nuConversion;

        ELSE
            return 0;
        END if;

    END fnugetDifMaxConver_Ajus;

   /*    Obtener el mayor valor absoluto entre los Errores de subida, Errores de bajada
   */
    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fnugetHisteresisMax
    Descripcion : Devuelve el valor para la histeresis máxima

    Autor       : llozada
    Fecha       : 16-04-2013

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    28-04-2015          Llozada [ARA 6869] Se modifica la lógica para que tome las nuevas formulas
                                           para presión.
    16-04-2013          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fnugetHisteresisMax
    (
      inuOrderId         in        OR_order.order_id%type
    )return  number
    IS
      nuPlanTemp                   ge_variable_template.variable_template_id%type;
      onuVacecodiB1                ldc_varicert.vacecodi%type;
      osbVaceVaatB1                ldc_varicert.vacevaat%type;
      onuVacecodiS1                ldc_varicert.vacecodi%type;
      osbVaceVaatS1                ldc_varicert.vacevaat%type;
      onuVacecodiB2                ldc_varicert.vacecodi%type;
      osbVaceVaatB2                ldc_varicert.vacevaat%type;
      onuVacecodiS2                ldc_varicert.vacecodi%type;
      osbVaceVaatS2                ldc_varicert.vacevaat%type;
      nuDensidadMedio              number;
      nuBaja1                      number;
      nuSubi1                      number;
    nuSubi2                      number;
    nuBaja2                      number;
      nuErrorMax                   number;
    nuErrorMax_2                 number;
    sbTipoLab                    ldc_plantemp.pltelabo%type;
    nuClase                           number;
    sbSecuenciaExactitud         VARCHAR2(1);

      --  Variables para manejo de Errores
      exCallService                EXCEPTION;
      sbCallService                varchar2(2000);
      sbErrorMessage               varchar2(2000);
      nuErrorCode                  number;

      -- CURSOR que obtiene la Histeresis  M?xima entre las Subidas 1 y Bajadas 1.
      CURSOR cuErrorSub1(inuOrderId in number ,
                         nuBaja1  in number ,
                         nuSubi1  in number ) IS
        select  max( abs(b.item_value - a.item_value)) histeresis
        from  or_order_act_measure a, or_order_act_measure b
        where a.ORDER_id = inuOrderId
        AND a.order_id = b.order_id
        and a.pattern_value = b.pattern_value
        and a.variable_id = nuSubi1  --subida
        and b.variable_id = nuBaja1;  --bajada

          -- CURSOR que obtiene la Histeresis  M?xima entre las Subidas 2 y Bajadas 2.
      CURSOR cuErrorSub2(inuOrderId in number ,
                         nuBaja2  in number ,
                         nuSubi2  in number ) IS
        select  max(abs(b.item_value - a.item_value)) histeresis
        from  or_order_act_measure a, or_order_act_measure b
        where a.ORDER_id = inuOrderId
        AND a.order_id = b.order_id
        and a.pattern_value = b.pattern_value
        and a.variable_id = nuSubi2  --subida 2
        and b.variable_id = nuBaja2;  --bajada 2

      CURSOR cuErrorSeqA(inuOrderId in number,
                           nuBaja1  in number ,
                           nuBaja2  in number,
                           nuSubi1  in number ,
                           nuSubi2  in number )
        IS
             SELECT MAX(ABS(((baja1.item_value + baja2.item_value)/2) - ((sub1.item_value + subida_2.item_value)/2)))
             FROM open.OR_order_act_measure  baja1 , --ob1
             open.OR_order_act_measure baja2, --ob2,
             open.OR_order_act_measure sub1 --os1
             left join
             open.OR_order_act_measure subida_2
             ON sub1.pattern_value = subida_2.pattern_value
              and subida_2.variable_id = nuSubi2
               and sub1.order_id = subida_2.order_id
             WHERE  baja1.Order_id = inuOrderId
              AND baja1.variable_id = nuBaja1
             AND baja2.variable_id = nuBaja2
             AND sub1.variable_id = nuSubi1
             and baja1.pattern_value = baja2.pattern_value
             AND baja2.pattern_value = sub1.pattern_value
             AND baja1.order_id = baja2.order_id
             AND baja2.order_id = sub1.order_id;

        CURSOR cuErrorSeqBC(inuOrderId in number ,
                         nuSubi1  in number,
                         nuBaja1  in number   )
         IS
            select  MAX(ABS(baja1.item_value - subi1.item_value))
            from  or_order_act_measure baja1, --a
                  or_order_act_measure subi1 --b
            where baja1.ORDER_id = inuOrderId
            AND baja1.variable_id = nuBaja1
            and subi1.variable_id = nuSubi1
            and baja1.order_id = subi1.order_id
            and baja1.pattern_value = subi1.pattern_value;

    BEGIN
      --.TRACE('Inicia  LDC_BOmetrologia.fnugetHisteresisMax',8);
      -- Obtiene el Id de la planilla utilizada en el proceso
      nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;

    -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId);

    nuClase:= fsbgetExactitudElement(inuOrderId);

      ldc_bometrologia.getVacecodiVacevaat(csbBaja_1 ,onuVacecodiB1,osbVaceVaatB1)  ;
      nuBaja1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiB1,nuPlanTemp);
      dbms_output.put_Line('nuBaja1: '||nuBaja1);

      ldc_bometrologia.getVacecodiVacevaat(csbSubi_1 ,onuVacecodiS1,osbVaceVaatS1)  ;
      nuSubi1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS1,nuPlanTemp);
      dbms_output.put_Line('nuSubi1: '||nuSubi1);

    /*Obtener el valor de la variable bajada2 */
      ldc_bometrologia.getVacecodiVacevaat(csbBaja_2 ,onuVacecodiB2,osbVaceVaatB2)  ;
      nuBaja2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiB2,nuPlanTemp);
      dbms_output.put_Line('nuBaja2: '||nuBaja2);

    ldc_bometrologia.getVacecodiVacevaat(csbSubi_2 ,onuVacecodiS2,osbVaceVaatS2)  ;
      nuSubi2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodiS2,nuPlanTemp);
      dbms_output.put_Line('nuSubi2: '||nuSubi2);

      /*Obtiene la diferencia m?xima */
      for exac in cuErrorSub1(inuOrderId,
                         nuBaja1  ,
                         nuSubi1 )
      loop
        nuErrorMax := exac.histeresis;
      end loop;
      dbms_output.put_Line('Histeresis M?xima  = '|| nuErrorMax);

      if sbTipoLab like '%'||csbPresion||'%' then
          --13-04-2015 Llozada: Aplicación de las nuevas fórmulas de presión  [ARA 6869]
          IF LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaGDC(sbNuevasFormulas)
          OR LDC_CONFIGURACIONRQ.aplicaParaGDO(sbNuevasFormulas) THEN
                sbSecuenciaExactitud := fsbgetSecuenciaExactitud(inuOrderId);

                IF sbSecuenciaExactitud = 'A' THEN
                    OPEN cuErrorSeqA(inuOrderId,nuBaja1,nuBaja2,nuSubi1,nuSubi2);
                    FETCH cuErrorSeqA INTO nuErrorMax;
                    CLOSE cuErrorSeqA;
                ELSE
                    OPEN cuErrorSeqBC(inuOrderId,nuSubi1,nuBaja1);
                    FETCH cuErrorSeqBC INTO nuErrorMax;
                    CLOSE cuErrorSeqBC;
                END IF;

                IF nuErrorMax IS NULL THEN
                    nuErrorMax := 0;
                END IF;
          ELSIF nuClase <= 0.6 THEN
        /*Obtiene la diferencia m?xima */
        for exac in cuErrorSub2(inuOrderId,
                 nuBaja2  ,
                 nuSubi2 )
        loop
        nuErrorMax_2 := exac.histeresis;
        end loop;

        if nuErrorMax_2 > nuErrorMax then
        nuErrorMax := nuErrorMax_2;
        end if;
      end if;
     end if;

      return  nuErrorMax;

      --.TRACE('Finaliza  LDC_BOmetrologia.fnugetHisteresisMax',8);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;

        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetHisteresisMax;

    FUNCTION fnugetHisteresisConver(inuOrderId         in        OR_order.order_id%type)
    return number
    IS
        nuHisteresisMax     number;
        nuFactorConver      number;
        nuConversion        varchar2(100) := null;
        sbTipoLab           varchar2(100);
    BEGIN
        nuHisteresisMax := fnugetHisteresisMax(inuOrderId);
        nuFactorConver  := fnuGetFactorConversion(inuOrderId);

        -- Obtiene el tipo de Laboratorio
        sbTipoLab := fnugetTipoLab (inuOrderId); --FSBGETNOMBRELABORATORIO(inuOrderId); --
        ----.TRACE('[METROLOGIA] {LDC_BOmetrologia.fsbgetDescrMedio} sbTipoLab: '||sbTipoLab,8);
        -- --.TRACE('---- [METROLOGIA]  sbRangoMedicion: '||sbRangoMedicion,8);

        IF sbTipoLab like '%'||csbPresion||'%' THEN
            --if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%PSI%' then
                --sbConversion := '('||to_char((to_number(nuHisteresisMax) * 6.8949),'999G999990D00')||' kPa)';
                nuConversion := nuHisteresisMax * nuFactorConver;

            --elsif upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%H2%' then
                --sbConversion := '('||to_char((to_number(nuHisteresisMax) * 0.2491),'999G999990D00')||' kPa)';
            --    nuConversion := nuHisteresisMax * nuFactorConver;
            --end if;

            --sbConversion := REGEXP_REPLACE(sbConversion, '  *', ' ');
        ELSIF sbTipoLab like '%'||csbTemperatura||'%' then
            if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%F%' then
               --sbConversion := '('||to_char(((to_number(nuHisteresisMax) - 32)*(5/9)),'999G999990D00')||' '||replace(upper(fsbgetUnidadMedida(inuOrderId)),'F','C')||')';
               --sbConversion := REGEXP_REPLACE(sbConversion, '  *', ' ');
               nuConversion := (nuHisteresisMax - 32)*(5/9);
            end if;
        END if;

        return nuConversion;

    END fnugetHisteresisConver;



    /*Devuelve TRUE si el elemento pasa la certificaci?n*/
    /* Para poder determinar que un instrumento requiere "Ajuste" se debe realizar la siguiente validaci?n:
      NOTA: Si cumple con la validaci?n se debe ajustar instrumento.
           Tolerancia = ((Clase*Rango))/100   */

     /*Esa diferencia en porcentaje, respecto al valor m?ximo de la escala es:
       %Error: equivale a aplicar la formula
      (Diferencia m?xima x100)/Rango = % (%error)

       ErrorMaximo + Incertidumbre > Tolerancia permitida */

      /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : fblCertificaElemento
      Descripcion    : Valida si el Elemento esta Certificado
      Caso           : FANA492
      Autor          : MMesa
      Fecha          : 20/03/2013

      Parametros              Descripcion
      ============         ===================

      Historia de Modificaciones
      Fecha             Autor           Modificacion
      =========         =========       ====================
      21-07-2014        llozada         Se adicionan los cálculos para determinar
                                        si una plancha termofusión requiere ajuste.
    ******************************************************************/
    FUNCTION fblCertificaElemento
    (
      inuOrderId       in       OR_order.order_id%type
    )
    return boolean
    IS
      nuRango                   number;
      nuClase                   number;
      nuTolerancia              number;
      nuItemSeriado             number;
      nuDiferenMax              number;
      nuIncertidumbre           number;
      nuDifeIncert              number;
      sbTipoLab                 ldc_plantemp.pltelabo%type;
      nuTipoPlancha             number;
      nuSocket                  number;
      nuTope                    number;
      nuRangoSocket             number;
      nuRangoTope               number;
      sbIncert             varchar2(200);

      --  Variables para manejo de Errores
      exCallService             EXCEPTION;
      sbCallService             varchar2(2000);
      nuErrorCode               number;
      sbErrorMessage            varchar2(2000);
    BEGIN
        ----.init;
        ----.setlevel(99);
        ----.setoutput(--.fntrace_output_db);
      -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId);

      --llozada, 16-07-2014: Valida si la plancha requiere Ajuste.
      if LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbNombreEntrega526)
      or LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbNombreEntrega526)
      or LDC_CONFIGURACIONRQ.aplicaParaGDC(sbNombreEntrega526)
      or LDC_CONFIGURACIONRQ.aplicaParaGDO(sbNombreEntrega526) then

            if sbTipoLab like csbPlanchas||'%' then

                nuTipoPlancha   := fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbNominalPlancha));
                nuSocket        := fnuObtValorParametro(csbSocket);
                nuTope          := fnuObtValorParametro(csbTope);
                nuRangoSocket   := fnuObtValorParametro(csbRangoSocket);
                nuRangoTope     := fnuObtValorParametro(csbRangoTope);

                if nuTipoPlancha = nuSocket then
                    if (nuSocket + abs(fnuGetPromedioPlancha(inuOrderId))) > (nuSocket + nuRangoSocket) then
                        return FALSE;
                    elsif (nuSocket - abs(fnuGetPromedioPlancha(inuOrderId))) < (nuSocket - nuRangoSocket) then
                        return FALSE;
                    end if;

                elsif nuTipoPlancha = nuTope then
                    if (nuTope + abs(fnuGetPromedioPlancha(inuOrderId))) > (nuTope + nuRangoTope) then
                        return FALSE;
                    elsif (nuTope - abs(fnuGetPromedioPlancha(inuOrderId))) < (nuTope - nuRangoTope) then
                        return FALSE;
                    end if;
                end if;

                return true;
            end if;
      end if;

      if sbTipoLab like csbPlanchas||'%' then
            return true;
      end if;

      --.trace ('Inicia LDC_BOmetrologia.fblCertificaElemento ',8) ;
      -- Obtiene el Item seriado dada la orden
      nuItemSeriado := fnugetItemSeriadOrden(inuOrderId) ;
      --.trace ('Item Seriado, que se esta calibrando ['||nuItemSeriado||']',8) ;

      --Comentario Maria Jeimy: Obtiene la clase o exactitud de el Elemento , se divide en 100 porque es porcentaje (%)
      /* 09/10/2013 LLOZADA: En reuni?n con Johana la L?der de Metrolog?a, se define que no se divide en 100
                             porque debe tomarse el valor tal cual lo ingresa el funcional para hacer los
                             c?lculos.
                             A esta reuni?n tambi?n asisti? el funcional Carlos Sanchez. */
      nuClase:= fsbgetExactitudElement(inuOrderId);

            -- Obtiene el rango del Elemento que se esta calibrando
     -- nuRango:= fsbgetValAttribute(nuItemSeriado,cnuRangMaxMed);
      nuRango := fnugetRangoMedicion(inuOrderId,nuItemSeriado);

      -- Obtiene la Tolerancia del Equipo
      nuTolerancia :=  (nuClase* nuRango )/100;

      -- Obtiene la diferencia M?xima
      nuDiferenMax := abs(fnugetDiferenciaMax(inuOrderId));

      -- Obtiene el valor absoluto de la incertidumbre  ************************
      nuIncertidumbre := round(abs(fnugetUexp_Incertidumbre(inuOrderId)),5);

      if sbTipoLab like csbConcentracion||'%' then
           sbIncert := fsbGetIncertidumbreConcNomi(inuOrderId);
           /*29-01-2015 Llozada: Se valida el segundo Gas en conccentración de Gas*/
           if nuIncertidumbreGas2 is not null then
                if  nuIncertidumbreGas2 > nuIncertidumbre then
                    nuIncertidumbre := nuIncertidumbreGas2;
                end if;
           end if;
      end if;

      --.trace ('---------- nuIncertidumbre  ['||nuIncertidumbre||']',2) ;
       --.trace ('---------- nuDiferenMax  ['||nuDiferenMax||']',2) ;
       --.trace ('---------- Tolerancia  ['||nuTolerancia||']',2) ;
       --.trace ('--------- Rango del Elemento  ['||nuRango||']',2) ;
       --.trace ('---------- UB_Exactitud ['||nuClase||']',2) ;

      nuDifeIncert := nuDiferenMax + nuIncertidumbre;
      --.trace ('---------- nuDifeIncert  ['||nuDifeIncert||']',8) ;
      -- Si ErrorMaximo + Incertidumbre > Tolerancia se debe ajustar el instrumento
      if nuDifeIncert >  abs(nuTolerancia) then
        --.trace ('---------- nuDifeIncert >  abs(nuTolerancia)  [TRUE]',8) ;
        return FALSE ;  -- No pasa la calibraci?n , necesita ajuste.
      else
        --.trace ('---------- nuDifeIncert >  abs(nuTolerancia)  [FALSE]',8) ;
        return TRUE;  -- Pasa la calibraci?n, se certifica el elemento
      END if ;

    --.trace ('Finaliza LDC_BOmetrologia.fblCertificaElemento ',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);


    END fblCertificaElemento;



   /*
     Obtiene el Id del Certificado - GE_XSL_TEMPLATE*/
    FUNCTION fnugetIdCertificado
    (
      inuOrderId        in      OR_order.order_id%type
    ) return number
    IS

      nuPlan                    ldc_plantemp.pltevate%type;
      sbTiCl                    ldc_plantemp.pltetipo%type;
      nuIdCertif                ldc_plantemp.pltexste%type;
      nuOrderAj                 OR_ORDER.order_id%type;
      --  Variables para manejo de Errores
      exCallService             EXCEPTION;
      sbCallService             varchar2(2000);
      sbErrorMessage            varchar2(2000);
      nuErrorCode               number;
      sbTipoLab                 varchar2(2000);

      -- CURSOR
      CURSOR cuCertifica(inuPlan in ldc_plantemp.pltevate%type,
                         inTipoCl in ldc_plantemp.pltetipo%type) IS
        select PLTEXSTE FROM  ldc_plantemp
        WHERE  pltevate = nuPlan
        AND pltetipo =  inTipoCl
         AND pltelabo not like '%'||csbAjuste
        AND rownum  = 1;

      CURSOR cuCertificaAju(inuPlan in ldc_plantemp.pltevate%type,
                         inTipoCl in ldc_plantemp.pltetipo%type)   IS
        select PLTEXSTE FROM  ldc_plantemp
        WHERE  pltevate = nuPlan
        AND pltetipo =  inTipoCl
        AND pltelabo LIKE  '%'||csbAjuste
        AND rownum  = 1;

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fnugetIdCertificado ',8) ;
      -- Obtiene el Item seriado dada la orden
      nuPlan := ldc_bometrologia.fnugetIdPlanilla(inuOrderId);
      sbTiCl := ldc_bometrologia.fsbTipoClienteCertif(inuOrderId);
      sbTipoLab := fnugetTipoLab (inuOrderId);

      -- Valida si el Certificado tiene una orden de ajuste
      nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

      if nuOrderAj <> 0 then
        for e in cuCertificaAju(nuPlan,sbTiCl) loop
          nuIdCertif := e.PLTEXSTE;
        end loop;
      else
        for e in cuCertifica(nuPlan,sbTiCl) loop
          nuIdCertif := e.PLTEXSTE;
        end loop;
      END if;

      if nuIdCertif is null then
            ge_boerrors.seterrorcodeargument(2741,'No se ha configurado el certificado '||sbTipoLab||
                                                  ', en el Maestro Detalle CERPLA.');
      end if;

      return nuIdCertif;

      --.trace ('Finaliza LDC_BOmetrologia.fnugetIdCertificado ',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetIdCertificado;


   /*Obtiene el Id de la Notificaci?n dado el id de XSL_TEMPLATE*/
    FUNCTION fnugetIdNotificacion
    (
      inuIdCertif          in       ldc_plantemp.pltexste%type
    ) return number
    IS

      nuIdNotificacion              ge_notification.notification_id%type;

      --  Variables para manejo de Errores
      exCallService                 EXCEPTION;
      sbCallService                 varchar2(2000);
      sbErrorMessage                varchar2(2000);
      nuErrorCode                   number;

      -- CURSOR que busca el Id de la notificaci?n
      CURSOR cuNotificacion(inuXSL_temp in ldc_plantemp.pltevate%type ) IS
        select notification_id FROM ge_notification
        WHERE xsl_template_id = inuXSL_temp
        AND rownum  = 1;

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fnugetIdNotificacion ',8) ;

      for e in cuNotificacion(inuIdCertif) loop
        nuIdNotificacion := e.notification_id;
      end loop;

      return nuIdNotificacion;
      --.trace ('Finaliza LDC_BOmetrologia.fnugetIdNotificacion ',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetIdNotificacion;


      /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : valCertificaElemento
      Descripcion    : Valida si el Elemento esta Certificado y levanta la notificaci?n.
      Caso           : FANA492
      Autor          : MMesa
      Fecha          : 20/03/2013

      Parametros              Descripcion
      ============         ===================

      Historia de Modificaciones
      Fecha             Autor           Modificacion
      =========         =========       ====================
      15-07-2014        llozada         Se modifica el update que actualiza la tabla LDC_CERTMETR
                                        para que actualice el campo CEMEREAJ que indica si el equipo
                                        requiere ajuste
      08-08-2014        llozada         Se elimina la certificación si el equipo requiere ajuste.
                                        NC 1158 Rollout.
      14-08-2014        llozada         Se remueve la validación para que a las planchas se les valide
                                        el ajuste.
    ******************************************************************/
    PROCEDURE valCertificaElemento
    IS
       -- Variables para el manejo de instancias..
       sbInstance                       ge_boinstancecontrol.stysbName;
       sbOrderId                        ge_boInstanceControl.stySbValue;
       sbNumCert                        ge_boInstanceControl.stySbValue;
       -- Variables Generales..
       onuNotifica_log                  ge_notification_log.notification_log_id%type;
       nuExternalId                     ge_notification_log.external_id%type := -1;
       nuNotificationId                 ge_notification.notification_id%type;
       nuOriginModule                   ge_module.module_id%type := 16;
       nuOrderId                        OR_order.order_id%type;
       sbValidUntil                     varchar2(100);
       sbParamString                    varchar2(4000);
       osbErrorText                     varchar2(2000) ;
       onuErrorCode                     number;
       blCertif                         boolean;
       nuItemId                         ge_items.items_id%type;
       nuItemSe                         ge_items_seriado.id_items_seriado%type;

       -- Variables manejo XML
       nuIdItemSeriado                  ge_items_seriado.id_items_seriado%type;
       nuOrderActivity                  or_order_activity.order_activity_id%type;
       nuOperUnitId                     or_operating_unit.operating_unit_id%type;
       nuPatronId                       OR_item_pattern.id_items_seriado%type;
       nuEstadoOrden                    OR_order.order_status_id%type :=0;
       dtValidUntil                     OR_item_pattern.valid_until%type;
       nuCodiCeMe                       ldc_certmetr.cemecodi%type;
       sbSerie                          ge_items_seriado.serie%type;
       nuSerie                          ge_items_seriado.serie%type;
       sbTracking                       OR_item_pattern.tracking%type;
       nuIdCertificado                  ldc_plantemp.pltexste%type;
       nuOrden                          OR_order.order_id%type;
       nuOrdenAju                       OR_order.order_id%type;
       sbTipoClie                       varchar2(100);
       sbTipoLab                        ldc_plantemp.pltelabo%type;
       nuEquiNoConf                     OR_ORDER.LEGAL_IN_PROJECT%type := 'N';
       sbreaju                          varchar2(1):='N';-- Necesita Ajuste por defecto
       sbRequestXML1                    varchar2(32767);
       nuTipoClien                      varchar2(2);
       osbMessageError                  varchar2(4000);
       onuCodeError                     number;
       nuSeqCeMe                        number;
       nuFrecuencia                     number;
       nufece                           DATE;
       nufemo                           DATE;
       --  Variables para manejo de Errores
       exCallService                    EXCEPTION;
       nuErrorCode                      number;
       sbCallService                    varchar2(2000);
       sbErrorMessage                   varchar2(2000);

       cursor cuExistsOrder(inuOrder_id or_order.order_id%type) is
       select order_id
       from or_order
       where order_id = inuOrder_id;

    BEGIN

    ----.init;
    ----.setlevel(99);
    ----.setoutput(--.fntrace_output_db);
    ----.trace (' ------------------  Inicia LDC_BOmetrologia.valCertificaElemento ',8) ;

      -- Obtiene la instancia actual
      Ge_BOInstanceControl.GetCurrentInstance(sbInstance);
      -- Obtiene el n?mero de la orden
      ge_boinstancecontrol.GetAttributeNewValue(sbInstance,null,'OR_ORDER','ORDER_ID',sbOrderId);

      if  sbOrderId IS null then
        -- Obtiene el n?mero de certificado.
        ge_boinstancecontrol.GetAttributeNewValue(sbInstance,null,'OR_ORDER_ACT_VAR_DET','VALUE',sbNumCert);
        -- Obtiene el n?mero de la Orden.
        nuOrderId := ldc_bometrologia.getOrderByNumCert(sbNumCert);
      else
        nuOrderId := to_number(sbOrderId);

        open cuExistsOrder(nuOrderId);
        fetch cuExistsOrder INTO nuOrderId;
        close cuExistsOrder;

        if nuOrderId is null then
            ge_boerrors.seterrorcodeargument(2741,'La ORDEN ingresada No Existe en el sistema, por favor '||
                                                  'valide la informaci?n.');
        end if;

      END if;

      -- Valida que la orden sea de Laboratorio
      valOrdenLaboratorio(nuOrderId);
      -- Obtiene el estado de la orden
      nuEstadoOrden := daor_order.fnugetorder_status_id(nuOrderId);

      nuIdCertificado := fnugetIdCertificado(nuOrderId);
      --.trace('------------------------------------- nuIdCertificado ['||nuIdCertificado||']',9) ;
      -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (nuOrderId);  --FSBGETNOMBRELABORATORIO(nuOrderId); --
      --.trace('------------------------------------- [llozada] sbTipoLab ['||sbTipoLab||']',9) ;

      if nuEstadoOrden  = cnuStatusOrderAnten  then
       -- Verifica si el elemento se Certifica o No se Certifica de acuerdo a las formulas planteadas.
       /*Si el lab es de plancha  u Orificios se imprime certificado es porque se Certifica, El equipo esta conforme */
        --14-08-2014,llozada: Las planchas deben validar si requieren ajuste  (sbTipoLab = csbPlanchas)
        if sbTipoLab = csbOrificios then
         blCertif  :=  true  ;
        else
            --Generar tabla de Temperatura
            --.trace('****************** antes de generar la tabla +++++++++++++++++ ['||csbTemperatura||']'||
                       --         'Tipo de Laboratorio ['||sbTipoLab||']',2);

            nuOrdenAju := ldc_bometrologia.valCertAjuste(nuOrderId);
            --.trace('----------------- nuOrdenAju '||nuOrdenAju,9);

            if sbTipoLab like '%'||csbTemperatura||'%' then
                --.trace('Laboratorio de ['||csbTemperatura||']'||
                        --            'Tipo de Laboratorio ['||sbTipoLab||']',2);
                  execute immediate 'truncate table LDC_FORMTEMP';

                  if nuOrdenAju <> 0 then
                  --.trace('----------------- AJUSTE TEMPERATURA generarDatosTemperatura '||nuOrdenAju,9);
                        --LDC_BOMETROLOGIA.generarDatosTemperatura(nuOrdenAju);
                        LDC_BOMETROLOGIA.temperatura(nuOrdenAju);
                  end if;
                  --.trace('----------------- TEMPERATURA generarDatosTemperatura '||nuOrdenAju,9);
                  --LDC_BOMETROLOGIA.generarDatosTemperatura(nuOrderId);
                  LDC_BOMETROLOGIA.temperatura(nuOrderId);
            END if;

         if nuOrdenAju <> 0 then
                blCertif  :=  LDC_BOmetrologia.fblCertificaElemento(nuOrdenAju);
         else
                blCertif  :=  LDC_BOmetrologia.fblCertificaElemento(nuOrderId);
         end if;

        END if;

        nuIdItemSeriado := ldc_bometrologia.fnugetItemSeriadOrden(nuOrderId);
        --.trace('------------------------------------- Id_Items_seriado ['||nuIdItemSeriado||']');
        -- Si el elemento despu?s de los c?lculos correspondientes se certifica..
        if blCertif = true then
          -- Si el Equipo se Certifica no necesita Ajuste.
          sbreaju := 'N';
          /*Actualiza las tablas de Certificaci?n de Smart ..     */
          -- Obtiene la serie dado el Id_items_seriado

          nuSerie:=dage_items_seriado.fsbgetserie (nuIdItemSeriado);
          --.trace('------------------------------------- Serie ['||nuSerie||']',2);

          IF sbTipoLab = csbOrificios then
              sbTracking := DAOR_ITEM_PATTERN.FSBGETTRACKING( LDC_BOMETROLOGIA.FNUGETELEMNTOPATRON (nuOrderId));
              --LDC_BOmetrologia.fsbgetValueVariable(nuOrderId,
                --fnuObtValorParametro(csbPATRON_ORIFICIO)) ;
            --.trace('------------------------------------- PATRON ORIFICIO ['||sbTracking||']',2);
          else
              -- Obtiene el Items_Seriado_Id del Patron
              nuPatronId := ldc_bometrologia.fnugetElemntoPatron(nuOrderId);
              --.trace('------------------------------------- PatronId ['||nuPatronId||']',2);
              -- Obtiene la trazabilidad  del patron
              sbTracking :=daor_item_pattern.fsbgettracking(nuPatronId);
              --.trace('------------------------------------- Tracking ['||sbTracking||']',2);
          end if;

          -- Obtiene la Fecha hasta la que es valido el patron
          --dtValidUntil:=daor_item_pattern.fdtgetvalid_until(nuPatronId);
          --sbValidUntil := to_char(dtValidUntil,'DD/MM/YYYY');

          nuFrecuencia := LDC_BOmetrologia.getFrecuencia(nuOrderId);
          --.trace('??????????? nuFrecuencia:['||nuFrecuencia||']',2);
          /* Se valida si el equipo tiene plan se toma la frecuencia del plan,
          sino se toma de la tabla de equivalencia creada para los ?tems. */
          --.trace('??????????? FECHA CALIBRACION:['||sysdate||']',2);
          dtValidUntil := /*to_date(LDC_BOmetrologia.fsbgetFechaCalibrac(nuOrderId))*/
                        daor_order.fdtgetlegalization_date(nuOrderId) + nuFrecuencia;
          --.trace('????????? dtValidUntil:['||dtValidUntil||']',2);
          sbValidUntil := to_char(dtValidUntil,'DD/MM/YYYY');
          --.trace('???????????? sbValidUntil :['||sbValidUntil||']',2);

          -- Arma el XML
          sbRequestXML1 := '<UPDITEMPATT><SERIE>' || nuSerie||
                         '</SERIE><VALID_UNTIL>'||sbValidUntil||
                         '</VALID_UNTIL><TRACKING>'||sbTracking||
                         '</TRACKING></UPDITEMPATT>  ';
          /* Envia mediante el Api la certificaci?n del elemento para actualizar en la tablas de Smart.
            Api proporcionado por OpenSystem.  */
          --.trace('Inicia API OS_UPDITEMPATT' ,9);

          OS_UPDITEMPATT(sbRequestXML1, onuCodeError ,osbMessageError);
          if onuCodeError <> 0 then
            ge_boerrors.seterrorcodeargument(2741,onuCodeError||'  '||osbMessageError||' OS_UPDITEMPATT' );
          END if;
          --.trace('Finiliza API OS_UPDITEMPATT' ,9);
        else
            -- El Elemento Necesita Ajuste ..
            sbreaju := 'Y';

            --08-08-2014, Llozada: Si no pasa la certificación no debe colocarle fecha de certificación
            /*12-05-2015 Llozada: NO se puede eliminar el registro ya que la tabla OR_ORDER_ACT_MEASURE
                                tiene una foranea esta tabla or_item_pattern (FK_OR_ORDER_A_OR_ITEM_PA_01).
                                Escalar el tema a OPEN porque la fecha de certificación NO puede ser nula*/
            if daor_item_pattern.fnugetid_items_seriado(nuIdItemSeriado,null) is not null then
                delete from or_item_pattern
                where  ID_ITEMS_SERIADO = nuIdItemSeriado;
            end if;
        END if ;

        -- CErtificado
        nuNotificationId  := fnugetIdNotificacion(nuIdCertificado);

        /*21-04-2015 Llozada: Se comenta ya que no se necesitan las plantillas de INH2
                              porque gracias a la configuración de EQUILAB, esto evita el uso
                              de estas plantillas.*/
        /*if sbTipoLab like '%'||csbPresion||'%' then
            if upper(fsbgetUnidadMedida(nuOrderId)) <> 'PSI' then
              nuOrdenAju := 0;
              -- Valida si el Certificado tiene una orden de ajuste
              nuOrdenAju := ldc_bometrologia.valCertAjuste(nuOrderId);
              sbTipoClie := ldc_bometrologia.fsbTipoClienteCertif(nuOrderId);

              if nuOrdenAju <> 0 then
                if sbTipoClie = 'I' then
                    nuNotificationId := fnugetIdNotificacion(
                                        fnuObtValorParametro(csbPlantillaInternoAjINH2O));
                else
                    nuNotificationId := fnugetIdNotificacion(
                                        fnuObtValorParametro(csbPlantillaExternoAjINH2O));
                end if;
            else
                if sbTipoClie = 'I' then
                    nuNotificationId := fnugetIdNotificacion(
                                        fnuObtValorParametro(csbPlantillaInternoINH2O));
                else
                    nuNotificationId := fnugetIdNotificacion(
                                        fnuObtValorParametro(csbPlantillaExternoINH2O));
                end if;
              END if;
            end if;
        els*/
        if sbTipoLab like '%'||csbTemperatura||'%' then
            if upper(fsbgetUnidadMedida(nuOrderId)) = 'F' OR upper(fsbgetUnidadMedida(nuOrderId)) like '%F' then
                  nuOrdenAju := 0;
                  -- Valida si el Certificado tiene una orden de ajuste
                  nuOrdenAju := ldc_bometrologia.valCertAjuste(nuOrderId);
                  sbTipoClie := ldc_bometrologia.fsbTipoClienteCertif(nuOrderId);

                  if nuOrdenAju <> 0 then
                    if sbTipoClie = 'I' then
                        nuNotificationId := fnugetIdNotificacion(
                                            fnuObtValorParametro(csbPlantillaInternoAjF));
                    else
                        nuNotificationId := fnugetIdNotificacion(
                                            fnuObtValorParametro(csbPlantillaExternoAjF));
                    end if;
                  else
                    if sbTipoClie = 'I' then
                        nuNotificationId := fnugetIdNotificacion(
                                            fnuObtValorParametro(csbPlantillaInternoF));
                    else
                        nuNotificationId := fnugetIdNotificacion(
                                            fnuObtValorParametro(csbPlantillaExternoF));
                    end if;
                  END if;
            end if;
        elsif sbTipoLab like '%'||csbConcentracion||'%' then
            nuItemSe := fnugetItemSeriadOrden(nuOrderId) ;
            nuItemId := dage_items_seriado.fnugetitems_id(nuItemSe) ;

            -- Se verifica que el ITEM sea MULTIGAS
            if nuItemId = fnuObtValorParametro(csbItemIdMultigas) then
                nuNotificationId := fnugetIdNotificacion(
                                    fnuObtValorParametro(csbPlantillaMultigas));
            END if;
        end if;

        --.trace('+++++++++++++++++++++++++ nuNotificationId ['||nuNotificationId||']',9) ;
        nuOriginModule := dage_notification.fnugetorigin_module_id(nuNotificationId);
        --.trace('Order_id ['||nuOrderId||']',9) ;


       --INSERT INTO temp_error values ('Antes del nuNotificationId:['||nuNotificationId||']');
      -- INSERT INTO temp_error values ('Antes del nuOriginModule:['||nuOriginModule||']');
       --INSERT INTO temp_error values ('Antes del sbParamString:['||sbParamString||']');
      -- INSERT INTO temp_error values ('Antes del nuExternalId:['||nuExternalId||']');
      -- COMMIT;

      --DE esta manera se genera la informacion para las notificaciones,
        --se hace de esta manera ya que en SF solo se aceptan hasta 3000
        --caracteres por sentencia.
        ut_trace.trace('--ANTES TE TRUNCAR, nuNotificationId: '||nuNotificationId,9);
        if sbTipoLab like '%'||csbPresion||'%' OR
           sbTipoLab like '%'||csbTemperatura||'%' OR
           sbTipoLab like '%'||csbConcentracion||'%'  then
            ut_trace.trace('--ANTES TE TRUNCAR - EN EL IF ',9);

            execute immediate 'truncate table LDC_DATOS_CERTIFICADO_MET';
            --Genera los datos para los Certificados de PRESION, TEMPERATURA o CONCENTRACION
            prGenerarDatosNotificacion(nuOrderId);
        END if;
        ut_trace.trace('--DESPUES TE TRUNCAR ',9);
        -- Setea los parametros de entrada de la sentencia.
        -- Creaci?n de la ge_notification _log
        Ge_BONotification.SETAttribute(sbParamString,'ORDER_ID', nuOrderId);
        --.trace('sbParamString ['||sbParamString||']',9);

       --.trace('Antes del nuNotificationId:['||nuNotificationId||']',2);
       --.trace('Antes del nuOriginModule:['||nuOriginModule||']',2);
       --.trace('Antes del sbParamString:['||sbParamString||']',2);
       --.trace('Antes del nuExternalId:['||nuExternalId||']',2);

        ge_bonotification.SendNotify (nuNotificationId,nuOriginModule,sbParamString,nuExternalId,
                                      onuNotifica_log , onuErrorCode, osbErrorText );

        --.trace('despues del onuNotifica_log:['||onuNotifica_log||']',2);
        ----.trace('despues del onuNotifica_log:['||onuErrorCode||']',2);
        ----.trace('despues del onuNotifica_log:['||osbErrorText||']',2);

        if (onuErrorCode <>0 ) then
          ge_boerrors.seterrorcodeargument(2741,onuErrorCode||' - '||osbErrorText||' ge_bonotification.SendNotify');
        END if;
        commit;
        --.trace('onuNotifica_log ['||onuNotifica_log||']');

        -- Levanta la forma de Impresi?n
        CC_BOPACKADDIDATE.RUNMOCNP(onuNotifica_log);

        -- Obtiene siguiente valor de la secuencia
        nuSeqCeMe := LDC_BOMETROLOGIA.fnunextLDC_CERTMETR;
        --.Trace('nuSeq ['||nuSeqCeMe||']',9);
        nufece := sysdate; -- Fecha de creaci?n del registro
        nufemo := sysdate; -- hacer el UPDATE
        -- Obtiene la Serie del equipo que se Calibro
        sbSerie := dage_items_seriado.fsbgetserie(nuIdItemSeriado);

        begin
          SELECT CEMECODI INTO nuCodiCeMe
          FROM ldc_certmetr
          WHERE CEMEORDE = sbOrderId
          AND rownum = 1;
        EXCEPTION
          when OTHERS then
          nuCodiCeMe := null;
        END;

        if nuCodiCeMe IS null then

          --.Trace('Insertando Registros LDC_CERTMETR ',9);
          -- Inserta registros certificados de Calibraci?n.

          --15-07-2014,llozada.
          INSERT INTO LDC_CERTMETR
           (CEMECODI,CEMEFECE,CEMEFEMO,CEMESERI,CEMEREAJ,CEMEORDE,CEMEORAJ )
            VALUES (nuSeqCeMe,nufece, nufemo,sbSerie, sbreaju,nuOrderId,nuOrdenAju);
          else
            UPDATE LDC_CERTMETR
            SET CEMEFEMO =sysdate,
                cemereaj = sbreaju
            WHERE CEMECODI=nuCodiCeMe;
          END if;
        Commit;
        --.Trace('REGISTR? EN LDC_CERTMETR',9);
      else
         ge_boerrors.seterrorcodeargument(2741,' La Orden debe estar en estado Atendido para ejecutar este proceso, '
                                              || 'por favor verifique la Legalización de la orden. ');
      END if ;
    --.trace ('Finaliza LDC_BOmetrologia.valCertificaElemento ',8) ;

    /*EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage); */

    END valCertificaElemento;

    /*
       Obtiene la orden anterior que requiere ajuste*/
    FUNCTION getFrecuencia
    (
        nuOrderId            in           or_order.order_id%type
    ) return number
    IS
      nuItemid                        ge_items_seriado.items_id%type;
      nuIdItemSeriado                 ge_items_seriado.id_items_seriado%type;
      nuFrecuencia                    if_maint_itemser.exec_frecuency%type;
      nuCodException                  if_maint_itseexc_att.maintenance_exc_id%type;
      nuCodEquiFrec                   number := 0;
      nuExistOrde                     number := 0;
      sbDescActivity                  ge_items.description%type;

      --  Variables para manejo de Errores
      exCallService                   EXCEPTION;
      sbCallService                   varchar2(2000);
      sbErrorMessage                  varchar2(2000);
      nuErrorCode                     number;

       -- CURSOR que obtiene la orden dada la serie del  elemento .
      CURSOR cuPlan(inuItemId in if_maint_itemser.item_id%type ) IS
        select exec_frecuency
        FROM if_maint_itemser
        where item_id = inuItemId
        AND dage_items.fsbgetdescription(activity) like '%CALIBRACI%'; -- debe tomar el plan de calibraci?n

      CURSOR cuException(inuSerieItem in if_maint_itseexc_att.serial_item_id%type ) IS
        select maintenance_exc_id
        FROM if_maint_itseexc_att
        where serial_item_id = inuSerieItem;

      CURSOR cuFrecException(inuException in if_maintenance_exc.maintenance_exc_id%type ) IS
        select exec_frecuency
        FROM if_maintenance_exc
        where maintenance_exc_id = inuException;

      CURSOR cuEquivalencia(inuEquiId GE_EQUIVALENC_VALUES.equivalence_set_id%type,
                            inuItem   GE_EQUIVALENC_VALUES.origin_value%type) IS
        select target_value
        from GE_EQUIVALENC_VALUES
        where equivalence_set_id = inuEquiId
        and origin_value = inuItem;

    BEGIN
    ----.init;
    ----.setlevel(99);
    ----.setoutput(--.fntrace_output_db);
      --.trace('------------------- Inicia LDC_BOmetrologia.getFechaValidacion ');

      nuIdItemSeriado := ldc_bometrologia.fnugetItemSeriadOrden(nuOrderId);
      nuItemid := dage_items_seriado.fnugetitems_id(nuIdItemSeriado);

      --.trace('------------------- nuIdItemSeriado:['||nuIdItemSeriado||']',2);
      --.trace('------------------- nuItemid:['||nuItemid||']',2);

      nuCodEquiFrec := fnuObtValorParametro(csbEquiFrecuencia);

      if dage_items_seriado.fsbgetpropiedad(nuIdItemSeriado) = 'T' OR dage_items_seriado.fsbgetpropiedad(nuIdItemSeriado) = 'C' then   --1

             --.trace('------------------- NO TIENE PLAN:['||nuCodEquiFrec||']',2);

                 open cuEquivalencia(nuCodEquiFrec, nuItemid);
                 fetch cuEquivalencia INTO nuFrecuencia;
                 close cuEquivalencia;

                 --.trace('------------------- [NO TIENE PLAN] nuFrecuencia:['||nuFrecuencia||']',2);
              if nuFrecuencia is null then   --2
                    --.trace(' ----------------------- NO CONFIGURADO ITEM',2);
                    ge_boerrors.seterrorcodeargument (2741,'No se ha configurado la equivalencia para el ?TEM '||
                                                      nuItemid||'. Esto debe hacerse para determinar la frecuencia del equipo'||
                                                      ' Para configurar la equivalencia debe ir a la forma '||
                                                      '[GEAGE/Grupos de Equivalencia], buscar por el c?digo: '||nuCodEquiFrec||
                                                      '; Y adicionar el ?TEM en la pesta?a DATOS DE GRUPO DE EQUIVALENCIA.')  ;

              end if; --2
      else    -- else 1

          open cuPlan(nuItemid);
          fetch cuPlan INTO nuFrecuencia;
          close cuPlan;

          --.trace('------------------- tiene plan nuFrecuencia:['||nuFrecuencia||']',2);
          /*exception
          when others then
              nuFrecuencia := 0;
              --.trace('------------------- No tiene plan nuFrecuencia:['||nuFrecuencia||']',2);
          end;*/

          if nuFrecuencia is not null or nuFrecuencia > 0 then   -- 3

                  open cuException(nuItemid);
                  fetch cuException INTO nuCodException;
                  close cuException;

                  --.trace('------------------- Tiene EXCEPTION configurado nuCodException:['||nuCodException||']',2);

              if nuCodException is not null or nuCodException > 0 then  -- 4

                    open cuFrecException(nuCodException);
                    fetch cuFrecException INTO nuFrecuencia;
                    close cuFrecException;

                    --.trace('------------------- EXCEPTION nuFrecuencia:['||nuFrecuencia||']',2);
                if nuFrecuencia is null then  -- 5
                    nuCodException := 0;
                    --.trace('------------------- NO EXCEPTION nuFrecuencia:['||nuFrecuencia||']',2);
                 end if;   -- 5
              end if; -- 4
          else  -- else 3

             --.trace('------------------- NO TIENE PLAN:['||nuCodEquiFrec||']',2);

                 open cuEquivalencia(nuCodEquiFrec, nuItemid);
                 fetch cuEquivalencia INTO nuFrecuencia;
                 close cuEquivalencia;

                 --.trace('------------------- [NO TIENE PLAN] nuFrecuencia:['||nuFrecuencia||']',2);
                if nuFrecuencia is null then  --6
                    --.trace(' ----------------------- NO CONFIGURADO ITEM',2);
                    ge_boerrors.seterrorcodeargument (2741,'No se ha configurado la equivalencia para el ?TEM '||
                                                      nuItemid||'. Esto debe hacerse para determinar la frecuencia del equipo'||
                                                      ' Para configurar la equivalencia debe ir a la forma '||
                                                      '[GEAGE/Grupos de Equivalencia], buscar por el c?digo: '||nuCodEquiFrec||
                                                      '; Y adicionar el ?TEM en la pesta?a DATOS DE GRUPO DE EQUIVALENCIA.')  ;
                end if;  --6
          end if; --3
      end if;  --1


      --.trace('------------------- [getFechaValidacion] Retorna la Frecuencia ['||nuFrecuencia||']');
      --.trace('------------------- finaliza LDC_BOmetrologia.getFechaValidacion');
      return nuFrecuencia;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);
    END getFrecuencia;

    /*Devuelve la Norma configurada para el ?tem*/
    FUNCTION getNorma(inuOrder_id in or_order.order_id%type)
    return varchar2
    IS
        nuCodEquiFrec                   number := 0;
        nuItemid                        ge_items_seriado.items_id%type;
        nuIdItemSeriado                 ge_items_seriado.id_items_seriado%type;
        sbNorma                         varchar2(4000);

        CURSOR cuEquivalencia(inuEquiId GE_EQUIVALENC_VALUES.equivalence_set_id%type,
                            inuItem   GE_EQUIVALENC_VALUES.origin_value%type) IS
        select target_value
        from GE_EQUIVALENC_VALUES
        where equivalence_set_id = inuEquiId
        and origin_value = inuItem;
    BEGIN

        nuIdItemSeriado := ldc_bometrologia.fnugetItemSeriadOrden(inuOrder_id);
        nuItemid := dage_items_seriado.fnugetitems_id(nuIdItemSeriado);

        nuCodEquiFrec := fnuObtValorParametro(csbEquiNorma);

        open cuEquivalencia(nuCodEquiFrec, nuItemid);
        fetch cuEquivalencia INTO sbNorma;
        close cuEquivalencia;

        if sbNorma is null then
            ge_boerrors.seterrorcodeargument (2741,'No se ha configurado la equivalencia para el ?TEM '||
                                                  nuItemid||'. Esto debe hacerse para determinar la NORMA del equipo'||
                                                  ' Para configurar la equivalencia debe ir a la forma '||
                                                  '[GEAGE/Grupos de Equivalencia], buscar por el c?digo: '||nuCodEquiFrec||
                                                  '; Y adicionar el ?TEM en la pesta?a DATOS DE GRUPO DE EQUIVALENCIA.')  ;

        end if;

        return sbNorma;

    END getNorma;

    /*
       Obtiene la orden anterior que requiere ajuste*/
    FUNCTION getOrdenPadre
    (
     inuSerie            in           ge_items_seriado.serie%type
    ) return varchar2
    IS

      nuOrder                         ge_items_seriado.serie%TYPE;
      nuExistOrAj                     number := 0;
      nuExistOrde                     number := 0;

      --  Variables para manejo de Errores
      exCallService                   EXCEPTION;
      sbCallService                   varchar2(2000);
      sbErrorMessage                  varchar2(2000);
      nuErrorCode                     number;


      --TICKET 2001825 LJLB -- se cambia la conulta que obtiene la orden padre
	  CURSOR cuItemSeriadoNu(inuSerie in ge_items_seriado.serie%type ) IS
      SELECT ci.cemeorde, o.LEGALIZATION_DATE
      FROM ldc_certmetr ci, or_order o
      WHERE ci.cemeseri = inuSerie
          AND ci.cemereaj ='Y'
          AND o.order_id = ci.cemeorde
          AND o.order_status_id = 8
          AND NOT EXISTS ( SELECT 1
                           FROM ldc_certmetr ce
                           WHERE ce.cemeoraj = ci.cemeorde
                         AND ci.cemeseri = ce.cemeseri)
      ORDER BY 2 DESC;

	  -- CURSOR que obtiene la orden dada la serie del  elemento .
	   CURSOR cuItemSeriado(inuSerie in ge_items_seriado.serie%type ) IS
        select * FROM ldc_certmetr
        where CEMEseri = inuSerie
        AND CEMEREAJ ='Y';

      --TICKET 2001825 LJLB --  se ajusta consulta para consulta si existe la serie
	  CURSOR cuCertMetr(inuSerie in ge_items_seriado.serie%type ) IS
      select 'X'
      FROM ldc_certmetr
      where CEMEseri = inuSerie;


      CURSOR culdc_certmetr(inuSerie in ge_items_seriado.serie%type ) IS
      select *
      FROM ldc_certmetr
      where CEMEseri = inuSerie;

      sbDatos  VARCHAR2(1);--TICKET 2001825 LJLB -- se almacena dato

      dtFechalega or_order.LEGALIZATION_DATE%TYPE; --TICKET 2001825 LJLB -- se almacena fecha de legalizacion
      csbEntrega2001835		VARCHAR2(100):='OSS_AML_LJLB_2001835_2';
    BEGIN
      --.trace('Inicia LDC_BOmetrologia.getOrdenPadre ');
     IF NOT fblaplicaentrega(csbEntrega2001835) THEN
		 for ex in culdc_certmetr(inuSerie) loop
			nuExistOrde :=1;
			for exac in cuItemSeriado(inuSerie) loop
			  nuExistOrAj :=1;
			  nuOrder := exac.cemeorde;
			END loop;
		  end loop;
	 ELSE
		  --TICKET 2001825 LJLB --  se comentarea logica anterior y se coloca la siguiente
		  OPEN cuCertMetr(inuSerie);
		  FETCH cuCertMetr INTO sbDatos;
		  IF cuCertMetr%FOUND THEN
			nuExistOrde :=1;
		  END IF;
		  CLOSE cuCertMetr;

		  --TICKET 2001825 LJLB -- se consulta orden padre
		  OPEN cuItemSeriadoNu(inuSerie);
		  FETCH cuItemSeriadoNu INTO nuOrder, dtFechalega ;
		  IF cuItemSeriadoNu%FOUND THEN
			 nuExistOrAj := 1;
		  END IF;
		  CLOSE cuItemSeriadoNu;
   END IF;


      if  nuExistOrde = 0 then
        ge_boerrors.seterrorcodeargument(2741,'La serie Ingresada no tiene una Orden de certificaci?n'
                                        ||' previa. Para realizar un ajuste de certificaci?n es necesario'
                                        ||' que el Elemento haya pasado por un proceso de Certificaci?n'
                                        ||' previo y que necesite un Ajuste de Certificaci?n');
      else
        if nuExistOrAj = 0 then
          ge_boerrors.seterrorcodeargument(2741,'La serie Ingresada no tiene una Orden Asociada que requiera ajuste.'
                                         ||' Por favor verificar.');
        END if;
      END if ;


      return nuOrder;
      --.trace('Retorna Orden Previa ['||nuOrder||']');

      --.trace('finaliza LDC_BOmetrologia.getOrdenPadre');
    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then

        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);
    END getOrdenPadre;

    /*
      Obtiene la direcci?n de la Orden  dada la orden.
    */

    FUNCTION getAdressIdOrder
    (
      inuOrderId           in       OR_order.order_id%type
    )
    return number
    IS
      nuAddressId                   ab_address.address_id%type;
      nuExistOrder                  number:= 0;

      --  Variables para manejo de Errores
      exCallService                 EXCEPTION;
      sbCallService                 varchar2(2000);
      sbErrorMessage                varchar2(2000);
      nuErrorCode                   number;

      -- CURSOR  la direcci?n dada la orden
      CURSOR cuOrderActiv(inuOrderId in OR_order.order_id%type ) IS
        select address_id  FROM OR_order_activity
        where ORDER_id  = inuOrderId
        AND address_id IS not null;

    BEGIN
      --.trace('Inicia LDC_METROLOGIA.getAdressIdOrder',9);

      for exac in cuOrderActiv(inuOrderId) loop
        --.trace('Entrta a, Cursor',9);
        nuExistOrder :=1;
        nuAddressId := exac.address_id;
      END loop;

      if (nuExistOrder = 0 ) then
        --.trace('No existe Address ', 9);
        nuAddressId := 1; --Direccion Dummy
        --ge_boerrors.seterrorcodeargument(2741, 'La orden anterior  a ?ste ajuste, ORDER_ID ['
        --                                       ||inuOrderId||'], no tiene una dirrecci?n'
        --                                       ||' asociada,para el proceso de ajuste es necesaria esta informaci?n') ;
      END if;

      return nuAddressId;
      --.trace('Finaliza LDC_METROLOGIA.getAdressIdOrder',9);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);
    END getAdressIdOrder;


   /*CREA Orden de Ajuste*/
   PROCEDURE sendOrderAjuste
   IS
     sbInstance                  ge_boinstancecontrol.stysbName;
     sbActivity                  ge_boInstanceControl.stySbValue := null;
     sbSerieId                   ge_boInstanceControl.stySbValue;
     /* Variables manejo API */
     nuActivity                  ge_items.items_id%type;
     nuParsedAddressId           ab_address.address_id%type;
     dtExecDate                  or_order.exec_estimate_date%type;
     sbComment                   or_order_activity.comment_%type;
     osbErrorMessage             ge_error_log.description%type;
     onuErrorCode                ge_error_log.error_log_id%type;
     ionuOrderId                 or_order.order_id%type;
     onuIdItemSerido             ge_items_seriado.id_items_seriado%type;
     nuOrderActivity             or_order_activity.order_activity_id%type;
     nuOperUnitId                or_operating_unit.operating_unit_id%type;
     nuReferenceValue            or_order_activity.value_reference%type := null;
     nuEquiNoConf                OR_ORDER.LEGAL_IN_PROJECT%type := 'N'; -- Por defecto se env?a N
     onuNotifica_log             ge_notification_log.notification_log_id%type;
     nuExternalId                ge_notification_log.external_id%type := -1;
     nuNotificationId            ge_notification.notification_id%type;
     nuOriginModule              ge_module.module_id%type := 16;
     sbParamString               varchar2(4000);
     osbErrorText                varchar2(2000) ;
     onuCodeError                number;
     osbMessageError             varchar2(4000);
     onuCodError                 number;
     osbMessError                varchar2(4000);
     nuOrdenPadre                number;
     sbConforme                  varchar2(2);
     blExistItSer                boolean;
     dtarrangedhour              date := null;
     dtchangedate                date;
     nuCodUsuario                ge_person.user_id%type;
     nuCodPersona                ge_person.person_id%type;

     --  Variables para manejo de Errores
     exCallService               EXCEPTION;
     sbCallService               varchar2(2000);
     sbErrorMessage              varchar2(2000);
     nuErrorCode                 number;
     rcOrder                     daor_order.styOR_order;

   BEGIN
     ----.init;
     ----.setlevel(99);
     ----.setoutput(--.fntrace_output_db);

     --.trace('Inicia LDC_BOmetrologia.sendOrderAjuste',9);

     -- Obtiene la instancia actual
     Ge_BOInstanceControl.GetCurrentInstance(sbInstance);
     -- Obtiene el n?mero de la orden
     ge_boinstancecontrol.GetAttributeNewValue(sbInstance,null,'GE_ITEMS_SERIADO','SERIE',sbSerieId);
     -- Obtiene el Id_item_seriado dada la serie del equipo.
     ge_boitemsseriado.getidbyserie(sbSerieId,onuIdItemSerido);
     --.trace('---------- [llozada] Paso 1. Id_items_seriado ['||onuIdItemSerido||']',9);
     blExistItSer := dage_items_seriado.fblexist(onuIdItemSerido);

     if blExistItSer = FALSE OR onuIdItemSerido IS null then
       ge_boerrors.seterrorcodeargument (2741,'La Serie Ingresada no pertenece'
                                  ||' a nig?n Item Seriado, por favor Verifique la informaci?n');
     END if ;

     -- Obtiene la orden padre que necesita Ajuste dada la serie.
     nuOrdenPadre := getOrdenPadre(sbSerieId);
     --.trace('---------- [llozada] Paso 2. Orden Padre ['||nuOrdenPadre||']',9);
     -- Obtiene la serie ingresada
     --ge_boinstancecontrol.GetAttributeNewValue(sbInstance,null,'GE_ITEMS_SERIADO','SERIE',sbSerieId);

     --Obtiene El flag que indica si imprime el certificado de equipo No conforme.
     ge_boinstancecontrol.GetAttributeNewValue(sbInstance,null,'OR_ORDER','LEGAL_IN_PROJECT',nuEquiNoConf);

     /********************************************************************
                      Levanta la forma de impresi?n para los
                      equipos No Conformes.
        *********************************************************************/

        --.trace('******************************* nuEquiNoConf:['||nuEquiNoConf||']',2);

        if nuEquiNoConf = 'S' then
             -- CErtificado de Equipos No conformes

            nuNotificationId  := fnugetIdNotificacion(fnuObtValorParametro(csbPlantillaNoConformes));
            --.trace('Equipos No Conformes nuNotificationId ['||nuNotificationId||']',9) ;

            nuOriginModule := dage_notification.fnugetorigin_module_id(nuNotificationId);

            --.trace('Equipos No Conformes Order_id ['||nuOrdenPadre||']',9) ;
            -- Setea los parametros de entrada de la sentencia.
            -- Creaci?n de la ge_notification _log
            Ge_BONotification.SETAttribute(sbParamString,'ORDER_ID', nuOrdenPadre);
            --.trace('Equipos No Conformes sbParamString ['||sbParamString||']',9);

           --.trace('Equipos No Conformes Antes del nuNotificationId:['||nuNotificationId||']',2);
           --.trace('Equipos No Conformes Antes del nuOriginModule:['||nuOriginModule||']',2);
           --.trace('Equipos No Conformes Antes del sbParamString:['||sbParamString||']',2);
           --.trace('Equipos No Conformes Antes del nuExternalId:['||nuExternalId||']',2);

            ge_bonotification.SendNotify (nuNotificationId,nuOriginModule,sbParamString,nuExternalId,
                                          onuNotifica_log , onuErrorCode, osbErrorText );

            --.trace('Equipos No Conformes despues del onuNotifica_log:['||onuNotifica_log||']',2);
            --.trace('Equipos No Conformes despues del onuNotifica_log:['||onuErrorCode||']',2);
            --.trace('Equipos No Conformes despues del onuNotifica_log:['||osbErrorText||']',2);

            if (onuErrorCode <>0 ) then
              ge_boerrors.seterrorcodeargument(2741,onuErrorCode||' - '||osbErrorText||'Equipos No Conformes: ge_bonotification.SendNotify');
            END if;
            commit;
            --.trace('Equipos No Conformes onuNotifica_log ['||onuNotifica_log||']');

            -- Levanta la forma de Impresi?n
            CC_BOPACKADDIDATE.RUNMOCNP(onuNotifica_log);

        else
            -- Obtiene el Id de la actividad.
             ge_boinstancecontrol.GetAttributeNewValue(sbInstance,null,'GE_LAB_TEMPLATE','ACTIVITY_ID',sbActivity);

             if sbActivity IS null then
               ge_boerrors.seterrorcodeargument(2741,'Es necesario que seleccione una Actividad de Ajuste. Para generar la Orden');
             else
               nuActivity := to_number(sbActivity);
             END if;

             --.trace('---------- [llozada] Paso 3. nuActivity ['||nuActivity||']',9);

             -- Obtiene la direcci?n de la orden dada la Orden Padre
             nuParsedAddressId :=  getAdressIdOrder(nuOrdenPadre) ;
             --.trace('---------- [llozada] Paso 4. nuParsedAddressId ['||nuParsedAddressId||']',9);

             -- Fecha estimada de Atenci?n de la nueva orden
             dtExecDate  := sysdate+1;
             --.trace('---------- [llozada] Paso 5. dtExecDate ['||dtExecDate||']',9);

             -- Se obtiene el usuario conectado
             nuCodUsuario := SA_BOUser.fnuGetUserId;

             -- Se obtiene la persona asociada al usuario conectado
             nuCodPersona := GE_BCPerson.fnuGetFirstPersonByUserId(nuCodUsuario);

             -- Comentario de la orden.
             sbComment := 'Orden de Ajuste de Laboratorio [Creada Mediante AJORLAB por el usuario '||
                          dage_person.fsbgetname_(nuCodPersona)||']';

             --.trace('---------- [llozada] Paso 6. sbComment ['||sbComment||']',9);

             OS_CREATEORDERACTIVITIES(
               nuActivity          ,
               nuParsedAddressId   ,
               dtExecDate          ,
               sbComment           ,
               nuReferenceValue    ,
               ionuOrderId         ,
               onuErrorCode        ,
               osbErrorMessage      );

             -- Muestra Error en el caso de que el API  OS_CREATEORDERACTIVITIES no pueda crear la orden
             if onuErrorCode <> 0 then
               ge_boerrors.seterrorcodeargument(2741,onuErrorCode||' - '||osbErrorMessage
                                                     ||'API OS_CREATEORDERACTIVITIES');
             else
                   rcOrder := daor_order.frcgetrecord(ionuOrderId);

                   nuOrderActivity:= getIdOrderActivity(nuOrdenPadre);
                   --.trace('Order_Activity_id [' ||nuOrderActivity||']',9) ;
                   nuOperUnitId   := daor_order_activity.fnugetoperating_unit_id(nuOrderActivity);

                   --[llozada - 220414] Se reemplaza por or_boprocessorder, ya que no esta funcionando
                   -- desde Smartflex
                   -- Api de Asignar Ordenes
                   /*OS_Assign_Order( ionuOrderId,
                                     nuOperUnitId,
                                     dtarrangedhour,
                                     dtchangedate,
                                     onuCodError,
                                     osbMessError );*/

                   or_boprocessorder.assign(rcOrder,
                                      nuOperUnitId,
                                      dtarrangedhour,
                                      FALSE,
                                      TRUE,
                                      null,
                                      null,
                                      null,
                                      null,
                                      null,
                                      dtchangedate);

                   -- Relaciona la orden Old con la orden New..
                   OS_Related_Order( ionuOrderId,
                                     nuOrdenPadre,
                                     onuErrorCode,
                                     osbErrorMessage)  ;

                    /*Actualiza el item serial id en OR_ORDER_ACTIVIDY para que se pueda legalizar la orden*/
                    UPDATE OR_order_activity
                    SET serial_items_id = onuIdItemSerido
                    WHERE ORDER_id = ionuOrderId;

                    --UPDATE OR_order_activity
                    --SET instance_id = onuIdItemSerido,

                    --WHERE ORDER_id = ionuOrderId;

                    /*Actualiza el item serial id en OR_ORDER_ITEMS*/
                    UPDATE or_order_items
                    SET serial_items_id = onuIdItemSerido
                    WHERE ORDER_id = ionuOrderId;

                   /*
                     Se Actualiza si necesita Ajuste, solo se puede Ajustar una sola vez *
                   */
                   UPDATE ldc_certmetr  set   cemeoraj = ionuOrderId , cemereaj = 'N'
                      WHERE  cemeorde = nuOrdenPadre;
                   commit;

             END if ;

        end if;

      /******************************************************************** */

     --.trace('finiliza LDC_BOmetrologia.sendOrderAjuste',9);

   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

   END sendOrderAjuste;


   /*Obtiene el nombre de la unidad operativa quien solicita*/
   function    fsbgetQuienSolicita
    (
     inuOrderId         in      OR_order.order_id%type
   )
   return varchar2
   IS

     nuItemSeriado              ge_items_seriado.id_items_seriado%type;
     nuOrderActivity            OR_order_activity.order_activity_id%type;
     nuOperUnitId               OR_order_activity.operating_unit_id%type;
     dtFechaRegOrd              OR_order.created_date%type;
     osbQuienSolici             varchar2(200) := ' ';
     nuExistMov                 number:=0;  -- no existen movimientos de inventario para ese item
     nuSolicitud                number:=0;

     --  Variables para manejo de Errores
     exCallService               EXCEPTION;
     sbCallService               varchar2(2000);
     sbErrorMessage              varchar2(2000);
     nuErrorCode                 number;

     -- Causa de movimiento de inventario Transito
     inuCausaMovimiento ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('LDC_MET_CAUSA_MOV_INV');

     -- CURSOR que obtiene la unidad operativa que solicita
     CURSOR cuMovInventa(inuItemSeriado in ge_items_seriado.id_items_seriado%type,
                            idtFechaRegOrd  in OR_order.created_date%type) IS
       select oper.name  QUIENSOLIC
       FROM open.OR_uni_item_bala_mov mov, open.or_operating_unit oper
       where mov.id_items_seriado = inuItemSeriado
       and item_moveme_caus_id = inuCausaMovimiento
       --and oper.oper_unit_classif_id <> 18 -- Que sea diferente a una unidad de laboratorio
       and mov.target_oper_unit_id = (select operating_unit_id
                                    from open.or_operating_unit a
                                    where mov.target_oper_unit_id = a.operating_unit_id
                                    and a.oper_unit_classif_id = 18)
       and oper.operating_unit_id = mov.operating_unit_id
       order by mov.move_date desc;

       cursor cuClienteExterno(inuOrder_id number) IS
       select package_id
       from or_order_activity
       where order_id = inuOrder_id;

   BEGIN

     open cuClienteExterno(inuOrderId);
     fetch cuClienteExterno into nuSolicitud;
     close cuClienteExterno;

     if  nuSolicitud is not null then
         return dage_subscriber.fsbgetsubscriber_name(
                ldc_boutilities.fsbgetvalorcampotabla('MO_PACKAGES','PACKAGE_ID','SUBSCRIBER_ID',nuSolicitud))
                ||' '||dage_subscriber.fsbgetsubs_last_name (
                ldc_boutilities.fsbgetvalorcampotabla('MO_PACKAGES','PACKAGE_ID','SUBSCRIBER_ID',nuSolicitud));
     else
         --.trace('Inicia LDC_BOmetrologia.getQuienSolicita',9);
         nuItemSeriado  := fnugetItemSeriadOrden(inuOrderId);
         --.trace('Item Seriado [' ||nuItemSeriado||']',9) ;
         nuOrderActivity:= getIdOrderActivity(inuOrderId);
         --.trace('Order_Activity_id [' ||nuOrderActivity||']',9) ;
         nuOperUnitId   := daor_order_activity.fnugetoperating_unit_id(nuOrderActivity);
         --.trace('Oper_unit_id dada la orden [' ||nuOperUnitId||']',9) ;
         dtFechaRegOrd  := daor_order.fdtgetcreated_date(inuOrderId);
         --.trace('Fecha de creaci?n de la Orden [' ||dtFechaRegOrd||']',9) ;

         for exac in cuMovInventa(nuItemSeriado,dtFechaRegOrd) loop
           nuExistMov:=1;
           osbQuienSolici := exac.QUIENSOLIC;
           exit;
         END loop;

         if nuExistMov <> 1 then
            --ge_boerrors.seterrorcodeargument(2741,'No hay movimientos de inventario para el Item Seriado: '||nuItemSeriado
              --                                    ||'. Recuerde que la Persona que Solicita se toma de los movimientos '
                --                                  ||'de inventario.' );
            return 'LABORATORIO';
         end if;

         --.trace('return ['||osbQuienSolici||']',9);
         return osbQuienSolici;

     end if;
     --.trace('finaliza LDC_BOmetrologia.getQuienSolicita',9);

   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

   END fsbgetQuienSolicita;

   /*Obtiene el ID de la unidad operativa quien solicita*/
   function    fnugetIDQuienSolicita
    (
     inuOrderId         in      OR_order.order_id%type
   )
   return number
   IS

     nuItemSeriado              ge_items_seriado.id_items_seriado%type;
     nuOrderActivity            OR_order_activity.order_activity_id%type;
     nuOperUnitId               OR_order_activity.operating_unit_id%type;
     dtFechaRegOrd              OR_order.created_date%type;
     osbQuienSolici             number;
     nuExistMov                 number:=0;  -- no existen movimientos de inventario para ese item
     nuSolicitud                number:=0;

     --  Variables para manejo de Errores
     exCallService               EXCEPTION;
     sbCallService               varchar2(2000);
     sbErrorMessage              varchar2(2000);
     nuErrorCode                 number;

     -- Causa de movimiento de inventario Transito
     inuCausaMovimiento ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('LDC_MET_CAUSA_MOV_INV');

     -- CURSOR que obtiene la unidad operativa que solicita
     CURSOR cuMovInventa(inuItemSeriado in ge_items_seriado.id_items_seriado%type,
                            idtFechaRegOrd  in OR_order.created_date%type) IS
       select oper.operating_unit_id  QUIENSOLIC
       FROM open.OR_uni_item_bala_mov mov, open.or_operating_unit oper
       where mov.id_items_seriado = inuItemSeriado
       and item_moveme_caus_id = inuCausaMovimiento
       --and oper.oper_unit_classif_id <> 18 -- Que sea diferente a una unidad de laboratorio
       and mov.target_oper_unit_id = (select operating_unit_id
                                    from open.or_operating_unit a
                                    where mov.target_oper_unit_id = a.operating_unit_id
                                    and a.oper_unit_classif_id = 18)
       and oper.operating_unit_id = mov.operating_unit_id
       order by mov.move_date desc;

   BEGIN
       --.trace('Inicia LDC_BOmetrologia.getQuienSolicita',9);
       nuItemSeriado  := fnugetItemSeriadOrden(inuOrderId);
       --.trace('Item Seriado [' ||nuItemSeriado||']',9) ;
       nuOrderActivity:= getIdOrderActivity(inuOrderId);
       --.trace('Order_Activity_id [' ||nuOrderActivity||']',9) ;
       nuOperUnitId   := daor_order_activity.fnugetoperating_unit_id(nuOrderActivity);
       --.trace('Oper_unit_id dada la orden [' ||nuOperUnitId||']',9) ;
       dtFechaRegOrd  := daor_order.fdtgetcreated_date(inuOrderId);
       --.trace('Fecha de creaci?n de la Orden [' ||dtFechaRegOrd||']',9) ;

       for exac in cuMovInventa(nuItemSeriado,dtFechaRegOrd) loop
         nuExistMov:=1;
         osbQuienSolici := exac.QUIENSOLIC;
         exit;
       END loop;

       if nuExistMov <> 1 then
          ge_boerrors.seterrorcodeargument(2741,'No hay movimientos de inventario para el Item Seriado: '||nuItemSeriado
                                                ||'. Recuerde que el Responsable se toma de los movimientos '
                                                ||'de inventario.' );
          --return 'LABORATORIO';
       end if;

       --.trace('return ['||osbQuienSolici||']',9);
       return osbQuienSolici;
     --.trace('finaliza LDC_BOmetrologia.getQuienSolicita',9);

   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

   END fnugetIDQuienSolicita;


    /*Obtiene la Direccion de la unidad operativa quien solicita*/
   function    fsbgetDirQuienSolicita
    (
     inuOrderId         in      OR_order.order_id%type
   )
   return varchar2
   IS


     nuItemSeriado              ge_items_seriado.id_items_seriado%type;
     nuOrderActivity            OR_order_activity.order_activity_id%type;
     nuOperUnitId               OR_order_activity.operating_unit_id%type;
     dtFechaRegOrd              OR_order.created_date%type;
     osbQuienSolici             varchar2(200) := ' ';
     nuExistMov                 number:=0;  -- no existen movimientos de inventario para ese item
     nuSolicitud                number:=0;

     --  Variables para manejo de Errores
     exCallService               EXCEPTION;
     sbCallService               varchar2(2000);
     sbErrorMessage              varchar2(2000);
     nuErrorCode                 number;

    -- Causa de movimiento de inventario Transito
     inuCausaMovimiento ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('LDC_MET_CAUSA_MOV_INV');

     -- CURSOR que obtiene la unidad operativa que solicita
     CURSOR cuMovInventa(inuItemSeriado in ge_items_seriado.id_items_seriado%type,
                            idtFechaRegOrd  in OR_order.created_date%type) IS
       select oper.address  QUIENSOLIC
       FROM open.OR_uni_item_bala_mov mov, open.or_operating_unit oper
       where mov.id_items_seriado = inuItemSeriado
       and item_moveme_caus_id = inuCausaMovimiento
       --and oper.oper_unit_classif_id <> 18 -- Que sea diferente a una unidad de laboratorio
       and mov.target_oper_unit_id = (select operating_unit_id
                                    from open.or_operating_unit a
                                    where mov.target_oper_unit_id = a.operating_unit_id
                                    and a.oper_unit_classif_id = 18)
       and oper.operating_unit_id = mov.operating_unit_id
       order by mov.move_date desc;

       cursor cuClienteExterno(inuOrder_id number) IS
       select package_id
       from or_order_activity
       where order_id = inuOrder_id;

   BEGIN

     open cuClienteExterno(inuOrderId);
     fetch cuClienteExterno into nuSolicitud;
     close cuClienteExterno;

     if  nuSolicitud is not null then
         return ldc_boutilities.fsbgetvalorcampotabla('MO_ADDRESS','PACKAGE_ID','ADDRESS',nuSolicitud);
     else
         --.trace('Inicia LDC_BOmetrologia.getDirQuienSolicita',9);
         nuItemSeriado  := fnugetItemSeriadOrden(inuOrderId);
         --.trace('Item Seriado [' ||nuItemSeriado||']',9) ;
         nuOrderActivity:= getIdOrderActivity(inuOrderId);
         --.trace('Order_Activity_id [' ||nuOrderActivity||']',9) ;
         nuOperUnitId   := daor_order_activity.fnugetoperating_unit_id(nuOrderActivity);
         --.trace('Oper_unit_id dada la orden [' ||nuOperUnitId||']',9) ;
         dtFechaRegOrd  := daor_order.fdtgetcreated_date(inuOrderId);
         --.trace('Fecha de creaci?n de la Orden [' ||dtFechaRegOrd||']',9) ;

         for exac in cuMovInventa(nuItemSeriado,dtFechaRegOrd) loop
           nuExistMov:=1;
           osbQuienSolici := exac.QUIENSOLIC;
           exit;
         END loop;

         if nuExistMov <> 1 then
            return daor_operating_unit.fsbgetaddress(799);
         end if;

         --.trace('return ['||osbQuienSolici||']',9);
         return osbQuienSolici;

     end if;
     --.trace('finaliza LDC_BOmetrologia.getQuienSolicita',9);

   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

   END fsbgetDirQuienSolicita;

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : fsbgetDirCompany
      Descripcion    : Obtiene la dirección de unidad operativa de laboratorio
      Caso           : FANA492
      Autor          : Llozada
      Fecha          : 26/06/2013

      Parametros              Descripcion
      ============         ===================
      inuOrderId           Código de la Orden

      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
      15-07-2014        llozada           Se ajusta la función para que tome la dirección
                                          de la unidad operativa de laboratorio y no de la
                                          persona responsable.
    ******************************************************************/
   function    fsbgetDirCompany
    (
     inuOrderId         in      OR_order.order_id%type
   )
   return varchar2
   IS
     osbQuienSolici             varchar2(200) := ' ';
     nuUnidadLab                number:=0;
     sbDirecccion               or_operating_unit.address%type;

     --  Variables para manejo de Errores
     exCallService               EXCEPTION;
     sbCallService               varchar2(2000);
     sbErrorMessage              varchar2(2000);
     nuErrorCode                 number;

       /*cursor cuDirPerson(iperson_id number) IS
       select a.address_id
       from ab_address a, ge_person b
       where b.person_id = iperson_id
       AND a.address_id  = b.address_id;*/

   BEGIN

    nuUnidadLab := fnuObtValorParametro(csbLaboratorio);

    sbDirecccion := daor_operating_unit.fsbgetaddress(nuUnidadLab,null);

    if sbDirecccion IS null then
        ge_boerrors.seterrorcodeargument(2741,'Debe ingresar una Dirección para '||
                                              ' la unidad operativa responsable del Laboratorio. ['||nuUnidadLab||
                                              ' - '||daor_operating_unit.fsbgetname(nuUnidadLab) ||']');
    END if;

    return sbDirecccion;
    --daab_address.fsbgetaddress_parsed(nuDirecccion)
    --||', '||dage_geogra_location.fsbgetdescription(daab_address.fnugetneighborthood_id(nuDirecccion))
    --||', '||dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id (nuDirecccion));

   EXCEPTION
     when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

   END fsbgetDirCompany;


   /*OBTIENE la fecha de recepci?n del elemento cuando llega a el laboratorio */

   FUNCTION fdtgetFechaRecepcion
   (
     inuOrderId          in      OR_order.order_id%type
   )return varchar2
   IS
     nuItemSeriado              ge_items_seriado.id_items_seriado%type;
     nuOrderActivity            OR_order_activity.order_activity_id%type;
     nuOperUnitId               OR_order_activity.operating_unit_id%type;
     dtFechaRegOrd              OR_order.created_date%type;
     odtFechaRecep              varchar2(200) := ' ';
     nuExistMov                 number:=0;  -- no existen movimientos de inventario para ese item

     --  Variables para manejo de Errores
     exCallService               EXCEPTION;
     sbCallService               varchar2(2000);
     sbErrorMessage              varchar2(2000);
     nuErrorCode                 number;
     -- CURSOR
     CURSOR cuMovInventa --(inuItemSeriado in ge_items_seriado.id_items_seriado%type,
                            --inuOperUnitId  in OR_order_activity.operating_unit_id%type,
                         --   idtFechaRegOrd  in OR_order.created_date%type)
     IS
       --Se toma la fecha de recepcion de la orden.
       --Validado con el funcional Carlos Sanchez
       --Correo enviado 14-02-2014, Asunto Fecha de Recepcion por fecha asignacion de la orden
       SELECT assigned_date
       FROM OR_order
       WHERE ORDER_id = inuOrderId;

       /*select MOVE_DATE
       FROM open.OR_uni_item_bala_mov mov, open.or_operating_unit oper
       where mov.id_items_seriado = inuItemSeriado
       --and item_moveme_caus_id = 28
       --and oper.oper_unit_classif_id <> 18 -- Que sea diferente a una unidad de laboratorio
       and mov.target_oper_unit_id = (select operating_unit_id
                                    from open.or_operating_unit a
                                    where mov.target_oper_unit_id = a.operating_unit_id
                                    and a.oper_unit_classif_id = 18)
       and oper.operating_unit_id = mov.operating_unit_id
       order by mov.move_date desc;*/

   BEGIN
     --.trace('Inicia  LDC_BOmetrologia.fdtgetFechaRecepcion',9) ;
     dtFechaRegOrd  := daor_order.fdtgetcreated_date(inuOrderId);
     nuItemSeriado  := fnugetItemSeriadOrden(inuOrderId);
     --.trace('Fecha de creaci?n de la Orden [' ||dtFechaRegOrd||']',9) ;

     for exac in cuMovInventa --(nuItemSeriado,dtFechaRegOrd)
     loop
       nuExistMov:=1;
       --odtFechaRecep := exac.MOVE_DATE;
       odtFechaRecep := exac.assigned_date;
       exit;
     END loop;

     if nuExistMov <> 1 then
        --ge_boerrors.seterrorcodeargument(2741,'No hay movimientos de inventario para el Item Seriado: '||nuItemSeriado
          --                                    ||'. Recuerde que la fecha de recepci?n se toma de los movimientos '
            --                                  ||'de inventario.' );
        return sysdate; --to_char(sysdate,'yyyy/mm/dd'); --sysdate;
     end if;

     return odtFechaRecep; --to_char(odtFechaRecep,'yyyy/mm/dd');

     --.trace('Finaliza  LDC_BOmetrologia.fdtgetFechaRecepcion',9) ;

   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);
   END ;


   /*OBTIENE la persona que calibra*/
   FUNCTION fsbGetCalibradoPor
   (
    inuOrderId          in      OR_order.order_id%type
   ) return varchar2
   IS

     osbCalibradPor             ge_person.name_%type:= ' ';
     nuExisPerson               number:=0;
     --  Variables para manejo de Errores
     exCallService               EXCEPTION;
     sbCallService               varchar2(2000);
     sbErrorMessage              varchar2(2000);
     nuErrorCode                 number;

     CURSOR cuCalibrPor(inuOrderId   in   OR_order.order_id%type)
     IS
        SELECT  p.name_  name
        FROM open.or_order_person o, ge_person p
        WHERE o.ORDER_id = inuOrderId
         AND p.person_id = o.person_id
         AND o.person_id IS not null;


     -- CURSOR
     /*CURSOR cuCalibrPor(inuOrderId   in   OR_order.order_id%type) IS
       SELECT p.name_  name
       FROM or_order_comment o, ge_person p
         where o.ORDER_id = inuOrderId
         AND p.person_id = o.person_id
         AND o.person_id IS not null
         AND rownum = 1; */

   BEGIN
     --.trace('Inicia  LDC_BOmetrologia.fsbGetCalibradoPor',9) ;

     for exac in cuCalibrPor(inuOrderId) loop
       nuExisPerson:=1;
       osbCalibradPor := exac.name;
     END loop;

     return osbCalibradPor;
     --.trace('Finaliza  LDC_BOmetrologia.fsbGetCalibradoPor',9) ;
   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

   END fsbGetCalibradoPor;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fsbGetCargoCalibradoPor
    Descripcion : Devuelve el cargo de la persona que calibra el equipo
    Autor       : llozada
    Fecha       : 15-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    15-08-2014          llozada              Creaci?n.
    **************************************************************************/
   FUNCTION fsbGetCargoCalibradoPor
   (
    inuOrderId          in      OR_order.order_id%type
   ) return varchar2
   IS

     osbCargoCalibradPor        ge_position_type.description%type;
     osbCalibradPor             ge_person.name_%type:= ' ';
     nuExisPerson               number:=0;
     --  Variables para manejo de Errores
     exCallService               EXCEPTION;
     sbCallService               varchar2(2000);
     sbErrorMessage              varchar2(2000);
     nuErrorCode                 number;

     CURSOR cuCalibrPor
     IS
        SELECT  dage_position_type.fsbgetdescription(p.POSITION_TYPE_ID,null), p.name_
        FROM open.or_order_person o, ge_person p
        WHERE o.ORDER_id = inuOrderId
         AND p.person_id = o.person_id
         AND o.person_id IS not null;

   begin

        open cuCalibrPor;
        fetch cuCalibrPor into osbCargoCalibradPor,osbCalibradPor;
        close cuCalibrPor;

        if osbCargoCalibradPor is not null then
            return osbCargoCalibradPor;
        end if;

        ge_boerrors.seterrorcodeargument(2741,'La persona que calibra el equipo ['||osbCalibradPor||
                                              '] NO tiene configurado un cargo en SAASE. Por favor asigne un cargo'||
                                              ' a esta persona o solicitelo al frente de seguridad.');

   end fsbGetCargoCalibradoPor;


   /* Obtiene el n?mero del elemento  */
   FUNCTION fnugetNumeroElemento
   (
     inuOrderId           in       OR_order.order_id%type
   ) return varchar2
   IS
     nuPlanTemp                    ge_variable_template.variable_template_id%type;
     nuItemSeriado                 ge_items_seriado.id_items_seriado%type;
     nuVaceCodi                    ldc_variattr.vaatvaat%type;
     onuVacecodi                   ldc_varicert.vacecodi%type;
     osbVaceVaat                   ldc_varicert.vacevaat%type;
     onuCodElement                 varchar2(200) := 0;
     osbNumber                     or_order_act_var_det.value%type := ' ';
     sbTipoLab                               varchar2(2000);
     nuActividad                    number;

     --  Variables para manejo de Errores
     exCallService                 EXCEPTION;
     sbCallService                 varchar2(2000);
     sbErrorMessage                varchar2(2000);
     nuErrorCode                   number;

     CURSOR cuActividadManten(inuOrder OR_order.order_id%type)
     IS
        SELECT unique activity_id
        FROM or_order_activity, ge_items
        WHERE ORDER_id = inuOrder
        AND activity_id IS not null
        AND upper(description) like 'MANTENIMIENTO%'
        AND activity_id = items_id;

   BEGIN

     open cuActividadManten(inuOrderId);
     fetch cuActividadManten INTO nuActividad;
     close cuActividadManten;

     if nuActividad > 0 then
        return LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,fnuObtValorParametro(csbReporteNumero)) ;
     END if;

     --.trace('Inicia ldc_bometrologia.fnugetNumeroElemento',9);

     sbTipoLab := fnugetTipoLab(inuOrderId); --FSBGETNOMBRELABORATORIO(inuOrderId); --

     if  sbTipoLab = csbPlanchas OR sbTipoLab = csbOrificios then
         osbNumber := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,
                fnuObtValorParametro(csbInforme)) ;
     else
         ldc_bometrologia.getVacecodiVacevaat(csbNumeroCertifi ,onuVacecodi,osbVaceVaat)  ;
         --.trace('Identificador interno ldc_varicert ['||onuVacecodi
               --          ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
         dbms_output.put_Line('Identificador interno ldc_varicert ['||onuVacecodi
                         ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat);

         nuPlanTemp :=fnugetIdPlanilla(inuOrderId);
         nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);
         dbms_output.put_Line('Plantilla '||nuPlanTemp);
         dbms_output.put_Line('nuVaceCodi ' ||nuVaceCodi);

         if osbVaceVaat = 'V' then -- si es una variable
           dbms_output.put_Line('Variable');
           osbNumber := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
           dbms_output.put_Line(osbNumber);
         else
           nuItemSeriado  := fnugetItemSeriadOrden(inuOrderId);
           --.trace('Item Seriado [' ||nuItemSeriado||']',9) ;
           osbNumber := LDC_BOmetrologia.fsbgetValAttribute (nuItemSeriado,nuVaceCodi);
         END if;
         --.trace('N?mero Cert[' ||onuCodElement||']',9) ;
         dbms_output.put_Line('N?mero Cert[' ||onuCodElement||']');
     end if;

     return  osbNumber;

     --.trace('Finaliza ldc_bometrologia.fnugetNumeroElemento',9);

   EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

   END fnugetNumeroElemento;


    /*OBTIENE el codigo del elemento*/
   FUNCTION fnugetCodigoElemento
   (
    inuOrderId           in        OR_order.order_id%type
   ) return varchar2
   IS
     nuPlanTemp                    ge_variable_template.variable_template_id%type;
     nuItemSeriado                 ge_items_seriado.id_items_seriado%type;
     nuVaceCodi                    ldc_variattr.vaatvaat%type;
     onuVacecodi                   ldc_varicert.vacecodi%type;
     osbVaceVaat                   ldc_varicert.vacevaat%type;
     onuCodElement                 varchar2(200) := 0;

           --  Variables para manejo de Errores
      exCallService                      EXCEPTION;
      sbCallService                      varchar2(2000);
      sbErrorMessage                     varchar2(2000);
      nuErrorAttribu                     number := 0;
      nuErrorCode                        number;

   BEGIN
     --.trace('Inicia ldc_bometrologia.fnugetCodigoElemento',9);

     ldc_bometrologia.getVacecodiVacevaat(csbCodigoElement ,onuVacecodi,osbVaceVaat)  ;
     --.trace('Identificador interno ldc_varicert ['||onuVacecodi
            --         ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);

     nuPlanTemp :=fnugetIdPlanilla(inuOrderId);
     nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);
     dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');

     if osbVaceVaat = 'V' then -- si es una variable
     dbms_output.put_line('***************** antes 1: '||onuCodElement);
       onuCodElement := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
            dbms_output.put_line('***************** 1: '||onuCodElement);
     else
       nuItemSeriado  := fnugetItemSeriadOrden(inuOrderId);
       --.trace('Item Seriado [' ||nuItemSeriado||']',9) ;
       dbms_output.put_line('***************** antes 2: '||nuItemSeriado||' '||nuVaceCodi);
       onuCodElement := LDC_BOmetrologia.fsbgetValAttribute(nuItemSeriado,nuVaceCodi);
            dbms_output.put_line('***************** 2: '||onuCodElement);
     END if;

     --.trace('Codigo_elemento [' ||onuCodElement||']',9) ;
     return onuCodElement;

     ----.trace('Finaliza ldc_bometrologia.fnugetCodigoElemento',9);
    /*EXCEPTION
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage); */
   END fnugetCodigoElemento;


   /*Obtiene la Descripci?n del Rango */
   FUNCTION fsbgetDescRangodelElemento
   (
     inuOrderId     in    OR_order.order_id%type,
     inuItemSeriado IN    ge_items_seriado.id_items_seriado%type
   )  return varchar2
   IS
     nuDifRang  varchar2(4000) := ' ';

      inuPlanTemp                         ge_variable_template.variable_template_id%type;
      nuVaceCodi                          ldc_variattr.vaatvaat%type;
      onuVacecodi                         ldc_varicert.vacecodi%type;
      osbVaceVaat                         ldc_varicert.vacevaat%type;


   BEGIN
      --.trace('Inicia LDC_BOmetrologia.fngetRangodelElemento',9)  ;
       -- Obtiene la descripci?n del rango
       ldc_bometrologia.getVacecodiVacevaat(csbRangoMediDesc ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                --     ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
      /*Obtiene el Id del Tipo de Certificado que se debe imprimir*/
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId);
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
       dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');

       if  osbVaceVaat = 'V' then -- si es una variable
         nuDifRang := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else
         nuDifRang  :=  LDC_BOmetrologia.fsbgetValAttribute (inuItemSeriado,nuVaceCodi);
       END if;
       --.trace('Rango Item Seriado'||nuDifRang );
      return  nuDifRang;

   END fsbgetDescRangodelElemento;


   /*OBTIENE EL rango de Medici?n del elemento que se esta Calibrando*/
   FUNCTION fnugetRangoMedicion
   (
     inuOrderId     in    OR_order.order_id%type,
     inuItemSeriado IN    ge_items_seriado.id_items_seriado%type
   ) return number
   IS
     nuRango  number :=0;
     nuDifRang  number := 0;

      inuPlanTemp                         ge_variable_template.variable_template_id%type;
      nuVaceCodi                          ldc_variattr.vaatvaat%type;
      onuVacecodi                         ldc_varicert.vacecodi%type;
      osbVaceVaat                         ldc_varicert.vacevaat%type;
      nuRangoFinal                        ldc_varicert.vacecodi%type;
      nuError                             number:=-1;

   BEGIN
         -- --.init;
        ----.setlevel(99);
        ----.setoutput(--.fntrace_output_db);
     --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetRangoMedicion} ',8);
      --ldc_bometrologia.getVacecodiVacevaat(csbRangMaxMed ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
               --      ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);

      /*Obtien el Id del certificado a Imprimir */
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       nuVaceCodi := fnuObtValorParametro(csbRangInic); --ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
        --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetRangoMedicion} nuVaceCodi: '||nuVaceCodi,8);
       nuRangoFinal := fnuObtValorParametro(csbRangFinal);
        --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetRangoMedicion} nuRangoFinal: '||nuRangoFinal,8);
       --nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);
       dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');

       -- 11/10/13: Para el rango se definen 2 parametros

       /*if  osbVaceVaat = 'V' then -- si es una variable
         nuDifRang := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else*/

       begin
            nuDifRang  :=  to_number(LDC_BOmetrologia.fsbgetValAttribute (inuItemSeriado,nuVaceCodi));
             --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetRangoMedicion} nuDifRang: '||nuDifRang,8);
            nuRangoFinal := to_number(LDC_BOmetrologia.fsbgetValAttribute (inuItemSeriado,nuRangoFinal));
             --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetRangoMedicion} nuRangoFinal: '||nuRangoFinal,8);
       exception
       when others then
            nuRango := -1;
       end;
       --END if;

    -- Obtiene el rango del Elemento que se esta calibrando
      nuRango:= nuRangoFinal - nuDifRang;
      --.trace ('Rango del Elemento  ['||nuRango||']',8) ;
      nuError := 0;

      return nuRango;
  /* exception
    when others then
        if(nuError = -1) then
            sbErrorMessage := 'ERROR, No se encuentra un valor para el RANGO DE MEDICION del elemento a calibrar.';
        end if;*/
   END fnugetRangoMedicion;

   /*Obtiene las observaci?n de la planilla */
   FUNCTION fnugetObservacion
   (
    inuOrderId          in       OR_order.order_id%type
   )return varchar2
   IS
      nuPlanTemp                 ge_variable_template.variable_template_id%type;
      sbValObserv                or_order_act_var_det.value%type;
      nuVaceCodi                 ldc_variattr.vaatvaat%type;
      onuVacecodi                ldc_varicert.vacecodi%type;
      osbVaceVaat                ldc_varicert.vacevaat%type;
   BEGIN
     --.trace ('Inicia LDC_BOmetrologia.fnugetObservacion',8) ;

      ldc_bometrologia.getVacecodiVacevaat(csbObservacion ,onuVacecodi,osbVaceVaat)  ;

      --.trace('Identificador interno ldc_varicert ['||onuVacecodi
            --         ||'] Es una variable (V) o un Atrivuto (A)  ['||osbVaceVaat||']',9);

      dbms_output.put_Line('Identificador interno ldc_varicert ['||onuVacecodi
                     ||'] Es una variable (V) o un Atrivuto (A)  ['||osbVaceVaat||']');
     /*Obtien el Id del certificado a Imprimir */
      nuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;

      if  osbVaceVaat = 'V' then -- si es una variable
        nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp);
        dbms_output.put_Line('nuVaceCodi ['||nuVaceCodi||']');
        sbValObserv := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
      else
        -- llamar obtener atributos**
        null;
      END if;
     --.trace ('Valor de la Observaci?n  ['||sbValObserv||']',8) ;

     --.trace ('Finaliza LDC_BOmetrologia.fnugetObservacion',8) ;
     return sbValObserv;
   exception
        when others then
            return 'N/A';
   END fnugetObservacion;


     /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fnugetPorErroMax
    Descripcion : Obtiene el porcentaje de error M?ximo
    Autor       : mmesa
    Fecha       : 02-02-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    18-10-2014          Llozada            Se toma el valor absoluto del porcentaje de error máximo
    14-10-2014          Llozada            Se realiza el cálculo con las cifras significativas.
    02-02-2014          mmesa              Creaci?n.
    18-09-2014          llozada            Se quita la incertidumbre de la formula del porcentaje de error
    **************************************************************************/
   FUNCTION fnugetPorErroMax
   (
    inuOrderId       in      OR_order.order_id%type
   )
   return number
   IS
     nuPorcErrorMax   number;
      sbTipoLab                               varchar2(2000);
      nuDifMax number;
   BEGIN

    ----.init;
      --  --.setlevel(99);
        ----.setoutput(--.fntrace_output_db);
     --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetPorErroMax} ',8);

        -- Obtiene el tipo de Laboratorio
      sbTipoLab := fnugetTipoLab (inuOrderId); --FSBGETNOMBRELABORATORIO(inuOrderId);
      --.TRACE('[METROLOGIA] {LDC_BOmetrologia.fnugetPorErroMax} sbTipoLab: '||sbTipoLab,8);

      IF sbTipoLab like '%'||csbConcentracion||'%' THEN
        RETURN 0;
      END IF;

      --.TRACE(' -+-+-+-+-+-+-+-+-+-++-+-+-[METROLOGIA] {LDC_BOmetrologia.fnugetPorErroMax} fnugetDiferenciaMax (inuOrderId): '||LDC_BOmetrologia.fnugetDiferenciaMax (inuOrderId),8);
      --.TRACE(' -+-+-+-+-+-+-+-+-+-++-+-+-[METROLOGIA] {LDC_BOmetrologia.fnugetPorErroMax} fnugetRangoMedicion ( inuOrderId: '||
             --   LDC_BOmetrologia.fnugetRangoMedicion ( inuOrderId,
           --    LDC_BOmetrologia.fnugetItemSeriadOrden(inuOrderId) ),8);

           --18-09-2014: llozada
      -- LDC_BOmetrologia.fnugetUexp_Incertidumbre(inuOrderId))
      --LDC_BOmetrologia.fnugetDiferenciaMax (inuOrderId) /
      /*14-10-2014 Llozada[NC 2328]: Se realiza el cálculo con las cifras significativas*/
      nuDifMax :=  to_number(LDC_BOMETROLOGIA.fsbCifrasDeci(fsbGetIncertCifrasSig(inuOrderId),
                            fnugetDiferenciaMax(inuOrderId)));

      nuPorcErrorMax := nuDifMax /
                LDC_BOmetrologia.fnugetRangoMedicion ( inuOrderId,
               LDC_BOmetrologia.fnugetItemSeriadOrden(inuOrderId) ) * cnu100;

     --llozada, 18-10-2014: Se toma el valor absoluto del porcentaje de error máximo
        if LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbNombreEntrega2328)
        or LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbNombreEntrega2328)
        or LDC_CONFIGURACIONRQ.aplicaParaGDC(sbNombreEntrega2328)
        or LDC_CONFIGURACIONRQ.aplicaParaGDO(sbNombreEntrega2328) then
            --Valor absoluto del porcentaje de error máximo
            nuPorcErrorMax := abs(nuPorcErrorMax);

        end if;

     return  nuPorcErrorMax;
   END fnugetPorErroMax;

   FUNCTION fnugetPorErrorMaxAjus(inuOrderId       in      OR_order.order_id%type)
   return number
   IS
        nuOrderAj   OR_order.order_id%type;
   BEGIN
        -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

        if nuOrderAj > 0 then
            return ldc_bometrologia.fnugetPorErroMax(nuOrderAj);
        else
            return 0;
        END if;
   END fnugetPorErrorMaxAjus;


    /* Devuelve la unidad de medida de Elemento */
    FUNCTION fsbgetUnidadMedida
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2
    IS

      sbUnidadMed                             ge_items_tipo_at_val.valor%type;
      inuPlanTemp                             ge_variable_template.variable_template_id%type;
      nuVaceCodi                              ldc_variattr.vaatvaat%type;
      onuVacecodi                             ldc_varicert.vacecodi%type;
      osbVaceVaat                             ldc_varicert.vacevaat%type;
      sbTipoLab                               varchar2(2000);

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fsbgetUnidadMedida',8);

       ldc_bometrologia.getVacecodiVacevaat(csbUnidadMedida ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                     --||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       -- Obtiene el ID de certificado que se debe imprimir.
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

       if  osbVaceVaat = 'V' then -- si es una variable
         --                   ID DE LA VARIABLE, ID DE LA PLANILLA QUE ESTA UTILIZANDO
         sbUnidadMed := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else
       -- llamar obtener atributos**
         sbUnidadMed := fsbgetValorAtributo(inuOrderId,nuVaceCodi)  ;
       END if;

       --LOZADA: Se debe pasar la unidad como llega para Cocentracion
       -- Obtiene el tipo de Laboratorio
      /*sbTipoLab := fnugetTipoLab (inuOrderId);

      IF sbTipoLab = csbConcentracion THEN
        if sbUnidadMed like '%CH4' then
            sbUnidadMed := '%LEL';
        else
            sbUnidadMed := 'PPM CO';
        END if;
      END IF;*/

      return  sbUnidadMed;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetUnidadMedida',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetUnidadMedida;

    /* Devuelve la unidad de medida del Patron */
    FUNCTION fsbgetUnidadMedidaPatron
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2
    IS

      sbUnidadMed                             ge_items_tipo_at_val.valor%type;
      inuPlanTemp                             ge_variable_template.variable_template_id%type;
      nuVaceCodi                              ldc_variattr.vaatvaat%type;
      onuVacecodi                             ldc_varicert.vacecodi%type;
      osbVaceVaat                             ldc_varicert.vacevaat%type;
      sbTipoLab                               varchar2(2000);

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);

      nuItSeriPatron                          ge_items_seriado.id_items_seriado%type;
    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fsbgetUnidadMedida',8);

       nuItSeriPatron := LDC_BOmetrologia.fnugetElemntoPatron(inuOrderId);

       ldc_bometrologia.getVacecodiVacevaat(csbUnidadMedida ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
              --       ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);

       -- Obtiene el ID de certificado que se debe imprimir.
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;

       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

       -- llamar obtener atributos**
       sbUnidadMed := LDC_BOmetrologia.fsbgetValAttribute (nuItSeriPatron,nuVaceCodi);

       --LOZADA: Se debe pasar la unidad como llega para Cocentracion
       -- Obtiene el tipo de Laboratorio
      /*sbTipoLab := fnugetTipoLab (inuOrderId);

      IF sbTipoLab = csbConcentracion THEN
        if sbUnidadMed like '%CH4' then
            sbUnidadMed := '%LEL';
        else
            sbUnidadMed := 'PPM CO';
        END if;
      END IF;*/
      return  sbUnidadMed;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetUnidadMedida',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetUnidadMedidaPatron;

    /*
      Devuelve la Fecha de Calibraci?n */
    FUNCTION fsbgetFechaCalibrac
     (
       inuOrderId       in       OR_order.order_id%type
     )
    return VARCHAR2
    IS

      sbUnidadMed                         ge_items_tipo_at_val.valor%type;
      inuPlanTemp                         ge_variable_template.variable_template_id%type;
      nuVaceCodi                          ldc_variattr.vaatvaat%type;
      onuVacecodi                         ldc_varicert.vacecodi%type;
      osbVaceVaat                         ldc_varicert.vacevaat%type;

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);
    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fsbgetUnidadMedida',8);

       /*ldc_bometrologia.getVacecodiVacevaat(csbFechaCalibrac ,onuVacecodi,osbVaceVaat)  ;
       --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                     ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
       -- Obtiene el ID de certificado que se debe imprimir.
       inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;
       nuVaceCodi := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

       if  osbVaceVaat = 'V' then -- si es una variable
         --                   ID DE LA VARIABLE, ID DE LA PLANILLA QUE ESTA UTILIZANDO
         sbUnidadMed := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuVaceCodi) ;
       else
       -- llamar obtener atributos**
         sbUnidadMed := fsbgetValorAtributo(inuOrderId,nuVaceCodi)  ;
       END if;  */
        sbUnidadMed := sysdate;

      return  sbUnidadMed;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetUnidadMedida',8) ;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbgetFechaCalibrac;

    /*
      Obtiene el n?mero de Orden dado el n?mero de Certificado */
    FUNCTION getOrderByNumCert
    (
       isbNumCert   or_order_act_var_det.value%type
    )return number
    IS

      CURSOR cuObtiOrder ( inuNumCert   in   OR_order_act_var_det.value%type) IS
        SELECT ORDER_id FROM or_order_act_var_det
         where variable_id = cnuVariNumCert
         AND value = isbNumCert
         AND rownum = 1;

      onuOrderId     OR_order.order_id%type;
      nuExistError   number := 0;
    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.getOrderByNumCert',8);

      for e in cuObtiOrder(isbNumCert) loop
        nuExistError:=1;
        onuOrderId := e.ORDER_id;
      END loop;

      if nuExistError = 0 then
            ge_boerrors.seterrorcodeargument(2741,'El n?mero de certificado ingresado No '||
                                                   'corresponde a una ORDEN del sistema. '||
                                                   'Verifique que la ORDEN se encuentre registrada en el sistema.');
      end if;

      return  onuOrderId;

      --.trace ('Finaliza LDC_BOmetrologia.fsbgetUnidadMedida',8);

    END getOrderByNumCert;

    /***************************************************************************
     Método :       valCertAjuste
     Descripción:   Valida si es una orden de ajuste

     Autor       :  Luis Lozada
     Fecha       :  07-10-2014

     Historia de Modificaciones

    Fecha          Autor           Modificación
    ===========    ==========      =============================================
    11-12-2015     Mmejia          SAO.358555 Se modifica la funcion para que el cursor
                                   cuObtiOrderIdAj consulta la orden de ajuse de una
                                   principal o devuelva la misma orden si la orden
                                   ingresada es de ajuste.
    ***************************************************************************/
    FUNCTION valCertAjuste
    (
       inuOrderId   in   OR_order.order_id%type
    )
    return number
    IS

       CURSOR cuObtiOrderIdAj ( inuOrderId   in   OR_order.order_id%type) IS
        SELECT ORDER_id FROM or_related_order
         WHERE (related_order_id = inuOrderId OR ORDER_id= inuOrderId)
         AND RELA_ORDER_TYPE_id = fnuObtValorParametro(csbCodRelaAjuste);

         --AND rownum < 2;

       onuOrderAj     OR_order.order_id%type := 0;
       nuExistError   number := 0;
    BEGIN
        ----.init;
        ----.setlevel(99);
        ----.setoutput(--.fntrace_output_db);
      --.trace('Inicia LDC_BOmetrologia.valCertAjuste',9);

      open cuObtiOrderIdAj(inuOrderId);
      fetch cuObtiOrderIdAj INTO  onuOrderAj;
      close cuObtiOrderIdAj;

      if onuOrderAj is null then
        --.trace('Inicia IF LDC_BOmetrologia.valCertAjuste 0.0',9);
         return 0;
      else
        --.trace('Inicia ELSE LDC_BOmetrologia.valCertAjuste -'||onuOrderAj,9);
         return onuOrderAj;
      end if;

    END valCertAjuste;

    /*Valida si el equipo es Bimetalico o Electrico*/
    FUNCTION tipoItemTemperatura(inuorderId OR_order.order_id%type)
    return varchar2
    IS
        nuSerialItemsId         number;
        nuItemsId               number;
        csbTipoEquipo           varchar(1000);
        nuCodEquiTemp           number;

        CURSOR cuEquivalencia(inuEquiId GE_EQUIVALENC_VALUES.equivalence_set_id%type,
                            inuItem   GE_EQUIVALENC_VALUES.origin_value%type) IS
            select target_value
            from GE_EQUIVALENC_VALUES
            where equivalence_set_id = inuEquiId
            and origin_value = inuItem;
    BEGIN
        nuSerialItemsId := LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('OR_ORDER_ACTIVITY', 'ORDER_ID', 'SERIAL_ITEMS_ID', inuOrderId);
        nuItemsId := dage_items_seriado.fnugetitems_id(nuSerialItemsId);

        nuCodEquiTemp := fnuObtValorParametro(csbEQUI_EQUIPOS_TEMPERA);

        open cuEquivalencia(nuCodEquiTemp, nuItemsId);
        fetch cuEquivalencia INTO csbTipoEquipo;
        close cuEquivalencia;

        if (csbTipoEquipo is null) then
            --.trace(' ----------------------- NO CONFIGURADO ITEM EN EQUIVALENCIA DE TEMPERATURA',2);
            ge_boerrors.seterrorcodeargument (2741,'No se ha configurado la equivalencia para el ?TEM '||
                                              nuItemsId||', esto debe hacerse para determinar '||
                                              'SI el equipo es BIMET?LICO o EL?CTRICO. '||
                                              'Para configurar la equivalencia debe ir a la forma '||
                                              '[GEAGE/GRUPOS DE EQUIVALENCIA], buscar por el c?digo: '||nuCodEquiTemp||
                                              '; Y adicionar el ?TEM en la pesta?a DATOS DE GRUPO DE EQUIVALENCIA.')  ;
        end if;

        return csbTipoEquipo;

    END tipoItemTemperatura;

      /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : fnugetUexp_Incertidumbre
      Descripcion    : Calcula la incertidumbre para el equipo que se esta calibrando

      Autor          : Llozada
      Fecha          : 14/07/2013

      Parametros              Descripcion
      ============         ===================
      inuOrderId           Codigo de la orden

      Historia de Modificaciones
      Fecha             Autor           Modificacion
      =========         =========       ====================
      23-01-2015       Llozada [NC 3976] El cálculo de la resolución depende del tipo de elemento
      30-07-2014        llozada         Se incluye las 3 lecturas del instrumento en los cálculos
                                        esta validación solo aplica para SURTIGAS.
    ******************************************************************/
    procedure temperatura (inuOrderId OR_order.order_id%type) IS

        sub_nom_1               number;
        sub_nom_2               number;
        sub_nom_3               number;
        sub_nom_4               number;
        sub_nom_5               number;
        baj_nom_1               number;
        baj_nom_2               number;
        baj_nom_3               number;
        baj_nom_4               number;
        baj_nom_5               number;
        UB_Exp                  number;
        UB_Medio                number;
        UB_Resolucion           number;
        UB_ResolucionPatron     number;
        UB_Exactitud            number;
        UA                      number;
        UB_Histeresis           number;
        nuSerialItemsId         number;
        nuItemsId               number;
        nuItems                 number;
        cnuk                    number;
        csbTipoEquipo           varchar(1000);
        nuCodEquiTemp           number;
        nuConta                 number:=1;
        nuCantidadLecturas      number(2) := 3; --30-07-2014,llozada: Por defecto
        nuTipoElemento          number;

        onuVacecodi             ldc_varicert.vacecodi%type;
        osbVaceVaat             ldc_varicert.vacevaat%type;
        inuPlanTemp             ge_variable_template.variable_template_id%type;

       cursor cuTipoItem(nuItemsId number) is
          select 1
            from ge_items
                where items_id = nuItemsId
                 and description like '%TEMP%ELECT%';

       cursor cuUABimetalicos(inuOrderId number, sub_nom_1 number,
                                                    sub_nom_2 number,
                                                    sub_nom_3 number,
                                                    sub_nom_4 number,
                                                    sub_nom_5 number,
                                                    baj_nom_1 number,
                                                    baj_nom_2 number,
                                                    baj_nom_3 number,
                                                    baj_nom_4 number,
                                                    baj_nom_5 number) is
        select
        --((SUBIDAS.item_value) + (BAJADAS.item_value))/2 X,
        --stddev(((SUBIDAS.item_value) + (BAJADAS.item_value))/2) DESVEST,
        (stddev(((SUBIDAS.item_value) + (BAJADAS.item_value))/2))/sqrt(3) UA
                    from OR_ORDER_ACT_MEASURE SUBIDAS, OR_ORDER_ACT_MEASURE BAJADAS
                    where SUBIDAS.order_id = inuOrderId
                    and SUBIDAS.variable_id = sub_nom_1
                    and BAJADAS.variable_id = baj_nom_1
                    and SUBIDAS.order_id = BAJADAS.order_id
                    and SUBIDAS.measure_number = BAJADAS.measure_number

        UNION

        -- NOMINAL 2
        select
        --((SUBIDAS.item_value) + (BAJADAS.item_value))/2 X,
        --stddev(((SUBIDAS.item_value) + (BAJADAS.item_value))/2) DESVEST,
        (stddev(((SUBIDAS.item_value) + (BAJADAS.item_value))/2))/sqrt(3) UA
                    from OR_ORDER_ACT_MEASURE SUBIDAS, OR_ORDER_ACT_MEASURE BAJADAS
                    where SUBIDAS.order_id = inuOrderId
                    and SUBIDAS.variable_id = sub_nom_2
                    and BAJADAS.variable_id = baj_nom_2
                    and SUBIDAS.order_id = BAJADAS.order_id
                    and SUBIDAS.measure_number = BAJADAS.measure_number

        UNION

        -- NOMINAL 3
        select
        --((SUBIDAS.item_value) + (BAJADAS.item_value))/2 X,
        --stddev(((SUBIDAS.item_value) + (BAJADAS.item_value))/2) DESVEST,
        (stddev(((SUBIDAS.item_value) + (BAJADAS.item_value))/2))/sqrt(3) UA
                    from OR_ORDER_ACT_MEASURE SUBIDAS, OR_ORDER_ACT_MEASURE BAJADAS
                    where SUBIDAS.order_id = inuOrderId
                    and SUBIDAS.variable_id = sub_nom_3
                    and BAJADAS.variable_id = baj_nom_3
                    and SUBIDAS.order_id = BAJADAS.order_id
                    and SUBIDAS.measure_number = BAJADAS.measure_number

        UNION

        -- NOMINAL 4
        select
        --((SUBIDAS.item_value) + (BAJADAS.item_value))/2 X,
        --stddev(((SUBIDAS.item_value) + (BAJADAS.item_value))/2) DESVEST,
        (stddev(((SUBIDAS.item_value) + (BAJADAS.item_value))/2))/sqrt(3) UA
                    from OR_ORDER_ACT_MEASURE SUBIDAS, OR_ORDER_ACT_MEASURE BAJADAS
                    where SUBIDAS.order_id = inuOrderId
                    and SUBIDAS.variable_id = sub_nom_4
                    and BAJADAS.variable_id = baj_nom_4
                    and SUBIDAS.order_id = BAJADAS.order_id
                    and SUBIDAS.measure_number = BAJADAS.measure_number

        UNION

        -- NOMINAL 5
        select
        --((SUBIDAS.item_value) + (BAJADAS.item_value))/2 X,
        --stddev(((SUBIDAS.item_value) + (BAJADAS.item_value))/2) DESVEST,
        (stddev(((SUBIDAS.item_value) + (BAJADAS.item_value))/2))/sqrt(3) UA
                    from OR_ORDER_ACT_MEASURE SUBIDAS, OR_ORDER_ACT_MEASURE BAJADAS
                    where SUBIDAS.order_id = inuOrderId
                    and SUBIDAS.variable_id = sub_nom_5
                    and BAJADAS.variable_id = baj_nom_5
                    and SUBIDAS.order_id = BAJADAS.order_id
                    and SUBIDAS.measure_number = BAJADAS.measure_number;



       cursor cuBimetalicosTabla(inuOrderId number, sub_nom_1 number,
                                                    sub_nom_2 number,
                                                    sub_nom_3 number,
                                                    sub_nom_4 number,
                                                    sub_nom_5 number,
                                                    baj_nom_1 number,
                                                    baj_nom_2 number,
                                                    baj_nom_3 number,
                                                    baj_nom_4 number,
                                                    baj_nom_5 number) is
        -- NOMINAL 1
        select
        --avg(SUBIDAS.item_value) PROMINSTSUB, avg(SUBIDAS.pattern_value) PROMPATSUB,
        --avg(BAJADAS.item_value) PROMINSTBAJ, avg(BAJADAS.pattern_value) PROMPATBAJ
        (avg(SUBIDAS.pattern_value) + avg(BAJADAS.pattern_value))/2 TEMPERATURA_PATRON,
        (avg(SUBIDAS.item_value) + avg(BAJADAS.item_value))/2 LECTURAS_INSTRUMENTO,
        ((avg(SUBIDAS.item_value) + avg(BAJADAS.item_value))/2) -
        ((avg(SUBIDAS.pattern_value) + avg(BAJADAS.pattern_value))/2) ERROR_INDICACION
                    from OR_ORDER_ACT_MEASURE SUBIDAS, OR_ORDER_ACT_MEASURE BAJADAS
                    where SUBIDAS.order_id = inuOrderId
                    and SUBIDAS.variable_id = sub_nom_1
                    and BAJADAS.variable_id = baj_nom_1
                    and SUBIDAS.order_id = BAJADAS.order_id
                    and SUBIDAS.measure_number = BAJADAS.measure_number

        UNION

        -- NOMINAL 2
        select
        --avg(SUBIDAS.item_value) PROMINSTSUB, avg(SUBIDAS.pattern_value) PROMPATSUB,
        --avg(BAJADAS.item_value) PROMINSTBAJ, avg(BAJADAS.pattern_value) PROMPATBAJ
        (avg(SUBIDAS.pattern_value) + avg(BAJADAS.pattern_value))/2 TEMPERATURA_PATRON,
        (avg(SUBIDAS.item_value) + avg(BAJADAS.item_value))/2 LECTURAS_INSTRUMENTO,
        ((avg(SUBIDAS.item_value) + avg(BAJADAS.item_value))/2) -
        ((avg(SUBIDAS.pattern_value) + avg(BAJADAS.pattern_value))/2) ERROR_INDICACION
                    from OR_ORDER_ACT_MEASURE SUBIDAS, OR_ORDER_ACT_MEASURE BAJADAS
                    where SUBIDAS.order_id = inuOrderId
                    and SUBIDAS.variable_id = sub_nom_2
                    and BAJADAS.variable_id = baj_nom_2
                    and SUBIDAS.order_id = BAJADAS.order_id
                    and SUBIDAS.measure_number = BAJADAS.measure_number

        UNION

        -- NOMINAL 3
        select
        --avg(SUBIDAS.item_value) PROMINSTSUB, avg(SUBIDAS.pattern_value) PROMPATSUB,
        --avg(BAJADAS.item_value) PROMINSTBAJ, avg(BAJADAS.pattern_value) PROMPATBAJ
        (avg(SUBIDAS.pattern_value) + avg(BAJADAS.pattern_value))/2 TEMPERATURA_PATRON,
        (avg(SUBIDAS.item_value) + avg(BAJADAS.item_value))/2 LECTURAS_INSTRUMENTO,
        ((avg(SUBIDAS.item_value) + avg(BAJADAS.item_value))/2) -
        ((avg(SUBIDAS.pattern_value) + avg(BAJADAS.pattern_value))/2) ERROR_INDICACION
                    from OR_ORDER_ACT_MEASURE SUBIDAS, OR_ORDER_ACT_MEASURE BAJADAS
                    where SUBIDAS.order_id = inuOrderId
                    and SUBIDAS.variable_id = sub_nom_3
                    and BAJADAS.variable_id = baj_nom_3
                    and SUBIDAS.order_id = BAJADAS.order_id
                    and SUBIDAS.measure_number = BAJADAS.measure_number

        UNION

        -- NOMINAL 4
        select
        --avg(SUBIDAS.item_value) PROMINSTSUB, avg(SUBIDAS.pattern_value) PROMPATSUB,
        --avg(BAJADAS.item_value) PROMINSTBAJ, avg(BAJADAS.pattern_value) PROMPATBAJ
        (avg(SUBIDAS.pattern_value) + avg(BAJADAS.pattern_value))/2 TEMPERATURA_PATRON,
        (avg(SUBIDAS.item_value) + avg(BAJADAS.item_value))/2 LECTURAS_INSTRUMENTO,
        ((avg(SUBIDAS.item_value) + avg(BAJADAS.item_value))/2) -
        ((avg(SUBIDAS.pattern_value) + avg(BAJADAS.pattern_value))/2) ERROR_INDICACION
                    from OR_ORDER_ACT_MEASURE SUBIDAS, OR_ORDER_ACT_MEASURE BAJADAS
                    where SUBIDAS.order_id = inuOrderId
                    and SUBIDAS.variable_id = sub_nom_4
                    and BAJADAS.variable_id = baj_nom_4
                    and SUBIDAS.order_id = BAJADAS.order_id
                    and SUBIDAS.measure_number = BAJADAS.measure_number

        UNION

        -- NOMINAL 5
        select
        --avg(SUBIDAS.item_value) PROMINSTSUB, avg(SUBIDAS.pattern_value) PROMPATSUB,
        --avg(BAJADAS.item_value) PROMINSTBAJ, avg(BAJADAS.pattern_value) PROMPATBAJ
        (avg(SUBIDAS.pattern_value) + avg(BAJADAS.pattern_value))/2 TEMPERATURA_PATRON,
        (avg(SUBIDAS.item_value) + avg(BAJADAS.item_value))/2 LECTURAS_INSTRUMENTO,
        ((avg(SUBIDAS.item_value) + avg(BAJADAS.item_value))/2) -
        ((avg(SUBIDAS.pattern_value) + avg(BAJADAS.pattern_value))/2) ERROR_INDICACION
                    from OR_ORDER_ACT_MEASURE SUBIDAS, OR_ORDER_ACT_MEASURE BAJADAS
                    where SUBIDAS.order_id = inuOrderId
                    and SUBIDAS.variable_id = sub_nom_5
                    and BAJADAS.variable_id = baj_nom_5
                    and SUBIDAS.order_id = BAJADAS.order_id
                    and SUBIDAS.measure_number = BAJADAS.measure_number;

        --CORRECTORES ELECTRICOS
        cursor cuElectricosTabla(inuOrderId number, sub_nom_1 number,
                                                sub_nom_2 number,
                                                sub_nom_3 number,
                                                sub_nom_4 number,
                                                sub_nom_5 number,
                                                nuCantLecturas  number) is
        -- NOMINAL 1
        select TEMPERATURA_PATRON, LECTURAS_INSTRUMENTO, (TEMPERATURA_PATRON - LECTURAS_INSTRUMENTO) ERROR_INDICACION
        from (
        select PATRON.variable_id,avg(pattern_value) TEMPERATURA_PATRON
                    from OR_ORDER_ACT_MEASURE PATRON
                    where PATRON.order_id = inuOrderId
                    and PATRON.variable_id = sub_nom_1
                group by PATRON.variable_id) PATRON
        ,
        (select  INSTRUMENTO.variable_id,avg(item_value) LECTURAS_INSTRUMENTO
                    from OR_ORDER_ACT_MEASURE INSTRUMENTO
                    where INSTRUMENTO.order_id = inuOrderId
                    and INSTRUMENTO.variable_id = sub_nom_1
                    and INSTRUMENTO.measure_number <> nuCantLecturas
                    group by INSTRUMENTO.variable_id) INSTRUMENTO
        where PATRON.variable_id = INSTRUMENTO.variable_id

        UNION

        -- NOMINAL 2
        select TEMPERATURA_PATRON, LECTURAS_INSTRUMENTO, (TEMPERATURA_PATRON - LECTURAS_INSTRUMENTO) ERROR_INDICACION
        from (
        select PATRON.variable_id,avg(pattern_value) TEMPERATURA_PATRON
                    from OR_ORDER_ACT_MEASURE PATRON
                    where PATRON.order_id = inuOrderId
                    and PATRON.variable_id = sub_nom_2
                group by PATRON.variable_id) PATRON
        ,
        (select  INSTRUMENTO.variable_id,avg(item_value) LECTURAS_INSTRUMENTO
                    from OR_ORDER_ACT_MEASURE INSTRUMENTO
                    where INSTRUMENTO.order_id = inuOrderId
                    and INSTRUMENTO.variable_id = sub_nom_2
                    and INSTRUMENTO.measure_number <> nuCantLecturas
                    group by INSTRUMENTO.variable_id) INSTRUMENTO
        where PATRON.variable_id = INSTRUMENTO.variable_id

        UNION

        -- NOMINAL 3
        select TEMPERATURA_PATRON, LECTURAS_INSTRUMENTO, (TEMPERATURA_PATRON - LECTURAS_INSTRUMENTO) ERROR_INDICACION
        from (
        select PATRON.variable_id,avg(pattern_value) TEMPERATURA_PATRON
                    from OR_ORDER_ACT_MEASURE PATRON
                    where PATRON.order_id = inuOrderId
                    and PATRON.variable_id = sub_nom_3
                group by PATRON.variable_id) PATRON
        ,
        (select  INSTRUMENTO.variable_id,avg(item_value) LECTURAS_INSTRUMENTO
                    from OR_ORDER_ACT_MEASURE INSTRUMENTO
                    where INSTRUMENTO.order_id = inuOrderId
                    and INSTRUMENTO.variable_id = sub_nom_3
                    and INSTRUMENTO.measure_number <> nuCantLecturas
                    group by INSTRUMENTO.variable_id) INSTRUMENTO
        where PATRON.variable_id = INSTRUMENTO.variable_id

        UNION

        -- NOMINAL 4
        select TEMPERATURA_PATRON, LECTURAS_INSTRUMENTO, (TEMPERATURA_PATRON - LECTURAS_INSTRUMENTO) ERROR_INDICACION
        from (
        select PATRON.variable_id,avg(pattern_value) TEMPERATURA_PATRON
                    from OR_ORDER_ACT_MEASURE PATRON
                    where PATRON.order_id = inuOrderId
                    and PATRON.variable_id = sub_nom_4
                group by PATRON.variable_id) PATRON
        ,
        (select  INSTRUMENTO.variable_id,avg(item_value) LECTURAS_INSTRUMENTO
                    from OR_ORDER_ACT_MEASURE INSTRUMENTO
                    where INSTRUMENTO.order_id = inuOrderId
                    and INSTRUMENTO.variable_id = sub_nom_4
                    and INSTRUMENTO.measure_number <> nuCantLecturas
                    group by INSTRUMENTO.variable_id) INSTRUMENTO
        where PATRON.variable_id = INSTRUMENTO.variable_id

        UNION

        -- NOMINAL 5
        select TEMPERATURA_PATRON, LECTURAS_INSTRUMENTO, (TEMPERATURA_PATRON - LECTURAS_INSTRUMENTO) ERROR_INDICACION
        from (
        select PATRON.variable_id,avg(pattern_value) TEMPERATURA_PATRON
                    from OR_ORDER_ACT_MEASURE PATRON
                    where PATRON.order_id = inuOrderId
                    and PATRON.variable_id = sub_nom_5
                group by PATRON.variable_id) PATRON
        ,
        (select  INSTRUMENTO.variable_id,avg(item_value) LECTURAS_INSTRUMENTO
                    from OR_ORDER_ACT_MEASURE INSTRUMENTO
                    where INSTRUMENTO.order_id = inuOrderId
                    and INSTRUMENTO.variable_id = sub_nom_5
                    and INSTRUMENTO.measure_number <> nuCantLecturas
                    group by INSTRUMENTO.variable_id) INSTRUMENTO
        where PATRON.variable_id = INSTRUMENTO.variable_id;

        /*CURSOR cuEquivalencia(inuEquiId GE_EQUIVALENC_VALUES.equivalence_set_id%type,
                            inuItem   GE_EQUIVALENC_VALUES.origin_value%type) IS
        select target_value
        from GE_EQUIVALENC_VALUES
        where equivalence_set_id = inuEquiId
        and origin_value = inuItem;  */

    begin

        ----.init;
        ----.setlevel(99);
        ----.setoutput(--.fntrace_output_db);

        -- Obtiene el Id del Certificado que se debe imprimir
        inuPlanTemp :=fnugetIdPlanilla(inuOrderId) ;

        nuSerialItemsId := LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('OR_ORDER_ACTIVITY', 'ORDER_ID', 'SERIAL_ITEMS_ID', inuOrderId);
        nuItemsId := dage_items_seriado.fnugetitems_id(nuSerialItemsId);

        cnuk := fnuObtValorParametro(csbK);

        --nuCodEquiTemp := fnuObtValorParametro(csbEQUI_EQUIPOS_TEMPERA);

        /*open cuEquivalencia(nuCodEquiTemp, nuItemsId);
        fetch cuEquivalencia INTO csbTipoEquipo;
        close cuEquivalencia;

        if (csbTipoEquipo is null) then
            --.trace(' ----------------------- NO CONFIGURADO ITEM EN EQUIVALENCIA DE TEMPERATURA',2);
            ge_boerrors.seterrorcodeargument (2741,'No se ha configurado la equivalencia para el ?TEM '||
                                              nuItemsId||', esto debe hacerse para determinar '||
                                              'SI el equipo es BIMET?LICO o EL?CTRICO. '||
                                              'Para configurar la equivalencia debe ir a la forma '||
                                              '[GEAGE/GRUPOS DE EQUIVALENCIA], buscar por el c?digo: '||nuCodEquiTemp||
                                              '; Y adicionar el ?TEM en la pesta?a DATOS DE GRUPO DE EQUIVALENCIA.')  ;
        end if;*/

        -- Bimetalico
        /*if(tipoItemTemperatura(inuOrderId) = 'B') then
            --.trace('----------------- TEMPERATURA Bimetalico ',9);
            ldc_bometrologia.getVacecodiVacevaat(csbSubNom1 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                   --      ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            sub_nom_1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbSubNom2 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                     --    ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            sub_nom_2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbSubNom3 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                      --   ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            sub_nom_3 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbSubNom4 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                      --   ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            sub_nom_4 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbSubNom5 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                   --      ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            sub_nom_5 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbBajNom1 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                    --     ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            baj_nom_1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbBajNom2 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                   --      ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            baj_nom_2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbBajNom3 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                   --      ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            baj_nom_3 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbBajNom4 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                     --    ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            baj_nom_4 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbBajNom5 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                      --   ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            baj_nom_5 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            -- Obtiene la  UB(Resoluci?n)
            UB_Resolucion := nvl(fnugetUB_Resolucion(inuOrderId)/sqrt(3),0); -- Se divide en raiz de 3 seg?n formulas excel
            --.trace('----------------- TEMPERATURA BIMETALICO UB_Resolucion: '||UB_Resolucion,9);

            UB_Medio      := fsbgetValorMedio(inuOrderId);
            --.trace('----------------- TEMPERATURA BIMETALICO UB_Medio: '||UB_Medio,9);

            UB_Histeresis := cnu0;  /* se asume cero debido a que las series ascendente y descendente se
                                   reportan por separado y no se reporta un valor promedio para cada punto de calibraci?n. * /
            --.trace('----------------- TEMPERATURA BIMETALICO UB_Histeresis: '||UB_Histeresis,9);

            for rc in cuUABimetalicos(inuOrderId,    sub_nom_1,
                                                       sub_nom_2,
                                                       sub_nom_3,
                                                       sub_nom_4,
                                                       sub_nom_5,
                                                       baj_nom_1,
                                                       baj_nom_2,
                                                       baj_nom_3,
                                                       baj_nom_4,
                                                       baj_nom_5) loop
                UA := rc.UA;
                exit;
            end loop;

            --.trace('----------------- TEMPERATURA BIMETALICO UA: '||UA,9);

            UB_Exp := cnuk * sqrt(power(UA,2) + power(UB_Resolucion,2)
                            + power(UB_Medio,2) + power(UB_Histeresis,2));
            --.trace('----------------- TEMPERATURA BIMETALICO UB_Exp: '||UB_Exp,9);

            for rc in cuBimetalicosTabla(inuOrderId,    sub_nom_1,
                                                       sub_nom_2,
                                                       sub_nom_3,
                                                       sub_nom_4,
                                                       sub_nom_5,
                                                       baj_nom_1,
                                                       baj_nom_2,
                                                       baj_nom_3,
                                                       baj_nom_4,
                                                       baj_nom_5) loop
                if rc.TEMPERATURA_PATRON is not null and rc.LECTURAS_INSTRUMENTO is not null then
                    Insert into LDC_FORMTEMP values(inuOrderId,to_char(rc.TEMPERATURA_PATRON,'9999.999'),
                                                           to_char(rc.LECTURAS_INSTRUMENTO,'9999.999'),
                                                           to_char(rc.ERROR_INDICACION,'9999.999'),
                                                           to_char(UB_Exp,'9999.999'));
                end if;
            end loop;

            commit;
        else */
        -- ELECTRICOS
            --.trace('----------------- TEMPERATURA ELECTRICO ',9);
            nuTipoElemento := fnugetTipoElemento(inuOrderId);

            ldc_bometrologia.getVacecodiVacevaat(csbInsNom1 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                  --       ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            sub_nom_1 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbInsNom2 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                       --  ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            sub_nom_2 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbInsNom3 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                     --    ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            sub_nom_3 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbInsNom4 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                      --   ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            sub_nom_4 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            ldc_bometrologia.getVacecodiVacevaat(csbInsNom5 ,onuVacecodi,osbVaceVaat)  ;
            --.trace('Identificador interno ldc_varicert ['||onuVacecodi
                      --   ||'] Es una variable(V) o un Atrivuto(A)  ['||osbVaceVaat||']',9);
            sub_nom_5 := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,inuPlanTemp);

            UB_Exactitud := fnugetUB_Exactitud(inuOrderId)/cnuk;
            --.trace('----------------- TEMPERATURA ELECTRICO UB_Exactitud: '||UB_Exactitud,9);

            --23-01-2015 Llozada [NC 3976]: El cálculo de la resolución depende del tipo de elemento
            if nuTipoElemento = 1 then --ANALOGO
                UB_Resolucion := nvl(fnugetUB_Resolucion(inuOrderId)/sqrt(3),0);
            else --DIGITAL
                UB_Resolucion := nvl(fnugetUB_Resolucion(inuOrderId)/(2*sqrt(3)),0);
            end if;

            --23-01-2015 Llozada [NC 3976]: Se comenta ya que la resolución depende del tipo de elemento
            /*UB_Resolucion := nvl(fnugetUB_Resolucion(inuOrderId)/(2*sqrt(3)),0); -- Se divide en raiz de 3 seg?n formulas excel
            --.trace('----------------- TEMPERATURA ELECTRICO UB_Resolucion: '||UB_Resolucion,9); */

            UB_ResolucionPatron := nvl(fnugetUB_ResolucionPatron(inuOrderId)/(2*sqrt(3)),0);
            --.trace('----------------- TEMPERATURA ELECTRICO UB_ResolucionPatron: '||UB_ResolucionPatron,9);

            UB_Medio      := fsbgetValorMedio(inuOrderId);
            --.trace('----------------- TEMPERATURA ELECTRICO UB_Medio: '||UB_Medio,9);

            UB_Exp := cnuk * sqrt(
                              power(UB_Resolucion,2) + power(UB_Medio,2));

                             --cnuk * sqrt(power(UB_Exactitud,2) + power(UB_Resolucion,2)
                      --      + power(UB_ResolucionPatron,2) + power(UB_Medio,2));
            --.trace('----------------- TEMPERATURA ELECTRICO UB_Exp: '||UB_Exp,9);

            --llozada, 30-07-2014: TERMOMETROS ELECTRICOS CON INDICADOR.
            if LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbNombreEntrega534)
            or LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbNombreEntrega534)
            or LDC_CONFIGURACIONRQ.aplicaParaGDC(sbNombreEntrega534)
            or LDC_CONFIGURACIONRQ.aplicaParaGDO(sbNombreEntrega534) then
                nuCantidadLecturas := 4;
            end if;

            for rc in cuElectricosTabla(inuOrderId,    sub_nom_1,
                                                       sub_nom_2,
                                                       sub_nom_3,
                                                       sub_nom_4,
                                                       sub_nom_5,
                                                       nuCantidadLecturas) loop
                --.trace('----------------- INSERTA ELECTRICO EN LA TABLA LDC_FORMTEMP',9);
                 --.trace('----------------- rc.TEMPERATURA_PATRON: '||rc.TEMPERATURA_PATRON,9);
                 --.trace('----------------- rc.LECTURAS_INSTRUMENTO: '||rc.LECTURAS_INSTRUMENTO,9);
                 --.trace('----------------- rc.ERROR_INDICACION: '||rc.ERROR_INDICACION,9);
                 --.trace('----------------- UB_Exp: '||UB_Exp,9);

                if rc.TEMPERATURA_PATRON is not null and rc.LECTURAS_INSTRUMENTO is not null then
                    Insert into LDC_FORMTEMP values(inuOrderId,to_char(rc.TEMPERATURA_PATRON,'9999.999'),
                                                           to_char(rc.LECTURAS_INSTRUMENTO,'9999.999'),
                                                           to_char(rc.ERROR_INDICACION,'9999.999'),
                                                           to_char(UB_Exp,'9999.999'));
                /*if nuConta = 3 then
                    exit;
                END if;
                nuConta := nuConta + 1; */

                end if;
            end loop;

        --end if;
    end temperatura;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  frfgetOrdenesMante
    Descripcion :
    Autor       : llozada
    Fecha       : 21-10-2013

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    21-10-2013          llozada              Creaci?n.
    **************************************************************************/
    FUNCTION frfgetOrdenesMante
    RETURN constants.tyRefCursor IS

        ocuCursor       constants.tyRefCursor;
        sbSql           varchar2(4000);

        sbCANCELLATION_ID       ge_boInstanceControl.stysbValue;
        sbCOFFEIN               ge_boInstanceControl.stysbValue;
        sbCOFFEFI               ge_boInstanceControl.stysbValue;
    begin

    ----.init;
    ----.setlevel(99);
    ----.setoutput(--.fntrace_output_db);

    sbCANCELLATION_ID := ge_boInstanceControl.fsbGetFieldValue ('LD_CANCELLATION', 'CANCELLATION_ID');
    ----.trace('La solicitud es:['||sbCANCELLATION_ID||']',2);
    sbCOFFEIN         := ge_boInstanceControl.fsbGetFieldValue ('LDC_COFUOOP', 'COFFEIN');
    ----.trace('La fecha inicial es:['||to_date(sbCOFFEIN,'dd/mm/yyyy hh24:mi:ss')||']',2);
    sbCOFFEFI         := ge_boInstanceControl.fsbGetFieldValue ('LDC_COFUOOP', 'COFFEFI');
    ----.trace('La fecha final es:['||to_date(sbCOFFEFI,'dd/mm/yyyy hh24:mi:ss')||']',2);

    execute immediate 'truncate table SOL_CALIBRACION';
    execute immediate 'truncate table ldc_met_recepcion';

    /*Se le da prioridad a las fechas en caso de que el Funcional diligencie los 3 campos*/
    if sbCOFFEIN is null and sbCOFFEFI is null and sbCANCELLATION_ID is null OR sbCANCELLATION_ID = 0
    then
        ge_boerrors.seterrorcodeargument (2741,'Debe ingresar alg?n criterio de B?squeda.');

    elsif( sbCOFFEIN is not null and sbCOFFEFI is not null) then
       --.trace('BUSQUEDA POR FECHA',2);
        -- SQL para genera la consulta del proceso
       sbSql :=
                   ' SELECT '||
                   '   unique a.order_id ORDEN , '||  --c.move_date,
                   '   c.target_oper_unit_id||'' - ''||daor_operating_unit.fsbgetname(c.target_oper_unit_id) UNIDAD_OPERATIVA, '||
                   '   dage_items_seriado.fsbgetserie(c.id_items_seriado) SERIE, c.items_id, '||
                   '   c.item_moveme_caus_id||'' - ''||daor_item_moveme_caus.fsbgetdescription(c.item_moveme_caus_id) CAUSA '||
                   ' from or_order a, OR_order_activity b, OR_uni_item_bala_mov c  '||
                   ' WHERE '||
                   '  item_moveme_caus_id = 16  '|| -- Aceptaci?n
                   ' AND c.move_date >= '''||to_date(sbCOFFEIN,'dd/mm/yyyy hh24:mi:ss')||''''||
                   ' AND trunc(c.move_date) <= '''||to_date(sbCOFFEFI,'dd/mm/yyyy hh24:mi:ss')||''''||  --'02-10-2013 00:00:00'
                   ' AND a.task_type_id  in (select task_type_id '||
                   '     from or_task_type '||
                   '     where task_type_classif = 209) '||
                   ' AND c.operating_unit_id = 799   '|| -- Igual a LABORATORIO
                   ' AND a.order_id = b.order_id '||
                   ' AND b.serial_items_id = c.id_items_seriado ';

       --.trace(sbSql,2);

    else  --' and a.order_status_id = 8         '||
       sbSql :=  '  select a.order_id ORDEN,a.created_date FECHA_CREACION '||
                    'from or_order a,or_order_activity b '||
                    'where b.package_id =  '||sbCANCELLATION_ID||
                    'and a.task_type_id  in (select task_type_id '||
                        'from or_task_type                '||
                        'where task_type_classif = 209)  '||
                    'AND a.order_id = b.order_id';
    end if;

    open ocuCursor for sbSql;

    RETURN ocuCursor;

    EXCEPTION
         --   raise ex.CONTROLLED_ERROR;

        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    end frfgetOrdenesMante;


        /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  processOrdenesMant
    Descripcion :
    Autor       : llozada
    Fecha       : 21-10-2013

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    21-10-2013          llozada              Creaci?n.
    23-07-2014          llozada            Se adiciona el flag de notical para
                                           traer el rango de medición.
    **************************************************************************/
    PROCEDURE processOrdenesMant (inuOrderId     IN  or_order.order_id%type,
                              inuRegistro   IN  number,
                              inuTotal      IN  number,
                              onuErrorCode  OUT number,
                              osbErrorMess  OUT varchar2) AS

    nuNotificationId        ge_notification.notification_id%type;
    sbParamString           varchar2(4000) := null;
    onuNotifica_log         ge_notification_log.notification_log_id%type;
    sbCANCELLATION_ID       ge_boInstanceControl.stysbValue;
    sbTipoEquipo            varchar2(4000);

    osbErrorText                     varchar2(2000) ;

    CURSOR cuUnidadOper(inuorder number) IS
        SELECT
          unique c.move_date fecha_registro,
          c.target_oper_unit_id||' - '||daor_operating_unit.fsbgetname(c.target_oper_unit_id) CLIENTE,
          daor_operating_unit.fsbgetaddress(c.target_oper_unit_id) DIRECCION,
          decode(daor_operating_unit.fsbgetphone_number(c.target_oper_unit_id),null,
          daor_operating_unit.fsbgetfax_number(c.target_oper_unit_id),
          daor_operating_unit.fsbgetphone_number(c.target_oper_unit_id)) telefono
        from or_order a, OR_order_activity b, OR_uni_item_bala_mov c
        WHERE a.order_id = inuorder
        and item_moveme_caus_id = 16
        AND a.task_type_id  in (select task_type_id
            from or_task_type
            where task_type_classif = 209)
        AND c.operating_unit_id = 799
        AND a.order_id = b.order_id
        AND b.serial_items_id = c.id_items_seriado
        ORDER BY fecha_registro desc;

    CURSOR cuTipoEquipo(inuorder number)
    IS
        SELECT ge_items.description
        FROM or_order_items, ge_items
        WHERE ORDER_id = inuorder
        AND or_order_items.items_id = ge_items.items_id;

    BEGIN

    sbCANCELLATION_ID := ge_boInstanceControl.fsbGetFieldValue ('LD_CANCELLATION', 'CANCELLATION_ID');
    --.trace('La solicitud es:['||sbCANCELLATION_ID||']',2);

    open cuTipoEquipo(inuOrderId);
    fetch cuTipoEquipo INTO sbTipoEquipo;
    close cuTipoEquipo;

    if sbTipoEquipo IS not null then
        --23-07-2014, llozada
        sbFlagNotical := 'Y';

        insert into SOL_CALIBRACION values (sbTipoEquipo, --fnugetTipoElemento(inuOrderId),
                                            fsbgetMarcaElemento(inuOrderId),
                                            dage_items_seriado.fsbgetserie(fnugetItemSeriadOrden(inuOrderId)),
                                            FSBGETRANGMEDICELEMENTO(inuOrderId),
                                            inuOrderId,
                                            '_',
                                            'COMPARACION DIRECTA');
    else
        ge_boerrors.seterrorcodeargument(2741,'No se encuentra el ?tem asociado a la Orden. Valide la informaci?n.');
    END if;

        commit;

    if inuRegistro = inuTotal then

        -- CErtificado
        nuNotificationId  := fnugetIdNotificacion(fnuObtValorParametro(csbTemplateCalibracion));
        --.trace('+++++++++++++++++++++++++ nuNotificationId ['||nuNotificationId||']',9) ;

        if sbCANCELLATION_ID IS not null then
            INSERT INTO ldc_met_recepcion VALUES (inuOrderId ,
                                                  damo_packages.fdtgetrequest_date(sbCANCELLATION_ID),
                                                  sbCANCELLATION_ID,
                                                  DAGE_SUBSCRIBER.FSBGETSUBSCRIBER_NAME(daMO_PACKAGES.fnugetsubscriber_id(sbCANCELLATION_ID))||' '||
                                                  DAGE_SUBSCRIBER.FSBGETSUBS_LAST_NAME (daMO_PACKAGES.fnugetsubscriber_id(sbCANCELLATION_ID)),
                                                  DAGE_SUBSCRIBER.FSBGETIDENTIFICATION(daMO_PACKAGES.fnugetsubscriber_id(sbCANCELLATION_ID)),
                                                  ' EXTERNO',
                                                  ldc_boutilities.fsbGetValorCampoTabla('MO_ADDRESS','PACKAGE_ID', 'ADDRESS',sbCANCELLATION_ID),
                                                  NVL(DAGE_SUBSCRIBER.FSBGETPHONE(daMO_PACKAGES.fnugetsubscriber_id(sbCANCELLATION_ID)),'-'),
                                                  '-');
        else
            for rc in cuUnidadOper(inuOrderId) loop
                INSERT INTO ldc_met_recepcion VALUES (inuOrderId,
                                                      rc.fecha_registro,
                                                      '-',
                                                      rc.cliente,
                                                      '-',
                                                      ' INTERNO',
                                                      rc.direccion,
                                                      nvl(rc.telefono,'-'),
                                                      '-');
            exit;
            END loop;
        END if;

        commit;

        -- Setea los parametros de entrada de la sentencia.
        -- Creaci?n de la ge_notification _log
        Ge_BONotification.SETAttribute(sbParamString,'ORDER_ID', nvl(inuOrderId,1));
        --.trace('sbParamString ['||sbParamString||']',9);

        ge_bonotification.SendNotify (nuNotificationId,
                                        dage_notification.fnugetorigin_module_id(nuNotificationId)
                                        ,sbParamString,-1,
                                      onuNotifica_log , onuErrorCode, osbErrorText );

        --.trace('despues del onuNotifica_log:['||onuNotifica_log||']',2);
        ----.trace('despues del onuNotifica_log:['||onuErrorCode||']',2);
        ----.trace('despues del onuNotifica_log:['||osbErrorText||']',2);

        if (onuErrorCode <>0 ) then
          ge_boerrors.seterrorcodeargument(2741,onuErrorCode||' - '||osbErrorText||' ge_bonotification.SendNotify');
        END if;
        commit;
        --.trace('onuNotifica_log ['||onuNotifica_log||']');

        -- Levanta la forma de Impresi?n
        CC_BOPACKADDIDATE.RUNMOCNP(onuNotifica_log);

    end if;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    end processOrdenesMant;

    /*Valida que la fecha Fin sea mayor o igual a la fecha de inicio*/
  PROCEDURE  validaFechaFin
   (
    idtFechafin        in        date
   )
   IS
     sbInstance                    Ge_BOInstanceControl.stysbName;
     sbFechaInicio                 Ge_BOInstanceControl.stysbValue := NULL;
     dtFechaini                    date;
   BEGIN
     --.trace('Inicia METROLOGIA.validaFechaFin',9);
     -- Obtiene
     Ge_BOInstanceControl.GetCurrentInstance(sbInstance);

     -- Obtiene numero de Fecha instanciada
     Ge_BOInstanceControl.GetAttributeNewValue(sbInstance,NULL,'LDC_COFUOOP','COFFEIN',sbFechaInicio );
     --.trace('La fecha inicial es:['||to_date(sbFechaInicio,'dd/mm/yyyy hh24:mi:ss')||']',2);
     --.Trace('idtFechafin ['||idtFechafin ||']',9);
     dtFechaini := to_date(sbFechaInicio);

     if dtFechaini is null then
       ge_boerrors.seterrorcodeargument(2741,'Debe ingresar le Fecha de Inicio.');
     elsif dtFechaini > idtFechafin then
         ge_boerrors.seterrorcodeargument(2741,'La Fecha de Fin debe ser Mayor a la Fecha de Inicio.');
     END if;

     --.trace('Finaliza METROLOGIA.validaFechaFin',9);

     END validaFechaFin;

      /*Valida que la fecha Fin sea mayor o igual a la fecha de inicio*/
    PROCEDURE  validaFechaInicio
    (
        idtFechaInicio        in        date
    )
    IS
        sbInstance                    Ge_BOInstanceControl.stysbName;
        sbFechaFin                    Ge_BOInstanceControl.stysbValue := NULL;
        dtFechafin                    date;
    BEGIN
        --.trace('Inicia METROLOGIA.validaFechaFin',9);
        -- Obtiene
        Ge_BOInstanceControl.GetCurrentInstance(sbInstance);
        -- Obtiene numero de Fecha instanciada
        Ge_BOInstanceControl.GetAttributeNewValue(sbInstance,NULL,'LDC_COFUOOP','COFFEFI',sbFechaFin );
        --.trace('La fecha fin es:['||to_date(sbFechaFin,'dd/mm/yyyy hh24:mi:ss')||']',2);
        --.Trace('idtFechaInicio ['||idtFechaInicio ||']',9);
        dtFechafin := to_date(sbFechaFin);

        if dtFechafin is not null then
           if idtFechaInicio > dtFechafin then
               ge_boerrors.seterrorcodeargument(2741,'La Fecha de Fin debe ser Mayor a la Fecha de Inicio.');
          end if;
        END if;

        --.trace('Finaliza METROLOGIA.validaFechaFin',9);

    END validaFechaInicio;


    function  convertirDecimal
    (
     sbNumber        in        varchar2
    )
    return number
    IS
    BEGIN
        begin
            return ut_convert.fnuchartonumber(replace(sbNumber, '.',','));
        EXCEPTION
        when others then
            return ut_convert.fnuchartonumber(replace(sbNumber, ',','.'));
        END;
    END convertirDecimal;

      /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  fnuObtValorParametro
    Descripcion :
    Autor       : llozada
    Fecha       : 11-07-2013

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    11-11-2013          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fnuObtValorParametro(isbparamecodi in ld_parameter.parameter_id%type)
    RETURN number IS
      nuValueParameter ld_parameter.numeric_value%type;

      CURSOR cuParametro(isbpara ld_parameter.parameter_id%type)
      IS
          select numeric_value
          from ld_parameter
          where parameter_id = isbparamecodi;
    BEGIN
    --.Trace('Inicia LDC_BOMETROLOGIA.fnuObtValorParametro',8);

        open cuParametro(isbparamecodi);
        fetch cuParametro INTO nuValueParameter;
        close cuParametro;

        if nuValueParameter IS null then
            ge_boerrors.seterrorcodeargument(2741,'Verifique en la forma LDPAR si el p?rametro ['||isbparamecodi||
                                                  '] existe. Si existe debe configurar el valor del parametro.'||
                                                  'Si NO existe debe crear el p?rametro en la forma LDPAR y asignarle'||
                                                  ' un valor.');
        END if;

        --.Trace('Inicia LDC_BOMETROLOGIA.fnuObtValorParametro',8);
        RETURN nuValueParameter;

    EXCEPTION
          when ex.CONTROLLED_ERROR then
               ge_boerrors.seterrorcodeargument(2741,'Verifique en la forma LDPAR si el p?rametro ['||isbparamecodi||
                                                  '] existe. Si existe debe configurar el valor del parametro.'||
                                                  'Si NO existe debe crear el p?rametro en la forma LDPAR y asignarle'||
                                                  ' un valor.');
          when others then
              ge_boerrors.seterrorcodeargument(2741,'Verifique en la forma LDPAR si el p?rametro ['||isbparamecodi||
                                                  '] existe. Si existe debe configurar el valor del parametro.'||
                                                  'Si NO existe debe crear el p?rametro en la forma LDPAR y asignarle'||
                                                  ' un valor.');
    END fnuObtValorParametro;


    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetIncertiEquivPresion
    Descripcion : Devuelve la equivalencia para la incertidumbre

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    15-07-2015          Llozada            Se comenta la condición que valida la unidad de medida
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetIncertiEquivPresion(
        inuOrderId             in         OR_order.order_id%type
    )return varchar2
    IS

        nuIncertidumbreEquiv    number;
        sbIncertidumbreEquiv    varchar2(1000);
        nuFactorConver          number;

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);

    BEGIN

        nuFactorConver := fnuGetFactorConversion(inuOrderId);

        --if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%PSI%' then
            --sbIncertidumbreEquiv := to_char(LDC_BOMETROLOGIA.FNUGETUEXP_INCERTIDUMBRE(inuOrderId)* 6.8949,'999G999G990D000')||' kPa';
            --nuIncertidumbreEquiv := LDC_BOMETROLOGIA.FNUGETUEXP_INCERTIDUMBRE(inuOrderId)* 6.894757;
        --    nuIncertidumbreEquiv := LDC_BOMETROLOGIA.FNUGETUEXP_INCERTIDUMBRE(inuOrderId)* nuFactorConver;

        --elsif upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%H2%' then
            --sbIncertidumbreEquiv := to_char(LDC_BOMETROLOGIA.FNUGETUEXP_INCERTIDUMBRE(inuOrderId)* 0.2491,'999G999G990D000')||' kPa';
            --nuIncertidumbreEquiv := LDC_BOMETROLOGIA.FNUGETUEXP_INCERTIDUMBRE(inuOrderId)* 0.2491;
        nuIncertidumbreEquiv := LDC_BOMETROLOGIA.FNUGETUEXP_INCERTIDUMBRE(inuOrderId)* nuFactorConver;
        --END if;

        if  nuIncertidumbreEquiv IS not null then
            -- retorna equivalencia de la Incertidumbre con cifras sig.
            sbIncertidumbreEquiv := fsbCifrasSignif(nuIncertidumbreEquiv);
        end if;

        -- Adicion
        if sbIncertidumbreEquiv IS null then
            sbIncertidumbreEquiv := '';
        END if;

        return sbIncertidumbreEquiv;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbGetIncertiEquivPresion;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetIncerEquivPresion_AJ
    Descripcion : Devuelve la equivalencia para la incertidumbre

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    15-07-2015          Llozada            Se comenta la condición que valida la unidad de medida
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetIncerEquivPresion_AJ(
        inuOrderId             in         OR_order.order_id%type
    )return varchar2
    IS

        nuIncertidumbreEquiv    number;
        sbIncertidumbreEquiv    varchar2(1000);
        nuFactorConver          number;

      --  Variables para manejo de Errores
      exCallService                       EXCEPTION;
      sbCallService                       varchar2(2000);
      nuErrorCode                         number;
      sbErrorMessage                      varchar2(2000);

      nuOrderAj   OR_order.order_id%type;
    BEGIN
        ut_trace.Trace('Inicia LDC_BOMETROLOGIA.fsbGetIncerEquivPresion_AJ',8);
        nuFactorConver := fnuGetFactorConversion(inuOrderId);
         -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

        if nuOrderAj > 0 then
            --if upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%PSI%' then

            --sbIncertidumbreEquiv := to_char(LDC_BOMETROLOGIA.fnugetIncertidumbre_AJ(inuOrderId)* 6.8949,'999G999G990D000')||' kPa';
            --nuIncertidumbreEquiv := LDC_BOMETROLOGIA.fnugetIncertidumbre_AJ(inuOrderId)* 6.894757;
            --nuIncertidumbreEquiv := LDC_BOMETROLOGIA.fnugetIncertidumbre_AJ(inuOrderId)* nuFactorConver;

            --elsif upper(fsbgetUnidadMedida(inuOrderId)) LIKE '%H2%' then
                --sbIncertidumbreEquiv := to_char(LDC_BOMETROLOGIA.fnugetIncertidumbre_AJ(nuOrderAj)* 0.2491,'999G999G990D000')||' kPa';
                --nuIncertidumbreEquiv := LDC_BOMETROLOGIA.fnugetIncertidumbre_AJ(inuOrderId)* 0.2491;
            ut_trace.Trace('   LDC_BOMETROLOGIA.fsbGetIncerEquivPresion_AJ nuFactorConver '||nuFactorConver,8);
            ut_trace.Trace('   LDC_BOMETROLOGIA.fsbGetIncerEquivPresion_AJ nuOrderAj '||nuOrderAj,8);
            nuIncertidumbreEquiv := LDC_BOMETROLOGIA.fnugetIncertidumbre_AJ(nuOrderAj)* nuFactorConver;
            ut_trace.Trace('   LDC_BOMETROLOGIA.fsbGetIncerEquivPresion_AJ nuIncertidumbreEquiv '||nuIncertidumbreEquiv,8);
            --END if;

             if  nuIncertidumbreEquiv IS not null then
                -- retorna equivalencia de la Incertidumbre con cifras sig.
                sbIncertidumbreEquiv := fsbCifrasSignif(nuIncertidumbreEquiv);
            end if;

            -- Adicion
            if sbIncertidumbreEquiv IS null then
                sbIncertidumbreEquiv := '';
            END if;

            return sbIncertidumbreEquiv;

        else
            return 0;
        END if;
        ut_trace.Trace('Finaliza LDC_BOMETROLOGIA.fsbGetIncerEquivPresion_AJ',8);
    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        pkErrors.pop;
        raise;
      when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      pkErrors.pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fsbGetIncerEquivPresion_AJ;


    /* Funcion que retorna la incertidumbre con 2 Cifras significativas
     para aplicar el numero de decimales a los campos DIFERENCIA_MAX y DIFERENCIA_MAX_AJUSTE */
    FUNCTION fsbGetIncertCifrasSig(inuOrderId or_order.order_id%type)
    return varchar2
    is
        sbIncertidumbre varchar2(50);
        nuOrderAj       or_order.order_id%type;
    begin

        nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

        if nuOrderAj > 0 then
            sbIncertidumbre := LDC_BOMETROLOGIA.fsbCifrasSignif(LDC_BOMETROLOGIA.FNUGETUEXP_INCERTIDUMBRE(nuOrderAj));
        else
            sbIncertidumbre := LDC_BOMETROLOGIA.fsbCifrasSignif(LDC_BOMETROLOGIA.FNUGETUEXP_INCERTIDUMBRE(inuOrderId));
        end if;

        if sbIncertidumbre is not null then
            return sbIncertidumbre;
        else
            return -1;
        end if;

    END fsbGetIncertCifrasSig;

    /* Funcion que retorna la incertidumbre Equivalente con 2 Cifras significativas
     para aplicar el numero de decimales a los campos DIFERENCIA_CONVER y DIFERENCIA_CONVER_AJ */
    FUNCTION fsbGetIncertEquivCifrasSig
    (
        inuOrderId  in  OR_order.order_id%type
    )
    RETURN varchar2
    IS
        nuOrderAj       OR_order.order_id%type;
        sbIncertEquiv   varchar2(1000);

    BEGIN

        nuOrderAj   := ldc_bometrologia.valCertAjuste(inuOrderId);

        if nuOrderAj > 0 then
            sbIncertEquiv := LDC_BOMETROLOGIA.fsbGetIncerEquivPresion_AJ(inuOrderId);
        else
            sbIncertEquiv := LDC_BOMETROLOGIA.fsbGetIncertiEquivPresion(inuOrderId);
        end if;

        return sbIncertEquiv;

    END fsbGetIncertEquivCifrasSig;


    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  getIdPlantilla
    Descripcion : Se le envia la Orden para saber que plantilla es la que tiene asignada la orden
    Autor       : llozada
    Fecha       : 12-02-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    12-02-2014          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION getIdPlantilla(nuOrderId OR_order.order_id%type)
    return varchar2
    AS
        nuIdCertificado                  ldc_plantemp.pltexste%type;
        nuNotificationId                 ge_notification.notification_id%type;
        sbTipoLab                        ldc_plantemp.pltelabo%type;
        nuOrdenAju                       OR_order.order_id%type;
        sbTipoClie                       varchar2(100);
        nuItemId                         ge_items.items_id%type;
        nuItemSe                         ge_items_seriado.id_items_seriado%type;
        sbValor                          varchar2(2000);

        csbItemIdMultigas                 CONSTANT   ldc_varicert.vacedesc%type := 'LDC_ITEM_ID_MULTIGAS';
        csbPlantillaMultigas              CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLA_MULTIGAS';
        csbPlantillaExternoINH2O          CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAEXTERNAINH2O';
        csbPlantillaInternoINH2O          CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAINTERNOINH2O';
        csbPlantillaExternoAjINH2O        CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAEXTERNAAJINH2O';
        csbPlantillaInternoAjINH2O        CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAINTERNAAJINH2O';
        csbPlantillaExternoF              CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAEXTERNAF';
        csbPlantillaInternoF              CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAINTERNOIF';
        csbPlantillaExternoAjF            CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAEXTERNAAJF';
        csbPlantillaInternoAjF            CONSTANT   ldc_varicert.vacedesc%type := 'LDC_PLANTILLAINTERNAAJF';

        CURSOR cuNotification(inuNotification_id ge_notification.notification_id%type)
        IS
            SELECT 'Notificacion: '||notification_id||', Plantilla_XSL: '||xsl_template_id
                   ||', Descripcion: '||description
            FROM ge_notification
            WHERE notification_id = inuNotification_id;
    BEGIN

        nuIdCertificado := fnugetIdCertificado(nuOrderId);

        nuNotificationId  := fnugetIdNotificacion(nuIdCertificado);

        -- Obtiene el tipo de Laboratorio
        sbTipoLab := fnugetTipoLab (nuOrderId); --FSBGETNOMBRELABORATORIO(nuOrderId);

        /*if sbTipoLab like '%'||csbPresion||'%' then
                if upper(fsbgetUnidadMedida(nuOrderId)) <> 'PSI' then
                  nuOrdenAju := 0;
                  -- Valida si el Certificado tiene una orden de ajuste
                  nuOrdenAju := ldc_bometrologia.valCertAjuste(nuOrderId);
                  sbTipoClie := ldc_bometrologia.fsbTipoClienteCertif(nuOrderId);

                  if nuOrdenAju <> 0 then
                    if sbTipoClie = 'I' then
                        nuNotificationId := fnugetIdNotificacion(
                                            fnuObtValorParametro(csbPlantillaInternoAjINH2O));
                    else
                        nuNotificationId := fnugetIdNotificacion(
                                            fnuObtValorParametro(csbPlantillaExternoAjINH2O));
                    end if;
                else
                    if sbTipoClie = 'I' then
                        nuNotificationId := fnugetIdNotificacion(
                                            fnuObtValorParametro(csbPlantillaInternoINH2O));
                    else
                        nuNotificationId := fnugetIdNotificacion(
                                            fnuObtValorParametro(csbPlantillaExternoINH2O));
                    end if;
                  END if;
                end if;
        els*/
        if sbTipoLab like '%'||csbTemperatura||'%' then
                if upper(fsbgetUnidadMedida(nuOrderId)) = 'F' OR upper(fsbgetUnidadMedida(nuOrderId)) like '%F' then
                      nuOrdenAju := 0;
                      -- Valida si el Certificado tiene una orden de ajuste
                      nuOrdenAju := ldc_bometrologia.valCertAjuste(nuOrderId);
                      sbTipoClie := ldc_bometrologia.fsbTipoClienteCertif(nuOrderId);

                      if nuOrdenAju <> 0 then
                        if sbTipoClie = 'I' then
                            nuNotificationId := fnugetIdNotificacion(
                                                fnuObtValorParametro(csbPlantillaInternoAjF));
                        else
                            nuNotificationId := fnugetIdNotificacion(
                                                fnuObtValorParametro(csbPlantillaExternoAjF));
                        end if;
                      else
                        if sbTipoClie = 'I' then
                            nuNotificationId := fnugetIdNotificacion(
                                                fnuObtValorParametro(csbPlantillaInternoF));
                        else
                            nuNotificationId := fnugetIdNotificacion(
                                                fnuObtValorParametro(csbPlantillaExternoF));
                        end if;
                      END if;
                end if;
        elsif sbTipoLab like '%'||csbConcentracion||'%' then
                nuItemSe := fnugetItemSeriadOrden(nuOrderId) ;
                nuItemId := dage_items_seriado.fnugetitems_id(nuItemSe) ;

                -- Se verifica que el ITEM sea MULTIGAS
                if nuItemId = fnuObtValorParametro(csbItemIdMultigas) then
                    nuNotificationId := fnugetIdNotificacion(
                                        fnuObtValorParametro(csbPlantillaMultigas));
                END if;
        end if;

        open cuNotification(nuNotificationId);
        fetch cuNotification INTO sbValor;
        close cuNotification;

        return sbValor;

    END getIdPlantilla;

     /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  generaInformeNoConformes
    Descripcion : Levanta la forma de Equipo No Conforme mediante la Forma IENCO
    Autor       : llozada
    Fecha       : 13-02-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    13-02-2014          llozada              Creaci?n.
  **************************************************************************/
    PROCEDURE generaInformeNoConformes
    IS
        nuNotificationId            ge_notification.notification_id%type;
        nuOriginModule              ge_module.module_id%type;
        sbParamString               varchar2(4000);
        osbErrorText                varchar2(2000) ;
        osbErrorMessage             ge_error_log.description%type;
        onuErrorCode                ge_error_log.error_log_id%type;
        nuExternalId                ge_notification_log.external_id%type := -1;
        onuNotifica_log             ge_notification_log.notification_log_id%type;
        sbORDER_ID                  ge_boInstanceControl.stysbValue;
        nuOrderId                   OR_order.order_id%type;
        sbCOMMENT_                  ge_boInstanceControl.stysbValue;
    BEGIN
         -- CErtificado de Equipos No conformes
        sbORDER_ID := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'ORDER_ID');
        nuOrderId := to_number(sbORDER_ID);

        sbCOMMENT_ := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_ACTIVITY', 'COMMENT_');
        sbPersonaQueRevisaIENCO := sbCOMMENT_||'-'||dage_person.fsbgetname_(sbCOMMENT_);

        sbFlagIenco := 'Y';

        ut_trace.trace('---------- sbCOMMENT_  ['||sbPersonaQueRevisaIENCO||']',1);

        nuNotificationId  := fnugetIdNotificacion(fnuObtValorParametro(csbPlantillaNoConformes));
        --.trace('Equipos No Conformes nuNotificationId ['||nuNotificationId||']',9) ;

        nuOriginModule := dage_notification.fnugetorigin_module_id(nuNotificationId);

        --.trace('Equipos No Conformes Order_id ['||nuOrderId||']',9) ;
        -- Setea los parametros de entrada de la sentencia.
        -- Creaci?n de la ge_notification _log
        Ge_BONotification.SETAttribute(sbParamString,'ORDER_ID', nuOrderId);
        --.trace('Equipos No Conformes sbParamString ['||sbParamString||']',9);

       --.trace('Equipos No Conformes Antes del nuNotificationId:['||nuNotificationId||']',2);
       --.trace('Equipos No Conformes Antes del nuOriginModule:['||nuOriginModule||']',2);
       --.trace('Equipos No Conformes Antes del sbParamString:['||sbParamString||']',2);
       --.trace('Equipos No Conformes Antes del nuExternalId:['||nuExternalId||']',2);

        ge_bonotification.SendNotify (nuNotificationId,nuOriginModule,sbParamString,nuExternalId,
                                      onuNotifica_log , onuErrorCode, osbErrorText );

        --.trace('Equipos No Conformes despues del onuNotifica_log:['||onuNotifica_log||']',2);
        --.trace('Equipos No Conformes despues del onuNotifica_log:['||onuErrorCode||']',2);
        --.trace('Equipos No Conformes despues del onuNotifica_log:['||osbErrorText||']',2);

        if (onuErrorCode <>0 ) then
          ge_boerrors.seterrorcodeargument(2741,onuErrorCode||' - '||osbErrorText);
        END if;

        --.trace('Equipos No Conformes onuNotifica_log ['||onuNotifica_log||']');

        -- Levanta la forma de Impresi?n
        CC_BOPACKADDIDATE.RUNMOCNP(onuNotifica_log);
    END generaInformeNoConformes;

    /*Capacidad para los certificados de Orificios*/
    FUNCTION fsbgetCapacidad(inuOrder_id OR_order.order_id%type)
    return varchar2
    IS
        CURSOR cuMinimo
        IS
            select
            --6 ENTRADA,avg(a.value/(b.value/60000)) QAIRE, avg(a.value/(b.value/60000))*sqrt(1/0.60) QGAS_M ,
            (avg(a.value/(b.value/60000))*sqrt(1/0.60))*60 QGAS_H
               from  OR_order_act_var_det a, OR_order_act_var_det b
               where a.ORDER_id = inuOrder_id
               AND a.variable_id = DALD_parameter.fnuGetNumeric_Value('VOLUMEN_NOMINAL_1')
               and  b.variable_id = DALD_parameter.fnuGetNumeric_Value('TIEMPO_NOMINAL_1')
               and a.measure_number = b.measure_number
               and a.order_id = b.order_id;

        CURSOR cuMaximo
        IS
            select
            --9 ENTRADA,avg(a.value/(b.value/60000)) QAIRE, avg(a.value/(b.value/60000))*sqrt(1/0.60) QGAS_M ,
            (avg(a.value/(b.value/60000))*sqrt(1/0.60))*60 QGAS_H
               from  OR_order_act_var_det a, OR_order_act_var_det b
               where a.ORDER_id = inuOrder_id
               AND a.variable_id = DALD_parameter.fnuGetNumeric_Value('VOLUMEN_NOMINAL_4')
               and  b.variable_id = DALD_parameter.fnuGetNumeric_Value('TIEMPO_NOMINAL_4')
               and a.measure_number = b.measure_number
               and a.order_id = b.order_id;

        sbMinimo    varchar2(100);
        sbMaximo    varchar2(100);
        nuPos       number;
    BEGIN

        open cuMinimo;
        fetch cuMinimo INTO sbMinimo;
        close cuMinimo;

        open cuMaximo;
        fetch cuMaximo INTO sbMaximo;
        close cuMaximo;

        if sbMinimo IS null AND sbMaximo IS null then
            ge_boerrors.seterrorcodeargument (2741,'No existen valores en la orden ');
        END if;

        nuPos := instr(sbMinimo,'.');
        sbMinimo := substr(sbMinimo,0,nuPos-1);

        nuPos := instr(sbMaximo,'.');
        sbMaximo := substr(sbMaximo,0,nuPos-1);

        return sbMinimo||' - '||sbMaximo;

    END fsbgetCapacidad;

    FUNCTION fsbGetCargoPersona(inuOrder_id or_order.order_id%type)
    return varchar2
    IS
        sbPersonaQueRevisa  varchar2(100);
        nuPos               number;
        sbCodPersona        varchar2(10);
        sbCargo             varchar2(100);

        CURSOR cuPerson(inuPerson_id ge_person.person_id%type)
        IS
            SELECT dage_position_type.fsbgetdescription(position_type_id)  --dage_position_type.fsbgetname(position_type_id)
            FROM ge_person a
            WHERE a.person_id = inuPerson_id;
    BEGIN
        nuFlagPersonaQueRevisa := 1; --Para indicarle al metodo fsbgetPersonaQRevisa
                                     --que es llamda desde aca
        sbPersonaQueRevisa := fsbgetPersonaQRevisa(inuOrder_id);

        ut_trace.trace('---------- sbPersonaQueRevisa CARGO  ['||sbPersonaQueRevisa||']',1);

        nuPos := instr(sbPersonaQueRevisa,'-');
        sbCodPersona := substr(sbPersonaQueRevisa,0,nuPos-1);

        open cuPerson(to_number(sbCodPersona));
        fetch cuPerson INTO sbCargo;
        close cuPerson;

        if sbCargo IS null then
            ge_boerrors.seterrorcodeargument (2741,'La Persona que revisa ['||sbPersonaQueRevisa||
                                '] No tiene configurado un CARGO. Valide la Configuracion en SAASE.');
        END if;

        return sbCargo;

    END fsbGetCargoPersona;

    FUNCTION getFechaNoConformes
    return date
    IS
    BEGIN
        return to_date(SYSDATE,'YYYY/mm/dd');
    EXCEPTION
        when others then
            return to_date(SYSDATE,'YYYY/mm/dd');
    END;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  prGenerarDatosNotificacion
    Descripcion : Genera los datos para los certificados

    Autor       : llozada
    Fecha       : 16-04-2013

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    02-07-2025          jpinedc            OSF-4555: * Se borra csbEntrega10020542
                                           * Se reemplaza pktblSistema
    07-09-2016          DSaltarin[ca 100-20542] Se modifica el formato de exactitud calulada y exactitud calcualada
                                                ajuste a 9G999G990D000
    18-08-2015          Llozada [ARA 6347] Se adiciona dos décimales a la exactitud
    28-04-2015          Llozada [ARA 6869] Se adicionan los campos SECUENCIA,TMAX,TMIN
                                           HMAX,DIF_TMAX_TMIN,HMIN,DIF_HMAX_HMIN,DIFERENCIA_ALTURA,
                                           POSICION
    16-04-2013          llozada              Creaci?n.
    
  **************************************************************************/
    PROCEDURE prGenerarDatosNotificacion
    (
        inuOrder_id     OR_order.order_id%type
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prGenerarDatosNotificacion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
            
        INSERT INTO open.LDC_DATOS_CERTIFICADO_MET
        SELECT O.ORDER_ID ORDER_ID,
        LDC_BOMETROLOGIA.FNUGETNUMEROELEMENTO(O.ORDER_ID) NUMERO,
        LDC_BOMETROLOGIA.FSBGETNOMBRELABORATORIO(O.ORDER_ID) LABORATORIO,I.DESCRIPTION INSTRUMENTO,
        LDC_BOMETROLOGIA.FSBGETMARCAELEMENTO(O.ORDER_ID) FABRICANTE,LDC_BOMETROLOGIA.FSBGETMODELOELEMENTO(O.ORDER_ID) MODELO,
        LDC_BOMETROLOGIA.FNUGETCODIGOELEMENTO(O.ORDER_ID) CODIGO,S.
        SERIE NUMERO_SERIE ,
        LDC_BOMETROLOGIA.FSBGETRANGMEDICELEMENTO(O.ORDER_ID) RANGO_DESC_MEDICION,
        LDC_BOMETROLOGIA.FNUGETRANGOMEDICION (O.ORDER_ID, LDC_BOMETROLOGIA.FNUGETITEMSERIADORDEN(O.ORDER_ID) ) RANGO_MEDICION,
        LDC_BOMETROLOGIA.FSBGETDIVICESCAELEMENT(O.ORDER_ID) DIVISION_ESCALA ,
        to_char(LDC_BOMETROLOGIA.FSBGETEXACTITUDELEMENT(O.ORDER_ID),'9G99G990D000')  EXACTITUD ,
        to_char(LDC_BOMETROLOGIA.fnugetExactitudIntervalo(O.ORDER_ID),'9G999G990D000')  EXACTITUD_CALCULADA ,
        to_char(LDC_BOMETROLOGIA.fnugetExactitudInterAjus(O.ORDER_ID),'9G999G990D000')  EXACTITUD_CALCULADA_AJ ,
        to_char(LDC_BOMETROLOGIA.fnugetExactitudPatron(O.ORDER_ID),'9G99G990D000')  EXACTITUD_PATRON ,
        LDC_BOMETROLOGIA.FSBGETQUIENSOLICITA(O.ORDER_ID) SOLICITANTE,
        to_char(to_date(LDC_BOMETROLOGIA.FDTGETFECHARECEPCION(O.ORDER_ID)),'yyyy/mm/dd') FECHA_RECEPCION_EQUIPO,
        to_char(O.LEGALIZATION_DATE,'yyyy/mm/dd') FECHA_CALIBRACION,
        to_char(O.LEGALIZATION_DATE,'yyyy/mm/dd') FECHA_EMISION,
        3 NUM_PAGINAS,
        LDC_BOMETROLOGIA.FSBGETCALIBRADOPOR(O.ORDER_ID) NOMBRE_QUIEN_CALIBRO,
        LDC_BOMETROLOGIA.FSBGETPERSONAQREVISA(O.ORDER_ID) NOMBRE_QUIEN_REVISO,
        DAGE_ITEMS.FSBGETDESCRIPTION(DAGE_ITEMS_SERIADO.FNUGETITEMS_ID (LDC_BOMETROLOGIA.FNUGETELEMNTOPATRON (O.ORDER_ID)))||' S/N '||
        DAGE_ITEMS_SERIADO.FSBGETSERIE (LDC_BOMETROLOGIA.FNUGETELEMNTOPATRON (O.ORDER_ID))||' '||
        LDC_BOMETROLOGIA.FSBGETDESCRANGODELELEMENTO(O.ORDER_ID, LDC_BOMETROLOGIA.FNUGETELEMNTOPATRON (O.ORDER_ID) ) PATRON,
        LDC_BOMETROLOGIA.FSBGETDESCRMEDIO(O.ORDER_ID) MEDIO ,
        null PRE_CICLO,
        DAOR_ITEM_PATTERN.FSBGETTRACKING( LDC_BOMETROLOGIA.FNUGETELEMNTOPATRON (O.ORDER_ID))  CERTIFI_TRAZABILIDAD,
        LDC_BOMETROLOGIA.fsbCifrasSignif(LDC_BOMETROLOGIA.FNUGETUEXP_INCERTIDUMBRE(O.ORDER_ID)) INCERTIDUMBRE,
        nvl(LDC_BOMETROLOGIA.fsbCifrasSignif(LDC_BOMETROLOGIA.fnugetIncertidumbre_AJ(O.ORDER_ID)),'') INCERTIDUMBRE_AJUSTE,
        nvl(LDC_BOMETROLOGIA.fsbgetIncertidumbreConver(O.ORDER_ID),'') INCERTIDUMBRE_CONVER,
        nvl(LDC_BOMETROLOGIA.fsbGetIncertiEquivPresion(O.ORDER_ID),'') INCERTIDUMBREKPA,
        nvl(LDC_BOMETROLOGIA.fsbGetIncerEquivPresion_AJ(O.ORDER_ID),'') INCERTIDUMBREKPA_AJ,
        nvl(LDC_BOMETROLOGIA.fsbCifrasDeci(fsbGetIncertCifrasSig(O.ORDER_ID),fnugetDiferenciaMax(O.ORDER_ID)),'') DIFERENCIA_MAX,
        nvl(LDC_BOMETROLOGIA.fsbCifrasDeci(fsbGetIncertCifrasSig(O.ORDER_ID),fnugetDifMaxAjuste(O.ORDER_ID)),'') DIFERENCIA_MAX_AJUSTE,
        nvl(LDC_BOMETROLOGIA.fsbCifrasDeci(LDC_BOMETROLOGIA.fsbGetIncertEquivCifrasSig(O.ORDER_ID), fnugetDifMaxConversion(O.ORDER_ID)),'') DIFERENCIA_CONVER,
        nvl(LDC_BOMETROLOGIA.fsbCifrasDeci(LDC_BOMETROLOGIA.fsbGetIncertEquivCifrasSig(O.ORDER_ID), fnugetDifMaxConver_Ajus(O.ORDER_ID)),'') DIFERENCIA_CONVER_AJ,
        nvl(LDC_BOMETROLOGIA.fsbCifrasDeci(fsbGetIncertCifrasSig(O.ORDER_ID), fnugetHisteresisMax( decode(ldc_bometrologia.valCertAjuste(O.ORDER_ID),0,O.ORDER_ID,
                              ldc_bometrologia.valCertAjuste(O.ORDER_ID)))),'') HISTERISIS_MAX,
        nvl(LDC_BOMETROLOGIA.fsbCifrasDeci(fsbGetIncertEquivCifrasSig(O.ORDER_ID), fnugetHisteresisConver(decode(ldc_bometrologia.valCertAjuste(O.ORDER_ID),0,O.ORDER_ID,
                              ldc_bometrologia.valCertAjuste(O.ORDER_ID)))),'') HISTERISIS_CONVER,
        pkg_empresa.fsbObtNombreEmpresa( pkg_BOConsultaEmpresa.fsbObtEmpresaUnidadOper(o.operating_unit_id) ) COMPANIA,
        INITCAP(pkg_empresa.fsbObtNombreEmpresa( pkg_BOConsultaEmpresa.fsbObtEmpresaUnidadOper(o.operating_unit_id) ) ) COMPANIA_MINU,
        LDC_BOMETROLOGIA.fsbgetDirQuienSolicita(O.ORDER_ID)  DIRECCION,
        daor_operating_unit.fsbgetphone_number(DALD_PARAMETER.FNUGETNUMERIC_VALUE(csbLaboratorio),null)  TEL_RESPON_LAB ,
        LOWER(daor_operating_unit.fsbgete_mail(DALD_PARAMETER.FNUGETNUMERIC_VALUE(csbLaboratorio),null)) CORREO_RESPON_LAB,
        LDC_BOMETROLOGIA.FNUGETOBSERVACION(O.ORDER_ID) OBSERVAC_LEGA_ORDER,
        DALD_PARAMETER.FNUGETNUMERIC_VALUE('CONSTANTE_K') CONST_K,
        nvl(LDC_BOMETROLOGIA.fsbCifrasDeci(LDC_BOMETROLOGIA.fsbGetIncertCifrasSig(O.ORDER_ID),
        LDC_BOMETROLOGIA.FNUGETPORERROMAX(O.ORDER_ID)),'')  POR_DIF_MAX,
        nvl(LDC_BOMETROLOGIA.fsbCifrasDeci(LDC_BOMETROLOGIA.fsbGetIncertCifrasSig(O.ORDER_ID),
        LDC_BOMETROLOGIA.fnugetPorErrorMaxAjus(O.ORDER_ID)),'')  POR_DIF_MAX_AJUS,
        DECODE(LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA ('LDC_CERTMETR', 'CEMEORDE','CEMEREAJ',O.ORDER_ID), 'N','SI','NO')    CERTIFICA,
        to_char(LDC_BOMETROLOGIA.fsbgetValorProfundidad(O.ORDER_ID),'999G999G990D000') PROFUNDIDAD_INMERSION ,
        LDC_BOMETROLOGIA.fsbgetDirCompany(O.ORDER_ID) DIRE_COMPANIA,
        LDC_BOMETROLOGIA.fsbgetUnidadMedida(O.ORDER_ID) UNIDADES,
        upper(ldc_bometrologia.getNorma(O.order_id)) NORMA,
        LDC_BOMETROLOGIA.fsbGetCargoPersona(O.ORDER_ID) CARGO_QUIEN_REVISO,
        LDC_BOMETROLOGIA.fsbGetPrecargas(O.ORDER_ID) PRECARGAS,
        LDC_BOMETROLOGIA.fsbgetUnidadMedidaPatron(O.ORDER_ID) UNIDADES_PATRON,
        LDC_BOMETROLOGIA.fsbgetCondInstru(O.ORDER_ID) CONDICION_DEL_INSTRUMENTO,
        LDC_BOMETROLOGIA.fsbGetNombreUnidad(O.ORDER_ID) NOMBRE_UNIDAD,
        LDC_BOMETROLOGIA.fsbGetUnidadEquiv(O.ORDER_ID) UNIDAD_EQUIVALENTE,
        LDC_BOMETROLOGIA.fsbGetNombreUnidadEquiv(O.ORDER_ID) NOM_UNI_EQUI,
        LDC_BOMETROLOGIA.fsbGetCargoCalibradoPor(O.ORDER_ID) CARGO_CALIBRADOR_POR,
        LDC_BOMETROLOGIA.fsbGetTemperaturaCA(O.ORDER_ID) CA_TEMPERATURA,
        LDC_BOMETROLOGIA.fsbGetHumedadCA(O.ORDER_ID) CA_HUMEDAD,
        LDC_BOMETROLOGIA.fsbGetIncertidumbreConcNomi(O.ORDER_ID) INCERT_NOMI,
        LDC_BOMETROLOGIA.fsbgetIncertidumbreConcNomi_AJ(O.ORDER_ID) INCERT_NOMI_AJU,
        LDC_BOMETROLOGIA.fsbgetSecuenciaExactitud(O.ORDER_ID) SECUENCIA, --nuevo
        to_char(LDC_BOMETROLOGIA.fsbGetTMax(O.ORDER_ID),'9G99G990D00') TMAX, --nuevo
        to_char(LDC_BOMETROLOGIA.fsbGetTMin(O.ORDER_ID),'9G99G990D00') TMIN, --nuevo
        to_char(ABS(LDC_BOMETROLOGIA.fsbGetTMax(O.ORDER_ID) - LDC_BOMETROLOGIA.fsbGetTMin(O.ORDER_ID)),'9G99G990D00') DIF_TMAX_TMIN, --nuevo
        to_char(LDC_BOMETROLOGIA.fsbGetHMax(O.ORDER_ID),'9G99G990D00') HMAX, --nuevo
        to_char(LDC_BOMETROLOGIA.fsbGetHMin(O.ORDER_ID),'9G99G990D00') HMIN, --nuevo
        to_char(ABS(LDC_BOMETROLOGIA.fsbGetHMax(O.ORDER_ID) - LDC_BOMETROLOGIA.fsbGetHMin(O.ORDER_ID)),'9G99G990D00') DIF_HMAX_HMIN, --nuevo
        to_char(LDC_BOMETROLOGIA.fsbGetDiferenciaAltura(O.ORDER_ID),'9G99G990D00000') DIFERENCIA_ALTURA, --nuevo
        LDC_BOMETROLOGIA.fsbGetPosicion(O.ORDER_ID) POSICION --nuevo
        FROM OR_ORDER O,OR_ORDER_ACTIVITY OA,GE_ITEMS_SERIADO S,GE_ITEMS I
        WHERE O.ORDER_ID=OA.ORDER_ID
        AND OA.SERIAL_ITEMS_ID=S.ID_ITEMS_SERIADO
        AND S.ITEMS_ID=I.ITEMS_ID
        AND O.ORDER_ID= inuOrder_id
        and rownum = 1;

        commit;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
    END prGenerarDatosNotificacion;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetTMax
    Descripcion : Devuelve el valor para el atributo TMAX

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetTMax(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2
    IS
        nuValVariable NUMBER;
        sbValor       VARCHAR2(100);
        nuOrderAj     NUMBER;
    BEGIN
        nuValVariable := fnuObtValorParametro(csbTMax);

        -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

        IF nuOrderAj > 0 THEN
            sbValor := LDC_BOmetrologia.fsbgetValueVariable(nuOrderAj,nuValVariable);
        ELSE
            sbValor := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuValVariable);
        END IF;

        IF sbValor IS NOT NULL THEN
            RETURN sbValor;
        ELSE
            RETURN NULL;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END fsbGetTMax;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetTMin
    Descripcion : Devuelve el valor para el atributo TMIN

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetTMin(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2
    IS
        nuValVariable NUMBER;
        sbValor       VARCHAR2(100);
        nuOrderAj     NUMBER;
    BEGIN
        nuValVariable := fnuObtValorParametro(csbTMin);

        -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

        IF nuOrderAj > 0 THEN
            sbValor := LDC_BOmetrologia.fsbgetValueVariable(nuOrderAj,nuValVariable);
        ELSE
            sbValor := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuValVariable);
        END IF;

        IF sbValor IS NOT NULL THEN
            RETURN sbValor;
        ELSE
            RETURN NULL;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END fsbGetTMin;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetHMax
    Descripcion : Devuelve el valor para el atributo HMAX

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetHMax(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2
    IS
        nuValVariable NUMBER;
        sbValor       VARCHAR2(100);
        nuOrderAj     NUMBER;
    BEGIN
        nuValVariable := fnuObtValorParametro(csbHMax);

        -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

        IF nuOrderAj > 0 THEN
            sbValor := LDC_BOmetrologia.fsbgetValueVariable(nuOrderAj,nuValVariable);
        ELSE
            sbValor := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuValVariable);
        END IF;

        IF sbValor IS NOT NULL THEN
            RETURN sbValor;
        ELSE
            RETURN NULL;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END fsbGetHMax;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetHMin
    Descripcion : Devuelve el valor para el atributo HMIN

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetHMin(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2
    IS
        nuValVariable NUMBER;
        sbValor       VARCHAR2(100);
        nuOrderAj     NUMBER;
    BEGIN
        nuValVariable := fnuObtValorParametro(csbHMin);

        -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

        IF nuOrderAj > 0 THEN
            sbValor := LDC_BOmetrologia.fsbgetValueVariable(nuOrderAj,nuValVariable);
        ELSE
            sbValor := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,nuValVariable);
        END IF;

        IF sbValor IS NOT NULL THEN
            RETURN sbValor;
        ELSE
            RETURN NULL;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END fsbGetHMin;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetDiferenciaAltura
    Descripcion : Devuelve el valor para el atributo HMIN

    Autor       : llozada
    Fecha       : 23-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    23-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetDiferenciaAltura(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2
    IS
        nuPlanTemp    NUMBER;
        onuValor      NUMBER;
        osbVaceVaat   VARCHAR2(100);
        nuDifAltura   NUMBER;
        nuValorDifAlt NUMBER;
    BEGIN

        nuPlanTemp :=fnugetIdPlanilla(inuOrderId);

        ldc_bometrologia.getVacecodiVacevaat(csbVarDifAltura ,onuValor,osbVaceVaat)  ;

        --  ID DE LA VARIABLE, ID DE LA PLANILLA UTILIZADA
        nuValorDifAlt := ldc_bometrologia.fnugetIdentifVariAttrib(onuValor,nuPlanTemp);
        nuDifAltura := convertirDecimal(LDC_BOmetrologia.fsbgetValueVariable(inuOrderId ,nuValorDifAlt));

        IF nuDifAltura IS NOT NULL THEN
            RETURN nuDifAltura;
        ELSE
            RETURN NULL;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END fsbGetDiferenciaAltura;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbGetPosicion
    Descripcion : Devuelve el valor para el atributo TMAX

    Autor       : llozada
    Fecha       : 22-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    22-04-2015          llozada              Creaci?n.
  **************************************************************************/
    FUNCTION fsbGetPosicion(inuOrderId    OR_order.order_id%type)
    RETURN VARCHAR2
    IS
        nuValAtributo NUMBER;
        sbValor       VARCHAR2(100);
    BEGIN
        nuValAtributo := fnuObtValorParametro(csbPosicion);
        sbValor := fsbgetValorAtributo(inuOrderId,nuValAtributo);

        IF sbValor IS NOT NULL THEN
            RETURN sbValor;
        ELSE
            RETURN NULL;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END fsbGetPosicion;


    /**/
    FUNCTION fsbGetPrecargas(inuOrderId    OR_order.order_id%type)
    return varchar2
    IS
        sbPrecargas     varchar2(20) := null;
        sbTipoLab       varchar2(2000);
    BEGIN
        sbTipoLab := fnugetTipoLab (inuOrderId);

        if sbTipoLab like '%'||csbPresion||'%' then
           sbPrecargas := LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,dald_parameter.fnuGetNumeric_Value(csbNumeroCargas));
        END if;

        return sbPrecargas;

    END fsbGetPrecargas;

    procedure prPlantillaXSL(inuOrderId    OR_order.order_id%type)
    is
        sbPlantilla     varchar2(2000);
    begin
        sbPlantilla := ldc_bometrologia.getidplantilla(inuOrderId);

        if sbPlantilla is not null then
            ge_boerrors.seterrorcodeargument (2741,sbPlantilla);
        else
            ge_boerrors.seterrorcodeargument (2741,'La Orden no tiene una Plantilla asociada.');
        end if;
    end prPlantillaXSL;

    --- Funcion que consulta la Incertidumbre expresada con 2 Cifras significativas
    function fsbGetIncertidumbreSig(order_id or_order.order_id%type)
    return varchar2
    is
        sbIncertidumbre varchar2(50);
        sbIncertidumbreAj varchar2(50);
        nuOrderAj       number;


    begin
        select incertidumbre, incertidumbre_ajuste
         into sbIncertidumbre, sbIncertidumbreAj
        from ldc_datos_certificado_met
        where order_id = order_id;

        -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(order_id);

        if sbIncertidumbre is not null then

            if nuOrderAj > 0 then
                return sbIncertidumbreAj;
            else
                return sbIncertidumbre;
            end if;
        else
            return -1;
        end if;

    end fsbGetIncertidumbreSig;

    --- Funcion que consulta la Incertidumbre Equivalente expresada con 2 Cifras significativas
    function fsbGetIncertidumbreConverSig(order_id or_order.order_id%type)
    return varchar2
    is
        sbIncertidumbre varchar2(50);
        sbIncertidumbreAj varchar2(50);
        nuOrderAj       number;
    begin
        select INCERTIDUMBREKPA, INCERTIDUMBREKPA_AJ
        into sbIncertidumbre, sbIncertidumbreAj
        from ldc_datos_certificado_met
        where order_id = order_id;

        -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(order_id);

        if sbIncertidumbre is not null then

            if nuOrderAj > 0 then
                return sbIncertidumbreAj;
            else
                return sbIncertidumbre;
            end if;
        else
            return -1;
        end if;

    end fsbGetIncertidumbreConverSig;


     --- Funcion que retorna la equivalencia pata tablas de Temperatura
    function fnuGetEquivalenciaTemp(inuNum    number)
    return number
    is
        nuResult    number;
        sbResult    number;

    begin

        if inuNum is null then
            return 0;
        end if;

        if inuNum < 32 then
            nuResult :=  inuNum * (5/9);
        else
            nuResult :=  (inuNum -32) * (5/9);
        end if;

        return round(nuResult,6);

     end fnuGetEquivalenciaTemp;


    --- Funcion que retorna la Correci?n  pata tablas de Temperatura
    function fnuGetEquivCorrecion(inupatron number, inuInstru number)
    return number
    is
        nuPatron    number;
        nuInstru    number;
        nuResult    number;

    begin

        if inupatron is null and inuInstru is null then
            return 0;
        end if;


        if inupatron is null then
            nuPatron := 0;

        elsif inuInstru is null then
            nuInstru := 0;

        else
            nuPatron    := inupatron;
            nuInstru    := inuInstru;

        end if;


        if (nupatron - nuInstru) < 32 then
            nuResult := (nupatron - nuInstru) * (5/9);
        else
            nuResult :=  ((nupatron - nuInstru) -32) * (5/9);
        end if;

        return round(nuResult,6);

     end fnuGetEquivCorrecion;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  generaInformeNoConformes
    Descripcion : Actualiza la propiedad del item seriado
    Autor       : llozada
    Fecha       : 05-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    05-08-2014          llozada              Creaci?n.
    **************************************************************************/
    PROCEDURE actualizaPropiedadCliente (inumotiveid mo_motive.motive_id%type)
    IS
        sbInstance                       ge_boinstancecontrol.stysbName;
        sbPackageId                      ge_boInstanceControl.stySbValue;
        sbMotiveId                       ge_boInstanceControl.stySbValue;

        nuSerialItemsId                  ge_items_seriado.id_items_seriado%type;
        nuSubscriberId                   or_order_activity.subscriber_id%type;
        sbErrorMessage                   varchar2(2000);

        CURSOR cuItemSeriado(inuPackage_id mo_packages.package_id%type)
        IS
            SELECT SERIAL_ITEMS_ID,subscriber_id
            FROM or_order_activity
            where package_id = inuPackage_id;

    BEGIN
/*        ut_trace.init;
    ut_trace.setlevel(99);
    ut_trace.setoutput(ut_trace.fntrace_output_db);*/

        ut_trace.trace(' ------------------ actualizaPropiedadCliente PASO 1. INICIO',1);
        -- Obtiene la instancia actual
       -- Ge_BOInstanceControl.GetCurrentInstance(sbInstance);
        ut_trace.trace(' ------------------ actualizaPropiedadCliente PASO 2. ANTES DE TRAER EL VALOR DE INSTANCIA. '||inumotiveid,1);
        -- Obtiene el n?mero de la orden
        --ge_boinstancecontrol.GetAttributeNewValue(sbInstance,null,'MO_PACKAGE','PACKAGE_ID',sbPackageId);
        sbMotiveId := inumotiveid; --OR_BOINSTANCE.FNUGETFATHEXTSYSIDFROMINSTANCE(); --ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGE', 'PACKAGE_ID');
        ut_trace.trace(' ------------------ actualizaPropiedadCliente PASO 2.1 TRAE EL PAQUETE DE LA INSTANCIA: '||sbMotiveId,1);

        sbPackageId := inumotiveid; --ldc_boutilities.fsbGetValorCampoTabla('MO_MOTIVE','MOTIVE_ID','PACKAGE_ID',sbPackageId);
        ut_trace.trace(' ------------------ actualizaPropiedadCliente PASO 3. TRAE EL PAQUETE DE LA INSTANCIA: '||sbPackageId,1);

        open cuItemSeriado(sbPackageId);
        fetch cuItemSeriado INTO nuSerialItemsId,nuSubscriberId;
        close cuItemSeriado;

        ut_trace.trace(' ------------------ actualizaPropiedadCliente PASO 4. DESPUES DEL CURSOR',1);
        if nuSerialItemsId is not null then
            ut_trace.trace(' ------------------ actualizaPropiedadCliente PASO 5. ENTRA EL IF, ANTES DE ACTUALIZAR. '||nuSerialItemsId,1);
            begin
                update ge_items_seriado
                set    PROPIEDAD = 'C',
                       SUBSCRIBER_ID = nuSubscriberId,
                       OPERATING_UNIT_ID = null
                where  ID_ITEMS_SERIADO = nuSerialItemsId;
            exception
            when others then
                 pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
                 ut_trace.trace(' ------------------ ERROR NO SE PUEDE ACTUALIZAR!!!! : '||sbErrorMessage,1);
            end;
            ut_trace.trace(' ------------------ actualizaPropiedadCliente PASO 6. DESPUES DE ACTUALIZAR',1);
        end if;
        ut_trace.trace(' ------------------ actualizaPropiedadCliente PASO 7. FIN',1);
    END actualizaPropiedadCliente;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fnuGetPromedioPlancha
    Descripcion : Devuelve el promedio de los puntos de calibración de una plancha termofusión
    Autor       : llozada
    Fecha       : 14-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    14-08-2014          llozada              Creaci?n.
    **************************************************************************/
    FUNCTION fnuGetPromedioPlancha(inuOrderId or_order.order_id%type)
    return number
    IS
        nuPromedio  number;
        nuVar       number;

        Cursor cuPromedio(inuVar or_order_act_measure.variable_id%type)
        IS
            select  avg(abs(item_value - pattern_value))
            from  or_order_act_measure
            where ORDER_id = inuOrderId
            AND variable_id IN (inuVar);
    BEGIN
        nuVar := fnuObtValorParametro(csbPuntosPlancha);

        open cuPromedio(nuVar);
        fetch cuPromedio into nuPromedio;
        close cuPromedio;

        if nuPromedio is not null then
            return nuPromedio;
        end if;

        return 0;

    END fnuGetPromedioPlancha;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fsbGetTemperaturaCA
    Descripcion : Devuelve las condiciones ambientales para la temperatura
    Autor       : llozada
    Fecha       : 14-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    14-08-2014          llozada              Creaci?n.
    **************************************************************************/
    FUNCTION fsbGetTemperaturaCA(inuOrderId or_order.order_id%type)
    return varchar2
    is
        sbLaboratorio  LDC_EQUILAB_.laboratorio%type;
    begin
        sbLaboratorio := ldc_bometrologia.fnugetTipoLab (inuOrderId);

        if sbLaboratorio like csbPlanchas||'%' THEN
            return dald_parameter.fsbGetValue_Chain(csbTemperaturaCAPlanchas);
        elsif sbLaboratorio like csbPresion||'%' THEN
            return dald_parameter.fsbGetValue_Chain(csbTemperaturaCAPresion);
        elsif sbLaboratorio like csbTemperatura||'%' THEN
            return dald_parameter.fsbGetValue_Chain(csbTemperaturaCATemp);
        elsif sbLaboratorio like csbConcentracion||'%' THEN
            return dald_parameter.fsbGetValue_Chain(csbTemperaturaCACGas);
        elsif sbLaboratorio like csbOrificios||'%' THEN
            return dald_parameter.fsbGetValue_Chain(csbTemperaturaCAOri);
        end if;

        return null;
    end fsbGetTemperaturaCA;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fsbGetHumedadCA
    Descripcion : Devuelve las condiciones ambientales para la humedad
    Autor       : llozada
    Fecha       : 14-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    14-08-2014          llozada              Creaci?n.
    **************************************************************************/
    FUNCTION fsbGetHumedadCA(inuOrderId or_order.order_id%type)
    return varchar2
    is
        sbLaboratorio  LDC_EQUILAB_.laboratorio%type;
    begin
        sbLaboratorio := ldc_bometrologia.fnugetTipoLab (inuOrderId);

        if sbLaboratorio like csbPlanchas||'%' THEN
            return dald_parameter.fsbGetValue_Chain(csbHumedadCAPlanchas);
        elsif sbLaboratorio like csbPresion||'%' THEN
            return dald_parameter.fsbGetValue_Chain(csbHumedadCAPresion);
        elsif sbLaboratorio like csbTemperatura||'%' THEN
            return dald_parameter.fsbGetValue_Chain(csbHumedadCATemp);
        elsif sbLaboratorio like csbConcentracion||'%' THEN
            return dald_parameter.fsbGetValue_Chain(csbHumedadCACGas);
        elsif sbLaboratorio like csbOrificios||'%' THEN
            return dald_parameter.fsbGetValue_Chain(csbHumedadCAOri);
        end if;

        return null;
    end fsbGetHumedadCA;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fsbGetNormaByItem
    Descripcion : Devuelve la norma de acuerdo al ítem
    Autor       : llozada
    Fecha       : 27-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    27-08-2014          llozada              Creaci?n.
    03-12-2014          agordillo NC 3969    Modificacion: Se consulta el paquete y el tipo de paquete.
                                             Se agrega la condicion de si el paquete es tipo de solicitud 299,
                                             se consulte y valide la NORMA, de resto se devuelve null en la funcion.
                                             La modificacion se realiza dado que solo para solicitudes de tipo 299
                                             se necesita este atributo
    **************************************************************************/
    function fsbGetNormaByItem(inuIdCotizacion    cc_quotation.quotation_id%type)
    return varchar2
    is
        nuCodEquiFrec                   number := 0;
        sbNorma                         varchar2(4000);
        nuItemid                        ge_items_seriado.items_id%type;
        nuPackageId                     cc_quotation.package_id%type;
        nuPackageTypeId                 mo_packages.package_type_id%type;
        nuTipoPackNorma                 number := 299;

        CURSOR cuEquivalencia(inuEquiId GE_EQUIVALENC_VALUES.equivalence_set_id%type,
                            inuItem   GE_EQUIVALENC_VALUES.origin_value%type)
        IS
            select target_value
            from GE_EQUIVALENC_VALUES
            where equivalence_set_id = inuEquiId
            and origin_value = inuItem;

        CURSOR cuItemsId
        IS
            select items_id
            from cc_quotation_item
            where quotation_id = inuIdCotizacion
            and rownum < 2;
    begin

       -- Inicia NC 3969 Agordillo 03/12/2014
        -- Se obtiene la solicitud
        nuPackageId := dacc_quotation.fnugetpackage_id(inuIdCotizacion);

        -- Se obtiene el tipo de paquete
        nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackageId);

        -- Si es tipo de solicitud 299 valida la existencia de la norma
        IF (nuPackageTypeId = nuTipoPackNorma ) THEN

            nuCodEquiFrec := fnuObtValorParametro(csbEquiNorma);

            open cuItemsId;
            fetch cuItemsId into nuItemid;
            close cuItemsId;

            if nuItemid is not null then
                open cuEquivalencia(nuCodEquiFrec, nuItemid);
                fetch cuEquivalencia INTO sbNorma;
                close cuEquivalencia;

                if sbNorma is null then
                    ge_boerrors.seterrorcodeargument (2741,'No se ha configurado la equivalencia para el ?TEM '||
                                                          nuItemid||'. Esto debe hacerse para determinar la NORMA del equipo'||
                                                          ' Para configurar la equivalencia debe ir a la forma '||
                                                          '[GEAGE/Grupos de Equivalencia], buscar por el c?digo: '||nuCodEquiFrec||
                                                          '; Y adicionar el ?TEM en la pesta?a DATOS DE GRUPO DE EQUIVALENCIA.')  ;

                end if;

                Return sbNorma;
            end if;

            ge_boerrors.seterrorcodeargument (2741,'No hay ITEMS asociados a la solicitud.');

        else
            return null;
        END IF;

        -- Fin NC 3969 Agordillo

    end fsbGetNormaByItem;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     : fsbGetAddressByQuotation
    Descripcion : Devuelve la dirección del laboratorio o de la empresa.
    Autor       : llozada
    Fecha       : 27-08-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    27-08-2014          llozada              Creaci?n.
    03-07-2025          jpinedc             OSF-4555: Se reemplaza pktblSistema
    **************************************************************************/
    function fsbGetAddressByQuotation(inuIdCotizacion    cc_quotation.quotation_id%type)
    return varchar2
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbGetAddressByQuotation';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuPackage               cc_quotation.package_id%type;
        nuUnidadLab             number:=0;
        sbDirecccion            or_operating_unit.address%type;
        nuLocalidad             ab_address.geograp_location_id%TYPE;

        CURSOR cuPackage
        IS
            SELECT ct.package_id, ad.geograp_location_id
            from  cc_quotation ct,
            mo_packages pk,
            ab_address ad
            where QUOTATION_ID = inuIdCotizacion
            and pk.package_id(+) = ct.package_id
            and ad.address_id(+) = pk.address_id;
            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        open cuPackage;
        fetch cuPackage into nuPackage, nuLocalidad;
        close cuPackage;

        if nuPackage is not null then
            if damo_packages.fnugetpackage_type_id(nuPackage) = fnuObtValorParametro(csbServicioTecExt) then
                nuUnidadLab := fnuObtValorParametro(csbLaboratorio);
                sbDirecccion := daor_operating_unit.fsbgetaddress(nuUnidadLab,null);

                if sbDirecccion IS null then
                    pkg_error.setErrorMessage( isbMsgErrr => 'Debe ingresar una Dirección para '||
                                                          ' la unidad operativa responsable del Laboratorio. ['||nuUnidadLab||
                                                          ' - '||daor_operating_unit.fsbgetname(nuUnidadLab) ||']');
                END if;
                
            end if;
            
        end if;
        
        IF sbDirecccion IS NULL THEN
            sbDirecccion := pkg_Empresa.fsbObtDireccionEmpresa( pkg_BOConsultaEmpresa.fsbObtEmpresaLocalidad( nuLocalidad));
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        RETURN sbDirecccion;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbDirecccion;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN sbDirecccion;
    END fsbGetAddressByQuotation;


    /*** Funci??ue retorna la incertidumbre para concentracion**/
    FUNCTION fsbGetIncertidumbreConcNomi
    (
      inuOrderId    in OR_order.order_id%type
    )
    return varchar2
    IS
        cnuK                 number;  -- Constante K
        UB_Exp               number ;
        sbTipoLab            ldc_plantemp.pltelabo%type;
        UB_Patron            number ; -- Valor incertidumbre tipo A
        UA_concet            number;
        UB_Resolucion        number;
        nuTipoElemento       number;
        nuPlanTemp           number;
        nuVaceCodi           number;
        onuVacecodi          number;
        osbVaceVaat          varchar2(100);
        sbResult             varchar2(2000);

        --  Variables para manejo de Errores
        exCallService        EXCEPTION;
        sbCallService        varchar2(2000);
        sbErrorMessage       varchar2(2000);
        nuErrorCode          number;

        /*Obtiene la icnertidumbre tipo A*/
        FUNCTION fnugetUA_Concent_2
        (
          inuOrderId in OR_order.order_id%type
        )return  number
        IS

          nuPlanTemp                 ge_variable_template.variable_template_id%type;
          onuVacecodi                ldc_varicert.vacecodi%type;
          osbVaceVaat                ldc_varicert.vacevaat%type;
          nuVarConcEqui              ldc_variattr.vaatvaat%type;
          nuItemId                   ge_items.items_id%type;
          nuItemSe                   ge_items_seriado.id_items_seriado%type;
          nuUA_Conc                  number;
          --  Variables para manejo de Errores
          exCallService              EXCEPTION;
          sbCallService              varchar2(2000);
          sbErrorMessage             varchar2(2000);
          nuErrorCode                number;

          -- CURSOR que obtiene el m?ximo  Error entre Sub y bajadas.
          CURSOR cuUA_Concent(inuOrderId     in   OR_order.order_id%type ,
                              inuVarConcEqui  in   ldc_variattr.vaatvaat%type)
          IS
            select  STDDEV(item_value) UA
            from  or_order_act_measure
            where ORDER_id = inuOrderId
            AND variable_id IN (inuVarConcEqui);

        BEGIN
          --.TRACE('Inicia  LDC_BOmetrologia.fnugetUA_Concent',8);
          -- Obtiene el Id de la planilla utilizada en el proceso
           /*nuPlanTemp := fnugetIdPlanilla(inuOrderId) ;
           ldc_bometrologia.getVacecodiVacevaat(csbConcEquipo ,onuVacecodi,osbVaceVaat)  ;
           nuVarConcEqui := ldc_bometrologia.fnugetIdentifVariAttrib(onuVacecodi,nuPlanTemp); */

          nuVarConcEqui := LDC_BOmetrologia.fnuObtValorParametro('LDC_CONCENTRACION_NOMINAL_2');

          /*Obtiene el la desviaci?n estandar de concentraci?n */
          for exac in cuUA_Concent(inuOrderId, nuVarConcEqui) loop
             nuUA_Conc := exac.UA;
          end loop;

          if nuUA_Conc is null then
            return null;
          end if;

          dbms_output.put_Line('UA  concentracion_2 = '|| nuUA_Conc);

          return  nuUA_Conc;

          --.TRACE('Finaliza  LDC_BOmetrologia.fnugetUA_Concent',8);

        EXCEPTION
          when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
          when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.pop;
            raise;
          when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
          pkErrors.pop;
          raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrorMessage);

        END fnugetUA_Concent_2;


        --- Obtener patron INCERTIDUMBRE_GAS_PATRON_2
        function fngetUB_Patron_2(inuOrderId in OR_order.order_id%type)
        return number
        is
            nuUB_Patron number;
            begin

                nuUB_Patron :=  convertirDecimal(LDC_BOmetrologia.fsbgetValueVariable(inuOrderId,
                    fnuObtValorParametro(csbINCERTIDUMBRE_GAS_PATRON_2)));

            return nuUB_Patron;

            exception
                when no_data_found then
                    nuUB_Patron := null;

        end fngetUB_Patron_2;

    BEGIN

        -- Obtiene el tipo de Laboratorio
        sbTipoLab := fnugetTipoLab (inuOrderId); -- FSBGETNOMBRELABORATORIO(inuOrderId); --


        -- Obtiene el valor de la constante K
        cnuK := fnuObtValorParametro(csbK);


        IF sbTipoLab like '%'||csbConcentracion||'%'  THEN

          /* Se puede afirmar que para la estimaci?n de incertidumbre para los instrumentos
            de Concentraci?n de Gas se determina a partir de la siguiente expresi?n:

             UB_Exp = k x sqrt( UA? + UB(Patron)? +UB(Resoluci?n)?  */

           -- Obtiene la incertidumbre tipo A  (UA)
           UA_concet := fnugetUA_Concent_2(inuOrderId);

           if (UA_concet is null) then
                return null;
           else
                UA_concet := UA_concet/sqrt(3);
           end if;
           -- Obtiene la UB(Patron)
           dbms_output.put_Line('UA_concet: '||UA_concet);

           -- Se realiza este cambio de acuerdo al excel Calibraci?n Detectores CO_Hoja Calculo_V1.xlsx
           -- Calibraci?n Detectores CH4_Hoja Calculo_V1.xlsx
           if upper(fsbgetUnidadMedida(inuOrderId)) like '%CO' then
               -- UB_Patron := (0.02 * fngetUB_Patron(inuOrderId))/2; -- Seg?n las formulas de Excel
               -- INCERTIDUMBRE_GAS_PATRON_2
               UB_Patron := fngetUB_Patron_2(inuOrderId); --/2;
           else
               -- INCERTIDUMBRE_GAS_PATRON_2
               UB_Patron := fngetUB_Patron_2(inuOrderId); --fngetUB_Patron(inuOrderId)/2;
                        --((2* (2*fngetUB_Patron(inuOrderId)/100) )*fngetUB_Patron(inuOrderId)
                          --      /(2*fngetUB_Patron(inuOrderId)/100)) /2;   --Seg?n las formulas de excel
           end if;
           dbms_output.put_Line('UB_Patron: '||UB_Patron);
           if (UB_Patron is null) then
                return null;

           else
               -- Obtiene la  UB(Resoluci?n)
               UB_Resolucion := fnugetUB_Resolucion(inuOrderId)/(2*sqrt(3));
               dbms_output.put_Line('UB_Resolucion: '||UB_Resolucion);

                /* UB_Exp = k x sqrt( UA? + UB(Patron)? +UB(Resoluci?n)?  */
               UB_Exp := cnuk* (sqrt(power(UA_concet,2)+ power(UB_Patron,2)+power(UB_Resolucion,2)));
               dbms_output.put_Line('UB_Exp: '||UB_Exp);

               /*29-01-2015 Llozada: Se guarda el valor de la incertidumbre para el calculo del segundo Gas
                                     en el laboratorio de concentración*/
               nuIncertidumbreGas2 := UB_Exp;

               if UB_Exp is not null then
                   sbResult := LDC_BOMETROLOGIA.fsbCifrasSignif(UB_Exp);
                   sbResult := dald_parameter.fsbGetValue_Chain(csbMasOMenos)||' '||sbResult||' '||LDC_BOMETROLOGIA.fsbgetUnidadMedida(inuOrderId);
               end if;
           end if;
        END IF;

        return sbResult;

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
            when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;

    END fsbGetIncertidumbreConcNomi;


    /*** Incertidumbre gas nominal 2 orden_ajuste **/
    FUNCTION fsbgetIncertidumbreConcNomi_AJ
    (
        inuOrderId  in OR_order.order_id%type
    )return  varchar2
    IS
        nuOrderAj   OR_order.order_id%type;
    BEGIN
        -- Valida si el Certificado tiene una orden de ajuste
        nuOrderAj := ldc_bometrologia.valCertAjuste(inuOrderId);

        if nuOrderAj > 0 then
            return ldc_bometrologia.fsbGetIncertidumbreConcNomi(nuOrderAj);
        else
            return null;
        END if;

    END fsbgetIncertidumbreConcNomi_AJ;

    /**************************************************************************
    Propiedad Intelectual de Gases de Occidente
    Funcion     :  fsbgetSecuenciaExactitud
    Descripcion : Devuelve el valor para la secuencia dependiendo de la exactitud
                  del instrumento, así:

                  Secuencia A : Exactitud Instrumento < 0,1

                  Secuencia B : 0,1 < Exactitud Instrumento < 0,6

                  Secuencia C : Exactitud Instrumento > 0,6

    Autor       : llozada
    Fecha       : 14-04-2015

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    14-04-2015          llozada [ARA 6869] Creaci?n.
  **************************************************************************/
  FUNCTION fsbgetSecuenciaExactitud(inuOrder_id or_order.order_id%type)
  RETURN VARCHAR2
  IS
        nuClase NUMBER;
  BEGIN
        nuClase:= fsbgetExactitudElement(inuOrder_id);

        IF nuClase < 0.1 THEN
            RETURN 'A';
        ELSIF nuClase >= 0.1 AND nuClase <= 0.6 THEN
            RETURN 'B';
        ELSIF nuClase > 0.6 THEN
            RETURN 'C';
        END IF;

  EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
  END fsbgetSecuenciaExactitud;

END  LDC_BOmetrologia;
/

GRANT EXECUTE on LDC_BOMETROLOGIA to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDC_BOMETROLOGIA to REXEOPEN;
GRANT EXECUTE on LDC_BOMETROLOGIA to RSELSYS;
/

