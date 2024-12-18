CREATE OR REPLACE PROCEDURE ADM_PERSON.LDCPROCREATRAMITESRP(nuOrder or_order.order_id%type,
                                                 nuMarca ge_suspension_type.suspension_type_id%type,
                                                 nuSoli  mo_packages.package_id%type) AS
  /********************************************************************************************************
  Propiedad Intelectual de Gases del caribe S.A E.S.P
  
  Funcion     : LDCPROCREATRAMITESRP
  Descripcion : Procedimiento que crea el tramite de revision, reparacion y certificacion
                segun la marca del producto.
  
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  
  11/08/2021        Horbath         CA 767: se coloca llamado a funcion FBLGENERATRAMITEREPARA, para valida si el, 
                                    producto relacionado con la orden es apto para generar el trammite.
                                    Se recupera asignación del 147 que se vio afectada por el cambio 472
  25/11/2021        DANVAL          CA 833_1 : Validaciones del caso para la asignacion automatica de las unidades operativas de los datos adicionales definidos
  25/03/2022        JORVAL          OSF-146: Reemplazar el llamado del servicio ldc_boordenes.fsbDatoAdicTmpOrden 
                                              por el nuevo servicio LDC_FSBDATOADICIONAL
  22/04/2022        JORVAL          OSF-146: Se agrego el parametro GRUPOADICION_UNIDADOPER para estabelcer el grupo de datos adicional 
                                              al que pertenece el dato adicional donde queda la unidad de apoyo.
  30/10/2023        JSOTO			OSF-1845 Se reemplazan algunos objetos de producto por personalizados, se actualiza el manejo de errores y trazas por personalizados
									y otros ajustes contenidos en el caso.
  12/04/2024		jerazomvm		OSF-2570: 1. Se ajusta el substr del comentario, para que no supere el tamaño de 2000 caracteres.		
											  2. Se reemplaza el llamado de DALD_PARAMETER.FNUGETNUMERIC_VALUE por PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO
											  3. Se reemplaza el llamado de DALD_PARAMETER.FSBGETVALUE_CHAIN por PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA
  02/05/2024        PACOSTA         OSF-2638: Se crea el objeto en el esquema adm_person                                                 
  *********************************************************************************************************/
 
  csbMT_NAME 	CONSTANT VARCHAR2(35):= 'ldcprocreatramitesrp';
  cnuNVLTRC 	CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
  csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;

  sbTipoTrabOperaRP ldc_pararepe.paravast%type := DALDC_PARAREPE.FSBGETPARAVAST('TIPOTRABAJO_OPERARP',
                                                                                     NULL);
  nuTipoTrabOperaRP number;
  nuTipoCausal      number;
  nuTipoTrabajo     number;
  sbDatoAdicional   ldc_pararepe.paravast%type := DALDC_PARAREPE.fsbGetPARAVAST('DATOADICION_UNIDADOPER',
                                                                                          NULL);
  nuCodDatoAdicic   ldc_pararepe.parevanu%type := DALDC_PARAREPE.fnuGetPAREVANU('COD_DATOADICION_UNIDADOPER',
                                                                                          NULL);                                                                                          
  NUUNITOPERADDDATA number := null;
  sbValorPRCDA      varchar2(2000);
  nuExisteOU        number;
  --
  --Jira 146
  nuGrupoAdicional   ldc_pararepe.parevanu%type := DALDC_PARAREPE.fnuGetPAREVANU('GRUPOADICION_UNIDADOPER',
                                                                                          NULL);
  ------------------------------------------
  CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
    SELECT pv.package_id colsolicitud
      FROM mo_packages pv, mo_motive mv
     WHERE pv.package_type_id IN
							   (SELECT regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('VAL_TIPO_PAQUETE_OTREV'), '[^,]+', 1, LEVEL)AS tipopack
								FROM dual
								CONNECT BY regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('VAL_TIPO_PAQUETE_OTREV'), '[^,]+', 1, LEVEL) IS NOT NULL)
       AND pv.motive_status_id =
           PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('ESTADO_SOL_REGISTRADA')
       AND mv.product_id = nucuproducto
       AND pv.package_id = mv.package_id;
  nuErrorCode         NUMBER;
  sbErrorMessage      VARCHAR2(4000);
  nuPackageId         mo_packages.package_id%type;
  nuMotiveId          mo_motive.motive_id%type;
  sbrequestxml1       constants_per.tipo_xml_sol%TYPE;
  nuorden             or_order.order_id%type;
  sbComment           VARCHAR2(2000);
  nuProductId         NUMBER;
  nuContratoId        NUMBER;
  nuTaskTypeId        NUMBER;
  nuCausalOrder       NUMBER;
  nupakageid          mo_packages.package_id%TYPE;
  nucliente           ge_subscriber.subscriber_id%TYPE;
  numediorecepcion    mo_packages.reception_type_id%TYPE;
  sbdireccionparseada ab_address.address_parsed%TYPE;
  nudireccion         ab_address.address_id%TYPE;
  nulocalidad         ab_address.geograp_location_id%TYPE;
  nucategoria         mo_motive.category_id%TYPE;
  nusubcategori       mo_motive.subcategory_id%TYPE;
  sw                  NUMBER(2) DEFAULT 0;
  nuparano            NUMBER(4);
  nuparmes            NUMBER(2);
  nutsess             NUMBER;
  sbparuser           VARCHAR2(30);
  sbmensa             VARCHAR2(10000);
  nuunidadoperativa   or_order.operating_unit_id%TYPE;
  sbflag              VARCHAR2(1);
  nucontacomponentes  NUMBER(4);
  nunumber            NUMBER(4) DEFAULT 0;
  nuprodmotive        mo_component.prod_motive_comp_id%TYPE;
  sbtagname           mo_component.tag_name%TYPE;
  nuclasserv          mo_component.class_service_id%TYPE;
  nucomppadre         mo_component.component_id%TYPE;
  rcComponent         damo_component.stymo_component;
  rcmo_comp_link      damo_comp_link.stymo_comp_link;
  sbsolicitudes VARCHAR2(1000);
  nuestadosol   mo_packages.motive_status_id%TYPE;
  nucontaexiste NUMBER(5);
  nuTipoSoli mo_packages.package_type_id%type;
  sbTipoSolic ld_parameter.value_chain%type := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('VAL_TIPO_PAQUETE_OTREV');
  ----767
  dtExecFinal     or_order.execution_final_date%TYPE;
  nuTiempoEsp     ldc_pararepe.parevanu%type := daldc_pararepe.fnuGetPAREVANU('TIEMPO_EJEC_LDCPROCREATRAMITESRP',
                                                                                        null);
  sbTitrReejecuta ldc_pararepe.paravast%type := ',' ||
                                                     daldc_pararepe.fsbGetPARAVAST('TITR_REEJECUTA_LDCPROCREATRAMITESRP',
                                                                                        null) || ',';
  sbWhat          VARCHAR2(4000);
  nuordenlega     NUMBER;
  nujob           NUMBER;
  sbRowid         VARCHAR2(4000) := NULL;
  
  sbProceso 	  VARCHAR2(70) := 'LDCPROCREATRAMITESRP'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
  --INICIO CA 147
  sbFlagasiAut VARCHAR2(1) := 'N';
  --FIN CA 147
  ------767

  --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
  CURSOR cuProducto(nuorden NUMBER) IS
    SELECT product_id,
           subscription_id,
           ot.task_type_id,
           oa.package_id,
           oa.subscriber_id,
           ot.operating_unit_id,
           m.motive_status_id estado_solicitud,
           execution_final_date /*caso: 767*/
      FROM or_order_activity oa, or_order ot, mo_packages m
     WHERE oa.order_id = nuorden
       AND oa.package_id IS NOT NULL
       AND oa.order_id = ot.order_id
       AND oa.package_id = m.package_id
       AND rownum = 1;
  -- Cursor para obtener los componentes asociados a un motivo
  CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
    SELECT COUNT(1) FROM mo_component c WHERE c.motive_id = nucumotivos;

  CURSOR cuTipoTrabOpera(inuTipoTrab or_task_type.task_type_id%TYPE,
                         isbTipoTrabOperaRP VARCHAR2) IS
      select count(1)
      from dual
     where inuTipoTrab in
					   (SELECT regexp_substr(isbTipoTrabOperaRP, '[^,]+', 1, LEVEL)AS tipotrab
						FROM dual
						CONNECT BY regexp_substr(isbTipoTrabOperaRP, '[^,]+', 1, LEVEL) IS NOT NULL);


  CURSOR cuDatosProducto(Inuproductid pr_product.product_id%TYPE) IS
      SELECT di.address_parsed,
             di.address_id,
             di.geograp_location_id,
             pr.category_id,
             pr.subcategory_id
        FROM pr_product pr, ab_address di
       WHERE pr.product_id = Inuproductid
         AND pr.address_id = di.address_id;
		 
  CURSOR cuCuentaAsig(inuunidadoperativa or_operating_unit.operating_unit_id%TYPE) IS
       SELECT COUNT(1)
        FROM or_operating_unit uo
        WHERE uo.operating_unit_id IN
								   (SELECT regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('VAL_UNIDAD_OPER_REGENERA'), '[^,]+', 1, LEVEL)AS unidad
									FROM dual
									CONNECT BY regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('VAL_UNIDAD_OPER_REGENERA'), '[^,]+', 1, LEVEL) IS NOT NULL)
        AND uo.operating_unit_id = inuunidadoperativa;

 --
