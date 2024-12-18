CREATE OR REPLACE PACKAGE personalizaciones.pkg_cadena_legalizacion
AS
/*******************************************************************************
    Package:        personalizaciones.pkg_cadena_legalizacion
    Descripción:    Paquete con los métodos para el armado de la cadena de 
                    legalización de ordenes en version 7.07 de SmartFlex
    Autor:          Lubin Pineda
    Fecha:          24/11/2023 

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    24/11/2023      jpinedc             OSF-1938 : Creación el paquete
*******************************************************************************/


    -- Tipo de registro que contiene la cadena de legalización
    TYPE tyCadenaLegalizacion IS RECORD( sbCadena VARCHAR2(32000) );
    
    -- Retorna el id del último caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Coloca en memoria los datos básicos
    PROCEDURE prSetDatosBasicos
    (
        inuOrden            NUMBER,
        inuCausal           NUMBER,
        inuPersona          NUMBER,
        inuTipoComentario   NUMBER, 
        isbComentario       VARCHAR2
    );
    
    -- Agrega un dato adicional a la cadena de datos adicionales
    PROCEDURE prAgregaDatoAdicional(isbAtributo VARCHAR2, isbValor VARCHAR2);

    -- Agrega una actvidad de la orden a la cadena de actividades    
    PROCEDURE prAgregaActividadOrden
    (
        inuIdActOrden   NUMBER   DEFAULT NULL, 
        inuCantLega     NUMBER   DEFAULT NULL, 
        isbActApoy      VARCHAR2 DEFAULT NULL,
        isbNombAtrib1   VARCHAR2 DEFAULT NULL,
        isbValoAtrib1   VARCHAR2 DEFAULT NULL,    
        isbNombAtrib2   VARCHAR2 DEFAULT NULL,
        isbValoAtrib2   VARCHAR2 DEFAULT NULL,
        isbNombAtrib3   VARCHAR2 DEFAULT NULL,
        isbValoAtrib3   VARCHAR2 DEFAULT NULL,
        isbNombAtrib4   VARCHAR2 DEFAULT NULL,
        isbValoAtrib4   VARCHAR2 DEFAULT NULL       
    );

    -- Agrega un item a la cadena de items    
    PROCEDURE prAgregaItem
    (
        inuItem         NUMBER,
        inuCantLega     NUMBER,
        isbInstala      VARCHAR2,
        isbCodElemento  VARCHAR2
    );

    -- Agrega una lectura en la tabla pl de lecturas de los seriales       
    PROCEDURE prAgregaLecturaSerial
    (
        isbSerial       VARCHAR2,
        inuTipoConsumo  NUMBER,
        inuLectura      NUMBER,
        isbCausa        VARCHAR2,
        inuObservacion1 NUMBER,      
        inuObservacion2 NUMBER,
        inuObservacion3 NUMBER        
    );

    -- Retorna un registro con la cadena de legalización        
    FUNCTION fsbCadenaLegalizacion RETURN CONSTANTS_PER.TIPO_XML_SOL%TYPE;
                  
