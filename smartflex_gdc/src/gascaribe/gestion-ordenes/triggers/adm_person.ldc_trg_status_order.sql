create or replace TRIGGER ADM_PERSON.LDC_TRG_STATUS_ORDER
BEFORE UPDATE OF order_status_id ON or_order
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
  --
when (new.order_status_id in (5,7,8,6,11) )
Declare
  /*----------------------------------------------------------------*/
  /*

       HISTORIAL DE MODIFICACIONES
     =======================================
     FECHA           AUTOR             DESCRIPCIÓN
   =========      ===========       =======================
   11/05/2016    socoroCA200-228    Se adiciona modificación para validar forma de legalización
   05/08/2016    Caren Berdejo      CA 200-232 - Se agrega validacion para calcular la fecha estimada de
                                                 la orden y la actividad de la orden con lo ingresado en
                                                 la pantalla CMAOTA
   28/04/2017    Jorge Valiente     CASO 200-1234: Se modificara la logica de la variable sbexistrestr
                                                   para asignar N en caso que :new.order_status_id=:old.order_status_id
   04/07/2017    LJLB                se adiciona porceso que asigna contrato al moemnto de asignar la unidad operativas
                                     se adiciona proceso para validar fecha final del contrato definido al momomento de legalizar
   12/04/2019    horbath            caso 200-2391 se modifica para tener en los controles de los procesos de asignacion, bloqueo, desbloqueo,
                                    resignacion, anulacion,  legalizacion con fallo y legalizacion con exito de ordenes (esto aplicable solo a ordenes hijas),
                           utilizando parametro creado LDC_TITRVALREDES, lo siguiente:
                                    que valide si el tipo de trabajo de la orden hija (exista en el campo ORDEN_HIJA de la tabla LDC_ORDENES_OFERTADOS_REDES)
                                    que se este asignado, ejecutando o legalizando existe en el parametro LDC_TITRVALREDES, en caso que sea afirmativo,
                                    se llamara un  nuevo proceso PRVALIORDEN que se creara en el paquete LDC_PKGASIGNARCONT.
   17/04/2019    HORBATH            CASO 200-2391 Modificar el  trigger  LDC_TRG_STATUS_ORDER, para que en el momento de cambiar el estado a En Ejecucion,
                                    Ejecutada o legalizada a cualquier orden de trabajo, el sistema realice lo siguiente:
                                    Si se va a cambiar el estado a En Ejecucion o Ejecutada, el sistema no validara la fecha maxima de asignacion,
                                    ni la fecha final del contrato.
                                    Si se va a cambiar el estado de la orden a Legalizada, el sistema no validara la fecha maxima de asignacion,
                                    pero si controlara que la fecha de legalizacion sea menor a la fecha final del contrato (establecida en GE_Contrato).
                                    Estos cambios deben tener en cuenta los parametros definidos en el inciso anterior (tipos de contrato).
  20/03/2020	dsaltarin		    glpi 357 se modifica para que calcule los valores de los contratos en la resingación de redes									

   18/09/2020   HORBATH      CA 503 habilitar el estado 11 - bloqueado, para que cuando se este bloqueando una orden se quite el valor estimado
                                    cuando sea una orden de redes se mande y la asignacion viene de  un desbloqueo se envie el estado 11 al proceso de validacion
                                    cuando se reasigne una orden al mismo contratista se mantenga el contrato que se tiene en la orden
	23/02/2023	lvalencia			OSF-914 Se modifca el trigger para que al momento de asignar la orden se valida si la contrato tiene configurado 
									el tipo de trabajo. Adicionalmente de elimina aplica entrega							
	21/07/2023	jpinedc			    OSF-1300: * Se ejecuta ut_session.getmodule al inicio
                                    * Se reemplaza ge_boerrors.seterrorcodeargument ( hace raise interamente)
                                    por pkg_error.setErrorMessage
                                    * Se reemplaza errors.seterror ( no hace raise interamente)
                                    por pkg_error.setErrorMessage
                                    * Se reemplaza raise ex.controlled_error por
                                    pkg_error.CONTROLLED_ERROR
                                    * Se quitan raise después de pkg_error.setErrorMessage
                                    * Se reemplaza pkErrors.fsbGetApplication por 
                                    pkg_error.getApplication
                                    * Se borran variables que  no se usan
                                    * Se borra código en comentarios
                                    * Se cambia el signo de interrogación por
                                    el caractér correcto
  */
  /*----------------------------------------------------------------*/

    sbesexterna or_operating_unit.es_externa%Type;

    sbflagttnoliquidable Varchar2(2);

    Type rccontrato Is Record(
    contrato       ge_contrato.id_contrato%Type,
    tipo_contrato  ge_contrato.id_tipo_contrato%Type,
    fecha_final    ge_contrato.fecha_final%Type,
    estado         ge_contrato.status%Type,
    tt_en_contrato Varchar2(2));

    Type tytbcontrato Is Table Of rccontrato Index By Binary_Integer;
    tbcontrato    tytbcontrato;
    nuconcontrato Number;
    nucontvigente Number;

    -------CA 200-228
    sbactividades      ld_parameter.value_chain%Type;
    sbejecutables      ld_parameter.value_chain%Type;
    sbexecutable       sa_executable.name%Type;
    nuactividad        ge_items.items_id%Type;
    nuestadoejecutado  or_order.order_status_id%Type;
    nuestadolegalizado or_order.order_status_id%Type;
    nuestadoasignado   or_order.order_status_id%Type;
    nuorderactivity    or_order_activity.order_activity_id%Type;

    -------CA 200-232
    nuactivity_id       ge_items.items_id%Type;
    nudays              conf_metaasig.days%Type;
    nuorder_activity_id or_order_activity.order_activity_id%Type;
    sbcalendario        or_task_type.work_days%Type;
    dtfechaejecicon     or_order.exec_estimate_date%Type;
    -------
  
    csbEntrega2002391  CONSTANT VARCHAR2(100) := '200-2391';
    --Se valida si la actividad tiene restricciones en la forma OSF que esta procesando la orden
    sbexistrestr Varchar2(1) := open.ldc_fsbactiv_bloq_osf(to_number(:old.order_id),
                                                         :new.order_status_id);
    -------
    sbFlagAsignar  VARCHAR2(2) := 'N'; --TICKET 200-810 LJLB -- se almacena valor del parametro LDC_ASIGCONT
    nuOk NUMBER; --TICKET 200-810 LJLB -- se almacena estado del proceso
    sbError VARCHAR2(4000); --TICKET 200-810 LJLB -- se almacena error del proceso
    nuContratoAsignar ge_contrato.id_contrato%TYPE; --TICKET 200-810 LJLB -- se almacena contrato a asignar
    --- Caso 200-1138
    nucostopromconf   ldc_taskactcostprom.costo_prom%TYPE;
    nuactivicostprom  ldc_taskactcostprom.actividad%TYPE;
    rgreistcontrato   ge_contrato%ROWTYPE;
    nutotalvaidarasig ge_contrato.valor_total_contrato%TYPE DEFAULT 0;
    nuclasscausal     or_order.order_id%TYPE;
    nusumacosto       NUMBER;
    sbClasifItem      VARCHAR2(4000) :=  DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CLASITEMAEXCLUIR', NULL);
    noExiParTiCon 	number;

    CURSOR cuCostoProm IS
    SELECT vb.costo_prom
	FROM ldc_taskactcostprom vb
	WHERE vb.unidad_operativa = :new.operating_unit_id
	AND vb.tipo_trab        = :old.task_type_id
	AND vb.actividad        = nuactivicostprom;

    CURSOR cuCostoProMTodos IS
    SELECT vb.costo_prom
	FROM ldc_taskactcostprom vb
	WHERE vb.unidad_operativa  is NULL
	AND vb.tipo_trab        = :old.task_type_id
	AND vb.actividad        = nuactivicostprom;

	CURSOR cuNovedad IS
	SELECT LIQUIDATION_SIGN * o.VALUE_REFERENCE
	FROM ct_item_novelty ino, OR_ORDER_ACTIVITY o
	WHERE ino.items_id  = o.ACTIVITY_ID
	  AND NOT EXISTS (SELECT 1 FROM CT_EXCL_ITEM_CONT_VAL IE WHERE IE.ITEMS_ID = ino.items_id)
	  and o.order_id = :old.order_id;


	CURSOR cuNovedadCont IS
	SELECT COUNT(1)
	FROM ct_item_novelty ino, OR_ORDER_ACTIVITY o
	WHERE ino.items_id  = o.ACTIVITY_ID
	  and o.order_id = :old.order_id;

	nuIsNova NUMBER;

	CURSOR  cuNovedadRev IS
	SELECT LIQUIDATION_SIGN * o.VALUE_REFERENCE
	FROM ct_item_novelty ino, OR_ORDER_ACTIVITY o
	WHERE ino.items_id  = o.ACTIVITY_ID
	 and o.order_id = :old.order_id;

    nuOrenPadreRev NUMBER;

	CURSOR cuOrdenRela IS
	SELECT order_id
    FROM OR_RELATED_ORDER
    WHERE RELATED_ORDER_ID = :old.ORDER_ID
     AND RELA_ORDER_TYPE_ID = 15;

	--se consulta relacion de automatico
	CURSOR cuOrdenRelaAut IS
	SELECT order_id
    FROM OR_RELATED_ORDER
    WHERE RELATED_ORDER_ID = :old.ORDER_ID
     AND RELA_ORDER_TYPE_ID = 2;

	--se consulta relacion de automatico
	CURSOR cuGetOrdenPadre IS
	SELECT order_id, rela_order_type_id
    FROM OR_RELATED_ORDER
    WHERE RELATED_ORDER_ID = :old.ORDER_ID ;

	--se consulta si las unidades son de mismo contratista
	CURSOR cuConstratista IS
	SELECT 'X'
	FROM OR_OPERATING_UNIT
	WHERE CONTRACTOR_ID  = (
						  SELECT CONTRACTOR_ID
						  FROM OR_OPERATING_UNIT
						  WHERE OPERATING_UNIT_ID = :new.OPERATING_UNIT_ID)
		AND  OPERATING_UNIT_ID = :old.OPERATING_UNIT_ID;

	nuOrdePadr OR_ORDER.ORDER_ID%TYPE;
    nuTipoRelaP or_related_order.rela_order_type_id%type;

    sbtitrredes ld_parameter.value_chain%type;
    vasig or_order.Estimated_Cost%type;
    nerr number;
    serr varchar2(4000);

    nh number;
    vltr  varchar2(1);

	ohi LDC_ORDENES_OFERTADOS_REDES.ORDEN_hija%type;
	nuCostEstOtHija	number;
	nuActividadOt open.ge_items.items_id%type;

	nuEsHija	number;
    sbModule VARCHAR2(4000);
    sbExisteCont VARCHAR2(1);

    nuEstadoPadre	or_order.order_status_id%type;
    nuCausPadre   ge_causal.causal_id%type;

    nuexisteNieta number;
    nuExcBrilla NUMBER;
    sbActividTrasMate VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ACTIVIMATE',NULL);

    nuisTrasMate NUMBER;

    nuEstadoBloqueado NUMBER := dald_parameter.fnugetnumeric_value('COD_ESTA_BLOQ',
                                                        Null);

    nuestadoOrig NUMBER;
  
    CURSOR cugetEstaBlo IS
    SELECT INITIAL_STATUS_ID
    FROM (
        SELECT *
        FROM or_order_stat_change eo
        WHERE initial_status_id = 11 AND  final_status_id = 5
         AND  order_id = :NEW.order_id
         ORDER BY STAT_CHG_DATE DESC) EO
    WHERE ROWNUM = 1
     AND EXISTS (SELECT 1 
                 FROM  or_order_stat_change eo1 
                 WHERE eo.order_id = eo1.order_id 
                   AND eo1.initial_status_id = 0 AND  eo1.final_status_id = 5
                   AND eo1.stat_chg_date BETWEEN  eo.stat_chg_date AND eo.stat_chg_date + 5/24/60 );
    --FIN CA 503
