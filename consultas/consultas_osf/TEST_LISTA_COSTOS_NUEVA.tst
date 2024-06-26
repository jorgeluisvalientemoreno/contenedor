PL/SQL Developer Test script 3.0
501
-- Created on 6/01/2023 by JORGE VALIENTE 
declare

  nupacodlitinterfaz NUMBER := 32;
  nunumerrorsal      NUMBER;
  sberrorsalida      VARCHAR2(4000);
  TYPE t_bi_listaprecio IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  v_bi_listaprecio t_bi_listaprecio;
  TYPE t_bi_listaprecioitem IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  v_bi_listaprecioitem t_bi_listaprecioitem;
  -- Cursor interfaz
  CURSOR cuinterfaz(nucudatointerfaz NUMBER) IS
    SELECT x.codigo, x.FECHA_INI_VIGEN, x.fecha_final_vige
      FROM open.ldci_intelistpr x
     WHERE x.codigo =
           decode(nucudatointerfaz, -1, x.codigo, nucudatointerfaz);
  -- Cursor obtener los datos de interfaz para crear listas
  CURSOR curegistrosinterfazprocesa(nucuprodlistaproc NUMBER) IS
    SELECT DISTINCT codigo_lista,
                    descripcion_lista,
                    fecha_final_vige,
                    compania,
                    unidad_operativa,
                    contratista,
                    contrato,
                    localidad
      FROM (SELECT m.list_unitary_cost_id codigo_lista,
                   n.description          descripcion_lista,
                   x.fecha_final_vige,
                   n.company_key          compania,
                   n.operating_unit_id    unidad_operativa,
                   n.contractor_id        contratista,
                   n.contract_id          contrato,
                   n.geograp_location_id  localidad
              FROM open.ldci_intelistpr      x,
                   open.ldci_intdetlistprec  y,
                   open.ge_unit_cost_ite_lis m,
                   open.ge_list_unitary_cost n
             WHERE x.estado <> 3
               AND x.codigo =
                   decode(nucuprodlistaproc, -1, x.codigo, nucuprodlistaproc)
               AND trunc(SYSDATE) BETWEEN n.validity_start_date AND
                   n.validity_final_date
               AND x.codigo = y.codigo_interfaz
               AND y.codigo_item = m.items_id
               AND m.list_unitary_cost_id = n.list_unitary_cost_id
               and (n.operating_unit_id is null and n.contractor_id is null and
                   n.contract_id is null and n.geograp_location_id is null)
               and n.VALIDITY_FINAL_DATE > sysdate
            UNION ALL
            SELECT m.list_unitary_cost_id,
                   n.description,
                   x.fecha_final_vige,
                   n.company_key          compania,
                   n.operating_unit_id,
                   n.contractor_id,
                   n.contract_id          contrato,
                   n.geograp_location_id  localidad
              FROM open.ldci_intelistpr      x,
                   open.ldci_intdetlistprec  y,
                   open.ge_unit_cost_ite_lis m,
                   open.ge_list_unitary_cost n,
                   open.ldc_homoitmaitac     h
             WHERE x.estado <> 3
               AND x.codigo =
                   decode(nucuprodlistaproc, -1, x.codigo, nucuprodlistaproc)
               AND trunc(SYSDATE) BETWEEN n.validity_start_date AND
                   n.validity_final_date
               AND x.codigo = y.codigo_interfaz
               AND y.codigo_item = h.item_material
               AND h.item_actividad = m.items_id
               AND m.list_unitary_cost_id = n.list_unitary_cost_id
               and (n.operating_unit_id is null and n.contractor_id is null and
                   n.contract_id is null and n.geograp_location_id is null)
               and n.VALIDITY_FINAL_DATE > sysdate);
  --WHERE codigo_lista = 10;
  -- Cursor para obtener la lista de precio que se va a finalizar
  CURSOR cuitemslistaprec(nucuprodlistaproc open.ldci_intelistpr.codigo%TYPE,
                          nuidlistaprecio   open.ge_list_unitary_cost.list_unitary_cost_id%TYPE) IS
    /*SELECT DISTINCT codigo_item, costo_items, salespres, orden
      FROM (SELECT i.items_id    codigo_item,
                   y.costo_items costo_items,
                   0             AS salespres,
                   1             orden
              FROM open.ldci_intelistpr     x,
                   open.ldci_intdetlistprec y,
                   open.ge_items            i
             WHERE x.estado <> 3
               AND x.codigo =
                   decode(nucuprodlistaproc, -1, x.codigo, nucuprodlistaproc)
               AND x.codigo = y.codigo_interfaz
               AND to_char(y.codigo_item) = i.code
            UNION ALL
            SELECT h.item_actividad, y.costo_items, 0 AS salespres, 3 orden
              FROM open.ldci_intelistpr     x,
                   open.ldci_intdetlistprec y,
                   open.ldc_homoitmaitac    h,
                   open.ge_items            i
             WHERE x.estado <> 3
               AND x.codigo =
                   decode(nucuprodlistaproc, -1, x.codigo, nucuprodlistaproc)
               AND x.codigo = y.codigo_interfaz
               AND to_char(y.codigo_item) = i.code
               AND i.items_id = h.item_material
            -- caso: 207 AND h.item_actividad = m.items_id
            )
    UNION ALL
    SELECT c.items_id, c.price, c.sales_value, 2 as orden
      FROM open.ge_unit_cost_ite_lis c, open.ge_list_unitary_cost b
     WHERE c.list_unitary_cost_id = nuidlistaprecio
       AND c.list_unitary_cost_id = b.list_unitary_cost_id
       and not exists
     (select null
              from open.ldci_intdetlistprec li, open.ge_items i
             where li.codigo_interfaz = nucuprodlistaproc
               and to_char(codigo_item) = i.code
               and c.items_id = i.items_id)
       and not exists (select null
              from open.ldci_intdetlistprec li,
                   open.ge_items            i,
                   open.ldc_homoitmaitac    ac
             where li.codigo_interfaz = nucuprodlistaproc
               and to_char(li.codigo_item) = i.code
               and i.items_id = ac.item_material
               and c.items_id = ac.item_actividad)
     ORDER BY codigo_item, orden;*/
