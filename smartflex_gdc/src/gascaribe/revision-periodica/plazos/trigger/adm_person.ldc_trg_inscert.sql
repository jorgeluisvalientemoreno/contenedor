CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_INSCERT

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_TRG_INSCERT
  Descripcion    : Disparador que inserta certificado de a nivel de producto cuando ingresa un certificado de OIA
  Autor          : Sayra Ocoro
  Fecha          : 28/05/2013

  Historia de Modificaciones
  Fecha         Autor             	Modificacion
  ==========    =========         	====================
  17/08/2022	cgonzalez			OSF-505: Se ajusta para ejecutarse logica cuando el estado anterior del certificado es I - Inicial
  17/06/2022	cgonzalez			OSF-357: Cuando un producto este marcado como vacio interno se le asigna vigencia de 3 años
  20/09/2020    OL-Software         Se adiciona logica para obtener la actividad de la tabla
                                    LDC_RESUINSP a partir del tipo de inspeccion
  06/04/2018   SEBTAP.REQ.2001572   Se aplican nuevas validaciones para servicios nuevos
  ******************************************************************/
  AFTER update OR INSERT on ldc_certificados_oia
  for each row

declare
  --PRAGMA AUTONOMOUS_TRANSACTION; --TICKET 200-1237 LJLB-- se desactiva opcion de proceso autonomo

  nuTaskTypeId or_task_type.task_type_id%type;
  nuActivityId ge_items.items_id%type;
  nuCausalId   ge_causal.causal_id%type;

  nuProductId       pr_product.product_id%type;
  nuAddressId       ab_address.address_id%type;
  onuErrorCode      number;
  osbErrorMessage   varchar2(2000);
  onuOrderId        or_order.order_id%type;
  nuOperatingUnitId or_operating_unit.operating_unit_id%type;
  nuPersonId        or_operating_unit.PERSON_IN_CHARGE%type;
  rcCertificate     dapr_certificate.stypr_certificate; --pr_certificate%rowtype;
  nuOrderActivity   or_order_activity.order_activity_id%type;
  dtReviewDate      date;
  nuMesesCert       number;

  NUDURATIONREVIEW NUMBER := NVL(GE_BOPARAMETER.FNUGET('REVIEW_DURATION',
                                                       null),
                                 5) * 12;
  dtRegisterDate   date;
  nuoperatingdummy or_operating_unit.operating_unit_id%type;

  -------------------
  --REQ.2001572 -->
  -------------------
  -- Cursor para validar existencia de valores en parametros separados por coma
  CURSOR cu_Parameter(inuvalor    NUMBER,
                      sbParameter ld_parameter.parameter_id%TYPE) IS
    SELECT COUNT(1) CANTIDAD
      FROM DUAL
     WHERE inuvalor IN
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(sbParameter,
                                                                                       NULL),
                                                      ',')));
  -- Variable para almacenar el resultado del cursor.
  nuExistParameter NUMBER := 0;
  -------------------
  --REQ.2001572 <--
  -------------------

  --Caso 404
    CURSOR cuGetActividadInspeccion(inuTipoInspeccion IN LDC_RESUINSP.codigo%type)
    IS
        SELECT ACTIVIDAD_GENERAR
        FROM LDC_RESUINSP
        WHERE CODIGO = inuTipoInspeccion;
    
    sbCaso404 VARCHAR2(30) := '0000404';
	
	
	CURSOR cuGetPlazosCert(inuProducto IN ldc_plazos_cert.id_producto%TYPE)
    IS
        SELECT 	vaciointerno
        FROM 	ldc_plazos_cert
        WHERE 	id_producto = inuProducto;
		
	sbVacioInterno ldc_plazos_cert.vaciointerno%TYPE;

