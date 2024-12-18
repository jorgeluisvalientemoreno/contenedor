CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_VAL_MOV_BODEGA
  BEFORE UPDATE OR DELETE OR INSERT ON OR_UNI_ITEM_BALA_MOV
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
/*  Propiedad intelectual de Gases de Occidente
      Trigger     :   TRG_VAL_MOV_BODEGA
      Descripci??n :   Trigger para realizar validaciones de materiales


      Historial de modificaciones
      Fecha            IDEntrega
    25/07/2020        Horbath         436: Se adiciona validaci¿n para que tenga en cuenta los ¿tems de costo cero,
                                      validando el par¿metro ITEMSUMSINCOSTO
    16/01/2019        dsaltarin       200-2412 Se crea para validar
                                      1. no se realicen devoluciones a sap sin valor
                                      2. no se traslade items sin valor a bodegas con valor o items con valor a bodegas sin valor
                                      3. no se realicen ajustes por valor mayor a cero.
	21/04/2021		  MABG			  Caso 670: Se modificar¿ los select into dentro del trigger para agregar un bloque de excepciones
									  que valide si no se encuentran datos.
  */

Declare
PRAGMA AUTONOMOUS_TRANSACTION;
  --200-2412
  Cursor cuobtieneCausalAnulDevol(inuiditemsdoc or_uni_item_bala_mov.id_items_documento%Type) Is
    Select orig.causal_id
      From open.ge_items_documento g1, open.ldci_intemmit,open.ge_items_documento orig
     Where g1.destino_oper_uni_id = g1.destino_oper_uni_id --:new.operating_unit_id
       And trunc(g1.fecha) = trunc(Sysdate)
       And g1.id_items_documento = inuiditemsdoc
       And 'AUTO_'||mmitdsap=g1.documento_externo
       and to_number(mmitnudo)=orig.id_items_documento;

  nuCausaDev open.ge_causal.causal_id%type;
  CostoDestino open.or_ope_uni_item_bala.total_costs%type;
  CantidadDestino open.or_ope_uni_item_bala.balance%type;
  sbEntrega2002412 ldc_versionentrega.nombre_entrega%type:='OSS_OYM_DSS_2002412_1';
  csbENTREGA436 constant ldc_versionentrega.nombre_entrega%type := '0000436';

  nuCaso670	varchar2(30):=	'0000670'; ---- caso 670
  sw670		boolean := False;

