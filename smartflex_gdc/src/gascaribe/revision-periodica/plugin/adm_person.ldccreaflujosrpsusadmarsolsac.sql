create or replace PROCEDURE adm_person.ldccreaflujosrpsusadmarsolsac IS
/******************************************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2018-09-27
  Descripcion : Procedimiento que verifica que la orden de suspension tenga el tipo de comentario PARAM_TIPOCOMENT_OTSUSPSOLSAC
               ,y de acuerdo a la causal con que se legalice, genere una reconexion o genere una orden de revision,reparacion
               o certificacion.

  Parametros Entrada

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
   05/12/2022   jhinestroza  Jira OSF-739: *Se adiciona el control para validar los estados del producto (C-Castigado o 5-suspension Total),
                                            si presenta uno de estos no se realiza la creacion del tramite de reconexion.

   12/05/2021   HORBATH      CASO 602: *Crear un nuevo cursor llamado CUVALIDACAUTIPTRA. En este cursor se validará si el
                                       tipo de trabajo y causal están configurados en el nuevo parámetro llamado LDC_PARAREPE
                                       *Crear un nuevo cursor llamado CUDATAORDEN. Para obtener información de la orden legalizada.
                                       *comentariar las sentencia con los parametros PARAM_CAUSLEG_SACOTSUSP,
                                       PARAM_CAULEG_FAL_SACOTSUSPACOM, PARAM_CAUSLEG_SACOTSUSPACOM
  19-04-2024   Adrianavg	 OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON   
	07/11/2024	jeerazomvm		OSF:3571: 1. Se agregan trazas
										  2. Se reemplaza el llamado de los siguientes procedimientos y funciones:
											- OR_BOLEGALIZEORDER.FNUGETCURRENTORDER por pkg_bcordenes.fnuObtenerOTInstanciaLegal
											- daor_order.fnugetcausal_id por pkg_bcordenes.fnuobtienecausal
											- ge_boerrors.seterrorcodeargument por pkg_error.setErrorMessage
											- os_addordercomment por api_addordercomment
										  3. Se elimina validación fblaplicaentregaxcaso(0000602)
										  4. Se crea el procedimiento prcEnviaCorreo y se implementa en el bloque de excepciones
											 despues de ejecutar los procedimientos LDCPROCCREATRAMFLUJSACXML y LDCPROCREATRAMRECSINCERTXML.
*******************************************************************************************************************************/

	--Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)  := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)     := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	:= pkg_traza.csbINICIO;   
	
	CURSOR cuComment(inuOrderId or_order.order_id%type) 
	IS
		SELECT COUNT(*)
		FROM or_order_comment
		WHERE order_id 		= inuOrderId
		AND comment_type_id = PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('PARAM_TIPOCOMENT_OTSUSPSOLSAC');
	 
	nuorderid    				or_order.order_id%TYPE;
	nucausalid   				ge_causal.causal_id%TYPE;
	nucount      				NUMBER(6);
	nuClaseCausal				ge_causal.class_causal_id%type;
	sbCausparam  				LDC_PARAREPE.PARAVAST%TYPE;
	sbmensa          			VARCHAR2(2000);

	--CASO 602---
	cursor CUVALIDACAUTIPTRA(INUTASKTYPEID number, INUCAUSALID number, IsbCausparam varchar2) 
	is
		SELECT count(1) cantidad
		FROM DUAL
		WHERE INUTASKTYPEID || ';' || INUCAUSALID IN (SELECT (regexp_substr(IsbCausparam,
                                                                '[^|]+',
                                                                1,
                                                                LEVEL)
                                                                ) AS vlrColumna
													  FROM dual
													  CONNECT BY regexp_substr(IsbCausparam,
                                                                  '[^|]+',
                                                                  1,
                                                                  LEVEL
                                                                  ) IS NOT NULL);

	cursor CUDATAORDEN(INUORDERID number) 
	is
		select oo.task_type_id, 
			   ooa.product_id
		from or_order oo, OR_ORDER_ACTIVITY ooa
		where oo.order_id 	= INUORDERID
		and oo.order_id 	= ooa.order_id;

	-- Jira OSF-739
	--<<
	CURSOR cuEstadoProducto(inuProducto pr_product.product_id%TYPE) 
	IS
	  SELECT COUNT(1) VALIDACION
	  FROM   servsusc
	  WHERE  sesunuse = inuProducto 
	  AND (SESUESCO = 5 OR sesuesfn = 'C');

	blEstaCastigado       	boolean;
	blGeneraComentario    	boolean:= FALSE;
	nuValidacion          	number;
	isbOrderComme         	varchar2(4000) := 'No se generaron tramites adicionales, porque el estado de corte del producto es igual a [5 - SUSPESIÓN TOTAL] y/o su estado financiero es igual a CASTIGADO';
	nuCommentType         	number := 1277;
	nuErrorCode           	number;
	sbErrorMesse          	varchar2(4000);
	-->>

	NUEXISTE      number; --establecer el resultado del nuevo cursor.
	NUTASKTYPEID  number; --establecer el tipo de trabajo de la orden legalizada.
	NUPRODUCTID   number; --establecer el producto de la orden legalizada.
	SBVALTIPOSUSP varchar2(10); --establecer el tipo de suspensión del producto.
	------------------------------------
	
	/******************************************************************************************************************************
	Autor       : Jhon Eduar Erazo Guachavez
	Fecha       : 15/11/2024
	Descripcion : Procedimiento que realiza el envio de correos, 
				  si la causal de legalización es de exito

	Parametros Entrada
		isbMensajeEnviar	Mensaje a enviar

	Valor de salida

	HISTORIA DE MODIFICACIONES
	FECHA        AUTOR   		DESCRIPCION
	15/11/2024	 jeerazomvm		OSF:3571: Creación
	*******************************************************************************************************************************/
	PROCEDURE prcEnviaCorreo(isbMensajeEnviar 	IN VARCHAR2)
	IS
		
		csbMetodoEnviaCorreo        CONSTANT VARCHAR2(70) 	:= csbMetodo || '.prcEnviaCorreo';
		csbSender   				VARCHAR2(2000) 			:= 'smartflex@gascaribe.com';
		csbSubject					VARCHAR2(2000)			:= 'Error! PLUGIN: Crea trámite correspondiente de RP';
	
		nuErrorEnviaCorreo			NUMBER;
		sbErrorMesseEnviaCorreo		VARCHAR2(4000);
		sbCorreos_creatramite_rp	VARCHAR2(4000)	:= NULL;
		
		
	BEGIN
	
		pkg_traza.trace(csbMetodoEnviaCorreo, csbNivelTraza, csbInicio);
		
		pkg_traza.trace('isbMensajeEnviar: ' 	|| isbMensajeEnviar, csbNivelTraza); 	
		
		-- Obtiene los correos configurados en el parametro CORREOS_PLUGIN_CREATRAMITE_RP
		sbCorreos_creatramite_rp 	:= pkg_parametros.fsbgetvalorcadena('CORREOS_PLUGIN_CREATRAMITE_RP');
		pkg_traza.trace('sbCorreos_creatramite_rp: ' || sbCorreos_creatramite_rp, csbNivelTraza); 
							
		-- Envia el error por correo
		pkg_Correo.prcEnviaCorreo(isbRemitente 		=> csbSender,
								  isbDestinatarios 	=> sbCorreos_creatramite_rp,
								  isbAsunto 		=> csbSubject,
								  isbMensaje		=> isbMensajeEnviar
								  );	
		
		pkg_traza.trace(csbMetodoEnviaCorreo, csbNivelTraza, pkg_traza.csbFIN);
	
	EXCEPTION
		WHEN pkg_error.controlled_error THEN
			RAISE;
		WHEN OTHERS THEN
			pkg_Error.setError;
			pkg_Error.getError(nuErrorEnviaCorreo, sbErrorMesseEnviaCorreo);
			pkg_traza.trace(csbMetodoEnviaCorreo ||' osbErrorMessage: ' || sbErrorMesseEnviaCorreo, csbNivelTraza);
			pkg_traza.trace(csbMetodoEnviaCorreo, csbNivelTraza, pkg_traza.csbFIN_ERR);		
	END prcEnviaCorreo;