Begin

	ut_trace.trace('Inicia LDC_TRG_STATUS_ORDER ', 10);
	
    --Obtener ejecutable
    Begin
      sbexecutable := ut_session.getmodule;

    Exception
      When Others Then
        sbexecutable := Null;
    End;
    
    ut_trace.trace('sbexecutable|' || sbexecutable, 10 );
	
    sbFlagAsignar := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ASIGCONT', Null);  --TICKET 200-810 LJLB -- se consulta si se va asignar el contrato o no
	
    ut_trace.trace('Existe Restriccion para la Actividad de la Orden?: ' || sbexistrestr, 10);

    --Inicio CASO 200-1234
    if :new.order_status_id=:old.order_status_id then
        sbexistrestr := 'N';
    end if;
    --Fin CASO 200-1234

    If sbexistrestr = 'S' Then

        --antes de instanciar error
        dbms_output.put_line('antes de instanciar error');

        --Si hay restricciones, se instancia el error.
        pkg_error.setErrorMessage( isbMsgErrr => 'La actividad de esta orden tiene restricciones para procesarse en esta Pantalla OSF.  ( Ver ORCREST o Parametro: LDC_EXEBLOQLEGA)' );

    End If;

	nuestadoasignado := dald_parameter.fnugetnumeric_value('COD_ESTADO_ASIGNADA_OT',Null);
	If nuestadoasignado Is Null Then
						
		If pkg_error.getapplication != 'PRC_SQ_ASI' Or
			pkg_error.getapplication Is Null Then
            pkg_error.setErrorMessage( isbMsgErrr => '[ORDER ID:' || :old.order_id ||
                            '] No se ha configurado el parámetro COD_ESTADO_ASIGNADA_OT');
		End If;
		
	End If;
	ut_trace.trace('Ejecución  LDC_TRG_STATUS_ORDER nuEstadoAsignado => ' ||
				 nuestadoasignado,
				 10);


	If :new.order_status_id = nuestadoasignado  Then
		ut_trace.trace('Ingreso => ' ||
					 :new.order_status_id||' :'||:old.order_status_id,
					 10);

		-- Se inicializan las variables
		tbcontrato.delete;
		nuconcontrato := 0;
		nucontvigente := 0;

		Begin
			-- Se consulta que clasificacion que tiene la UT a asignar
			Select es_externa
				Into sbesexterna
			From or_operating_unit
			Where operating_unit_id = :new.operating_unit_id;
		Exception
			When no_data_found Then
				sbesexterna := Null;
		End;
		-- Valida si la unidad operativa es externa, si no es externa termina(permite asignar la orden)
		If sbesexterna = 'Y' Then
			Begin
				/* Se consultan los contratos vigentes de los contratistas, y se marca si el contrato
				tiene asociado el tipo de trabajo*/
				SELECT 	coc.id_contrato,
						coc.id_tipo_contrato,
						coc.fecha_final,
						coc.status,
						(
							SELECT  'Y'
							FROM 	open.ge_contrato co
							WHERE 	id_contratista IN (
														SELECT 	contractor_id 
														FROM 	open.or_operating_unit 
														WHERE 	operating_unit_id=:new.operating_unit_id
													)
							AND 	status='AB'
							AND 	co.id_contrato = coc.id_contrato
							AND 	EXISTS	(
												SELECT 	NULL 
												FROM 	open.ct_tasktype_contype c 
												WHERE 	c.contract_id=co.id_contrato 
												AND 	task_type_id=:old.task_type_id
												UNION
												SELECT  null 
												FROM 	open.ct_tasktype_contype c , 
														open.ge_contrato co2
												WHERE 	c.contract_type_id=co2.id_tipo_contrato
												AND 	co2.id_contrato=co.id_contrato
												AND 	task_type_id=:old.task_type_id
												AND NOT EXISTS	(
																	SELECT 	NULL 
																	FROM 	open.ct_tasktype_contype c2 
																	WHERE 	c2.contract_id=co2.id_contrato
																)
											)
						) tt_en_contrato  Bulk Collect
				INTO 	tbcontrato
				FROM 	or_operating_unit oou, ge_contratista cop, ge_contrato coc
				WHERE 	oou.operating_unit_id = :new.operating_unit_id
				AND 	oou.contractor_id = cop.id_contratista
				AND 	cop.id_contratista = coc.id_contratista
				AND 	Sysdate Between coc.fecha_inicial AND coc.fecha_final
				AND 	coc.status = 'AB';
			Exception
				When no_data_found Then
					nuconcontrato := 0;
			End;

			Begin
				-- Consulta si el tipo de trabajo no es liquidable
				Select 'Y' flag
				Into sbflagttnoliquidable
				From ldc_unpaid_task_types utt
				Where utt.task_type_id = :old.task_type_id
				And rownum = 1;
			Exception
				When no_data_found Then
					sbflagttnoliquidable := Null;
			End;

			nuconcontrato := tbcontrato.count;
			-- Valida si el contratista tiene contratos vigentes, si no los tiene se lanza la excepción
			If nuconcontrato > 0 Then
				/* Puesto que tiene al menos un contrato vigente, valida si el tipo de trabajo no es liquidable,
				si no es liquidable termina(permite asignar la orden)*/
				If sbflagttnoliquidable Is Null Then
					-- Si es liquidable se valida que exista un contrato vigente que tenga asociado el tipo de trabajo
					For nuindex In tbcontrato.first .. tbcontrato.last Loop
						If tbcontrato(nuindex).tt_en_contrato = 'Y' Then
							nucontvigente := nucontvigente + 1;
						End If;
					End Loop;
					-- Si existe un contrato vigente asociado al tipo de trabajo, termina (permite asignar la orden)
					If nucontvigente = 0 Then
						If pkg_error.getapplication != 'PRC_SQ_ASI' Or
							pkg_error.getapplication Is Null Then
                            -- Si no tiene contrato vigente asociado al tipo de trabajo despliega un mensaje de error.
                            pkg_error.setErrorMessage( isbMsgErrr => 
                                        '[ORDER ID:' || :old.order_id ||
                                        '] El contratista asociado a la unidad operativa [' ||
                                        :new.operating_unit_id ||
                                        '] tiene contrato vigente pero no tiene asociado el tipo de trabajo ['||
                                        :old.task_type_id||']');
						End If;
					End If;
				End If;
			Else
				If pkg_error.getapplication != 'PRC_SQ_ASI' Or
					pkg_error.getapplication Is Null Then
                    -- Si no tiene contrato vigente despliega un mensaje de error.
                    pkg_error.setErrorMessage( isbMsgErrr => 
                                '[ORDER ID:' || :old.order_id ||
                                '] El contratista asociado a la unidad operativa [' ||
                                :new.operating_unit_id ||
                                '] no tiene un contrato vigente ');
				End If;
			End If;--If nuconcontrato > 0 Then

			--TICKET 200-810 LJLB -- si el flag esta activo se proceso asignar el contrato
			IF sbFlagAsignar = 'S'  THEN
				--Se consulta orden padre
				OPEN cuGetOrdenPadre;
				FETCH cuGetOrdenPadre INTO nuOrdePadr, nuTipoRelaP;
				CLOSE cuGetOrdenPadre;
				ut_trace.trace('cuGetOrdenPadre  nuOrdePadr=> ' ||nuOrdePadr,10);
				ut_trace.trace(':old.order_status_id' ||:old.order_status_id,10);
		        --Se consulta constratista
                OPEN cuConstratista;
				FETCH cuConstratista INTO sbExisteCont;
				CLOSE cuConstratista;

				IF :old.order_status_id in (0,11) or (:old.OPERATING_UNIT_ID <> :new.OPERATING_UNIT_ID and :old.order_status_id = nuestadoasignado AND sbExisteCont IS NULL)  THEN
					 
                   nuActividadOt:=open.daor_order_activity.fnugetactivity_id(open.ldc_bcfinanceot.fnugetactivityid(:new.order_id),NULL);          --DETERMINA ACTIVIDAD ORDEN ORIGEN
                    if nuOrdePadr is not null then
                        if nuTipoRelaP = 2 then
                          nuEstadoPadre:=8;
                        else          
                            begin
                                select final_status_id into nuEstadoPadre
                                from 
                                (
                                    select final_status_id, stat_chg_Date
                                    from open.or_order_stat_change c
                                    where c.order_id=nuOrdePadr
                                    order by stat_chg_Date desc
                                )
                                where rownum=1;
                            exception
                                when others then
                                    nuEstadoPadre:=-1;
                            end;
                        end if;
                        
                        begin
                           select l.causal_id into nuCausPadre
                           from OR_ORDER_CAUSAL_TMP l
                           where l.order_id =  nuOrdePadr
                           and rownum=1;
              
                        exception
                           when others then
                           sbError:=SQLERRM;
                        end;
                        ut_trace.trace('nuOrdePadr is not null=> nuEstadoPadre' ||nuEstadoPadre,10);
                        ut_trace.trace('nuOrdePadr is not null=> nuActividadOt' ||nuActividadOt,10);
                        ut_trace.trace('nuOrdePadr is not null=> sbError' ||sbError,10);
                        ut_trace.trace('nuOrdePadr is not null=> nuCausPadre' ||nuCausPadre,10);
                        sbError:=NULL;
  
                    end if;
                    
                    LDC_PKGASIGNARCONT.PROASIGNARCONTRATO(:new.order_id,
                                        nuOrdePadr,
                                        nuEstadoPadre,
                                        nuCausPadre,
                                        :NEW.OPERATING_UNIT_ID,
                                        :NEW.task_type_id,
                                        nuActividadOt,
                                        nuContratoAsignar,
                                        nuOk,
                                        sbError);
                    ut_trace.trace('Contrato asignar'||nuContratoAsignar, 10);
                    
                    --TICKET 200-810 LJLB -- se valida si hubo error al asignar el contrato
                    IF nuOk <> 0 THEN
                      pkg_error.setErrorMessage( isbMsgErrr => '[ORDER ID:' || :old.order_id ||']'||sbError);
                    else
                      :NEW.DEFINED_CONTRACT_ID := nuContratoAsignar;
                    END IF;         
				END IF;
        
                --si es reasigancion del mismo contratista asigan contrato del campo old.DEFINED_CONTRACT_ID
                IF :old.OPERATING_UNIT_ID <> :new.OPERATING_UNIT_ID and :old.order_status_id = nuestadoasignado AND sbExisteCont IS NOT NULL THEN
                    IF :NEW.DEFINED_CONTRACT_ID IS NULL THEN
                        :NEW.DEFINED_CONTRACT_ID := :OLD.DEFINED_CONTRACT_ID;
                    END IF;
                END IF;        
                
				-- caso 200-1138
				-- Consultamos la actividad asociada a la orden que se esta legalizando
                ut_trace.trace('nuContratoAsignar: '||nuContratoAsignar, 10);
				IF  nuContratoAsignar is not null  THEN
					--inicio 200-2391

					-- if nh>0 then -- es una orden hija
					sbtitrredes:=open.dald_parameter.fsbgetvalue_chain('LDC_TITRVALREDES',null);
					vltr:='0';
					ut_trace.trace('Orden  Hija: '||:new.order_id, 10);
					-- 200-2391 valida si el tipo de trabajo es de redes ofertados
					begin
					  select '1' into VLTR from dual where :NEW.TASK_TYPE_ID in (SELECT TO_NUMBER(COLUMN_VALUE) FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(sbtitrredes, ',')));
					exception
					  when others then
					   VLTR:='0';
					end;
					-- END IF;
					IF vltr = '1' THEN
						select count(1) into nh from LDC_ORDENES_OFERTADOS_REDES where ORDEN_HIJA=:new.order_id and PRESUPUESTO_OBRA is not null;

						IF nh = 0 THEN
							pkg_error.setErrorMessage( isbMsgErrr => 'La orden de trabajo hija['||to_char(:new.order_id)||'] no tiene configurado presupuesto en la forma LDCDEORREOF.');
						END IF;
					END IF;--IF vltr = '1' THEN
					ut_trace.trace('Es orden de Redes: '||VLTR, 10);

					--fin 200-2391
					nuactivicostprom := NULL;
					BEGIN
						SELECT activi_cost_prom INTO nuactivicostprom
						FROM(
							SELECT a.register_date,a.activity_id activi_cost_prom
							FROM or_order_activity a
							WHERE a.order_id     = :new.order_id
							AND a.task_type_id = :new.task_type_id
							AND a.status       <> 'F'
							ORDER BY a.register_date ASC
							)
						WHERE ROWNUM = 1;
					EXCEPTION
						WHEN no_data_found THEN
							nuactivicostprom := NULL;
							pkg_error.setErrorMessage( isbMsgErrr => 'La unidad operativa : '||to_char(:new.operating_unit_id)||' con el tipo de trabajo : '||to_char(:old.task_type_id)||' y la actividad : '||to_char(nuactivicostprom)||' no se encontró actividad de la orden.');
					END;

					-- Consultamos el costo promedio configurado
					nucostopromconf := 0;
					
					if vltr='0' then	-- se hacen validaciones sin tener en cuenta que es orden hija y que el tipo de trabajo no esta configurado para validar ot hijas que sean de ordenes de redes de ofertados
						ut_trace.trace('No Es orden de Redes: '||VLTR, 10);
						BEGIN
							IF NVL(nucostopromconf,0) = 0 then
								OPEN cuCostoProM;
								FETCH cuCostoProM INTO nucostopromconf;
								IF cuCostoProM%NOTFOUND THEN
									OPEN cuCostoProMTodos;
									FETCH cuCostoProMTodos INTO nucostopromconf;
									IF cuCostoProMTodos%NOTFOUND THEN
										ut_trace.trace('Error Costo Promedio ', 10);
										CLOSE cuCostoProMTodos;
										CLOSE cuCostoProM;
										pkg_error.setErrorMessage( isbMsgErrr => 'La unidad operativa : '||to_char(:new.operating_unit_id)||' con el tipo de trabajo : '||to_char(:old.task_type_id)||' y la actividad : '||to_char(nuactivicostprom)||' no tiene configuracion del costo promedio por la forma : LDCCOTTACCP.');
									eND IF;
									CLOSE cuCostoProMTodos;
								END IF;
								CLOSE cuCostoProM;
                                ut_trace.trace('nucostopromconf '||nucostopromconf, 10);
							END IF;
						EXCEPTION
							WHEN no_data_found THEN
								pkg_error.setErrorMessage( isbMsgErrr => 'La unidad operativa : '||to_char(:new.operating_unit_id)||' con el tipo de trabajo : '||to_char(:old.task_type_id)||' y la actividad : '||
												to_char(nuactivicostprom)||' no tiene configuracion del costo promedio por la forma : LDCCOTTACCP.');
						END;
						IF :old.order_status_id = 0 AND :new.order_status_id = nuestadoasignado AND nucostopromconf > 0 THEN
							nusumacosto := 0;
							nuOrdePadr := null;
							--INICIO CA 200-2391
							OPEN cuOrdenRelaAut;
							FETCH cuOrdenRelaAut INTO nuOrdePadr;
							IF cuOrdenRelaAut%FOUND THEN
								SELECT SUM(it.value) INTO nusumacosto
								FROM open.or_order_items it,open.ge_items id
								WHERE it.order_id = nuOrdePadr AND
									id.item_classif_id not in  (SELECT to_number(COLUMN_VALUE) FROM TABLE(ldc_boutilities.splitstrings(sbClasifItem, ',') )) AND
									it.items_id = id.items_id;
								nusumacosto := nusumacosto - LDC_PKGASIGNARCONT.proGetCostEstorden(nuOrdePadr);
							END IF;
							CLOSE cuOrdenRelaAut;
							--FIN CA 200-2391

							-- Validamos si se puede asignar la orden
							BEGIN
								SELECT * INTO rgreistcontrato
								FROM open.ge_contrato con
								WHERE con.id_contrato = nuContratoAsignar;
							EXCEPTION
								WHEN no_data_found THEN
									pkg_error.setErrorMessage( isbMsgErrr => 'El contrato : '||to_char(nuContratoAsignar)||' no existe.');
							END;

							nutotalvaidarasig := ( nvl(nucostopromconf,0) +  nusumacosto )+
												nvl(rgreistcontrato.valor_asignado,0) +
												nvl(rgreistcontrato.valor_no_liquidado,0) +
												nvl(rgreistcontrato.valor_liquidado,0) ;

							IF nvl(nutotalvaidarasig,0) > nvl(rgreistcontrato.valor_total_contrato,0) THEN
								pkg_error.setErrorMessage( isbMsgErrr => 'No es posible asignar la orden : '||to_char(:new.order_id)||' debido a que el contrato : '||to_char(nuContratoAsignar)||' no tiene cupo.');
							ELSE
								:new.estimated_cost := nucostopromconf;
								ldc_pkgasignarcont.procvalacumttact(nvl(nucostopromconf,0),NULL,nuContratoAsignar,:new.order_status_id,NULL);
							END IF;
                        elsif :old.order_status_id = nuestadoasignado AND :new.order_status_id = nuestadoasignado AND nucostopromconf > 0 and :old.operating_unit_id!=:new.operating_unit_id THEN
                            -- Validamos si se puede asignar la orden
                            if :new.defined_contract_id!=nvl(:old.defined_contract_id,0) then
                                begin
                                   SELECT * INTO rgreistcontrato
                                    FROM open.ge_contrato con
                                    WHERE con.id_contrato = nuContratoAsignar;
                                EXCEPTION
                                    WHEN no_data_found THEN
                                      pkg_error.setErrorMessage( isbMsgErrr => 'El contrato : '||to_char(nuContratoAsignar)||' no existe.');
                                END;
                                nutotalvaidarasig := ( nvl(nucostopromconf,0) )+
                                        nvl(rgreistcontrato.valor_asignado,0) +
                                        nvl(rgreistcontrato.valor_no_liquidado,0) +
                                        nvl(rgreistcontrato.valor_liquidado,0) ;

                                IF nvl(nutotalvaidarasig,0) > nvl(rgreistcontrato.valor_total_contrato,0) THEN
                                    pkg_error.setErrorMessage( isbMsgErrr => 'No es posible asignar la orden : '||to_char(:new.order_id)||' debido a que el contrato : '||to_char(nuContratoAsignar)||' no tiene cupo.');
                                ELSE
                                    :new.estimated_cost := nucostopromconf;
                                    ldc_pkgasignarcont.procvalacumttact(nvl(nucostopromconf,0),NULL,nuContratoAsignar,:new.order_status_id,NULL);
                                    if :old.defined_contract_id is not null then
                                        UPDATE ge_contrato t
                                        SET t.valor_asignado = nvl(t.valor_asignado,0) - nvl(:OLD.estimated_cost,0)
                                        WHERE t.id_contrato = :old.defined_contract_id;
                                    end if;
                                END IF;
                            end if;
						END IF;--IF :old.order_status_id = 0 AND :new.order_status_id = nuestadoasignado AND nucostopromconf > 0 THEN
					else -- se hace validacion si es orden hija y el tipo de trabajo es de redes de ofertados
						ut_trace.trace('Ingreso por orden de Redes: '||VLTR, 10);
						BEGIN
							SELECT * INTO rgreistcontrato
							FROM open.ge_contrato con
							WHERE con.id_contrato = nuContratoAsignar;
						EXCEPTION
							WHEN no_data_found THEN
								pkg_error.setErrorMessage( isbMsgErrr => 'El contrato : '||to_char(nuContratoAsignar)||' no existe.');
						END;
						--INICIO CA 503

                        OPEN cugetEstaBlo;
                        FETCH cugetEstaBlo INTO nuestadoOrig;
                        IF cugetEstaBlo%NOTFOUND THEN
                           nuestadoOrig :=  	:old.order_status_id;
                        END IF;
                        CLOSE cugetEstaBlo;
 
                        -- 200- 2391 LLAMAR A PROCEDMIENTO PRVALIORDEN  del paquete PKGASIGNARCONT
						LDC_PKGASIGNARCONT.PRVALIORDEN(:new.order_id,:new.order_status_id,
														nuestadoOrig,--:old.order_status_id,
														nuContratoAsignar,
														:new.operating_unit_id,
														:old.operating_unit_id,
														:new.Estimated_Cost,
														vasig,nerr,
														serr);
						ut_trace.trace('Salio del proceso asignar costo: '||vasig||' contrato: '||nuContratoAsignar, 10);
						if nerr=1 then  -- VALIDA Y MANEJA EL ERROR DEL PROCEDIMIENTO
							pkg_error.setErrorMessage( isbMsgErrr => serr);
						else
							ut_trace.trace('Validacion de estado de orden redes: '||:new.order_status_id||' estado anterior: '||:old.order_status_id, 10);
							if :new.order_status_id = nuestadoasignado and :old.order_status_id IN (0,11) then --200-2391 asigna por primera vez
								:new.estimated_cost :=vasig;
								ut_trace.trace('COSTO ESTIMADO  ASIGNADO'|| :new.estimated_cost, 10);
								ldc_pkgasignarcont.procvalacumttact(nvl(vasig,0),NULL,nuContratoAsignar,:new.order_status_id,NULL);
							else
								if :old.OPERATING_UNIT_ID <> :new.OPERATING_UNIT_ID and :old.order_status_id = nuestadoasignado and vasig > 0 then -- 200-2391 reasigna
									:new.estimated_cost :=vasig;
									ut_trace.trace('Ingreso a Reasignar costo estimado '||:new.estimated_cost,10);
									IF :old.defined_contract_id is not null and :new.defined_contract_id is not null and :old.defined_contract_id <> :new.defined_contract_id then
										ldc_pkgasignarcont.procvalacumttact(nvl(vasig,0),NULL,nuContratoAsignar,:old.order_status_id,NULL);
										UPDATE ge_contrato t
										SET t.valor_asignado = nvl(t.valor_asignado,0) - nvl(:OLD.estimated_cost,0)
										WHERE t.id_contrato = :old.defined_contract_id;
									else
                                        IF :old.defined_contract_id is null and :new.defined_contract_id is not null then 
                                          ldc_pkgasignarcont.procvalacumttact(nvl(vasig,0),NULL,nuContratoAsignar,:old.order_status_id,NULL);
                                        end if;
									END IF;
								end if;
							end if;--if :new.order_status_id = nuestadoasignado and :old.order_status_id IN (0,11) then
						end if;--if nerr=1 then
					END IF; --if vltr='0' then
				END IF;--IF  nuContratoAsignar is not null  THEN
			END IF;--IF sbFlagAsignar = 'S'  THEN
		ELSE
			--TICKET 200-810 LJLB --  se valida si esta activo el flag de validacion
			IF sbFlagAsignar = 'S' THEN
				--TICKET 200-810 LJLB --  se valida si la orden tiene contrato definido para borraselo
				IF :NEW.DEFINED_CONTRACT_ID IS NOT NULL OR :OLD.DEFINED_CONTRACT_ID IS NOT NULL THEN
					:NEW.DEFINED_CONTRACT_ID := NULL;
					  UPDATE ge_contrato t
										SET t.valor_asignado = nvl(t.valor_asignado,0) - nvl(:OLD.estimated_cost,0)
										WHERE t.id_contrato = :old.defined_contract_id;
                END IF;
			END IF;
		End If; -- fin valida UT externa

        -- Obtiene la actividad de la orden
        nuorder_activity_id := ldc_bcfinanceot.fnugetactivityid(:old.order_id);
        nuactivity_id       := daor_order_activity.fnugetactivity_id(nuorder_activity_id,
                                                                   Null);
        Begin
            -- Se consulta la configuracion de la tabla conf_metasig
            Select c.days
              Into nudays
              From open.conf_metaasig c, open.or_order_activity o
             Where o.order_id = :old.order_id
               And o.order_activity_id = nuorder_activity_id
               And o.task_type_id = c.task_type_id
               And (c.activity_id = nuactivity_id Or c.activity_id Is Null);
        Exception
            When no_data_found Then
                nudays := 0;
            When Others Then
                nudays := 0;
        End;

        Begin
            Select work_days
              Into sbcalendario
              From open.or_task_type
             Where task_type_id = :new.task_type_id;
        Exception
            When no_data_found Then
                sbcalendario := Null;
        End;

        If upper(sbcalendario) = 'L' Then
            dtfechaejecicon := pkholidaymgr.fdtgetdatenonholiday(Sysdate,
                                                             nudays);
        Elsif upper(sbcalendario) = 'B' Then
            dtfechaejecicon := Sysdate + nudays;
        End If;

        If dtfechaejecicon is not Null Then
            :new.exec_estimate_date := dtfechaejecicon;

            Update open.or_order_activity
            Set exec_estimate_date = dtfechaejecicon
            Where order_id = :old.order_id
            And order_activity_id = nuorder_activity_id;
        End If;

    End If; --Fin valida asignación

    --INICIO CA 503
    IF :NEW.ORDER_STATUS_ID = nuEstadoBloqueado and sbFlagAsignar = 'S' THEN
        IF :new.DEFINED_CONTRACT_ID IS NOT NULL THEN
            IF LDC_PKGASIGNARCONT.fnuGetConfTicoCont(:new.DEFINED_CONTRACT_ID) > 0 THEN
               :new.DEFINED_CONTRACT_ID := NULL;           
            END IF;      
        END IF;
    END IF;        
    --FIN CA 503
  
    --Obtener estado de Ejecución de la orden
    nuestadoejecutado := dald_parameter.fnugetnumeric_value('COD_ESTADO_OT_EJE',
                                                          Null);
    If nuestadoejecutado Is Null Then
        If pkg_error.getapplication != 'PRC_SQ_ASI' Or
            pkg_error.getapplication Is Null Then
            pkg_error.setErrorMessage( isbMsgErrr => 
                        '[ORDER ID:' || :old.order_id ||
                        '] No se ha configurado el parámetro COD_ESTADO_OT_EJE');
        End If;
    End If;
    
    ut_trace.trace('Ejecución  LDC_TRG_STATUS_ORDER nuEstadoEjecutado => ' ||
                 nuestadoejecutado,
                 10);

    nuestadolegalizado := dald_parameter.fnugetnumeric_value('ESTADO_CERRADO',
                                                           Null);
    If nuestadolegalizado Is Null Then
        If pkg_error.getapplication != 'PRC_SQ_ASI' Or
        pkg_error.getapplication Is Null Then
            pkg_error.setErrorMessage( isbMsgErrr => 
                        '[ORDER ID:' || :old.order_id ||
                        '] No se ha configurado el parámetro ESTADO_CERRADO');
        End If;
    End If;

    SELECT MODULE into sbModule
    FROM v$session
    where AUDSID = USERENV('SESSIONID')
    ;
  
    ut_trace.trace('sbModule|' || sbModule ,10);

	ut_trace.trace(' ANTES DE :NEW.ORDER_STATUS_ID = nuestadolegalizado AND sbModule' ,10);

	IF :NEW.ORDER_STATUS_ID = nuestadolegalizado AND sbModule not in ('LDCAIOSA','LDCMIOSA')  THEN
        ut_trace.trace(' ENTRO DE :NEW.ORDER_STATUS_ID = nuestadolegalizado AND sbModule' ,10);

        --TICKET 200-810 LJLB --  se valida si esta activo el flag de validacion
		IF sbFlagAsignar = 'S' THEN
            DELETE OR_ORDER_CAUSAL_TMP WHERE ORDER_ID=:NEW.ORDER_ID;

			--INICIO CA 00-2391
			select count(1) into noExiParTiCon
			from ld_parameter
			Where parameter_id='LDC_CONTIPOCONT'; -- valida si se ha creado el parametro LDC_CONTIPOCONT;

			if noExiParTiCon=0 then
				pkg_error.setErrorMessage( isbMsgErrr =>  'No se ha creado el parametro LDC_CONTIPOCONT');
			else
				IF LDC_PKGASIGNARCONT.fnuGetConfTicoCont(:new.DEFINED_CONTRACT_ID) > 0 THEN
					IF NOT LDC_PKGASIGNARCONT.fblValiFechContLega( :OLD.DEFINED_CONTRACT_ID, nuOk, sbError) THEN
						pkg_error.setErrorMessage( isbMsgErrr =>  '[ORDER ID:' || :old.order_id ||']'||sbError);
					END IF;
					ldc_pkgasignarcont.procvalacumttact(:old.estimated_cost,NULL,:old.defined_contract_id,:new.order_status_id,NULL);
					BEGIN
						SELECT cas.class_causal_id INTO nuclasscausal
						FROM open.ge_causal cas
						WHERE cas.causal_id = :new.causal_id;
					EXCEPTION
						WHEN no_data_found THEN
							pkg_error.setErrorMessage( isbMsgErrr => 'La causal : '||to_char(:new.causal_id)||' de la orden : '||to_char(:new.order_id)||' no existe.');
					END;
					nusumacosto := 0;
					nuOrenPadreRev := NULL;

					OPEN cuOrdenRela;
					FETCH cuOrdenRela INTO nuOrenPadreRev;
					IF cuOrdenRela%NOTFOUND THEN
					   OPEN cuNovedad;
					   FETCH cuNovedad INTO  nusumacosto;
					   CLOSE cuNovedad;
					ELSE
					   OPEN cuNovedadRev;
					   FETCH cuNovedadRev INTO  nusumacosto;
					   CLOSE cuNovedadRev;
					END IF;
					CLOSE cuOrdenRela;


					BEGIN
						IF NVL(nusumacosto, 0) = 0 THEN
							SELECT SUM(it.value) INTO nusumacosto
							FROM open.or_order_items it,open.ge_items id
							WHERE it.order_id = :new.order_id AND
							id.item_classif_id not in  (SELECT to_number(COLUMN_VALUE) FROM TABLE(ldc_boutilities.splitstrings(sbClasifItem, ',') ))
							AND it.items_id = id.items_id;
						END IF;
					EXCEPTION
						WHEN no_data_found THEN
							nusumacosto := 0;
					END;
					IF nuclasscausal = 1 THEN

						-- sumacosto es el valor de legalizacion de la orden que se este legalizando
						-- control legalizacion orden nieta
						nuOrdePadr := null;
						if nuOrdePadr is null then
							OPEN cuGetOrdenPadre;
							FETCH cuGetOrdenPadre INTO nuOrdePadr, nuTipoRelaP;
							CLOSE cuGetOrdenPadre;
							if nuOrdePadr is not null then
								select count(1) into nuEsHija from LDC_ORDENES_OFERTADOS_REDES where ORDEN_HIJA=nuOrdePadr;
							end if;
						end if;
						if nuEsHija>0 then -- es nieta
							--se valida que exista orden nieta configurada
							select count(1) into nuexisteNieta
							from LDC_ORDENES_OFERTADOS_REDES
							where ORDEN_NIETA=:new.order_id
								and orden_hija is not null;

							IF nuexisteNieta = 0 THEN
							   	pkg_error.setErrorMessage( isbMsgErrr => 'La orden nieta : '||to_char(:new.order_id )||' no esta configurada en LDCDEORREOF');
							END IF;
							ohi:=nuOrdePadr;
							if ohi is not null and ohi<>-1 then -- se tiene la orden hija
								nuCostEstOtHija := ldc_pkgasignarcont.proGetCostEstorden(OHI);

								if nuCostEstOtHija >= nvl(nusumacosto,0) then
									ldc_pkgasignarcont.proActuaCostoEsti( ohi ,nuCostEstOtHija-nvl(nusumacosto,0) );
									if :new.DEFINED_CONTRACT_ID is not null then
										update ge_contrato set valor_asignado=nvl(valor_asignado,0)- nvl(nusumacosto,0) /*, valor_no_liquidado=nvl(valor_no_liquidado,0)+nvl(nusumacosto,0)*/
										where id_contrato=:new.DEFINED_CONTRACT_ID;
									end if;
								else
									ldc_pkgasignarcont.proActuaCostoEsti( ohi ,0);
									if :new.DEFINED_CONTRACT_ID is not null then
										update ge_contrato set valor_asignado=nvl(valor_asignado,0)- nvl(nuCostEstOtHija,0)/*, valor_no_liquidado=nvl(valor_no_liquidado,0)+nvl(nusumacosto,0)*/
										where id_contrato=:new.DEFINED_CONTRACT_ID;
									end if;
								end if;--if nuCostEstOtHija >= nvl(nusumacosto,0) then
							end if;--if ohi is not null and ohi<>-1 then -- se tiene la orden hija
						end if;--if ni>0 then -- es nieta
						IF nuOrenPadreRev IS NOT NULL THEN
						   IF LDC_PKGASIGNARCONT.proGetCostEstorden(nuOrenPadreRev) <> 0 THEN
							 nusumacosto := -1 * nusumacosto;
						   ELSE
						      nusumacosto := 0;
						   END IF;
						END IF;
						ldc_pkgasignarcont.procvalacumttact(0,nusumacosto,:new.defined_contract_id,:new.order_status_id,nuclasscausal);
						:new.estimated_cost := nvl(nusumacosto,0);

					ELSE
						:new.estimated_cost := nvl(nusumacosto,0);  --se actualiza costo
					END IF;--IF nuclasscausal = 1 THEN
				END IF;
			END IF;	--if noExiParTiCon=0 then
		END IF;--IF sbFlagAsignar = 'S' THEN
	END IF; --IF :NEW.ORDER_STATUS_ID = nuestadolegalizado AND sbModule <> 'LDCAIOSA'  THEn
	ut_trace.trace(' DESPUES DE :NEW.ORDER_STATUS_ID = nuestadolegalizado AND sbModule', 10);
    -- 200-2391

    NUESTADOEJECUTADO  := dald_parameter.fnugetnumeric_value('COD_ESTADO_OT_EJE',
                                                           Null);


    If NUESTADOEJECUTADO Is Null Then
        If pkg_error.getapplication != 'PRC_SQ_ASI' Or
        pkg_error.getapplication Is Null Then
            pkg_error.setErrorMessage( isbMsgErrr => 
                        '[ORDER ID:' || :old.order_id ||
                        '] No se ha configurado el parámetro COD_ESTADO_OT_EJE');
        End If;
    End If;

    ut_trace.trace('Ejecución  LDC_TRG_STATUS_ORDER nuEstadoLegalizado => ' ||
                 nuestadolegalizado,
                 10);

    ---
    ut_trace.trace('Ejecución  LDC_TRG_STATUS_ORDER :new.order_status_id => ' ||
                 :new.order_status_id,
                 10);


    ut_trace.trace('pkg_error.getApplication|' || pkg_error.getApplication, 10);
     
    -- Se excluyen las ordenes agrupadoras generadas por el Job JOB_AGRUPAOTTITR
    -- Se excluyen las odenes agrupadoras generadas por CTGOC
	If fblaplicaentregaxcaso(csbEntrega2002391) AND  
        :NEW.ORDER_STATUS_ID = nuestadolegalizado
        AND NVL(pkg_error.getApplication , '-') <> 'JOBAGPTT'
        AND NVL(sbexecutable, '-') <> 'CTCCO'
    THEN
                
        --se consulta si el tt no es liquidable
        SELECT COUNT(*) INTO nuExcBrilla
		FROM ldc_unpaid_task_types
		WHERE TASK_TYPE_ID = :new.TASK_TYPE_ID;

		 OPEN cuNovedadCont;
		 FETCH cuNovedadCont INTO nuIsNova;
		 CLOSE cuNovedadCont;

		 SELECT COUNT(*) INTO nuisTrasMate
		 FROM OR_ORDER_ACTIVITY
		 WHERE ORDER_ID = :NEw.ORDER_ID
           AND ACTIVITY_ID IN ( SELECT TO_NUMBER(COLUMN_VALUE)
		                        FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(sbActividTrasMate, ',')));

		IF  :NEW.DEFINED_CONTRACT_ID IS NULL AND nuExcBrilla =0 AND NVL(nuIsNova, 0) = 0 and nuisTrasMate = 0 THEN
			Begin
				-- Se consulta que clasificacion que tiene la UT a asignar
				Select es_externa
				Into sbesexterna
				From or_operating_unit
				Where operating_unit_id = :new.operating_unit_id;
			Exception
				When no_data_found Then
					sbesexterna := Null;
			End;
			-- Valida si la unidad operativa es externa, si no es externa termina(permite asignar la orden)
			If sbesexterna = 'Y' Then
				pkg_error.setErrorMessage( isbMsgErrr => 'No se puede legalizar, no se pudo determinar contrato');
			END IF;
		END IF;
	END IF;
	--200-2391

    If :new.order_status_id = nuestadoejecutado Or
     :new.order_status_id = nuestadolegalizado Or
     :new.order_status_id = nuestadoasignado Then
        --Validar parametrización
        sbactividades := dald_parameter.fsbgetvalue_chain('LDC_ACT_BLOQLEGA',
                                                      Null);

        sbejecutables := dald_parameter.fsbgetvalue_chain('LDC_EXEBLOQLEGA',
                                                      Null);

        --Obtener actividad de la orden
        ut_trace.trace('nuActividad  => ' || nuactividad, 10);
        nuorderactivity := ldc_bcfinanceot.fnugetactivityid(:old.order_id);
        nuactividad     := daor_order_activity.fnugetactivity_id(nuorderactivity,
                                                                 Null);
        ut_trace.trace('sbExecutable  => ' || sbexecutable, 10);
        ut_trace.trace('sbEjecutables  => ' || sbejecutables, 10);
        ut_trace.trace('sbActividades  => ' || sbactividades, 10);
        ut_trace.trace('nuActividad  => ' || nuactividad, 10);

        If ((sbexecutable Is Null And sbactividades Is Null) Or
           ((sbexecutable Is Not Null And sbactividades Is Not Null) And
           (instr(sbejecutables, sbexecutable) > 0) And
           (instr(sbactividades, to_char(nuactividad)) > 0))) Then

            pkg_error.setErrorMessage( isbMsgErrr => 'CAMBIO DE ESTADO DE ORDEN NO PERMITIDO DESDE ' || sbexecutable);

        End If;
    End If;
  
    ut_trace.trace('Finaliza LDC_TRG_STATUS_ORDER ', 10);

Exception
    When pkg_error.CONTROLLED_ERROR Then
        Raise;
    When Others Then
        pkg_error.setError;
        Raise pkg_error.CONTROLLED_ERROR;
End ldc_trg_status_order;
/