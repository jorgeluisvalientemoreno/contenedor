CREATE OR REPLACE PACKAGE adm_person.ldci_pkinterfazlistprecsap AS
  /*************************************************************************************************************************
      Autor       : John Jairo Jimenez Marimon
      Fecha       : 2018-07-04
      Descripcion : Paquete creacion listas de precio por Interfaz

      Parametros Entrada

      Valor de salida

     HISTORIA DE MODIFICACIONES
       FECHA        AUTOR       DESCRIPCION
	12/12/2019	ESANTIAGO       caso: 207 Se agrega procedimiento LDC_MAILLISTCOST .
					(HORBATH)
    06/02/2023   Jose Donado    INT-249 Ajuste a procedimiento ldci_procesaxmlitemslistprec para notificar 
                                      inicio y finalización de proceso via email
    26/04/2024  jpinedc         OSF-2581-  LDC_MAILLISTCOST: Se cambia ldc_sendemail 
                                por pkg_Correo.prcEnviaCorreo
    18/06/2024   Adrianavg      OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
  *************************************************************************************************************************/
  PROCEDURE ldci_procllenatablainterfaz(nupaidproceso  NUMBER,
                                        nupacoditems   NUMBER,
                                        nupacostoitmes NUMBER,
                                        fechaInicial   Varchar2,
                                        fechaFinal     Varchar2,
                                        nupainserror   OUT NUMBER,
                                        sbpainserror   OUT VARCHAR2);
  PROCEDURE ldci_proccrealistaprecinterfaz(nupacodlitinterfaz NUMBER,
                                           nunumerrorsal      OUT NUMBER,
                                           sberrorsalida      OUT VARCHAR2);
  PROCEDURE ldci_procesaxmlitemslistprec(xmlpar    CLOB,
                                         nupaerror OUT NUMBER,
                                         sbpaerror OUT VARCHAR2);

  /*
  * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
  *
  * Proceso     : proProcesaXMLListaPrecio
  * Tiquete     :
  * Fecha       : 26-11-2018
  * Descripcion : Se encarga de procesar las listas de precios enviadas desde SAP

  * Historia de Modificaciones
  * Autor       Fecha           Descripcion
  * jdonado     26/11/2018      Creacion bajo el caso 200-1596
  *
  *
  **/

  PROCEDURE proProcesaXMLListaPrecio(CODIGO        In Number,
                                     INBOX_ID      in VARCHAR2,
                                     inuProcesoExt in NUMBER,
                                     isbSistema    in VARCHAR2,
                                     isbOperacion  in VARCHAR2,
                                     isbXML        in CLOB,
                                     inuContrato   in Varchar2,
                                     inuProducto   in Varchar2,
                                     inuUnid_oper  in number,
                                     inuOrden      in number,
                                     ocurRespuesta Out SYS_REFCURSOR,
                                     onuErrorCodi  out NUMBER,
                                     osbErrorMsg   out VARCHAR2);

  PROCEDURE LDC_MAILLISTCOST (sbmensa  VARCHAR2 );

END ldci_pkinterfazlistprecsap;
/

