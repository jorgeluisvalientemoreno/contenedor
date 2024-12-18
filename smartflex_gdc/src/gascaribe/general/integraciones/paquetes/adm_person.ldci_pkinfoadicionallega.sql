create or replace package      ADM_PERSON.LDCI_PKINFOADICIONALLEGA is



  -- Author  : NCarrasquilla

  -- Created : 26/08/2016 08:53:30 a.m.

  -- Purpose : Recibir todos los mensajes de la tabla LDCI_INFGESTOTMOV



  procedure proProcesaXMLLegOT( mensaje_id        In ldci_infgestotmov.mensaje_id%type,

                                isbSistema        In Varchar2,

                                inuOrden          In Number,

                                isbXML            In Clob,

                                isbEstado         In ldci_infgestotmov.estado%type,

                                isbOperacion      in Varchar2,

                                inuProcesoExt     In ldci_infgestotmov.proceso_externo_id%type,

                                idtFechaRece      In ldci_infgestotmov.fecha_recepcion%type,

                                idtFechaProc      In ldci_infgestotmov.fecha_procesado%type,

                                idtFechaNoti      In ldci_infgestotmov.fecha_notificado%type,

                                inuCodErrOsf      In ldci_infgestotmov.cod_error_osf%type,

                                isbMsgErrOsf      In ldci_infgestotmov.msg_error_osf%type,

                                ocurRespuesta     Out SYS_REFCURSOR,

                                onuErrorCodi      out NUMBER,

                                osbErrorMsg       out VARCHAR2);

                                

    procedure proProcesaXMLLego( mensaje_id        In ldci_infgestotmov.mensaje_id%type,

                                isbSistema        In Varchar2,

                                inuOrden          In Number,

                                isbXML            In Clob,

                                isbEstado         In ldci_infgestotmov.estado%type,

                                isbOperacion      in Varchar2,

                                inuProcesoExt     In ldci_infgestotmov.proceso_externo_id%type,

                                idtFechaRece      In ldci_infgestotmov.fecha_recepcion%type,

                                idtFechaProc      In ldci_infgestotmov.fecha_procesado%type,

                                idtFechaNoti      In ldci_infgestotmov.fecha_notificado%type,

                                inuCodErrOsf      In ldci_infgestotmov.cod_error_osf%type,

                                isbMsgErrOsf      In ldci_infgestotmov.msg_error_osf%type,

                                ocurRespuesta     Out SYS_REFCURSOR,

                                onuErrorCodi      out NUMBER,

                                osbErrorMsg       out VARCHAR2 ) ;



    /*

    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.

    *

    * Funcion     : proProcesaXMLLego

    * Tiquete     :

    * Autor       : Luis Javier Lopez Barrios

    * Fecha       : 01/08/2018

    * Descripcion : Recibe el XML de informacion adicional de registro de ordenes.

    *

    * Historia de Modificaciones

    * Autor                         Fecha      Descripcion



    **/



end LDCI_PKINFOADICIONALLEGA;

/

