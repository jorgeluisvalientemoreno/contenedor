CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKMESAWS AS

/*
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : LDCI_PKMESAWS.sql
         AUTOR : Hector Fabio Dominguez
         FECHA : 19/05/2011

 DESCRIPCION : Paquete de interfaz encargada del manejo de mensajes
               Tiquete 143105.
 Parametros de Entrada

   isbXmlEnv        IN LDCI_mesaenvws.mesaxmlenv%type,
   isbWebService    IN LDCI_mesaenvws.MESADEFI%type,
   isbHttpError     IN LDCI_mesaenvws.mesahttperror%type,
   isabSoapError    IN LDCI_mesaenvws.mesasoaperror%type
 Parametros de Salida

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    19/05/2011  Creacion del paquete
*/




PROCEDURE proCreateMessageError(isbXmlEnv        IN LDCI_mesaenvws.mesaxmlenv%type,
                                isbWebService    IN LDCI_mesaenvws.MESADEFI%type,
                                isbHttpError     IN LDCI_mesaenvws.mesahttperror%type,
                                isbSoapPayload   IN LDCI_mesaenvws.MESAXMLPAYLOAD%type,
                                isbSoapError     IN LDCI_mesaenvws.mesasoaperror%type,
                                isbTraceError    IN LDCI_mesaenvws.mesatraceerror%type,
                                boolHttpError    IN BOOLEAN,
                                boolSoapError    IN BOOLEAN);


PROCEDURE proSenderMessage;

procedure proUpdateMessageError(inuCodi        IN LDCI_mesaenvws.mesacodi%type,
                                 boolHttpError  IN BOOLEAN,
                                 boolSoapError  IN BOOLEAN,
                                 isbHttpError   IN LDCI_mesaenvws.mesahttperror%TYPE,
                                 isbSoapError   IN LDCI_mesaenvws.mesasoaperror%type,
                                 inuEstado      IN LDCI_mesaenvws.mesaestado%type);


PROCEDURE proCreateInitMessage (inuCodi            IN LDCI_mesaenvws.mesacodi%type,
                                  isbWebService    IN LDCI_mesaenvws.MESADEFI%type,
                                  inuEstado        IN LDCI_mesaenvws.mesaestado%type);


  PROCEDURE proUpdateFullMessageError(
                                  inuCodi          IN LDCI_mesaenvws.mesacodi%type,
                                  isbXmlEnv        IN LDCI_mesaenvws.mesaxmlenv%type,
                                  isbWebService    IN LDCI_mesaenvws.MESADEFI%type,
                                  isbHttpError     IN LDCI_mesaenvws.mesahttperror%type,
                                  isbSoapPayload   IN LDCI_mesaenvws.MESAXMLPAYLOAD%type,
                                  isbSoapError     IN LDCI_mesaenvws.mesasoaperror%type,
                                  isbTraceError    IN LDCI_mesaenvws.mesatraceerror%type,
                                  boolHttpError    IN BOOLEAN,
                                  boolSoapError    IN BOOLEAN,
                                  dtFechaFin       IN LDCI_mesaenvws.mesafechafin%type);

-- procedimeinto que hace el manejo de la tabla de procesamiento
procedure proCreaEstaProc(isbPROCDEFI      in LDCI_ESTAPROC.PROCDEFI%type,
																									icbPROCPARA      in LDCI_ESTAPROC.PROCPARA%type,
																									idtPROCFEIN      in LDCI_ESTAPROC.PROCFEIN%type,
                         isbPROCESTA      in LDCI_ESTAPROC.PROCESTA	%type,
																									isbPROCUSUA      in LDCI_ESTAPROC.PROCUSUA%type,
																									isbPROCTERM      in LDCI_ESTAPROC.PROCTERM%type,
																									isbPROCPROG      in LDCI_ESTAPROC.PROCPROG%type,
																									onuPROCCODI     out LDCI_ESTAPROC.PROCCODI%type,
																									onuErrorCode    out NUMBER,
																									osbErrorMessage out VARCHAR2);

-- procedimiento que hace el cambio de estado de la tabla de procesameintos
procedure proActuEstaProc(inuPROCCODI      in LDCI_ESTAPROC.PROCCODI%type,
												             idtPROCFEFI      in LDCI_ESTAPROC.PROCFEFI%type,
																									isbPROCESTA      in LDCI_ESTAPROC.PROCESTA	%type,
																									onuErrorCode    out NUMBER,
																									osbErrorMessage out VARCHAR2);

-- procedimiento que crea el registro del mensaje XML a enviar
procedure proCreaMensEnvio(idtMESAFECH       in LDCI_MESAENVWS.MESAFECH%type,
																										isbMESADEFI       in LDCI_MESAENVWS.MESADEFI%type,
																										inuMESAESTADO     in LDCI_MESAENVWS.MESAESTADO%type,
																										inuMESAPROC       in LDCI_MESAENVWS.MESAPROC%type,
																										icbMESAXMLENV     in LDCI_MESAENVWS.MESAXMLENV%type,
																										icdMESAXMLPAYLOAD in LDCI_MESAENVWS.MESAXMLPAYLOAD%type,
																										inuMESATAMLOT     in LDCI_MESAENVWS.MESATAMLOT%type,
																										inuMESALOTACT     in LDCI_MESAENVWS.MESALOTACT%type,
																										onuMESACODI      out LDCI_MESAENVWS.MESACODI%type,
																				 					onuErrorCode     out NUMBER,
																					 				osbErrorMessage  out VARCHAR2);

