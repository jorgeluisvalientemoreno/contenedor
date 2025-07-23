CREATE OR REPLACE PACKAGE ldci_pkintercontablemesa AS

/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : LDCI_PKINTERCONTABLEMESA.sql
         AUTOR : Heiber Barco
         FECHA : 22/07/2013

 DESCRIPCION : Paquete de interfaz con SAP(PI),tiene como funcion principal el
               el manejo de los errores que pueden ocurrir durante el consumo de
               servicios web.
 Parametros de Entrada

    iNuDocumento IN LDCI_ENCAINTESAO.NUM_DOCUMENTOSAP%TYPE
    sbMensaje    OUT VARCHAR2

 Parametros de Salida

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    05/11/2013  Ajuste para guardar los parametros que realizaron el llamado
                          al paquete de envio a SAP para interfaz contable
************************************************************************/

PROCEDURE proEnviaDocContable
                          ( iNuDocumento IN  LDCI_ENCAINTESAP.COD_INTERFAZLDC%TYPE);


END LDCi_PKINTERCONTABLEMESA;
/
CREATE OR REPLACE PACKAGE BODY ldci_pkintercontablemesa AS

/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : proEnviaDocContable.prc
 * Autor   : Arquitecsoft Heiber Barco
 * Fecha   : 22/07/2013
 * Descripcion : Crea el paquete SOAP de acuerdo a los parametros configurados
 *
 * Parametros
 * iNuDocumento   IN LDC_ENCAINTESAP.COD_INTERFAZLDC%TYP,
 * sbMensaje      IN VARCHAR2
 *
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
**/

PROCEDURE proEnviaDocContable
                          ( iNuDocumento IN  LDCI_ENCAINTESAP.COD_INTERFAZLDC%TYPE ) AS

/*
 * Este cursor permite extraer la informaci?n depurada de la interfaz contable
 * que corresponda, y a partir de esta informacion se genere el xml para enviar
 */



