CREATE OR REPLACE PROCEDURE PERSONALIZACIONES.LDC_PRNOT_CXC_SIN_LEGALIZAR
IS
    /************************************************************************
      Metodo:       PERSONALIZACIONES.LDC_PRNOT_CXC_SIN_LEGALIZAR
      Descripcion:  Procedimiento que valida ordenes de CXC sin legalizar
                    despues de un tiempo de establecido la fecha de ejecucion final.

      Autor:        Jorge Valiente
      Fecha:        01/30/2023
      Parametros:
      Historia de Modificaciones
    FECHA           AUTOR             Observacion
    ----------      -------------     -------------------------------------
    18/06/2024        jpinedc         OSF-2605: * Se usa pkg_Correo
                                      * Ajustes por estandares
    28/08/2024        jpinedc         OSF-3210: Se reemplazan caracteres
                                      extraños                                   
    *************************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) :=  'LDC_PRNOT_CXC_SIN_LEGALIZAR';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef; 

    --Variables
    NUDIAS_SIN_LEG_CXC      LD_PARAMETER.NUMERIC_VALUE%TYPE
                                := pkg_BCLD_Parameter.fnuObtieneValorNumerico('DIAS_SIN_LEG_CXC');

    SBTT_CXC_SIN_LEG        LD_PARAMETER.VALUE_CHAIN%TYPE
                                := pkg_BCLD_Parameter.fsbObtieneValorCadena('TT_CXC_SIN_LEG');

    SBNOT_COR_CXC_SIN_LEG   LD_PARAMETER.VALUE_CHAIN%TYPE
                                := pkg_BCLD_Parameter.fsbObtieneValorCadena('NOT_COR_CXC_SIN_LEG');

    NUERROR                 NUMBER;
    SBERROR                 VARCHAR2 (4000);
    SBERRORCORREO           VARCHAR2 (4000);
    SBASUNTO                VARCHAR2 (4000);

    raise_continuar         EXCEPTION;

    sbEmailNoti             Ld_Parameter.Value_Chain%TYPE;
    sbNomArch               VARCHAR2 (200);

    clReporte               pkg_gestionArchivos.styArchivo;
    sbNomHoja               VARCHAR2 (2000);
    clSentencia             CLOB;

    sbMensaje               ge_error_log.description%TYPE;
    ValParametro            NUMBER := 0; --La cantidad 0 indica que no hay errores, 1indica que al menos un parametro no tiene DATA o no exite.
    ValCorreo               NUMBER := 0; --La cantidad 0 indica que no hay errores, 1indica que al menos un parametro no tiene DATA o no exite.

    sbDirectorio                  VARCHAR2(1000) := 'XML_DIR';
    --cursor
    CURSOR cuCorreos IS
            SELECT REGEXP_SUBSTR (SBNOT_COR_CXC_SIN_LEG,
                                  '[^,]+',
                                  1,
                                  LEVEL)    AS correos
              FROM DUAL
        CONNECT BY REGEXP_SUBSTR (SBNOT_COR_CXC_SIN_LEG,
                                  '[^,]+',
                                  1,
                                  LEVEL)
                       IS NOT NULL;

    rfcuCorreos             cuCorreos%ROWTYPE;

    --Procedimientos y funciones

    --Proicedimiento para registrar inconsistencias del proceso
    --JOB para identificar CXC sin legalizar
    PROCEDURE proInsertLog (sbMensaje VARCHAR2)
    IS
        csbMetodo1        CONSTANT VARCHAR2(105) := csbMetodo || '.proInsertLog';    
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
        
        INSERT INTO LDC_LOG_CXC_SIN_LEG (FECHA_REGISTRO,
                                                           MENSAJE)
             VALUES (SYSDATE, sbMensaje);

        COMMIT;
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);  
    EXCEPTION
        WHEN OTHERS
        THEN
            NULL;
    END proInsertLog;

    --Proicedimiento para Crear un libro de EXCEL
    PROCEDURE proAbrirExcel
    IS
        csbMetodo2        CONSTANT VARCHAR2(105) := csbMetodo || '.proAbrirExcel';     
    BEGIN
    
        pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbINICIO);  

        -- Apertura
        sbNomArch :=
               'OrdenesCXCSinLegalizar'
            || TO_CHAR (SYSDATE, 'DDMMYYYY')
            || '.xls';
                        
        clReporte := pkg_gestionArchivos.ftAbrirArchivo_SMF( sbDirectorio, sbNomArch, 'W' );
        --Iniciar Libro de Excel
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<?xml version="1.0"?>' );
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Workbook xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">' );

        --Definir estilos de formato y fecha
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Styles>' );
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Style ss:ID="OracleDate">' );
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:NumberFormat ss:Format="dd/mm/yyyy\ hh:mm:ss"/>'
            );
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '</ss:Style>' );
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '</ss:Styles>' );

        --Iniciar Hoja de trabajo
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Worksheet ss:Name="'|| sbNomHoja|| '">' );
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Table>', TRUE );
        
        pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN);          
    END proAbrirExcel;

    --Proicedimiento para estabelcer contenido del libro de EXCEL
    PROCEDURE proReporteExcel (p_sql IN VARCHAR2)
    IS
        csbMetodo3        CONSTANT VARCHAR2(105) := csbMetodo || '.proReporteExcel';
        v_v_val        VARCHAR2 (4000);
        v_n_val        NUMBER;
        v_d_val        DATE;
        v_ret          NUMBER;
        c              NUMBER;
        d              NUMBER;
        col_cnt        INTEGER;
        f              BOOLEAN;
        rec_tab        DBMS_SQL.DESC_TAB;
        col_num        NUMBER;
    BEGIN
    
        pkg_traza.trace(csbMetodo3, csbNivelTraza, pkg_traza.csbINICIO);  
            
        --Inicia_Query
        c := DBMS_SQL.OPEN_CURSOR;
        -- se analiza la instruccion SQL --
        DBMS_SQL.PARSE (c, p_sql, DBMS_SQL.NATIVE);
        -- se incia la ejecucion de la sentencia SQL --
        d := DBMS_SQL.EXECUTE (c);
        -- se obtiene la descripcion de las columnas devueltas --
        DBMS_SQL.DESCRIBE_COLUMNS (c, col_cnt, rec_tab);

        -- se enlaza las variables a la columnas por medio de un ciclo FOR --
        FOR j IN 1 .. col_cnt
        LOOP
            CASE rec_tab (j).col_type
                WHEN 1
                THEN
                    DBMS_SQL.DEFINE_COLUMN (c,
                                            j,
                                            v_v_val,
                                            4000);
                WHEN 2
                THEN
                    DBMS_SQL.DEFINE_COLUMN (c, j, v_n_val);
                WHEN 12
                THEN
                    DBMS_SQL.DEFINE_COLUMN (c, j, v_d_val);
                ELSE
                    DBMS_SQL.DEFINE_COLUMN (c,
                                            j,
                                            v_v_val,
                                            4000);
            END CASE;
        END LOOP;

        -- Aqui se muestra la salida de los encabezados de columna

        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Row>',TRUE );

        FOR j IN 1 .. col_cnt
        LOOP
            pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Cell>' );
            pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Data ss:Type="String">'
                || rec_tab (j).col_name
                || '</ss:Data>'
                );
            pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '</ss:Cell>', TRUE );
        END LOOP;

        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '</ss:Row>', TRUE );


        -- datos de salida
        LOOP
            v_ret := DBMS_SQL.FETCH_ROWS (c);
            EXIT WHEN v_ret = 0;
            pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Row>' );

            FOR j IN 1 .. col_cnt
            LOOP
                CASE rec_tab (j).col_type
                    WHEN 1
                    THEN
                        DBMS_SQL.COLUMN_VALUE (c, j, v_v_val);
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Cell>' );
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Data ss:Type="String">'
                            || v_v_val
                            || '</ss:Data>'
                            );
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte,  '</ss:Cell>' );
                    WHEN 2
                    THEN
                        DBMS_SQL.COLUMN_VALUE (c, j, v_n_val);
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Cell>' );
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte,
                            '<ss:Data ss:Type="Number">'
                            || TO_CHAR (v_n_val)
                            || '</ss:Data>'
                            );
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '</ss:Cell>' );
                    WHEN 12
                    THEN
                        DBMS_SQL.COLUMN_VALUE (c, j, v_d_val);
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Cell ss:StyleID="OracleDate">'
                            );
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Data ss:Type="DateTime">'
                            || TO_CHAR (v_d_val, 'YYYY-MM-DD"T"HH24:MI:SS')
                            || '</ss:Data>'
                            );
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '</ss:Cell>' );
                    ELSE
                        DBMS_SQL.COLUMN_VALUE (c, j, v_v_val);
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '<ss:Cell>' );
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte,'<ss:Data ss:Type="String">'
                            || v_v_val
                            || '</ss:Data>'
                            );
                        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '</ss:Cell>' );
                END CASE;
            END LOOP;

            pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '</ss:Row>' , TRUE);
        END LOOP;

        DBMS_SQL.CLOSE_CURSOR (c);
        
        pkg_traza.trace(csbMetodo3, csbNivelTraza, pkg_traza.csbFIN);  
                
    EXCEPTION
        WHEN OTHERS
        THEN
            sbMensaje :=
                'Error en ejecucion sentencia para el reporte.' || SQLERRM;
            RAISE raise_continuar;
    END proReporteExcel;

    --Proicedimiento para cierre del libro de EXCEL
    PROCEDURE procierreExcel
    IS
        csbMetodo4        CONSTANT VARCHAR2(105) := csbMetodo || '.procierreExcel';
    BEGIN

        pkg_traza.trace(csbMetodo4, csbNivelTraza, pkg_traza.csbINICIO);  
    
        --Fin de la hoja de trabajo
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '</ss:Table>' );
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '</ss:Worksheet>' );
        --Fin del libro de excel
        pkg_gestionArchivos.prcEscribirLinea_SMF( clReporte, '</ss:Workbook>', TRUE );

        pkg_gestionArchivos.prcCerrarArchivo_SMF( clReporte );

        pkg_traza.trace(csbMetodo4, csbNivelTraza, pkg_traza.csbFIN); 
        
    END proCierreExcel;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    ---Validacion de Parametros para ejecucion del proceso del JOB
    IF SBNOT_COR_CXC_SIN_LEG IS NULL
    THEN
        ValCorreo := 1;
        SBERRORCORREO :=
            'El parametro NOT_COR_CXC_SIN_LEG no existe o no tiene DATA valida. Valdiar en LDPAR';
        proInsertLog (SBERRORCORREO);
    END IF;

    IF NUDIAS_SIN_LEG_CXC IS NULL
    THEN
        ValParametro := 1;
        sbError := 'DIAS_SIN_LEG_CXC';
    END IF;

    IF SBTT_CXC_SIN_LEG IS NULL
    THEN
        ValParametro := 1;

        IF sbError IS NULL
        THEN
            sbError := 'TT_CXC_SIN_LEG';
        ELSE
            sbError := sbError || ' y TT_CXC_SIN_LEG';
        END IF;
    END IF;


    SBASUNTO := 'Ordenes de Cargo por Conexión sin legalizar';

    --Notificar por correo inconveintes con los primeros 2 paramertos
    IF ValParametro = 1
    THEN
        SBERRORCORREO :=
               'El o los parametros '
            || sbError
            || ' no existe(n) o no tiene(n) DATA consistente. Validar en LDPAR';

        --Envia correo si existen en el parametro
        IF ValCorreo = 0
        THEN
            FOR rfcuCorreos IN cuCorreos
            LOOP
                        
                pkg_Correo.prcEnviaCorreo
                (
                    isbDestinatarios    => rfcuCorreos.Correos,
                    isbAsunto           => sbAsunto,
                    isbMensaje          => SBERRORCORREO
                );
                
            END LOOP;
        END IF;

        proInsertLog (SBERRORCORREO);
    END IF;

    --Fin validacion de parametros

    IF ValParametro = 0 AND ValCorreo = 0
    THEN
        sbNomHoja := 'Ordenes CXC Sin Legalizar';
        clSentencia :=
               'SELECT rownum ID,
                          to_char(a.order_id) ORDEN,
                          to_char(oa.subscription_id) CONTRATO,
                          to_char(oa.product_id) PRODUCTO,
                          a.order_status_id || '' - '' || OOS.DESCRIPTION ESTADO_ORDEN,
                          to_char(OL.EXEC_FINAL_DATE) AS FECHA_EJECUCION_FINAL,
                          to_char(trunc(sysdate - OL.EXEC_FINAL_DATE)) AS DIAS_SIN_LEGALIZAR,
                          dp.category_id || '' - '' || C.CATEDESC AS CATEGORIA,
                          dp.subcategory_id || '' - '' || SC.SUCADESC As SUBCATEGORIA,
                          a.operating_unit_id || '' - '' || DUO.Name as UNIDAD_OPERATIVA,
                          DUO.Contractor_Id || '' - '' || GCON.NOMBRE_CONTRATISTA CONTRATISTA
                     FROM or_order A
                    INNER JOIN or_order_activity oa
                       ON oa.order_id = a.order_id
                    INNER JOIN pr_product DP
                       ON DP.PRODUCT_ID = oa.product_id
                    INNER JOIN or_operating_unit DUO
                       ON DUO.OPERATING_UNIT_ID = A.Operating_Unit_Id
                    INNER JOIN OR_ORDER_STATUS OOS
                       ON OOS.ORDER_STATUS_ID = A.ORDER_STATUS_ID
                    INNER JOIN ldc_otlegalizar ol
                       ON ol.order_id = a.order_id
                    INNER JOIN CATEGORI C
                       ON C.CATECODI = dp.category_id
                    INNER JOIN subcateg SC
                       ON SC.SUCACATE = dp.category_id
                      AND SC.SUCACODI = dp.subcategory_id
                    INNER JOIN GE_CAUSAL GC
                       ON GC.CAUSAL_ID = OL.CAUSAL_ID
                      AND GC.class_causal_id = 1
                    INNER JOIN ge_contratista GCON
                       ON GCON.ID_CONTRATISTA = DUO.Contractor_Id
             WHERE a.task_type_id IN (SELECT to_number(regexp_substr('''|| SBTT_CXC_SIN_LEG || ''',''[^,]+'',1,LEVEL)) AS task_type
                                        FROM dual
                                      CONNECT BY regexp_substr('''|| SBTT_CXC_SIN_LEG|| ''', ''[^,]+'', 1, LEVEL) IS NOT NULL)
               AND a.order_status_id in (7,5)
               AND trunc(sysdate - ol.exec_final_date) >= '|| NUDIAS_SIN_LEG_CXC|| '  order by 1';
            
        proAbrirExcel;
        proReporteExcel (clSentencia);
        proCierreExcel;
            
        --Envio correo
        FOR rfcuCorreos IN cuCorreos
        LOOP
            sbEmailNoti := rfcuCorreos.Correos;
 
             pkg_Correo.prcEnviaCorreo
             (
                 isbDestinatarios    => TRIM (sbEmailNoti),
                 isbAsunto           => sbAsunto,
                 isbMensaje          => 'Se adjunta archivo con la información de las ordenes de cargo por conexión pendientes por legalizar',
                 isbArchivos         => sbDirectorio || '/' || sbNomArch
             );

        END LOOP;
    END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
EXCEPTION
    WHEN OTHERS
    THEN
        pkg_Error.setError ();
        pkg_Error.getError (nuError, sbError);

        SBERROR := nuError || ' - ' || sbError || ' - ' || SQLERRM;
        ROLLBACK;
        proInsertLog (sbError);
END LDC_PRNOT_CXC_SIN_LEGALIZAR;
/