select * from (SELECT DISTINCT codigo_item,
                      costo_items,
                      salespres,
                      orden
        FROM (SELECT i.items_id          codigo_item,
                     y.costo_items          costo_items,
                     0                      AS salespres,
                     1                      orden
                FROM open.ldci_intelistpr      x,
                     open.ldci_intdetlistprec  y,
                     open.ge_items i
               WHERE x.estado <> 3
                 AND x.codigo = decode(nucuprodlistaproc,
                                       -1,
                                       x.codigo,
                                       nucuprodlistaproc)
                 AND x.codigo = y.codigo_interfaz
                 AND to_char(y.codigo_item)=i.code
              UNION ALL
              SELECT h.item_actividad,
                     y.costo_items,
                     0                      AS salespres,
                     3                      orden
                FROM open.ldci_intelistpr      x,
                     open.ldci_intdetlistprec  y,
                     open.ldc_homoitmaitac     h,
                     open.ge_items i
               WHERE x.estado <> 3
                 AND x.codigo = decode(nucuprodlistaproc,
                                       -1,
                                       x.codigo,
                                       nucuprodlistaproc)
                 AND x.codigo = y.codigo_interfaz
                 AND to_char(y.codigo_item) = i.code
                 AND i.items_id=h.item_material
                 -- caso: 207 AND h.item_actividad = m.items_id
                 )
      UNION ALL
      SELECT c.items_id,
             c.price,
             c.sales_value,
             2 as orden
        FROM open.ge_unit_cost_ite_lis c, open.ge_list_unitary_cost b
       WHERE c.list_unitary_cost_id = nuidlistaprecio
         AND c.list_unitary_cost_id = b.list_unitary_cost_id
         and not exists(select null from open.ldci_intdetlistprec li,open.ge_items i where li.codigo_interfaz=nucuprodlistaproc and to_char(codigo_item)=i.code and c.items_id=i.items_id)
         and not exists(select null from open.ldci_intdetlistprec li, open.ge_items i, open.ldc_homoitmaitac ac where li.codigo_interfaz=nucuprodlistaproc and to_char(li.codigo_item)=i.code and i.items_id=ac.item_material and c.items_id=ac.item_actividad)
       ORDER BY codigo_item, orden) aa where aa.codigo_item in (10005534,
10005441,
10007597,
10007708,
10005731,
10007793,
10007921,
10007937,
10007958,
10008268,
10008358,
10008373,
10008471,
10008526,
10008967,
10009105,
10010138,
10010549,
10010550,
10010630,
10010959,
10010961,
10011399,
10004897,
10004902,
10004903,
10004908,
10006413,
10006988,
10006989,
10006990,
10006992,
10007011,
10007087,
10007100,
10007136,
10007238,
10007239,
10007240,
10007437,
10007438,
10007439,
10000734,
10000738,
10000846,
10000868,
10000913,
10000935,
10000937,
10000947,
10000988,
10001316,
10001382,
10004812,
10004813,
10000127,
10000130,
10000227,
10000228,
10000263,
10000301,
10001844,
10001994,
10002055,
10004797,
10004798,
10004799,
10004800,
10004802,
10004803,
10004811,
10000561,
10000622,
10000638,
10000639,
10003538,
10003797,
10004070,
10004146,
10004271,
10004283,
10004319,
10004480	);     

  nuparano           NUMBER(4);
  nuparmes           NUMBER(2);
  nutsess            NUMBER;
  sbparuser          VARCHAR2(30);
  sbmensa            VARCHAR2(4000);
  nucodlistaprecios  open.ldci_intelistpr.codigo%TYPE;
  nunuevalista       open.ge_list_unitary_cost.list_unitary_cost_id%TYPE;
  rcdatlis           open.dage_list_unitary_cost.styge_list_unitary_cost;
  rcdatcos           open.dage_unit_cost_ite_lis.styge_unit_cost_ite_lis;
  dtfechafinal       DATE;
  dtfechaininewlista DATE;
  nuvaloriva         open.ld_parameter.numeric_value%TYPE;
  nuvalnewcosto      open.ge_unit_cost_ite_lis.price%TYPE;
  nuvalsalevalue     open.ge_unit_cost_ite_lis.sales_value%TYPE;
  nuitemactividad    open.ge_items.items_id%TYPE;
  nuitemvalida       open.ge_items.items_id%TYPE;
  nuporcadicional    open.ld_parameter.numeric_value%TYPE;
  nucodinterfazproc  open.ldci_intelistpr.codigo%TYPE;
  sbmensajeproc      open.ldci_intelistpr.mensaje%TYPE;
  nuconta            NUMBER(10) DEFAULT 0;
  nuitems            NUMBER(10) DEFAULT 0;
  nuvaitemsvalida    open.ge_items.items_id%TYPE;
  nuCosf             NUMBER; -- CASO:207
  nuParporcadicional NUMBER; -- CASO:207
  nuPorcentaje       NUMBER; -- CASO:207
  sbcormes           VARCHAR2(4000); --caso:207
  CONTROLLED_ERROR EXCEPTION; --caso:207

  cursor cuListaReciente is
    select list_unitary_cost_id,
           description,
           validity_start_date,
           validity_final_date
      from open.ge_list_unitary_cost
     where operating_unit_id is null
       and geograp_location_id is null
       and contract_id is null
       and contractor_id is null
       and description like '%MATERIALES%'
     order by validity_start_date desc;

  rgListaReciente cuListaReciente%rowtype;
  sbMensaje       varchar2(4000);

