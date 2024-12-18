create or replace PACKAGE   personalizaciones.ldc_bcConsGenerales IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    ldc_bcConsGenerales
    Autor       :   Lubin Pineda - MVM
    Fecha       :   03-02-2023
    Descripcion :   Paquete con las consultas generales
    Modificaciones  :
    Autor       Fecha       Caso    	Descripcion
    jpinedc     03-02-2023  OSF-858 	Creacion
    jsoto       05-10-2023  OSF-1686 	se elimina la funcioón fnuLocalidadDireccion
										se traslada la función fsbGetFormatoFecha 
										del paquete ldc_bcConsGenerales al paquete ldc_boConsGenerales
	jerazomvm	25/10/2023	OSF-1788	Se crea la función fsbconcatenar
*******************************************************************************/

    CURSOR cuSplitString( isbCadena VARCHAR2, isbExpresion VARCHAR2)
    IS
    SELECT regexp_substr(isbCadena, isbExpresion, 1, LEVEL) AS Tokens
    FROM dual
    CONNECT BY regexp_substr(isbCadena, isbExpresion, 1, LEVEL) IS NOT NULL;

   TYPE tyTblStringTable IS TABLE OF VARCHAR2(32767) INDEX BY BINARY_INTEGER;
   tblStringTable tyTblStringTable;

    -- Retona Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Retorna una tabla pl con los tokens de la cadena
    FUNCTION ftbSplitString
    (
        isbCadena       VARCHAR2,
        isbSeparador    VARCHAR2
    )
    RETURN tStringTable;

     -- Retorna una tabla pl con los tokens de la cadena
    FUNCTION ftbAllSplitString
    (
        isbCadena       VARCHAR2,
        isbSeparador    VARCHAR2
    )
    RETURN tyTblStringTable;

    -- Retorna el valor de una columna con la llave primaria de una tabla usando caché
    FUNCTION fsbValorColumna
    (
        isbTabla        VARCHAR2,
        isbColumna      VARCHAR2,
        isbColumnaPk    VARCHAR2,
        isbCodigo       VARCHAR2
    )
    RETURN VARCHAR2;

     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInicializaError
    Descripcion     : inicializa variables de error
    Autor           : Lusi Javier Lopez / horbath
    Fecha           : 26-05-2023
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion

    ***************************************************************************/
    PROCEDURE prInicializaError (onuErrorCode     OUT NUMBER,
                                  osbErrorMessage  OUT VARCHAR2);
								  
	--Retorna los parametros de entrada concatenados.
	FUNCTION fsbconcatenar(isbTexto1 		IN VARCHAR2,
						   isbTexto2 		IN VARCHAR2,
						   isbSeparador	IN VARCHAR2 DEFAULT ''
						   )
	RETURN VARCHAR2;
                                  
END ldc_bcConsGenerales;
/