create or replace package body      ADM_PERSON.LDCI_PKINFOADICIONALLEGA is





  -- Function and procedure implementations

  procedure proProcesaXMLLegOT( mensaje_id        In ldci_infgestotmov.mensaje_id%type,

                                isbSistema        In Varchar2,

                                inuOrden          In Number,

                                isbXML            In Clob,

                                isbEstado         In ldci_infgestotmov.estado%type,

                                isbOperacion      in Varchar2,

                                inuProcesoExt     In ldci_infgestotmov.proceso_externo_id%type,

                                idtFechaRece      In ldci_infgestotmov.fecha_recepcion%type,

                                idtFechaProc      In ldci_infgestotmov.fecha_procesado%type,

                                idtFechaNoti      In ldci_infgestotmov.fecha_notificado%type,

                                inuCodErrOsf      In ldci_infgestotmov.cod_error_osf%type,

                                isbMsgErrOsf      In ldci_infgestotmov.msg_error_osf%type,

                                ocurRespuesta     Out SYS_REFCURSOR,

                                onuErrorCodi      out NUMBER,

                                osbErrorMsg       out VARCHAR2 ) is



    /*

    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.

    *

    * Funcion     : proProcesaXMLLegOT

    * Tiquete     :

    * Autor       : Nivis Carrasquilla Zu?iga

    * Fecha       : 26-08-2016

    * Descripcion : Recibe el XML de informacion adicional de registro de venta para que OSF genere la venta.

    *

    * Historia de Modificaciones

    * Autor                         Fecha      Descripcion

    * Nivis Carrasquilla Zu?iga    26-08-2016 Creacion del procedimieno
     jsoto                         6/12/2023  (OSF-1891) Se elimina el método proProcesaXMLLegOT

    **/



  begin

  NULL;

  end proProcesaXMLLegOT;

  

   procedure proProcesaXMLLego( mensaje_id        In ldci_infgestotmov.mensaje_id%type,

                                isbSistema        In Varchar2,

                                inuOrden          In Number,

                                isbXML            In Clob,

                                isbEstado         In ldci_infgestotmov.estado%type,

                                isbOperacion      in Varchar2,

                                inuProcesoExt     In ldci_infgestotmov.proceso_externo_id%type,

                                idtFechaRece      In ldci_infgestotmov.fecha_recepcion%type,

                                idtFechaProc      In ldci_infgestotmov.fecha_procesado%type,

                                idtFechaNoti      In ldci_infgestotmov.fecha_notificado%type,

                                inuCodErrOsf      In ldci_infgestotmov.cod_error_osf%type,

                                isbMsgErrOsf      In ldci_infgestotmov.msg_error_osf%type,

                                ocurRespuesta     Out SYS_REFCURSOR,

                                onuErrorCodi      out NUMBER,

                                osbErrorMsg       out VARCHAR2 ) is



    /*

    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.

    *

    * Funcion     : proProcesaXMLLego

    * Tiquete     :

    * Autor       : Luis Javier Lopez Barrios

    * Fecha       : 01/08/2018

    * Descripcion : Recibe el XML de informacion adicional de registro de ordenes.

    *

    * Historia de Modificaciones

    * Autor                         Fecha      Descripcion



    **/



    csbEntrega2002017  CONSTANT VARCHAR2(100) := 'OSS_REV_LJLB_2002017_8';

    sbOtAdi           varchar2(1000);



  begin





    IF fblaplicaentrega(csbEntrega2002017) THEN



      --PROCESA LAS GESTIONES ADICIONALES

      onuErrorCodi := 0;



      ldcI_botrabajoadicional.prolegalizaotxml( isbXML,

                                               osbErrorMsg,

                                               onuErrorCodi

                                               );



      if ( onuErrorCodi = 0 ) then

         NULL;--select OsbErrorMsg into sbOtAdi from dual;

      end if;



      open ocurRespuesta for

        select 'idSistema' parametro, isbSistema valor from dual union

        select 'idOrden' parametro, to_char(inuOrden) valor from dual union

        select 'trabajosAdicionales' parametro, to_char(inuOrden) valor from dual union

        select 'codigoError' parametro, to_char(onuErrorCodi) valor from dual union

        select 'mensajeError' parametro, osbErrorMsg valor from dual;



      commit;



    END IF;

    -- Manejo de excepciones

    Exception

      When Others Then

          onuErrorCodi := -1;

          osbErrorMsg  := '[LDCI_PKINFOADICIONALLEGA.proProcesaXMLLego.Others]: ' ||

                          SqlErrM;



  end proProcesaXMLLego;





end LDCI_PKINFOADICIONALLEGA;

/
PROMPT Otorgando permisos de ejecucion a LDCI_PKINFOADICIONALLEGA
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKINFOADICIONALLEGA','ADM_PERSON');
END;
/
