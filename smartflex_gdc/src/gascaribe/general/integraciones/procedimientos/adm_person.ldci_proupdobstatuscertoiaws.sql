create or replace PROCEDURE ADM_PERSON.LDCI_PROUPDOBSTATUSCERTOIAWS(inuCertiOia LDC_CERTIFICADOS_OIA.CERTIFICADOS_OIA_ID%type,
                                                         IsbStatus   LDC_CERTIFICADOS_OIA.STATUS_CERTIFICADO%type,
                                                         IsbObser    LDC_CERTIFICADOS_OIA.OBSER_RECHAZO%type,
														 IdtFechapro  LDC_CERTIFICADOS_OIA.FECHA_REG_OSF%TYPE DEFAULT null, --caso: 806
                                                         OnuCodigo   out number,
                                                         OsbMensaje  out varchar2) AS

  /***************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

   PROCEDIMIENTO : LDCI_PROUPDOBSTATUSCERTOIAWS
   AUTOR : Francisco castro
   FECHA : 15/05/2016
   DESCRIPCION : Procedimiento para actualizar el esta del certificado resultado de la
                 validacion de autenticidad del certificado, tambien envia correo el OIA
                 si tiene e_mail configurado en la unidad operativa

     Parametros de Entrada

     Parametros de Salida

   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   ljlb        23/10/2017   Caso 200-1324 Se coloca logica de creacion de suspension cuando el resultado sea 3
                            se coloca insert de tabla de transacciones
   eaguera     27/10/2017   Caso 200-1324 Se realizan correcciones y se modifica para que un error en la generaci?n
                            de la suspensi?n no afecte el resultado del proceso.
   stapias     02/01/2017   Caso 200-1572 Se agrega validacion de solicitud en estado atendida,
                            cuando el resultado de la inspeccion es 1 y se intenta aprobar.
                            Solo se permite actualizar estado, si el estado anterior es I.
   Kbaquero    09/02/2018   Caso 200-1722 Se va a descomentariar el envio de mail teniendo en cuenta
                            el condicional de aplicacion entrega.
   AAcuna      05/04/2018   Caso 200-1869 Quitar excepciones con ex.controller y enviar codigo y mensaje de error al momento
                            de ir a la excepcion personalizada

  Jbrito       08/01/2019   caso 200-2290 se agrega proceso para generar tramite 100014
  dsaltarin    14/03/2019   ca 200-2491. Se recupera el cambio perdido del caso 200-1871:
										 Se genera reconexion si es un certificado de tercero. Se llena tabla temporal a usar en
										 trigger ldc_trg_marca_producto_gdc.

  esantiago    17/05/2019	 caso 200-2464: Se agrega llamado al procedimiento LDC_PROCIERRAOTVISITACERTI
  LJLB         04/12/2019    CA 19 se agrega parametro de resultado de inspeccion al procedimiento LDC_PROCIERRAOTVISITACERTI
  dsaltarin	   26/11/2020	 Glpi  404 : Si se aprueba y el resultado es defectos actualice el campo el campo register_por_defecto
  dsaltarin    18/02/2022    GLPI 667: Si el certificado viene con resultado certificado se borra la marca de no reparable.
  horbath      30/12/2021    GLPI 806: Se añade el campo fecha de aprobacion
  jsoto		   03/01/2024	-Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
							-Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
							-Se suprimen llamado a "AplicaEntrega" (se deja la lógica solo de los que estén activos)
							-se crean cursores nuevo cuDatos, cuExisteSol,cuContadorInsp en reemplazo de (select into)
							-Se reemplaza función ldc_boutilities.splitstrings por REGEXP_SUBSTR.
  Paola Acosta 09/05/2024   OSF-2672: Cambio de esquema ADM_PERSON 
   ***************************************************************************/

  -- define las variables
  csbMT_NAME  			VARCHAR2(70) := 'LDCI_PROUPDOBSTATUSCERTOIAWS';
  cnuNVLTRC 			CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
  csbInicio   			CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;


  sbStatus_certi        LDC_CERTIFICADOS_OIA.STATUS_CERTIFICADO%TYPE;
  nuCERTIFICADOS_OIA_ID LDC_CERTIFICADOS_OIA.CERTIFICADOS_OIA_ID%TYPE;
  sbCERTIFICADO         LDC_CERTIFICADOS_OIA.CERTIFICADO%TYPE;
  nuID_ORGANISMO_OIA    LDC_CERTIFICADOS_OIA.ID_ORGANISMO_OIA%TYPE;
  nuID_CONTRATO         LDC_CERTIFICADOS_OIA.ID_CONTRATO%TYPE;
  dtFECHA_REGISTRO      LDC_CERTIFICADOS_OIA.FECHA_REGISTRO%TYPE;

  inuCERTIFICADOS_OIA_ID ge_boInstanceControl.stysbValue;
  isbCERTIFICADO         ge_boInstanceControl.stysbValue;
  inuID_ORGANISMO_OIA    ge_boInstanceControl.stysbValue;
  inuID_CONTRATO         ge_boInstanceControl.stysbValue;
  idtFECHA_REGISTRO      ge_boInstanceControl.stysbValue;
  idtID                  ge_boInstanceControl.stysbValue;
  sbFatherInstance       Ge_BOInstanceControl.stysbName;

  sbSTATUS_CERTIFICADO ge_boInstanceControl.stysbValue;
  sbOBSER_RECHAZO      ge_boInstanceControl.stysbValue;

  sender          VARCHAR2(2000);
  sbRecipients    VARCHAR2(2000);
  sbSubject       VARCHAR2(2000);
  sbMessage0      VARCHAR2(4000);
  onuErrorCode    NUMBER;
  osbErrorMessage VARCHAR2(4000);

  --ticket 2001324 LJLB-- se declaran variables
  nuResulInsp      LDC_CERTIFICADOS_OIA.RESULTADO_INSPECCION%type;
  sw               number;
  sbIdentification ge_subscriber.identification%type;
  SBValSuspCert    varchar2(100) := Dald_parameter.fsbGetValue_Chain('LDCI_FLAG_VALSUSPCERT',null);
  sbEstadoInicial  LDC_CERTIFICADOS_OIA.STATUS_CERTIFICADO%type;
  nuProductId      pr_product.product_id%TYPE;
  nuLocalidad      NUMBER;
  nuAse            NUMBER;
  onuPackageId     mo_packageS.package_id%type;
  onuMotiveId      mo_motive.motive_id%type;
  nuSecuencia      NUMBER;
  sbTerminal VARCHAR2(100);
  sbuser     VARCHAR2(100);
  sbMensSusp VARCHAR2(1000);
  blGenSusp  boolean := true;
  --fin 200 1324

  -- Ca 200-1572
  sbTipoPackage  VARCHAR(100);
  nuExitsPackage NUMBER;
  -- Fin

  --ticket 2001324 LJLB-- se consulta id del cliente
  CURSOR cuIdentificationSus(inuContrato SUSCRIPC.SUSCCODI%type) IS
    SELECT g.subscriber_id
      FROM SUSCRIPC s, ge_subscriber g
     WHERE g.subscriber_id = s.suscclie
       AND s.susccodi = inuContrato;

  CURSOR cuCertificadosOIA(nuCertificado LDC_CERTIFICADOS_OIA.certificados_oia_id%TYPE) IS
    SELECT id_contrato,
           id_producto,
           certificado,
           id_organismo_oia,
           fecha_registro,
           RESULTADO_INSPECCION,
           STATUS_CERTIFICADO,
           TIPO_INSPECCION,
           order_id,
           fecha_inspeccion,
		   VacioInterno -- caso: 806
      FROM LDC_CERTIFICADOS_OIA
     WHERE certificados_oia_id = nuCertificado;

    --TICKET 200-2290 Jbrito
    CURSOR cuCliente IS
    SELECT suscclie
    FROM suscripc
    WHERE susccodi = nuID_CONTRATO;

	CURSOR cuDatos IS
	SELECT USERENV('TERMINAL'), USER
	FROM dual;

   nuCliente   suscripc.suscclie%type;  --TICKET 200-2290 Jbrito -- se alamcena cliente
   nuProducto  pr_product.product_id%type;  --TICKET 200-2290 Jbrito -- se almacena codigo de producto
   nuTipoInsp  LDC_CERTIFICADOS_OIA.TIPO_INSPECCION%type; --TICKET 200-2290 Jbrito -- se almacena tipo de inspeccion

   sbTipoCerti  VARCHAR2(4000) := DALD_PARAMETER.fsbGetValue_Chain('LDCPARTIPOCERT', NULL);

  --CA200-1871
  sbTablaTemp ld_parameter.value_chain%type:= nvl(Dald_parameter.fsbGetValue_Chain('LD_OPERATING_UNIT_GDC',null),'N');
  plsql_block  varchar2(4000);
  --CA200-1871

  --CASO 19
  sbTipoInso            VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TIPOESSN',NULL); --se almacena tipo de inspension de servicio nuevo
  sbresultadoInsp		VARCHAR2(100) := dald_parameter.fsbgetvalue_chain('RESULTADO_INSPECCION_OIA',NULL);
  sbTipoSolVenta		VARCHAR2(100) := dald_parameter.fsbgetvalue_chain('TIPO_SOLIC_VENTA_OIA',NULL);
  sbStatusVentaOIA		VARCHAR2(100) := dald_parameter.fsbgetvalue_chain('STATUS_SOLIC_VENTA_OIA',NULL);
  csbTiposInspeccionMarca CONSTANT LDC_PARAREPE.paravast%type := DALDC_PARAREPE.fsbGetPARAVAST('TIPOINSACTMARCA',NULL);



  nuTipoIns        NUMBER; --se almacena si el tipo de Inspecci??n
  sbdatoSusp VARCHAR2(1);

  inuOrderid       number;

  --Se valida si el tipo de Inspecci??n  es de servicio nuevos
  Cursor cuValTipoInspeccion(nuTipoInsp number) is
    SELECT count(1) cantidad
      FROM DUAL
     WHERE nuTipoInsp IN
					  (select distinct REGEXP_SUBSTR(sbTipoInso, '[^,]+', 1, level)
						from dual
					  connect by regexp_substr(sbTipoInso, '[^,]+', 1, level) is not null);


    inuSUSPENSION_TYPE_ID NUMBER := dald_parameter.fnugetnumeric_value('LDC_TIPOSUSPRECSN',
                                                                       NULL); --se almacena el tipo de suspension
    --se consulta syuspension por servicio nuevo
    CURSOR cuGetprodSusp IS
      SELECT 'X'
        FROM pR_PROD_SUSPENSION ps
       where ps.PRODUCT_ID = nuProducto
         and ps.ACTIVE = 'Y'
         AND ps.suspension_type_id = inuSUSPENSION_TYPE_ID;

    CURSOR CUEXISTE(NUVALOR OR_ORDER.CAUSAL_ID%TYPE) IS
		SELECT count(1) cantidad
		  FROM DUAL
		 WHERE NUVALOR IN
					  (select distinct REGEXP_SUBSTR(sbresultadoInsp, '[^,]+', 1, level)
						from dual
					  connect by regexp_substr(sbresultadoInsp, '[^,]+', 1, level) is not null);


	CURSOR cuExisteSol(inuCERTIFICADOS_OIA_ID LDC_CERTIFICADOS_OIA.CERTIFICADOS_OIA_ID%TYPE) IS
		SELECT COUNT(1)
            FROM MO_PACKAGES          M,
                 LDC_CERTIFICADOS_OIA L,
                 SUSCRIPC             C,
                 SERVSUSC             P
           WHERE M.SUBSCRIPTION_PEND_ID = L.ID_CONTRATO
             AND L.CERTIFICADOS_OIA_ID = inuCERTIFICADOS_OIA_ID
             AND L.ID_CONTRATO = C.SUSCCODI
             AND C.SUSCCODI = P.SESUSUSC
             AND L.ID_PRODUCTO = P.SESUNUSE
             AND M.PACKAGE_TYPE_ID IN
								  (select distinct REGEXP_SUBSTR(sbTipoSolVenta, '[^,]+', 1, level)
									from dual
								  connect by regexp_substr(sbTipoSolVenta, '[^,]+', 1, level) is not null)
             AND M.MOTIVE_STATUS_ID IN
								  (select distinct REGEXP_SUBSTR(sbStatusVentaOIA, '[^,]+', 1, level)
									from dual
								  connect by regexp_substr(sbStatusVentaOIA, '[^,]+', 1, level) is not null);


	CURSOR cuContadorInsp(inuTipoInsp LDC_CERTIFICADOS_OIA.TIPO_INSPECCION%type)IS
		SELECT COUNT(to_number(DatosParametro))
            FROM(
	             SELECT regexp_substr(csbTiposInspeccionMarca, '[^,]+', 1, LEVEL)AS DatosParametro
		         FROM dual
			     CONNECT BY regexp_substr(csbTiposInspeccionMarca, '[^,]+', 1, LEVEL) IS NOT NULL)
            WHERE DatosParametro = inuTipoInsp;



  nuRESULTADO_INSPECCION_OIA number;
  --CASO 19

  --404
  nuCountInspeccion 		NUMBER;
  sbInactivaRegister 	  	ldc_pararepe.paravast%type:=DALDC_PARAREPE.fsbGetPARAVAST('INACTIVA_REGISTRO_POR_DEF',NULL);
  sbRESU_ES_X_DEFECTO   	VARCHAR2(1);
  nuSUSPENSION_TYPE_ID  	LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID%TYPE;
  dtFechaInsp           	ldc_certificados_oia.fecha_inspeccion%type;
  sbActualizaMarca 	  		ldc_pararepe.paravast%type:=DALDC_PARAREPE.fsbGetPARAVAST('ACTUALIZA_MARCA_102',NULL);
  Sbvacio 					ldc_certificados_oia.vaciointerno%TYPE; -- caso: 806
  nuValplazo 				number;-- caso: 806
  sbNoReparable        		varchar2(1);
  nuNoReparable        		number;
  rcMarkProduct       		LDC_MARCAPRODREPA%rowtype;
  sbproceso                 VARCHAR2(200) := 'LDCI_PROUPDOBSTATUSCERTOIAWS'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

  Cursor cuValplazo(nuProd number) is -- caso: 806
    select 1
	from LDC_PLAZOS_CERT
	where ID_PRODUCTO=nuProd
	and rownum=1;

