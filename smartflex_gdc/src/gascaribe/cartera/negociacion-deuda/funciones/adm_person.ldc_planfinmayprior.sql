CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_PLANFINMAYPRIOR 
(
    nupaproducto    ldc_osf_sesucier.producto%TYPE,
    nupalocalidad   ldc_osf_sesucier.localidad%TYPE,
    nupasegmenpre   ldc_osf_sesucier.segmento_predio%TYPE,
    nupadireccion   pr_product.address_id%TYPE,
    nupacategoria   ldc_osf_sesucier.categoria%TYPE,
    nupasubcateg    ldc_osf_sesucier.subcategoria%TYPE,
    nupaestadcort   ldc_osf_sesucier.estado_corte%TYPE,
    nupaplancomer   pr_product.commercial_plan_id%TYPE,
    nucantfinan     NUMBER,
    nupacuentassl   ldc_osf_sesucier.nro_ctas_con_saldo%TYPE,
    sbpaestadofin   ldc_osf_sesucier.estado_financiero%TYPE,
    nuultplanfina   ldc_osf_sesucier.ultimo_plan_fina%TYPE
)
    RETURN NUMBER
IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    /**************************************************************************
      Autor       : Eduardo Cerón
      Fecha       : 10-12-2018
      Descripcion : Obtenemos plan de financiación de mayor prioridad según
                    segmentación

      Parametros Entrada
        nupaproducto        Producto
        nupalocalidad       Localidad
        nupasegmenpre       Segmento
        nupadireccion       Direciión
        nupacategoria       Categoría
        nupasubcateg        Subcategoría
        nupaestadcort       Estado de corte
        nupaplancomer       Plan comercial
        nucantfinan         Estado corte
        nupacuentassl       Cuentas con saldo
        sbpaestadofin       Estado financiero
        nuultplanfina       Ultimo plan de financiación

      Valor de salida
        nuvaplanfinan       Plan de financiación

     HISTORIA DE MODIFICACIONES
       FECHA            AUTOR           DESCRIPCIÓN
       26/06/2024       jcatuche        OSF-2865: Ajuste para restrigir en la obtención del plan prioritario un plan especial determinado por el parámetro SPECIALS_PLAN
                                        Se estandariza traza y se ajusta objeto según lineamientos.
       10/12/2018       Eduardo Cerón   Creación
     ***************************************************************************/
    -- Constantes para el control de la traza
    csbMetodo       CONSTANT VARCHAR2 (32) := $$PLSQL_UNIT; -- Constante para nombre de función
    csbNivelTraza   CONSTANT NUMBER (2) := pkg_traza.cnuNivelTrzDef; -- Nivel de traza para esta función.
    csbInicio       CONSTANT VARCHAR2 (4) := pkg_traza.fsbINICIO; -- Indica inicio de método
    csbFin          CONSTANT VARCHAR2 (4) := pkg_traza.fsbFIN; -- Indica Fin de método ok
    csbFin_Erc      CONSTANT VARCHAR2 (4) := pkg_traza.fsbFIN_ERC; -- Indica fin de método con error controlado
    csbFin_Err      CONSTANT VARCHAR2 (4) := pkg_traza.fsbFIN_ERR; -- Indica fin de método con error no controlado
    
    sberror                         VARCHAR2(4000);
    nuerror                         NUMBER;
    
    CURSOR cuplanesfinactivos IS
        SELECT s.commercial_segm_id     segmento,
               f.financing_plan_id,
               f.com_seg_finan_id,
               f.priority
          FROM cc_commercial_segm s, cc_com_seg_finan f, plandife p
         WHERE     s.active = 'Y'
               AND f.offer_class = 3
               AND p.pldifefi >= SYSDATE
               AND s.commercial_segm_id = f.commercial_segm_id
               AND f.financing_plan_id = p.pldicodi
               AND not EXISTS
               (
                    select 'x'
                    from ld_parameter
                    where parameter_id = 'SPECIALS_PLAN'
                    and INSTR(','||value_chain||',',','||p.pldicodi||',') > 0 
               );

    CURSOR cudatogeopolitico (
        nucurpasegmento   cc_commercial_segm.commercial_segm_id%TYPE)
    IS
        SELECT t.commercial_segm_id,
               t.geog_geogph_loc_id,
               t.geog_initial_number,
               t.geog_final_number,
               t.geog_segment_id,
               t.geog_address_id,
               t.geog_category_id,
               t.geog_subcategory_id,
               t.com_seg_fea_val_id
          FROM open.cc_com_seg_fea_val t
         WHERE     t.commercial_segm_id = nucurpasegmento
               AND (   t.geog_geogph_loc_id IS NOT NULL
                    OR t.geog_segment_id IS NOT NULL
                    OR t.geog_initial_number IS NOT NULL
                    OR t.geog_final_number IS NOT NULL
                    OR t.geog_address_id IS NOT NULL
                    OR t.geog_category_id IS NOT NULL
                    OR t.geog_subcategory_id IS NOT NULL);

    CURSOR cudatosfinancieros (
        nucurpasegmento   cc_commercial_segm.commercial_segm_id%TYPE)
    IS
        SELECT t.commercial_segm_id,
               t.prod_cutting_state,
               t.prod_commercial_plan,
               t.com_seg_fea_val_id
          FROM open.cc_com_seg_fea_val t
         WHERE     t.commercial_segm_id = nucurpasegmento
               AND (   t.prod_cutting_state IS NOT NULL
                    OR t.prod_commercial_plan IS NOT NULL);

    CURSOR cudatoscomercial (
        nucurpasegmento   cc_commercial_segm.commercial_segm_id%TYPE)
    IS
        SELECT t.commercial_segm_id,
               t.finan_finan_count,
               t.finan_acc_balance,
               t.finan_finan_state,
               t.finan_last_fin_plan,
               t.com_seg_fea_val_id
          FROM open.cc_com_seg_fea_val t
         WHERE     t.commercial_segm_id = nucurpasegmento
               AND (   t.finan_finan_count IS NOT NULL
                    OR t.finan_acc_balance IS NOT NULL
                    OR t.finan_finan_state IS NOT NULL
                    OR t.finan_last_fin_plan IS NOT NULL);
                    
    cursor cuplanfinan is
    SELECT planfinan
    FROM 
    (  
        SELECT x.idplafise     planfinan
        FROM ldc_plfiaplpro x
        WHERE x.producto = nupaproducto
        ORDER BY x.prioridad
    )
    WHERE ROWNUM = 1;
    
    cursor cupoliticas (inuSegmento in cc_commercial_segm.commercial_segm_id%TYPE) is
    SELECT COUNT (1)
    FROM open.cc_com_seg_fea_val t
    WHERE     t.commercial_segm_id = inuSegmento
    AND 
    (   
        t.geog_geogph_loc_id IS NOT NULL
        OR t.geog_segment_id IS NOT NULL
        OR t.geog_initial_number IS NOT NULL
        OR t.geog_final_number IS NOT NULL
        OR t.geog_address_id IS NOT NULL
        OR t.geog_category_id IS NOT NULL
        OR t.geog_subcategory_id IS NOT NULL
    );
         
    cursor cufinancieras (inuSegmento in cc_commercial_segm.commercial_segm_id%TYPE) is
    SELECT COUNT (1)
    FROM open.cc_com_seg_fea_val t
    WHERE     t.commercial_segm_id = inuSegmento
    AND 
    (   
        t.prod_cutting_state IS NOT NULL
        OR t.prod_commercial_plan IS NOT NULL
    ); 
    
    cursor cucomerciales (inuSegmento in cc_commercial_segm.commercial_segm_id%TYPE) is
    SELECT COUNT (1)
    FROM open.cc_com_seg_fea_val t
    WHERE     t.commercial_segm_id = inuSegmento
    AND 
    (   
        t.finan_finan_count IS NOT NULL
        OR t.finan_acc_balance IS NOT NULL
        OR t.finan_finan_state IS NOT NULL
        OR t.finan_last_fin_plan IS NOT NULL
    );
                              

    nucontageopolitico       NUMBER (10);
    nucontafinanciero        NUMBER (10);
    nucontacomercial         NUMBER (10);
    nucontaaplica            NUMBER (10);
    nucantfinconf            cc_com_seg_fea_val.finan_finan_count%TYPE;
    nucantfinprod            cc_com_seg_fea_val.finan_finan_count%TYPE;
    nucuentasconf            cc_com_seg_fea_val.finan_acc_balance%TYPE;
    nucuentasprod            cc_com_seg_fea_val.finan_acc_balance%TYPE;
    sbestfinaconf            cc_com_seg_fea_val.finan_finan_state%TYPE;
    sbestfinaprod            cc_com_seg_fea_val.finan_finan_state%TYPE;
    nuultplanconf            cc_com_seg_fea_val.finan_last_fin_plan%TYPE;
    nuultplanprod            cc_com_seg_fea_val.finan_last_fin_plan%TYPE;
    nuestacorconf            cc_com_seg_fea_val.prod_cutting_state%TYPE;
    nuestacorprod            cc_com_seg_fea_val.prod_cutting_state%TYPE;
    nuplnacomconf            cc_com_seg_fea_val.prod_commercial_plan%TYPE;
    nuplnacomprod            cc_com_seg_fea_val.prod_commercial_plan%TYPE;
    nulocalidconf            cc_com_seg_fea_val.geog_geogph_loc_id%TYPE;
    nulocalidprod            cc_com_seg_fea_val.geog_geogph_loc_id%TYPE;
    nusegmentconf            cc_com_seg_fea_val.geog_segment_id%TYPE;
    nusegmentprod            cc_com_seg_fea_val.geog_segment_id%TYPE;
    nudirecciconf            cc_com_seg_fea_val.geog_address_id%TYPE;
    nudirecciprod            cc_com_seg_fea_val.geog_address_id%TYPE;
    nucategorconf            cc_com_seg_fea_val.geog_category_id%TYPE;
    nucategorprod            cc_com_seg_fea_val.geog_category_id%TYPE;
    nusubcateconf            cc_com_seg_fea_val.geog_subcategory_id%TYPE;
    nusubcateprod            cc_com_seg_fea_val.geog_subcategory_id%TYPE;
    nuvaplanfinan            plandife.pldicodi%TYPE;
