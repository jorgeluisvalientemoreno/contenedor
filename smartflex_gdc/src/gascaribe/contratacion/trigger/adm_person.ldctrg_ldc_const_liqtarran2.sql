CREATE OR REPLACE trigger ADM_PERSON.LDCTRG_LDC_CONST_LIQTARRAN2
 FOR  INSERT OR UPDATE ON ldc_const_liqtarran
COMPOUND TRIGGER
 /*******************************************************************


  Trigger     :  ldctrg_ldc_const_liqtarran2

  Descripci?n : Validaciones de fechas de vigencias y rangos


  Historia de Modificaciones

fecha 	   autor 	  descripcion
25/05/2021 dsaltarin CAMBIO 630: Se corrigen las validaciones del trigger  ldctrg_ldc_const_liqtarran2
20/09/2021 dsaltarin CAMBIO 809: Se corrigen errores que salen en el cambio 809
 ********************************************************************/
   eerror    EXCEPTION;
   sbmensaje VARCHAR2(2000);
   nureg     ldc_const_liqtarran.iden_reg%TYPE;
   swval     NUMBER(1);
   nuvalrep  number; -- caso 104
   sbliqui   ldc_item_uo_lr.liquidacion%TYPE;

    --- variables caso 645 ---
    nuVal     number:=0;

    nuIden_reg         ldc_const_liqtarran.iden_reg%type;
    nuUnidad_operativa ldc_const_liqtarran.unidad_operativa%type;
    nuOldUnidad        ldc_const_liqtarran.unidad_operativa%type;
    nuActividad_orden  ldc_const_liqtarran.actividad_orden%type;
    nuCantidad_inicial ldc_const_liqtarran.cantidad_inicial%type;
    nuCantidad_final   ldc_const_liqtarran.cantidad_final%type;
    nuvalor_liquidar   ldc_const_liqtarran.valor_liquidar%type;
    dtFecha_ini_vigen  ldc_const_liqtarran.fecha_ini_vigen%type;
    dtFecha_fin_vige   ldc_const_liqtarran.fecha_fin_vige%type;
    nuItems            ldc_const_liqtarran.items%type;
    nuZona_ofertados   ldc_const_liqtarran.zona_ofertados%type;

    ----809
    nuIden_regOld         ldc_const_liqtarran.iden_reg%type;
    nuUnidad_operativaOld ldc_const_liqtarran.unidad_operativa%type;
    nuActividad_ordenOld  ldc_const_liqtarran.actividad_orden%type;
    nuCantidad_inicialOld ldc_const_liqtarran.cantidad_inicial%type;
    nuCantidad_finalOld   ldc_const_liqtarran.cantidad_final%type;
    nuvalor_liquidarOld   ldc_const_liqtarran.valor_liquidar%type;
    dtFecha_ini_vigenOld  ldc_const_liqtarran.fecha_ini_vigen%type;
    dtFecha_fin_vigeOld   ldc_const_liqtarran.fecha_fin_vige%type;
    nuItemsOld            ldc_const_liqtarran.items%type;
    nuZona_ofertadosOld   ldc_const_liqtarran.zona_ofertados%type;
    sbValor               VARCHAR2(2000);
    sbAplica809           VARCHAR2(1):='N';

     cursor cuVal_const_liqtarran(new_unidad_operativa ldc_const_liqtarran.unidad_operativa%type,
                                  new_actividad_orden  ldc_const_liqtarran.actividad_orden%type,
                                  new_items            ldc_const_liqtarran.items%type,
                                  new_zona_ofertados   ldc_const_liqtarran.zona_ofertados%type,
                                  new_iden_reg         ldc_const_liqtarran.iden_reg%type) is
        select l.cantidad_inicial, l.cantidad_final, l.fecha_ini_vigen, l.fecha_fin_vige
          from ldc_const_liqtarran l
          where l.unidad_operativa = new_unidad_operativa
           AND l.actividad_orden  = new_actividad_orden
           AND l.items            = new_items
           AND l.zona_ofertados   = new_zona_ofertados
           and l.iden_reg != new_iden_reg;
   -- Se lanzar? despu?s de cada fila actualizada
    AFTER EACH ROW IS
    BEGIN
        nuIden_reg         := :NEW.Iden_reg;
        nuUnidad_operativa := :NEW.unidad_operativa;
        nuOldUnidad        := :OLD.unidad_operativa;
        nuActividad_orden  := :NEW.actividad_orden;
        nuCantidad_inicial := :NEW.cantidad_inicial;
        nuCantidad_final   := :NEW.cantidad_final;
        nuvalor_liquidar   := :NEW.valor_liquidar;
        dtFecha_ini_vigen  := :NEW.fecha_ini_vigen;
        dtFecha_fin_vige   := :NEW.fecha_fin_vige;
        nuItems            := :NEW.items;
        nuZona_ofertados   := :NEW.zona_ofertados;

        if fblaplicaentregaxcaso('0000809') then
            sbAplica809           := 'S';
            nuIden_regOld         := :Old.Iden_reg;
            nuUnidad_operativaOld := :Old.unidad_operativa;
            nuActividad_ordenOld  := :Old.actividad_orden;
            nuCantidad_inicialOld := :Old.cantidad_inicial;
            nuCantidad_finalOld   := :Old.cantidad_final;
            nuvalor_liquidarOld   := :Old.valor_liquidar;
            dtFecha_ini_vigenOld  := :Old.fecha_ini_vigen;
            dtFecha_fin_vigeOld   := :Old.fecha_fin_vige;
            nuItemsOld            := :Old.items;
            nuZona_ofertadosOld   := :Old.zona_ofertados;
       else
            sbAplica809 := 'N';
        end if;

    EXCEPTION
     WHEN eerror THEN
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
       ut_trace.trace('ldctrg_ldc_const_liqtarran '||sbmensaje||' '||SQLERRM, 11);
     WHEN OTHERS THEN
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
      ut_trace.trace('ldctrg_ldc_const_liqtarran '||' '||SQLERRM, 11);
    END AFTER EACH ROW;

   AFTER STATEMENT IS
   BEGIN
     sbmensaje := NULL;
     IF inserting THEN
      -- Consultamos modo de liquidaci?n
      BEGIN
       SELECT po.liquidacion INTO sbliqui
         FROM ldc_item_uo_lr po
        WHERE po.unidad_operativa = nuUnidad_operativa
          AND po.actividad        = nuActividad_orden
          AND po.item             = nuItems;
      EXCEPTION
       WHEN no_data_found THEN
        sbmensaje := 'El registro : '||nuIden_reg||' no tiene configuracion en el comando LDCCUAI.';
        RAISE eerror;
      END;
       -- Validamos modo de liquidaci?n Actividad
       IF sbliqui = 'A' AND nuItems <> -1 THEN
        sbmensaje := 'El registro : '||nuIden_reg||' la liquidacion configurada es por actividad, el campo item debe ser -1.';
        RAISE eerror;
       END IF;
       -- Validamos modo de liquidaci?n Items
       IF sbliqui = 'I' AND nuItems = -1 THEN
        sbmensaje := 'El registro : '||nuIden_reg||' la liquidacion configurada es por Items, el campo item debe ser diferente de -1.';
        RAISE eerror;
       END IF;
       -- Validamos que el registro no exista con una vigencia
       nureg := NULL;

        -- Validamos que la fecha inicial de vigencia no sea mayor a la fecha final de vigencia
        IF dtFecha_ini_vigen > dtFecha_fin_vige THEN
         sbmensaje := 'La fecha inicial de vigencia no debe ser mayor a la fecha final de vigencia. Fecha inicial de vigencia : '||dtFecha_ini_vigen||' Fecha final de vigencia : '|| dtFecha_fin_vige;
         RAISE eerror;
        END IF;
       --END IF;
     ELSIF updating THEN
      swval := 0;
      IF nuUnidad_operativa <> nuOldUnidad THEN
       swval := 1;
      END IF;
      IF (nuActividad_orden <> :old.actividad_orden and sbAplica809='N') OR (nuActividad_orden <> nuActividad_ordenOld  and sbAplica809='S')THEN
       swval := 1;
      END IF;
      IF (nuItems <> :old.items and sbAplica809='N') OR (nuItems <> nuItemsOld and sbAplica809='S')  THEN
       swval := 1;
      END IF;
      IF (nuZona_ofertados <> :old.zona_ofertados and sbAplica809='N') OR (nuZona_ofertados <> nuZona_ofertadosOld and sbAplica809='S') THEN
       swval := 1;
      END IF;

      IF (nuCantidad_inicial <> :old.cantidad_inicial and sbAplica809='N') or (nuCantidad_inicial <> nuCantidad_inicialOld and sbAplica809='S')  THEN
       swval := 1;
      END IF;
      IF (nuCantidad_final <> :old.cantidad_final and sbAplica809='N') OR (nuCantidad_final <> nuCantidad_finalOld and sbAplica809='S') THEN
       swval := 1;
      END IF;
      -- Validamos que la fecha inicial de vigencia no sea mayor a la fecha final de vigencia
      IF dtFecha_ini_vigen > dtFecha_fin_vige THEN
         sbmensaje := 'La fecha inicial de vigencia no debe ser mayor a la fecha final de vigencia. Fecha inicial de vigencia : '||dtFecha_ini_vigen||' Fecha final de vigencia : '|| dtFecha_fin_vige;
         RAISE eerror;
      END IF;
      -- Validamos que el valor a descontar sea mayor a 0
      IF :new.valor_liquidar < 0 THEN
         sbmensaje := 'El valor a descontar no puede ser menor a 0';
         RAISE eerror;
      END IF;
     END IF;
     IF swval = 1 THEN
      sbmensaje := 'El unico valor permitido para modificar es el valor a descontar y las fechas de vigencias.' ;
      RAISE eerror;
     END IF;

      --------------------------------      Inicio modificaciones caso 645    -------------------------------------------
    if FBLAPLICAENTREGAXCASO('0000645') then

         ut_trace.trace('Se inicia Trigger ldctrg_ldc_const_liqtarran validacion solapamiento cantidad y fecha ',10);

      FOR i IN cuVal_const_liqtarran(nuUnidad_operativa,
                                      nuActividad_orden,
                                      nuItems,
                                      nuZona_ofertados,
                                      nuIden_reg) LOOP



            ut_trace.trace(':new.cantidad_final ==>> '||nuCantidad_final,10);
            ut_trace.trace(':new.cantidad_inicial ==>> '||nuCantidad_inicial,10);

            ut_trace.trace(':new.fecha_fin_vige ==>> '||dtFecha_fin_vige,10);
            ut_trace.trace(':new.fecha_ini_vigen ==>> '||dtFecha_ini_vigen,10);

            --- se valida si la fecha inicio sea mayor a la fecha de inicio y menor a la fecha final registrada,
            --- se valida si la fecha final sea mayor a la fecha de inicio y menor a la fecha final registrada,
            IF(  (dtFecha_ini_vigen >= i.fecha_ini_vigen  AND dtFecha_ini_vigen <= i.fecha_fin_vige   and
                  dtFecha_fin_vige  >=i.fecha_ini_vigen  AND dtFecha_fin_vige >= i.fecha_fin_vige ) AND
                 (   (nuCantidad_final   BETWEEN i.cantidad_inicial AND i.cantidad_final) OR
                     (nuCantidad_inicial BETWEEN i.cantidad_inicial AND i.cantidad_final) ) )THEN

                        sbmensaje := 'Las Cantidades y/o Fechas se encuentran solapadas registro '||nuIden_reg;
                        RAISE eerror;

            --- se valida si la fecha inicio sea mayor a la fecha de inicio y menor a la fecha final registrada
            ELSIF((i.fecha_ini_vigen <= dtFecha_ini_vigen  AND i.fecha_fin_vige >= dtFecha_ini_vigen )AND
                (   (nuCantidad_final   BETWEEN i.cantidad_inicial AND i.cantidad_final) OR
                    (nuCantidad_inicial BETWEEN i.cantidad_inicial AND i.cantidad_final) ) )THEN

              sbmensaje := 'Las Cantidades y/o Fechas se encuentran solapadas registro '||nuIden_reg;
              RAISE eerror;

            --- se valida si la fecha fin sea mayor a la fecha de inicio y menor a la fecha final registrada
            ELSIF((i.fecha_ini_vigen <= dtFecha_fin_vige  AND i.fecha_fin_vige >= dtFecha_fin_vige) AND
                 (  (nuCantidad_final    BETWEEN i.cantidad_inicial AND i.cantidad_final) OR
                    (nuCantidad_inicial  BETWEEN i.cantidad_inicial AND i.cantidad_final) ) )THEN

              sbmensaje := 'Las Cantidades y/o Fechas se encuentran solapadas registro '||nuIden_reg;
              RAISE eerror;

             --- se valida si la fecha fin sea mayor a la fecha de inicio y menor a la fecha final registrada
            ELSIF((dtFecha_ini_vigen <= i.fecha_ini_vigen  AND dtFecha_fin_vige >= i.fecha_fin_vige ) AND
                 (  (nuCantidad_final    BETWEEN i.cantidad_inicial AND i.cantidad_final) OR
                    (nuCantidad_inicial  BETWEEN i.cantidad_inicial AND i.cantidad_final) ) )THEN

              sbmensaje := 'Las Cantidades y/o Fechas se encuentran solapadas registro '||nuIden_reg;
              RAISE eerror;
            END IF;



      END LOOP;

        ut_trace.trace('Se Finaliza Trigger ldctrg_ldc_const_liqtarran validacion solapamiento cantidad y fecha ',10);

    END IF;

    EXCEPTION
     WHEN eerror THEN
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
       ut_trace.trace('ldctrg_ldc_const_liqtarran '||sbmensaje||' '||SQLERRM, 11);
     WHEN OTHERS THEN
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
      ut_trace.trace('ldctrg_ldc_const_liqtarran '||' '||SQLERRM, 11);
    END AFTER STATEMENT;

END;
/