CURSOR cuDatosInterContable
IS
SELECT  XMLElement("urn:ContabilizaDoctosFinanSend",
        XMLAGG(XMLElement("Docs",
            decode(FECHDCTO,null,null,XMLElement("FechDcto",to_char(FECHDCTO,'YYYY-MM-DD'))),
            decode(FECHCONT,null,null,XMLElement("FechCont",to_char(FECHCONT,'YYYY-MM-DD'))),
            decode(GRLEDGER,null,null,XMLElement("GrLedger",GRLEDGER)),
            --decode(IDENTIFICADOR,null,null,XMLElement("Identificador",IDENTIFICADOR)),
            decode(REFERENC,null,null,XMLElement("Referenc",REFERENC)),
            decode(TXTCABEC,null,null,XMLElement("TxtCabec",TXTCABEC)),
            decode(CLASEDOC,null,null,XMLElement("ClaseDoc",CLASEDOC)),
            decode(SOCIEDAD,null,null,XMLElement("Sociedad",SOCIEDAD)),
            decode(CURRENCY,null,null,XMLElement("Currency",CURRENCY)),
            (SELECT   XMLAGG(
             XMLELEMENT(NAME "Detalle",
                        decode(ClavCont,null,null,XMLElement("ClavCont",ClavCont)),
                        --decode(IDENTIFICADOR,null,null,XMLElement("Identificador",IDENTIFICADOR)),
                        decode(ClaseCta,null,null,XMLElement("ClaseCta",ClaseCta)),
                        decode(IndicCME,null,null,XMLElement("IndicCME",IndicCME)),
                        decode(ImpoMTrx,null,null,XMLElement("ImpoMTrx",ImpoMTrx)),
                        decode(ImpoMSoc,null,null,XMLElement("ImpoMSoc",ImpoMSoc)),
                        decode(IndicIVA,null,null,XMLElement("IndicIVA",IndicIVA)),
                        decode(CondPago,null,null,XMLElement("CondPago",CondPago)),
                        decode(FechBase,null,null,XMLElement("FechBase",FechBase)),
                        decode(RefFactr,null,null,XMLElement("RefFactr",RefFactr)),
                        decode(BaseImpt,null,null,XMLElement("BaseImpt",BaseImpt)),
                        decode(CentroCo,null,null,XMLElement("CentroCo",CentroCo)),
                        decode(OrdenInt,null,null,XMLElement("OrdenInt",OrdenInt)),
                        decode(Cantidad,null,null,XMLElement("Cantidad",Cantidad)),
                        decode(Asignacn,null,null,XMLElement("Asignacn",Asignacn)),
                        decode(TxtPoscn,null,null,XMLElement("TxtPoscn",TxtPoscn)),
                        decode(CentroBe,null,null,XMLElement("CentroBe",CentroBe)),
                        decode(Segmento,null,null,XMLElement("Segmento",Segmento)),
                        decode(ObjCosto,null,null,XMLElement("ObjCosto",ObjCosto)),
                        decode(ClavRef1,null,null,XMLElement("ClavRef1",ClavRef1)),
                        decode(ClavRef2,null,null,XMLElement("ClavRef2",ClavRef2)),
                        decode(ClavRef3,null,null,XMLElement("ClavRef3",ClavRef3)),
                        decode(Material,null,null,XMLElement("Material",Material)),
                        decode(Tiporetc,null,null,XMLElement("Tiporetc",Tiporetc)),
                        decode(Indretec,null,null,XMLElement("Indretec",Indretec)),
                        decode(Baseretc,null,null,XMLElement("Baseretc",Baseretc)),
                        decode(FechValor,null,null,XMLElement("FechValor",to_char(FechValor,'YYYY-MM-DD'))),
                        decode(CtaDiv,null,null,XMLElement("CtaDiv",CtaDiv))
                        ))
            FROM LDCI_DETAINTESAP detalleSap
            WHERE  detalleSap.COD_INTERFAZLDC =  encabezadoSap.COD_INTERFAZLDC
            AND detalleSap.NUM_DOCUMENTOSAP = encabezadoSap.NUM_DOCUMENTOSAP
            AND detalleSap.identificador = encabezadoSap.identificador)
        ))
        )
FROM LDCI_ENCAINTESAP encabezadoSap
WHERE encabezadoSap.COD_INTERFAZLDC=iNuDocumento;

  vaDatos             XMLType;
  sbPayload           CLOB;
  sbResponse          CLOB;
  nuReportSoapError   NUMBER;
  nuReportHttpError   NUMBER;
  codMensaje          NUMBER;
  sbNameSpace         ldci_carasewe.casevalo%type;
  sbTarget            ldci_carasewe.casevalo%type;
  sbTargetFull        ldci_carasewe.casevalo%type;
  sbProtocolo         ldci_carasewe.casevalo%TYPE;
  sbHost              ldci_carasewe.casevalo%type;
  sbWSURL             ldci_carasewe.casevalo%type;
  sbSoapAction        ldci_carasewe.casevalo%type;
  sbPuerto            ldci_carasewe.casevalo%type;
  sbMens              VARCHAR2(500);
  nuEstado            NUMBER;
  onuProcCodi         NUMBER;
  onuErrorCode        NUMBER;
  osbErrorMessage     VARCHAR2(2000);



BEGIN