END pkg_cadena_legalizacion; 
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_cadena_legalizacion IS

    -- Versión del paquete
    csbVersion              CONSTANT VARCHAR2(15) := 'OSF-1938';

    csbSP_NAME		        CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT ||'.';
    csbNivelTraza           CONSTANT NUMBER(2)     := pkg_traza.fnuNivelTrzDef;
 
    nuOrden                 NUMBER;
    nuCausal                NUMBER;
    nuPersona               NUMBER;
    sbCadDatosAdicionales   VARCHAR2(4000);
    sbCadActividades        VARCHAR2(4000);
    sbCadItems              VARCHAR2(4000);
    sbCadLecturas           VARCHAR2(4000);
    sbCadComentario         VARCHAR2(4000);
    
    TYPE tytbLecturasSerial IS TABLE OF VARCHAR2(4000) INDEX BY VARCHAR(50);
    
    tbLecturasSerial        tytbLecturasSerial;

    /*******************************************************************************
    Método:         fsbVersion
    Descripción:    Funcion que retorna la csbVersion, la cual indica el último
                    caso que modificó el paquete. Se actualiza cada que se ajusta
                    algún Método del paquete

    Autor:          Lubin Pineda
    Fecha:          24/11/2023

    Entrada         Descripción
    NA

    Salida          Descripción
    csbVersion      Ultima version del paquete

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    24/11/2023      jpinedc             OSF-1938 : Creación
    *******************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /*******************************************************************************
    Método:         prSetDatosBasicos
    Descripción:    Coloca en memoria los datos básicos

    Autor:          Lubin Pineda
    Fecha:          24/11/2023

    Entrada             Descripción
    inuOrden            Orden a legaliza
    inuCausal           Causal de legalización
    inuPersona          Persona que legaliza
    inuTipoComentario   Tipo de comentario
    isbComentario       Comentario de legalización

    Salida          Descripción
    NA

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    24/11/2023      jpinedc             OSF-1938 : Creación
    *******************************************************************************/    
    PROCEDURE prSetDatosBasicos
    (
        inuOrden            NUMBER,
        inuCausal           NUMBER,
        inuPersona          NUMBER,
        inuTipoComentario   NUMBER, 
        isbComentario       VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70)  := csbSP_NAME || 'prSetDatosBasicos';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        tbLecturasSerial.Delete;
        
        nuOrden                 := inuOrden;
        nuCausal                := inuCausal;
        nuPersona               := inuPersona;
        sbCadDatosAdicionales   := NULL;
        sbCadActividades        := NULL;
        sbCadItems              := NULL;
        sbCadLecturas           := NULL;
        sbCadComentario         := inuTipoComentario || ';' || isbComentario;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_error.Controlled_Error;                         
    END prSetDatosBasicos;

    /*******************************************************************************
    Método:         prAgregaDatoAdicional
    Descripción:    Agrega un dato adicional a la cadena de datos adicionales

    Autor:          Lubin Pineda
    Fecha:          24/11/2023

    Entrada             Descripción
    isbAtributo         Nomber del atributo adicional
    isbValor            Valor del atributo adicional

    Salida          Descripción
    NA

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    24/11/2023      jpinedc             OSF-1938 : Creación
    *******************************************************************************/  
    PROCEDURE prAgregaDatoAdicional(isbAtributo VARCHAR2, isbValor VARCHAR2) IS
        csbMetodo        CONSTANT VARCHAR2(70)  := csbSP_NAME || 'prAgregaDatoAdicional';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
         
        IF sbCadDatosAdicionales IS NOT NULL THEN
            sbCadDatosAdicionales := sbCadDatosAdicionales || ';';
        END IF;
        sbCadDatosAdicionales := sbCadDatosAdicionales || isbAtributo || '=' || isbValor;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_error.Controlled_Error;       
    END prAgregaDatoAdicional;

    /*******************************************************************************
    Método:         prAgregaActividadOrden
    Descripción:    Agrega una actvidad de la orden a la cadena de actividades.
                    Si se invoca sin parámetros 
                    * inuIdActOrden = la que se encuentre en estado R - Registrada
                    * inuCantLega   =  1 si la causal es de éxito y 0 si es de fallo
                    * Los demás parámetros se colocarán en NULL

    Autor:          Lubin Pineda
    Fecha:          24/11/2023

    Entrada             Descripción
    inuIdActOrden       Id de la actividad de la orden 
    inuCantLega         Cantidad con la que se legaliza
    isbActApoy          Lista de Actividaded de Apoyo
    isbNombAtrib1       Nombre del Atributo1 = READING para actividades de lectura
    isbValoAtrib1       Valor del Atributo1  = Lectura para actividades de lectura
    isbNombAtrib2       Nombre del Atributo2 = COMMENT1 para actividades de lectura
    isbValoAtrib2       Valor del Atributo2  = Observación de Lectura para actividades de lectura
    isbNombAtrib3       Nombre del Atributo3 = COMMENT2 para actividades de lectura
    isbValoAtrib3       Valor del Atributo3  = Observación de Lectura para actividades de lectura
    isbNombAtrib4       Nombre del Atributo4 = COMMENT3 para actividades de lectura
    isbValoAtrib4       Valor del Atributo4  = Observación de Lectura para actividades de lectura

    Salida          Descripción
    NA

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    24/11/2023      jpinedc             OSF-1938 : Creación
    *******************************************************************************/      
    PROCEDURE prAgregaActividadOrden
    (
        inuIdActOrden   NUMBER   DEFAULT NULL, 
        inuCantLega     NUMBER   DEFAULT NULL, 
        isbActApoy      VARCHAR2 DEFAULT NULL,
        isbNombAtrib1   VARCHAR2 DEFAULT NULL,
        isbValoAtrib1   VARCHAR2 DEFAULT NULL,    
        isbNombAtrib2   VARCHAR2 DEFAULT NULL,
        isbValoAtrib2   VARCHAR2 DEFAULT NULL,
        isbNombAtrib3   VARCHAR2 DEFAULT NULL,
        isbValoAtrib3   VARCHAR2 DEFAULT NULL,
        isbNombAtrib4   VARCHAR2 DEFAULT NULL,
        isbValoAtrib4   VARCHAR2 DEFAULT NULL       
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70)  := csbSP_NAME || 'prAgregaActividadOrden'; 
        
        nuIdActOrden    NUMBER := inuIdActOrden;
        nuCantLega      NUMBER := inuCantLega;
        sbCadActividad  VARCHAR2(4000);
                        
        CURSOR cuActivOrdenPend
        IS
        SELECT order_activity_id
        FROM or_order_activity oa
        WHERE oa.order_id = nuOrden
        AND oa.status = 'R';
        
        TYPE tytbActivOrdenPend IS TABLE OF cuActivOrdenPend%ROWTYPE
        INDEX BY BINARY_INTEGER;
        
        tbActivOrdenPend  tytbActivOrdenPend;
        
        CURSOR cuCantidadLega( inuCausal NUMBER) 
        IS
        SELECT  CASE  
                    WHEN cc.class_causal_id = 1 THEN
                        1
                    ELSE
                       0
                END CantidadLega
        FROM GE_CAUSAL ca,
        ge_causal_type ct,
        ge_class_causal cc
        WHERE ca.CAUSAL_ID = inuCausal
        AND ct.causal_type_id = ca.causal_type_id
        AND cc.class_causal_id = ca.class_causal_id;
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);        
               
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        IF inuIdActOrden IS NULL THEN
        
            OPEN cuActivOrdenPend;
            FETCH cuActivOrdenPend BULK COLLECT INTO tbActivOrdenPend;
            CLOSE cuActivOrdenPend;
            
            IF tbActivOrdenPend.Count = 0 then
                pkg_Error.setErrorMessage( isbMsgErrr => 'La orden no tiene actividades pendientes' );
            ELSIF tbActivOrdenPend.Count = 1 then
                nuIdActOrden := tbActivOrdenPend(1).order_activity_id;
            ELSE
                pkg_Error.setErrorMessage( isbMsgErrr => 'La orden más de 1 actividad pendiente' );
            END IF; 
                       
        END IF;
    
        IF inuCantLega IS NULL THEN
            OPEN cuCantidadLega( nuCausal);
            FETCH cuCantidadLega INTO nuCantLega;
            CLOSE cuCantidadLega;
        END IF;

        sbCadActividad := nuIdActOrden || '>' || nuCantLega ;
        
        sbCadActividad := sbCadActividad || CASE WHEN isbActApoy IS NOT NULL THEN  '>' ||isbActApoy END;
        
        sbCadActividad := sbCadActividad || ';';
        
        IF isbNombAtrib1 IS NOT NULL THEN
            sbCadActividad := sbCadActividad || isbNombAtrib1 || '>' || isbValoAtrib1 || '>>';
        END IF;

        sbCadActividad := sbCadActividad || ';';
                
        IF isbNombAtrib2 IS NOT NULL THEN        
            sbCadActividad := sbCadActividad ||isbNombAtrib2 || '>' || isbValoAtrib2 || '>>';
        END IF;

        sbCadActividad := sbCadActividad || ';';
                
        IF isbNombAtrib3 IS NOT NULL THEN
            sbCadActividad := sbCadActividad || isbNombAtrib3 || '>' || isbValoAtrib3 || '>>';        
        END IF;
        
        sbCadActividad := sbCadActividad || ';';
        
        IF isbNombAtrib4 IS NOT NULL THEN
            sbCadActividad := sbCadActividad || isbNombAtrib4 || '>' || isbValoAtrib4 || '>>';
        END IF;
        
        IF sbCadActividades IS NOT NULL THEN
            sbCadActividades := sbCadActividades || '<';
        END IF;
        
        sbCadActividades := sbCadActividades || sbCadActividad;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_error.Controlled_Error;       
    END prAgregaActividadOrden;

    /*******************************************************************************
    Método:         prAgregaItem
    Descripción:    Agrega un item a la cadena de items 

    Autor:          Lubin Pineda
    Fecha:          24/11/2023

    Entrada             Descripción
    inuItem             Item que se agrega en legalización
    inuCantLega         Cantidad a legalizar
    isbInstala          NULL = Si isbCodElemento tiene valor
                        Y = Se instala
                        N = Se retira
    isbCodElemento      Serial o código del elemento

    Salida          Descripción
    NA

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    24/11/2023      jpinedc             OSF-1938 : Creación
    *******************************************************************************/     
    PROCEDURE prAgregaItem
    (
        inuItem         NUMBER,
        inuCantLega     NUMBER,
        isbInstala      VARCHAR2,
        isbCodElemento  VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70)  := csbSP_NAME || 'prAgregaItem';         
        sbCadItem       VARCHAR2(4000);
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    
        sbCadItem := sbCadItem || inuItem        || '>';
        sbCadItem := sbCadItem || inuCantLega    || '>';
        sbCadItem := sbCadItem || CASE WHEN isbCodElemento IS NULL THEN  isbInstala || '>' END;
        sbCadItem := sbCadItem || CASE WHEN isbCodElemento IS NOT NULL THEN isbCodElemento END;
        
        IF sbCadItems IS NOT NULL THEN
            sbCadItems := sbCadItems || ';';
        END IF;
        
        sbCadItems := sbCadItems || sbCadItem;
   
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_error.Controlled_Error;  
    END prAgregaItem;

    /*******************************************************************************
    Método:         prAgregaLecturaSerial
    Descripción:    Agrega una lectura en la tabla pl de lecturas de los seriales

    Autor:          Lubin Pineda
    Fecha:          24/11/2023

    Entrada             Descripción
    isbSerial           Serial del medidor
    inuTipoConsumo      Tipo de consumo
    inuLectura          Lectura
    inuCausa            Causal de lectura
    inuObservacion1     Observación de lectura1
    inuObservacion2     Observación de lectura2
    inuObservacion3     Observación de lectura3

    Salida          Descripción
    NA

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    24/11/2023      jpinedc             OSF-1938 : Creación
    *******************************************************************************/              
    PROCEDURE prAgregaLecturaSerial
    (
        isbSerial       VARCHAR2,
        inuTipoConsumo  NUMBER,
        inuLectura      NUMBER,
        isbCausa        VARCHAR2,
        inuObservacion1 NUMBER,      
        inuObservacion2 NUMBER,
        inuObservacion3 NUMBER        
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70)  := csbSP_NAME || 'prAgregaLecturaSerial'; 
        sbCadLecturasSerial VARCHAR2(4000);
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        IF tbLecturasSerial.Exists(isbSerial)  THEN
            tbLecturasSerial(isbSerial) := tbLecturasSerial(isbSerial) || '>';
        ELSE 
            tbLecturasSerial(isbSerial) := NULL;        
        END IF;
        
        sbCadLecturasSerial := sbCadLecturasSerial || inuTipoConsumo  || '=';
        sbCadLecturasSerial := sbCadLecturasSerial || inuLectura      || '=';
        sbCadLecturasSerial := sbCadLecturasSerial || isbCausa        || '=';
        sbCadLecturasSerial := sbCadLecturasSerial || inuObservacion1 || '=';
        sbCadLecturasSerial := sbCadLecturasSerial || inuObservacion2 || '=';
        sbCadLecturasSerial := sbCadLecturasSerial || inuObservacion3 ;
        
        tbLecturasSerial(isbSerial) := tbLecturasSerial(isbSerial) || sbCadLecturasSerial;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_error.Controlled_Error;                                  
    END prAgregaLecturaSerial;

    /*******************************************************************************
    Método:         fsbCadLecturas
    Descripción:    Retorna la cadena de lecturas con los datos que se encuentren
                    en la tabla pl de lecturas de los medidores 

    Autor:          Lubin Pineda
    Fecha:          24/11/2023

    Entrada             Descripción
    NA

    Salida          Descripción
    sbCadLect       Cadena de lecturas de medidores

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    24/11/2023      jpinedc             OSF-1938 : Creación
    *******************************************************************************/       
    FUNCTION fsbCadLecturas RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbCadLecturas';    
        sbSeri      VARCHAR2(50);
        sbCadLect   VARCHAR2(4000);
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
    BEGIN
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        IF tbLecturasSerial.Count > 0 THEN
        
            sbSeri := tbLecturasSerial.First;
            
            LOOP
                EXIT WHEN sbSeri IS NULL;                
                sbCadLect := sbCadLect || sbSeri || ';' || tbLecturasSerial(sbSeri);                
                sbSeri := tbLecturasSerial.Next(sbSeri);
                IF sbSeri IS NOT NULL THEN
                    sbCadLect := sbCadLect || '<';
                END IF;
            END LOOP;

        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN sbCadLect;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_error.Controlled_Error;    
    END fsbCadLecturas;

    /*******************************************************************************
    Método:         fsbCadenaLegalizacion
    Descripción:    Retorna un registro con la cadena de legalización 

    Autor:          Lubin Pineda
    Fecha:          24/11/2023

    Entrada             Descripción
    NA

    Salida          Descripción
    sbCadLect       Cadena de lecturas de medidores

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    24/11/2023      jpinedc             OSF-1938 : Creación
    *******************************************************************************/                   
    FUNCTION fsbCadenaLegalizacion RETURN CONSTANTS_PER.TIPO_XML_SOL%TYPE
    IS
        csbMetodo           CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbCadenaLegalizacion';        
        sbcadena_legalizacion   CONSTANTS_PER.TIPO_XML_SOL%TYPE;
        nuError                 NUMBER;
        sbError                 VARCHAR2(4000);    
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
        
        IF sbCadActividades IS NULL THEN
            prAgregaActividadOrden;
        END IF;

        sbCadLecturas := fsbCadLecturas;
                
        sbcadena_legalizacion  :=  nuOrden                 || '|' || 
                                            nuCausal                || '|' || 
                                            nuPersona               || '|' ||
                                            sbCadDatosAdicionales   || '|' ||
                                            sbCadActividades        || '|' ||
                                            sbCadItems              || '|' ||
                                            sbCadLecturas           || '|' ||
                                            sbCadComentario     ;
                                    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN  sbcadena_legalizacion;
                
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);                
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);            
            RAISE pkg_error.Controlled_Error;             
    END fsbCadenaLegalizacion;
                             
END pkg_cadena_legalizacion; 
/

Prompt Otorgando permisos sobre PKG_CADENA_LEGALIZACION
BEGIN
    pkg_utilidades.prAplicarPermisos( 'PKG_CADENA_LEGALIZACION','PERSONALIZACIONES');
END;
/

