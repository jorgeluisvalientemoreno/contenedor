CREATE OR REPLACE FUNCTION adm_person.fsbgetmtstuberiahijas 
(
    inuorden IN NUMBER,
    isbparam IN VARCHAR2
) 
RETURN NUMBER IS
  /**************************************************************************
    Autor       : Cesar Figueroa
    Fecha       : 30-12-2019
    Descripcion : Obtiene la cantidad de metros de tuberia legalizadas para las ordenes hijas de la orden ingresada

    Parametros Entrada
    inuorden: orden padre
    isbparam: Nombre del atributo que contiene los metros de tuberia legalizados en las ordenes hijas

    Valor de salida

   HISTORIA DE MODIFICACIONES
   
   Fecha               Autor                Modificacion
   =========           =========          ====================
   11/03/2024 		   Carlos Gonzalez	  OSF-2463: Eliminar llamado a REPLACE(sbvalor,'.',',')
   23/02/2024          Paola Acosta       OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON. 
                                                    Se clasifican los par�metros de la funci�n en IN
                                                    y se antepone una "i" para indicar su tipo.
                                                    Se agrega funci�n oracle REPLACE para controlar error
                                                    conversi�n number cuando el double tiene "." en vez de ","
  ***************************************************************************/

    query_str VARCHAR2(2000);
    nucuenta  NUMBER := 1;
    sbvalor   VARCHAR2(100);
    nuflag    NUMBER;
    
    csbMT_NAME  VARCHAR2(100) := $$PLSQL_UNIT;
	sbError     VARCHAR2(4000);
    nuError     NUMBER;
BEGIN
    
	LOOP
        EXIT WHEN nucuenta > 20;
        query_str := 'SELECT Count(1)' ||
                         ' FROM OR_REQU_DATA_VALUE
                           WHERE ORDER_ID = ' || inuOrden || '
                             AND NAME_'||nuCuenta||' = '''||isbParam||''' ';

        EXECUTE IMMEDIATE query_str INTO nuflag;
        
        IF nuflag > 0 THEN
        
            query_str := 'SELECT VALUE_' || nuCuenta ||
                         ' FROM OR_REQU_DATA_VALUE
                           WHERE ORDER_ID = ' || inuOrden || '
                             AND NAME_'||nuCuenta||' = '''||isbParam||''' ';

            EXECUTE IMMEDIATE query_str INTO sbvalor;
			
			pkg_traza.trace('Valor: ' || sbvalor, pkg_traza.cnuNivelTrzDef);

            EXIT;
        END IF;

        nucuenta := nucuenta + 1;
    END LOOP;
    
    IF sbvalor IS NULL THEN
        sbvalor := '0';
    END IF;
    
	RETURN to_number(sbvalor);
    
EXCEPTION
    WHEN pkg_error.controlled_error THEN
		pkg_error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;        
END fsbgetmtstuberiahijas;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBGETMTSTUBERIAHIJAS', 'ADM_PERSON');
END;
/