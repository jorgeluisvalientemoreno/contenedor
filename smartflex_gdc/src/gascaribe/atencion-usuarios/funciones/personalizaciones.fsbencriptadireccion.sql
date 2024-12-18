create or replace FUNCTION PERSONALIZACIONES.FSBENCRIPTADIRECCION(col_in VARCHAR2)
   RETURN VARCHAR2
IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : FSBENCRIPTADIRECCION 
    Descripcion     : Reemplaza las palabras pares de una cadena por asteriscos
    Autor           : JHON JAIRO SOTO - HORBATH 
    Fecha           : 20/09/2024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jsoto       20/09/2024  OSF-3315    Creacion
    ***************************************************************************/     

   sbCadena         VARCHAR2(4000);
   sbValor          VARCHAR2(4000);
   sbValor1         VARCHAR2(4000);
   sbValor2         VARCHAR2(4000);
   nuContador       NUMBER;
   nuCantPalabra    NUMBER;
   nuCantCadena     NUMBER;
   sbCantCadena     VARCHAR2(4000);
   sbCantCadena2    VARCHAR2(4000) := null;
   csbMetodo        VARCHAR2(30) := 'FSBENCRIPTADIRECCION';
   sbError          VARCHAR2(4000);
   nuError          NUMBER;

BEGIN

 pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   

    --Se reemplaza algunos carateres especiales
    sbCadena := TRIM(REGEXP_REPLACE(col_in,'[-#.]','X'));
    
    --Se reemplaza cuando hay mas de un espacio entre palabras
    sbCadena := REGEXP_REPLACE(sbCadena, '( ){2,}', ' ' );
   
    --Cuenta cantidad de palabras
    nuCantPalabra := (REGEXP_COUNT(sbCadena,' ',1,'i')+1);
    
    --Arma el parametro para enviar en la funcion REGEXP_SUBSTR que separa y encripta cada palabra
    FOR nuCantCadena in 1..nuCantPalabra LOOP

        sbCantCadena := '(\w+)';

        IF nuCantCadena = 1 THEN
		-- Si es la primera palabra no lleva espacio al inicio
           sbCantCadena2 := sbCantCadena;
        ELSE
           sbCantCadena2 := sbCantCadena2||' '||sbCantCadena;
        END IF;

    END LOOP;

    FOR nucontador IN 1..nuCantPalabra LOOP

		--Se va extrayendo cada palabra de la cadena.
        sbValor := REGEXP_SUBSTR (sbCadena,sbCantCadena2, 1, 1, 'i',nucontador);
		pkg_traza.trace('sbValor:' ||sbValor);

				-- como los fragmentos de la dirección pueden ser muy cortos
				-- se reemplaza la palabra completa pero se intercala los impares no y las pares si se reemplaza
                IF MOD(nucontador,2) = 0  THEN
                      sbValor1 := REGEXP_REPLACE (
                                                    SUBSTR(
                                                    sbValor,
                                                    1,
                                                    LENGTH (
                                                       SUBSTR ((sbValor), 1, LENGTH ((sbValor))))),
                                                    '[A-Za-z^0-9]',
                                                    '*'
                                                 );
												 
					pkg_traza.trace('sbValor1:' ||sbValor1);					 
                                                 
                    -- Se van concatenando las palabras con los reemplazos
					sbValor2 := sbValor2||' '||sbValor1;  
					pkg_traza.trace('sbValor2:' ||sbValor2);	
					
                ELSE
				   -- En las palabras pares no se hace reemplazo y se va concatenando
                   sbValor2 := sbValor2||' '||sbValor;
				   pkg_traza.trace('sbValor2:' ||sbValor2);
				   
                END IF;
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
END FSBENCRIPTADIRECCION;
/
Prompt Otorgando permisos sobre FSBENCRIPTADIRECCION
BEGIN
    pkg_utilidades.prAplicarPermisos( 'FSBENCRIPTADIRECCION', 'PERSONALIZACIONES');
END;
/