CREATE OR REPLACE PACKAGE BODY adm_person.ldci_pkinterfazlistprecsap
AS
    PROCEDURE ldci_procllenatablainterfaz (nupaidproceso        NUMBER,
                                           nupacoditems         NUMBER,
                                           nupacostoitmes       NUMBER,
                                           fechaInicial         VARCHAR2,
                                           fechaFinal           VARCHAR2,
                                           nupainserror     OUT NUMBER,
                                           sbpainserror     OUT VARCHAR2)
    AS
        /*************************************************************************************************************************
           Autor       : John Jairo Jimenez Marimon
           Fecha       : 2018-07-04
           Descripcion : Proceso para crear la informacion de listas de precio en las tablas de interfax, MAESTRO - DETALLE

           Parametros Entrada

           Valor de salida

          HISTORIA DE MODIFICACIONES
           FECHA         AUTOR              DESCRIPCION
           22/11/2018    Daniel Valiente    Se agrego la Fecha Inicial y Fecha Final (CA2001596)
        *************************************************************************************************************************/
        nucodigointerfaz      ldci_intelistpr.codigo%TYPE;
        nucodigointerfazdet   ldci_intdetlistprec.codigo%TYPE;
        dtvafechaini          DATE;
        dtvafechafin          DATE;
        nuconta               NUMBER (10);
        nucontaitem           NUMBER (10);
    BEGIN

        dtvafechaini :=
            TO_DATE (
                   SUBSTR (fechaInicial, 7, 2)
                || '/'
                || SUBSTR (fechaInicial, 5, 2)
                || '/'
                || SUBSTR (fechaInicial, 1, 4)
                || ' 00:00:00',
                'dd/mm/yyyy hh24:mi:ss');
        dtvafechafin :=
            TO_DATE (
                   SUBSTR (fechaFinal, 7, 2)
                || '/'
                || SUBSTR (fechaFinal, 5, 2)
                || '/'
                || SUBSTR (fechaFinal, 1, 4)
                || ' 23:59:59',
                'dd/mm/yyyy hh24:mi:ss');

        --
        -- Insertamos registro maestro de interfaz.
        SELECT COUNT (1)
          INTO nuconta
          FROM ldci_intelistpr c
         WHERE c.codigo = nupaidproceso;

        IF nuconta >= 1
        THEN
            nucodigointerfaz := nupaidproceso;
        ELSE
            nucodigointerfaz := nupaidproceso;

            INSERT INTO ldci_intelistpr (codigo,
                                         descripcion,
                                         fecha_ini_vigen,
                                         fecha_final_vige,
                                         fecha_registro,
                                         usuario,
                                         estado,
                                         mensaje)
                 VALUES (nucodigointerfaz,
                         'LISTA DE PRECIOS ' || TO_CHAR (nucodigointerfaz),
                         dtvafechaini,
                         dtvafechafin,
                         SYSDATE,
                         USER,
                         1,
                         'Registro Ok.');
        END IF;

        -- Insertamos registro detalle de interfaz.
        nucodigointerfazdet := seq_ldci_intdetlistprec.NEXTVAL;

        SELECT COUNT (1)
          INTO nucontaitem
          FROM ldci_intdetlistprec ci
         WHERE     ci.codigo_interfaz = nucodigointerfaz
               AND ci.codigo_item = nupacoditems;

        IF nucontaitem >= 1
        THEN
            UPDATE ldci_intdetlistprec f
               SET f.costo_items = nupacostoitmes
             WHERE     f.codigo_interfaz = nucodigointerfaz
                   AND f.codigo_item = nupacoditems;
        ELSE
            INSERT INTO ldci_intdetlistprec (codigo,
                                             codigo_interfaz,
                                             codigo_item,
                                             costo_items)
                 VALUES (nucodigointerfazdet,
                         nucodigointerfaz,
                         nupacoditems,
                         nupacostoitmes);
        END IF;

        COMMIT;
        nupainserror := 0;
        sbpainserror := 'Termino Ok.';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            nupainserror := -1;
            sbpainserror := SQLERRM;
    END ldci_procllenatablainterfaz;

    PROCEDURE ldci_proccrealistaprecinterfaz (
        nupacodlitinterfaz       NUMBER,
        nunumerrorsal        OUT NUMBER,
        sberrorsalida        OUT VARCHAR2)
    AS
        /*************************************************************************************************************************
            Autor       : John Jairo Jimenez Marimon
            Fecha       : 2018-07-04
            Descripcion : Proceso para crear la informacion de listas de precio en las tablas de interfax, MAESTRO - DETALLE

            Parametros Entrada

            Valor de salida

           HISTORIA DE MODIFICACIONES
             FECHA        AUTOR   DESCRIPCION
       12/12/2019 ESANTIAGO caso:207 Se modifica el calculo de precios y costos del item proveniente de la interface SAP.
         (HORBATH)


        *************************************************************************************************************************/
        TYPE t_bi_listaprecio IS TABLE OF NUMBER
            INDEX BY BINARY_INTEGER;

        v_bi_listaprecio       t_bi_listaprecio;

        TYPE t_bi_listaprecioitem IS TABLE OF NUMBER
            INDEX BY BINARY_INTEGER;

        v_bi_listaprecioitem   t_bi_listaprecioitem;

        -- Cursor interfaz
        CURSOR cuinterfaz (nucudatointerfaz NUMBER)
        IS
            SELECT x.codigo, x.FECHA_INI_VIGEN, x.fecha_final_vige
              FROM ldci_intelistpr x
             WHERE x.codigo =
                   DECODE (nucudatointerfaz, -1, x.codigo, nucudatointerfaz);

        -- Cursor obtener los datos de interfaz para crear listas
        CURSOR curegistrosinterfazprocesa (nucuprodlistaproc NUMBER)
        IS
            SELECT DISTINCT codigo_lista,
                            descripcion_lista,
                            fecha_final_vige,
                            compania,
                            unidad_operativa,
                            contratista,
                            contrato,
                            localidad
              FROM (SELECT m.list_unitary_cost_id     codigo_lista,
                           n.description              descripcion_lista,
                           x.fecha_final_vige,
                           n.company_key              compania,
                           n.operating_unit_id        unidad_operativa,
                           n.contractor_id            contratista,
                           n.contract_id              contrato,
                           n.geograp_location_id      localidad
                      FROM ldci_intelistpr       x,
                           ldci_intdetlistprec   y,
                           ge_unit_cost_ite_lis  m,
                           ge_list_unitary_cost  n
                     WHERE     x.estado <> 3
                           AND x.codigo =
                               DECODE (nucuprodlistaproc,
                                       -1, x.codigo,
                                       nucuprodlistaproc)
                           AND TRUNC (SYSDATE) BETWEEN n.validity_start_date
                                                   AND n.validity_final_date
                           AND x.codigo = y.codigo_interfaz
                           AND y.codigo_item = m.items_id
                           AND m.list_unitary_cost_id =
                               n.list_unitary_cost_id
                           AND (    n.operating_unit_id IS NULL
                                AND n.contractor_id IS NULL
                                AND n.contract_id IS NULL
                                AND n.geograp_location_id IS NULL)
                           AND n.VALIDITY_FINAL_DATE > SYSDATE
                    UNION ALL
                    SELECT m.list_unitary_cost_id,
                           n.description,
                           x.fecha_final_vige,
                           n.company_key             compania,
                           n.operating_unit_id,
                           n.contractor_id,
                           n.contract_id             contrato,
                           n.geograp_location_id     localidad
                      FROM ldci_intelistpr       x,
                           ldci_intdetlistprec   y,
                           ge_unit_cost_ite_lis  m,
                           ge_list_unitary_cost  n,
                           ldc_homoitmaitac      h
                     WHERE     x.estado <> 3
                           AND x.codigo =
                               DECODE (nucuprodlistaproc,
                                       -1, x.codigo,
                                       nucuprodlistaproc)
                           AND TRUNC (SYSDATE) BETWEEN n.validity_start_date
                                                   AND n.validity_final_date
                           AND x.codigo = y.codigo_interfaz
                           AND y.codigo_item = h.item_material
                           AND h.item_actividad = m.items_id
                           AND m.list_unitary_cost_id =
                               n.list_unitary_cost_id
                           AND (    n.operating_unit_id IS NULL
                                AND n.contractor_id IS NULL
                                AND n.contract_id IS NULL
                                AND n.geograp_location_id IS NULL)
                           AND n.VALIDITY_FINAL_DATE > SYSDATE);

        -- Cursor para obtener la lista de precio que se va a finalizar
        CURSOR cuitemslistaprec (
            nucuprodlistaproc   ldci_intelistpr.codigo%TYPE,
            nuidlistaprecio     ge_list_unitary_cost.list_unitary_cost_id%TYPE)
        IS
            SELECT DISTINCT codigo_item,
                            costo_items,
                            salespres,
                            orden
              FROM (SELECT i.items_id        codigo_item,
                           y.costo_items     costo_items,
                           0                 AS salespres,
                           1                 orden
                      FROM ldci_intelistpr      x,
                           ldci_intdetlistprec  y,
                           ge_items             i
                     WHERE     x.estado <> 3
                           AND x.codigo =
                               DECODE (nucuprodlistaproc,
                                       -1, x.codigo,
                                       nucuprodlistaproc)
                           AND x.codigo = y.codigo_interfaz
                           AND TO_CHAR (y.codigo_item) = i.code
                    UNION ALL
                    SELECT h.item_actividad,
                           y.costo_items,
                           0     AS salespres,
                           3     orden
                      FROM ldci_intelistpr      x,
                           ldci_intdetlistprec  y,
                           ldc_homoitmaitac     h,
                           open.ge_items        i
                     WHERE     x.estado <> 3
                           AND x.codigo =
                               DECODE (nucuprodlistaproc,
                                       -1, x.codigo,
                                       nucuprodlistaproc)
                           AND x.codigo = y.codigo_interfaz
                           AND TO_CHAR (y.codigo_item) = i.code
                           AND i.items_id = h.item_material-- caso: 207 AND h.item_actividad = m.items_id
                                                           )
            UNION ALL
            SELECT c.items_id,
                   c.price,
                   c.sales_value,
                   2     AS orden
              FROM open.ge_unit_cost_ite_lis c, open.ge_list_unitary_cost b
             WHERE     c.list_unitary_cost_id = nuidlistaprecio
                   AND c.list_unitary_cost_id = b.list_unitary_cost_id
                   AND NOT EXISTS
                           (SELECT NULL
                              FROM open.ldci_intdetlistprec  li,
                                   open.ge_items             i
                             WHERE     li.codigo_interfaz = nucuprodlistaproc
                                   AND TO_CHAR (codigo_item) = i.code
                                   AND c.items_id = i.items_id)
                   AND NOT EXISTS
                           (SELECT NULL
                              FROM open.ldci_intdetlistprec  li,
                                   open.ge_items             i,
                                   ldc_homoitmaitac          ac
                             WHERE     li.codigo_interfaz = nucuprodlistaproc
                                   AND TO_CHAR (li.codigo_item) = i.code
                                   AND i.items_id = ac.item_material
                                   AND c.items_id = ac.item_actividad)
            ORDER BY codigo_item, orden;

        nuparano               NUMBER (4);
        nuparmes               NUMBER (2);
        nutsess                NUMBER;
        sbparuser              VARCHAR2 (30);
        sbmensa                VARCHAR2 (4000);
        nucodlistaprecios      ldci_intelistpr.codigo%TYPE;
        nunuevalista           ge_list_unitary_cost.list_unitary_cost_id%TYPE;
        rcdatlis               dage_list_unitary_cost.styge_list_unitary_cost;
        rcdatcos               dage_unit_cost_ite_lis.styge_unit_cost_ite_lis;
        dtfechafinal           DATE;
        dtfechaininewlista     DATE;
        nuvaloriva             ld_parameter.numeric_value%TYPE;
        nuvalnewcosto          ge_unit_cost_ite_lis.price%TYPE;
        nuvalsalevalue         ge_unit_cost_ite_lis.sales_value%TYPE;
        nuitemactividad        ge_items.items_id%TYPE;
        nuitemvalida           ge_items.items_id%TYPE;
        nuporcadicional        ld_parameter.numeric_value%TYPE;
        nucodinterfazproc      ldci_intelistpr.codigo%TYPE;
        sbmensajeproc          ldci_intelistpr.mensaje%TYPE;
        nuconta                NUMBER (10) DEFAULT 0;
        nuitems                NUMBER (10) DEFAULT 0;
        nuvaitemsvalida        ge_items.items_id%TYPE;
        nuCosf                 NUMBER;                             -- CASO:207
        nuParporcadicional     NUMBER;                             -- CASO:207
        nuPorcentaje           NUMBER;                             -- CASO:207
        sbcormes               VARCHAR2 (4000);                     --caso:207
        CONTROLLED_ERROR       EXCEPTION;                           --caso:207

        CURSOR cuListaReciente IS
              SELECT list_unitary_cost_id,
                     description,
                     validity_start_date,
                     validity_final_date
                FROM open.ge_list_unitary_cost
               WHERE     operating_unit_id IS NULL
                     AND geograp_location_id IS NULL
                     AND contract_id IS NULL
                     AND contractor_id IS NULL
                     AND description LIKE '%MATERIALES%'
            ORDER BY validity_start_date DESC;

        rgListaReciente        cuListaReciente%ROWTYPE;
        sbMensaje              VARCHAR2 (4000);
    BEGIN
        LDCI_PKINTERFAZLISTPRECSAP.LDC_MAILLISTCOST (
            'Inicio del proceso de creacion de nuevas listo de costos interface con SAP');

        -- Obtenemos datos para realizar ejecucion
        SELECT TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY')),
               TO_NUMBER (TO_CHAR (SYSDATE, 'MM')),
               USERENV ('SESSIONID'),
               USER
          INTO nuparano,
               nuparmes,
               nutsess,
               sbparuser
          FROM DUAL;

        -- Se inicia log del programa
        ldc_proinsertaestaprog (
            nuparano,
            nuparmes,
            'LDCI_PKINTERFAZLISTPRECSAP.LDCI_PROCCREALISTAPRECINTERFAZ',
            'En ejecucion',
            nutsess,
            sbparuser);
        nucodlistaprecios := nupacodlitinterfaz;
        sbmensajeproc := 'Se crearán la(s) lista(s) :';
        v_bi_listaprecio.delete;

        FOR reg IN cuinterfaz (nucodlistaprecios)
        LOOP
            OPEN cuListaReciente;

            FETCH cuListaReciente INTO rgListaReciente;

            CLOSE cuListaReciente;

            nucodinterfazproc := rgListaReciente.List_Unitary_Cost_Id;

            nuconta := nuconta + 1;

            IF rgListaReciente.Validity_Final_Date > REG.FECHA_INI_VIGEN
            THEN
                dtfechafinal := REG.FECHA_INI_VIGEN - 1;           --CASO: 207
            ELSIF     rgListaReciente.Validity_Final_Date IS NOT NULL
                  AND TRUNC (rgListaReciente.Validity_Final_Date) <
                      TRUNC (REG.FECHA_INI_VIGEN - 1)
            THEN
                sbmensa :=
                    'No se puede actualizar la lista debido a que se deja un lapsus de tiempo sin lista';
                RAISE CONTROLLED_ERROR;
            END IF;

            -- Se crea la nueva lista y se arma la descripción
            SELECT seq_ge_list_unitary_cost.NEXTVAL
              INTO nunuevalista
              FROM DUAL;

            -- Llenamos variables para crear listas
            rcdatlis.list_unitary_cost_id := nunuevalista;

            rcdatlis.Description :=
                   'LISTA DE COSTOS DE MATERIALES - Interfaz: '
                || TO_CHAR (nucodlistaprecios);

            dtfechaininewlista :=
                TO_DATE (
                       TO_CHAR (REG.FECHA_INI_VIGEN, 'dd/mm/yyyy')
                    || ' 00:00:00',
                    'dd/mm/yyyy hh24:mi:ss');

            --inicio caso:207
            IF rgListaReciente.Validity_Start_Date IS NOT NULL
            THEN
                IF dtfechafinal < rgListaReciente.Validity_Start_Date
                THEN
                    sbmensa :=
                           'La fecha final de la lista de costos '
                        || rgListaReciente.List_Unitary_Cost_Id
                        || ' no puede ser menor que la fecha inicial';
                    RAISE CONTROLLED_ERROR;
                END IF;
            END IF;

            IF dtfechaininewlista > reg.fecha_final_vige
            THEN
                sbmensa :=
                    'Las fechas de costos de la interfaz a procesar presentan un error. La fecha inicial no puede ser mayor que la fecha final';
                RAISE CONTROLLED_ERROR;
            END IF;

            rcdatlis.validity_start_date := dtfechaininewlista;
            rcdatlis.validity_final_date := reg.fecha_final_vige;
            rcdatlis.company_key := 99;
            rcdatlis.operating_unit_id := NULL;
            rcdatlis.user_id := USER;
            rcdatlis.terminal := USERENV ('TERMINAL');
            rcdatlis.contractor_id := NULL;
            rcdatlis.contract_id := NULL;
            rcdatlis.geograp_location_id := NULL;
            -- Insertamos el registro
            dage_list_unitary_cost.insrecord (rcdatlis);
            v_bi_listaprecio (nucodinterfazproc) := nunuevalista;

            -- LLenamos el mensaje
            IF nuconta = 1
            THEN
                sbmensajeproc :=
                       TRIM (sbmensajeproc)
                    || ' ACTUAL : '
                    || TO_CHAR (
                              v_bi_listaprecio (nucodinterfazproc)
                           || ' ANTES : '
                           || TO_CHAR (nucodinterfazproc));
            ELSE
                sbmensajeproc :=
                       TRIM (sbmensajeproc)
                    || ' , ACTUAL : '
                    || TO_CHAR (
                              v_bi_listaprecio (nucodinterfazproc)
                           || ' ANTES : '
                           || TO_CHAR (nucodinterfazproc));
            END IF;

            -- Creamos los items de las nuevas listas
            v_bi_listaprecioitem.delete;
            --INICIO CASO:207
            nuParporcadicional :=
                NVL (
                    dald_parameter.fnuGetNumeric_Value (
                        'PORC_ADMIN_ITEM_MATERIAL',
                        NULL),
                    0);
            nuvaloriva :=
                NVL (
                    dald_parameter.fnuGetNumeric_Value ('COD_VALOR_IVA',
                                                        NULL),
                    0);
            nuPorcentaje :=
                  NVL (
                      TO_NUMBER (
                          dage_parameter.fsbgetvalue ('AIU_ADMIN_UTIL', NULL)),
                      0)
                + NVL (
                      TO_NUMBER (
                          dage_parameter.fsbgetvalue ('AIU_ADMIN_UNEXPECTED',
                                                      NULL)),
                      0)
                + NVL (
                      TO_NUMBER (
                          dage_parameter.fsbgetvalue ('AIU_ADMIN_ADMIN',
                                                      NULL)),
                      0);

            --FIN CASO:207

            FOR j IN cuitemslistaprec (nupacodlitinterfaz, nucodinterfazproc)
            LOOP
                nuvaitemsvalida := j.codigo_item;

                IF v_bi_listaprecioitem.EXISTS (nuvaitemsvalida)
                THEN
                    NULL;
                ELSE
                    -- Verificamos si el item de interfaz esta homolohago
                    nuitemactividad := NULL;

                    IF j.orden = 3
                    THEN                                          -- CASO: 207
                        nuitemactividad := j.codigo_item;
                    END IF;

                    IF nuitemactividad IS NOT NULL
                    THEN
                        nuitemvalida := nuitemactividad;
 
                        nuporcadicional := nuParporcadicional;
                    ELSE
                        nuitemvalida := nuvaitemsvalida;
                        nuporcadicional := 0;
                    END IF;

                    -- Llenamos variables para crear items de la listas
                    nuvalnewcosto := 0;
                    nuvalsalevalue := 0;
                    nuCosf := 0;

                    --INICIO CASO:207
                    IF j.orden = 1 OR j.orden = 3
                    THEN
                        nuCosf :=
                              j.costo_items
                            + (j.costo_items * (nuvaloriva / 100)); -- se calcula costo osf =(costo sap + iva)
                        nuvalnewcosto :=
                            nuCosf + (nuCosf * (nuporcadicional / 100)); -- se calcula costo del item de la nueva lista =  (costo osf + costo adicional)

                        nuvalsalevalue :=
                              nuvalnewcosto
                            + (nuvalnewcosto * (nuPorcentaje / 100)); -- precio del item de la nueva lista = (costo del item + porcentaje de venta )
                    --FIN CASO:207
                    ELSE
                        nuvalnewcosto := NVL (j.costo_items, 0);
                        nuvalsalevalue := NVL (j.salespres, 0);
                    END IF;



                    rcdatcos.items_id := nuitemvalida;
                    rcdatcos.list_unitary_cost_id :=
                        v_bi_listaprecio (nucodinterfazproc);
                    rcdatcos.price := nuvalnewcosto;
                    rcdatcos.last_update_date := SYSDATE;
                    rcdatcos.user_id := USER;
                    rcdatcos.terminal := USERENV ('TERMINAL');
                    rcdatcos.sales_value := nuvalsalevalue;
                    -- Se adicio a registro
                    dage_unit_cost_ite_lis.insrecord (rcdatcos);
                    nuitems := nuitems + 1;

                    v_bi_listaprecioitem (nuitemvalida) := nuitemvalida;
                END IF;
            END LOOP;

            -- Actualizamos el registro de interfaz
            UPDATE ldci_intelistpr e
               SET e.estado = 3,
                   fecha_procesado = SYSDATE,
                   e.mensaje = sbmensajeproc
             WHERE e.codigo = reg.codigo;
        END LOOP;

        sbmensa :=
               'Proceso terminó Ok. Se procesarán: '
            || TO_CHAR (nuitems)
            || ' items, '
            || TO_CHAR (nuconta)
            || ' listas';
        nunumerrorsal := 0;
        sberrorsalida := sbmensa;

        IF dtfechafinal IS NOT NULL
        THEN
            UPDATE ge_list_unitary_cost xc
               SET xc.validity_final_date = dtfechafinal
             WHERE xc.list_unitary_cost_id = nucodinterfazproc;
        END IF;

        COMMIT;
        -- Se finaliza proceso
        LDCI_PKINTERFAZLISTPRECSAP.LDC_MAILLISTCOST (
            'Finalizo exitosamente el proceso de creación de nuevas listo de costos interface con SAP');
        ldc_proactualizaestaprog (
            nutsess,
            sbmensa,
            'LDCI_PKINTERFAZLISTPRECSAP.LDCI_PROCCREALISTAPRECINTERFAZ',
            'Termino Ok.');
    EXCEPTION
        WHEN CONTROLLED_ERROR
        THEN
            ROLLBACK;

            nunumerrorsal := -1;
            sberrorsalida := sbmensa;

            sbcormes :=
                   'Termino con errores el proceso de creación de nuevas listo de costos interface con SAP. <br> Error: '
                || sbmensa;
            LDCI_PKINTERFAZLISTPRECSAP.LDC_MAILLISTCOST (sbcormes);

            UPDATE ldci_intelistpr e
               SET e.estado = 2,
                   fecha_procesado = SYSDATE,
                   e.mensaje = sbmensa
             WHERE e.codigo = nucodlistaprecios;


            COMMIT;
            ldc_proactualizaestaprog (
                nutsess,
                sbmensa,
                'LDCI_PKINTERFAZLISTPRECSAP.LDCI_PROCCREALISTAPRECINTERFAZ',
                'Termino con error.');
        WHEN OTHERS
        THEN
            ROLLBACK;
            sbmensa :=
                   -1
                || ' Error en el proceso LDCCRELIPREC..lineas error '
                || ' : '
                || SQLERRM;
            nunumerrorsal := -1;
            sberrorsalida := sbmensa;

            sbcormes :=
                   'Termino con errores el proceso de creación de nuevas listo de costos interface con SAP. <br> Error: '
                || sbmensa;
            LDCI_PKINTERFAZLISTPRECSAP.LDC_MAILLISTCOST (sbcormes);

            UPDATE ldci_intelistpr e
               SET e.estado = 2,
                   fecha_procesado = SYSDATE,
                   e.mensaje = sbmensa
             WHERE e.codigo = nucodlistaprecios;



            COMMIT;
            ldc_proactualizaestaprog (
                nutsess,
                sbmensa,
                'LDCI_PKINTERFAZLISTPRECSAP.LDCI_PROCCREALISTAPRECINTERFAZ',
                'Termino con error.');
    END;

    PROCEDURE ldci_procesaxmlitemslistprec (xmlpar          CLOB,
                                            nupaerror   OUT NUMBER,
                                            sbpaerror   OUT VARCHAR2)
    AS
        /*************************************************************************************************************************
            Autor       : John Jairo Jimenez Marimon
            Fecha       : 2018-10-08
            Descripcion : Procesa XML de items

            Parametros Entrada

            Valor de salida

           HISTORIA DE MODIFICACIONES
             FECHA        AUTOR   DESCRIPCION
             22/11/2018   Daniel Valiente    Se modifica para manejar Fecha Inicial y Fecha Final (CA2001596)
             06/02/2023   Jose Donado        INT-249 Ajuste para notificar inicio y finalización de proceso via email

        *************************************************************************************************************************/
        x               XMLTYPE := xmltype (xmlpar);
        consulta        VARCHAR2 (1000);
        sbcoditem       VARCHAR2 (1000);
        sbvalitem       VARCHAR2 (1000);
        sbcoditemproc   VARCHAR2 (1000);

        nuconta         NUMBER (6);
        nuvaerror       NUMBER;
        sbvaerror       VARCHAR2 (3000);
        fechaI          VARCHAR2 (50);
        fechaF          VARCHAR2 (50);
        sbMensaje       VARCHAR2 (500);
    BEGIN
        sbcoditemproc := seq_ldci_intelistpr.NEXTVAL;

        SELECT COUNT (1)
          INTO nuconta
          FROM ldci_intelistpr c
         WHERE c.codigo = TO_NUMBER (TRIM (sbcoditemproc)) AND c.estado = 3;

        IF nuconta >= 1
        THEN
            nupaerror := -1;
            sbpaerror :=
                   'El registro en XML con TAG codigo : '
                || TRIM (sbcoditemproc)
                || ' ya se encuentra procesado.';
            RETURN;
        END IF;

        SELECT EXTRACTVALUE (VALUE (p), '/fechaInicial/text()')
          INTO fechaI
          FROM TABLE (
                   XMLSEQUENCE (
                       EXTRACT (x, '//ListaPrecioRequest/fechaInicial'))) p;

        SELECT EXTRACTVALUE (VALUE (p), '/fechaFinal/text()')
          INTO fechaF
          FROM TABLE (
                   XMLSEQUENCE (
                       EXTRACT (x, '//ListaPrecioRequest/fechaFinal'))) p;


        sbMensaje :=
               'Inicio de cargue de Lista de Precio '
            || fechaI
            || ' - '
            || fechaF;
        sbMensaje :=
               sbMensaje
            || '<br> <strong> Para garantizar la integridad de la informacion, por favor <span style = "color:red">no</span> ejecute procesos asociados a listas de precio hasta recibir notificacion de <span style = "color:red">finalizacion</span>.</strong>';
        sbMensaje :=
            sbMensaje || '<br> Este proceso puede tardar unos minutos.';
        LDCI_PKINTERFAZLISTPRECSAP.LDC_MAILLISTCOST (sbMensaje);

        FOR r
            IN (SELECT EXTRACTVALUE (VALUE (P),
                                     '/material/codMaterial/text()')
                           AS codigo,
                       EXTRACT (VALUE (P), '/material')
                           AS promet
                  FROM TABLE (
                           XMLSEQUENCE (
                               EXTRACT (
                                   x,
                                   '//ListaPrecioRequest/materiales/material')))
                       P)
        LOOP
            sbcoditem := TO_CHAR (r.codigo);
            consulta :=
                   'DECLARE nuvaerror NUMBER; sbvaerror VARCHAR2(1000); BEGIN LDCI_PKINTERFAZLISTPRECSAP.LDCI_PROCLLENATABLAINTERFAZ('
                || TO_NUMBER (TRIM (sbcoditemproc))
                || ','
                || TO_NUMBER (TRIM (sbcoditem))
                || ',';

            FOR r1
                IN (SELECT EXTRACTVALUE (VALUE (T1), '/costo/text()')    AS costo
                      FROM TABLE (
                               XMLSEQUENCE (
                                   EXTRACT (r.promet, 'material/costo'))) T1)
            LOOP
                sbvalitem := TO_CHAR (r1.costo);
                consulta :=
                       TRIM (consulta)
                    || TO_NUMBER (TRIM (sbvalitem))
                    || ','
                    || fechaI
                    || ','
                    || fechaF
                    || ',nuvaerror,sbvaerror); END;';

                IF nuvaerror <> 0
                THEN
                    nupaerror := nuvaerror;
                    sbpaerror := sbvaerror;
                    RETURN;
                END IF;

                --pkg_Traza.Trace(consulta);
                EXECUTE IMMEDIATE consulta;

                COMMIT;
            END LOOP;
        END LOOP;

        nupaerror := 0;
        sbpaerror := 'Termino Ok.';

        /*INT-249*/
        sbMensaje :=
            'Fin de cargue de Lista de Precio ' || fechaI || ' - ' || fechaF;
        LDCI_PKINTERFAZLISTPRECSAP.LDC_MAILLISTCOST (sbMensaje);
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            nupaerror := -1;
            sbpaerror := SQLERRM;
    END;

    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Proceso     : proProcesaXMLListaPrecio
    * Tiquete     :
    * Fecha       : 26-11-2018
    * Descripcion : Se encarga de procesar las listas de precios enviadas desde SAP

    * Historia de Modificaciones
    * Autor       Fecha           Descripcion
    * jdonado     26/11/2018      Creacion bajo el caso 200-1596
    *
    *
    **/

    PROCEDURE proProcesaXMLListaPrecio (CODIGO          IN     NUMBER,
                                        INBOX_ID        IN     VARCHAR2,
                                        inuProcesoExt   IN     NUMBER,
                                        isbSistema      IN     VARCHAR2,
                                        isbOperacion    IN     VARCHAR2,
                                        isbXML          IN     CLOB,
                                        inuContrato     IN     VARCHAR2,
                                        inuProducto     IN     VARCHAR2,
                                        inuUnid_oper    IN     NUMBER,
                                        inuOrden        IN     NUMBER,
                                        ocurRespuesta      OUT SYS_REFCURSOR,
                                        onuErrorCodi       OUT NUMBER,
                                        osbErrorMsg        OUT VARCHAR2)
    AS
    BEGIN
        ldci_procesaxmlitemslistprec (isbXML, onuErrorCodi, osbErrorMsg);

        OPEN ocurRespuesta FOR
            SELECT 'idProcesoExterno'          parametro,
                   TO_CHAR (inuProcesoExt)     valor
              FROM DUAL
            UNION
            SELECT 'codigoError' parametro, TO_CHAR (onuErrorCodi) valor
              FROM DUAL
            UNION
            SELECT 'mensajeError' parametro, osbErrorMsg valor FROM DUAL;
    EXCEPTION
        WHEN OTHERS
        THEN
            errors.geterror (onuErrorCodi, osbErrorMsg);

            OPEN ocurRespuesta FOR
                SELECT 'idProcesoExterno'          parametro,
                       TO_CHAR (inuProcesoExt)     valor
                  FROM DUAL
                UNION
                SELECT 'codigoError' parametro, TO_CHAR (onuErrorCodi) valor
                  FROM DUAL
                UNION
                SELECT 'mensajeError' parametro, osbErrorMsg valor FROM DUAL;
    END proProcesaXMLListaPrecio;

    PROCEDURE LDC_MAILLISTCOST (sbmensa VARCHAR2)
    IS
        /**************************************************************************
            Autor       : Ernesto Santiago / Horbath
            Fecha       : 2019-12-22
            Ticket      : 207
            Descripcion : PROCEDIMIENTO QUE ENVIA CORREOS DEL PROCESO CREACIÓN DE LISTAS DE COSTOS

            Valor de salida

            HISTORIA DE MODIFICACIONES
            FECHA        AUTOR       DESCRIPCION
       ***************************************************************************/


        SBDATEBASE             VARCHAR2 (50);
        NUVAL                  NUMBER;
        sbmessage              VARCHAR2 (500);
        q_ejec                 VARCHAR (200) := 'Select * From Global_Name';

        --- en este cursor se obtiene el tipo de trabajo, la actividad y el estado de la orden que se esta legalizando
        CURSOR cu_correos IS
            SELECT COLUMN_VALUE     correo
              FROM TABLE (
                       ldc_boutilities.splitstrings (
                           dald_parameter.fsbgetvalue_chain (
                               'CORREO_INTERFAZ_LISTACOSTO',
                               NULL),
                           ','));

        CURSOR CUVALBD (DB VARCHAR)
        IS
            SELECT 1
              FROM TABLE (
                       ldc_boutilities.splitstrings (
                           dald_parameter.fsbgetvalue_chain (
                               'BASE_DATOS_PRUEBAS',
                               NULL),
                           ','))
             WHERE UPPER (TO_CHAR (COLUMN_VALUE)) = UPPER (DB);


        sbRemitente            ld_parameter.value_chain%TYPE
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');
    BEGIN
        -- con estas funciones se obtienen los datos de la orden que se intentan legalizar --
        pkg_Traza.Trace ('Inicio LDC_MAILLISTCOST', 10);

        EXECUTE IMMEDIATE q_ejec
            INTO SBDATEBASE;

        pkg_Traza.Trace (' SBDATEBASE: ' || SBDATEBASE);

        BEGIN
            SELECT 1
              INTO NUVAL
              FROM TABLE (
                       ldc_boutilities.splitstrings (
                           dald_parameter.fsbgetvalue_chain (
                               'BASE_DATOS_PRUEBAS',
                               NULL),
                           ','))
             WHERE UPPER (TO_CHAR (COLUMN_VALUE)) = UPPER (SBDATEBASE);
        EXCEPTION
            WHEN OTHERS
            THEN
                NUVAL := NULL;
        END;

        sbmessage := sbmensa;

        IF NUVAL IS NOT NULL
        THEN
            sbmessage :=
                   sbmessage
                || '<br> Ejecutado desde la base de datos de prueba '
                || SBDATEBASE;
        END IF;

        FOR reg IN cu_correos
        LOOP
            pkg_Correo.prcEnviaCorreo (
                isbRemitente       => sbRemitente,
                isbDestinatarios   => reg.correo,
                isbAsunto          =>
                    'Notificación de estado de la creación de listas de costos',
                isbMensaje         => sbmessage);
        END LOOP;

        pkg_Traza.Trace (' 6');
        pkg_Traza.Trace ('fin  LDC_MAILLISTCOST', 10);
    EXCEPTION
        WHEN OTHERS
        THEN
            --Errors.setError;
            pkg_Traza.Trace ('error onuErrorCode: ' || SQLERRM);
            RAISE ex.controlled_error;
    END LDC_MAILLISTCOST;
END ldci_pkinterfazlistprecsap;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDCI_PKINTERFAZLISTPRECSAP
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKINTERFAZLISTPRECSAP', 'ADM_PERSON'); 
END;
/
