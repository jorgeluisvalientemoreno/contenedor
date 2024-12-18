CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_STATUS_ORDER_ANBLO
BEFORE UPDATE OF order_status_id ON or_order
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
  --
when ((old.order_status_id = 5 and new.order_status_id = 0) or new.order_status_id = 12 )
Declare
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
  /*Variables CA 200-703*/
  csbEntrega200703   CONSTANT VARCHAR2(100) := 'OSS_DIS_NCZ_200703_2';
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
  nusumacosto       or_order_items.value%TYPE;

  SBPROGRAMA VARCHAR2(4000);

  nuValidaTiCo NUMBER := 0;-- ticket  200-2391 ljlb -- Se almacena valor si tipo de
  nuout NUMBER;
  sbOrden VARCHAR2(40);

  CURSOR cuNovedad IS
  SELECT ore.order_id
  FROM ct_item_novelty ino, OR_ORDER_ACTIVITY o, OR_RELATED_ORDER ore
  WHERE LIQUIDATION_SIGN = -1
  and ino.items_id  = o.ACTIVITY_ID
  AND NOT EXISTS (SELECT 1 FROM CT_EXCL_ITEM_CONT_VAL IE WHERE IE.ITEMS_ID = ino.items_id)
  and o.order_id = :old.order_id
  AND ore.RELATED_ORDER_ID = :old.ORDER_ID;

  nuOrdenPadre NUMBER;
  nuCostoEsti NUMBER;

Begin

  ut_trace.trace('Inicia LDC_TRG_STATUS_ORDER ', 10);
  --TICKET 200-810 LJLB -- se consulta si aplica la entrega en la gasera
  IF fblaplicaentrega(LDC_PKGASIGNARCONT.FSBVERSION) THEN
     sbFlagAsignar := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ASIGCONT', Null);  --TICKET 200-810 LJLB -- se consulta si se va asignar el contrato o no

  END IF;

   ut_trace.trace('Ejecuci?n  LDC_TRG_STATUS_ORDER nuEstadoAsignado => ' ||
                 nuestadoasignado,
                 10);


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

      --TICKET 200-810 LJLB -- si el flag esta activo se proceso asignar el contrato
     IF sbFlagAsignar = 'S' THEN
	  --se valida si el contrato esta configurado
	  IF LDC_PKGASIGNARCONT.fnuGetConfTicoCont(:new.defined_contract_id) > 0 THEN

		 If (:old.order_status_id = 5 and :new.order_status_id = 0)  then
			 :new.estimated_cost := NULL;
			 ldc_pkgasignarcont.procvalacumttact(nvl(:old.estimated_cost,0),NULL,:old.defined_contract_id,:new.order_status_id,NULL);
		 elsif :new.order_status_id=12 and :new.defined_contract_id is not null and nvl(:new.estimated_cost,0) <> 0 then
			 sbOrden := NULL;
			 --se valida si la anulacion viene de orcao
		    IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK( GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
														  NULL,
														  'OR_ORDER',
														 'ORDER_ID',
														  nuout) THEN
			  GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
														NULL,
														'OR_ORDER',
														'ORDER_ID',
														sbOrden);

            END IF;
			IF sbOrden IS NULL THEN
			  nuOrdenPadre := NULL;

			  nuCostoEsti := nvl(:new.estimated_cost,0);
			  OPEN cuNovedad;
			  FETCH cuNovedad INTO nuOrdenPadre;
			  CLOSE cuNovedad;

			  IF nuCostoEsti > 0 THEN
			    --ldc_pkgasignarcont.procvalacumttact(nvl(:new.estimated_cost,0),NULL,:new.defined_contract_id,:new.order_status_id,NULL);
				ldc_pkgasignarcont.procvalacumttact(nuCostoEsti,NULL,:new.defined_contract_id,:new.order_status_id,NULL);
			  END IF;
			  --se consulta estado de la orden hija
			  IF nuOrdenPadre IS NOT NULL THEN
			    nuCostoEsti := abs(nuCostoEsti);
				  UPDATE open.ge_contrato con
				   SET con.valor_no_liquidado = nvl(con.valor_no_liquidado,0) + nvl(nuCostoEsti,0)
				 WHERE con.id_contrato    = :new.defined_contract_id;
			  END IF;

			END IF;
			:new.estimated_cost := NULL;
			:new.defined_contract_id:=null;
		end if;
	  END IF;
    END IF;
  END IF;

Exception
  When ex.controlled_error Then
    Raise;
  When Others Then
    errors.seterror;
    Raise ex.controlled_error;
End LDC_TRG_STATUS_ORDER_ANBLO;
/