BEGIN
  --LDCI_PKINTERFAZLISTPRECSAP.LDC_MAILLISTCOST( 'Inicio del proceso de creacion de nuevas listo de costos interface con SAP' );
  -- Obtenemos datos para realizar ejecucion
  SELECT to_number(to_char(SYSDATE, 'YYYY')),
         to_number(to_char(SYSDATE, 'MM')),
         userenv('SESSIONID'),
         USER
    INTO nuparano, nuparmes, nutsess, sbparuser
    FROM dual;
  -- Se inicia log del programa
  /*ldc_proinsertaestaprog(nuparano,
  nuparmes,
  'LDCI_PKINTERFAZLISTPRECSAP.LDCI_PROCCREALISTAPRECINTERFAZ',
  'En ejecucion',
  nutsess,
  sbparuser);*/
  nucodlistaprecios := nupacodlitinterfaz;
  sbmensajeproc     := 'Se crear?n la(s) lista(s) :';
  v_bi_listaprecio.delete;
  FOR reg IN cuinterfaz(nucodlistaprecios) LOOP
  
    open cuListaReciente;
    fetch cuListaReciente
      into rgListaReciente;
    close cuListaReciente;
  
    dbms_output.put_line('nucodinterfazproc: ' || rgListaReciente.List_Unitary_Cost_Id);
        
    /*nucodinterfazproc := rgListaReciente.List_Unitary_Cost_Id;
  
    nuconta := nuconta + 1;
    \* CASO: 207
    dtfechafinal := to_date(to_char(SYSDATE, 'dd/mm/yyyy') ||
                                ' 23:59:59',
                                'dd/mm/yyyy hh24:mi:ss');*\
    --dbms_output.put_line('if rgListaReciente.Validity_Final_Date['|| rgListaReciente.Validity_Final_Date ||'] > REG.FECHA_INI_VIGEN['|| REG.FECHA_INI_VIGEN ||'] then');
    if rgListaReciente.Validity_Final_Date > REG.FECHA_INI_VIGEN then
      dtfechafinal := REG.FECHA_INI_VIGEN - 1; --CASO: 207
    elsif rgListaReciente.Validity_Final_Date is not null and
          trunc(rgListaReciente.Validity_Final_Date) <
          trunc(REG.FECHA_INI_VIGEN - 1) then
      sbmensa := 'No se puede actualizar la lista debido a que se deja un lapsus de tiempo sin lista';
      raise CONTROLLED_ERROR;
    end if;
  
    -- Se crea la nueva lista y se arma la descripci?n
    SELECT 111 --open.seq_ge_list_unitary_cost.nextval
      INTO nunuevalista
      FROM dual;
    -- Llenamos variables para crear listas
    rcdatlis.list_unitary_cost_id := nunuevalista;
    \*rcdatlis.Description          := TRIM(i.descripcion_lista) ||
    ' - Se crea lista por interfaz codigo : ' ||
    to_char(nucodlistaprecios);*\
    rcdatlis.Description := 'LISTA DE COSTOS DE MATERIALES - Interfaz: ' ||
                            to_char(nucodlistaprecios);
    -- CASO:207 dtfechaininewlista            := to_date(to_char(dtfechafinal + 1,
    dtfechaininewlista := to_date(to_char(REG.FECHA_INI_VIGEN, 'dd/mm/yyyy') ||
                                  ' 00:00:00',
                                  'dd/mm/yyyy hh24:mi:ss');
    --inicio caso:207
    dbms_output.put_line('Paso 0');    
    IF rgListaReciente.Validity_Start_Date is not null then
      if dtfechafinal < rgListaReciente.Validity_Start_Date THEN
        sbmensa := 'La fecha final de la lista de costos ' ||
                   rgListaReciente.List_Unitary_Cost_Id ||
                   ' no puede ser menor que la fecha inicial';
        --raise CONTROLLED_ERROR;
      end if;
    END IF;
  
    if dtfechaininewlista > reg.fecha_final_vige then
      sbmensa := 'Las fechas de costos de la interfaz a procesar presentan un error. La fecha inicial no puede ser mayor que la fecha final';
      --raise CONTROLLED_ERROR;
    end if;
    --fin caso:207
  
    rcdatlis.validity_start_date := dtfechaininewlista;
    rcdatlis.validity_final_date := reg.fecha_final_vige;
    rcdatlis.company_key         := 99;
    rcdatlis.operating_unit_id   := null;
    rcdatlis.user_id             := USER;
    rcdatlis.terminal            := userenv('TERMINAL');
    rcdatlis.contractor_id       := null;
    rcdatlis.contract_id         := null;
    rcdatlis.geograp_location_id := null;
    -- Insertamos el registro
    ---------------dage_list_unitary_cost.insrecord(rcdatlis);
    v_bi_listaprecio(nucodinterfazproc) := nunuevalista;
    -- LLenamos el mensaje
    dbms_output.put_line('Paso 1');       
    IF nuconta = 1 THEN
      sbmensajeproc := TRIM(sbmensajeproc) || ' ACTUAL : ' ||
                       to_char(v_bi_listaprecio(nucodinterfazproc) ||
                               ' ANTES : ' || to_char(nucodinterfazproc));
    ELSE
      sbmensajeproc := TRIM(sbmensajeproc) || ' , ACTUAL : ' ||
                       to_char(v_bi_listaprecio(nucodinterfazproc) ||
                               ' ANTES : ' || to_char(nucodinterfazproc));
    END IF;

  
    -- Creamos los items de las nuevas listas
    v_bi_listaprecioitem.delete;
    --INICIO CASO:207
    nuParporcadicional := NVL(open.dald_parameter.fnuGetNumeric_Value('PORC_ADMIN_ITEM_MATERIAL',
                                                                      NULL),
                              0);
    nuvaloriva         := NVL(open.dald_parameter.fnuGetNumeric_Value('COD_VALOR_IVA',
                                                                      NULL),
                              0);
    nuPorcentaje       := NVL(to_number(open.dage_parameter.fsbgetvalue('AIU_ADMIN_UTIL',
                                                                        NULL)),
                              0) + NVL(to_number(open.dage_parameter.fsbgetvalue('AIU_ADMIN_UNEXPECTED',
                                                                                 NULL)),
                                       0) + NVL(to_number(open.dage_parameter.fsbgetvalue('AIU_ADMIN_ADMIN',
                                                                                          NULL)),
                                                0);
  
    dbms_output.put_line('nuParporcadicional: ' || nuParporcadicional);                                            
    dbms_output.put_line('nuvaloriva:         ' || nuvaloriva);                                            
    dbms_output.put_line('nuPorcentaje:       ' || nuPorcentaje);                                            
    --FIN CASO:207
  
    dbms_output.put_line('Paso 2');     
    dbms_output.put_line('FOR j IN cuitemslistaprec(nupacodlitinterfaz[' || nupacodlitinterfaz ||'], nucodinterfazproc[' || nucodinterfazproc ||']) LOOP');    
    FOR j IN cuitemslistaprec(nupacodlitinterfaz, nucodinterfazproc) LOOP
      nuvaitemsvalida := j.codigo_item;
      dbms_output.put_line('Paso 2.1 nuvaitemsvalida['|| nuvaitemsvalida||']');
      IF v_bi_listaprecioitem.exists(nuvaitemsvalida) THEN
        NULL;
      ELSE
        -- Verificamos si el item de interfaz esta homolohago
        nuitemactividad := NULL;
        IF j.orden = 3 THEN
          -- CASO: 207
          nuitemactividad := j.codigo_item;
        END IF;

        dbms_output.put_line('Paso 3');      
        IF nuitemactividad IS NOT NULL THEN
          nuitemvalida := nuitemactividad;
          \* CASO:207
          nuporcadicional := dald_parameter.fnuGetNumeric_Value('PORC_ADMIN_ITEM_MATERIAL',NULL);
                nuporcadicional := (j.costo_items * (nuporcadicional / 100));*\
          nuporcadicional := nuParporcadicional;
        ELSE
          nuitemvalida    := nuvaitemsvalida;
          nuporcadicional := 0;
        END IF;
      
        -- Llenamos variables para crear items de la listas
        nuvalnewcosto  := 0;
        nuvalsalevalue := 0;
        nuCosf         := 0;
        --INICIO CASO:207
        IF j.orden = 1 OR j.orden = 3 THEN
        
          nuCosf        := j.costo_items +
                           (j.costo_items * (nuvaloriva / 100)); -- se calcula costo osf =(costo sap + iva)
          nuvalnewcosto := nuCosf + (nuCosf * (nuporcadicional / 100)); -- se calcula costo del item de la nueva lista =  (costo osf + costo adicional)
        
          nuvalsalevalue := nuvalnewcosto +
                            (nuvalnewcosto * (nuPorcentaje / 100)); -- precio del item de la nueva lista = (costo del item + porcentaje de venta )
          --FIN CASO:207
        ELSE
          nuvalnewcosto  := nvl(j.costo_items, 0);
          nuvalsalevalue := nvl(j.salespres, 0);
        END IF;
      
        rcdatcos.items_id             := nuitemvalida;
        rcdatcos.list_unitary_cost_id := v_bi_listaprecio(nucodinterfazproc);
        rcdatcos.price                := nuvalnewcosto;
        rcdatcos.last_update_date     := SYSDATE;
        rcdatcos.user_id              := USER;
        rcdatcos.terminal             := userenv('TERMINAL');
        rcdatcos.sales_value          := nuvalsalevalue;
        dbms_output.put_line('nuitemvalida '|| nuitemvalida || ' - nuvalnewcosto:  '|| nuvalnewcosto ||' - nuvalsalevalue: '|| nuvalsalevalue);        
        -- Se adicio a registro
        ------------dage_unit_cost_ite_lis.insrecord(rcdatcos);
        nuitems := nuitems + 1;
      
        v_bi_listaprecioitem(nuitemvalida) := nuitemvalida;
      END IF;
    END LOOP;
    -- Actualizamos el registro de interfaz
  \*UPDATE ldci_intelistpr e
           SET e.estado        = 3,
               fecha_procesado = SYSDATE,
               e.mensaje       = sbmensajeproc
         WHERE e.codigo = reg.codigo;*\*/
  END LOOP;
    dbms_output.put_line('Paso 4');
  sbmensa       := 'Proceso termin? Ok. Se procesar?n: ' ||
                   to_char(nuitems) || ' items, ' || to_char(nuconta) ||
                   ' listas';
  nunumerrorsal := 0;
  sberrorsalida := sbmensa;

end;
0
0