-- actualiza mensaje de envio
procedure proActuMensEnvio(inuMESACODI       in LDCI_MESAENVWS.MESACODI%type,
																										inuMESAESTADO     in LDCI_MESAENVWS.MESAESTADO%type,
																										icbMESAXMLENV     in LDCI_MESAENVWS.MESAXMLENV%type,
																										icdMESAXMLPAYLOAD in LDCI_MESAENVWS.MESAXMLPAYLOAD%type,
																										inuMESATAMLOT     in LDCI_MESAENVWS.MESATAMLOT%type,
																										inuMESALOTACT     in LDCI_MESAENVWS.MESALOTACT%type,
																										idtMESAFECHAINI   in LDCI_MESAENVWS.MESAFECHAINI%type,
																										idtMESAFECHAFIN   in LDCI_MESAENVWS.MESAFECHAFIN%type,
																										onuErrorCode     out NUMBER,
																										osbErrorMessage  out VARCHAR2);

-- procedimeinto que crea el mensaje de procesamiento
procedure proCreaMensProc(inuMESAPROC       in LDCI_MESAPROC.MESAPROC%type,
																							  isbMESADESC        in LDCI_MESAPROC.MESADESC%type,
																									isbMESATIPO        in LDCI_MESAPROC.MESATIPO%type,
																									idtMESAFECH        in LDCI_MESAPROC.MESAFECH%type,
																									onuMESACODI       out LDCI_MESAPROC.MESACODI%type,
																				 				onuErrorCode      out NUMBER,
																					 			osbErrorMessage   out VARCHAR2);

-- procedimeinto que crea el mensaje de procesamiento
procedure proCreaMensajeProc(inuMESAPROC        in LDCI_MESAPROC.MESAPROC%type,
																								    	isbMESATIPO        in LDCI_MESAPROC.MESATIPO%type,
																													inuERROR_LOG_ID    in LDCI_MESAPROC.ERROR_LOG_ID%type,
																							      isbMESADESC        in LDCI_MESAPROC.MESADESC%type,
																													isbMESAVAL1        in LDCI_MESAPROC.MESAVAL1%type,
																													isbMESAVAL2        in LDCI_MESAPROC.MESAVAL2%type,
																													isbMESAVAL3        in LDCI_MESAPROC.MESAVAL3%type,
																													isbMESAVAL4								in LDCI_MESAPROC.MESAVAL3%type,
																								    	idtMESAFECH        in LDCI_MESAPROC.MESAFECH%type,
																								    	onuMESACODI       out LDCI_MESAPROC.MESACODI%type,
																				 			    	onuErrorCode      out NUMBER,
																					 			    osbErrorMessage   out VARCHAR2);

-- retorna la pila de mensajes para un proceso determinado
procedure proGetMensProc(inuPROCCODI      in LDCI_ESTAPROC.PROCCODI%type,
																								orfMensProc     out LDCI_PKMESAWS.tyRefcursor,
																								onuErrorCode    out NUMBER,
																								osbErrorMessage out VARCHAR2);

type tyRefcursor is ref cursor;

END LDCI_PKMESAWS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKMESAWS AS
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : proSenderMessage.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft/Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Reenvia Mensajes pendientes.
 *
 * Parametros
 * isbProtocol in  VARCHAR2,
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del paquete
**/

--cursor con la informacion de la sesion
cursor cuSESSION is
			select MACHINE,
										PROGRAM,
										OSUSER,
										USERNAME
				from V$SESSION
			where sid=(select sys_context('USERENV','SID') from dual);
reSESSION			cuSESSION%rowtype;



procedure proUpdateMessageError(inuCodi         IN LDCI_mesaenvws.mesacodi%type,
                                 boolHttpError  IN BOOLEAN,
                                 boolSoapError  IN BOOLEAN,
                                 isbHttpError   IN LDCI_mesaenvws.mesahttperror%TYPE,
                                 isbSoapError   IN LDCI_mesaenvws.mesasoaperror%type,
                                 inuEstado      IN LDCI_mesaenvws.mesaestado%type) AS



nuIsHttpError number;
nuIsSoapError number;

BEGIN


       IF boolHttpError then
          nuIsHttpError:=1;
       ELSE
          nuIsHttpError:=0;
       END IF;

       IF boolSoapError then
          nuIsSoapError:=1;
       ELSE
          nuIsSoapError:=0;
       END IF;

                 UPDATE LDCI_mesaenvws SET LDCI_mesaenvws.mesaestado      = inuEstado,
                                          LDCI_mesaenvws.mesahttperror   = isbHttpError,
                                          LDCI_mesaenvws.mesaintentos    = nvl(LDCI_mesaenvws.mesaintentos,0)+1,
                                          LDCI_mesaenvws.mesasoaperror   = isbSoapError,
                                          LDCI_mesaenvws.mesaishttperror = nuIsHttpError,
                                          LDCI_mesaenvws.mesaissoaperror = nuIsSoapError
                WHERE LDCI_mesaenvws.mesacodi=inuCodi;
                COMMIT;

EXCEPTION
  WHEN OTHERS THEN
  LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| Sqlerrm || Dbms_Utility.Format_Error_Backtrace, null, null);
END proUpdateMessageError;



/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : proSenderMessage.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft/Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Reenvia Mensajes pendientes.
 *
 * Parametros
 * isbProtocol in  VARCHAR2,
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del paquete
**/

PROCEDURE proSenderMessage AS

