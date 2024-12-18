CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_DEFINED_CONTRAC
BEFORE UPDATE OF defined_contract_id  ON or_order
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
--when (old.defined_contract_id is not null and new.defined_contract_id is not null and old.defined_contract_id <> new.defined_contract_id)
Declare
 /*----------------------------------------------------------------*/
  /*

       HISTORIAL DE MODIFICACIONES
     =======================================
     FECHA           AUTOR             DESCRIPCI?N
   =========      ===========       =======================
    21/09/2020     HORBATH           CA 503 se modifica para que mediante la orden nietabusque la orden hija
                                    en caso que este asignada sumarle el valor de la novedad al valor estimado
   *********************************************************************/

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
  SBPROGRAMA        VARCHAR2(4000);
  nuestadolegalizado NUMBER := dald_parameter.fnugetnumeric_value('ESTADO_CERRADO',
                                                           Null);

  sbestadoAsigEje    VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESTAPRDECONT', NULL);
  CURSOR cuNovedad IS
  SELECT LIQUIDATION_SIGN, LIQUIDATION_SIGN * o.VALUE_REFERENCE
  FROM ct_item_novelty ino, OR_ORDER_ACTIVITY o
  WHERE /*LIQUIDATION_SIGN = 1
	  and */ino.items_id  = o.ACTIVITY_ID
	  AND NOT EXISTS (SELECT 1 FROM CT_EXCL_ITEM_CONT_VAL IE WHERE IE.ITEMS_ID = ino.items_id)
	  and o.order_id = :old.order_id;

  CURSOR cuOrdenRela IS
  SELECT 'X'
  FROM OR_RELATED_ORDER
  WHERE RELATED_ORDER_ID = :old.ORDER_ID
   AND RELA_ORDER_TYPE_ID = 15;

	CURSOR cuGetOrdenPadre IS
	SELECT order_id
	FROM OR_RELATED_ORDER
	WHERE RELATED_ORDER_ID = :old.ORDER_ID ;
  nuOrdePadr NUMBER;
  nuEstaOrdH NUMBER;
  sbExiste VARCHAR2(1);
  nuSigno NUMBER;

  --INICIO CA 503
   sbApliCaso503 VARCHAR2(1) := 'N';
   nuOrdePadrHij NUMBER;

   CURSOR cuGetOrdenPadreNieta IS
	SELECT ORDEN_HIJA, ORDEN_NIETA
	FROM OR_RELATED_ORDER, LDC_ORDENES_OFERTADOS_REDES
	WHERE RELATED_ORDER_ID = :old.ORDER_ID
   and ORDEN_NIETA = order_id ;

   nuCostHija number;
  --FIN CA 503