BEGIN
 ut_trace.trace('TRG_VAL_MOV_BODEGA -> OPER_UNIT: '||:NEW.OPERATING_UNIT_ID||' TARGET: '||:NEW.TARGET_OPER_UNIT_ID,10);

 -- caso 670 --
 IF FBLAPLICAENTREGAXCASO(nuCaso670) THEN
	sw670 := True;
 END IF;
 -- fin caso 670 --


 If fblAplicaEntrega(sbEntrega2002412) Then
      if instr(open.dald_parameter.fsbGetValue_Chain('LDC_TIPO_CAUS_AJUS_SIN_VALOR',null),:new.item_moveme_caus_id||',')>0 And :new.movement_type!='N'  then
        if :new.total_value > 0 then
          errors.seterror(2741,
                              'No se pueden realizar ajustes con valor mayor a cero');
              Raise ex.controlled_error;
        else
			if open.dald_parameter.fsbGetValue_Chain('LDC_VAL_MOV_AJUS_CON_VALOR',null)= 'S' then

				-- Inicio Caso 670 --
				IF sw670 THEN

					BEGIN

					SELECT total_costs, balance
					 INTO CostoDestino, CantidadDestino
					  FROM OPEN.or_ope_uni_item_bala b
					  where b.items_id=:NEW.ITEMS_ID
						and b.operating_unit_id=:NEW.TARGET_OPER_UNIT_ID;

					EXCEPTION
						  WHEN no_data_found THEN
							   CostoDestino := 0;
							   CantidadDestino := 0;
					END;

				ELSE

					SELECT total_costs, balance
					 INTO CostoDestino, CantidadDestino
					  FROM OPEN.or_ope_uni_item_bala b
					  where b.items_id=:NEW.ITEMS_ID
						and b.operating_unit_id=:NEW.TARGET_OPER_UNIT_ID;

				END IF;


				-- Fin Caso 670 --

				IF CostoDestino  > 0 and CantidadDestino>0 THEN
					errors.seterror(2741,
							  'No se pueden mover material Sin costo a una bodega Con costo');
							  Raise ex.controlled_error;
				END IF;



				-- Inicio Caso 670 --
				IF sw670 THEN

					BEGIN

						SELECT total_costs, balance
						 INTO CostoDestino, CantidadDestino
						  FROM OPEN.or_ope_uni_item_bala b
						  where b.items_id=:NEW.ITEMS_ID
							and b.operating_unit_id=:NEW.OPERATING_UNIT_ID;

					EXCEPTION
						  WHEN no_data_found THEN
							   CostoDestino := 0;
							   CantidadDestino := 0;

					END;

				ELSE

					SELECT total_costs, balance
					 INTO CostoDestino, CantidadDestino
					  FROM OPEN.or_ope_uni_item_bala b
					  where b.items_id=:NEW.ITEMS_ID
						and b.operating_unit_id=:NEW.OPERATING_UNIT_ID;

				END IF;
				-- Fin Caso 670 --

               IF CostoDestino  > 0 and CantidadDestino>0 THEN
                 errors.seterror(2741,
                              'No se pueden mover material Sin costo a una bodega Con costo');
                              Raise ex.controlled_error;
               END IF;
          end if;
        end if;
      ELSE
      ut_trace.trace('TRG_VAL_MOV_BODEGA -> ITEMS_ID: '||:NEW.ITEMS_ID||' :NEW.ITEM_MOVEME_CAUS_ID '||:NEW.ITEM_MOVEME_CAUS_ID||' :NEW.MOVEMENT_TYPE: '||:NEW.MOVEMENT_TYPE,10);
      --200-2412 SE VALIDA SI SE PUEDE TRASLADAR CON VALOR CERO A UNA UNIDAD CON VALOR O CON CON VALOR A UNA UNIDAD SIN VALOR
      IF :NEW.ITEM_MOVEME_CAUS_ID = 20 AND :NEW.MOVEMENT_TYPE IN ('D','N') THEN
         IF open.daor_operating_unit.fnugetoper_unit_classif_id(:NEW.TARGET_OPER_UNIT_ID,NULL)=11 THEN
           IF :NEW.TOTAL_VALUE = 0 AND OPEN.DAGE_ITEMS.FNUGETITEM_CLASSIF_ID(:NEW.ITEMS_ID, NULL) != 3 THEN
            -- Caso 436: Se valida que el item exista en el parametro
            IF  NOT (INSTR(','||OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('ITEMSUMSINCOSTO', NULL)||',' , ','||:NEW.ITEMS_ID||',') > 0
                    AND fblaplicaentregaxcaso(csbENTREGA436)) THEN
                 IF OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_VALOR_DEVOLUCION', NULL) = 'S' THEN
                  errors.seterror(2741,
                                  'No se pueden devolver a sap con valor cero');
                  Raise ex.controlled_error;
                 END IF;
            END IF; -- Fin caso 436
           END IF;
         ELSE
           IF OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_VALOR_TRASLADOS', NULL) = 'S' THEN
             IF :NEW.TOTAL_VALUE = 0 THEN

				-- Inicio Caso 670 --
				IF sw670 THEN
					BEGIN

						SELECT total_costs, balance
						 INTO CostoDestino, CantidadDestino
						  FROM OPEN.or_ope_uni_item_bala b
						  where b.items_id=:NEW.ITEMS_ID
							and b.operating_unit_id=:NEW.TARGET_OPER_UNIT_ID;


					EXCEPTION
						  WHEN no_data_found THEN
							   CostoDestino := 0;
							   CantidadDestino := 0;

					END;
				ELSE

					SELECT total_costs, balance
						 INTO CostoDestino, CantidadDestino
						  FROM OPEN.or_ope_uni_item_bala b
						  where b.items_id=:NEW.ITEMS_ID
							and b.operating_unit_id=:NEW.TARGET_OPER_UNIT_ID;

				END IF;
				-- Fin Caso 670 --

               IF CostoDestino  > 0 and CantidadDestino>0 THEN
                 errors.seterror(2741,
                              'No se pueden trasladar material Sin costo a una bodega Con costo');
                              Raise ex.controlled_error;
               END IF;

			ELSE

				-- Inicio Caso 670 --
				IF sw670 THEN
					BEGIN

						SELECT total_costs, balance
						 INTO CostoDestino, CantidadDestino
						  FROM OPEN.or_ope_uni_item_bala b
						  where b.items_id=:NEW.ITEMS_ID
							and b.operating_unit_id=:NEW.TARGET_OPER_UNIT_ID;


					EXCEPTION
						  WHEN no_data_found THEN
							   CostoDestino := 0;
							   CantidadDestino := 0;

					END;

				ELSE

					SELECT total_costs, balance
						 INTO CostoDestino, CantidadDestino
						  FROM OPEN.or_ope_uni_item_bala b
						  where b.items_id=:NEW.ITEMS_ID
							and b.operating_unit_id=:NEW.TARGET_OPER_UNIT_ID;

				END IF;
				-- Fin Caso 670 --

               IF CostoDestino  = 0 and CantidadDestino>0 THEN
                 errors.seterror(2741,
                              'No se pueden trasladar material Con costo a una bodega Sin Costo');
                              Raise ex.controlled_error;
               END IF;
             END IF;
           END IF;
         END IF;
      END IF;

      end if;--if :new.total_value > 0 then
    end if;
  --200-2412
Exception
  When ex.controlled_error Then
    Raise;
  When Others Then
    errors.seterror;
    Raise ex.controlled_error;
End TRG_VAL_MOV_BODEGA;
/
