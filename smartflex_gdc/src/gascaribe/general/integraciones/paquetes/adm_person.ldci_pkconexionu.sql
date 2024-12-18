CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKCONEXIONU AS
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     PAQUETE       : LDCI_PKCONEXIONU
     AUTOR         : OLSoftware / Carlos Virgen <carlos.virgen@olsoftware.com>
     FECHA         : 02/09/2014
     RICEF : #GC_CEV_4298_1
     DESCRIPCION: Paquete que permite encapsula las operaciones de consulta de suscruptores

    Historia de Modificaciones
    Autor   Fecha      Descripcion
  */

  -- consulta la informacion de suscriptor
  PROCEDURE proConsultaSuscriptor(inuSERVCODI         in NUMBER,
                                 inuSubscriptionId   in NUMBER,
                                 isbIdentification   in VARCHAR2,
                                 isbPhoneNumber      in VARCHAR2,
                                 orfSubscriptionData OUT LDCI_PKREPODATATYPE.tyRefcursor,
                                 onuErrorCode        OUT NUMBER,
                                 osbErrorMessage     OUT VARCHAR2);

END LDCI_PKCONEXIONU;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKCONEXIONU AS

  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     PAQUETE       : LDCI_PKCONEXIONU
     AUTOR         : OLSoftware / Mauricio Ortiz
     FECHA         : 02/09/2014
     RICEF : #GC_CEV_4298_1
     DESCRIPCION: Paquete que permite encapsula las operaciones de consulta de suscruptores

    Historia de Modificaciones
    Autor   Fecha      Descripcion
  */
  PROCEDURE proConsultaSuscriptor(inuSERVCODI         in NUMBER,
                                 inuSubscriptionId   in NUMBER,
                                 isbIdentification   in VARCHAR2,
                                 isbPhoneNumber      in VARCHAR2,
                                 orfSubscriptionData OUT LDCI_PKREPODATATYPE.tyRefcursor,
                                 onuErrorCode        OUT NUMBER,
                                 osbErrorMessage     OUT VARCHAR2) AS
    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       PAQUETE       : LDCI_PKCONEXIONU.proConsultaSuscriptor
       AUTOR         : OLSoftware / Carlos E. Virgen
       FECHA         : 19/03/2013
       RICEF : I020,I038,I039,I040
       DESCRIPCION: Paquete que permite encapsula las operaciones de consulta de suscruptores

      Historia de Modificaciones
      Autor   Fecha      Descripcion

    */
    -- variables
    nuSERVCODI       SERVICIO.SERVCODI%type;
    nuSUSCCODI       SUSCRIPC.SUSCCODI%type;
    sbIDENTIFICATION GE_SUBSCRIBER.IDENTIFICATION%type;
    sbPHONE          GE_SUBSCRIBER.PHONE%type;
    reContractData   LDCI_PKREPODATATYPE.tyContractDataRecord;

    excep_Sin_Codigo_Servicio    exception;
    excep_Sin_Parametros_Entrada exception;
    excep_No_Encontro_Registro   exception;
  BEGIN
    -- valida los parametros de entrada
    nuSERVCODI       := nvl(inuSERVCODI, 7014);
    nuSUSCCODI       := nvl(inuSubscriptionId, -1);
    sbIDENTIFICATION := nvl(isbIdentification, '-1');
    sbPHONE          := nvl(isbPhoneNumber, '-1');

    -- valida que se haya ingresado los parametros de busqueda
    if ((inuSubscriptionId is null or inuSubscriptionId = -1) and
       (isbIdentification is null or isbIdentification = '-1') and
       (isbPhoneNumber is null or isbPhoneNumber = '-1')) then
      raise excep_Sin_Parametros_Entrada;
    end if; --If (inuSubscriptionId is null or inuSubscriptionId = -1) .. Then

    -- carga el cusor referenciado
    if (inuSubscriptionId is not null or isbIdentification is not null) THEN

      open orfSubscriptionData for
        select Cont.SUSCCODI CONTRATO,
               SeSu.SESUNUSE NRO_SERVICIO,
               SeSu.SESUSERV CODIGO_SERVICIO,
               Serv.SERVDESC SERVICIO_DESC,
               Cont.SUSCCLIE CODIGO_CLIENTE,
               Clie.SUBSCRIBER_NAME || ' ' || Clie.SUBS_LAST_NAME CLIENTE,
               Pred.ADDRESS_ID CODIGO_DIRECCION_COBRO,
               Pred.ADDRESS DIRECCION_COBRO,
               DepLocPred.GEOGRAP_LOCATION_ID CODIGO_DEPTO,
               DepLocPred.DISPLAY_DESCRIPTION DEPTO_DIRECCION_COBRO,
               LocPred.GEOGRAP_LOCATION_ID CODIGO_LOCALIDAD,
               LocPred.DISPLAY_DESCRIPTION LOCALIDAD_DIRECCION_COBRO,
               Cate.CATECODI CODIGO_CATEGORIA,
               Cate.CATEDESC CATEGORIA,
               SuCa.SUCACODI CODIGO_SUBCATEGORIA,
               SuCa.SUCADESC SUBCATEGORIA,
			   Clie.PHONE TELEFONO,
			   SeSu.SESUESFN ESTADO_FINANCIERO,
			   Prod.PRODUCT_STATUS_ID ESTADO_TECNICO
          from SUSCRIPC           Cont,
               SERVSUSC           SeSu,
               SERVICIO           Serv,
               GE_SUBSCRIBER      Clie,
               PR_PRODUCT         Prod,
               AB_ADDRESS         Dire,
               AB_ADDRESS         Pred,
               CATEGORI           Cate,
               SUBCATEG           SuCa,
               GE_GEOGRA_LOCATION LocDire,
               GE_GEOGRA_LOCATION LocPred,
               GE_GEOGRA_LOCATION DepLocDire,
               GE_GEOGRA_LOCATION DepLocPred
         where SeSu.SESUSUSC = Cont.SUSCCODI
           and Serv.SERVCODI = SeSu.SESUSERV
           and Serv.SERVCODI = decode(nuSERVCODI, -1, Serv.SERVCODI, nuSERVCODI)
           and Cont.SUSCCODI = decode(nuSUSCCODI, -1, Cont.SUSCCODI, nuSUSCCODI)
           and Clie.IDENTIFICATION =
               decode(sbIDENTIFICATION,
                      '-1',
                      Clie.IDENTIFICATION,
                      sbIDENTIFICATION)
           and nvl(Clie.PHONE, '-1') =
               decode(sbPHONE, '-1', nvl(Clie.PHONE, '-1'), sbPHONE)
           and Cont.SUSCCLIE = Clie.SUBSCRIBER_ID
           and Cont.SUSCCODI = Prod.SUBSCRIPTION_ID
           and Dire.ADDRESS_ID = Clie.ADDRESS_ID
           and Dire.GEOGRAP_LOCATION_ID = LocDire.GEOGRAP_LOCATION_ID
           and DepLocDire.GEOGRAP_LOCATION_ID = LocDire.GEO_LOCA_FATHER_ID
           and Pred.ADDRESS_ID = Cont.SUSCIDDI
           and Pred.GEOGRAP_LOCATION_ID = LocPred.GEOGRAP_LOCATION_ID
           and DepLocPred.GEOGRAP_LOCATION_ID = LocPred.GEO_LOCA_FATHER_ID
           and SeSu.SESUCATE = Cate.CATECODI
           and SeSu.SESUCATE = SuCa.SUCACATE
           and SeSu.SESUSUCA = SuCa.SUCACODI;
    ELSIF (isbPhoneNumber IS NOT NULL) THEN

      open orfSubscriptionData for
        select Cont.SUSCCODI CONTRATO,
               SeSu.SESUNUSE NRO_SERVICIO,
               SeSu.SESUSERV CODIGO_SERVICIO,
               Serv.SERVDESC SERVICIO_DESC,
               Cont.SUSCCLIE CODIGO_CLIENTE,
               Clie.SUBSCRIBER_NAME || ' ' || Clie.SUBS_LAST_NAME CLIENTE,
               Pred.ADDRESS_ID CODIGO_DIRECCION_COBRO,
               Pred.ADDRESS DIRECCION_COBRO,
               DepLocPred.GEOGRAP_LOCATION_ID CODIGO_DEPTO,
               DepLocPred.DISPLAY_DESCRIPTION DEPTO_DIRECCION_COBRO,
               LocPred.GEOGRAP_LOCATION_ID CODIGO_LOCALIDAD,
               LocPred.DISPLAY_DESCRIPTION LOCALIDAD_DIRECCION_COBRO,
               Cate.CATECODI CODIGO_CATEGORIA,
               Cate.CATEDESC CATEGORIA,
               SuCa.SUCACODI CODIGO_SUBCATEGORIA,
               SuCa.SUCADESC SUBCATEGORIA,
			   Clie.PHONE TELEFONO,
			   SeSu.SESUESFN ESTADO_FINANCIERO,
			   Prod.PRODUCT_STATUS_ID ESTADO_TECNICO
          from SUSCRIPC           Cont,
               SERVSUSC           SeSu,
               SERVICIO           Serv,
               GE_SUBSCRIBER      Clie,
               PR_PRODUCT         Prod,
               AB_ADDRESS         Dire,
               AB_ADDRESS         Pred,
               CATEGORI           Cate,
               SUBCATEG           SuCa,
               GE_GEOGRA_LOCATION LocDire,
               GE_GEOGRA_LOCATION LocPred,
               GE_GEOGRA_LOCATION DepLocDire,
               GE_GEOGRA_LOCATION DepLocPred
         where SeSu.SESUSUSC = Cont.SUSCCODI
           and Serv.SERVCODI = SeSu.SESUSERV
           and Serv.SERVCODI =
               decode(nuSERVCODI, -1, Serv.SERVCODI, nuSERVCODI)
           and Cont.SUSCCLIE in (select SUBSCRIBER_ID
                                   from GE_SUBSCRIBER
                                  where PHONE = sbPHONE)
           and Cont.SUSCCLIE = Clie.SUBSCRIBER_ID
           and Cont.SUSCCODI = Prod.SUBSCRIPTION_ID
           and Dire.ADDRESS_ID = Clie.ADDRESS_ID
           and Dire.GEOGRAP_LOCATION_ID = LocDire.GEOGRAP_LOCATION_ID
           and DepLocDire.GEOGRAP_LOCATION_ID = LocDire.GEO_LOCA_FATHER_ID
           and Pred.ADDRESS_ID = Cont.SUSCIDDI
           and Pred.GEOGRAP_LOCATION_ID = LocPred.GEOGRAP_LOCATION_ID
           and DepLocPred.GEOGRAP_LOCATION_ID = LocPred.GEO_LOCA_FATHER_ID
           and SeSu.SESUCATE = Cate.CATECODI
           and SeSu.SESUCATE = SuCa.SUCACATE
           and SeSu.SESUSUCA = SuCa.SUCACODI;

    END IF;
    onuErrorCode := 0;
  EXCEPTION
    WHEN excep_Sin_Parametros_Entrada THEN
      rollback;
      OPEN orfSubscriptionData FOR
        SELECT * FROM DUAL WHERE 1 = 2;
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKCONEXIONU.proConsultaSuscriptor.excep_Sin_Parametros_Entrada]: ' ||
                         chr(13) ||
                         'No ingreso parametros de busqueda (Busqueda por Contrado o Documento Identidad o Telefono).';
      Errors.seterror(onuErrorCode, osbErrorMessage);

    WHEN excep_No_Encontro_Registro THEN
      rollback;
      OPEN orfSubscriptionData FOR
        SELECT * FROM DUAL WHERE 1 = 2;
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKCONEXIONU.proConsultaSuscriptor.excep_No_Encontro_Registro]: ' ||
                         chr(13) ||
                         'No se encontro registro con el criterio de busqueda ingresado.' ||
                         chr(13) || 'Servicio: ' || nuSERVCODI || chr(13) ||
                         'Contrato: ' || nuSUSCCODI || chr(13) ||
                         'Identificacion: ' || sbIDENTIFICATION || chr(13) ||
                         'Nro. Telefono: ' || sbPHONE;
      Errors.seterror(onuErrorCode, osbErrorMessage);

    WHEN OTHERS THEN
      rollback;
      OPEN orfSubscriptionData FOR
        SELECT * FROM DUAL WHERE 1 = 2;
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);
  END proConsultaSuscriptor;

END LDCI_PKCONEXIONU;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKBSSPORTALWEB', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKCONEXIONU to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKCONEXIONU to INTEGRADESA;
/
