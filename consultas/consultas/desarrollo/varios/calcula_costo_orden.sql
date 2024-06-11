alter session set current_schema="OPEN";
 declare
 inucontrato  open.ge_contrato.id_contrato%TYPE:=7002;
 inuOrderId   open.or_order.order_id%TYPE:=182653206;
 onuOrderCost NUMBER;
 
    TYPE TYVALORITEMLISTA IS RECORD
    (
        LIST_UNITARY_COST_ID GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE,
        PRICE                GE_UNIT_COST_ITE_LIS.PRICE%TYPE,
        SALES_VALUE          GE_UNIT_COST_ITE_LIS.SALES_VALUE%TYPE
    );

    
    TYPE TYTBVALORITEMLISTA IS TABLE OF TYVALORITEMLISTA INDEX BY VARCHAR2(42);
    TBCACHEVALORITEMLISTA TYTBVALORITEMLISTA;
 
   
CURSOR cuitemslegorden(nuorderid IN or_order_items.order_id%TYPE) IS

      SELECT OR_order_items.items_id, OR_order_items.LEGAL_ITEM_AMOUNT, OR_order_items.VALUE

       FROM OR_order_items,ge_items

       WHERE order_id = nuorderid

       and OR_order_items.items_id = ge_items.items_id

       and ge_items.item_classif_id not in (SELECT column_value ITEMS_ID

                                            from table (ldc_boutilities.SPLITstrings(

                                            dald_parameter.fsbGetValue_Chain('LDC_EXCLUIR_ITEMSCLASIF'),',')));



    /*07-01-2014 Llozada [NC 2367]: Se excluyen los items de clasificacion 21 y 8

                                    Configurados en el parametro LDC_EXCLUIR_ITEMSCLASIF*/

    CURSOR cuItemLegOrdenByItem(nuOrderId IN or_order_items.order_id%TYPE, nuItemId NUMBER)

    IS

      SELECT OR_order_items.items_id, OR_order_items.LEGAL_ITEM_AMOUNT, OR_order_items.VALUE

        FROM OR_order_items, ge_items

       WHERE OR_order_items.order_id = nuorderid

        AND OR_order_items.items_id = nuItemId

        and OR_order_items.items_id = ge_items.items_id

       and ge_items.item_classif_id not in (SELECT column_value ITEMS_ID

                                            from table (ldc_boutilities.SPLITstrings(

                                            dald_parameter.fsbGetValue_Chain('LDC_EXCLUIR_ITEMSCLASIF'),',')));

         --and legal_item_amount > 0; --Se obtienen todos los Items del padre



    --LLOZADA: debe tomar todos los items de la orden padre

    CURSOR cuitemslegordenPadre(nuorderid IN or_order_items.order_id%TYPE,

                                nuItems   IN or_order_items.items_id%TYPE) IS

      SELECT items_id

        FROM OR_order_items

       WHERE order_id = nuorderid

         AND items_id = nuItems;

         --and legal_item_amount > 0;



    -- CURSOR que trae la orden padre

    CURSOR cuOrdenSinAjuste(nuorderid IN or_order_items.order_id%TYPE) IS

      SELECT ro.related_order_id
        FROM or_related_order ro, or_order o
       WHERE ro.related_order_id = o.order_id
      AND ro.order_id = nuorderid
      AND o.ORDER_STATUS_ID = 8
         AND ro.rela_order_type_id = 9;


    nucontract     ge_contrato.id_contrato%TYPE;

    nucontrato     ge_contrato.id_contrato%TYPE;

    nuCantidad     OR_order_items.LEGAL_ITEM_AMOUNT%TYPE;

    dtfecha        DATE;

    onupricelistid NUMBER;

    onuvalue       NUMBER;



    --NC 795

    -- CURSOR que trae los items de la orden de ajuste

    CURSOR cuordenajustes(nuorderid IN or_order.order_id%TYPE) IS

         SELECT OR_order_items.Order_Id, OR_order_items.LEGAL_ITEM_AMOUNT, OR_order_items.out_, OR_order_items.VALUE, OR_order_items.items_id

         FROM OR_order_items, ge_items

         WHERE order_id = nuorderid

         AND legal_item_amount > 0

         AND out_ IN (Ge_Boconstants.csbYES, Ge_Boconstants.csbNO)

         and OR_order_items.items_id = ge_items.items_id

         and ge_items.item_classif_id not in (SELECT column_value ITEMS_ID

                                            from table (ldc_boutilities.SPLITstrings(

                                            dald_parameter.fsbGetValue_Chain('LDC_EXCLUIR_ITEMSCLASIF'),',')));



    TYPE tyRcItemsAjuste IS RECORD (Order_Id OR_order_items.order_id%TYPE,

                         LEGAL_ITEM_AMOUNT OR_order_items.legal_item_amount%TYPE,

                         out_ OR_order_items.out_%TYPE,

                         VALUE OR_order_items.VALUE%TYPE,

                         items_id  OR_order_items.items_id%TYPE

                         );



    TYPE tytbItemsAjuste IS TABLE OF tyRcItemsAjuste INDEX BY BINARY_INTEGER;



    tbItemsAjuste tytbItemsAjuste;



    TYPE tyRcItemsPadre IS RECORD (items_id  OR_order_items.items_id%TYPE,

                         LEGAL_ITEM_AMOUNT OR_order_items.legal_item_amount%TYPE,

                         VALUE OR_order_items.VALUE%TYPE

                         );



    TYPE tytbItemsPadre IS TABLE OF tyRcItemsPadre INDEX BY BINARY_INTEGER;



    tbItemsPadre tytbItemsPadre;



    nuY           NUMBER;

    nuN           NUMBER;

    nuOrdenAjuste NUMBER := 0;

    nuOrden       NUMBER;

    nuSigValor    NUMBER;

    --FIN NC795



    --<<NC 1776

    CURSOR cuitemnovedadpos(nuitem ge_items.items_id%TYPE) IS

      SELECT 'X'

        FROM ct_item_novelty

       WHERE items_id = nuitem

         AND liquidation_sign = 1;



    -- ARANDA 2818

    CURSOR cuitemnovedadneg(nuitem ge_items.items_id%TYPE) IS
      SELECT 'X', -1 SigValor
        FROM ct_item_novelty
       WHERE items_id = nuitem
         AND items_id IN (SELECT TO_NUMBER(COLUMN_VALUE)
                                FROM TABLE(Ldc_Boutilities.splitstrings(Dald_Parameter.fsbGetValue_Chain('ACT_NOVEDAD_NEG_FNB'), ',')))
         AND liquidation_sign = -1;

    --<200-2081>
    --cursor sin validacion de parametro
    CURSOR cuitemnovedadneg_noVal(nuitem ge_items.items_id%TYPE) IS
      SELECT 'X', -1 SigValor
        FROM ct_item_novelty
       WHERE items_id = nuitem
         AND liquidation_sign = -1;







    sbliquida VARCHAR2(2);

    nuitemnov ge_items.items_id%TYPE;



    onuCondicionSimple NUMBER;

    ochCosto VARCHAR2(100);

    ochLista VARCHAR2(100);

    ochTodosLosItems VARCHAR2(100);

    otbItemsCondSimple Dact_Simple_Cond_Items.tytbCT_SIMPLE_COND_ITEMS;

    -->>

    nuI NUMBER;

    nuItemNew NUMBER;

    nuCantNew NUMBER;

    nuValueNew NUMBER;

    i NUMBER;

    nupos NUMBER;



    nuitem number;

    nuvalor number;



  
      CURSOR cuitemslegordennov(nuorderid IN or_order_items.order_id%TYPE) IS

      SELECT activity_id, DECODE(nvl(( SELECT 'Y'

       FROM or_related_order

       WHERE or_related_order.order_id = nuorderid

       AND   or_related_order.rela_order_type_id = 15),'N'),'Y',value_reference*-1,value_reference) value_reference

        FROM OR_ORDER_ACTIVITY

       WHERE order_id = nuorderid;
       
    PROCEDURE OBTENERVALORITEMLISTA
    (
        INUORDERID     IN  OR_ORDER.ORDER_ID%TYPE,
        INUITEMID      IN  GE_ITEMS.ITEMS_ID%TYPE,
        ISBCAMPO       IN  VARCHAR2,
        ONUPRICELISTID OUT GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE,
        ONUVALUE       OUT GE_UNIT_COST_ITE_LIS.PRICE%TYPE,
        IDTDATE        IN  OR_ORDER.LEGALIZATION_DATE%TYPE DEFAULT NULL
    )
    IS
        SBCACHE VARCHAR2(31);

        DTDATE            OR_ORDER.LEGALIZATION_DATE%TYPE;

        NUASSIGNEDDATE     OR_ORDER.ASSIGNED_DATE%TYPE;
        NUOPERATINGUNITID  OR_ORDER.OPERATING_UNIT_ID%TYPE;
        NUGEOGRALOCATIONID GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE;

        NUIDCONTRATISTA   GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
        
        NUPRICE           GE_UNIT_COST_ITE_LIS.PRICE%TYPE;
        NUSALESVALUE      GE_UNIT_COST_ITE_LIS.SALES_VALUE%TYPE;
        
        SBCONTRACT      GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCONTRACT      GE_CONTRATO.ID_CONTRATO%TYPE := NULL;

        PROCEDURE CARGARDATOS
        IS
        BEGIN
            
            GE_BCCERTCONTRATISTA.OBTENERDATOSORDEN
            (
                INUORDERID,
                NUASSIGNEDDATE,
                NUOPERATINGUNITID,
                NUGEOGRALOCATIONID
            );

            
            GE_BCCERTCONTRATISTA.OBTENERDATOSUNIDADTRABAJO(NUOPERATINGUNITID,
                                                           NUIDCONTRATISTA);
                                                           
                                                           
            

            SBCONTRACT:=INUCONTRATO;
            
            IF SBCONTRACT IS NOT NULL THEN
                NUCONTRACT := TO_NUMBER(SBCONTRACT);
            END IF;
            
    		
        END;
    BEGIN
        
        SBCACHE := INUORDERID||'_'||INUITEMID||'_'||TO_CHAR(IDTDATE,'dd_mm_yyyy');
        IF (TBCACHEVALORITEMLISTA.EXISTS(SBCACHE)) THEN
            ONUPRICELISTID := TBCACHEVALORITEMLISTA(SBCACHE).LIST_UNITARY_COST_ID;
            IF (ISBCAMPO = GE_BOCONSTANTS.FSBGETITEMPRICECOLNAME) THEN
                ONUVALUE   := TBCACHEVALORITEMLISTA(SBCACHE).PRICE;
            ELSIF (ISBCAMPO = GE_BOCONSTANTS.FSBGETITEMSALESVALUECOLNAME) THEN
                ONUVALUE   := TBCACHEVALORITEMLISTA(SBCACHE).SALES_VALUE;
            END IF;
            RETURN;
        END IF;

        CARGARDATOS;

        
        DTDATE := NVL(IDTDATE,
                      NUASSIGNEDDATE);
                      
        DTDATE := TRUNC(DTDATE);

        
        GE_BCCERTCONTRATISTA.OBTENERCOSTOITEMLISTA
        (
            INUITEMID,
            DTDATE,
            NUGEOGRALOCATIONID,
            NUIDCONTRATISTA,
            NUOPERATINGUNITID,
            NUCONTRACT,
            ONUPRICELISTID,
            NUPRICE,
            NUSALESVALUE
        );

        
        NUSALESVALUE := NVL(NUSALESVALUE,0);

        
        TBCACHEVALORITEMLISTA(SBCACHE).LIST_UNITARY_COST_ID := ONUPRICELISTID;
        TBCACHEVALORITEMLISTA(SBCACHE).PRICE                := NUPRICE;
        TBCACHEVALORITEMLISTA(SBCACHE).SALES_VALUE          := NUSALESVALUE;
        
        IF (ISBCAMPO = GE_BOCONSTANTS.FSBGETITEMPRICECOLNAME) THEN
            ONUVALUE := NUPRICE;
        ELSIF (ISBCAMPO = GE_BOCONSTANTS.FSBGETITEMSALESVALUECOLNAME) THEN
               ONUVALUE := NUSALESVALUE;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END OBTENERVALORITEMLISTA;       
  BEGIN



    Ldc_Acta.LDC_ObtenerCondLiquidacion(inucontrato,onuCondicionSimple,ochCosto,ochLista,ochTodosLosItems,otbItemsCondSimple);



    nuOrden := inuOrderId;

    --obtiene la fecha con que se debe buscar el costo en la lista de costos

    "OPEN".Ldc_Acta.PROFECHALISTACOSTO(dtfecha, nuOrden);



    Ut_Trace.TRACE('-- INICIO COSTO ACTA:',2);



    IF cuItemsLegOrden%isopen THEN

      CLOSE cuItemsLegOrden;

    END IF;



    OPEN cuOrdenSinAjuste(inuOrderId);

    FETCH cuOrdenSinAjuste

      INTO nuOrdenAjuste;

    CLOSE cuOrdenSinAjuste;



    --Valida si la orden que llega es de Ajuste

    IF nuOrdenAjuste IS NULL THEN

      nuOrdenAjuste := 0;

    END IF;



    nuContract := inucontrato;



    -- Adiciona el atributo de la entidad a la instancia

    


    -- si creo la instancia, podra obtener el costo

    IF (1=1) THEN
      
    

      --valida si es orden de novedad

      IF (Ct_Bonovelty.fsbisnoveltyorder(nuorden) = 'N') THEN
        dbms_output.put_line('No novedad');
        --ut_trace.trace('-- Paso 4. No es Novedad -->', 1);

        onuordercost := 0;



    /***************************************************************************

     *       LLOZADA:              Tabla de Items Padre

     **************************************************************************/



        -- se valida si la liquidacion es por todos los items

        IF ochTodosLosItems = 'Y' THEN



            OPEN cuitemslegorden(nuorden);

            FETCH cuitemslegorden BULK COLLECT INTO tbItemsPadre;

            CLOSE cuitemslegorden;



            --Ut_Trace.TRACE('-- CANTIDAD tbItemsPadre: '||tbItemsPadre.COUNT,5);



        ELSE

            -- se valida si la liquidacion es para algunos items

            tbItemsPadre.DELETE;

            nuI := 1;

            nupos := 1;

            -- La tabla tbItemsPadre se reemplaza con los items de la lista

            FOR nui IN 1 .. otbitemscondsimple.COUNT LOOP

                nuitemnew := NULL;

                nucantnew := NULL;

                nuValueNew := NULL;

                OPEN cuItemLegOrdenByItem(nuorden, otbItemsCondSimple(nuI).items_id);

                FETCH cuItemLegOrdenByItem INTO nuItemNew,nuCantNew,nuValueNew;

                CLOSE cuItemLegOrdenByItem;



                IF(nuitemnew IS NOT NULL)THEN

                  tbItemsPadre(nupos).items_id := nuItemNew;

                  tbitemspadre(nupos).legal_item_amount := nucantnew;

                  tbitemspadre(nupos).VALUE := nuvaluenew;

                  nupos := nupos + 1;

                END IF;

              END LOOP;



        END IF; -- END if ochTodosLosItems = 'Y'



        --Items del padre

        FOR i IN tbitemspadre.FIRST .. tbitemspadre.LAST LOOP

            onuvalue := 0;

            --LLOZADA: Solo procesa los Items del Padre con cantidad mayor a 0

            IF tbItemsPadre(i).LEGAL_ITEM_AMOUNT > 0 OR tbItemsPadre(i).LEGAL_ITEM_AMOUNT IS NOT NULL THEN



                -- Se valida si la liquidacion es por costo de la orden

                IF ochCosto = 'Y' THEN

                     onuvalue := tbItemsPadre(i).VALUE;

                END IF; -- END if ochCosto = 'Y'



                -- Se valida si es por lista de costos

                IF ochLista = 'Y' THEN



                    nuCantidad := tbItemsPadre(i).LEGAL_ITEM_AMOUNT; --rtitemslegorden.LEGAL_ITEM_AMOUNT;



                    Ge_Bocertcontratista.obtenervaloritemlista(nuOrden,

                                                               tbItemsPadre(i).items_id, --rtitemslegorden.items_id,

                                                               'PRICE',

                                                               onupricelistid,

                                                               onuvalue,

                                                               dtfecha);

                    onuvalue := onuvalue * nucantidad;



                END IF; -- END if ochLista = 'Y'

                onuordercost := onuvalue + onuordercost;

            END IF;

        END LOOP;





    /***************************************************************************

     *   LLOZADA:                 Fin Recorrido Items Padre

     **************************************************************************/



        --NC 795

        --Busqueda de ordenes de ajustes con su valor total

        nuY := 0;

        nuN := 0;



    /***************************************************************************

     *                     Ordenes de Ajuste

     **************************************************************************/

        IF nuOrdenAjuste > 0 THEN



            OPEN cuordenajustes(nuOrdenAjuste);

            FETCH cuordenajustes BULK COLLECT INTO tbItemsAjuste;

            CLOSE cuordenajustes;



            FOR j IN tbItemsAjuste.FIRST .. tbItemsAjuste.LAST LOOP



                 --LOZADA 10-03-2014 NO VALIDA CONTRA LOS ITEMS PADRE

                 --Devuelve los items de la orden Padre

                  --for i in tbItemsPadre.first .. tbItemsPadre.last loop



                        onuvalue := 0;

                        nuY      := 0;

                        nuN      := 0;



                        --LOZADA 10-03-2014 NO VALIDA CONTRA LOS ITEMS PADRE

                        --if tbItemsAjuste(j).items_id = tbItemsPadre(i).items_id then  --LLOZADA



                            -- Se valida si la liquidacion es por costo de la orden

                            IF ochCosto = 'Y' THEN

                                 onuvalue := tbItemsAjuste(j).VALUE;

                            END IF; -- END if ochCosto = 'Y'



                            -- Se valida si es por lista de costos

                            IF ochLista = 'Y' THEN



                                nucantidad := tbItemsAjuste(j).legal_item_amount;



                                Ge_Bocertcontratista.obtenervaloritemlista(tbItemsAjuste(j).order_id, --rtordenajuste.order_id,

                                                           tbItemsAjuste(j).items_id, --rtordenajuste.items_id,

                                                           'PRICE',

                                                           onupricelistid,

                                                           onuvalue,

                                                           dtfecha);



                                onuvalue := onuvalue * nucantidad;



                            END IF; -- END if ochLista = 'Y'



                          IF tbItemsAjuste(j).out_ = Ge_Boconstants.csbyes THEN -- LLOZADA

                                nuy := nuy + onuvalue;

                          ELSE

                                nun := nun + onuvalue;

                          END IF;

                          --exit;

                        --end if;

                  --end loop;

                  onuOrderCost := onuOrderCost + nuY - nuN;

            END LOOP;

        END IF;

    /***************************************************************************

     *                     Fin Ordenes de Ajuste

     **************************************************************************/



        --Fin Busqueda de ordenes de ajustes con su valor total

        --Fin NC 795

      ELSE
        dbms_output.put_line('Es novedad');
        --Se trata de una orden de Novedad

        onuordercost := 0;

        --obtener el item de or_order_activity



        --ut_trace.trace('ORDEN NOVEDAD -->' || nuorden, 1);

        --DBMS_OUTPUT.put_line('ORDEN NOVEDAD -->' || nuorden);



        FOR rtitemslegordennov IN cuitemslegordennov(nuorden) LOOP

          nuitemnov := rtitemslegordennov.activity_id;

          dbms_output.put_line(rtitemslegordennov.activity_id);

          --ut_trace.trace('VALOR NOVEDAD -->' || nuitemnov, 1);

          --DBMS_OUTPUT.put_line('VALOR NOVEDAD -->' || nuitemnov);



          --ut_trace.trace('ITEM NOVEDAD -->' || nuitemnov, 1);

          --DBMS_OUTPUT.put_line('ITEM NOVEDAD -->' || nuitemnov);



          --valida si se trata de un item de novedad positivo

          sbliquida := NULL;

          IF cuitemnovedadpos%isopen THEN

            CLOSE cuitemnovedadpos;

          END IF;

          OPEN cuitemnovedadpos(nuitemnov); --(inuorderid);

          FETCH cuitemnovedadpos

            INTO sbLiquida;

          CLOSE cuitemnovedadpos;



          -- jjsu aranda 2818 -- cuando es novedad de devolucion brilla con signo negativo

          nuSigValor := NULL;

          --<200-2081>
            --si la entrega aplica para la gasera
            IF OPEN.fblAplicaEntrega('OSS_SAT_LCSP_2002081_1') THEN
              dbms_output.put_line('aplica OSS_SAT_LCSP_2002081_1');
              --si aplica para la gasera ejecutar cursor nuevo
              IF sbliquida IS NULL THEN
                 IF cuitemnovedadneg_noVal%isopen THEN
                    CLOSE cuitemnovedadneg_noVal;
                 END IF;
                  OPEN cuitemnovedadneg_noVal(nuitemnov);
                 FETCH cuitemnovedadneg_noVal
                  INTO sbLiquida, nuSigValor;
                 CLOSE cuitemnovedadneg_noVal;
              END IF;
            ELSE
             -- si no aplica para la gasera ejecutar cursor con validacion
              IF sbliquida IS NULL THEN
                 IF cuitemnovedadneg%isopen THEN
                    CLOSE cuitemnovedadneg;
                 END IF;
                  OPEN cuitemnovedadneg(nuitemnov);
                 FETCH cuitemnovedadneg
                  INTO sbLiquida, nuSigValor;
                 CLOSE cuitemnovedadneg;
              END IF;
            END IF;
          --END <200-2081>


          IF nuSigValor IS NULL THEN   --Si no esta configurado como item novedad negativo para devolucion brilla

             nuSigValor := 1;

          END IF;

          dbms_output.put_line('nuSigValor'||nuSigValor);
          dbms_output.put_line('nuSigValor'||nuSigValor);
          dbms_output.put_line('sbliquida'||sbliquida);
          --si item de novedad

          if (sbliquida = 'X') then

            --<<99369

            /*onuvalue := (rtitemslegordennov.value_reference*nuSigValor);

            IF (onuvalue IS NULL) THEN

              onuvalue := 0;

            END IF;*/



            if(rtitemslegordennov.value_reference is not null or rtitemslegordennov.value_reference = 0)then
              dbms_output.put_line('Entro valor no nulo');
              onuvalue := (rtitemslegordennov.value_reference*nusigvalor);

              IF (onuvalue IS NULL) THEN

                onuvalue := 0;

               END IF;

            else
              dbms_output.put_line('Entro valor nulo');
              OPEN cuitemslegorden(nuorden);

              fetch cuitemslegorden

              into nuitem, nucantidad, nuvalor;

              close cuitemslegorden;

              dbms_output.put_line('nucantidad NOVEDAD -->' || nucantidad);

              dbms_output.put_line('nuitem NOVEDAD -->' || nuitem);
              
              dbms_output.put_line('nuorden NOVEDAD -->' || nuorden);

              /*"OPEN".Ge_Bocertcontratista.*/obtenervaloritemlista(nuorden, --rtordenajuste.order_id,

                                                           nuitem, --rtordenajuste.items_id,

                                                           'PRICE',

                                                           onupricelistid,

                                                           onuvalue,

                                                           dtfecha);

              onuvalue := onuvalue * nucantidad;

              dbms_output.put_line('onuvalue NOVEDAD -->' || onuvalue);

            end if;

            onuordercost := onuvalue + onuordercost;

            -->>99369

          END IF;

        END LOOP;

      END IF;



    END IF;

    Ut_Trace.TRACE('-- Total Orden Acumu: '||onuordercost,5);

    --ut_trace.trace('-- Paso 12. Final onuOrderCost -->' || onuOrderCost, 10);

    Ut_Trace.TRACE('Fin [llozada] ldc_procostoorden', 10);


    DBMS_OUTPUT.PUT_LINE('onuOrderCost: '||onuOrderCost);
  EXCEPTION

    WHEN Ex.CONTROLLED_ERROR THEN

      IF cuItemsLegOrden%isopen THEN

        CLOSE cuItemsLegOrden;

      END IF;

      onuOrderCost := -1;

      RAISE;

    WHEN OTHERS THEN

      IF cuItemsLegOrden%isopen THEN

        CLOSE cuItemsLegOrden;

      END IF;

      Errors.setError;

      onuOrderCost := -1;

      RAISE Ex.CONTROLLED_ERROR;



  END;

