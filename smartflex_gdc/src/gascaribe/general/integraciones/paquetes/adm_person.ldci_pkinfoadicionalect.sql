CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKINFOADICIONALECT AS
  /*
   * Propiedad Intelectual Gases del Caribe SA ESP
   *
   * Script  :
   * RICEF   : I074 - I075
   * Autor   : Jose Donado <jdonado@gascaribe.com>
   * Fecha   : 04-06-2014
   * Descripcion : Paquete gestion de informacion adicional de ordenes moviles

   *
   * Historia de Modificaciones
   * Autor                         Fecha       Descripcion
   * JESUS VIVERO (LUDYCOM)        24-04-2015  #149251-20150424: jesviv: Se agrega calculo de descuento maximo de refinanciacion y fecha de pago como sysdate + dias de gracia
   * JESUS VIVERO (LUDYCOM)        13-05-2015  #148643-20150513: jesviv: Se corrige funcion fnuDescuentoMaxRefinan para calcular de forma correcta el descuento maximo
   * SAMUEL PACHECO (SINCECOMP)    20-01-2016  ca 100-7282: se corrigen error en (Proregistracotizacion) registro de venta cotizada al momento de reenvia venta; de igual forma
                                               se contrala y notifica como error cuando se intenta reenviar una venta ya aplicada
   * FCASTRO (CA575)               14-11-2020  Se halla periodo de consumo para enviarlo a la tabla ldc_cm_lectesp ya que antes iba nulo

  **/

  Procedure proProcesaXMLLectura(isbSistema      In Varchar2,
                                 inuOrden        In Number,
                                 isbXMLEncuesta  In Clob,
                                 otyTabRespuesta Out LDCI_PkRepoDataType.tyTabRespuesta,
                                 onuErrorCodi    Out Number,
                                 osbErrorMsg     Out Varchar2);