CURSOR cuMessageSend(intentos NUMBER) is
       SELECT *
       FROM LDCI_mesaenvws
       WHERE (mesaishttperror = 1 OR mesaissoaperror=1)   AND
             mesaestado=-1 AND mesaintentos<=intentos;

      regMessageSend          cuMessageSend%ROWTYPE;
      sbResponse              CLOB;
      sbTargetFull            LDCI_carasewe.casevalo%type;
      SBNAMESPACE             LDCI_carasewe.casevalo%type;
      SBWSURL                 LDCI_carasewe.casevalo%type;
      SBHOST                  LDCI_carasewe.casevalo%type;
      SBSOAPACTION            LDCI_carasewe.casevalo%type;
      SBPUERTO                LDCI_carasewe.casevalo%type;
      SBPROTOCOLO             LDCI_carasewe.casevalo%type;
      SBPAYLOAD               LDCI_carasewe.casevalo%type;
      SBMENS                  LDCI_carasewe.casevalo%type;
      nuEstado                NUMBER;
      nuIntentos              NUMBER;


BEGIN
LDCI_pkWebServUtils.proCaraServWeb('WS_CONFIG_SOAPAPI','WS_CONFIG_SENDMESSA_HITS',nuIntentos,sbMens);
  FOR regMessageSend IN cuMessageSend(nuIntentos)
        LOOP
          LDCI_pkWebServUtils.proCaraServWeb(regMessageSend.MESADEFI,'NAMESPACE',sbNameSpace,sbMens);
          LDCI_pkWebServUtils.proCaraServWeb(regMessageSend.MESADEFI,'PROTOCOLO',sbProtocolo,sbMens);
          LDCI_pkWebServUtils.proCaraServWeb(regMessageSend.MESADEFI,'WSURL',sbWSURL,sbMens);
          LDCI_pkWebServUtils.proCaraServWeb(regMessageSend.MESADEFI,'HOST',sbHost,sbMens);
          LDCI_pkWebServUtils.proCaraServWeb(regMessageSend.MESADEFI,'SOAPACTION',sbSoapAction,sbMens);
          LDCI_pkWebServUtils.proCaraServWeb(regMessageSend.MESADEFI,'PUERTO',sbPuerto,sbMens);


          sbTargetFull        := lower(sbProtocolo)||'://'||sbHost||':'||sbPuerto||'/'||sbWSURL;
          LDCI_pksoapapi.proSetProtocol(lower(sbProtocolo));
          sbResponse := LDCI_pksoapapi.fsbSoapSegmentedCall(regMessageSend.mesaxmlpayload, sbTargetFull, sbSoapAction,sbNameSpace);

          IF LDCI_pksoapapi.boolSoapError OR LDCI_pksoapapi.boolHttpError THEN
              nuEstado:=-1;
              --dbms_output.put_line('Error invocando servicio '||sbTargetFull);
                        LDCI_PKMESAWS.proUpdateMessageError( regMessageSend.mesacodi,
                                                            LDCI_pksoapapi.boolHttpError,
                                                            LDCI_pksoapapi.boolSoapError,
                                                            LDCI_pksoapapi.sbErrorHttp,
                                                            sbResponse,
                                                            nuEstado);
          ELSE
              nuEstado:=1;
              --dbms_output.put_line('Error invocando servicio '||sbTargetFull);
                        LDCI_PKMESAWS.proUpdateMessageError( regMessageSend.mesacodi,
                                                            LDCI_pksoapapi.boolHttpError,
                                                            LDCI_pksoapapi.boolSoapError,
                                                            regMessageSend.mesahttperror,
                                                            sbResponse,
                                                            nuEstado);

          END IF;




          COMMIT;
   END LOOP;

EXCEPTION
  WHEN OTHERS THEN
  LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| Sqlerrm || Dbms_Utility.Format_Error_Backtrace, null, null);