BEGIN

	pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

	-- Obtiene la orden
	nuorderid     := pkg_bcordenes.fnuObtenerOTInstanciaLegal;
	pkg_traza.trace('nuorderid: ' || nuorderid, csbNivelTraza); 
	
	-- Obtiene la causal de legalizacion de la orden
	nucausalid    := pkg_bcordenes.fnuobtienecausal(nuorderid);
	pkg_traza.trace('nucausalid: ' || nucausalid, csbNivelTraza); 	
	
	IF CUDATAORDEN%ISOPEN THEN
		CLOSE CUDATAORDEN;
	END IF;
		
	-- Obtiene el tipo de trabajo y producto de la orden
	open CUDATAORDEN(nuorderid);
	fetch CUDATAORDEN into NUTASKTYPEID, NUPRODUCTID;
	close CUDATAORDEN;
	
	pkg_traza.trace('NUTASKTYPEID: ' || NUTASKTYPEID, csbNivelTraza); 
	pkg_traza.trace('NUPRODUCTID: ' || NUPRODUCTID, csbNivelTraza); 

	-- Valida si el producto es suspendido desde centro de medicion o acometida
	SBVALTIPOSUSP := LDC_FSBVALIDASUSPCEMOACOMPROD(NUPRODUCTID);
	pkg_traza.trace('SBVALTIPOSUSP: ' || SBVALTIPOSUSP, csbNivelTraza); 	

	-- Obtiene el valor del parametro TITR_CAUSAL_OTSUSPENSION
	sbCausparam := PKG_BCLDC_PARAREPE.FSBOBTIENEVALORCADENA('TITR_CAUSAL_OTSUSPENSION');
	pkg_traza.trace('sbCausparam: ' || sbCausparam, csbNivelTraza); 

    IF sbCausparam IS NULL THEN
		pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,
								  'No existe datos para el parametro "TITR_CAUSAL_OTSUSPENSION", definalos por el comando LDCPARP'
								  );
    END IF;

    --Inicio CASO 602
	IF CUVALIDACAUTIPTRA%ISOPEN THEN
		CLOSE CUVALIDACAUTIPTRA;
	END IF;
		
	-- Valida si el tipo de trabajo y causal, está configurados en el parametro TITR_CAUSAL_OTSUSPENSION
	open CUVALIDACAUTIPTRA(NUTASKTYPEID, 
						   nucausalid, 
						   sbCausparam
						   );
	fetch CUVALIDACAUTIPTRA into NUEXISTE;
	close CUVALIDACAUTIPTRA;
	
	pkg_traza.trace('NUEXISTE: ' || NUEXISTE, csbNivelTraza); 
	
	-- Obtiene la clase de causal de legalización
	nuClaseCausal	:= pkg_bcordenes.fnuObtieneClaseCausal(nucausalid);
	pkg_traza.trace('nuClaseCausal: ' || nuClaseCausal, csbNivelTraza); 
	
	IF cucomment%ISOPEN THEN
		CLOSE cucomment;
	END IF;
	
	-- Valida si el tipo de comentario es el configurado en el parametro PARAM_TIPOCOMENT_OTSUSPSOLSAC
	OPEN cucomment(nuorderid);
	FETCH cuComment INTO nucount;
	
	IF cuComment%NOTFOUND THEN
		nucount := 0;
	END IF;
	CLOSE cuComment;
	
	pkg_traza.trace('nucount: ' || nucount, csbNivelTraza); 

    IF cuEstadoProducto%ISOPEN THEN
		CLOSE cuEstadoProducto;
    END IF;

    -- Valida que el estado de corte del producto sea 5 y el estado financiero sea C
	OPEN  cuEstadoProducto(NUPRODUCTID);
    FETCH cuEstadoProducto INTO nuValidacion;
    close cuEstadoProducto;
	
	pkg_traza.trace('nuValidacion: ' || nuValidacion, csbNivelTraza); 

    IF (nuValidacion > 0) THEN
		blEstaCastigado := true;
    ELSE
		blEstaCastigado := false;
    END IF;

	IF NUCOUNT >= 1 AND NUEXISTE = 1 THEN
	
		IF SBVALTIPOSUSP = 'CM' OR SBVALTIPOSUSP IS NULL THEN
		
			IF (blEstaCastigado) THEN
				-- Adiciona comentario en la orden
                blGeneraComentario := TRUE;
            ELSE
				BEGIN
				
					pkg_traza.trace('Inicia LDCPROCCREATRAMFLUJSACXML', csbNivelTraza); 
					
					SAVEPOINT LDCPROCCREATRAMFLUJSACXML;
				
					-- El producto NO se encuentra [5 - SUSPESIÓN TOTAL] y/o [C - CASTIGADO]
					LDCPROCCREATRAMFLUJSACXML;
					
					pkg_traza.trace('Termina LDCPROCCREATRAMFLUJSACXML', csbNivelTraza); 
					
				EXCEPTION
					WHEN pkg_error.CONTROLLED_ERROR THEN
						pkg_error.setError;
						pkg_Error.getError(nuErrorCode, sbErrorMesse);
						pkg_traza.trace('LDCPROCCREATRAMFLUJSACXML nuErrorCode: ' || nuErrorCode || ' sbErrorMesse: ' || sbErrorMesse, csbNivelTraza);
						pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC); 
						IF (nuClaseCausal = 1) THEN
							prcEnviaCorreo(sbErrorMesse);
							ROLLBACK TO SAVEPOINT LDCPROCCREATRAMFLUJSACXML;
						ELSE
							RAISE pkg_error.CONTROLLED_ERROR;
						END IF;
					WHEN others THEN
						pkg_Error.setError;
						pkg_Error.getError(nuErrorCode, sbErrorMesse);
						pkg_traza.trace('LDCPROCCREATRAMFLUJSACXML nuErrorCode: ' || nuErrorCode || ' sbErrorMesse: ' || sbErrorMesse, csbNivelTraza);
						pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
						IF (nuClaseCausal = 1) THEN
							prcEnviaCorreo(sbErrorMesse);
							ROLLBACK TO SAVEPOINT LDCPROCCREATRAMFLUJSACXML;
						ELSE
							RAISE pkg_error.CONTROLLED_ERROR;
						END IF;
				END;
            END IF;
			
        ELSE
		
			IF SBVALTIPOSUSP = 'AC' THEN
			
				IF (blEstaCastigado) THEN
					-- Adiciona comentario en la orden
                    blGeneraComentario := TRUE;
                ELSE
					BEGIN
				
						pkg_traza.trace('Inicia LDCPROCREATRAMRECSINCERTXML', csbNivelTraza); 
						
						SAVEPOINT LDCPROCREATRAMRECSINCERTXML;
					
						-- El producto NO se encuentra [5 - SUSPESIÓN TOTAL] y/o [C - CASTIGADO]
						LDCPROCREATRAMRECSINCERTXML(NUORDERID);
					
						pkg_traza.trace('Termina LDCPROCREATRAMRECSINCERTXML', csbNivelTraza); 
					
					EXCEPTION
						WHEN pkg_error.CONTROLLED_ERROR THEN
							pkg_error.setError;
							pkg_Error.getError(nuErrorCode, sbErrorMesse);
							pkg_traza.trace('LDCPROCREATRAMRECSINCERTXML nuErrorCode: ' || nuErrorCode || ' sbErrorMesse: ' || sbErrorMesse, csbNivelTraza);
							pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC); 
							IF (nuClaseCausal = 1) THEN
								prcEnviaCorreo(sbErrorMesse);
								ROLLBACK TO SAVEPOINT LDCPROCCREATRAMFLUJSACXML;
							ELSE
								RAISE pkg_error.CONTROLLED_ERROR;
							END IF;
						WHEN others THEN
							pkg_Error.setError;
							pkg_Error.getError(nuErrorCode, sbErrorMesse);
							pkg_traza.trace('LDCPROCREATRAMRECSINCERTXML nuErrorCode: ' || nuErrorCode || ' sbErrorMesse: ' || sbErrorMesse, csbNivelTraza);
							pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
							IF (nuClaseCausal = 1) THEN
								prcEnviaCorreo(sbErrorMesse);
								ROLLBACK TO SAVEPOINT LDCPROCCREATRAMFLUJSACXML;
							ELSE
								RAISE pkg_error.CONTROLLED_ERROR;
							END IF;							
					END;
					
                END IF;
				
            END IF;
			
        END IF;
	ELSE
		-- Se valida si la orden esta marcada con el comentario
        IF nucount >= 1 THEN
			IF (blEstaCastigado) THEN
				-- Adiciona comentario en la orden
                blGeneraComentario := TRUE;
            END IF;
        END IF;
    END IF;

	-- Jira OSF-739
	IF (blGeneraComentario) THEN
		-- Adiciona comentario en la orden
        api_addordercomment(inuOrderId       => nuorderid,
                            inuCommentTypeId => nuCommentType,
                            isbComment       => isbOrderComme,
                            onuErrorCode     => nuErrorCode,
                            osbErrorMessage  => sbErrorMesse
							);
							
        IF (nuErrorCode <> 0) THEN
            pkg_error.setError;
            RAISE pkg_error.controlled_error;
        END IF;
		
	END IF;

	sbmensa := 'Proceso termin? Ok.';
	
	pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

EXCEPTION
	WHEN pkg_error.controlled_error THEN
		RAISE;
	WHEN OTHERS THEN
		pkg_Error.setError;
		pkg_Error.getError(nuErrorCode, sbErrorMesse);
		pkg_traza.trace(csbMetodo ||' osbErrorMessage: ' || sbErrorMesse, csbNivelTraza);
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
		
END LDCCREAFLUJOSRPSUSADMARSOLSAC;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDCCREAFLUJOSRPSUSADMARSOLSAC
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCCREAFLUJOSRPSUSADMARSOLSAC', 'ADM_PERSON'); 
END;
/