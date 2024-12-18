CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKIVR AS
  /***********************************************************************************************************
   Paquete     : LDCI_PKIVR
   Descripcion : Paquete de integraciones personalizado para comunicaci?n con el IVR.
   Autor       : Jose Donado
   Fecha       : 24-09-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  PROCEDURE proConsDatosBasicosCont(clContratos          IN CLOB,
                             CUDATOSCONTRATOS            OUT SYS_REFCURSOR,
                             ONUERRORCODE                OUT NUMBER,
                             OSBERRORMESSAGE             OUT VARCHAR2);
                             
  PROCEDURE proConsultaCuponCont(inuSuscCodi   IN SUSCRIPC.SUSCCODI%TYPE,
                               onuCupon        OUT  CUPON.CUPONUME%TYPE,
                               onuValorCupon   OUT  CUPON.CUPOVALO%TYPE,
                               odtFechaLimPago OUT  VARCHAR2,
                               onuErrorCode    OUT  NUMBER,
                               osbErrorMessage OUT  VARCHAR2);
                               
  PROCEDURE proConsDatosInterrupCtto(clContratos       IN CLOB,
                           CUDATOSINTERRUP             OUT SYS_REFCURSOR,
                           ONUERRORCODE                OUT NUMBER,
                           OSBERRORMESSAGE             OUT VARCHAR2);
   
  PROCEDURE proConsReconexContrato(inuSuscCodi       IN SUSCRIPC.SUSCCODI%TYPE,
                                   onuSolicitud      OUT  NUMBER,
                                   osbTipoSolicitud  OUT  VARCHAR2,
                                   odtFechaRegSoli   OUT  VARCHAR2,
                                   odtFechaEstiAten  OUT  VARCHAR2,
                                   osbEstadoSoli     OUT  VARCHAR2,
                                   odtFechaAtencion  OUT  VARCHAR2,
                                   onuErrorCode      OUT  NUMBER,
                                   osbErrorMessage   OUT  VARCHAR2);
                           
END LDCI_PKIVR;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKIVR AS
  /***********************************************************************************************************
   Paquete     : LDCI_PKIVR
   Descripcion : Paquete de integraciones personalizado para comunicaci?n con el IVR.
   Autor       : Jose Donado
   Fecha       : 24-09-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/

  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : prcCierraCursor
  Descripcion    : Procedimiento para cerrar cursores (mandarlos con "DUMMY" en caso de que sean nulos)
  Autor          : Sebastian Tapias
  Fecha          : 02/04/2018
  REQ            : 200-1511

  Fecha             Autor                Modificacion
  =========       =========             ====================
  ******************************************************************/

PROCEDURE prcCierraCursor(CUCURSOR IN OUT SYS_REFCURSOR) AS

BEGIN
  IF NOT CUCURSOR%ISOPEN THEN
    OPEN CUCURSOR FOR
      SELECT * FROM dual where 1 = 2;
  END IF;