END proSenderMessage;
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : proCreateMessageError.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft/Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Almacena errores en el log para su posterior reenvio.
 *
 * Parametros
 * isbProtocol in  VARCHAR2,
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del paquete
**/

  PROCEDURE proCreateMessageError(isbXmlEnv        IN LDCI_mesaenvws.mesaxmlenv%type,
                                  isbWebService    IN LDCI_mesaenvws.MESADEFI%type,
                                  isbHttpError     IN LDCI_mesaenvws.mesahttperror%type,
                                  isbSoapPayload   IN LDCI_mesaenvws.MESAXMLPAYLOAD%type,
                                  isbSoapError     IN LDCI_mesaenvws.mesasoaperror%type,
                                  isbTraceError    IN LDCI_mesaenvws.mesatraceerror%type,
                                  boolHttpError    IN BOOLEAN,
                                  boolSoapError    IN BOOLEAN) AS


  nuReportHttpError NUMBER;
  nuReportSoapError NUMBER;

  BEGIN

  IF boolHttpError THEN
   nuReportHttpError:=1;
  ELSE
    nuReportHttpError:=0;
  END IF;

  IF boolSoapError THEN
   nuReportSoapError:=1;
  ELSE
  nuReportSoapError:=0;
  END IF;


  INSERT INTO LDCI_mesaenvws  (mesacodi,
                              mesafech,
                              mesaXmlEnv,
                              MESADEFI,
                              mesaHttpError,
                              mesaSoapError,
                              mesaTraceError,
                              mesaEstado,
                              mesaIntentos,
                              mesaIsHttpError,
                              mesaIsSoapError,
                              Mesaxmlpayload)
                      VALUES (LDCI_SEQMESAWS.NEXTVAL,
                              sysdate,
                              isbXmlEnv,
                              isbWebService,
                              isbHttpError,
                              isbSoapError,
                              isbTraceError,
                              -1,
                              1,
                              nuReportHttpError,
                              nuReportSoapError,
                              isbSoapPayload);
  COMMIT;
 EXCEPTION
  WHEN OTHERS THEN
  LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| Sqlerrm || Dbms_Utility.Format_Error_Backtrace, null, null);
  END proCreateMessageError;


  /*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : proUpdateFullMessageError.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft/Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Actualiza un mensaje con todos sus atributos.
 *
 * Parametros
 * isbProtocol in  VARCHAR2,
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del paquete
**/

  PROCEDURE proUpdateFullMessageError(
                                  inuCodi          IN LDCI_mesaenvws.mesacodi%type,
                                  isbXmlEnv        IN LDCI_mesaenvws.mesaxmlenv%type,
                                  isbWebService    IN LDCI_mesaenvws.MESADEFI%type,
                                  isbHttpError     IN LDCI_mesaenvws.mesahttperror%type,
                                  isbSoapPayload   IN LDCI_mesaenvws.MESAXMLPAYLOAD%type,
                                  isbSoapError     IN LDCI_mesaenvws.mesasoaperror%type,
                                  isbTraceError    IN LDCI_mesaenvws.mesatraceerror%type,
                                  boolHttpError    IN BOOLEAN,
                                  boolSoapError    IN BOOLEAN,
                                  dtFechaFin       IN LDCI_mesaenvws.mesafechafin%type) AS


  nuReportHttpError NUMBER;
  nuReportSoapError NUMBER;
  nuEstado          NUMBER:=1;

  BEGIN

  IF boolHttpError THEN
   nuReportHttpError:=1;
   nuEstado:=-1;
  ELSE
    nuReportHttpError:=0;
  END IF;

  IF boolSoapError THEN
   nuReportSoapError:=1;
   nuEstado:=-1;
  ELSE
  nuReportSoapError:=0;
  END IF;

  UPDATE LDCI_mesaenvws SET mesaXmlEnv     = isbXmlEnv,
                           mesaHttpError  = isbHttpError,
                           mesaSoapError  =isbSoapError ,
                           mesaTraceError = isbTraceError,
                           mesaIsHttpError = nuReportHttpError,
                           mesaIsSoapError = nuReportSoapError,
                           mesaFechaFin    = dtFechaFin,
                           mesaxmlpayload  = isbSoapPayload,
                           mesaintentos = mesaintentos+1,
                           mesaestado   = nuEstado

  WHERE  mesacodi=inuCodi;

  COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
  LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| Sqlerrm || Dbms_Utility.Format_Error_Backtrace, null, null);
  END proUpdateFullMessageError;



  /*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : proCreateInitMessage.prc
 * Tiquete : 143105
 * Autor   : Arquitecsoft/Hector Fabio Dominguez
 * Fecha   : 18/05/2011
 * Descripcion : Inicia el registro del mensaje para determinar el tiempo que se
                 en crear el paquete a enviar
 *
 * Parametros
 * isbProtocol in  VARCHAR2,
 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * Hector Dominguez   18/05/2011    Creacion del paquete
**/

  PROCEDURE proCreateInitMessage (inuCodi        IN LDCI_mesaenvws.mesacodi%type,
                                  isbWebService    IN LDCI_mesaenvws.MESADEFI%type,
                                  inuEstado      IN LDCI_mesaenvws.mesaestado%type) AS


  nuReportHttpError NUMBER;
  nuReportSoapError NUMBER;

  BEGIN


  INSERT INTO LDCI_mesaenvws  (mesacodi,
                              mesafech,
                              mesafechaini,
                              mesaEstado,
                              mesaIntentos,
                              MESADEFI)
                      VALUES (inuCodi,
                              sysdate,
                              sysdate,
                              -1,
                              0,
                              isbWebService);
  COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
  LDCI_pkWebServUtils.Procrearerrorlogint('ENVIO DE INTERFAZ', 1, 'Error procesando interfaz: '|| Sqlerrm || Dbms_Utility.Format_Error_Backtrace, null, null);
  END proCreateInitMessage;

