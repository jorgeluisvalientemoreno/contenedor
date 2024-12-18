CREATE OR REPLACE PROCEDURE LDC_EXPORT_REPORT_EXCEL (
    sbRutaArchivo       IN VARCHAR2,
    sbNombreArchivo     IN VARCHAR2,
    sbNombreHojaExcel   IN VARCHAR2,
    sbSentencia         IN CLOB)
IS
    /*******************************************************************************
   Metodo:       LDC_EXPORT_REPORT_EXCEL
   Descripcion:  Procedimiento para generar reportes en excel por medio de una consulta SQL,
                 El reporte es generado de acuerdo a los datos que trae la consulta, asi se visualizaran
                 los datos en cada celda con el encanbezado en especifico.

   Autor:        Olsoftware/Miguel Ballesteros
   Fecha:        07/09/2019

   Entrada                Descripcion
   sbRutaArchivo:         Ruta en donde se generará el archivo en el servidor
   sbNombreArchivo:       Nombre del Archivo de Excel
   sbNombreHojaExcel:     El nombre que tendra la hoja de excel
   sbSentencia:           Sentencia Sql de donde se tomaran los datos a visualizar en el excel

   Salida             Descripcion

   Historia de Modificaciones
   FECHA        AUTOR                       DESCRIPCION
    jpinedc     05/03/2024          OSF-2375: Ajuste Validación Técnica
  *******************************************************************************/

    csbMetodo        CONSTANT VARCHAR2(70) :=  'LDC_EXPORT_REPORT_EXCEL';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;    
    nuError         NUMBER;
    sbError         VARCHAR2(4000);  
    
    fiArchivo       pkg_gestionArchivos.styArchivo;

    posicion        NUMBER := 1;
    posNameHoja     NUMBER := 0;
    posSentence     NUMBER := 0;

    ------------------------------------------------------------------------------
    -- Declaracion de variables para el procedimiento Relahojasentencrear_excel --
    ------------------------------------------------------------------------------
    -- cursor que separa la cadena sbNombreHojaExcel
    CURSOR cuNameHojaExc IS
    SELECT regexp_substr(sbNombreHojaExcel,'[^|]+', 1,LEVEL) COLUMN_VALUE
    FROM dual
    CONNECT BY regexp_substr(sbNombreHojaExcel, '[^|]+', 1, LEVEL) IS NOT NULL;

    -- cursor que separa la cadena sbSentencia
    CURSOR cuSentencia IS
        SELECT COLUMN_VALUE FROM TABLE (Split_clob (sbSentencia, '|'));

    --Definición del Tipo Tabla:
    TYPE typ_assoc_array IS TABLE OF /*VARCHAR2(2000)*/
                                     CLOB
        INDEX BY PLS_INTEGER;

    --Declaramos una Variable del Tipo Tabla anterior:
    v_CellnameHoj   typ_assoc_array;
    v_CellSentenc   typ_assoc_array;

    ---------------------------------------------
    -- Inicio de los procedimientos Auxiliares --
    ---------------------------------------------

    -- procedimiento que inicia todo el proceso de la adecuacion de la consulta en las celdas del excel --
    PROCEDURE Inicia_Query (p_sql IN VARCHAR2)
    IS

        csbMetodo1        CONSTANT VARCHAR2(105) :=  csbMetodo || '.Inicia_Query';
        nuError1         NUMBER;
        sbError1         VARCHAR2(4000); 
        
        v_v_val   VARCHAR2 (4000);
        v_n_val   NUMBER;
        v_d_val   DATE;
        v_ret     NUMBER;
        c         NUMBER;
        d         NUMBER;
        col_cnt   INTEGER;
        f         BOOLEAN;
        rec_tab   DBMS_SQL.DESC_TAB;
        col_num   NUMBER;
    BEGIN
    
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);
            
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
        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '<ss:Row>');

        FOR j IN 1 .. col_cnt
        LOOP
            pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '<ss:Cell>');
            pkg_gestionArchivos.prcEscribirLinea_SMF (
                fiArchivo,
                   '<ss:Data ss:Type="String">'
                || rec_tab (j).col_name
                || '</ss:Data>');
            pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Cell>');
        END LOOP;

        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Row>');

        -- datos de salida
        LOOP
            v_ret := DBMS_SQL.FETCH_ROWS (c);
            EXIT WHEN v_ret = 0;
            pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '<ss:Row>');

            FOR j IN 1 .. col_cnt
            LOOP
                CASE rec_tab (j).col_type
                    WHEN 1
                    THEN
                        DBMS_SQL.COLUMN_VALUE (c, j, v_v_val);
                        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '<ss:Cell>');
                        pkg_gestionArchivos.prcEscribirLinea_SMF (
                            fiArchivo,
                               '<ss:Data ss:Type="String">'
                            || v_v_val
                            || '</ss:Data>');
                        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Cell>');
                    WHEN 2
                    THEN
                        DBMS_SQL.COLUMN_VALUE (c, j, v_n_val);
                        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '<ss:Cell>');
                        pkg_gestionArchivos.prcEscribirLinea_SMF (
                            fiArchivo,
                               '<ss:Data ss:Type="Number">'
                            || TO_CHAR (v_n_val)
                            || '</ss:Data>');
                        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Cell>');
                    WHEN 12
                    THEN
                        DBMS_SQL.COLUMN_VALUE (c, j, v_d_val);
                        pkg_gestionArchivos.prcEscribirLinea_SMF (
                            fiArchivo,
                            '<ss:Cell ss:StyleID="OracleDate">');
                        pkg_gestionArchivos.prcEscribirLinea_SMF (
                            fiArchivo,
                               '<ss:Data ss:Type="DateTime">'
                            || TO_CHAR (v_d_val, 'YYYY-MM-DD"T"HH24:MI:SS')
                            || '</ss:Data>');
                        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Cell>');
                    ELSE
                        DBMS_SQL.COLUMN_VALUE (c, j, v_v_val);
                        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '<ss:Cell>');
                        pkg_gestionArchivos.prcEscribirLinea_SMF (
                            fiArchivo,
                               '<ss:Data ss:Type="String">'
                            || v_v_val
                            || '</ss:Data>');
                        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Cell>');
                END CASE;
            END LOOP;

            pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Row>');
        END LOOP;

        DBMS_SQL.CLOSE_CURSOR (c);
        
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);     
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError1,sbError1);        
            pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError1,sbError1);
            pkg_traza.trace('sbError1 => ' || sbError1, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END Inicia_Query;

    --

    -- procedimiento que incia la hoja de excel --
    PROCEDURE start_workbook
    IS
        csbMetodo2        CONSTANT VARCHAR2(105) :=  csbMetodo || '.start_workbook';
        nuError2         NUMBER;
        sbError2         VARCHAR2(4000);     
    BEGIN
        pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbINICIO);         
        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '<?xml version="1.0"?>');
        pkg_gestionArchivos.prcEscribirLinea_SMF (
            fiArchivo,
            '<ss:Workbook xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">');
        pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN);                 
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError2,sbError2);        
            pkg_traza.trace('sbError2 => ' || sbError2, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError2,sbError2);
            pkg_traza.trace('sbError2 => ' || sbError2, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END start_workbook;

    -- procedimiento que finaliza la hoja de excel --
    PROCEDURE end_workbook
    IS
        csbMetodo3        CONSTANT VARCHAR2(105) :=  csbMetodo || '.end_workbook';
        nuError3         NUMBER;
        sbError3         VARCHAR2(4000);     
    BEGIN
        pkg_traza.trace(csbMetodo3, csbNivelTraza, pkg_traza.csbINICIO);      
        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Workbook>');
        pkg_traza.trace(csbMetodo3, csbNivelTraza, pkg_traza.csbFIN);   
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo3, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError3,sbError3);        
            pkg_traza.trace('sbError3 => ' || sbError3, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo3, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError3,sbError3);
            pkg_traza.trace('sbError3 => ' || sbError3, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END end_workbook;


    -- procedimiento que establece el nombre de la hoja de excel --
    PROCEDURE start_worksheet (p_sheetname IN VARCHAR2)
    IS
        csbMetodo4       CONSTANT VARCHAR2(105) :=  csbMetodo || '.start_worksheet';
        nuError4         NUMBER;
        sbError4         VARCHAR2(4000);     
    BEGIN
    
        pkg_traza.trace(csbMetodo4, csbNivelTraza, pkg_traza.csbINICIO);   
            
        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo,
                           '<ss:Worksheet ss:Name="' || p_sheetname || '">');
        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '<ss:Table>');

        pkg_traza.trace(csbMetodo4, csbNivelTraza, pkg_traza.csbFIN);   
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo4, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError4,sbError4);        
            pkg_traza.trace('sbError4 => ' || sbError4, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo4, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError4,sbError4);
            RAISE pkg_error.Controlled_Error;            
    END start_worksheet;

    -- procedimiento que se define el final de cada hoja de acuerdo a la sentencia --
    PROCEDURE end_worksheet
    IS
        csbMetodo5       CONSTANT VARCHAR2(105) :=  csbMetodo || '.end_worksheet';
        nuError5         NUMBER;
        sbError5         VARCHAR2(4000);      
    BEGIN
        pkg_traza.trace(csbMetodo5, csbNivelTraza, pkg_traza.csbINICIO);       
        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Table>');
        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Worksheet>');
        pkg_traza.trace(csbMetodo5, csbNivelTraza, pkg_traza.csbFIN);   
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo5, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError5,sbError5);        
            pkg_traza.trace('sbError5 => ' || sbError5, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo5, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError5,sbError5);
            RAISE pkg_error.Controlled_Error;            
    END end_worksheet;


    -- procedimiento en donde se establece el formato de excel --
    PROCEDURE set_date_style
    IS
        csbMetodo6       CONSTANT VARCHAR2(105) :=  csbMetodo || '.set_date_style';
        nuError6         NUMBER;
        sbError6         VARCHAR2(4000);        
    BEGIN
        pkg_traza.trace(csbMetodo6, csbNivelTraza, pkg_traza.csbINICIO);     
        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '<ss:Styles>');
        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '<ss:Style ss:ID="OracleDate">');
        pkg_gestionArchivos.prcEscribirLinea_SMF (
            fiArchivo,
            '<ss:NumberFormat ss:Format="dd/mm/yyyy\ hh:mm:ss"/>');
        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Style>');
        pkg_gestionArchivos.prcEscribirLinea_SMF (fiArchivo, '</ss:Styles>');
        pkg_traza.trace(csbMetodo6, csbNivelTraza, pkg_traza.csbFIN);          
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo6, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError6,sbError6);        
            pkg_traza.trace('sbError6 => ' || sbError6, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo6, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError6,sbError6);
            RAISE pkg_error.Controlled_Error;  
    END set_date_style;


    -- procedimiento que relaciona cada hoja ingresada con cada sentencia --
    PROCEDURE Relahojasentencrear_excel
    IS
        csbMetodo7       CONSTANT VARCHAR2(105) :=  csbMetodo || '.Relahojasentencrear_excel';
        nuError7         NUMBER;
        sbError7        VARCHAR2(4000);      
    BEGIN
        ----------------- Se recorren los cursores y se guardan en vectores -----------------
        pkg_traza.trace(csbMetodo7, csbNivelTraza, pkg_traza.csbINICIO);  

        FOR item IN cuNameHojaExc
        LOOP
            v_CellnameHoj (posicion) := item.COLUMN_VALUE;

            EXIT WHEN cuNameHojaExc%NOTFOUND; ---si no encuentra mas valores dentro del cursor termina el ciclo.
            posicion := posicion + 1;
        END LOOP;

        posicion := 1;


        FOR item IN cuSentencia
        LOOP
            v_CellSentenc (posicion) := item.COLUMN_VALUE;

            EXIT WHEN cuSentencia%NOTFOUND; ---si no encuentra mas valores dentro del cursor termina el ciclo.
            posicion := posicion + 1;
        END LOOP;


        ------- Se valida que la cantidad de hojas ingresadas y de las sentencias sean las mismas -------

        IF (v_CellnameHoj.COUNT = v_CellSentenc.COUNT)
        THEN
            -- se recorre la primera lista que tiene el nombre de las hojas
            FOR i IN v_CellnameHoj.FIRST .. v_CellnameHoj.LAST
            LOOP
                posNameHoja := i;

                -- se recorre la segunda lista que tiene el nombre de las sentencias
                FOR j IN v_CellSentenc.FIRST .. v_CellSentenc.LAST
                LOOP
                    posSentence := j;

                    -- si la posicion de la lista de las hojas es igual al de las sentencias, entonces se llama al procedimiento de creacion del excel
                    IF (posNameHoja = posSentence)
                    THEN
                        start_worksheet (v_CellnameHoj (i)); -- el nombre que tendrá la hoja
                        Inicia_Query (v_CellSentenc (j));      -- la sentencia
                        end_worksheet;
                    END IF;
                END LOOP;
            END LOOP;
        ELSE
            RAISE_APPLICATION_ERROR (
                -20001,
                'El numero de hojas debe ser igual al numero de sentencias');
        END IF;
        pkg_traza.trace(csbMetodo7, csbNivelTraza, pkg_traza.csbFIN);          
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo7, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError7,sbError7);        
            pkg_traza.trace('sbError7 => ' || sbError7, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo7, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError7,sbError7);
            RAISE pkg_error.Controlled_Error; 
    END Relahojasentencrear_excel;
------------------------------------------
-- Fin de los procedimientos Auxiliares --
------------------------------------------

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
    fiArchivo :=
        pkg_gestionArchivos.ftAbrirArchivo_SMF (sbRutaArchivo,
                        sbNombreArchivo || '.xls',
                        pkg_gestionArchivos.csbMODO_ESCRITURA);
    start_workbook;
    
    set_date_style;

    -- se llama al procedimiento para la creacion del reporte
    Relahojasentencrear_excel;

    end_workbook;

    pkg_gestionArchivos.prcCerrarArchivo_SMF (fiArchivo, sbRutaArchivo, sbNombreArchivo || '.xls' );
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);     
    
EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);        
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
END LDC_EXPORT_REPORT_EXCEL;
/

GRANT EXECUTE on LDC_EXPORT_REPORT_EXCEL to SYSTEM_OBJ_PRIVS_ROLE
/