begin
  ut_trace.trace('Inicio LDC_TRG_INSCERT', 10);
  -------------------
  --REQ.2001572 -->
  -------------------
  --Ejecutar el proceso solo si el certificado oia est? aprobado.
  /*Observacion.2001572
  Se agrega validacion para realizar el proceso, solo si el resultado de inspeccion es
  instalacion certificada e instalacion certificada parcial*/
  OPEN cu_Parameter(:new.resultado_inspeccion, 'COD_RESUL_INSPEC_OIA');
  FETCH cu_Parameter
    INTO nuExistParameter;
  IF cu_Parameter%NOTFOUND THEN
    nuExistParameter := 0;
  END IF;
  CLOSE cu_Parameter;
  if (:old.status_certificado = 'I' AND :new.status_certificado = 'A' AND nuExistParameter <> 0) then
    -------------------
    --REQ.2001572 <--
    -------------------
    --Obeter  par?metros
    nuTaskTypeId := dald_parameter.fnuGetNumeric_Value('LDC_TTCERTEXT',
                                                       null);
    if nuTaskTypeId is null then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'ERROR: NO SE HA CONFIGURADO VALOR NUMPERICO PARA EL    PAR?METRO LDC_TTCERTEXT');
      raise ex.CONTROLLED_ERROR;
    end if;
    --
    -------------------
    --REQ.2001572 -->
    -------------------
    /*Observacion.2001572
    Se agrega para definir la actividad para los tipos de inspeccion.
    --Si es de revision periodica o de servicios nuevos*/
  
    --Caso 404
    IF fblaplicaentregaxcaso(sbCaso404) THEN
    
        --Si aplica el caso 404
        OPEN cuGetActividadInspeccion(:NEW.tipo_inspeccion);
        FETCH cuGetActividadInspeccion INTO nuActivityId;
        CLOSE cuGetActividadInspeccion;
    
    
    ELSE

        nuExistParameter := 0; -- Setear la variable.
        OPEN cu_Parameter(:new.tipo_inspeccion, 'COD_CERTIF_REVIPERI_OIA');
        FETCH cu_Parameter
          INTO nuExistParameter;
        IF cu_Parameter%NOTFOUND THEN
          nuExistParameter := 0;
        END IF;
        CLOSE cu_Parameter;
        --Si existe asignamos la actividad para revision periodica.
        IF nuExistParameter = 1 THEN
          nuActivityId := dald_parameter.fnuGetNumeric_Value('LDC_ACTCERTEXT',
                                                             null);
        END IF;

        nuExistParameter := 0; -- Setear la variable.
        OPEN cu_Parameter(:new.tipo_inspeccion, 'COD_CERTIF_SERVNUEV_OIA');
        FETCH cu_Parameter
          INTO nuExistParameter;
        IF cu_Parameter%NOTFOUND THEN
          nuExistParameter := 0;
        END IF;
        CLOSE cu_Parameter;
        --Si existe asignamos la actividad para servicios nuevos.
        IF nuExistParameter = 1 THEN
          nuActivityId := dald_parameter.fnuGetNumeric_Value('COD_ACTIVIDAD_SERVINUEVOS',
                                                             null);
        END IF;
    
    END IF;
    -------------------
    --REQ.2001572 <--
    -------------------
    IF NOT fblaplicaentregaxcaso(sbCaso404) THEN
    
        if nuActivityId is null and :NEW.tipo_inspeccion in (1,2,3) then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'ERROR: NO SE HA CONFIGURADO VALOR DE LA ACTIVIDAD, VALIDAR PARAMETROS LDC_ACTCERTEXT Y COD_ACTIVIDAD_SERVINUEVOS');
          raise ex.CONTROLLED_ERROR;
        end if;
    
    END IF;
    --
    
    IF nuActivityId IS NOT NULL THEN
    
        nuCausalId := dald_parameter.fnuGetNumeric_Value('LDC_CAUSALEXITOCERTEXT',
                                                         null);
        if nuCausalId is null then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'ERROR: NO SE HA CONFIGURADO VALOR NUM?RICO PARA EL    PAR?METRO LDC_CAUSALEXITOCERTEXT');
          raise ex.CONTROLLED_ERROR;
        end if;
        --N?mero de meses de validez del certificado
        nuMesesCert := dald_parameter.fnuGetNumeric_Value('LDC_MESES_VALIDEZ_CERT',
                                                          null);
        if nuMesesCert is null then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'ERROR: NO SE HA CONFIGURADO VALOR NUM?RICO PARA EL    PAR?METRO LDC_MESES_VALIDEZ_CERT');
          raise ex.CONTROLLED_ERROR;
        end if;

        --------------FIN PARAMETRIZACI?N----------------------------------

        --1. Crear una orden de trabajo del tipo que se parametriz?
        nuProductId := :new.id_producto;
        nuAddressId := dapr_product.fnugetaddress_id(nuProductId, null);
        if nuAddressId is null then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'ERROR: NO SE ENCONTR? DIRECCI?N ASOCIADA AL PRODUCTO ' ||
                                           TO_CHAR(nuProductId));
          raise ex.CONTROLLED_ERROR;
        end if;
        os_createorderactivities(inuactivity        => nuActivityId,
                                 inuparsedaddressid => nuAddressId,
                                 idtexecdate        => sysdate + 1,
                                 isbcomment         => 'CERTIFICACI?N EXTERNA',
                                 ionuorderid        => onuOrderId,
                                 inureferencevalue  => null,
                                 onuerrorcode       => onuErrorCode,
                                 osberrormessage    => osbErrorMessage);
        if onuErrorCode <> 0 then
          --rollback;
          ge_boerrors.seterrorcodeargument(onuErrorCode, osbErrorMessage);
          raise ex.CONTROLLED_ERROR;
        end if;

        --Obtener el identificador de la unidad operativa externa que certific? el producto y  asignarle la orden de trabajo creada
        /* open cuUnidadCertificadora(nuProductId);
        fetch cuUnidadCertificadora into nuOperatingUnitId,dtReviewDate;
        close cuUnidadCertificadora;*/

        nuOperatingUnitId := :NEW.ID_ORGANISMO_OIA;
        dtReviewDate      := :NEW.FECHA_INSPECCION;
        nuPersonId        := :NEW.id_inspector;
        dtRegisterDate    := :NEW.FECHA_INSPECCION;
        os_assign_order(inuorderid         => onuOrderId,
                        inuoperatingunitid => nuOperatingUnitId,
                        idtarrangedhour    => sysdate + 1,
                        idtchangedate      => sysdate,
                        onuerrorcode       => onuErrorCode,
                        osberrormessage    => osbErrorMessage);
        if onuErrorCode <> 0 then
          nuoperatingdummy := null;
          begin
            select k.unidad_dummy
              INTO nuoperatingdummy
              from or_operating_unit b, ge_contratista m, ldc_unit_dummy_oia k
             where b.operating_unit_id = nuOperatingUnitId
               AND b.contractor_id = m.id_contratista
               AND m.id_contratista = k.id_contratista;
          exception
            when no_data_found then
              nuoperatingdummy := nuOperatingUnitId;
          end;
          if nuoperatingdummy is not null then
            onuErrorCode    := 0;
            osbErrorMessage := null;
            os_assign_order(inuorderid         => onuOrderId,
                            inuoperatingunitid => nuoperatingdummy,
                            idtarrangedhour    => sysdate + 1,
                            idtchangedate      => sysdate,
                            onuerrorcode       => onuErrorCode,
                            osberrormessage    => osbErrorMessage);
          end if;
          --rollback;
          --ge_boerrors.seterrorcodeargument(onuErrorCode,osbErrorMessage);
          if onuErrorCode <> 0 then
            raise ex.CONTROLLED_ERROR;
          end if;
        end if;
        --nuPersonId := daor_operating_unit.fnugetperson_in_charge(nuOperatingUnitId,null);

        if nuPersonId is null then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'ERROR: NO SE CONFIGUR? PERSONA A CARGO PARA LA UNIDAD OPERATIVA EXTERNA ' ||
                                           TO_CHAR(nuOperatingUnitId));
          raise ex.CONTROLLED_ERROR;
        end if;
        -- Asignar orden a t?cnico
        BEGIN
          insert into LDC_ASIG_OT_TECN
            (UNIDAD_OPERATIVA, TECNICO_UNIDAD, ORDEN)
          values
            (nuOperatingUnitId, nuPersonId, onuOrderId);
        EXCEPTION
          WHEN OTHERS THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'ERROR: NO FUE POSIBLE ASIGNAR ORDEN A T?CNICO');
            raise ex.CONTROLLED_ERROR;
        END;
        --Legalizar la orden

        os_legalizeorderallactivities(inuorderid        => onuOrderId,
                                      inucausalid       => nuCausalId,
                                      inupersonid       => nuPersonId,
                                      idtexeinitialdate => sysdate - 1,
                                      idtexefinaldate   => sysdate - 1,
                                      isbcomment        => 'Certificaci?n externa',
                                      idtchangedate     => sysdate,
                                      onuerrorcode      => onuErrorCode,
                                      osberrormessage   => osbErrorMessage);
        if onuErrorCode <> 0 then
          --rollback;
          --ge_boerrors.seterrorcodeargument(onuErrorCode,osbErrorMessage);
          raise ex.CONTROLLED_ERROR;
        end if;

        BEGIN

          --Insertar un registro en la entidad PR_CERTIFICATE para el producto que se est? certificando
          nuOrderActivity := ldc_bcfinanceot.fnuGetActivityId(onuOrderId);
          --Actualizar el identificador del producto de la orden
          daor_order_activity.updproduct_id(nuOrderActivity, nuProductId, null);
          rcCertificate.Certificate_Id := seq_pr_certificate_156806.nextval;
          rcCertificate.Product_Id     := nuProductId;
          rcCertificate.PACKAGE_ID     := -1;

          rcCertificate.Order_Act_Certif_Id := nuOrderActivity;
          rcCertificate.Register_Date       := dtRegisterDate;
          rcCertificate.Review_Date         := dtReviewDate;
          rcCertificate.Estimated_End_Date  := ADD_MONTHS(dtReviewDate,
                                                          NUDURATIONREVIEW);
          rcCertificate.Order_Act_Review_Id := nuOrderActivity;
          rcCertificate.END_DATE            := NULL;
          --Se anulan los certificados anteriores
          PR_BOCertificate.ANULLCERTIFICATE(nuProductId, nuOrderActivity);
          
		  --Validar si el producto presenta vacio interno
		  IF (daldc_pararepe.fsbgetparavast('ACT_FECHA_VACIO_INTERNO') = 'S') THEN
		  
		    OPEN cuGetPlazosCert(nuProductId);
			FETCH cuGetPlazosCert INTO sbVacioInterno;
			CLOSE cuGetPlazosCert;
			
			IF (sbVacioInterno = 'S') THEN
			  rcCertificate.Estimated_End_Date  := ADD_MONTHS(dtReviewDate, daldc_pararepe.fnugetparevanu('MESES_ACT_VACIO_INTERNO'));
			END IF;
		  END IF;
		  
		  --Se genera el nuevo certificado
          dapr_certificate.insrecord(ircpr_certificate => rcCertificate);
        EXCEPTION
          WHEN OTHERS THEN
            --rollback;
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'ERROR: AL INSERTAR CERTIFICADO ' ||
                                             sqlerrm);
            raise ex.CONTROLLED_ERROR;
        end;
        --  nui := nui + 1;

      end if;
  
  END IF;
  --COMMIT; --TICKET 200-1237 LJLB-- se desactiva opcion de commit
  /*if nui > 0 then
      COMMIT; --TICKET 200-1237 LJLB-- se desactiva opci CERTIFICADOS ACTUALIZADOS');
  else
    rollback;
  end if;*/

exception
  when ex.CONTROLLED_ERROR then
    Errors.geterror(onuErrorCode, osbErrorMessage);
    raise ex.CONTROLLED_ERROR;
  
end LDC_TRG_INSCERT;
/