procedure proCreaEstaProc(isbPROCDEFI     in LDCI_ESTAPROC.PROCDEFI%type,
																									icbPROCPARA      in LDCI_ESTAPROC.PROCPARA%type,
																									idtPROCFEIN      in LDCI_ESTAPROC.PROCFEIN%type,
                         isbPROCESTA      in LDCI_ESTAPROC.PROCESTA	%type,
																									isbPROCUSUA      in LDCI_ESTAPROC.PROCUSUA%type,
																									isbPROCTERM      in LDCI_ESTAPROC.PROCTERM%type,
																									isbPROCPROG      in LDCI_ESTAPROC.PROCPROG%type,
																									onuPROCCODI     out LDCI_ESTAPROC.PROCCODI%type,
																									onuErrorCode    out NUMBER,
																									osbErrorMessage out VARCHAR2) as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKMESAWS.proCreaEstaProc
 * Tiquete : Acta: 20130417 Acta reunion ModificaciÃ³n-Caja-GRIS.docx
 * Autor   : OLSoftware / Carlos E. Virgen LondoÃ±o
 * Fecha   : 17/04/2013
 * Descripcion : Procedimiento que hace la creaciÃ³n de un registro de estado.
	* Parametros:
					IN: isbPROCDEFI: CÃ³digo de la interfaz
					IN: icbPROCPARA: XML de Parametros con el estandar
																				<?xml version="1.0" encoding="UTF-8"?>
																				<PARAMETROS>
																								<PARAMETRO>
																												<NOMBRE>ESTADO</NOMBRE>
																												<VALOR>X</VALOR>
																								</PARAMETRO>
																								<PARAMETRO>
																												<NOMBRE>CODIGO</NOMBRE>
																												<VALOR>1</VALOR>
																								</PARAMETRO>
																				</PARAMETROS>

					IN: idtPROCFEIN: Fecha de inicio
					IN: isbPROCUSUA: Nombre de usuario [select UT_SESSION.GETMACHINE from dual;]
					IN: isbPROCTERM: Nombre de la terminal [select UT_SESSION.GETUSER from dual;]
					IN: isbPROCPROG: Nombre del programama [select UT_SESSION.GETPROGRAM from dual;]
					OUT:onuPROCCODI: CÃ³digo del proceso
					OUT:onuErrorCode: CÃ³digo de error
					OUT:osbErrorMessage: Mensaje de excepciÃ³n

					* Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * carlosvl           17/04/2013    Creacion del paquete
**/
 PRAGMA AUTONOMOUS_TRANSACTION;
 -- definicion de cursores
	-- cursor de los cargos
	cursor cuPROCPARA(clXML in CLOB) is
					SELECT PARAMETROS.*
						FROM XMLTable('PARAMETROS/PARAMETRO' PASSING XMLType(clXML)
																					COLUMNS
																					"NOMBRE"       VARCHAR2(3000) PATH 'NOMBRE',
																					"VALOR"        VARCHAR2(3000) PATH 'VALOR') AS PARAMETROS;
 rePROCPARA cuPROCPARA%rowtype;
 -- excepciones
 EXCEP_XML_CHECK exception; -- menejo de excepciones XML
begin
 -- inicializa mensaje de salida
	onuErrorCode := 0;
 -- valida los parametros del proceso
	open cuPROCPARA(upper(icbPROCPARA));
	fetch cuPROCPARA into rePROCPARA;
	if (cuPROCPARA%notfound) then
				raise EXCEP_XML_CHECK;
	end if; -- if (cuPROCPARA%notfound) then
	close cuPROCPARA;

	open cuSESSION;
	fetch cuSESSION into reSESSION;
	close cuSESSION;

 -- genera el consecutivo
	select SEQ_LDCI_MESAPROC.nextval into onuPROCCODI from dual;

 -- realia la inserciÃ³n en la tabla LDCI_ESTAPROC
	insert into LDCI_ESTAPROC (PROCCODI,
	                          PROCDEFI,
																											PROCPARA,
																											PROCFEIN,
																											PROCUSUA,
																											PROCTERM,
																											PROCPROG,
																											PROCESTA)
	                   values (onuPROCCODI,
																				       isbPROCDEFI,
																											upper(icbPROCPARA),
																											idtPROCFEIN,
																											nvl(isbPROCUSUA,reSESSION.OSUSER),
																											nvl(isbPROCTERM,reSESSION.MACHINE),
																											nvl(isbPROCPROG,reSESSION.PROGRAM),
																											nvl(isbPROCESTA,'R'));
		commit;

exception
	when EXCEP_XML_CHECK then
			rollback;
			onuErrorCode := -1;
			osbErrorMessage := '[LDCI_PKMESAWS.proCreaEstaProc.EXCEP_XML_CHECK]: ' || chr(13) ||
																						'El campo de PARÃ?METROS debe contener registros. ';
			LDCI_pkWebServUtils.Procrearerrorlogint('ESTAPROC', 1,osbErrorMessage, null, null);
	when others then
			rollback;
   onuErrorCode:= -1;
			osbErrorMessage:= '[LDCI_PKMESAWS.proGetMensProc] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
   LDCI_pkWebServUtils.Procrearerrorlogint('ESTAPROC ',1,osbErrorMessage, null, null);
end proCreaEstaProc;

procedure proActuEstaProc(inuPROCCODI      in LDCI_ESTAPROC.PROCCODI%type,
												             idtPROCFEFI      in LDCI_ESTAPROC.PROCFEFI%type,
																									isbPROCESTA      in LDCI_ESTAPROC.PROCESTA	%type,
																									onuErrorCode    out NUMBER,
																									osbErrorMessage out VARCHAR2) as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKMESAWS.proActuEstaProc
 * Tiquete : Acta: 20130417 Acta reunion ModificaciÃ³n-Caja-GRIS.docx
 * Autor   : OLSoftware / Carlos E. Virgen LondoÃ±o
 * Fecha   : 17/04/2013
 * Descripcion : procedimeinto que actualiza el registro de proceso.
	* Parametros:
	IN :inuPROCCODI: CÃ³digo del proceso
	IN: idtPROCFEFI: Fecha final de procesamiento
	IN: isbPROCESTA: Estado del proceso [R=Registrado, P=procesando, F=Finalizado.]
	OUT:onuErrorCode: CÃ³digo de error
	OUT:osbErrorMessage: Mensaje de excepciÃ³n

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * carlosvl           17/04/2013    Creacion del paquete
**/
 PRAGMA AUTONOMOUS_TRANSACTION;
 -- excepciones
 EXCEP_UPDATE_CHECK exception; -- menejo de excepciones XML