Begin

  ut_trace.trace('Inicia LDC_TRG_STATUS_ORDER ', 10);
  --TICKET 200-810 LJLB -- se consulta si aplica la entrega en la gasera
  IF fblaplicaentrega(LDC_PKGASIGNARCONT.FSBVERSION) THEN
     sbFlagAsignar := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ASIGCONT', Null);  --TICKET 200-810 LJLB -- se consulta si se va asignar el contrato o no
  END IF;

    --INICIA CA 503
  if fblaplicaentregaxcaso('0000503') then
		sbApliCaso503:='S';
	ELSE
		sbApliCaso503:='N';
	end if;
  --FIN CA 503

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
      null;

      --TICKET 200-810 LJLB -- si el flag esta activo se proceso asignar el contrato
     IF sbFlagAsignar = 'S' and LDC_PKGASIGNARCONT.fnuGetConfTicoCont( :new.defined_contract_id ) > 0 THEN
        IF :old.defined_contract_id is not null
           and :new.defined_contract_id is not null
           and :old.defined_contract_id <> :new.defined_contract_id then
          -- Validamos si se puede asignar la orden
          nuContratoAsignar := :new.defined_contract_id;
          BEGIN
           SELECT * INTO rgreistcontrato
             FROM open.ge_contrato con
            WHERE con.id_contrato = nuContratoAsignar;
         EXCEPTION
          WHEN no_data_found THEN
             errors.seterror(2741,'El contrato : '||to_char(nuContratoAsignar)||' no existe.');
         RAISE ex.controlled_error;
         END;
         nucostopromconf   := nvl(:old.estimated_cost,0);
         nutotalvaidarasig := 0;
       IF nucostopromconf > 0 THEN
         nutotalvaidarasig := nvl(nucostopromconf,0) +
                  nvl(rgreistcontrato.valor_asignado,0) +
                  nvl(rgreistcontrato.valor_no_liquidado,0) +
                  nvl(rgreistcontrato.valor_liquidado,0) ;

        IF nvl(nutotalvaidarasig,0) > nvl(rgreistcontrato.valor_total_contrato,0) THEN
        errors.seterror(2741,'No es posible cambiar el contrato a la ord?n : '||to_char(:new.order_id)||' debido a que el contrato : '||to_char(:new.defined_contract_id)||' no tiene cupo.');
        RAISE ex.controlled_error;
        ELSE
        IF :old.order_status_id IN(5,11,12, 6, 7) THEN

           IF INSTR(sbestadoAsigEje,:old.order_status_id) > 0 THEN
             ldc_pkgasignarcont.procvalacumttact(nvl(nucostopromconf,0),NULL,nuContratoAsignar,:old.order_status_id,NULL);

           ELSIF :old.order_status_id IN(11,12) THEN
              UPDATE ge_contrato t
             SET t.valor_asignado = nvl(t.valor_asignado,0) + nvl(nucostopromconf,0)
             WHERE t.id_contrato = nuContratoAsignar;
           END IF;

           IF INSTR(sbestadoAsigEje,:old.order_status_id) > 0 THEN
            UPDATE ge_contrato t
             SET t.valor_asignado = nvl(t.valor_asignado,0) - nvl(nucostopromconf,0)
             WHERE t.id_contrato = :old.defined_contract_id;
           ELSIF :old.order_status_id IN(11,12) THEN
            UPDATE ge_contrato t
             SET t.valor_asignado = nvl(t.valor_asignado,0) + nvl(nucostopromconf,0)
             WHERE t.id_contrato = :old.defined_contract_id;
           END IF;
        END IF;
        IF :new.order_status_id = 8 THEN
           BEGIN
            SELECT cas.class_causal_id INTO nuclasscausal
            FROM open.ge_causal cas
             WHERE cas.causal_id = :old.causal_id;
           EXCEPTION
            WHEN no_data_found THEN
             errors.seterror(2741,'La causal : '||to_char(:new.causal_id)||' de la ord?n : '||to_char(:new.order_id)||' no existe.');
             RAISE ex.controlled_error;
           END;
           IF nuclasscausal = 1 THEN
              ldc_pkgasignarcont.procvalacumttact(0,nvl(nucostopromconf,0),nuContratoAsignar,:old.order_status_id,nuclasscausal);
              UPDATE ge_contrato t
               SET t.valor_no_liquidado = nvl(t.valor_no_liquidado,0) - nvl(nucostopromconf,0)
               WHERE t.id_contrato = :old.defined_contract_id;
           END IF;
           ut_trace.trace('Contrato asignado'|| :NEW.DEFINED_CONTRACT_ID, 10);
        END IF;
       END IF;
         END IF;
    END IF;

    IF :NEW.defined_contract_id IS NOT NULL THEN
    -- se valida las novedades
	   OPEN cuNovedad;
	   fetch cuNovedad into nuSigno, nucostopromconf;
	   if cunovedad%found then
	        sbExiste := NULL;
			OPEN cuOrdenRela;
		    FETCH cuOrdenRela INTO sbExiste;
			IF cuOrdenRela%FOUND AND nuSigno = -1 THEN
			   nucostopromconf := nucostopromconf * nuSigno;
			   sbExiste :=  NULL;
			END IF;
		    CLOSE cuOrdenRela;



			nuContratoAsignar := :NEW.defined_contract_id;
            BEGIN
              SELECT * INTO rgreistcontrato
              FROM open.ge_contrato con
              WHERE con.id_contrato = nuContratoAsignar;
            EXCEPTION
            WHEN no_data_found THEN
              errors.seterror(2741,'El contrato : '||to_char(:OLD.defined_contract_id)||' no existe.');
              RAISE ex.controlled_error;
            END;
            --nucostopromconf   := nvl(:old.estimated_cost,0);

            nutotalvaidarasig := 0;
            IF nucostopromconf > 0 and sbExiste is null THEN
                nutotalvaidarasig := nvl(nucostopromconf,0) +
                  nvl(rgreistcontrato.valor_asignado,0) +
                  nvl(rgreistcontrato.valor_no_liquidado,0) +
                  nvl(rgreistcontrato.valor_liquidado,0) ;

              IF nvl(nutotalvaidarasig,0) > nvl(rgreistcontrato.valor_total_contrato,0) THEN
                  errors.seterror(2741,'No es posible generar la novedad asociada al contrato: '||to_char(nuContratoAsignar)||' debido a que este no tiene cupo.');
                  RAISE ex.controlled_error;
              end if;
            END IF;
            IF :NEW.ORDER_STATUS_ID = nuestadolegalizado THEN
                BEGIN
                SELECT cas.class_causal_id INTO nuclasscausal
                FROM open.ge_causal cas
                WHERE cas.causal_id = :new.causal_id;
                EXCEPTION
                WHEN no_data_found THEN
                    errors.seterror(2741,'La causal : '||to_char(:new.causal_id)||' de la ord?n : '||to_char(:new.order_id)||' no existe.');
                    Raise ex.controlled_error;
                END;

                IF nuclasscausal = 1 THEN
                    IF sbExiste IS NOT NULL THEN
                      nucostopromconf := -1 * nucostopromconf;
                    END IF;
                  ldc_pkgasignarcont.procvalacumttact(0,nucostopromconf,:NEW.defined_contract_id,:new.order_status_id,nuclasscausal);
                  :new.estimated_cost := nucostopromconf;

                    nuOrdePadr := NULL;
                  --INICIO CA 503
                   if sbApliCaso503 = 'N' THEN
                        OPEN cuGetOrdenPadre;
                        FETCH cuGetOrdenPadre INTO nuOrdePadr;
                        CLOSE cuGetOrdenPadre;
                    ELSE
                        OPEN cuGetOrdenPadreNieta;
                        FETCH cuGetOrdenPadreNieta INTO nuOrdePadrHij,nuOrdePadr ;
                        CLOSE cuGetOrdenPadreNieta;
                    END IF;
                  --FIN CA 503
                  nuEstaOrdH := ldc_pkgasignarcont.proGetEstadoOrden(nuOrdePadr);
                 --INICIO CA 503
                 IF sbApliCaso503 = 'S' AND nuEstaOrdH = 5 THEN
                    nuCostHija := ldc_pkgasignarcont.proGetCostEstorden(nuOrdePadrHij);
                    ldc_pkgasignarcont.proActuaCostoEsti(nuOrdePadrHij, (nvl(nuCostHija,0) + (nvl(nucostopromconf,0)  * -1)) );
                 end if;
                 --FIN CA 503
                  nucostopromconf := abs(nucostopromconf);
                  IF nuEstaOrdH = 5 THEN
                    UPDATE open.ge_contrato con
                    SET con.valor_asignado = nvl(con.valor_asignado,0) + nvl(nucostopromconf,0)
                    WHERE con.id_contrato = :NEW.defined_contract_id;

                 END IF;


                END IF;
            END IF;
        END IF;
			  close cuNovedad;
	   END IF;
        null;
   END IF;
  END IF;
Exception
  When ex.controlled_error Then
    Raise;
  When Others Then
    errors.seterror;
    Raise ex.controlled_error;
End LDC_TRG_DEFINED_CONTRAC;
/