BEGIN

  pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);

  --Obtener el identificador de la orden  que se encuentra en la instancia
  nuorden := nuOrder;
  pkg_traza.trace('Numero de la Orden:' || nuorden, cnuNVLTRC);
  nucausalorder := pkg_bcordenes.fnuObtieneCausal(nuorden);
  -- Consultamos datos para inicializar el proceso
  
  pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

  pkg_estaproc.prActualizaEstaproc(sbProceso,'En Ejecucion','Nuot[' || nuorden || ']');
  
   --CA 833_1
    /*Si el Tipo de Trabajo está definido en el  Parámetro TIPOTRABAJO_OPERARP y la causal es de éxito*/
    nuExisteOU := 0;
    sbValorPRCDA := LDC_FSBDATOADICIONAL(nuorden,sbDatoAdicional,nuGrupoAdicional); 
    if sbValorPRCDA is not null then
       nuUnitOperAdddata := to_number(sbValorPRCDA);
       if pkg_bcunidadoperativa.fblExiste(nuUnitOperAdddata ) then
          nuExisteOU :=1;
       else
          nuExisteOU :=0;
          sbmensa := 'Proceso termino con errores : La Unidad Operativa [' ||
                     NUUNITOPERADDDATA ||
                     '] registrada en el Dato Adicional [' ||
                     sbDatoAdicional || '] no existe';
          pkg_error.setErrorMessage(ld_boconstans.cnugeneric_error,
                                           sbmensa);
       end if;
    end if;

    nuTipoTrabajo := pkg_bcordenes.fnuObtieneTipoTrabajo(nuorden);

	IF cuTipoTrabOpera%ISOPEN THEN
		CLOSE cuTipoTrabOpera;
	END IF;
	
	OPEN cuTipoTrabOpera(nuTipoTrabajo,sbTipoTrabOperaRP);
	FETCH cuTipoTrabOpera INTO nuTipoTrabOperaRP;
	CLOSE cuTipoTrabOpera;
	
       
      nuTipoCausal := pkg_bcordenes.fnuObtieneClaseCausal(nucausalorder);

  --
  -- obtenemos el producto y el paquete
  OPEN cuproducto(nuorden);
  FETCH cuProducto
    INTO nuproductid,
         nucontratoid,
         nutasktypeid,
         nupakageid,
         nucliente,
         nuunidadoperativa,
         nuestadosol,
         dtExecFinal;
  IF cuProducto%NOTFOUND THEN
    sbmensa := 'Nuot[' || nuorden || ']Proceso termino con errores : ' ||
               'El cursor cuProducto no arrojo datos con el # de orden' ||
               to_char(nuorden);
			   
	pkg_estaproc.prActualizaEstaproc(sbProceso,'ok',sbmensa);		   
	
  END IF;
  CLOSE cuproducto;
  pkg_traza.trace('Salio cursor cuProducto, nuProductId: ' || nuProductId ||
                 'nuContratoId:' || 'nuTaskTypeId:' || nuTaskTypeId,
                 cnuNVLTRC);
  --Inicio caso:0000767
  -- Se valida si el producto de la orden es apto para generar tramite de rp
  --CA 833_1 se añade validacion con variable para validar de entrega 767
  IF NUUNITOPERADDDATA is null THEN
    IF FBLGENERATRAMITEREPARA(nutasktypeid, nuProductId, dtExecFinal) =
       FALSE THEN
      begin
        nuordenlega := pkg_bcordenes.fnuObtenerOTInstanciaLegal;
      exception
        when others then
          nuordenlega := null;
      end;
      if nuordenlega is not null then
        if instr(sbTitrReejecuta,
                 ',' ||
                 pkg_bcordenes.fnuObtieneTipoTrabajo(nuordenlega) || ',') > 0 then
          sbWhat := ' BEGIN ' || chr(10) || '   LDCPROCREATRAMITESRP(' ||
                    nuOrder || ',' || nuMarca || ',' || nuSoli || ');' ||
                    chr(10) ||
                    ' exception when others then  pkg_error.SetError; ' ||
                    chr(10) || 'END;';
          dbms_job.submit(nujob, sbWhat, sysdate + nuTiempoEsp / 1440); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
          sbmensa := 'OT:' || nuorden ||
                     '.Usuario vencido no se genera tramite. Se programa job ' ||
                     nujob;
        else
          sbmensa := 'OT:' || nuorden ||
                     '.Usuario vencido no se genera tramite : ';
        end if;
      else
        sbmensa := 'OT:' || nuorden ||
                   '.Usuario vencido no se genera tramite : ';
      end if;
    
  	  pkg_estaproc.prActualizaEstaproc(sbProceso,'ok',sbmensa);		   

      GOTO NoGeneraRp;
    END IF;
  END IF;
  --fin caso:0000767

  -- Buscamos solicitudes de revisi?n periodica generadas
  nuTipoSoli := pkg_bcsolicitudes.fnuGetTipoSolicitud(nuSoli);
  update ld_parameter
     set value_chain = replace(value_chain, nuTipoSoli, '0')
   where parameter_id = 'VAL_TIPO_PAQUETE_OTREV';
  sbsolicitudes := NULL;
  FOR i IN cusolicitudesabiertas(nuproductid) LOOP
    IF sbsolicitudes IS NULL THEN
      sbsolicitudes := i.colsolicitud;
    ELSE
      sbsolicitudes := sbsolicitudes || ',' || to_char(i.colsolicitud);
    END IF;
  END LOOP;
  IF TRIM(sbsolicitudes) IS NULL THEN
    -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico
    sbdireccionparseada := NULL;
    nudireccion         := NULL;
    nulocalidad         := NULL;
    nucategoria         := NULL;
    nusubcategori       := NULL;
    sw                  := 1;
	
    BEGIN

	IF cuDatosProducto%ISOPEN THEN
		CLOSE cuDatosProducto;
	END IF;

	OPEN cuDatosProducto(nuproductid);
	FETCH cuDatosProducto INTO
			sbdireccionparseada,
            nudireccion,
            nulocalidad,
            nucategoria,
            nusubcategori;
	IF cuDatosProducto%NOTFOUND THEN
		CLOSE cuDatosProducto;
		RAISE no_data_found;
	END IF;
	CLOSE cuDatosProducto;

    EXCEPTION
      WHEN no_data_found THEN
        sw := 0;
    END;
    IF sw = 1 THEN
      IF numarca = ldcfncretornamarcarevprp THEN
        --200-1662
        sbcomment := substr(ldc_retornacomentotlega(nuorden), 1, 1800) ||
                     ' ord?n legalizada : ' || to_char(nuorden) ||
                     ' con causal : ' || to_char(nucausalorder) ||
                     ' SE GENERO SOLICITUD VISITA_IDENTIFICACION_CERTIFICADO';
        --200-1662
        numediorecepcion := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('MEDIO_RECEPCION_VISITA');
		
		sbrequestxml1 := pkg_xml_soli_rev_periodica.getSolicitudRevisionRp(
																 numediorecepcion,
																 sbcomment,
																 nuproductid,
																 nucliente
																 );
      ELSIF numarca in (ldcfncretornamarcarepprp, ldcfncretornamarcadefcri) THEN
        sbcomment        := substr(ldc_retornacomentotlega(nuorden),
                                   1,
                                   1800) || ' ord?n legalizada : ' ||
                            to_char(nuorden) || ' con causal : ' ||
                            to_char(nucausalorder) ||
                            ' SE GENERO SOLICITUD REPARACION PRP.';
        numediorecepcion := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('MEDIO_RECEPCION_REPARACION_PRP');
		
		sbrequestxml1 := pkg_xml_soli_rev_periodica.getSolicitudReparacionRp(
																	numediorecepcion,
																	sbComment,
																	nuproductid,
																	nucliente
																   );
																	
        --INICIO CA 147
        IF nutasktypeid = 12460 THEN
          sbFlagasiAut := 'S';
        END IF;
        --FIN CA 147
      ELSIF numarca = ldcfncretornamarcacerprp THEN
        sbcomment        := substr(ldc_retornacomentotlega(nuorden),
                                   1,
                                   1800) || ' ord?n legalizada : ' ||
                            to_char(nuorden) || ' con causal : ' ||
                            to_char(nucausalorder) ||
                            ' SE GENERO SOLICITUD CERTIFICACION PRP.';
        numediorecepcion := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('MEDIO_RECEPCION_CERT_PRP');
		
		sbrequestxml1:=  pkg_xml_soli_rev_periodica.getXMSolicitudCertificacionRp(
																		numediorecepcion,
																		sbComment,
																		nuproductid,
																		nucliente
																		);
																		
      END IF;
      -- Generamos la solicitud y la orden de trabajo
      nupackageid    := NULL;
      numotiveid     := NULL;
      nuerrorcode    := NULL;
      sberrormessage := NULL;
      IF numarca IN (ldcfncretornamarcarevprp,
                     ldcfncretornamarcadefcri,
                     ldcfncretornamarcarepprp,
                     ldcfncretornamarcacerprp) THEN
        api_registerRequestByXml(sbrequestxml1,
                                 nupackageid,
                                 numotiveid,
                                 nuerrorcode,
                                 sberrormessage);
        IF nupackageid IS NULL THEN
          sbmensa := 'Nuot[' || nuorden ||
                     ']Proceso termino con errores : ' ||
                     'Error al generar la solicitud. Codigo error : ' ||
                     to_char(nuerrorcode) || ' Mensaje de error : ' ||
                     sberrormessage;
					 
		  pkg_estaproc.prActualizaEstaproc(sbProceso,'ok',sbmensa);		   

        ELSE
          --CA 833_1
          /*Se registrará en la tabla LDC_ORDENTRAMITERP la Orden legalizada, Tipo de Trabajo de la orden, Causal de legalización de la orden, el Id de la Solicitud Generada y el NUUNITOPERADDDATA (Unidad Operativa del dato adicional)*/
          IF (nuTipoTrabOperaRP > 0 and nuTipoCausal = 1) THEN
            if NUUNITOPERADDDATA is not null then
              insert into LDC_ORDENTRAMITERP
                (ORDEN, TIPOTRABAJO, CAUSAL, SOLICITUD, UNIDADOPERA)
              values
                (nuorden,
                 nuTipoTrabajo,
                 nucausalorder,
                 nupackageid,
                 NUUNITOPERADDDATA);
            end if;
          end if;
          -- Consultamos si el motivo generado tiene asociado los componentes
          IF numarca in
             (ldcfncretornamarcarepprp, ldcfncretornamarcadefcri) THEN
            OPEN cuComponente(numotiveid);
            FETCH cuComponente
              INTO nucontacomponentes;
            CLOSE cuComponente;
            -- Si el motivo no tine los componentes asociados, se procede a registrarlos
            IF (nucontacomponentes = 0) THEN
              FOR i IN (SELECT kl.*
                          FROM pr_component kl
                         WHERE kl.product_id = nuProductId
                           AND kl.component_status_id <> 9
                         ORDER BY kl.component_type_id) LOOP
                IF i.component_type_id = 7038 THEN
                  nunumber     := 1;
                  nuprodmotive := 10346;
                  sbtagname    := 'C_GAS_10346';
                  nuclasserv   := NULL;
                ELSIF i.component_type_id = 7039 THEN
                  nunumber     := 2;
                  nuprodmotive := 10348;
                  sbtagname    := 'C_MEDICION_10348';
                  nuclasserv   := 3102;
                END IF;
                rcComponent.component_id         := mo_bosequences.fnugetcomponentid();
                rcComponent.component_number     := nunumber;
                rcComponent.obligatory_flag      := 'N';
                rcComponent.obligatory_change    := 'N';
                rcComponent.notify_assign_flag   := 'N';
                rcComponent.authoriz_letter_flag := 'N';
                rcComponent.status_change_date   := SYSDATE;
                rcComponent.recording_date       := SYSDATE;
                rcComponent.directionality_id    := 'BI';
                rcComponent.custom_decision_flag := 'N';
                rcComponent.keep_number_flag     := 'N';
                rcComponent.motive_id            := numotiveid;
                rcComponent.prod_motive_comp_id  := nuprodmotive;
                rcComponent.component_type_id    := i.component_type_id;
                rcComponent.motive_type_id       := 75;
                rcComponent.motive_status_id     := 15;
                rcComponent.product_motive_id    := 100304;
                rcComponent.class_service_id     := nuclasserv;
                rcComponent.package_id           := nupackageid;
                rcComponent.product_id           := i.product_id;
                rcComponent.service_number       := i.product_id;
                rcComponent.component_id_prod    := i.component_id;
                rcComponent.uncharged_time       := 0;
                rcComponent.product_origin_id    := i.product_id;
                rcComponent.quantity             := 1;
                rcComponent.tag_name             := sbtagname;
                rcComponent.is_included          := 'N';
                rcComponent.category_id          := nucategoria;
                rcComponent.subcategory_id       := nusubcategori;
                damo_component.Insrecord(rcComponent);
                UPDATE pr_component fx
                   SET fx.category_id    = nucategoria,
                       fx.subcategory_id = nusubcategori
                 WHERE fx.component_id = i.component_id;
                IF i.component_type_id = 7038 THEN
                  nucomppadre := rcComponent.component_id;
                END IF;
                IF (nuMotiveId IS NOT NULL) THEN
                  rcmo_comp_link.child_component_id := rcComponent.component_id;
                  IF i.component_type_id = 7039 THEN
                    rcmo_comp_link.father_component_id := nucomppadre;
                  ELSE
                    rcmo_comp_link.father_component_id := NULL;
                  END IF;
                  rcmo_comp_link.motive_id := nuMotiveId;
                  damo_comp_link.insrecord(rcmo_comp_link);
                END IF;
              END LOOP;
            END IF;
          END IF;
		  
		  IF cuCuentaAsig%ISOPEN THEN
			CLOSE cuCuentaAsig;
		  END IF;
		  
			-- Si la unidad operativa no debe asignar automatica, no se guarda el registro
		  OPEN cuCuentaAsig(nuunidadoperativa);
		  FETCH cuCuentaAsig INTO nucontaexiste;
		  CLOSE cuCuentaAsig;
		  
		
          sbflag := ldc_fsbretornaaplicaasigauto(nutasktypeid,
                                                 nucausalorder);
        
          IF (nvl(sbflag, 'N') = 'S' AND nucontaexiste = 0) OR
             sbFlagasiAut = 'S' THEN
            ldc_procrearegasiunioprevper(nuunidadoperativa,
                                         nuproductid,
                                         nutasktypeid,
                                         nuorden,
                                         nupackageid);
            IF sbFlagasiAut = 'S' THEN
              INSERT INTO LDC_BLOQ_LEGA_SOLICITUD
                (PACKAGE_ID_GENE)
              VALUES
                (nupackageid);
            END IF;
          END IF;
          sbmensa := 'Nuot[' || nuorden ||
                     ']Proceso termino Ok. Se genero la solicitud Nro : ' ||
                     to_char(nupackageid);
	  	  pkg_estaproc.prActualizaEstaproc(sbProceso,'ok',sbmensa);		   

        END IF;
      ELSE
        sbmensa := 'Nuot[' || nuorden ||
                   ']Proceso termino con Errores. Marca nro ' || numarca ||
                   ' no es valida.';
				   
		pkg_estaproc.prActualizaEstaproc(sbProceso,'ok',sbmensa);		   

      END IF;
    END IF;
  ELSE
    sbmensa := 'Nuot[' || nuorden ||
               ']Error al generar la solicitud para el producto : ' ||
               to_char(nuproductid) ||
               ' Tiene las siguientes solicitudes de revisi?n periodica en estado registradas : ' ||
               TRIM(sbsolicitudes);
			   
	pkg_estaproc.prActualizaEstaproc(sbProceso,'ok',sbmensa);		   

  END IF;

  update ld_parameter
     set value_chain = sbTipoSolic
   where parameter_id = 'VAL_TIPO_PAQUETE_OTREV';
  <<NoGeneraRp>> --caso:767  
  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

