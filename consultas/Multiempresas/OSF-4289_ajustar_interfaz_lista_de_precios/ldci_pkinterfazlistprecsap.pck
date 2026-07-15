CREATE OR REPLACE PACKAGE ADM_PERSON.ldci_pkinterfazlistprecsap AS
  /*************************************************************************************************************************
      Autor       : John Jairo Jimenez Marimon
      Fecha       : 2018-07-04
      Descripcion : Paquete creacion listas de precio por Interfaz

      Parametros Entrada

      Valor de salida

     HISTORIA DE MODIFICACIONES
       FECHA        AUTOR       DESCRIPCION
  12/12/2019  ESANTIAGO       caso: 207 Se agrega procedimiento LDC_MAILLISTCOST .
          (HORBATH)
    06/02/2023   Jose Donado    INT-249 Ajuste a procedimiento ldci_procesaxmlitemslistprec para notificar
                                      inicio y finalizacion de proceso via email
    26/04/2024  jpinedc         OSF-2581-  LDC_MAILLISTCOST: Se cambia ldc_sendemail
                                por pkg_Correo.prcEnviaCorreo
    18/06/2024   Adrianavg      OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
  23/05/2025   JSOTO      OSF-4289: Ajustes para funcionalidad multiempresa
                -Se aplican Pautas de desarrollo:
                  -Manejo de trazas y excepciones
                  -Remmplazo de uso de LDC_PROINSERTAESTAPROG y LDC_PROACTUALIZAESTAPROG por PKG_ESTAPROC
                  -Reemplazo de uso de LDC_BOUTILITIES.SPLITSTRINGS por REGEXP_SUBSTR

  *************************************************************************************************************************/
  PROCEDURE ldci_procllenatablainterfaz(nupaidproceso  NUMBER,
                                        nupacoditems   NUMBER,
                                        nupacostoitmes NUMBER,
                                        fechaInicial   Varchar2,
                                        fechaFinal     Varchar2,
                    isbCodEmpresa  Varchar2,
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
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.ldci_pkinterfazlistprecsap
AS

  -- Constantes para el control de la traza
  csbSP_NAME            CONSTANT VARCHAR2(100):= $$PLSQL_UNIT ||'.';

    PROCEDURE ldci_procllenatablainterfaz (nupaidproceso        NUMBER,
                                           nupacoditems         NUMBER,
                                           nupacostoitmes       NUMBER,
                                           fechaInicial         VARCHAR2,
                                           fechaFinal           VARCHAR2,
                       isbCodEmpresa    VARCHAR2,
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
    csbMT_NAME            VARCHAR2(100) := csbSP_NAME || 'ldci_procllenatablainterfaz';
    nuError         NUMBER;
    sbError         VARCHAR2(4000);

    CURSOR cuValinterfaz
    IS
        SELECT COUNT (1)
          FROM ldci_intelistpr c
         WHERE c.codigo = nupaidproceso;

    CURSOR cuCuentaItems (inucodigointerfaz NUMBER)
    IS
    SELECT COUNT (1)
          FROM ldci_intdetlistprec ci
         WHERE     ci.codigo_interfaz = inucodigointerfaz
               AND ci.codigo_item = nupacoditems;


    BEGIN

  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

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
    IF cuValinterfaz%ISOPEN THEN
      CLOSE cuValinterfaz;
    END IF;

    OPEN cuValinterfaz;
    FETCH cuValinterfaz INTO nuconta;
    CLOSE cuValinterfaz;


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
                                         mensaje,
                     empresa)
                 VALUES (nucodigointerfaz,
                         'LISTA DE PRECIOS ' || TO_CHAR (nucodigointerfaz),
                         dtvafechaini,
                         dtvafechafin,
                         SYSDATE,
                         USER,
                         1,
                         'Registro Ok.',
             isbCodEmpresa);
        END IF;

        -- Insertamos registro detalle de interfaz.
        nucodigointerfazdet := seq_ldci_intdetlistprec.NEXTVAL;

    IF cuCuentaItems%ISOPEN THEN
      CLOSE cuCuentaItems;
    END IF;

    OPEN cuCuentaItems(nucodigointerfaz);
    FETCH cuCuentaItems INTO nucontaitem;
    CLOSE cuCuentaItems;

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

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
      pkg_error.setError;
      pkg_error.geterror(nuError,sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            nupainserror := -1;
            sbpainserror := SQLERRM;
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
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
      23/05/2025  JSOTO  OSF-4289 Se agregan consultas con UNION ALL al cursor cuitemslistaprec para que se procese
                 el codigo de interfaz (ldci_intelistpr) de GDCA y cree la nueva lista de costos en OSF y luego adicione
                 a esa misma lista los item asociados al codigo de interfaz (ldci_intelistpr) de GDGU con fechas de
                 vigencia iguales a la de GDCA.
                 Se crea el parametro VALIDA_INTERFAZ_GDGU para activar/desactivar la validacion de que exista
                  un registro de interfaz con empresa GDGU con las mismas fechas de vigencia que tiene la interfaz de GDCA.
                 se agrega al select el campo ?empresa? y se ordena el resultado por empresa.
        *************************************************************************************************************************/
        TYPE t_bi_listaprecio IS TABLE OF NUMBER
            INDEX BY BINARY_INTEGER;

        v_bi_listaprecio       t_bi_listaprecio;

        TYPE t_bi_listaprecioitem IS TABLE OF NUMBER
            INDEX BY BINARY_INTEGER;

        v_bi_listaprecioitem   t_bi_listaprecioitem;


    nupacodlitinterfazGDGU  NUMBER;
    csbMT_NAME              VARCHAR2(100) := csbSP_NAME || 'ldci_proccrealistaprecinterfaz';
    nuError           NUMBER;
    sbError           VARCHAR2(4000);
    sbproceso         VARCHAR2(100) := upper(csbMT_NAME)||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        nuCantIntGDGU           NUMBER;



        CURSOR cuinterfazGDGU (idtFechaIni DATE, idtFechaFin DATE)
    IS
            SELECT x.codigo
              FROM ldci_intelistpr x
             WHERE trunc(x.fecha_ini_vigen) = trunc(idtFechaIni)
         AND trunc(x.fecha_final_vige) = trunc(idtFechaFin)
         AND x.empresa = 'GDGU'
               and x.estado = 1;

        CURSOR cuinterfazGDGUCant (idtFechaIni DATE, idtFechaFin DATE)
    IS
            SELECT count(1)
              FROM ldci_intelistpr x
             WHERE trunc(x.fecha_ini_vigen) = trunc(idtFechaIni)
         AND trunc(x.fecha_final_vige) = trunc(idtFechaFin)
         AND x.empresa = 'GDGU'
               and x.estado = 1;

        -- Cursor interfaz
        CURSOR cuinterfaz (nucudatointerfaz NUMBER)
    IS
            SELECT x.codigo, x.FECHA_INI_VIGEN, x.fecha_final_vige, x.empresa
              FROM ldci_intelistpr x
             WHERE x.codigo = DECODE (nucudatointerfaz, -1, x.codigo, nucudatointerfaz)
         AND x.empresa = 'GDCA';


        -- Cursor para obtener la lista de precio que se va a finalizar
        CURSOR cuitemslistaprec (
                nucuprodlistaproc     ldci_intelistpr.codigo%TYPE,
                nuidlistaprecio       ge_list_unitary_cost.list_unitary_cost_id%TYPE,
                nucuprodlistaprocGDGU   ldci_intelistpr.codigo%TYPE
                )
        IS
            SELECT DISTINCT empresa,
              codigo_item,
                            costo_items,
                            salespres,
                            orden
              FROM (SELECT x.empresa     empresa,
                 i.items_id        codigo_item,
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
                           AND x.empresa = 'GDCA'
                    UNION ALL
                    SELECT x.empresa,
                           h.item_actividad,
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
                           AND i.items_id = h.item_material
               AND x.empresa = 'GDCA' -- caso: 207 AND h.item_actividad = m.items_id
                           AND x.empresa = h.empresa

          -- INICIA OSF-4289 UNION REGISTROS DE LA LISTA DE GDGU

          UNION ALL

                    SELECT x.empresa,
               h.item_actividad,
                           y.costo_items,
                           0     AS salespres,
                           3     orden
                      FROM ldci_intelistpr      x,
                           ldci_intdetlistprec  y,
                           ldc_homoitmaitac     h,
                           open.ge_items        i
                     WHERE     x.estado <> 3
                           AND x.codigo =
                               DECODE (nucuprodlistaprocGDGU,
                                       -1, x.codigo,
                                       nucuprodlistaprocGDGU)
                           AND x.codigo = y.codigo_interfaz
                           AND TO_CHAR (y.codigo_item) = i.code
                           AND i.items_id = h.item_material
                           AND x.empresa = 'GDGU'
                           AND x.empresa = h.empresa
          -- FIN OSF-4289 UNION REGISTROS DE LA LISTA DE GDGU
                    )
            UNION ALL
            SELECT 'N/A' empresa,
           c.items_id codigo_item,
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
                             WHERE     li.codigo_interfaz in (nucuprodlistaproc)
                                   AND TO_CHAR (codigo_item) = i.code
                                   AND c.items_id = i.items_id)
                   AND NOT EXISTS
                           (SELECT NULL
                              FROM open.ldci_intdetlistprec  li,
                                   open.ldci_intelistpr      l,
                                   open.ge_items             i,
                                   ldc_homoitmaitac          ac
                             WHERE     li.codigo_interfaz in  (nucuprodlistaproc, nucuprodlistaprocGDGU)
                                   AND TO_CHAR (li.codigo_item) = i.code
                                   AND i.items_id = ac.item_material
                                   AND c.items_id = ac.item_actividad
                                   and ac.empresa = l.empresa
                                   and l.codigo  =  li.codigo_interfaz)
            -- INICIA OSF-4289 UNION REGISTROS DE LA LISTA DE GDGU

            ORDER BY empresa, codigo_item, orden;

        sbmensa                VARCHAR2 (4000);
        nucodlistaprecios      ldci_intelistpr.codigo%TYPE;
        nunuevalista           ge_list_unitary_cost.list_unitary_cost_id%TYPE;
        rcdatlis               dage_list_unitary_cost.styge_list_unitary_cost;
        rcdatcos               dage_unit_cost_ite_lis.styge_unit_cost_ite_lis;
        dtfechafinal           DATE;
        dtfechaininewlista     DATE;
        dtfechafinnewlista     DATE;
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
        sbValInterfazGDGU    VARCHAR2(1) := pkg_parametros.fsbGetValorCadena('VALIDA_INTERFAZ_GDGU');

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

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);


        LDCI_PKINTERFAZLISTPRECSAP.LDC_MAILLISTCOST (
            'Inicio del proceso de creacion de nuevas listas de costos interface con SAP');

        -- Se inicia log del programa
    pkg_estaproc.prInsertaEstaproc(sbproceso,NULL);

        nucodlistaprecios := nupacodlitinterfaz;
        sbmensajeproc := 'Se crearan la(s) lista(s) :';
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

        -- Se crea la nueva lista y se arma la descripcion

        nunuevalista := seq_ge_list_unitary_cost.NEXTVAL;

        dtfechaininewlista :=
          TO_DATE (
               TO_CHAR (REG.FECHA_INI_VIGEN, 'dd/mm/yyyy')
            || ' 00:00:00',
            'dd/mm/yyyy hh24:mi:ss');

        dtfechafinnewlista := reg.fecha_final_vige;

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

        OPEN cuinterfazGDGU(dtfechaininewlista, dtfechafinnewlista);
        FETCH cuinterfazGDGU INTO nupacodlitinterfazGDGU;
        CLOSE cuinterfazGDGU;


        IF sbValInterfazGDGU = 'S' THEN
          IF nupacodlitinterfazGDGU IS NULL THEN
            sbmensa :=
              'No se encontro interfaz para procesar con fechas de vigencia de: '||dtfechaininewlista||' a : '||dtfechafinnewlista||' para empresa GDGU';
            RAISE CONTROLLED_ERROR;
          END IF;
        END IF;

        nuCantIntGDGU := null;
        OPEN cuinterfazGDGUCant(dtfechaininewlista, dtfechafinnewlista);
        FETCH cuinterfazGDGUCant into nuCantIntGDGU;
        CLOSE cuinterfazGDGUCant;

        IF nuCantIntGDGU > 1  THEN
          sbmensa :=
              'Se encontro mas de una interfaz para procesar con fechas de vigencia de: '||dtfechaininewlista||' a : '||dtfechafinnewlista||' para empresa GDGU';
            RAISE CONTROLLED_ERROR;
        END IF;

        -- Llenamos variables para crear listas
        rcdatlis.list_unitary_cost_id := nunuevalista;
        rcdatlis.Description :=
             'LISTA DE COSTOS DE MATERIALES - Interfaz: '
          || TO_CHAR (nucodlistaprecios) ||' '|| TO_CHAR (nupacodlitinterfazGDGU);

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
            pkg_bcld_parameter.fnuobtienevalornumerico('PORC_ADMIN_ITEM_MATERIAL'),
            0);
        nuvaloriva :=
          NVL (
            pkg_bcld_parameter.fnuobtienevalornumerico('COD_VALOR_IVA'),
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

        FOR j IN cuitemslistaprec (nupacodlitinterfaz, nucodinterfazproc, nupacodlitinterfazGDGU)
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

         IF nupacodlitinterfazGDGU IS NOT NULL THEN
           UPDATE ldci_intelistpr e
             SET e.estado = 3,
               fecha_procesado = SYSDATE,
               e.mensaje = sbmensajeproc
           WHERE e.codigo = nupacodlitinterfazGDGU;
         END IF;

      END LOOP;

        sbmensa :=
               'Proceso termino Ok. Se procesaran: '
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
            'Finalizo exitosamente el proceso de creacion de nuevas listo de costos interface con SAP');

    pkg_estaproc.prActualizaEstaproc(sbproceso,' Ok',sbmensa);

    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


    EXCEPTION
        WHEN CONTROLLED_ERROR THEN

            ROLLBACK;
      pkg_error.geterror(nuError,sbError);

            nunumerrorsal := -1;
            sberrorsalida := sbmensa;

            sbcormes :=
                   'Termino con errores el proceso de creacion de nuevas listo de costos interface con SAP. <br> Error: '
                || sbmensa;
            LDCI_PKINTERFAZLISTPRECSAP.LDC_MAILLISTCOST (sbcormes);

            UPDATE ldci_intelistpr e
               SET e.estado = 2,
                   fecha_procesado = SYSDATE,
                   e.mensaje = sbmensa
             WHERE e.codigo = nucodlistaprecios;


            COMMIT;
      pkg_estaproc.prActualizaEstaproc(sbproceso,' Error',sbmensa);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);

        WHEN OTHERS THEN
            ROLLBACK;
      pkg_error.setError;
      pkg_error.geterror(nuError,sbError);

            sbmensa :=
                   -1
                || ' Error en el proceso LDCCRELIPREC..lineas error '
                || ' : '
                || SQLERRM;

            nunumerrorsal := -1;
            sberrorsalida := sbmensa;

            sbcormes :=
                   'Termino con errores el proceso de creacion de nuevas listo de costos interface con SAP. <br> Error: '
                || sbmensa;
            LDCI_PKINTERFAZLISTPRECSAP.LDC_MAILLISTCOST (sbcormes);

            UPDATE ldci_intelistpr e
               SET e.estado = 2,
                   fecha_procesado = SYSDATE,
                   e.mensaje = sbmensa
             WHERE e.codigo = nucodlistaprecios;

            COMMIT;
      pkg_estaproc.prActualizaEstaproc(sbproceso,' Error',sbmensa);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);

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
             06/02/2023   Jose Donado        INT-249 Ajuste para notificar inicio y finalizacion de proceso via email

        *************************************************************************************************************************/
        x               XMLTYPE := xmltype (xmlpar);
        consulta        VARCHAR2 (1000);
        sbcoditem       VARCHAR2 (1000);
        sbvalitem       VARCHAR2 (1000);
        sbcoditemproc   VARCHAR2 (1000);

        nuconta         NUMBER (6);
        nuvaerror       NUMBER;
        sbvaerror       VARCHAR2 (3000);
    sbSociedad    VARCHAR2 (10);
        fechaI          VARCHAR2 (50);
        fechaF          VARCHAR2 (50);
        sbMensaje       VARCHAR2 (500);
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || 'ldci_procesaxmlitemslistprec';
    nuError     NUMBER;
    sbError     VARCHAR2(4000);

    CURSOR cuCuentaInterfaz(isbcoditemproc VARCHAR2)
    IS
    SELECT COUNT (1)
          FROM ldci_intelistpr c
         WHERE c.codigo = TO_NUMBER (TRIM (isbcoditemproc)) AND c.estado = 3;


    CURSOR cuExtraeValor(sbVariable1 VARCHAR2, sbVariable2 VARCHAR2)
    IS
        SELECT EXTRACTVALUE (VALUE (p), sbVariable1)
          FROM TABLE (
                   XMLSEQUENCE (
                       EXTRACT (x, sbVariable2))) p;


    BEGIN

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);


        sbcoditemproc := seq_ldci_intelistpr.NEXTVAL;

    IF cuCuentaInterfaz%ISOPEN THEN
      CLOSE cuCuentaInterfaz;
    END IF;

    OPEN cuCuentaInterfaz(sbcoditemproc);
    FETCH cuCuentaInterfaz INTO nuconta;
    CLOSE cuCuentaInterfaz;


        IF nuconta >= 1
        THEN
            nupaerror := -1;
            sbpaerror :=
                   'El registro en XML con TAG codigo : '
                || TRIM (sbcoditemproc)
                || ' ya se encuentra procesado.';
            RETURN;
        END IF;

    IF cuExtraeValor%ISOPEN THEN
      CLOSE cuExtraeValor;
    END IF;

    OPEN cuExtraeValor('/sociedad/text()','//ListaPrecioRequest/sociedad');
    FETCH cuExtraeValor INTO sbSociedad;
    CLOSE cuExtraeValor;

    OPEN cuExtraeValor('/fechaInicial/text()','//ListaPrecioRequest/fechaInicial');
    FETCH cuExtraeValor INTO fechaI;
    CLOSE cuExtraeValor;

    OPEN cuExtraeValor('/fechaFinal/text()', '//ListaPrecioRequest/fechaFinal');
    FETCH cuExtraeValor INTO fechaF;
    CLOSE cuExtraeValor;


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
                    || ','''
                    || sbSociedad
                    || ''',nuvaerror,sbvaerror); END;';

                IF nuvaerror <> 0
                THEN
                    nupaerror := nuvaerror;
                    sbpaerror := sbvaerror;
                    RETURN;
                END IF;

                EXECUTE IMMEDIATE consulta;

                COMMIT;
            END LOOP;
        END LOOP;

        nupaerror := 0;
        sbpaerror := 'Termino Ok.';

        /*INT-249*/
        sbMensaje :=
            'Fin de cargue de Lista de Precio ' || fechaI || ' - ' || fechaF;
        ldci_pkinterfazlistprecsap.ldc_maillistcost (sbMensaje);

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
      pkg_error.setError;
      pkg_error.geterror(nuError,sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            nupaerror := -1;
            sbpaerror := SQLERRM;
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
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

    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || 'proProcesaXMLListaPrecio';
    nuError     NUMBER;
    sbError     VARCHAR2(4000);

    BEGIN

  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

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

  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN OTHERS
        THEN
      pkg_error.setError;
            pkg_error.geterror (onuErrorCodi, osbErrorMsg);

            OPEN ocurRespuesta FOR
                SELECT 'idProcesoExterno'          parametro,
                       TO_CHAR (inuProcesoExt)     valor
                  FROM DUAL
                UNION
                SELECT 'codigoError' parametro, TO_CHAR (onuErrorCodi) valor
                  FROM DUAL
                UNION
                SELECT 'mensajeError' parametro, osbErrorMsg valor FROM DUAL;

      pkg_traza.trace(' osbErrorMsg => ' || osbErrorMsg, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);

    END proProcesaXMLListaPrecio;

    PROCEDURE LDC_MAILLISTCOST (sbmensa VARCHAR2)
    IS
        /**************************************************************************
            Autor       : Ernesto Santiago / Horbath
            Fecha       : 2019-12-22
            Ticket      : 207
            Descripcion : PROCEDIMIENTO QUE ENVIA CORREOS DEL PROCESO CREACION DE LISTAS DE COSTOS

            Valor de salida

            HISTORIA DE MODIFICACIONES
            FECHA        AUTOR       DESCRIPCION
       ***************************************************************************/


        sbDatebase              VARCHAR2 (50);
        nuVal                   NUMBER;
        sbmessage               VARCHAR2 (500);
        q_ejec                  VARCHAR (200) := 'Select * From Global_Name';
    csbMT_NAME            VARCHAR2(100) := csbSP_NAME || 'LDC_MAILLISTCOST';
    nuError           NUMBER;
    sbError         VARCHAR2(4000);
    sbBasePruebas     ld_parameter.value_chain%TYPE := pkg_bcld_parameter.fsbobtienevalorcadena('BASE_DATOS_PRUEBAS');
        sbRemitente       ld_parameter.value_chain%TYPE := pkg_bcld_parameter.fsbObtieneValorCadena ('LDC_SMTP_SENDER');
    sbCorreoInterfaz    ld_parameter.value_chain%TYPE := pkg_bcld_parameter.fsbobtienevalorcadena('CORREO_INTERFAZ_LISTACOSTO');


        --- en este cursor se obtiene el tipo de trabajo, la actividad y el estado de la orden que se esta legalizando
        CURSOR cu_correos IS
      SELECT (regexp_substr(
                sbCorreoInterfaz,
                '[^,]+',
                1,
                LEVEL
               )
          ) AS correo
      FROM dual
      CONNECT BY regexp_substr(sbCorreoInterfaz, '[^,]+', 1, LEVEL) IS NOT NULL;


    CURSOR cuBasePruebas(isbdatebase VARCHAR2)
    IS
    SELECT 1
              FROM (
          SELECT (regexp_substr(
                    sbBasePruebas,
                    '[^,]+',
                    1,
                    LEVEL
                   )
              ) AS BaseDatos
          FROM dual
          CONNECT BY regexp_substr(sbBasePruebas, '[^,]+', 1, LEVEL) IS NOT NULL
          )
             WHERE UPPER (TO_CHAR (BaseDatos)) = UPPER (isbdatebase);



    BEGIN

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE q_ejec
            INTO sbDatebase;

        pkg_Traza.Trace (' sbDatebase: ' || sbDatebase);

    IF cuBasePruebas%ISOPEN THEN
      CLOSE cuBasePruebas;
    END IF;

    OPEN cuBasePruebas(sbDatebase);
    FETCH cuBasePruebas INTO nuVal;
    CLOSE cuBasePruebas;

        sbmessage := sbmensa;

        IF nuVal IS NOT NULL
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
                    'Notificacion de estado de la creacion de listas de costos',
                isbMensaje         => sbmessage);
        END LOOP;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


    EXCEPTION
        WHEN OTHERS
        THEN
      pkg_error.setError;
      pkg_error.geterror(nuError,sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END LDC_MAILLISTCOST;

END ldci_pkinterfazlistprecsap;
/
