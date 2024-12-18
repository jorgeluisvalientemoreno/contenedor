create or replace PROCEDURE      ldc_procinclumas(inuProgramacion in ge_process_schedule.process_schedule_id%TYPE) IS
  /*********************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2014-08-12
    Descripcion : Generamos el proyecto de castigo a usuarios por inclusion manual

    Parametros Entrada

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR     DESCRIPCION
     25/03/2021   DANVAL    Caso 604_1: Validacion del Estado de Corte con base al parametro ESTACORT_NO_PERMI_CASTIGO
     31/05/2021   DANVAL    Caso 604_2: En cambio de alcance, se definio ejecutar el registro GC_PRODPRCA por fuera del ciclo y establecer un mensaje segun el caso, si es o no cartera castigada
     13/07/2021   DANVAL    Caso 604_3: Se modifica el proceso para garantizar el registro de todos los productos validos en la tabla de castigos
     06/07/2022   CGONZALEZ OSF-194: Se adiciona validacion por estado del producto para 7014-Gas
									 Actualizacion de fecha de exclusion cuando el producto no cumpla las validaciones
     19/03/2023   Adrianavg OSF-2389: Se aplican pautas técnicas y se reemplazan servicios homólogos
                            Se declaran variables para la gestión de trazas
                            Se reemplaza ldc_boutilities.splitstrings por regexp_substr
                            Se reemplaza dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbObtieneValorCadena
                            Se reemplaza dald_parameter.fnuGetNumeric_Value por pkg_bcld_parameter.fnuobtienevalornumerico
                            Se declaran variables para inicializar el proceso
                            Se reemplaza consulta de datos para inicializar el proceso según pautas técnicas
                            Se reemplaza ldc_proinsertaestaprog por pkg_estaproc.prinsertaestaproc
                            Se reemplaza ldc_proactualizaestaprog por pkg_estaproc.prinsertaestaproc
                            Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo                            
                            Se reemplaza utl_file.get_line por pkg_gestionarchivos.fsbobtenerlinea_smf
                            Se reemplaza utl_file.fopen por pkg_gestionarchivos.ftabrirarchivo_smf
                            Se reemplaza utl_file.PUT por pkg_gestionarchivos.prcescribirlineasinterm_smf
                            Se reemplaza SELECT-INTO por cursor cuEdoCorteTipProduc, cuEstadoProduc, cuConseProyCast, cuConsecProy
                            Se reemplaza ut_trace.trace por pkg_traza.trace
                            Se reemplaza utl_file.fclose por pkg_gestionarchivos.prccerrararchivo_smf
                            Se reemplaza el tipo de dato de las variables sbnombrearchivo y sbnombrearinco de VARCHAR(30) por ge_boInstanceControl.stysbValue[VARCHAR2(2000)]
                            Se retiran las variables nuparano, nuparmes, nutsess, sbparuser
                            Se ajusta bloque de excepciones según pautas técnicas
  *********************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
	  csbInicio   	      CONSTANT VARCHAR2(35) 	    := pkg_traza.csbINICIO;  
    Onuerrorcode        NUMBER                      := pkg_error.CNUGENERIC_MESSAGE; 
       
    -- Creamos arreglo
    TYPE t_proy_cast_inclu IS TABLE OF ldc_usu_eva_cast%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE t_indice IS TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;
    
    -- Cursor para obtener datos del producto a castigar
    CURSOR curegistr(nucnuse NUMBER) IS
    SELECT c.*, p.identification, p.subscriber_id cliente, j.susccicl ciclo
      FROM ldc_usu_eva_cast c, suscripc j, ge_subscriber p
     WHERE c.producto = nucnuse
       AND c.contrato = j.susccodi
       AND j.suscclie = p.subscriber_id;
    
    table_proy_cast_inclu t_proy_cast_inclu;
    table_indice          t_indice;
    nuconseproycast       gc_proycast.prcacons%TYPE;
    nuconsepp             gc_prodprca.prpccons%TYPE;
    sbnombrearchivo       ge_boInstanceControl.stysbValue;
    sbnombrearinco        ge_boInstanceControl.stysbValue;
    nuvanuse              servsusc.sesunuse%TYPE;
    nuvatipr              servsusc.sesuserv%TYPE;
    cadena                VARCHAR2(4000);
    vfile                 pkg_gestionarchivos.styarchivo;
    vfileinco             pkg_gestionarchivos.styarchivo;
    sbrutaarchiv          VARCHAR2(30);
    nurefarrind           NUMBER(6);
    nucontaindice         NUMBER(6);
    nuposicap             NUMBER(6);
    sw                    NUMBER(1) DEFAULT 0;
    nucontareg            NUMBER(15) DEFAULT 0;
    nucantiregcom         NUMBER(15) DEFAULT 0;
    nucantiregtot         NUMBER(15) DEFAULT 0;
    sbmensaje             VARCHAR2(5000);
    sbmensajeinco         VARCHAR2(100);
    /*nuparano              NUMBER(4);
    nuparmes              NUMBER(2);
    nutsess               NUMBER;
    sbparuser             VARCHAR2(30);*/
    sbOk                  VARCHAR2(3);
    nuHilos               NUMBER := 1;
    nuLogProceso          ge_log_process.log_process_id%TYPE;
    sbParametros          ge_process_schedule.parameters_%TYPE;
    sbproyeccod           VARCHAR2(5000);
   
    --Caso 604_1
    CURSOR cuValestacort(inuCodigo NUMBER) IS
    SELECT COUNT(*)
      FROM ( SELECT TO_NUMBER(REGEXP_SUBSTR(pkg_bcld_parameter.fsbObtieneValorCadena('ESTACORT_NO_PERMI_CASTIGO'),  '[^,]+',  1, LEVEL)) AS columna
               FROM dual
            CONNECT BY REGEXP_SUBSTR(pkg_bcld_parameter.fsbObtieneValorCadena('ESTACORT_NO_PERMI_CASTIGO'), '[^,]+', 1, LEVEL) IS NOT NULL)
     WHERE columna = inucodigo;
    
    nuRespuesta         NUMBER := 0;
    nuEstadoCorte       NUMBER := NULL;
    nuTipoProducto      NUMBER;
    nuValTipoProd       NUMBER := 0;
    
    CURSOR cuValEstaProd(inuCodigo NUMBER) IS
    SELECT COUNT(*)
      FROM ( SELECT TO_NUMBER(REGEXP_SUBSTR(pkg_bcld_parameter.fsbObtieneValorCadena('ESTPROD_NO_PERMI_CASTIGO'),  '[^,]+',  1, LEVEL)) AS columna
               FROM dual
            CONNECT BY REGEXP_SUBSTR(pkg_bcld_parameter.fsbObtieneValorCadena('ESTPROD_NO_PERMI_CASTIGO'), '[^,]+', 1, LEVEL) IS NOT NULL)
     WHERE columna = inucodigo;
        
    nuEstadoProd  pr_product.product_status_id%type;
    dtFechaExcl   gc_prodprca.prpcfeex%TYPE;
    
    CURSOR cuValTipoProducto(inuCodigo NUMBER) IS
    SELECT COUNT(*)
      FROM ( SELECT TO_NUMBER(REGEXP_SUBSTR(pkg_bcld_parameter.fsbObtieneValorCadena('TIPOPROD_VAL_ESTPROD_INCLU'),  '[^,]+',  1, LEVEL)) AS columna
               FROM dual
            CONNECT BY REGEXP_SUBSTR(pkg_bcld_parameter.fsbObtieneValorCadena('TIPOPROD_VAL_ESTPROD_INCLU'), '[^,]+', 1, LEVEL) IS NOT NULL)
     WHERE columna = inucodigo;
    --
    --Caso 604_2
    sbRespuesta varchar2(200);
    --
    --variables para inicializar el proceso
    sbproceso       VARCHAR2(100 BYTE) :=  csbMetodo||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
    sbNameProceso   sbproceso%TYPE; 
    
    CURSOR cuEdoCorteTipProduc(p_nuvanuse servsusc.sesunuse%TYPE)
    IS
    SELECT S.sesuesco, S.sesuserv 
      FROM servsusc S
     WHERE S.sesunuse = p_nuvanuse;  
     
    CURSOR cuEstadoProduc(p_nuvanuse servsusc.sesunuse%TYPE)
    IS
    SELECT product_status_id 
      FROM pr_product
     WHERE product_id = p_nuvanuse;
     
    CURSOR cuConseProyCast
    IS
    SELECT seq_gc_proycast_172026.nextval FROM dual;
    
    CURSOR cuConsecProy
    IS
    SELECT seq_gc_prodprca_172041.nextval FROM dual;    
    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, sbmensaje);
    pkg_traza.trace(csbMetodo ||' inuProgramacion: '||inuProgramacion , csbNivelTraza);
    
    -- inicializar el proceso
    BEGIN
        sbNameProceso:= sbproceso; --invocarlo una sola vez
        pkg_traza.trace(csbMetodo||' sbNameProceso: '||sbNameProceso , csbNivelTraza);
        pkg_estaproc.prinsertaestaproc(sbNameProceso, NULL); 
    EXCEPTION
        WHEN OTHERS THEN
             pkg_error.seterror;
             pkg_error.geterror(onuerrorcode, sbmensaje );
             pkg_traza.trace(csbMetodo||' Error: '||sbmensaje , csbNivelTraza);
             pkg_estaproc.practualizaestaproc( sbNameProceso, 'Error ', sbmensaje  );
    END;                         
                     
    -- se adiciona al log de procesos
    ge_boschedule.AddLogToScheduleProcess(inuProgramacion, nuHilos, nuLogProceso);
    pkg_traza.trace(csbMetodo||' nuLogProceso: '||nuLogProceso , csbNivelTraza);
    nucantiregcom   := 0;
    nucantiregtot   := 0;
    nucontareg      := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CANTIDAD_REG_GUARDAR'); --100
    pkg_traza.trace(csbMetodo ||' nucontareg: '||nucontareg , csbNivelTraza);
    
    sbmensaje       := NULL;
    sbmensajeinco   := NULL;
    sbrutaarchiv    := trim(pkg_bcld_parameter.fsbObtieneValorCadena('RUTA_PROY_CAST_INCLUSI'));--/smartfiles/SCR/cartera
    pkg_traza.trace(csbMetodo ||' sbrutaarchiv: '||sbrutaarchiv , csbNivelTraza);
    
    -- se obtiene parametros
    sbParametros    := dage_process_schedule.fsbGetParameters_(inuProgramacion);
    pkg_traza.trace(csbMetodo ||' sbParametros: '||sbParametros , csbNivelTraza);
    
    sbnombrearchivo := ut_string.getparametervalue(sbParametros, 'SUBSCRIBER_NAME', '|', '=');
    sbnombrearchivo := lower(sbnombrearchivo);
    pkg_traza.trace(csbMetodo ||' sbnombrearchivo: '||sbnombrearchivo , csbNivelTraza);
    
    sbnombrearinco  := 'inconsist.txt';
    pkg_traza.trace(csbMetodo ||' Nombre archivo de inconsistencias: '||sbnombrearinco , csbNivelTraza);
    
    pkg_traza.trace(csbMetodo ||' abrir archivo de inconsistencias '||sbnombrearinco||' modo W' , csbNivelTraza);
    vfileinco       := pkg_gestionarchivos.ftabrirarchivo_smf(sbrutaarchiv, sbnombrearinco, 'W');
    
    pkg_traza.trace(csbMetodo ||' abrir archivo '||sbnombrearchivo||' modo R' , csbNivelTraza);        
    vfile           := pkg_gestionarchivos.ftabrirarchivo_smf(sbrutaarchiv, sbnombrearchivo, 'R');
    
    
    -- Recorre el archivo
    LOOP
        BEGIN
            cadena:= pkg_gestionarchivos.fsbobtenerlinea_smf(vfile);
            pkg_traza.trace(csbMetodo ||' Linea: '||cadena , csbNivelTraza);
        EXCEPTION
            WHEN no_data_found THEN
            EXIT;
        END;
        nuvanuse := TO_NUMBER(TRIM(REPLACE(substr(cadena, 1, 10), chr(13), '')));
        pkg_traza.trace(csbMetodo ||' producto: '||nuvanuse , csbNivelTraza);
        
        -- Obtenemos datos usuarios a castigar
        FOR i IN curegistr(nuvanuse) LOOP
            nuvatipr := i.tipo_producto;
            pkg_traza.trace(csbMetodo ||' tipo_producto: '||nuvatipr , csbNivelTraza);
        
        -- Llenamos el arreglo de indice con sus respectivas agrupaciones
            nurefarrind := table_indice.count;
            IF nurefarrind = 0 THEN
            nucontaindice := 1;
            table_indice(nucontaindice) := nuvatipr;
            nuposicap := nucontaindice;
            ELSE
                sw := 0;
                FOR indice IN 1 .. nurefarrind LOOP
                  IF trim(table_indice(indice)) = nuvatipr THEN
                    nuposicap := indice;
                    sw        := 1;
                    exit;
                  ELSE
                    sw := 0;
                  END IF;
                END LOOP;
        
                IF sw = 0 then
                  nucontaindice := nurefarrind + 1;
                  table_indice(nucontaindice) := nuvatipr;
                  nuposicap := nucontaindice;
                END IF;
            END IF;
            --Caso 604_1: Validacion del Estado de corte actual
            /*Logica:
            Se modificara el procedimiento LDC_PROCINCLUMAS, para agregar la validación del estado de corte actual del producto no se encuentre configurado en el par¿metro ¿ESTACORT_NO_PERMI_CASTIGO¿, si es correcta esta validaci¿n continuara con el proceso normal, en caso contrario terminara el proceso para el producto actual y continuara con el siguiente producto en el ciclo. Así será la lógica:
            1. Se creara el cursor ¿cuValestacort¿, que retornara 1 si el código estado de corte se encuentra en el parámetro ¿ESTACORT_NO_PERMI_CASTIGO¿.
            2. Se validara si el cursor ¿cuValestacort¿ es diferente de 1, si es correcta esta validación continuará con el proceso normal, en caso contrario, terminara el proceso para el producto actual, dejando el mensaje ¿el producto (#producto_actual) se encuentra en estado de corte valido para el proceso de castigo¿, en el archivo de log y continuara con el siguiente producto en el ciclo.
            */
            nuRespuesta := 0;
            nuValTipoProd := 0;
            dtFechaExcl := NULL;
            
            OPEN cuEdoCorteTipProduc(nuvanuse);
            FETCH cuEdoCorteTipProduc INTO nuEstadoCorte, nuTipoProducto;
            CLOSE cuEdoCorteTipProduc;
             
            pkg_traza.trace(csbMetodo ||' nuEstadoCorte: '||nuEstadoCorte , csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' nuTipoProducto: '||nuTipoProducto , csbNivelTraza);
            
            OPEN cuValestacort(nuEstadoCorte);
            FETCH cuValestacort INTO nuRespuesta;
            CLOSE cuValestacort;
            pkg_traza.trace(csbMetodo ||' Estado corte entre los permitidos(>0): '||nuRespuesta , csbNivelTraza);
            
            IF nurespuesta <> 1 THEN
                --Caso 604_3 se cambio de lugar el registro de los proyectos
                --Fin Caso 604_3
                sbrespuesta := '0';
                dtfechaexcl := NULL;
                --
                --Caso 604_1
            ELSE
                sbmensajeinco := ' [ El producto (' || TO_CHAR(I.producto) ||  ') no se encuentra en estado de corte valido para el proceso de castigo ] ';
                pkg_traza.trace(csbMetodo ||' sbmensajeinco: '||sbmensajeinco , csbNivelTraza);
                
                --604_2
                sbrespuesta := 'El producto (' || TO_CHAR(I.producto) || ') no tiene un estado de corte valido';
                pkg_traza.trace(csbMetodo ||' sbrespuesta: '||sbrespuesta , csbNivelTraza);
                --
                dtfechaexcl := sysdate;
                pkg_traza.trace(csbMetodo ||' dtfechaexcl: '||dtfechaexcl , csbNivelTraza);
                
                pkg_gestionarchivos.prcescribirlineasinterm_smf(vfileinco, sbmensajeinco);
            END IF;
        
            pkg_traza.trace(csbMetodo ||' Val Estacort - Producto: '||nuvanuse||' EstadoCorte: '||nuEstadoCorte , csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' sbRespuesta: '||sbRespuesta , csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' dtFechaExcl: '||dtFechaExcl , csbNivelTraza); 
            
            OPEN cuValTipoProducto(nuTipoProducto);
            FETCH cuValTipoProducto INTO nuValTipoProd;
            CLOSE cuValTipoProducto;
            pkg_traza.trace(csbMetodo ||' Tipo Prod aplica(>0): '||nuValTipoProd , csbNivelTraza); 
            
            --Si no fallo por estado de corte, se valida el estado de producto
            IF (nuRespuesta <> 1 AND nuValTipoProd <> 0) THEN
            
                OPEN cuEstadoProduc(nuvanuse);
                FETCH cuEstadoProduc INTO nuEstadoProd;
                CLOSE cuEstadoProduc; 
                pkg_traza.trace(csbMetodo ||' Estado del Prod: '||nuEstadoProd , csbNivelTraza); 
            
                OPEN cuValEstaProd(nuEstadoProd);
                FETCH cuValEstaProd INTO nuRespuesta;
                CLOSE cuValEstaProd;
                pkg_traza.trace(csbMetodo ||' Estado del Prod entre los NO permitidos(>0): '||nuRespuesta , csbNivelTraza); 
            
                IF (nuRespuesta <> 1) THEN
            
                    sbRespuesta := '0';
                    dtFechaExcl := NULL;
                ELSE
                    sbmensajeinco := ' [ El producto ('||TO_CHAR(i.producto)||') no tiene estado de producto valido para el proceso de castigo] ';
                    
                    sbRespuesta := 'El producto ('||TO_CHAR(i.producto)||') no tiene un estado de producto valido'; 
            
                    dtFechaExcl := SYSDATE; 
            
                    pkg_gestionarchivos.prcescribirlineasinterm_smf(vfileinco, sbmensajeinco);
                END IF;
            END IF;
            
            pkg_traza.trace(csbMetodo ||' Val ProductStatus - Producto: '||nuvanuse||' nuEstadoProd: '||nuEstadoProd, csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' sbRespuesta: '||sbRespuesta , csbNivelTraza);
            pkg_traza.trace(csbMetodo ||' dtFechaExcl: '||dtFechaExcl , csbNivelTraza); 
            
              --604_2
              --Inicio 604_3
              pkg_traza.trace(csbMetodo ||' nuposicap: '||nuposicap, csbNivelTraza); 
              IF table_proy_cast_inclu.exists(nuposicap) THEN
                
                pkg_traza.trace(csbMetodo ||' Dato total_deuda del usuario a castigar: '||nvl(i.total_deuda, 0), csbNivelTraza); 
                table_proy_cast_inclu(nuposicap).total_deuda := table_proy_cast_inclu(nuposicap).total_deuda + nvl(i.total_deuda,  0);
                pkg_traza.trace(csbMetodo ||' total_deuda: '||table_proy_cast_inclu(nuposicap).total_deuda , csbNivelTraza); 
                
                table_proy_cast_inclu(nuposicap).producto := table_proy_cast_inclu(nuposicap).producto + 1;
                pkg_traza.trace(csbMetodo ||' producto: '||table_proy_cast_inclu(nuposicap).producto , csbNivelTraza); 
                
                nuconseproycast := table_proy_cast_inclu(nuposicap).contrato;
                pkg_traza.trace(csbMetodo ||' consecutivo del proyecto de castigo: '||nuconseproycast , csbNivelTraza);
                
              ELSE
                -- Obtenemos consecutivo de castigo
                OPEN cuConseProyCast;
                FETCH cuConseProyCast INTO nuconseproycast;
                CLOSE cuConseProyCast; 
                pkg_traza.trace(csbMetodo ||' consecutivo del proyecto de castigo: '||nuconseproycast , csbNivelTraza);
                
                sbmensaje := 'Error al registrar el proyecto de castigo.';
                -- Creamos el proyecto de castigo
                INSERT INTO gc_proycast (prcacons, prcafecr, prcaobse, prcaprpc,
                                         prcasapc, prcaprca, prcasaca, prcaesta,
                                         prcaserv, prcanomb)
                VALUES (nuconseproycast, SYSDATE, 'PRUEBA CASTIGO INCLUSION MANUAL POR PROCESO BASH ' || TO_CHAR(nuvatipr),1,
                       1, 0, 0, NULL, 
                       nuvatipr, 'SALD_CAST_PROC_BACH_' || TO_CHAR(nuvatipr));
                pkg_traza.trace(csbMetodo ||' INSERT INTO gc_proycast , prcacons '||nuconseproycast , csbNivelTraza);      
                 
                table_proy_cast_inclu(nuposicap).total_deuda := nvl(i.total_deuda, 0);
                pkg_traza.trace(csbMetodo ||' total_deuda: '||table_proy_cast_inclu(nuposicap).total_deuda  , csbNivelTraza);
                
                table_proy_cast_inclu(nuposicap).producto := 1;
                pkg_traza.trace(csbMetodo ||' producto: '||table_proy_cast_inclu(nuposicap).producto  , csbNivelTraza);
                
                table_proy_cast_inclu(nuposicap).contrato := nuconseproycast;
                pkg_traza.trace(csbMetodo ||' contrato: '||table_proy_cast_inclu(nuposicap).contrato  , csbNivelTraza);
                
                IF sbproyeccod IS NULL THEN
                  sbproyeccod := 'PROYECTO CASTIGO NRO(S) : ' || TO_CHAR(nuconseproycast);
                ELSE
                  sbproyeccod := sbproyeccod || ',' || TO_CHAR(nuconseproycast);
                END IF;
                pkg_traza.trace(csbMetodo ||' sbproyeccod: '||sbproyeccod , csbNivelTraza);
                
              END IF;
              --Fin Caso 604_3
              --se valida el consecutivo del proyecto
              IF nuconseproycast IS NOT NULL THEN
                -- Consecutivo productos a castigar
                OPEN cuConsecProy;
                FETCH cuConsecProy INTO nuconsepp;
                CLOSE cuConsecProy; 
                pkg_traza.trace(csbMetodo ||' consecutivo del proyecto: '||nuconsepp , csbNivelTraza);
                
                pkg_traza.trace(csbMetodo ||' Datos del usuario a Castigar ' , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' cliente: '||i.cliente , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' contrato: '||i.contrato , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' tipo_producto: '||i.tipo_producto , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' producto: '||i.producto , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' estado_corte: '||i.estado_corte , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' categoria: '||i.categoria , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' subcategoria: '||i.subcategoria , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' departamento: '||i.departamento , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' localidad: '||i.localidad , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' ciclo: '||i.ciclo , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' deuda_facturada: '||i.deuda_facturada , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' deuda_diferida: '||i.deuda_diferida , csbNivelTraza);
                pkg_traza.trace(csbMetodo ||' edad_deuda: '||i.edad_deuda , csbNivelTraza);                  
                
                --se registraran los hallazgos en la tabla gc_prodprca
                BEGIN
                  INSERT INTO gc_prodprca
                    (prpccons,
                     prpcprca,
                     prpcpoca,
                     prpcticl,
                     prpcidcl,
                     prpcclie,
                     prpcsusc,
                     prpcserv,
                     prpcnuse,
                     prpcesco,
                     prpccate,
                     prpcsuca,
                     prpcubg1,
                     prpcubg2,
                     prpcubg3,
                     prpcubg4,
                     prpcubg5,
                     prpccifa,
                     prpcseop,
                     prpcnucu,
                     prpcnufi,
                     prpcspnf,
                     prpcspfi,
                     prpcedde,
                     prpctica,
                     prpcmoca,
                     prpcobse,
                     prpcfeex,
                     prpcfeca,
                     prpcsaca,
                     prpcsare,
                     prpcreca)
                  VALUES
                    (nuconsepp,
                     nuconseproycast,
                     NULL,
                     1,
                     TRIM(i.identification),
                     i.cliente,
                     i.contrato,
                     i.tipo_producto,
                     i.producto,
                     i.estado_corte,
                     i.categoria,
                     i.subcategoria,
                     NULL,
                     i.departamento,
                     i.localidad,
                     NULL,
                     NULL,
                     i.ciclo,
                     NULL,
                     NULL,
                     NULL,
                     i.deuda_facturada,
                     i.deuda_diferida,
                     i.edad_deuda,
                     1,
                     2,
                     'PRUEBA CASTIGO EN BACH ' || TO_CHAR(nuvatipr),
                     dtFechaExcl,
                     NULL,
                     0,
                     0,
                     sbRespuesta);
                     pkg_traza.trace(csbMetodo ||' INSERT INTO gc_prodprca: PRPCCONS[CONSE]= '||nuconsepp||', PRPCPRCA[PROYECTO DE CASTIGO]= '||nuconseproycast||
                     ', PRPCFEEX[FECHA DE EXCLUSION]= '||dtFechaExcl||', PRPCRECA[RESULTADO DE CASTIGO]='||sbRespuesta||
                     ', PRPCSACA[SALDO CASTIGADO]= 0, PRPCSARE[SALDO REACTIVADO]=0', csbNivelTraza);   
                EXCEPTION
                  WHEN OTHERS THEN
                    sbmensajeinco := ' [ Error al procesar el producto : ' || TO_CHAR(i.producto) || ' ' || SQLERRM || ' ] ';
                    pkg_traza.trace(csbMetodo ||' [ Error al procesar el producto : ' || TO_CHAR(i.producto) || ' ' || SQLERRM || ' ] ' , csbNivelTraza);  
                    pkg_gestionarchivos.prcescribirlineasinterm_smf(vfileinco, sbmensajeinco);
                END;
              ELSE
                sbmensajeinco := ' [ Error al procesar el producto : ' || to_char(I.producto) || ' no tiene un proyecto de castigo ] ';
                pkg_traza.trace(csbMetodo ||' [ Error al procesar el producto : ' || to_char(I.producto) || ' no tiene un proyecto de castigo ] ', csbNivelTraza);
                pkg_gestionarchivos.prcescribirlineasinterm_smf(vfileinco, sbmensajeinco);
              END IF;
              --
              nucantiregcom := nucantiregcom + 1;
              IF nucantiregcom >= nucontareg THEN
                COMMIT;
                nucantiregtot := nucantiregtot + nucantiregcom;
                nucantiregcom := 0;
              END IF;
        END LOOP;
    END LOOP;
    -- Fin de archivo
    
    pkg_gestionarchivos.prccerrararchivo_smf(vfile);
    pkg_gestionarchivos.prccerrararchivo_smf(vfileinco);
    
    -- Actualizamos el proyecto de castigo
    FOR i IN 1 .. table_proy_cast_inclu.count LOOP
    UPDATE gc_proycast h
       SET h.prcaprpc = table_proy_cast_inclu(i).producto,
           h.prcasapc = table_proy_cast_inclu(i).total_deuda
     WHERE h.prcacons = table_proy_cast_inclu(i).contrato;
    pkg_traza.trace(csbMetodo ||' UPDATE gc_proycast where prcacons= '||table_proy_cast_inclu(i).contrato, csbNivelTraza);
    END LOOP;
    COMMIT;
    
    nucantiregtot := nucantiregtot + nucantiregcom;
    pkg_traza.trace(csbMetodo ||' nucantiregtot: '||nucantiregtot , csbNivelTraza);
    IF sbmensajeinco IS NULL THEN
        sbmensaje := 'Proceso terminó Ok: se procesaron : ' || TO_CHAR(nucantiregtot) || ' registros. ' || trim(sbproyeccod);
        sbOk      := 'Ok';
    ELSE
        sbmensaje := 'Proceso terminó con inconsistencias: se procesaron : ' || TO_CHAR(nucantiregtot) || ' registros. Revisar archivo de inconsistencias. ' || trim(sbproyeccod);
        sbOk      := 'Nok';
    END IF;
    pkg_traza.trace(csbMetodo ||' sbmensaje: '||sbmensaje , csbNivelTraza);
    pkg_estaproc.practualizaestaproc( sbNameProceso, sbOk, sbmensaje  ); 
    ge_boschedule.changelogProcessStatus(nuLogProceso, 'F');
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        sbmensaje := 'Error en LDC_PROCINCLUMAS ' || ' producto ' || TO_CHAR(nuvanuse) || ' - ' || sqlerrm;
        pkg_estaproc.practualizaestaproc( sbNameProceso, 'NOk ', 'Error en el proceso : ' || ' ' || sbmensaje  ); 
        pkg_Error.setError;
        pkg_Error.getError(onuerrorcode, sbmensaje);
        pkg_traza.trace(csbMetodo ||' sbmensaje: ' || sbmensaje, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
END;
/