begin
 -- inicializa mensaje de salida
	onuErrorCode := 0;
 -- realia la inserciÃ³n en la tabla LDCI_ESTAPROC
	update LDCI_ESTAPROC set PROCFEFI = idtPROCFEFI,
	                        PROCESTA = isbPROCESTA
	  where PROCCODI = inuPROCCODI;
	if (SQL%notfound)		then
				raise EXCEP_UPDATE_CHECK;
	end if;--if (SQL%notfound)		then
 commit;
exception
	when EXCEP_UPDATE_CHECK then
			rollback;
			onuErrorCode := -1;
			osbErrorMessage := '[LDCI_PKMESAWS.proActuEstaProc.EXCEP_UPDATE_CHECK]: ' || chr(13) ||
																						'No se encontrÃ³ el proceso de cÃ³digo ' || inuPROCCODI ||'.';
			LDCI_pkWebServUtils.Procrearerrorlogint('ESTAPROC',1,osbErrorMessage, null, null);
	when others then
			rollback;
   onuErrorCode:= -1;
			osbErrorMessage:= '[LDCI_PKMESAWS.proGetMensProc] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
			LDCI_pkWebServUtils.Procrearerrorlogint('ESTAPROC',1,osbErrorMessage, null, null);
end proActuEstaProc;

procedure proCreaMensEnvio(idtMESAFECH       in LDCI_MESAENVWS.MESAFECH%type,
																										isbMESADEFI       in LDCI_MESAENVWS.MESADEFI%type,
																										inuMESAESTADO     in LDCI_MESAENVWS.MESAESTADO%type,
																										inuMESAPROC       in LDCI_MESAENVWS.MESAPROC%type,
																										icbMESAXMLENV     in LDCI_MESAENVWS.MESAXMLENV%type,
																										icdMESAXMLPAYLOAD in LDCI_MESAENVWS.MESAXMLPAYLOAD%type,
																										inuMESATAMLOT     in LDCI_MESAENVWS.MESATAMLOT%type,
																										inuMESALOTACT     in LDCI_MESAENVWS.MESALOTACT%type,
                          onuMESACODI      out LDCI_MESAENVWS.MESACODI%type,
																				 					onuErrorCode     out NUMBER,
																					 				osbErrorMessage  out VARCHAR2) as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKMESAWS.proCreaMensEnvio
 * Tiquete : Acta: 20130417 Acta reunion ModificaciÃ³n-Caja-GRIS.docx
 * Autor   : OLSoftware / Carlos E. Virgen LondoÃ±o
 * Fecha   : 17/04/2013
 * Descripcion : Procedimeinto que crea el registro en la tabla LDCI_MESAENVWS
	* Parametros:
	IN :idtMESAFECH: Fecha de creacion del registro
	IN: isbMESADEFI: Definicion del servicio Web
	IN: inuMESAESTADO: Estado del proceso [Estado del mensaje, 1 = enviado -1= pendiente]
	IN: inuMESAPROC: CÃ³digo del proceso asociado
	IN: icbMESAXMLENV: XML de confirmaciÃ³n
	IN: icdMESAXMLPAYLOAD: XML 	con los datos de interfaz
	IN: inuMESATAMLOT: Cantidad de mensajes que componen la interfaz.
	IN: inuMESALOTACT: Es el nÃºmero de paquete o lote actual tiene este registro.
	OUT: onuMESACODI: CÃ³digo del mensaje retronado
	OUT:onuErrorCode: CÃ³digo de error
	OUT:osbErrorMessage: Mensaje de excepciÃ³n

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * carlosvl           17/04/2013    Creacion del paquete
**/
PRAGMA AUTONOMOUS_TRANSACTION;
begin
 -- cre el  mensaje de envio XML
	onuMESACODI := LDCI_SEQMESAWS.nextval;

 -- inserta el registro del mensaje XML
	insert into LDCI_MESAENVWS(MESACODI,
																											MESAFECH,
																											MESADEFI,
																											MESAESTADO,
																											MESAPROC,
																											MESAXMLENV,
																											MESAXMLPAYLOAD,
																											MESATAMLOT,
																											MESALOTACT)
																											values
																											(onuMESACODI,
																											nvl(idtMESAFECH,sysdate),
																											isbMESADEFI,
																											nvl(inuMESAESTADO,-1),
																											inuMESAPROC,
																											icbMESAXMLENV,
																											icdMESAXMLPAYLOAD,
																											inuMESATAMLOT,
																											inuMESALOTACT);
 commit;

exception
	when others then
			rollback;
   onuErrorCode:= -1;
			osbErrorMessage:= '[LDCI_PKMESAWS.proGetMensProc] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
   LDCI_pkWebServUtils.Procrearerrorlogint('ESTAPROC', 1, osbErrorMessage, null, null);
end proCreaMensEnvio;