---667
        FUNCTION fnuExistMark(nuProduct pr_product.product_id%type)
        RETURN NUMBER
        IS
			CURSOR cuContador IS
            SELECT  COUNT(1)
            FROM    LDC_MARCAPRODREPA
            WHERE   PRODUCTO_ID = nuProduct
            AND     bloqueo = 'Y';



            nuCount         NUMBER;
        BEGIN

			pkg_traza.trace(csbMT_NAME||'.fnuExistMark ',cnuNVLTRC, pkg_traza.csbINICIO);

			IF cuContador%ISOPEN THEN
				CLOSE cuContador;
			END IF;

			OPEN cuContador;
			FETCH cuContador INTO nuCount;
			CLOSE cuContador;

			pkg_traza.trace('nuCount :'||nuCount, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME||'.fnuExistMark ',cnuNVLTRC,pkg_traza.csbFIN);

            RETURN nuCount;

        EXCEPTION
            WHEN pkg_error.controlled_error THEN
 				 pkg_error.getError(onuErrorCode,osbErrorMessage);
				 pkg_traza.trace(csbMT_NAME||'.fnuExistMark '||osbErrorMessage, cnuNVLTRC);
			     pkg_traza.trace(csbMT_NAME||'.fnuExistMark',cnuNVLTRC, pkg_traza.csbFIN_ERC);
                RAISE pkg_error.controlled_error;
            WHEN OTHERS THEN
				 pkg_error.setError;
				 pkg_error.getError(onuErrorCode,osbErrorMessage);
 				 pkg_traza.trace(csbMT_NAME||'.fnuExistMark '||osbErrorMessage, cnuNVLTRC);
			     pkg_traza.trace(csbMT_NAME||'.fnuExistMark',cnuNVLTRC, pkg_traza.csbFIN_ERR);
                RAISE pkg_error.controlled_error;
        END fnuExistMark;