dbms_output.put_Line('Inicio PROCESO ... '||iNuDocumento);
  /*
   * Obtengo el mensaje xml a enviar
   */
  open cuDatosInterContable;
   fetch cuDatosInterContable into vaDatos;
  close cuDatosInterContable;

  /*
    * Se registra el mensaje
    * en estaproc
    * para hacer seguimiento al
    * envio de la interfaz
    * Esto va con excepcion controlada
    * ya que esto no es motivo para detener el envio
    * de la interfaz
    */

  BEGIN
    LDCI_PKMESAWS.proCreaEstaProc('WS_INTER_CONTABLE','<PARAMETROS><PARAMETRO><NOMBRE>iNuDocumento</NOMBRE> <VALOR>'||iNuDocumento||'</VALOR></PARAMETRO></PARAMETROS>',SYSDATE,'R',USER,SYS_CONTEXT('USERENV', 'TERMINAL'),'WS_INTER_CONTABLE',onuProcCodi,onuErrorCode,osbErrorMessage);
  EXCEPTION
  WHEN OTHERS THEN
    ldci_pkWebServUtils.Procrearerrorlogint('INTERFAZ CONTABLE', 1, 'Error procesando interfaz: '|| Sqlerrm || Dbms_Utility.Format_Error_Backtrace, null, null);
  END;

  sbPayload :=vaDatos.getClobVal();

  ldci_pkWebServUtils.proCaraServWeb('WS_INTER_CONTABLE','NAMESPACE',sbNameSpace,sbMens);
  ldci_pkWebServUtils.proCaraServWeb('WS_INTER_CONTABLE','PROTOCOLO',sbProtocolo,sbMens);
  ldci_pkWebServUtils.proCaraServWeb('WS_INTER_CONTABLE','WSURL',sbWSURL,sbMens);
  ldci_pkWebServUtils.proCaraServWeb('WS_INTER_CONTABLE','HOST',sbHost,sbMens);
  ldci_pkWebServUtils.proCaraServWeb('WS_INTER_CONTABLE','SOAPACTION',sbSoapAction,sbMens);
  ldci_pkWebServUtils.proCaraServWeb('WS_INTER_CONTABLE','PUERTO',sbPuerto,sbMens);

  sbTargetFull        := lower(sbProtocolo)||'://'||sbHost||':'||sbPuerto||'/'||sbWSURL;
  ldci_pksoapapi.proSetProtocol(lower(sbProtocolo));

  SELECT LDCi_SEQMESAWS.NEXTVAL INTO codMensaje FROM DUAL;

 LDCi_PKMESAWS.proCreateInitMessage(codMensaje,'WS_INTER_CONTABLE',-1);
 sbResponse := ldci_pksoapapi.fsbSoapSegmentedCall(sbPayload, sbTargetFull, sbSoapAction,sbNameSpace);
 LDCi_PKMESAWS.proUpdateFullMessageError(codMensaje,
                                           ldci_pksoapapi.sbSoapRequest,
                                           'WS_INTER_CONTABLE',
                                           ldci_pksoapapi.sbErrorHttp,
                                           sbPayload,
                                           sbResponse,
                                           ldci_pksoapapi.sbTraceError,
                                           ldci_pksoapapi.boolHttpError,
                                           ldci_pksoapapi.boolSoapError,
                                           SYSDATE
                                           );
  /*
   * Validamos si se logro realizar el envio de la interfaz
   *
   */

   IF NOT LDCI_pksoapapi.boolSoapError AND NOT LDCI_pksoapapi.boolHttpError THEN
      LDCI_PKMESAWS.PROACTUESTAPROC(onuProcCodi, SYSDATE, 'F', onuErrorCode, osbErrorMessage );
      UPDATE LDCI_MESAENVWS SET MESAPROC=onuProcCodi WHERE MESACODI=codMensaje;
      COMMIT;
   END IF;

  dbms_output.put_Line('Termina Proceso '||iNuDocumento||' Exito');

  EXCEPTION
  WHEN OTHERS THEN
      ldci_pkWebServUtils.Procrearerrorlogint('INTERFAZ CONTABLE', 1, 'Error procesando interfaz: '|| Sqlerrm || Dbms_Utility.Format_Error_Backtrace, null, null);
      ROLLBACK;
  END proEnviaDocContable;
END ldci_pkintercontablemesa;
/
GRANT EXECUTE on LDCI_PKINTERCONTABLEMESA to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDCI_PKINTERCONTABLEMESA to REXEOPEN;
GRANT EXECUTE on LDCI_PKINTERCONTABLEMESA to INTEGRACIONES;
GRANT EXECUTE on LDCI_PKINTERCONTABLEMESA to RSELSYS;
GRANT EXECUTE on LDCI_PKINTERCONTABLEMESA to INTEGRADESA;
/