END;

  /***********************************************************************************************************
   Funcion     : proConsDatosBasicosCont
   Descripcion : Servicio encargado de obtener los datos b?sicos de los contratos ingresados.
   Autor       : Jose Donado
   Fecha       : 24-09-2018

  Parametros Entrada
    clContratos   XML con contratos

  Valor de salida
   ONUERRORCODE           codigo de error
   OSBERRORMESSAGE        mensaje de error
   CUDATOSCONTRATOS       refcursor datos de contratos

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
PROCEDURE proConsDatosBasicosCont(clContratos IN CLOB,
                           CUDATOSCONTRATOS            OUT SYS_REFCURSOR,
                           ONUERRORCODE                OUT NUMBER,
                           OSBERRORMESSAGE             OUT VARCHAR2) AS
                           
sbContrato VARCHAR2(32000); --se alamacenara lista de contrato 
nuContador NUMBER := 1; -- contador para tablas

--se deserializan los contratos pasados por XML
CURSOR cuContratos IS
SELECT DISTINCT idContrato
FROM XMLTable('/contratos/contrato' Passing
                 XMLType(clCONTRATOS)  Columns
                          idContrato NUMBER Path 'idContrato')
WHERE idContrato IS NOT NULL;

--CURSOR cuDatosContrato()

BEGIN
 sbContrato := '';

 --Se recorre cursor de contrato
 FOR reg IN cuContratos LOOP
    IF nuContador = 1 THEN
      sbContrato := reg.idContrato;
    ELSE
      sbContrato := sbContrato||','||reg.idContrato;
    END IF;
    
    nuContador := nuContador + 1;
 END  LOOP;
 
 --DBMS_OUTPUT.PUT_LINE('CONTRATOS: '||sbContrato);
 
    -- se carga cursor de datos de contratos
    OPEN CUDATOSCONTRATOS FOR
    SELECT S.SESUSUSC CONTRATO,
           S.SESUNUSE PRODUCTO,
           --to_char(MIN(d.difefein),'DD/MM/YYYY HH24:MI:SS') FECHAFINANCIACION,
           CL.IDENTIFICATION IDENTIFICACION,
           CL.SUBSCRIBER_NAME || ' ' || CL.SUBS_LAST_NAME NOMBRE,
           DECODE(S.SESUESFN,'A','AL DIA','D','CON DEUDA','C','CASTIGADO','M','MORA',S.SESUESFN) ESTADOFINANCIERO,
           P.PRODUCT_STATUS_ID IDESTADOPRODUCTO,
           PS.DESCRIPTION ESTADOPRODUCTO,
           S.SESUESCO IDESTADOCORTE,
           EC.ESCODESC ESTADOCORTE,
           A.ADDRESS DIRECCION,
           GL2.DESCRIPTION DEPARTAMENTO,
           GL.DESCRIPTION LOCALIDAD,
           S.SESUCATE IDCATEGORIA,
           CAT.CATEDESC CATEGORIA,
           S.SESUSUCA ESTRATO,
           (SELECT QH.ASSIGNED_QUOTE
            FROM OPEN.LD_QUOTA_HISTORIC QH
            WHERE QH.SUBSCRIPTION_ID = S.SESUSUSC
                  AND QH.QUOTA_HISTORIC_ID = (
            SELECT max(h.quota_historic_id)
            FROM Open.ld_quota_historic h
            WHERE h.subscription_id = S.SESUSUSC)) CUPOBRILLA,
            (SELECT ACTIVE
             FROM OPEN.PR_PROD_SUSPENSION PRS
             WHERE PRS.PRODUCT_ID = S.SESUNUSE
                   AND PRS.PROD_SUSPENSION_ID = (SELECT MAX(PRS2.PROD_SUSPENSION_ID) FROM OPEN.PR_PROD_SUSPENSION PRS2 WHERE PRS2.PRODUCT_ID = S.SESUNUSE)) SUSPENSIONES,
            TO_CHAR((SELECT PC.PLAZO_MIN_REVISION 
             FROM OPEN.LDC_PLAZOS_CERT PC
             WHERE PC.PLAZOS_CERT_ID = (SELECT MAX(PC1.PLAZOS_CERT_ID) FROM OPEN.LDC_PLAZOS_CERT PC1 WHERE PC1.ID_CONTRATO = S.SESUSUSC AND PC1.ID_PRODUCTO = S.SESUNUSE)),'DD/MM/YYYY') FECHAMINREVP,
            TO_CHAR((SELECT PC.PLAZO_MAXIMO 
             FROM OPEN.LDC_PLAZOS_CERT PC
             WHERE PC.PLAZOS_CERT_ID = (SELECT MAX(PC1.PLAZOS_CERT_ID) FROM OPEN.LDC_PLAZOS_CERT PC1 WHERE PC1.ID_CONTRATO = S.SESUSUSC AND PC1.ID_PRODUCTO = S.SESUNUSE)),'DD/MM/YYYY') FECHAMAXREVP
    FROM OPEN.SERVSUSC S
    
    INNER JOIN OPEN.SUSCRIPC C
    ON(C.SUSCCODI = S.SESUSUSC)
    
    INNER JOIN OPEN.PR_PRODUCT P
    ON(P.PRODUCT_ID = S.SESUNUSE)
    
    LEFT JOIN OPEN.GE_SUBSCRIBER CL
    ON(CL.SUBSCRIBER_ID = C.SUSCCLIE)
    
    INNER JOIN OPEN.PS_PRODUCT_STATUS PS
    ON(PS.PRODUCT_STATUS_ID = P.PRODUCT_STATUS_ID)
    
    INNER JOIN OPEN.ESTACORT EC
    ON(EC.ESCOCODI = S.SESUESCO)
    
    LEFT JOIN OPEN.AB_ADDRESS A
    ON(A.ADDRESS_ID = C.SUSCIDDI)
    
    LEFT JOIN OPEN.GE_GEOGRA_LOCATION GL
    ON(GL.GEOGRAP_LOCATION_ID = A.GEOGRAP_LOCATION_ID)
    
    LEFT JOIN OPEN.GE_GEOGRA_LOCATION GL2
    ON(GL2.GEOGRAP_LOCATION_ID = GL.GEO_LOCA_FATHER_ID)
    
    INNER JOIN OPEN.CATEGORI CAT
    ON(CAT.CATECODI = S.SESUCATE)
       
    WHERE S.SESUSUSC IN ( SELECT regexp_substr(sbContrato,'[^,]+', 1, LEVEL) FROM dual
                          CONNECT BY regexp_substr(sbContrato, '[^,]+', 1, LEVEL) IS NOT NULL ) 
       AND s.SESUSERV  in ( SELECT regexp_substr(OPEN.DALD_PARAMETER.FNUGETNUMERIC_VALUE('COD_SERV_GAS', NULL),'[^,]+', 1, LEVEL) FROM dual
                          CONNECT BY regexp_substr(OPEN.DALD_PARAMETER.FNUGETNUMERIC_VALUE('COD_SERV_GAS', NULL), '[^,]+', 1, LEVEL) IS NOT NULL );
  
  ONUERRORCODE := 0;
  OSBERRORMESSAGE := 'Proceso Ejecutado correctamente';
  prcCierraCursor(CUDATOSCONTRATOS);

EXCEPTION

  WHEN OTHERS THEN
    ONUERRORCODE    := -1;
    OSBERRORMESSAGE := sqlerrm;
    prcCierraCursor(CUDATOSCONTRATOS);
    dbms_output.put_line('Error al ejecutar el paquete LDCI_PKIVR.proConsultaDatosBasicosContrato' ||
                         sqlerrm);
    raise_application_error(-20010,
                            'Error al ejecutar el paquete LDCI_PKIVR.proConsultaDatosBasicosContrato');
END proConsDatosBasicosCont;

  /***********************************************************************************************************
   Funcion     : proConsultaCuponCont
   Descripcion : Servicio encargado de obtener las datos b?sicos del ?ltimo cup?n generado por la facturaci?n recurrente de un contrato.
   Autor       : Jose Donado
   Fecha       : 25-09-2018

  Parametros Entrada
    inuSuscCodi   Contrato

  Valor de salida
   ONUERRORCODE           codigo de error
   OSBERRORMESSAGE        mensaje de error
   ONUCUPON               Ultimo cupon generado por la facturaci?n recurrente
   ONUVALORCUPON          Valor del cupon
   ODTFECHALIMPAGO        Fecha limite de pago

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
PROCEDURE proConsultaCuponCont(inuSuscCodi IN SUSCRIPC.SUSCCODI%TYPE,
                               onuCupon        OUT  CUPON.CUPONUME%TYPE,
                               onuValorCupon   OUT  CUPON.CUPOVALO%TYPE,
                               odtFechaLimPago OUT  VARCHAR2,
                               onuErrorCode    OUT  NUMBER,
                               osbErrorMessage OUT  VARCHAR2) AS

nuFactura factura.factcodi%type;

BEGIN
    --Obtiene la ultima factura del contrato
    SELECT MAX(FACTCODI) 
    INTO NUFACTURA
    FROM OPEN.FACTURA 
    WHERE FACTSUSC = inuSuscCodi 
          AND FACTPROG=6;   

    IF NUFACTURA IS NOT NULL THEN         
      --Obtiene el cup?n asociado a la ?ltima factura recurrente del contrato
      BEGIN
        
      SELECT CUPONUME, 
             CUPOVALO
      INTO onuCupon,onuValorCupon
      FROM OPEN.CUPON
      WHERE CUPOSUSC = inuSuscCodi 
            AND CUPODOCU = nuFactura
            AND CUPOPROG = 'FIDF'
            AND CUPOFECH = (SELECT MAX(CUPOFECH) FROM OPEN.CUPON WHERE CUPOSUSC = inuSuscCodi AND CUPODOCU = nuFactura AND CUPOPROG = 'FIDF');   
      
      EXCEPTION 
        WHEN NO_DATA_FOUND THEN
          onuCupon := -1;
          onuValorCupon := -1;
      END;
            
      SELECT TO_CHAR(MAX(CUCOFEVE),'DD/MM/YYYY HH24:MI:SS')
      INTO odtFechaLimPago
      FROM OPEN.CUENCOBR
      WHERE CUCOFACT = nuFactura;
    
    ELSE
      onuCupon := NULL;
      onuValorCupon := NULL;
      odtFechaLimPago := NULL;
    END IF;
    
  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ejecutado correctamente';
    
EXCEPTION

  WHEN OTHERS THEN
    onuErrorCode    := -1;
    osbErrorMessage := sqlerrm;
    dbms_output.put_line('Error al ejecutar el paquete LDCI_PKIVR.proConsultaCuponCont' ||
                         sqlerrm);
    raise_application_error(-20010,
                            'Error al ejecutar el paquete LDCI_PKIVR.proConsultaCuponCont');
END proConsultaCuponCont;

  /***********************************************************************************************************
   Funcion     : proConsDatosInterrupCtto
   Descripcion : Servicio encargado de obtener las datos de la ?ltima interrupci?n registrada al producto de gas del contrato.
   Autor       : Jose Donado
   Fecha       : 25-09-2018

  Parametros Entrada
    clContratos   XML con contratos

  Valor de salida
   ONUERRORCODE           codigo de error
   OSBERRORMESSAGE        mensaje de error
   CUDATOSINTERRUP        Cursor referenciado, con la informaci?n de la ?ltima interrupci?n registrada a los contratos enviados


   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
PROCEDURE proConsDatosInterrupCtto(clContratos IN CLOB,
                           CUDATOSINTERRUP             OUT SYS_REFCURSOR,
                           ONUERRORCODE                OUT NUMBER,
                           OSBERRORMESSAGE             OUT VARCHAR2) AS

sbContrato  VARCHAR2(32000); --se alamacenara lista de contrato
sbSolicitud VARCHAR2(32000); --se alamacenara lista de solicitudes 
sbProductos VARCHAR2(32000); --se alamacenara lista de productos de gas
nuContador NUMBER := 1; -- contador para tablas

--se deserializan los contratos pasados por XML
CURSOR cuContratos IS
SELECT C.idContrato,S.SESUNUSE,MAX(PACKAGE_ID) SOLICITUD
FROM XMLTable('/contratos/contrato' Passing
                 XMLType(clCONTRATOS)  Columns
                          idContrato NUMBER Path 'idContrato') C
                          
INNER JOIN OPEN.SERVSUSC S
ON (S.SESUSUSC = C.idContrato)

LEFT JOIN OPEN.TT_DAMAGE_PRODUCT DP
ON(DP.PRODUCT_ID = S.SESUNUSE)

WHERE C.idContrato IS NOT NULL
      AND S.SESUSERV IN((  SELECT TO_NUMBER(COLUMN_VALUE)
                           FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.FNUGETNUMERIC_VALUE('COD_SERV_GAS', NULL), ',')))   )
GROUP BY C.idContrato,S.SESUNUSE;

BEGIN
  
 sbContrato  := '';
 sbProductos := '';
 sbSolicitud := '';

 --Se recorre cursor de contrato
 FOR reg IN cuContratos LOOP
    IF nuContador = 1 THEN
      sbContrato := reg.idContrato;
      sbProductos := reg.SESUNUSE;
      sbSolicitud := reg.SOLICITUD;
    ELSE
      sbContrato := sbContrato||','||reg.idContrato;
      sbProductos := sbProductos||','||reg.SESUNUSE;
      sbSolicitud := sbSolicitud||','||reg.SOLICITUD;
    END IF;
    
    nuContador := nuContador + 1;
 END  LOOP;
 
 /*

?	Tipo de Falla Registrada
?	Tipo de Falla Final

 */
  -- se carga cursor de datos de interrupciones
  OPEN CUDATOSINTERRUP FOR
  SELECT S.SESUSUSC CONTRATO,
         S.SESUNUSE PRODUCTO,
         DP.PACKAGE_ID SOLICITUD,
         PT.DESCRIPTION TIPOSOLICITUD,
         TO_CHAR(D.INITIAL_DATE,'DD/MM/YYYY HH24:MI:SS') FECHAINIINTERR,
         TO_CHAR(D.END_DATE,'DD/MM/YYYY HH24:MI:SS') FECHAFININTERR,
         TO_CHAR(D.ESTIMAT_ATTENT_DATE,'DD/MM/YYYY HH24:MI:SS') FECHAESTIMASOL,
         P.COMMENT_ OBSERVACION,
         DECODE(DP.REPAIRED,'Y','SI','N','NO','A','ATENDIDO','NO ESPECIFICADO') FUEREPARADO
  FROM OPEN.TT_DAMAGE_PRODUCT DP
  
  INNER JOIN OPEN.TT_DAMAGE D
  ON(D.PACKAGE_ID = DP.PACKAGE_ID)
  
  INNER JOIN OPEN.SERVSUSC S
  ON(S.SESUNUSE = DP.PRODUCT_ID)
  
  INNER JOIN OPEN.MO_PACKAGES P
  ON(P.PACKAGE_ID = DP.PACKAGE_ID)
  
  INNER JOIN OPEN.PS_PACKAGE_TYPE PT
  ON(PT.PACKAGE_TYPE_ID = P.PACKAGE_TYPE_ID)
  
  WHERE DP.PRODUCT_ID IN (  SELECT TO_NUMBER(COLUMN_VALUE)
                                            FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(sbProductos, ',')))
        AND DP.PACKAGE_ID IN(  SELECT TO_NUMBER(COLUMN_VALUE)
                                            FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(sbSolicitud, ',')));
  
  prcCierraCursor(CUDATOSINTERRUP);
    
  ONUERRORCODE := 0;
  OSBERRORMESSAGE := 'Proceso Ejecutado correctamente';
    