BEGIN
    pkg_traza.trace (csbMetodo, csbNivelTraza, csbInicio);
    pkg_traza.trace('nupaproducto   <= '||nupaproducto, csbNivelTraza);
    pkg_traza.trace('nupalocalidad  <= '||nupalocalidad, csbNivelTraza);
    pkg_traza.trace('nupasegmenpre  <= '||nupasegmenpre, csbNivelTraza);
    pkg_traza.trace('nupadireccion  <= '||nupadireccion, csbNivelTraza);
    pkg_traza.trace('nupacategoria  <= '||nupacategoria, csbNivelTraza);
    pkg_traza.trace('nupasubcateg   <= '||nupasubcateg, csbNivelTraza);
    pkg_traza.trace('nupaestadcort  <= '||nupaestadcort, csbNivelTraza);
    pkg_traza.trace('nupaplancomer  <= '||nupaplancomer, csbNivelTraza);
    pkg_traza.trace('nucantfinan    <= '||nucantfinan, csbNivelTraza);
    pkg_traza.trace('nupacuentassl  <= '||nupacuentassl, csbNivelTraza);
    pkg_traza.trace('sbpaestadofin  <= '||sbpaestadofin, csbNivelTraza);
    pkg_traza.trace('nuultplanfina  <= '||nuultplanfina, csbNivelTraza);
    
    --cierre de cursores
    if cuplanfinan%isopen then
        close cuplanfinan;
    end if;
    
    if cupoliticas%isopen then
        close cupoliticas;
    end if;
    
    if cufinancieras%isopen then
        close cufinancieras;
    end if;
    
    if cucomerciales%isopen then
        close cucomerciales;
    end if;
    
    pkg_traza.trace('Borrado ldc_plfiaplpro para el producto', csbNivelTraza);
    DELETE ldc_plfiaplpro
    WHERE producto = nupaproducto;

    FOR j IN cuplanesfinactivos
    LOOP
        -- Caracteristicas geopoliticas
        nucontageopolitico := 0;
        open cupoliticas (j.segmento);
        fetch cupoliticas into nucontageopolitico;
        close cupoliticas;
        
        -- Características financieras
        nucontafinanciero := 0;
        open cufinancieras (j.segmento);
        fetch cufinancieras into nucontafinanciero;
        close cufinancieras;
        
        -- Características comerciales
        nucontacomercial :=  0;
        open cucomerciales (j.segmento);
        fetch cucomerciales into nucontacomercial;
        close cucomerciales;
        
        -- Validamos si tiene configuración en características geopoliticas,financieras y comerciales

        IF     nucontageopolitico >= 1
           AND nucontafinanciero >= 1
           AND nucontacomercial >= 1
        THEN
            -- Características geopoliticas
            FOR k IN cudatogeopolitico (j.segmento)
            LOOP
                IF k.geog_geogph_loc_id IS NOT NULL
                THEN
                    nulocalidconf := k.geog_geogph_loc_id;
                    nulocalidprod := nupalocalidad;
                ELSE
                    nulocalidconf := -1;
                    nulocalidprod := -1;
                END IF;

                IF k.geog_segment_id IS NOT NULL
                THEN
                    nusegmentconf := k.geog_segment_id;
                    nusegmentprod := nupasegmenpre;
                ELSE
                    nusegmentconf := -1;
                    nusegmentprod := -1;
                END IF;

                IF k.geog_address_id IS NOT NULL
                THEN
                    nudirecciconf := k.geog_address_id;
                    nudirecciprod := nupadireccion;
                ELSE
                    nudirecciconf := -1;
                    nudirecciprod := -1;
                END IF;

                IF k.geog_category_id IS NOT NULL
                THEN
                    nucategorconf := k.geog_category_id;
                    nucategorprod := nupacategoria;
                ELSE
                    nucategorconf := -1;
                    nucategorprod := -1;
                END IF;

                IF k.geog_subcategory_id IS NOT NULL
                THEN
                    nusubcateconf := k.geog_subcategory_id;
                    nusubcateprod := nupasubcateg;
                ELSE
                    nusubcateconf := -1;
                    nusubcateprod := -1;
                END IF;

                -- Características financieras
                FOR m IN cudatosfinancieros (j.segmento)
                LOOP
                    IF m.prod_cutting_state IS NOT NULL
                    THEN
                        nuestacorconf := m.prod_cutting_state;
                        nuestacorprod := nupaestadcort;
                    ELSE
                        nuestacorconf := -1;
                        nuestacorprod := -1;
                    END IF;

                    IF m.prod_commercial_plan IS NOT NULL
                    THEN
                        nuplnacomconf := m.prod_commercial_plan;
                        nuplnacomprod := nupaplancomer;
                    ELSE
                        nuplnacomconf := -1;
                        nuplnacomprod := -1;
                    END IF;

                    -- Características comerciales
                    FOR n IN cudatoscomercial (j.segmento)
                    LOOP
                        IF n.finan_finan_count IS NOT NULL
                        THEN
                            nucantfinconf := n.finan_finan_count;
                            nucantfinprod := nucantfinan;
                        ELSE
                            nucantfinconf := -1;
                            nucantfinprod := -1;
                        END IF;

                        IF n.finan_acc_balance IS NOT NULL
                        THEN
                            nucuentasconf := n.finan_acc_balance;
                            nucuentasprod := nupacuentassl;
                        ELSE
                            nucuentasconf := -1;
                            nucuentasprod := -1;
                        END IF;

                        IF n.finan_finan_state IS NOT NULL
                        THEN
                            sbestfinaconf := n.finan_finan_state;
                            sbestfinaprod := sbpaestadofin;
                        ELSE
                            sbestfinaconf := '-';
                            sbestfinaprod := '-';
                        END IF;

                        IF n.finan_last_fin_plan IS NOT NULL
                        THEN
                            nuultplanconf := n.finan_last_fin_plan;
                            nuultplanprod := nuultplanfina;
                        ELSE
                            nuultplanconf := -1;
                            nuultplanprod := -1;
                        END IF;

                        IF     nulocalidconf = nulocalidprod
                           AND nusegmentconf = nusegmentprod
                           AND nudirecciconf = nudirecciprod
                           AND nucategorconf = nucategorprod
                           AND nusubcateconf = nusubcateprod
                           AND nuestacorconf = nuestacorprod
                           AND nuplnacomconf = nuplnacomprod
                           AND nucantfinconf = nucantfinprod
                           AND nucuentasconf = nucuentasprod
                           AND sbestfinaconf = sbestfinaprod
                           AND nuultplanconf = nuultplanprod
                        THEN
                            pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', csbNivelTraza);
                            pkg_traza.trace('Conteo Geopolítico : '||nucontageopolitico, csbNivelTraza);
                            pkg_traza.trace('Conteo Financiero  : '||nucontafinanciero, csbNivelTraza);
                            pkg_traza.trace('Conteo Comercial   : '||nucontacomercial, csbNivelTraza);
                            pkg_traza.trace('-------------------------------------------------------', csbNivelTraza);
                            pkg_traza.trace('Segmento           : '||j.com_seg_finan_id, csbNivelTraza);
                            pkg_traza.trace('Prioridad          : '||j.priority, csbNivelTraza);
                            pkg_traza.trace('Plan Financiación  : '||j.financing_plan_id, csbNivelTraza);
                            pkg_traza.trace('=======================================================', csbNivelTraza);
                            INSERT INTO ldc_plfiaplpro (producto,
                                                        idplafise,
                                                        prioridad,
                                                        iden)
                                 VALUES (nupaproducto,
                                         j.financing_plan_id,
                                         j.priority,
                                         j.com_seg_finan_id);

                            COMMIT;
                        END IF;

                        COMMIT;
                    END LOOP;
                END LOOP;
            END LOOP;
        -- Validamos si tiene configuración en características geopoliticas y financieras
        ELSIF     nucontageopolitico >= 1
              AND nucontafinanciero >= 1
              AND nucontacomercial = 0
        THEN
            -- Características geopoliticas
            FOR k IN cudatogeopolitico (j.segmento)
            LOOP
                IF k.geog_geogph_loc_id IS NOT NULL
                THEN
                    nulocalidconf := k.geog_geogph_loc_id;
                    nulocalidprod := nupalocalidad;
                ELSE
                    nulocalidconf := -1;
                    nulocalidprod := -1;
                END IF;

                IF k.geog_segment_id IS NOT NULL
                THEN
                    nusegmentconf := k.geog_segment_id;
                    nusegmentprod := nupasegmenpre;
                ELSE
                    nusegmentconf := -1;
                    nusegmentprod := -1;
                END IF;

                IF k.geog_address_id IS NOT NULL
                THEN
                    nudirecciconf := k.geog_address_id;
                    nudirecciprod := nupadireccion;
                ELSE
                    nudirecciconf := -1;
                    nudirecciprod := -1;
                END IF;

                IF k.geog_category_id IS NOT NULL
                THEN
                    nucategorconf := k.geog_category_id;
                    nucategorprod := nupacategoria;
                ELSE
                    nucategorconf := -1;
                    nucategorprod := -1;
                END IF;

                IF k.geog_subcategory_id IS NOT NULL
                THEN
                    nusubcateconf := k.geog_subcategory_id;
                    nusubcateprod := nupasubcateg;
                ELSE
                    nusubcateconf := -1;
                    nusubcateprod := -1;
                END IF;

                -- Características financieras
                FOR m IN cudatosfinancieros (j.segmento)
                LOOP
                    IF m.prod_cutting_state IS NOT NULL
                    THEN
                        nuestacorconf := m.prod_cutting_state;
                        nuestacorprod := nupaestadcort;
                    ELSE
                        nuestacorconf := -1;
                        nuestacorprod := -1;
                    END IF;

                    IF m.prod_commercial_plan IS NOT NULL
                    THEN
                        nuplnacomconf := m.prod_commercial_plan;
                        nuplnacomprod := nupaplancomer;
                    ELSE
                        nuplnacomconf := -1;
                        nuplnacomprod := -1;
                    END IF;

                    IF     nulocalidconf = nulocalidprod
                       AND nusegmentconf = nusegmentprod
                       AND nudirecciconf = nudirecciprod
                       AND nucategorconf = nucategorprod
                       AND nusubcateconf = nusubcateprod
                       AND nuestacorconf = nuestacorprod
                       AND nuplnacomconf = nuplnacomprod
                    THEN
                        pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', csbNivelTraza);
                        pkg_traza.trace('Conteo Geopolítico : '||nucontageopolitico, csbNivelTraza);
                        pkg_traza.trace('Conteo Financiero  : '||nucontafinanciero, csbNivelTraza);
                        pkg_traza.trace('Conteo Comercial   : '||nucontacomercial, csbNivelTraza);
                        pkg_traza.trace('-------------------------------------------------------', csbNivelTraza);
                        pkg_traza.trace('Segmento           : '||j.com_seg_finan_id, csbNivelTraza);
                        pkg_traza.trace('Prioridad          : '||j.priority, csbNivelTraza);
                        pkg_traza.trace('Plan Financiación  : '||j.financing_plan_id, csbNivelTraza);
                        pkg_traza.trace('=======================================================', csbNivelTraza);
                        INSERT INTO ldc_plfiaplpro (producto,
                                                    idplafise,
                                                    prioridad,
                                                    iden)
                             VALUES (nupaproducto,
                                     j.financing_plan_id,
                                     j.priority,
                                     j.com_seg_finan_id);

                        COMMIT;
                    END IF;

                    COMMIT;
                END LOOP;
            END LOOP;
        -- Validamos si tiene configuración en características geopoliticas y comercial

        ELSIF     nucontageopolitico >= 1
              AND nucontafinanciero = 0
              AND nucontacomercial >= 1
        THEN
            -- Características geopoliticas
            FOR k IN cudatogeopolitico (j.segmento)
            LOOP
                IF k.geog_geogph_loc_id IS NOT NULL
                THEN
                    nulocalidconf := k.geog_geogph_loc_id;
                    nulocalidprod := nupalocalidad;
                ELSE
                    nulocalidconf := -1;
                    nulocalidprod := -1;
                END IF;

                IF k.geog_segment_id IS NOT NULL
                THEN
                    nusegmentconf := k.geog_segment_id;
                    nusegmentprod := nupasegmenpre;
                ELSE
                    nusegmentconf := -1;
                    nusegmentprod := -1;
                END IF;

                IF k.geog_address_id IS NOT NULL
                THEN
                    nudirecciconf := k.geog_address_id;
                    nudirecciprod := nupadireccion;
                ELSE
                    nudirecciconf := -1;
                    nudirecciprod := -1;
                END IF;

                IF k.geog_category_id IS NOT NULL
                THEN
                    nucategorconf := k.geog_category_id;
                    nucategorprod := nupacategoria;
                ELSE
                    nucategorconf := -1;
                    nucategorprod := -1;
                END IF;

                IF k.geog_subcategory_id IS NOT NULL
                THEN
                    nusubcateconf := k.geog_subcategory_id;
                    nusubcateprod := nupasubcateg;
                ELSE
                    nusubcateconf := -1;
                    nusubcateprod := -1;
                END IF;

                -- Características comerciales
                FOR n IN cudatoscomercial (j.segmento)
                LOOP
                    IF n.finan_finan_count IS NOT NULL
                    THEN
                        nucantfinconf := n.finan_finan_count;
                        nucantfinprod := nucantfinan;
                    ELSE
                        nucantfinconf := -1;
                        nucantfinprod := -1;
                    END IF;

                    IF n.finan_acc_balance IS NOT NULL
                    THEN
                        nucuentasconf := n.finan_acc_balance;
                        nucuentasprod := nupacuentassl;
                    ELSE
                        nucuentasconf := -1;
                        nucuentasprod := -1;
                    END IF;

                    IF n.finan_finan_state IS NOT NULL
                    THEN
                        sbestfinaconf := n.finan_finan_state;
                        sbestfinaprod := sbpaestadofin;
                    ELSE
                        sbestfinaconf := '-';
                        sbestfinaprod := '-';
                    END IF;

                    IF n.finan_last_fin_plan IS NOT NULL
                    THEN
                        nuultplanconf := n.finan_last_fin_plan;
                        nuultplanprod := nuultplanfina;
                    ELSE
                        nuultplanconf := -1;
                        nuultplanprod := -1;
                    END IF;

                    IF     nulocalidconf = nulocalidprod
                       AND nusegmentconf = nusegmentprod
                       AND nudirecciconf = nudirecciprod
                       AND nucategorconf = nucategorprod
                       AND nusubcateconf = nusubcateprod
                       AND nucantfinconf = nucantfinprod
                       AND nucuentasconf = nucuentasprod
                       AND sbestfinaconf = sbestfinaprod
                       AND nuultplanconf = nuultplanprod
                    THEN
                        pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', csbNivelTraza);
                        pkg_traza.trace('Conteo Geopolítico : '||nucontageopolitico, csbNivelTraza);
                        pkg_traza.trace('Conteo Financiero  : '||nucontafinanciero, csbNivelTraza);
                        pkg_traza.trace('Conteo Comercial   : '||nucontacomercial, csbNivelTraza);
                        pkg_traza.trace('-------------------------------------------------------', csbNivelTraza);
                        pkg_traza.trace('Segmento           : '||j.com_seg_finan_id, csbNivelTraza);
                        pkg_traza.trace('Prioridad          : '||j.priority, csbNivelTraza);
                        pkg_traza.trace('Plan Financiación  : '||j.financing_plan_id, csbNivelTraza);
                        pkg_traza.trace('=======================================================', csbNivelTraza);
                        INSERT INTO ldc_plfiaplpro (producto,
                                                    idplafise,
                                                    prioridad,
                                                    iden)
                             VALUES (nupaproducto,
                                     j.financing_plan_id,
                                     j.priority,
                                     j.com_seg_finan_id);

                        COMMIT;
                    END IF;
                END LOOP;
            END LOOP;
        -- Validamos si solo tiene configuración en características geopoliticas
        ELSIF     nucontageopolitico >= 1
              AND nucontafinanciero = 0
              AND nucontacomercial = 0
        THEN
            -- Características geopoliticas
            FOR k IN cudatogeopolitico (j.segmento)
            LOOP
                IF k.geog_geogph_loc_id IS NOT NULL
                THEN
                    nulocalidconf := k.geog_geogph_loc_id;
                    nulocalidprod := nupalocalidad;
                ELSE
                    nulocalidconf := -1;
                    nulocalidprod := -1;
                END IF;

                IF k.geog_segment_id IS NOT NULL
                THEN
                    nusegmentconf := k.geog_segment_id;
                    nusegmentprod := nupasegmenpre;
                ELSE
                    nusegmentconf := -1;
                    nusegmentprod := -1;
                END IF;

                IF k.geog_address_id IS NOT NULL
                THEN
                    nudirecciconf := k.geog_address_id;
                    nudirecciprod := nupadireccion;
                ELSE
                    nudirecciconf := -1;
                    nudirecciprod := -1;
                END IF;

                IF k.geog_category_id IS NOT NULL
                THEN
                    nucategorconf := k.geog_category_id;
                    nucategorprod := nupacategoria;
                ELSE
                    nucategorconf := -1;
                    nucategorprod := -1;
                END IF;

                IF k.geog_subcategory_id IS NOT NULL
                THEN
                    nusubcateconf := k.geog_subcategory_id;
                    nusubcateprod := nupasubcateg;
                ELSE
                    nusubcateconf := -1;
                    nusubcateprod := -1;
                END IF;

                nucontaaplica := 0;

                IF     nulocalidconf = nulocalidprod
                   AND nusegmentconf = nusegmentprod
                   AND nudirecciconf = nudirecciprod
                   AND nucategorconf = nucategorprod
                   AND nusubcateconf = nusubcateprod
                THEN
                    pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', csbNivelTraza);
                    pkg_traza.trace('Conteo Geopolítico : '||nucontageopolitico, csbNivelTraza);
                    pkg_traza.trace('Conteo Financiero  : '||nucontafinanciero, csbNivelTraza);
                    pkg_traza.trace('Conteo Comercial   : '||nucontacomercial, csbNivelTraza);
                    pkg_traza.trace('-------------------------------------------------------', csbNivelTraza);
                    pkg_traza.trace('Segmento           : '||j.com_seg_finan_id, csbNivelTraza);
                    pkg_traza.trace('Prioridad          : '||j.priority, csbNivelTraza);
                    pkg_traza.trace('Plan Financiación  : '||j.financing_plan_id, csbNivelTraza);
                    pkg_traza.trace('=======================================================', csbNivelTraza);
                    INSERT INTO ldc_plfiaplpro (producto,
                                                idplafise,
                                                prioridad,
                                                iden)
                         VALUES (nupaproducto,
                                 j.financing_plan_id,
                                 j.priority,
                                 j.com_seg_finan_id);

                    COMMIT;
                END IF;
            END LOOP;
        -- Validamos si tiene configuración en características financieras y comercial
        ELSIF     nucontageopolitico = 0
              AND nucontafinanciero >= 1
              AND nucontacomercial >= 1
        THEN
            -- Características financieras
            FOR m IN cudatosfinancieros (j.segmento)
            LOOP
                IF m.prod_cutting_state IS NOT NULL
                THEN
                    nuestacorconf := m.prod_cutting_state;
                    nuestacorprod := nupaestadcort;
                ELSE
                    nuestacorconf := -1;
                    nuestacorprod := -1;
                END IF;

                IF m.prod_commercial_plan IS NOT NULL
                THEN
                    nuplnacomconf := m.prod_commercial_plan;
                    nuplnacomprod := nupaplancomer;
                ELSE
                    nuplnacomconf := -1;
                    nuplnacomprod := -1;
                END IF;

                -- Características comerciales
                FOR n IN cudatoscomercial (j.segmento)
                LOOP
                    IF n.finan_finan_count IS NOT NULL
                    THEN
                        nucantfinconf := n.finan_finan_count;
                        nucantfinprod := nucantfinan;
                    ELSE
                        nucantfinconf := -1;
                        nucantfinprod := -1;
                    END IF;

                    IF n.finan_acc_balance IS NOT NULL
                    THEN
                        nucuentasconf := n.finan_acc_balance;
                        nucuentasprod := nupacuentassl;
                    ELSE
                        nucuentasconf := -1;
                        nucuentasprod := -1;
                    END IF;

                    IF n.finan_finan_state IS NOT NULL
                    THEN
                        sbestfinaconf := n.finan_finan_state;
                        sbestfinaprod := sbpaestadofin;
                    ELSE
                        sbestfinaconf := '-';
                        sbestfinaprod := '-';
                    END IF;

                    IF n.finan_last_fin_plan IS NOT NULL
                    THEN
                        nuultplanconf := n.finan_last_fin_plan;
                        nuultplanprod := nuultplanfina;
                    ELSE
                        nuultplanconf := -1;
                        nuultplanprod := -1;
                    END IF;

                    IF     nuestacorconf = nuestacorprod
                       AND nuplnacomconf = nuplnacomprod
                       AND nucantfinconf = nucantfinprod
                       AND nucuentasconf = nucuentasprod
                       AND sbestfinaconf = sbestfinaprod
                       AND nuultplanconf = nuultplanprod
                    THEN
                        pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', csbNivelTraza);
                        pkg_traza.trace('Conteo Geopolítico : '||nucontageopolitico, csbNivelTraza);
                        pkg_traza.trace('Conteo Financiero  : '||nucontafinanciero, csbNivelTraza);
                        pkg_traza.trace('Conteo Comercial   : '||nucontacomercial, csbNivelTraza);
                        pkg_traza.trace('-------------------------------------------------------', csbNivelTraza);
                        pkg_traza.trace('Segmento           : '||j.com_seg_finan_id, csbNivelTraza);
                        pkg_traza.trace('Prioridad          : '||j.priority, csbNivelTraza);
                        pkg_traza.trace('Plan Financiación  : '||j.financing_plan_id, csbNivelTraza);
                        pkg_traza.trace('=======================================================', csbNivelTraza);
                        INSERT INTO ldc_plfiaplpro (producto,
                                                    idplafise,
                                                    prioridad,
                                                    iden)
                             VALUES (nupaproducto,
                                     j.financing_plan_id,
                                     j.priority,
                                     j.com_seg_finan_id);

                        COMMIT;
                    END IF;
                END LOOP;
            END LOOP;
        -- Validamos si solo tiene configuración en características financieras
        ELSIF     nucontageopolitico = 0
              AND nucontafinanciero >= 1
              AND nucontacomercial = 0
        THEN
            -- Características financieras
            FOR m IN cudatosfinancieros (j.segmento)
            LOOP
                IF m.prod_cutting_state IS NOT NULL
                THEN
                    nuestacorconf := m.prod_cutting_state;
                    nuestacorprod := nupaestadcort;
                ELSE
                    nuestacorconf := -1;
                    nuestacorprod := -1;
                END IF;

                IF m.prod_commercial_plan IS NOT NULL
                THEN
                    nuplnacomconf := m.prod_commercial_plan;
                    nuplnacomprod := nupaplancomer;
                ELSE
                    nuplnacomconf := -1;
                    nuplnacomprod := -1;
                END IF;

                nucontaaplica := 0;

                IF     nuestacorconf = nuestacorprod
                   AND nuplnacomconf = nuplnacomprod
                THEN
                    pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', csbNivelTraza);
                    pkg_traza.trace('Conteo Geopolítico : '||nucontageopolitico, csbNivelTraza);
                    pkg_traza.trace('Conteo Financiero  : '||nucontafinanciero, csbNivelTraza);
                    pkg_traza.trace('Conteo Comercial   : '||nucontacomercial, csbNivelTraza);
                    pkg_traza.trace('-------------------------------------------------------', csbNivelTraza);
                    pkg_traza.trace('Segmento           : '||j.com_seg_finan_id, csbNivelTraza);
                    pkg_traza.trace('Prioridad          : '||j.priority, csbNivelTraza);
                    pkg_traza.trace('Plan Financiación  : '||j.financing_plan_id, csbNivelTraza);
                    pkg_traza.trace('=======================================================', csbNivelTraza);
                    INSERT INTO ldc_plfiaplpro (producto,
                                                idplafise,
                                                prioridad,
                                                iden)
                         VALUES (nupaproducto,
                                 j.financing_plan_id,
                                 j.priority,
                                 j.com_seg_finan_id);

                    COMMIT;
                END IF;
            END LOOP;
        -- Validamos si solo tiene configuración en características comerciales

        ELSIF nucontageopolitico = 0
              AND nucontafinanciero = 0
              AND nucontacomercial >= 1
        THEN
            -- Características comerciales
            FOR n IN cudatoscomercial (j.segmento)
            LOOP
                IF n.finan_finan_count IS NOT NULL
                THEN
                    nucantfinconf := n.finan_finan_count;
                    nucantfinprod := nucantfinan;
                ELSE
                    nucantfinconf := -1;
                    nucantfinprod := -1;
                END IF;

                IF n.finan_acc_balance IS NOT NULL
                THEN
                    nucuentasconf := n.finan_acc_balance;
                    nucuentasprod := nupacuentassl;
                ELSE
                    nucuentasconf := -1;
                    nucuentasprod := -1;
                END IF;

                IF n.finan_finan_state IS NOT NULL
                THEN
                    sbestfinaconf := n.finan_finan_state;
                    sbestfinaprod := sbpaestadofin;
                ELSE
                    sbestfinaconf := '-';
                    sbestfinaprod := '-';
                END IF;

                IF n.finan_last_fin_plan IS NOT NULL
                THEN
                    nuultplanconf := n.finan_last_fin_plan;
                    nuultplanprod := nuultplanfina;
                ELSE
                    nuultplanconf := -1;
                    nuultplanprod := -1;
                END IF;

                nucontaaplica := 0;

                IF     nucantfinconf = nucantfinprod
                   AND nucuentasconf = nucuentasprod
                   AND sbestfinaconf = sbestfinaprod
                   AND nuultplanconf = nuultplanprod
                THEN
                    pkg_traza.trace('Inserta en ldc_plfiaplpro para el producto', csbNivelTraza);
                    pkg_traza.trace('Conteo Geopolítico : '||nucontageopolitico, csbNivelTraza);
                    pkg_traza.trace('Conteo Financiero  : '||nucontafinanciero, csbNivelTraza);
                    pkg_traza.trace('Conteo Comercial   : '||nucontacomercial, csbNivelTraza);
                    pkg_traza.trace('-------------------------------------------------------', csbNivelTraza);
                    pkg_traza.trace('Segmento           : '||j.com_seg_finan_id, csbNivelTraza);
                    pkg_traza.trace('Prioridad          : '||j.priority, csbNivelTraza);
                    pkg_traza.trace('Plan Financiación  : '||j.financing_plan_id, csbNivelTraza);
                    pkg_traza.trace('=======================================================', csbNivelTraza);
                    INSERT INTO ldc_plfiaplpro (producto,
                                                idplafise,
                                                prioridad,
                                                iden)
                         VALUES (nupaproducto,
                                 j.financing_plan_id,
                                 j.priority,
                                 j.com_seg_finan_id);

                    COMMIT;
                END IF;
            END LOOP;
        END IF;
    END LOOP;
    
    nuvaplanfinan := null;
    open cuplanfinan;
    fetch cuplanfinan into nuvaplanfinan;
    close cuplanfinan;

    pkg_traza.trace('return => '||nuvaplanfinan, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);        
    RETURN nuvaplanfinan;    
    
EXCEPTION
    WHEN OTHERS THEN 
        nuvaplanfinan  := -1;
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace('return => '||nuvaplanfinan, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
        RETURN nuvaplanfinan;    
END ldc_planfinmayprior;
/

BEGIN
    pkg_utilidades.prAplicarPermisos ('LDC_PLANFINMAYPRIOR', 'ADM_PERSON');
END;
/