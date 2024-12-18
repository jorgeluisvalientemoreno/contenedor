create or replace FUNCTION PERSONALIZACIONES.FSBENCRIPTACADENA(col_in VARCHAR2)
   RETURN VARCHAR2
IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : FSBENCRIPTACADENA 
    Descripcion     : Reemplaza a partir del tercer caracter de cada palabra de la cadena por asteriscos
    Autor           : JHON JAIRO SOTO - HORBATH 
    Fecha           : 20/09/2024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jsoto       20/09/2024  OSF-3315    Creacion
    ***************************************************************************/     
   sbCadena			VARCHAR2(4000);
   sbValor          VARCHAR2(4000);
   sbValor1         VARCHAR2(4000);
   sbValor2         VARCHAR2(4000);
   nuContador       NUMBER;
   nuCantPalabra    NUMBER;
   nuCantCadena     NUMBER;
   sbCantCadena     VARCHAR2(4000);
   sbCantCadena2    VARCHAR2(4000) := null;
   csbMetodo        VARCHAR2(30) := 'FSBENCRIPTACADENA';
   sbError          VARCHAR2(4000);
   nuError          NUMBER;

BEGIN

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   
	
	    --Se reemplaza algunos carateres especiales y espacios al inicio y al final
    sbCadena := TRIM(REGEXP_REPLACE(col_in,'[-#.]','X'));
    
    --Se reemplaza cuando hay mas de un espacio entre palabras
    sbCadena := REGEXP_REPLACE(sbCadena, '( ){2,}', ' ' );

    --Cuenta cantidad de espacio para determinar la cantidad de palabras
    nuCantPalabra := (REGEXP_COUNT(sbCadena,' ',1,'i')+1);
    

    --Arma el parametro para enviar en la funcion REGEXP_SUBSTR que separa y encripta cada palabra

    FOR nuCantCadena in 1..nuCantPalabra LOOP
        
        sbCantCadena := '(\w+)';
        
        IF nuCantCadena = 1 THEN
			--si es la primera palabra no tiene espacio al inicio
           sbCantCadena2 := sbCantCadena;
        ELSE
           sbCantCadena2 := sbCantCadena2||' '||sbCantCadena;
        END IF;
        
    END LOOP;

	    pkg_traza.trace('sbCantCadena2 :' ||sbCantCadena2);

    
    FOR nucontador IN 1..nuCantPalabra LOOP

		--Obtiene cada palabra 
        sbValor := REGEXP_SUBSTR (sbCadena,sbCantCadena2, 1, 1, 'i',nucontador);
		
		pkg_traza.trace('sbValor :' ||sbValor);
        
			  --Obtiene los dos primeros caracteres de cada palabra y los concatena con los demás que se han reemplazado por asteriscos
			  
              sbValor1 :=  SUBSTR ((sbValor), 1, 2)
                           || REGEXP_REPLACE (
                                             SUBSTR (
                                                    sbValor,
                                                    3,
                                                    LENGTH (
                                                    SUBSTR ((sbValor), 3, LENGTH ((sbValor))))
                                                    ),'[A-Za-z^0-9]', '*'
                                             );
											 
			  pkg_traza.trace('sbValor1 :' ||sbValor1);
              
			  -- Va concatenando las palabras de la cadena ya con los reemplazos
              sbValor2 := sbValor2||' '||sbValor1;

			  pkg_traza.trace('sbValor2 :' ||sbValor2);


        END LOOP;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    RETURN(sbValor2);

EXCEPTION
    WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN sbValor2;
END FSBENCRIPTACADENA;
/
Prompt Otorgando permisos sobre FSBENCRIPTACADENA
BEGIN
    pkg_utilidades.prAplicarPermisos( 'FSBENCRIPTACADENA', 'PERSONALIZACIONES');
END;
/