EXCEPTION

  WHEN OTHERS THEN
    ONUERRORCODE    := -1;
    OSBERRORMESSAGE := sqlerrm;
    dbms_output.put_line('Error al ejecutar el paquete LDCI_PKIVR.proConsDatosInterrupCtto' ||
                         sqlerrm);
    raise_application_error(-20010,
                            'Error al ejecutar el paquete LDCI_PKIVR.proConsDatosInterrupCtto');
END proConsDatosInterrupCtto;

 /***********************************************************************************************************
   Funcion     : proConsReconexContrato
   Descripcion : Servicio encargado de obtener los datos requeridos de la orden de reconexi?n.
   Autor       : Freddy Sierra
   Fecha       : 15-03-2021

  Parametros Entrada
    inuSuscCodi           Contrato

  Valor de salida
   onuSolicitud           Id de solicitud de la ?ltima orden de reconexi?n en estado generada
   osbTipoSolicitud       Tipo de solicitud -> 300- Reconexi?n por Pago, o 100240-Solicitud de reconexi?n, o 100333- LDC - Solicitud de Reconexi?n Tramites Internos
   odtFechaRegSoli        Fecha de registro de la solicitud en formato DD/MM/YYYY HH24:MI:SS
   odtFechaEstiAten       Fecha estimada de atenci?n en formato DD/MM/YYYY HH24:MI:SS
   osbEstadoSoli          Estado de la Solicitud
   odtFechaAtencion       Fecha de Atenci?n
   onuErrorCode           C?digo de Error
   osbErrorMessage        Mensaje de error

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
PROCEDURE proConsReconexContrato(inuSuscCodi       IN SUSCRIPC.SUSCCODI%TYPE,
                                 onuSolicitud      OUT  NUMBER,
                                 osbTipoSolicitud  OUT  VARCHAR2,
                                 odtFechaRegSoli   OUT  VARCHAR2,
                                 odtFechaEstiAten  OUT  VARCHAR2,
                                 osbEstadoSoli     OUT  VARCHAR2,
                                 odtFechaAtencion  OUT  VARCHAR2,
                                 onuErrorCode      OUT  NUMBER,
                                 osbErrorMessage   OUT  VARCHAR2) AS
-- Se definen las variables

sbTipoSolicitud VARCHAR2(100) := Dald_parameter.fsbGetValue_Chain('LDCI_TIPO_SOLICITUD_IVR',NULL); 
nuEstadoSolicitudReg NUMBER := Dald_parameter.fnuGetNumeric_Value('ESTADO_SOL_REGISTRADA',NULL);
exNoSolicitudes      EXCEPTION;

CURSOR cuSolicitud(inuContrato OPEN.SUSCRIPC.SUSCCODI%TYPE) IS
SELECT L.PACKAGE_ID AS SOLICITUD,
       L.PACKAGE_TYPE_ID || '-' || P.DESCRIPTION AS TIPO_SOLICITUD,
       TO_CHAR(L.REQUEST_DATE, 'DD/MM/YYYY HH24:MI:SS') AS FECHA_REGISTRO_SOLICITUD,
       TO_CHAR(L.EXPECT_ATTEN_DATE, 'DD/MM/YYYY HH24:MI:SS') AS FECHA_ESTIMADA_ATENCION,
       L.MOTIVE_STATUS_ID || '-' || MS.DESCRIPTION AS ESTADO_SOLICITUD,
       TO_CHAR(L.ATTENTION_DATE, 'DD/MM/YYYY HH24:MI:SS') AS FECHA_ATENCION
       
FROM OPEN.MO_PACKAGES L
  
 INNER JOIN OPEN.PS_PACKAGE_TYPE P
    ON (L.PACKAGE_TYPE_ID = P.PACKAGE_TYPE_ID)
    
 INNER JOIN OPEN.PS_MOTIVE_STATUS MS
    ON (L.MOTIVE_STATUS_ID = MS.MOTIVE_STATUS_ID)
    
WHERE L.PACKAGE_ID = (SELECT MAX(C.PACKAGE_ID)
                         FROM OPEN.MO_PACKAGES C
                        INNER JOIN OPEN.MO_MOTIVE F
                           ON (C.PACKAGE_ID = F.PACKAGE_ID)
                        WHERE C.PACKAGE_TYPE_ID IN (SELECT REGEXP_SUBSTR(sbTipoSolicitud,'[^,]+', 1, LEVEL) FROM DUAL
                                                    CONNECT BY REGEXP_SUBSTR(sbTipoSolicitud, '[^,]+', 1, LEVEL) IS NOT NULL)
                          AND C.MOTIVE_STATUS_ID = nuEstadoSolicitudReg
                          AND F.SUBSCRIPTION_ID = inuContrato); 
                                                          
BEGIN
                                        
IF sbTipoSolicitud IS NULL THEN
      RAISE ex.controlled_error;
END IF;      

IF nuEstadoSolicitudReg IS NULL THEN
      RAISE ex.controlled_error;
END IF; 

OPEN cuSolicitud(inuSuscCodi);
FETCH cuSolicitud INTO onuSolicitud, 
                       osbTipoSolicitud, 
                       odtFechaRegSoli, 
                       odtFechaEstiAten, 
                       osbEstadoSoli, 
                       odtFechaAtencion;
                       
IF cuSolicitud%NOTFOUND THEN
  onuSolicitud := -1;
  osbTipoSolicitud := ' '; 
  odtFechaRegSoli := '01/01/1900';
  odtFechaEstiAten := '01/01/1900';
  osbEstadoSoli := ' ';
  odtFechaAtencion := '01/01/1900';
  close cuSolicitud;
  RAISE exNoSolicitudes;
END IF;

CLOSE cuSolicitud; 
    
  onuErrorCode := 0;
  osbErrorMessage := 'Proceso Ejecutado correctamente';
    
EXCEPTION
  WHEN ex.controlled_error THEN
    onuErrorCode    := -1;
    osbErrorMessage := 'No existe datos en la configuracion del parametro';
    
  WHEN exNoSolicitudes THEN
    onuErrorCode := -1;
    osbErrorMessage := 'El contrato no tiene solicitudes de Reconexion en estado Registradas';
    
  WHEN OTHERS THEN
    onuErrorCode    := -1;
    osbErrorMessage := sqlerrm;
    dbms_output.put_line('Error al ejecutar el paquete LDCI_PKIVR.proConsReconexContrato' ||
                         sqlerrm);
                            
END proConsReconexContrato;

END LDCI_PKIVR;
/

PROMPT Otorgando permisos de ejecucion a LDCI_PKIVR
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKIVR','ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKIVR to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKIVR to REXEINNOVA;
/