EXCEPTION
  WHEN pkg_error.controlled_error THEN
    update ld_parameter
       set value_chain = sbTipoSolic
     where parameter_id = 'VAL_TIPO_PAQUETE_OTREV';
    pkg_error.getError(nuErrorCode, sbmensa);
	pkg_estaproc.prActualizaEstaproc(sbProceso,'ok',sbmensa); 
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.fsbFIN_ERC); 
    RAISE;
  WHEN OTHERS THEN
    update ld_parameter
       set value_chain = sbTipoSolic
     where parameter_id = 'VAL_TIPO_PAQUETE_OTREV';
    sbmensa := 'Nuot[' || nuorden || ']Proceso termino con Errores. ' ||
               SQLERRM;
	pkg_estaproc.prActualizaEstaproc(sbProceso,'ok',sbmensa);		   
    pkg_error.seterror;
    pkg_traza.trace(csbMT_NAME||' :'||sbmensa, cnuNVLTRC); 
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.fsbFIN_ERR); 
    RAISE pkg_error.controlled_error;
END LDCPROCREATRAMITESRP;
/
PROMPT Otorgando permisos de ejecucion a LDCPROCREATRAMITESRP
BEGIN
    pkg_utilidades.praplicarpermisos('LDCPROCREATRAMITESRP', 'ADM_PERSON');
END;
/