BEGIN

  pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
  
  pkg_traza.trace('inuCertiOia: '||inuCertiOia, cnuNVLTRC);

  OnuCodigo             := 0;
  sbStatus_certi        := IsbStatus;
  nuCERTIFICADOS_OIA_ID := inuCertiOia;

  --Obtiene los datos del resultado de inspeccion
  OPEN cuCertificadosOIA(nuCERTIFICADOS_OIA_ID);
  FETCH cuCertificadosOIA
    INTO nuID_CONTRATO,
         nuProducto,
         sbCERTIFICADO,
         nuID_ORGANISMO_OIA,
         dtFECHA_REGISTRO,
         nuResulInsp,
         sbEstadoInicial,
         nuTipoInsp,
         inuOrderid,
         dtFechaInsp,
		     Sbvacio; -- caso: 806
  CLOSE cuCertificadosOIA;

  pkg_traza.trace('nuID_CONTRATO: '||nuID_CONTRATO||
                  'nuProducto: '||nuProducto||
                  'sbCERTIFICADO: '||sbCERTIFICADO||
                  'nuID_ORGANISMO_OIA: '||nuID_ORGANISMO_OIA||
                  'dtFECHA_REGISTRO: '||dtFECHA_REGISTRO||
                  'nuResulInsp:'||nuResulInsp||
                  'sbEstadoInicial: '||sbEstadoInicial||
                  'nuTipoInsp: '||nuTipoInsp||
                  'inuOrderid: '||inuOrderid||
                  'dtFechaInsp: '||dtFechaInsp
                  ,cnuNVLTRC);

 
  /*Inicio se activa para el caso 200-1722 */
  sender       := DALD_PARAMETER.fsbGetValue_Chain('LDC_SMTP_SENDER', NULL);
  sbRecipients := daor_operating_unit.fsbgete_mail(nuID_ORGANISMO_OIA);
  /*Fin se activa para el caso 200-1722 */

  pkg_traza.trace('sbRecipients: '||sbRecipients, cnuNVLTRC);
  
  --Caso 200-1572 validacion de estado anterior
    IF sbEstadoInicial = 'I' THEN

		pkg_traza.trace('sbEstadoInicial: '||sbEstadoInicial, cnuNVLTRC);

		IF cuDatos%ISOPEN THEN
			CLOSE cuDatos;
		END IF;

		OPEN cuDatos;
		FETCH cuDatos INTO sbTerminal,sbuser;
		CLOSE cuDatos;

		--Consultamos la secuencia para registrar el cambio de estado
		nuSecuencia := SEQ_LDC_CERTIFICADO_CAMBEST.NEXTVAL;

		--Se registra el cambio de estado de la inspecci?n
		INSERT INTO LDC_CERTIFICADO_CAMBEST
		  (ID_CAESCERT,
		   CERTIFICADOS_OIA_ID,
		   USUARIO,
		   TERMINAL,
		   FECHA_CAMBIO,
		   ESTADO_INICIAL,
		   ESTADO_FINAL,
		   OBSERVACION)
		VALUES
		  (nuSecuencia,
		   nuCERTIFICADOS_OIA_ID,
		   sbuser,
		   sbTerminal,
		   SYSDATE,
		   sbEstadoInicial,
		   sbStatus_certi,
		   nvl(IsbObser, ''));

    -- Ca 200-1572 validacion de solictud en estado antendida.
		IF dald_parameter.fsbgetvalue_chain('VALIDA_SOLICITUD_ATENDIDA_OIA') = 'Y' THEN
		  --Verificamos que la orden de inspeccion este en estado [1 - CERTIFICADA].

			pkg_traza.trace('VALIDA_SOLICITUD_ATENDIDA_OIA', cnuNVLTRC);

			  IF nuResulInsp =
				 Dald_parameter.fnuGetNumeric_Value('ESTADO_INSPECCION_ORDEN_OIA') AND
				 sbStatus_certi =
				 dald_parameter.fsbgetvalue_chain('STATUS_CERTIF_OIA') THEN

					pkg_traza.trace('ESTADO_INSPECCION_ORDEN_OIA = STATUS_CERTIF_OIA', cnuNVLTRC);

					BEGIN
					  --Verificamos si para el contrato y producto del certificado existe una solicitud de tipo [Venta de Gas por Formulario o Venta de Gas Cotizada] en estado atendida.

					  IF cuExisteSol%ISOPEN THEN
						CLOSE cuExisteSol;
					  END IF;

					  OPEN cuExisteSol(nuCERTIFICADOS_OIA_ID);
					  FETCH cuExisteSol INTO nuExitsPackage;
					  CLOSE cuExisteSol;

					  pkg_traza.trace('nuExitsPackage: '||nuExitsPackage, cnuNVLTRC);

					  IF nuExitsPackage = 0 THEN
						sbTipoPackage := dald_parameter.fsbgetvalue_chain('TIPO_SOLIC_VENTA_OIA');
						OnuCodigo     := -1;
						OsbMensaje    := 'El certificado a actualizar no tiene una solicitud asociada de tipo [' ||
										 sbTipoPackage || '] en estado Atendida';
						RAISE pkg_error.controlled_error;

					  END IF;
					EXCEPTION
					  WHEN pkg_error.controlled_error THEN
						rollback;
						RAISE pkg_error.controlled_error;
					  WHEN OTHERS THEN
						OnuCodigo  := -1;
						OsbMensaje := 'Proceso termino con errores, Se presento un error validando la solicitud asociada al certificado';
						RAISE pkg_error.controlled_error;
					END;
			  END IF;

		END IF;
    -- Fin

		IF sbTablaTemp = 'S' then
		  pkg_traza.trace('sbTablaTemp: '||sbTablaTemp, cnuNVLTRC);
		  EXECUTE IMMEDIATE 'INSERT INTO LDC_UNIDAD_CERTIF VALUES('||nuID_CONTRATO||','||nuID_ORGANISMO_OIA||')';
		END IF;
	--200-1871--

	--INICIO caso: 806
		IF nuProducto IS NOT NULL and Sbvacio is not null and sbstatus_certi = 'A' THEN

			pkg_traza.trace('sbstatus_certi: '||sbstatus_certi, cnuNVLTRC);

			open cuValplazo(nuProducto);
			  fetch cuValplazo into nuValplazo ;
			  close cuValplazo;

			  pkg_traza.trace('nuValplazo: '||nuValplazo, cnuNVLTRC);

				IF nuValplazo=1 THEN

					UPDATE LDC_PLAZOS_CERT
					SET VACIOINTERNO=Sbvacio
					where ID_PRODUCTO=nuProducto;
				else

					insert into LDC_PLAZOS_CERT
								(PLAZOS_CERT_ID,
								ID_CONTRATO,
								ID_PRODUCTO,
								VACIOINTERNO)
						VALUES  (LDC_SEQ_PLAZOS_CERT.NEXTVAL,
								nuID_CONTRATO,
								nuProducto,
								Sbvacio);
				END IF;

		END IF;


		IF IdtFechapro IS NULL THEN
		  OnuCodigo:=-1;
				OsbMensaje:= 'La fecha de aprobacion no puede ser nula';
				pkg_traza.trace('OsbMensaje: '||OsbMensaje, cnuNVLTRC);
				RAISE pkg_error.controlled_error;
		end if;

		IF trunc(IdtFechapro) > trunc(sysdate) THEN
		  OnuCodigo:=-1;
				OsbMensaje:= 'La fecha de aprobacion '|| trunc(IdtFechapro) ||' no puede ser mayor que la fecha actual '||trunc(sysdate);
				pkg_traza.trace('OsbMensaje: '||OsbMensaje, cnuNVLTRC);
				RAISE pkg_error.controlled_error;
		end if;

             --Actualiza el estado de la inspecci?n
		UPDATE LDC_CERTIFICADOS_OIA
		   SET STATUS_CERTIFICADO = sbStatus_certi,
			   OBSER_RECHAZO      = IsbObser || '. ' || sbMensSusp,
			   FECHA_APRO_OSF   = SYSDATE,
			   FECHA_APROBACION   = IdtFechapro
		 WHERE CERTIFICADOS_OIA_ID = nuCERTIFICADOS_OIA_ID;

	   --Fin caso: 806

		OsbMensaje := 'El estado de la inspecci?n ' || sbCERTIFICADO ||
					  ' fue cambiado a ';

		IF sbStatus_certi = 'A' THEN
		  OsbMensaje := OsbMensaje || ' APROBADO';
		ELSE
		  OsbMensaje := OsbMensaje || ' RECHAZADO';
		END IF;

		pkg_traza.trace('OsbMensaje: '||OsbMensaje, cnuNVLTRC);

		OnuCodigo  := 0;
		OsbMensaje := OsbMensaje || '. ' || sbMensSusp;

  ELSE
    OnuCodigo  := -1;
    OsbMensaje := 'El estado inicial es [' || sbEstadoInicial ||
                  ']. Solo se puede actualizar si el estado inicial es [I]';
	pkg_traza.trace('OsbMensaje: '||OsbMensaje, cnuNVLTRC);
    RAISE pkg_error.controlled_error;
  END IF;


  ---404
  IF sbStatus_certi = 'A' THEN

		IF cuContadorInsp%ISOPEN THEN
			CLOSE cuContadorInsp;
		END IF;

		OPEN cuContadorInsp(nuTipoInsp);
		FETCH cuContadorInsp INTO nuCountInspeccion;
		CLOSE cuContadorInsp;

        pkg_traza.trace('nuCountInspeccion: '||nuCountInspeccion, cnuNVLTRC);

        IF nuCountInspeccion > 0 THEN

              IF (nuResulInsp  in (2, 5)) THEN --Se agrega l?gica del resultado 5 (GLPI 102)
                sbRESU_ES_X_DEFECTO := 'Y';
                IF daldc_marca_producto.fblExist(nuProducto) THEN
                  nuSUSPENSION_TYPE_ID := daldc_marca_producto.fnuGetSUSPENSION_TYPE_ID(nuProducto);
				  pkg_traza.trace('sbActualizaMarca: '||sbActualizaMarca, cnuNVLTRC);

                    if sbActualizaMarca ='S' then
                      UPDATE LDC_MARCA_PRODUCTO
                         SET CERTIFICADO          = sbCERTIFICADO,
                             FECHA_ULTIMA_ACTU    = TRUNC(dtFechaInsp),
                             INTENTOS             = NVL(INTENTOS, 0) + 1,
                             MEDIO_RECEPCION      = 'E',
                             REGISTER_POR_DEFECTO = sbRESU_ES_X_DEFECTO,
                             SUSPENSION_TYPE_ID   = 102
                       WHERE ID_PRODUCTO = nuProducto;
                    ldc_prmarcaproductolog(nuProducto,nuSUSPENSION_TYPE_ID, 102 , 'Aprobacion Certificado :'||inuCertiOia);
                  else
                     UPDATE LDC_MARCA_PRODUCTO
                         SET CERTIFICADO          = sbCERTIFICADO,
                             FECHA_ULTIMA_ACTU    = TRUNC(dtFechaInsp),
                             INTENTOS             = NVL(INTENTOS, 0) + 1,
                             MEDIO_RECEPCION      = 'E',
                             REGISTER_POR_DEFECTO = sbRESU_ES_X_DEFECTO
                       WHERE ID_PRODUCTO = nuProducto;
                  end if;
                ELSE
                  INSERT INTO LDC_MARCA_PRODUCTO
                    (ID_PRODUCTO,
                     ORDER_ID,
                     CERTIFICADO,
                     FECHA_ULTIMA_ACTU,
                     INTENTOS,
                     MEDIO_RECEPCION,
                     REGISTER_POR_DEFECTO,
                     SUSPENSION_TYPE_ID)
                  VALUES
                    (nuProducto,
                     NULL,
                     isbCertificado,
                     trunc(dtFechaInsp),
                     1,
                     'E',
                     sbRESU_ES_X_DEFECTO,
                     102);
					           ldc_prmarcaproductolog(nuProducto,null, 102 , 'Aprobacion Certificado :'||inuCertiOia);
                END IF;
              ELSE
			    pkg_traza.trace('sbInactivaRegister: '||sbInactivaRegister, cnuNVLTRC);
				IF sbInactivaRegister = 'S' THEN
					IF daldc_marca_producto.fblExist(nuProducto) THEN
						UPDATE LDC_MARCA_PRODUCTO
						   SET REGISTER_POR_DEFECTO = 'N'
						 WHERE ID_PRODUCTO = nuProducto;
					End if;
				END IF;
			  END IF;

          END IF;

  end if;
  ---404

  --200-1871
  IF nvl(dald_parameter.fsbgetvalue_chain('LDC_PAR_IF_TRAMITA_RECONEXION',null),'N') = 'S' THEN
    pkg_traza.trace('plsql_block: '||'LDCCREATETRAMITERECONEXIONXML'||nuCERTIFICADOS_OIA_ID||' '||sbStatus_certi, cnuNVLTRC);
    plsql_block := 'BEGIN LDCCREATETRAMITERECONEXIONXML(:id_certificado, :estado); END;';
	EXECUTE IMMEDIATE plsql_block USING nuCERTIFICADOS_OIA_ID, sbStatus_certi;
  END IF;
  --200-2871

    -- inicio caso: 2002464
   IF sbStatus_certi = 'A' then
       pkg_traza.trace('PROCIERRAOTVISITACERTI'||' '||nuProducto||' '||nuID_ORGANISMO_OIA||' '||SBCERTIFICADO);
       --TICKET 19 LJLB-- se agrega parametro nuResulInsp
        LDC_PROCIERRAOTVISITACERTI(  nuProducto,     nuID_ORGANISMO_OIA,     SBCERTIFICADO );
   END IF;
   -- fin caso: 2002464

   --CASO 19

    --TICKET 19 LJLB--

      OPEN cuValTipoInspeccion(nuTipoInsp);
      FETCH cuValTipoInspeccion
        INTO nuTipoIns;
      CLOSE cuValTipoInspeccion;

      open CUEXISTE(nuResulInsp);
      fetch CUEXISTE into nuRESULTADO_INSPECCION_OIA;
      close CUEXISTE;

      IF nuTipoIns > 0 and IsbStatus = 'A' and inuOrderid IS NULL and nuRESULTADO_INSPECCION_OIA = 1 THEN
        onuErrorCode    := null;
        osbErrorMessage := null;
        sbdatoSusp      := null;
        pkg_traza.trace('ingreso al proceso sn '||nuProducto);
        OPEN cuGetprodSusp;
        FETCH cuGetprodSusp
          into sbdatoSusp;
        CLOSE cuGetprodSusp;
            pkg_traza.trace('sbdatoSusp '||sbdatoSusp);
        IF sbdatoSusp IS NOT NULL THEN
          pkg_traza.trace(' Inicia LDC_PKGESTNUESQSERVNUE.PRGENEORDRECO');
		  --se realiza reconexion de servicio
          LDC_PKGESTNUESQSERVNUE.PRGENEORDRECO(inuOrderid,
                                               nuProducto,
                                               onuErrorCode,
                                               osbErrorMessage);
          IF nvl(onuErrorCode, 0) != 0 THEN
		    pkg_traza.trace('fin LDC_PKGESTNUESQSERVNUE.PRGENEORDRECO' ||' onuErrorCode:'||onuErrorCode||' '||osbErrorMessage);
            pkg_error.setErrorMessage(pkg_error.cnugeneric_message,
                                             osbErrorMessage);
          END IF;
        END IF;
        pkg_traza.trace('fin LDC_PKGESTNUESQSERVNUE.PRGENEORDRECO');
        LDC_PKGESTNUESQSERVNUE.PRANULORDCERYSUS(nuProducto);

      END IF;

   --FIN CASO 19

      if nuRESULTADO_INSPECCION_OIA>=1 then
        sbNoReparable :='N';
      else
        sbNoReparable:= ldc_bodefectnorepara.fsbvaldefectsnorepairbycod(nuCERTIFICADOS_OIA_ID);
      end if;

	  pkg_traza.trace('sbNoReparable: '||sbNoReparable, cnuNVLTRC);
	  pkg_traza.trace('IsbStatus: '||IsbStatus, cnuNVLTRC);

      nuNoReparable := fnuExistMark(nuProducto);
      if sbNoReparable = 'N' and IsbStatus = 'A' and nuNoReparable>0  then
        UPDATE LDC_MARCAPRODREPA
              SET fecha_inactivacion = LDC_BOCONSGENERALES.FDTGETSYSDATE,
                  bloqueo = 'N'
          WHERE producto_id = nuProducto
          AND   bloqueo = 'Y';
      elsif sbNoReparable ='S' and IsbStatus = 'A' and nuNoReparable= 0 then
            rcMarkProduct.MARCA_ID := SEQ_LDC_MARCAPRODREPA.NEXTVAL;
            rcMarkProduct.PRODUCTO_ID := nuProducto;
            rcMarkProduct.ORDEN_ID := inuOrderid;
            rcMarkProduct.BLOQUEO := 'Y';
            rcMarkProduct.FECHA_BLOQUEO := LDC_BOCONSGENERALES.FDTGETSYSDATE;

            INSERT INTO LDC_MARCAPRODREPA VALUES rcMarkProduct;
      end if;

   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN);

EXCEPTION

  WHEN pkg_error.controlled_error THEN
	rollback;
	pkg_error.getError(OnuCodigo,OsbMensaje);
	pkg_traza.trace(csbMT_NAME||' '||OsbMensaje, cnuNVLTRC);
	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);
  WHEN OTHERS THEN
    rollback;
	pkg_error.setError;
	pkg_error.getError(OnuCodigo,OsbMensaje);
	pkg_traza.trace(csbMT_NAME||' '||OsbMensaje, cnuNVLTRC);
	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);
END LDCI_PROUPDOBSTATUSCERTOIAWS;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PROUPDOBSTATUSCERTOIAWS
BEGIN
    pkg_utilidades.praplicarpermisos('LDCI_PROUPDOBSTATUSCERTOIAWS', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDCI_PROUPDOBSTATUSCERTOIAWS para reportes
GRANT EXECUTE ON adm_person.LDCI_PROUPDOBSTATUSCERTOIAWS TO rexereportes;
/

PROMPT Otorgando permisos de ejecucion sobre LDCI_PROUPDOBSTATUSCERTOIAWS para REXEINNOVA
GRANT EXECUTE ON adm_person.LDCI_PROUPDOBSTATUSCERTOIAWS TO REXEINNOVA;
/