procedure proActuMensEnvio(inuMESACODI       in LDCI_MESAENVWS.MESACODI%type,
																										inuMESAESTADO     in LDCI_MESAENVWS.MESAESTADO%type,
																										icbMESAXMLENV     in LDCI_MESAENVWS.MESAXMLENV%type,
																										icdMESAXMLPAYLOAD in LDCI_MESAENVWS.MESAXMLPAYLOAD%type,
																										inuMESATAMLOT     in LDCI_MESAENVWS.MESATAMLOT%type,
																										inuMESALOTACT     in LDCI_MESAENVWS.MESALOTACT%type,
																										idtMESAFECHAINI   in LDCI_MESAENVWS.MESAFECHAINI%type,
																										idtMESAFECHAFIN   in LDCI_MESAENVWS.MESAFECHAFIN%type,
																										onuErrorCode     out NUMBER,
																										osbErrorMessage  out VARCHAR2) as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKMESAWS.proActuMensEnvio
 * Tiquete : Acta: 20130417 Acta reunion ModificaciÃ³n-Caja-GRIS.docx
 * Autor   : OLSoftware / Carlos E. Virgen LondoÃ±o
 * Fecha   : 17/04/2013
 * Descripcion : Procedimeinto que crea el registro en la tabla LDCI_MESAENVWS
	* Parametros:
	IN :idtMESAFECH: Fecha de creacion del registro
	IN: isbMESADEFI: Definicion del servicio Web
	IN: inuMESAESTADO: Estado del proceso [Estado del mensaje, 1 = enviado -1= pendiente]
	IN: inuMESAPROC: CÃ³digo del proceso asociado
	IN: icbMESAXMLENV: XML de confirmaciÃ³n
	IN: icdMESAXMLPAYLOAD: XML 	con los datos de interfaz
	IN: inuMESATAMLOT: Cantidad de mensajes que componen la interfaz.
	IN: inuMESALOTACT: Es el nÃºmero de paquete o lote actual tiene este registro.
	OUT: onuMESACODI: CÃ³digo del mensaje retronado
	OUT:onuErrorCode: CÃ³digo de error
	OUT:osbErrorMessage: Mensaje de excepciÃ³n

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * carlosvl           17/04/2013    Creacion del paquete
**/
 PRAGMA AUTONOMOUS_TRANSACTION;
 EXCEP_UPDATE_CHECK exception; -- menejo de excepciones XML
begin

 -- inserta el registro del mensaje XML
	update LDCI_MESAENVWS set MESAESTADO     = inuMESAESTADO,
																									 MESAXMLENV     = icbMESAXMLENV,
																										MESAXMLPAYLOAD = icdMESAXMLPAYLOAD,
																										MESATAMLOT     = inuMESATAMLOT,
																										MESALOTACT     = inuMESALOTACT,
																										MESAFECHAINI   = idtMESAFECHAINI,
																										MESAFECHAFIN   = idtMESAFECHAFIN
  where MESACODI = inuMESACODI;
	-- valida el procesamiento del UPDATE
	if (SQL%notfound)		then
				raise EXCEP_UPDATE_CHECK;
	end if;--if (SQL%notfound)		then
	commit;
exception
	when EXCEP_UPDATE_CHECK then
			rollback;
			onuErrorCode := -1;
			osbErrorMessage := '[LDCI_PKMESAWS.proActuMensEnvio.EXCEP_UPDATE_CHECK]: ' || chr(13) ||
																						'No se encontrÃ³ el proceso de cÃ³digo ' || inuMESACODI ||'.';
   LDCI_pkWebServUtils.Procrearerrorlogint('ESTAPROC', 1, osbErrorMessage, null, null);
	when others then
			rollback;
   onuErrorCode:= -1;
			osbErrorMessage:= '[LDCI_PKMESAWS.proGetMensProc] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
   LDCI_pkWebServUtils.Procrearerrorlogint('ESTAPROC', 1,osbErrorMessage, null, null);
end proActuMensEnvio;

procedure proCreaMensProc(inuMESAPROC       in LDCI_MESAPROC.MESAPROC%type,
																							  isbMESADESC       in LDCI_MESAPROC.MESADESC%type,
																									isbMESATIPO       in LDCI_MESAPROC.MESATIPO%type,
																									idtMESAFECH       in LDCI_MESAPROC.MESAFECH%type,
																									onuMESACODI      out LDCI_MESAPROC.MESACODI%type,
																				 				onuErrorCode     out NUMBER,
																					 			osbErrorMessage  out VARCHAR2) as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKMESAWS.proCreaMensProc
 * Tiquete : Acta: 20130417 Acta reunion ModificaciÃ³n-Caja-GRIS.docx
 * Autor   : OLSoftware / Carlos E. Virgen LondoÃ±o
 * Fecha   : 17/04/2013
 * Descripcion : Procedimeinto que crea el registro en la tabla LDCI_MESAENVWS
	* Parametros:
	IN :inuMESAPROC: ForÃ¡nea de LDCI_ESTAPROC, para identificar el proceso al que pertenece
	IN :isbMESADESC: descripciÃ³n del mensaje
	IN :isbMESATIPO: E error, I InformaciÃ³n, W Advertencia
	IN :idtMESAFECH: Fecha en que se registra el mensaje
	OUT: onuMESACODI: CÃ³digo del mensaje retronado
	OUT:onuErrorCode: CÃ³digo de error
	OUT:osbErrorMessage: Mensaje de excepciÃ³n

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * carlosvl           17/04/2013    Creacion del paquete
**/
PRAGMA AUTONOMOUS_TRANSACTION;
begin
 -- cre el  mensaje de envio XML
	onuMESACODI := SEQ_LDCI_ESTAPROC.nextval;

 -- inserta el registro del mensaje XML
	insert into LDCI_MESAPROC(MESACODI,
																										MESADESC,
																										MESAPROC,
																										MESATIPO,
																										MESAFECH)
																										values
																									(onuMESACODI,
																										isbMESADESC,
																										inuMESAPROC,
																										isbMESATIPO,
																										idtMESAFECH);
 commit;