create or replace PACKAGE BODY    personalizaciones.ldc_bcConsGenerales IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-1788';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    cnuNVLTRC       CONSTANT NUMBER(2)  	:= pkg_traza.fnuNivelTrzDef;
	csbPUSH         CONSTANT VARCHAR2(4)  	:= pkg_traza.fsbINICIO; 

    -- Tipo Tabla pl que se usa como caché para las descripciones
    TYPE tytbValorColumna IS TABLE OF VARCHAR2(2000) INDEX BY VARCHAR2(100);

    -- Tabla pl que se usa como caché para las descripciones
    gtbValorColumna  tytbValorColumna;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete
    Autor           : Lubin Pineda - MVM
    Fecha           : 03-02-2023
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     03-02-2023  OSF-858 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;


   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInicializaError
    Descripcion     : inicializa variables de error
    Autor           : Lusi Javier Lopez / horbath
    Fecha           : 26-05-2023
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion

    ***************************************************************************/
    PROCEDURE prInicializaError (onuErrorCode     OUT NUMBER,
                                  osbErrorMessage  OUT VARCHAR2) 
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'prInicializaError';
    BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
        onuErrorCode := 0;
        osbErrorMessage := NULL;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
    END prInicializaError;


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftbSplitString
    Descripcion     : Retorna una tabla pl con los tokens de la cadena
    Autor           : Lubin Pineda - MVM
    Fecha           : 03-02-2023
    Modificaciones  :
    Autor       Fecha       Caso    Descripción
    jpinedc     03-02-2023  OSF-858 Creación
    ***************************************************************************/
    FUNCTION ftbSplitString
    (
        isbCadena       VARCHAR2,
        isbSeparador    VARCHAR2
    )
    RETURN tStringTable
    IS
        -- Nombre de éste método
        csbMT_NAME      VARCHAR2(70) := csbSP_NAME ||'ftbSplitString';

        sbExpresion     VARCHAR2(20) := '[^' ||isbSeparador|| ']+';

        tbSplitString   tStringTable;

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('isbCadena: ' 	 || isbCadena || chr(10) ||
						'isbSeparador: ' || isbSeparador, cnuNVLTRC);

        OPEN cuSplitString( isbCadena, sbExpresion );
        FETCH cuSplitString BULK COLLECT INTO tbSplitString;
        CLOSE cuSplitString;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN tbSplitString;
   EXCEPTION
      WHEN OTHERS THEN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        RETURN tbSplitString;
    END ftbSplitString;

     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftbAllSplitString
    Descripcion     : Retorna una tabla pl con los tokens de la cadena
    Autor           : Lubin Pineda - MVM
    Fecha           : 03-02-2023
    Modificaciones  :
    Autor       Fecha       Caso    Descripción
    jpinedc     03-02-2023  OSF-858 Creación
    ***************************************************************************/
    FUNCTION ftbAllSplitString
    (
        isbCadena       VARCHAR2,
        isbSeparador    VARCHAR2
    )
    RETURN tyTblStringTable
    IS
        -- Nombre de éste método
        csbMT_NAME      VARCHAR2(70) := csbSP_NAME ||'ftbAllSplitString';

        sbExpresion     VARCHAR2(20) := '[^' ||isbSeparador|| ']+';
        nuUltPosicion   PLS_INTEGER;
        nuPosicion      PLS_INTEGER := 0;
        nuControl       PLS_INTEGER := 1;
        chDelimitador VARCHAR2(1):= SUBSTR(isbSeparador, 1);

        tbSplitString   tyTblStringTable ;

    BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('isbCadena: ' 	 || isbCadena || chr(10) ||
						'isbSeparador: ' || isbSeparador, cnuNVLTRC);
		
		IF NVL(LENGTH(chDelimitador), 0) = 0 OR NVL(LENGTH(isbSeparador), 0) = 0 OR isbCadena IS NULL THEN
			RETURN tbSplitString;
		END IF;

		LOOP
			nuUltPosicion := nuPosicion + 1;
			nuPosicion  := INSTR (isbCadena, chDelimitador, nuUltPosicion);

			IF nuUltPosicion > 0 AND nuPosicion = 0 THEN
				tbSplitString (nuControl) := SUBSTR (isbCadena, nuUltPosicion, LENGTH(isbCadena));
			END IF;

			EXIT WHEN nuPosicion = 0;
	        tbSplitString (nuControl) := SUBSTR (isbCadena, nuUltPosicion, nuPosicion - nuUltPosicion);
			IF nuPosicion = LENGTH (isbCadena) THEN
				tbSplitString (nuControl + 1) := NULL;
			END IF;

			nuControl := nuControl + 1;
		END LOOP;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN tbSplitString;

    EXCEPTION
      WHEN OTHERS THEN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
        RETURN tbSplitString;
    END ftbAllSplitString;

    PROCEDURE pCargatbValorColumna( isbColumna VARCHAR2, isbTabla VARCHAR2, isbColumnaPk VARCHAR2,isbCodigo VARCHAR2, sbIndice VARCHAR2 )
    IS
        sbValorColumna   VARCHAR2(2000);

        -- Nombre de éste método
        csbMT_NAME      VARCHAR2(70) := csbSP_NAME || 'pCargatbValorColumna';

        sbSentencia     VARCHAR2(500) := 'SELECT ';

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('isbColumna: ' 	 	|| isbColumna	|| chr(10) ||
						'isbTabla: ' 		|| isbTabla		|| chr(10) ||
						'isbColumnaPk: '	|| isbColumnaPk	|| chr(10) ||
						'isbCodigo: ' 		|| isbCodigo 	|| chr(10) ||
						'sbIndice: ' 		|| sbIndice, cnuNVLTRC);

        IF NOT gtbValorColumna.Exists( sbIndice ) THEN

            sbSentencia := sbSentencia || isbColumna || ' ';
            sbSentencia := sbSentencia || 'FROM' || ' ' || isbTabla || ' ';
            sbSentencia := sbSentencia || 'WHERE' || ' ' || isbColumnaPk || '=';
            sbSentencia := sbSentencia ||  ' ' || '''' || isbCodigo || '''';

            BEGIN
                EXECUTE IMMEDIATE sbSentencia INTO sbValorColumna;

                gtbValorColumna( sbIndice ) := sbValorColumna;

                EXCEPTION
                    WHEN OTHERS THEN
						pkg_traza.trace('Error Ejecutando|' || sbSentencia, cnuNVLTRC);
            END;

        END IF;

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            NULL;
    END pCargatbValorColumna;

    -- Retorna la descripción con la llave primaria de una tabla
    FUNCTION fsbValorColumna
    (
        isbTabla        VARCHAR2,
        isbColumna      VARCHAR2,
        isbColumnaPk    VARCHAR2,
        isbCodigo       VARCHAR2
    )
    RETURN VARCHAR2
    IS
        -- Nombre de éste método
        csbMT_NAME      VARCHAR2(70) := csbSP_NAME || 'fsbValorColumna';

        sbValorColumna   VARCHAR2(2000);

        sbIndice        VARCHAR2(100);

    BEGIN

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('isbTabla: ' 	 	|| isbTabla		|| chr(10) ||
						'isbColumna: ' 		|| isbColumna	|| chr(10) ||
						'isbColumnaPk: '	|| isbColumnaPk	|| chr(10) ||
						'isbCodigo: ' 		|| isbCodigo, cnuNVLTRC);

        sbIndice := UPPER(isbTabla || '|' || isbColumna || '|' || isbCodigo );

        pCargatbValorColumna( isbColumna, isbTabla, isbColumnaPk, isbCodigo, sbIndice );

        IF gtbValorColumna.Exists( sbIndice ) THEN
            sbValorColumna := gtbValorColumna( sbIndice );
        END IF;

        pkg_traza.trace('sbValorColumna: ' || sbValorColumna, cnuNVLTRC);

        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN sbValorColumna;

    END fsbValorColumna;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbconcatenar 
    Descripcion     : Retorna los parametros de entrada concatenados.
	
    Autor           : Jhon Erazo - MVM 
    Fecha           : 25-10-2023 
	
	Parametros entrada:
		isbTexto1		Texto 1
		isbTexto2		Texto 2
		isbSeparador	Separador
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm   25-07-2023  OSF-1788    Creacion
    ***************************************************************************/
	FUNCTION fsbconcatenar(isbTexto1 	IN VARCHAR2,
						   isbTexto2 	IN VARCHAR2,
						   isbSeparador	IN VARCHAR2 DEFAULT ''
						   )
	RETURN VARCHAR2
	IS
		csbMT_NAME      VARCHAR2(70) := csbSP_NAME || 'fsbconcatenar';
		sbConcatenar	VARCHAR2(2000);
	BEGIN
	
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbPUSH);
		
		pkg_traza.trace('isbTexto1: ' 	 	|| isbTexto1	|| chr(10) ||
						'isbTexto2: ' 		|| isbTexto2	|| chr(10) ||
						'isbSeparador: '	|| isbSeparador, cnuNVLTRC);
		
		sbConcatenar := isbTexto1||isbSeparador||isbTexto2;
		
		pkg_traza.trace('sbConcatenar: ' || sbConcatenar, cnuNVLTRC);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN sbConcatenar;
		
	END fsbconcatenar;

END ldc_bcConsGenerales;
/
begin
  pkg_utilidades.prAplicarPermisos('LDC_BCCONSGENERALES', 'PERSONALIZACIONES');
end;
/