END LDCI_PKINFOADICIONALECT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKINFOADICIONALECT AS

  Procedure proProcesaXMLLectura(isbSistema      In Varchar2,
                                 inuOrden        In Number,
                                 isbXMLEncuesta  In Clob,
                                 otyTabRespuesta Out LDCI_PkRepoDataType.tyTabRespuesta,
                                 onuErrorCodi    Out Number,
                                 osbErrorMsg     Out Varchar2) As
    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Funcion     : proProcesaXMLEncuesta
    * Tiquete     :
    * Autor       : AAcuna <aacuna@jmgestioninformatica.com>
    * Fecha       : 15-06-2016
    * Descripcion : Recibe el XML de informacion adicional de registro de lecturas complementarias.
    *
    *  XML de entrada
    *
     <proProcesaXMLRegLecControl>
        <idProducto></idProducto> -- Obligatorio
        <idConsecutivoExterno></idConsecutivoExterno> -- Obligatorio
        <idPeriodoFacturacion></idPeriodoFacturacion> -- Obligatorio
        <lectura></lectura> -- Obligatorio
        <presion></presion> -- Obligatorio
        <temperatura></temperatura> -- Obligatorio
        <presionAlta/>
        <presionBaja/>
        <volCorregido/>
        <volSinCorregir/>
        <lecturaEagle/>
        <fechaHoraLectura></fechaHoraLectura>
        <voltajeBateria/>
        <servicioFuncionando/>
      </proProcesaXMLRegLecControl>

    * Historia de Modificaciones
    * Autor          Fecha      Descripcion
    * AAcuna   15-06-2016 Creacion del procedimieno
      AAcuna   10-01-2016 Cambios sobre el proceso de lecturas para agregar parametros sobre la causal y observaciones para cuando no se digite la presion
      FCastro  04-11-2020 CA575 Se halla y agrega el periodo de facturacion en la cadena que se envia a ldc_pkcm_lectesp.proinslectura
    **/

    -- Cursor para extraer del XML la informacion de la lectura
    Cursor cuXMLLectura(isbXMLDat In Clob) Is
      Select Datos.idProducto,
             Datos.idConsecutivoExterno,
             Datos.idPeriodoFacturacion,
             Datos.lectura,
             Datos.presion,
             Datos.temperatura,
             Datos.presionAlta,
             Datos.presionBaja,
             Datos.volCorregido,
             Datos.volSinCorregir,
             Datos.lecturaEagle,
             Datos.fechaHoraLectura,
             Datos.voltajeBateria,
             Datos.servicioFuncionando,
             Datos.codigoNoLectura,
             Datos.observacion
        From XMLTable('/proProcesaXMLRegLecControl' Passing
                      XMLType(isbXMLDat) Columns idProducto Number Path
                      'idProducto',
                      idConsecutivoExterno Number Path
                      'idConsecutivoExterno',
                      idPeriodoFacturacion Number Path
                      'idPeriodoFacturacion',
                      lectura Varchar2(20) Path 'lectura',
                      presion Number Path 'presion',
                      temperatura Number Path 'temperatura',
                      presionAlta Number Path 'presionAlta',
                      presionBaja Number Path 'presionBaja',
                      volCorregido Number Path 'volCorregido',
                      volSinCorregir Number Path 'volSinCorregir',
                      lecturaEagle Number Path 'lecturaEagle',
                      fechaHoraLectura Varchar2(100) Path 'fechaHoraLectura',
                      voltajeBateria Varchar2(100) Path 'voltajeBateria',
                      servicioFuncionando Varchar(50) Path
                      'servicioFuncionando',
                      codigoNoLectura Number Path 'codigoNoLectura',
                      observacion Varchar(1000) Path 'observacion') As Datos;

   -- Se halla periodo de consuno (CA575)
   cursor cuPericose (nupefa perifact.pefacodi%type) is
    select pefacicl, pc.pecscons
      from open.perifact p, open.pericose pc
     where pc.pecsfecf between pefafimo and pefaffmo
       and pc.pecscico = pefacicl
       and pefacodi=nupefa;

   -- Se halla ciclo del producto
   cursor cuCicloProd (nuprod servsusc.sesunuse%type) is
     select sesucicl, sesucico
       from open.servsusc
      where sesunuse=nuprod;

    --Variables
    isbDatosCad     varchar2(3200);
    idConsExt       Number := 0;
    nupefacicl      servsusc.sesucicl%type;
    nupecs          pericose.pecscons%type;
    nusesucicl      servsusc.sesucicl%type;
    nusesucico      servsusc.sesucicl%type;

    --Datos de Salida

    --Estructura de respuesta
    tabRespuesta   LDCI_PkRepoDataType.tyTabRespuesta;
    tyRegRespuesta LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;

    ISBXML2       clob; -- se crea para pruebas
    ISBXML3       varchar2(3200); -- se crea para pruebas
    sbObservacion varchar2(3200);
    nuCausal      number := 0;

  Begin

    /* ISBXML3 := '<?xml version="1.0" encoding="UTF-8"?><proProcesaXMLRegLecControl><idProducto>1191328</idProducto><idConsecutivoExterno>9</idConsecutivoExterno><idPeriodoFacturacion>67610</idPeriodoFacturacion><lectura>99</lectura><presion>123</presion><temperatura>123</temperatura><codigoNoLectura>0</codigoNoLectura><codigoObservacion>0</codigoObservacion><presionAlta/><presionBaja/><volCorregido/><volSinCorregir/><lecturaEagle/><fechaHoraLectura>02/07/2016 07:56:37</fechaHoraLectura><voltajeBateria/><servicioFuncionando/></proProcesaXMLRegLecControl>';
    */ -- Inicializacion control de error
    onuErrorCodi := 0;
    osbErrorMsg  := Null;

    -- Inicializacion del contador de preguntas registradas
    idConsExt := 0;

   For rgLectura In cuXMLLectura(isbXMLEncuesta) Loop

      isbDatosCad := null;

      idConsExt := rgLectura.idConsecutivoExterno;
      --Cambio 200-856
      --Si la presion de la lectura es nula -- obtengo los parametros definidos para enviar la causal y observacion
      ---Se comenta por que se aplica bajo el caso 200-857
      /*if (rgLectura.presion is null) then

        sbObservacion := dald_parameter.fsbGetValue_Chain('OBSE_CAUSAL_LECT_COMP');
        nuCausal      := dald_parameter.fnuGetNumeric_Value('CAUSAL_LECT_COMP');

      else
        sbObservacion := null;
        nuCausal      := null;
      end if;*/

      -- Se halla periodo de consumo (CA575)
      open cuPericose(rgLectura.idPeriodoFacturacion);
      fetch cuPericose into nupefacicl, nupecs;
      if cuPericose%notfound then
        nupefacicl := null;
        nupecs := null;
      end if;
      close cuPericose;

      -- valida si el ciclo del periodo de facturacion es diferente al del producto (sucederia si el producto cambio de ciclo entre la generacion
      -- de la lectura y la legalizacion), y valida que el producto tenga sus ciclos de facturacion y de consumo iguales
      if nupecs is not null then
        /*open cuCicloProd(rgLectura.idProducto);
        fetch cuCicloProd  into nusesucicl, nusesucico;
        if cuCicloProd%notfound then
          nusesucicl := null;
          nusesucico := null;
        end if;
        close cuCicloProd;

        if nusesucicl != nusesucico then
          onuErrorCodi := -1;
          osbErrorMsg := 'Ciclo de fact del producto diferente a su ciclo de consumo';
        elsif nusesucicl != nupefacicl then
          onuErrorCodi := -1;
          osbErrorMsg := 'Ciclo de fact del producto diferente al del periodo que se esta legalizando';
        end if;
      else
         onuErrorCodi := -1;
         osbErrorMsg := 'Periodo de consumo no hallado';
      end if;

      If Nvl(onuErrorCodi, 0) !=  -1 Then*/
        isbDatosCad := inuOrden || '|' || rgLectura.idProducto || '|' ||
                       rgLectura.idConsecutivoExterno || '|' || nupecs  || '|' ||
                       rgLectura.idPeriodoFacturacion || '|' ||
                       rgLectura.fechaHoraLectura || '|' ||
                       to_char(sysdate, 'dd/mm/yyyy') || '|' ||
                       rgLectura.lectura || '|' || rgLectura.temperatura || '|' ||
                       rgLectura.presion || '|' || rgLectura.presionAlta || '|' ||
                       rgLectura.presionBaja || '|' || rgLectura.volCorregido || '|' ||
                       rgLectura.volSinCorregir || '|' ||
                       rgLectura.lecturaEagle || '|' ||
                       rgLectura.voltajeBateria || '|' ||
                       rgLectura.servicioFuncionando || '|' || 'S' || '|' ||
                       rgLectura.Codigonolectura || '|' || rgLectura.Observacion || '|';

      -- Se ingresa la lectura tomada

      ldc_pkcm_lectesp.proinslectura(isbDatosCad,
                                     onuErrorCodi,
                                     osbErrorMsg);
    end if;
  End Loop;

    -- Se valida si no ocurrio error
    If Nvl(onuErrorCodi, 0) = 0 Then

      Commit;

    Else

      RollBack;

    End If;

    -- Genera la Respuesta
    tyRegRespuesta.Parametro := 'idSistema';
    tyRegRespuesta.Valor := isbSistema;
    tabRespuesta(1) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idOrden';
    tyRegRespuesta.Valor := Nvl(idConsExt, 0);
    tabRespuesta(2) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idConsecutivoExterno';
    tyRegRespuesta.Valor := Nvl(inuOrden, 0);
    tabRespuesta(3) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'codigoError';
    tyRegRespuesta.Valor := Nvl(onuErrorCodi, 0);
    tabRespuesta(4) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'mensajeError';
    tyRegRespuesta.Valor := osbErrorMsg;
    tabRespuesta(5) := tyRegRespuesta;

    -- Se asigna la respuesta a la salida
    otyTabRespuesta := tabRespuesta;

    -- Manejo de excepciones
  Exception
    When Others Then

      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKINFOADICIONALECT.proProcesaXMLLectura.Others]: ' ||
                      SqlErrM;

  End proProcesaXMLLectura;

End LDCI_PKINFOADICIONALECT;
/

PROMPT Asignación de permisos para el paquete LDCI_PKINFOADICIONALECT
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKINFOADICIONALECT', 'ADM_PERSON');
end;
/