exception
	when others then
			rollback;
   onuErrorCode:= -1;
			osbErrorMessage:= '[LDCI_PKMESAWS.proCreaMensProc] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
   LDCI_pkWebServUtils.Procrearerrorlogint('ESTAPROC', 1, osbErrorMessage, null, null);
end proCreaMensProc;

procedure proCreaMensajeProc(inuMESAPROC        in LDCI_MESAPROC.MESAPROC%type,
																								    	isbMESATIPO        in LDCI_MESAPROC.MESATIPO%type,
																													inuERROR_LOG_ID    in LDCI_MESAPROC.ERROR_LOG_ID%type,
																							      isbMESADESC        in LDCI_MESAPROC.MESADESC%type,
																													isbMESAVAL1        in LDCI_MESAPROC.MESAVAL1%type,
																													isbMESAVAL2        in LDCI_MESAPROC.MESAVAL2%type,
																													isbMESAVAL3        in LDCI_MESAPROC.MESAVAL3%type,
																													isbMESAVAL4								in LDCI_MESAPROC.MESAVAL3%type,
																								    	idtMESAFECH        in LDCI_MESAPROC.MESAFECH%type,
																								    	onuMESACODI       out LDCI_MESAPROC.MESACODI%type,
																				 			    	onuErrorCode      out NUMBER,
																					 			    osbErrorMessage   out VARCHAR2)		 as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKMESAWS.proCreaMensajeProc
 * Tiquete : Acta: 20130417 Acta reunion ModificaciÃ³n-Caja-GRIS.docx
 * Autor   : OLSoftware / Carlos E. Virgen LondoÃ±o
 * Fecha   : 17/04/2013
 * Descripcion : Procedimeinto que crea el registro en la tabla LDCI_MESAENVWS
	* Parametros:
	IN :inuMESAPROC: ForÃ¡nea de LDCI_ESTAPROC, para identificar el proceso al que pertenece
	IN :isbMESADESC: descripciÃ³n del mensaje
	IN :isbMESATIPO: E error, I InformaciÃ³n, W Advertencia
	IN :idtMESAFECH: Fecha en que se registra el mensaje
	OUT: onuMESACODI: CÃ³digo del mensaje retronado
	OUT:onuErrorCode: CÃ³digo de error
	OUT:osbErrorMessage: Mensaje de excepciÃ³n

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * carlosvl           17/04/2013    Creacion del paquete
**/
PRAGMA AUTONOMOUS_TRANSACTION;
begin
 -- cre el  mensaje de envio XML
	onuMESACODI := SEQ_LDCI_ESTAPROC.nextval;

 -- inserta el registro del mensaje XML
	insert into LDCI_MESAPROC(MESACODI,
																									 	MESAPROC,
																											ERROR_LOG_ID,
																									 	MESADESC,
																											MESAVAL1,
																											MESAVAL2,
																											MESAVAL3,
																											MESAVAL4,
																									 	MESATIPO,
																									 	MESAFECH)
																										 values
																									 (onuMESACODI,
																										 inuMESAPROC,
																											inuERROR_LOG_ID,
																										 isbMESADESC,
																											isbMESAVAL1,
																											isbMESAVAL2,
																											isbMESAVAL3,
																											isbMESAVAL4,
																										 isbMESATIPO,
																										 idtMESAFECH);
 commit;

exception
	when others then
			rollback;
   onuErrorCode:= -1;
			osbErrorMessage:= '[LDCI_PKMESAWS.proCreaMensajeProc] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
   LDCI_pkWebServUtils.Procrearerrorlogint('ESTAPROC', 1, osbErrorMessage, null, null);
end proCreaMensajeProc;


procedure proGetMensProc(inuPROCCODI      in LDCI_ESTAPROC.PROCCODI%type,
																								orfMensProc     out LDCI_PKMESAWS.tyRefcursor,
																								onuErrorCode    out NUMBER,
																								osbErrorMessage out VARCHAR2) as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKMESAWS.proGetMensProc
 * Tiquete : Acta: 20130417 Acta reunion ModificaciÃ³n-Caja-GRIS.docx
 * Autor   : OLSoftware / Carlos E. Virgen LondoÃ±o
 * Fecha   : 26/06/2013
 * Descripcion : Procedimiento que retorna los mensajes generados para un proceso determindado
	* Parametros:
	IN :inuPROCCODI: ForÃ¡nea de LDCI_ESTAPROC, para identificar el proceso al que pertenece
	OUT: orfMensProc: Cursor con la informaicÃ³n de los mensajes de salida
	OUT:onuErrorCode: CÃ³digo de error
	OUT:osbErrorMessage: Mensaje de excepciÃ³n

 * Historia de Modificaciones
 * Autor              Fecha         Descripcion
 * carlosvl           17/04/2013    Creacion del paquete
**/
begin
	-- carga la pila de mensajes para un proceso detemrindado
	open orfMensProc for
		select MESAPROC,
		      MESACODI,
        MESADESC,
        MESATIPO
    from LDCI_MESAPROC
   where 	MESAPROC = inuPROCCODI;
exception
	when others then
			rollback;
   onuErrorCode:= -1;
			osbErrorMessage:= '[LDCI_PKMESAWS.proGetMensProc] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
   LDCI_pkWebServUtils.Procrearerrorlogint('ESTAPROC', 1, osbErrorMessage, null, null);
end proGetMensProc;

END LDCI_PKMESAWS;
/
PROMPT Asignación de permisos para el método LDCI_PKMESAWS
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKMESAWS', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKMESAWS to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKMESAWS to INTEGRADESA;
/
