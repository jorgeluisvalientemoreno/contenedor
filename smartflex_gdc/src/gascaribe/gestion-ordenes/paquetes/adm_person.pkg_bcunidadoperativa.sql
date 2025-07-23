CREATE OR REPLACE PACKAGE adm_person.pkg_bcunidadoperativa IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcordenes
    Autor       :   Jhon Soto - Horbath
    Fecha       :   23-10-2023
    Descripcion :   Paquete con los metodos para manejo de información sobre las 
					unidades operativas
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
*******************************************************************************/

  CURSOR cuRecord( inuUnidadOpera IN or_operating_unit.operating_unit_id%TYPE ) IS
	SELECT or_operating_unit.*,or_operating_unit.rowid
	FROM or_operating_unit
	WHERE operating_unit_id= inuUnidadOpera ;

SUBTYPE styUnidadOperativa  IS cuRecord%ROWTYPE;
	   
TYPE tytbUnidadOperativa IS TABLE OF styUnidadOperativa   INDEX BY BINARY_INTEGER;


-- Retorna verdadero si la Unidad Operativa existe
FUNCTION fblExiste
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN BOOLEAN;
  

FUNCTION fsbgetNombre
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.name%TYPE;


FUNCTION fsbgetTipoAsignacion
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.assign_type%TYPE;


FUNCTION fsbgetDireccion
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.address%TYPE;


 FUNCTION fsbGetCorreo
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.e_mail%TYPE;
  

 FUNCTION fnuGetEstadoUniOper
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.oper_unit_status_id%TYPE;


 FUNCTION fnuGetSectorOperativo
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.operating_sector_id%TYPE;


 FUNCTION fnuGetPersonaACargo
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.person_in_charge%TYPE;


 FUNCTION fnuGetClasificacion
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.oper_unit_classif_id%TYPE;


 FUNCTION fnuGetAreaOrganizacional
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.orga_area_id%TYPE;


FUNCTION fsbGetEsExterna
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.Es_Externa%TYPE;


FUNCTION fnuGetContratista
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.Contractor_id%TYPE;


FUNCTION fnuGetBaseAdministrativa
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.admin_base_id%TYPE;


FUNCTION fnuGetValorAiuUtilidad
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.aiu_value_util%TYPE;



FUNCTION fnuGetCapacidadAsignacion
(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.assign_capacity%TYPE;


FUNCTION fnuGetCapacidadUsada
(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.Used_Assign_cap%TYPE;


FUNCTION fnuGetZonaOperativa
(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.Operating_zone_id%TYPE;


FUNCTION frcgetRecord 
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
  RETURN styUnidadOperativa;


FUNCTION frfgetUnidadOperativa 
(
  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN constants_per.TYREFCURSOR;


FUNCTION fsbObtTelefono
(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
)
  RETURN or_operating_unit.phone_number%TYPE;

END PKG_BCUNIDADOPERATIVA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcunidadoperativa IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-1776';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= 'pkg_bcunidadoperativa.';
    cnuNVLTRC 	CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;


FUNCTION fblExiste
(
   inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
) 
   RETURN BOOLEAN IS

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblExiste 
    Descripcion     : Consulta la existencia de la Unidad Operativa con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	Retorna True si la Unidad Operativa existe
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/
	
    
   csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fblExiste';

   nuExiste NUMBER;   
   onuCodError NUMBER;
   osbMensError VARCHAR2(2000);

   
   CURSOR cuUnidadOperativa IS
   SELECT COUNT(*)
   FROM or_operating_unit
   WHERE operating_unit_id = inuUnidadOperativa;
   
   BEGIN
       pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);

       IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO nuExiste;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('nuExiste: ' || nuExiste, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   IF nuExiste >0 THEN
		  RETURN TRUE;
	   END IF;   

	   RETURN FALSE;   
           
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN FALSE;
    END fblExiste;

    FUNCTION fsbgetNombre
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.name%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbgetNombre 
    Descripcion     : Consulta el nombre de la unidad con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla or_operating_unit
	
	Parametros de salida
	osbNombre       Nombre de la unidad
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1740 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbgetNombre';
	
   osbNombre or_operating_unit.name%TYPE;
   onuCodError  NUMBER;
   osbMensError VARCHAR2(2000);
	
    CURSOR cuUnidadOperativa IS
    SELECT name
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO osbNombre;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('osbNombre: ' || osbNombre, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN osbNombre;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN osbNombre;
	END fsbgetNombre;

	FUNCTION fsbgetTipoAsignacion
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.assign_type%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbgetTipoAsignacion 
    Descripcion     : Consulta el tipo de asignacion de la unidad con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	osbTipoAsignacion       Tipo de asignacion de la unidad
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbgetTipoAsignacion';
	
   osbTipoAsignacion 	or_operating_unit.assign_type%TYPE;
   osbMensError 		VARCHAR2(2000);
   onuCodError          NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT assign_type
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO osbTipoAsignacion;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('osbTipoAsignacion: ' || osbTipoAsignacion, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN osbTipoAsignacion;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN osbTipoAsignacion;
	END fsbgetTipoAsignacion;


	FUNCTION fsbgetDireccion
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.address%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbgetDireccion 
    Descripcion     : Consulta la direccion de la unidad con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	osbDireccion       Direccion de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbgetDireccion';
	
   osbDireccion 	or_operating_unit.address%TYPE;
   osbMensError 	VARCHAR2(2000);
   onuCodError      NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT address
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO osbDireccion;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('osbDireccion: ' || osbDireccion, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN osbDireccion;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN osbDireccion;
	END fsbgetDireccion;


	 FUNCTION fsbGetCorreo
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.e_mail%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetCorreo 
    Descripcion     : Consulta el correo de la unidad con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	osbCorreo       Correo de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbGetCorreo';
	
    osbCorreo 			or_operating_unit.e_mail%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT e_mail
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO osbCorreo;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('osbCorreo: ' || osbCorreo, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN osbCorreo;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN osbCorreo;
	END fsbgetCorreo;


	 FUNCTION fnuGetEstadoUniOper
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.oper_unit_status_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetEstadoUniOper 
    Descripcion     : Consulta el estado de la unidad con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	onuEstadoUniOper       Estado de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetEstadoUniOper';
	
    onuEstadoUniOper 	or_operating_unit.oper_unit_status_id%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT oper_unit_status_id
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO onuEstadoUniOper;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('onuEstadoUniOper: ' || onuEstadoUniOper, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuEstadoUniOper;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuEstadoUniOper;
	END fnuGetEstadoUniOper;


	 FUNCTION fnuGetSectorOperativo
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.operating_sector_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetSectorOperativo 
    Descripcion     : Consulta el sector operativo de la unidad con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	OnuSectorOperativo       Sector Operativo de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetSectorOperativo';
	
    OnuSectorOperativo 	or_operating_unit.operating_sector_id%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT operating_sector_id
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO OnuSectorOperativo;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('OnuSectorOperativo: ' || OnuSectorOperativo, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN OnuSectorOperativo;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN OnuSectorOperativo;
	END fnuGetSectorOperativo;


	 FUNCTION fnuGetPersonaACargo
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.person_in_charge%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetPersonaACargo 
    Descripcion     : Consulta la persona a cargo de la unidad con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	onuPersonaACargo    persona a cargo de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetPersonaACargo';
	
    onuPersonaACargo 	or_operating_unit.person_in_charge%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT person_in_charge
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO onuPersonaACargo;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('onuPersonaACargo: ' || onuPersonaACargo, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuPersonaACargo;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuPersonaACargo;
	END fnuGetPersonaACargo;


	 FUNCTION fnuGetClasificacion
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.oper_unit_classif_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetClasificacion 
    Descripcion     : Consulta la clasificacion de la unidad con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	onuClasificacion    Clasificacion de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetClasificacion';
	
    onuClasificacion 	or_operating_unit.oper_unit_classif_id%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT oper_unit_classif_id
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO onuClasificacion;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('onuClasificacion: ' || onuClasificacion, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuClasificacion;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuClasificacion;
	END fnuGetClasificacion;


	 FUNCTION fnuGetAreaOrganizacional
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.orga_area_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetAreaOrganizacional 
    Descripcion     : Consulta area organizacional de la unidad con el identificador ingresado
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	onuAreaOrganizacional    Area organizacional de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetAreaOrganizacional';
	
    onuAreaOrganizacional 	or_operating_unit.orga_area_id%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT orga_area_id
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO onuAreaOrganizacional;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('onuAreaOrganizacional: ' || onuAreaOrganizacional, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuAreaOrganizacional;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuAreaOrganizacional;
	END fnuGetAreaOrganizacional;


	FUNCTION fsbGetEsExterna
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.Es_Externa%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbGetEsExterna 
    Descripcion     : Consulta  la unidad operativa es externa
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	osbEsExterna    Es externa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbGetEsExterna';
	
    osbEsExterna 	or_operating_unit.Es_Externa%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT Es_Externa
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO osbEsExterna;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('osbEsExterna: ' || osbEsExterna, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN osbEsExterna;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN osbEsExterna;
	END fsbGetEsExterna;


	FUNCTION fnuGetContratista
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.Contractor_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetContratista 
    Descripcion     : Consulta el contratista de la unidad operativa 
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	onuContratista    Contratista de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetContratista';
	
    onuContratista 		or_operating_unit.Contractor_id%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT Contractor_id
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO onuContratista;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('onuContratista: ' || onuContratista, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuContratista;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuContratista;
	END fnuGetContratista;


	FUNCTION fnuGetBaseAdministrativa
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.admin_base_id%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetBaseAdministrativa 
    Descripcion     : Consulta la base administrativa de la unidad operativa 
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	onuBaseAdmin    base administrativa de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetBaseAdministrativa';
	
    onuBaseAdmin 		or_operating_unit.admin_base_id%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT admin_base_id
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO onuBaseAdmin;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('onuBaseAdmin: ' || onuBaseAdmin, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	   RETURN onuBaseAdmin;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuBaseAdmin;
	END fnuGetBaseAdministrativa;


	FUNCTION fnuGetValorAiuUtilidad
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.aiu_value_util%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetValorAiuUtilidad 
    Descripcion     : Consulta el valor AIU Utilidad para la unidad operativa 
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	onuValorUtilidad    Valor de Utilidad AIU para la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetValorAiuUtilidad';
	
    onuValorUtilidad 	or_operating_unit.admin_base_id%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT admin_base_id
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO onuValorUtilidad;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('onuValorUtilidad: ' || onuValorUtilidad, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuValorUtilidad;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuValorUtilidad;
	END fnuGetValorAiuUtilidad;


	FUNCTION fnuGetCapacidadAsignacion
	(
	  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.assign_capacity%TYPE
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetCapacidadAsignacion 
    Descripcion     : Consulta la capacidad de asignacion para la unidad operativa 
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	onuCapacidadAsign    Capacidad de asignacion de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetCapacidadAsignacion';
	
    onuCapacidadAsign 	or_operating_unit.assign_capacity%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT assign_capacity
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO onuCapacidadAsign;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('onuCapacidadAsign: ' || onuCapacidadAsign, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuCapacidadAsign;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuCapacidadAsign;
	END fnuGetCapacidadAsignacion;


	FUNCTION fnuGetCapacidadUsada
	(
		  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.used_assign_cap%TYPE
	
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetCapacidadUsada 
    Descripcion     : Consulta la capacidad de asignacion usada para la unidad operativa 
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	onuCapacidadUsada    Capacidad de asignacion usada de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetCapacidadUsada';
	
    onuCapacidadUsada 	or_operating_unit.used_assign_cap%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT used_assign_cap
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO onuCapacidadUsada;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('onuCapacidadUsada: ' || onuCapacidadUsada, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuCapacidadUsada;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuCapacidadUsada;
	END fnuGetCapacidadUsada;


	FUNCTION fnuGetZonaOperativa
	(
		  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.Operating_zone_id%TYPE
	
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuGetZonaOperativa 
    Descripcion     : Consulta la operativa para la unidad operativa 
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	onuZonaOperativa    Zona Operativa de la unidad operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuGetZonaOperativa';
	
    onuZonaOperativa 	or_operating_unit.Operating_zone_id%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT Operating_zone_id
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO onuZonaOperativa;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('onuZonaOperativa: ' || onuZonaOperativa, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN onuZonaOperativa;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN onuZonaOperativa;
	END fnuGetZonaOperativa;


    FUNCTION frcgetRecord 
	(
		  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN styUnidadOperativa
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcgetRecord 
    Descripcion     : retorna el registro de la unidad operativa
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la unidad operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida
	styUnidadOperativa   Registro de la Unidad Operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1776 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.frcgetRecord';
	
	rcDatos 		cuRecord%ROWTYPE;
	cuRegNulo 		cuRecord%ROWTYPE;
    onuCodError 	NUMBER;
    osbMensError 	VARCHAR2(2000);
	
    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuRecord%ISOPEN THEN 
	      CLOSE cuRecord;
	   END IF;
		
	   OPEN cuRecord(inuUnidadOperativa);
	   FETCH cuRecord INTO rcDatos;
	   
	    IF cuRecord%NOTFOUND THEN
			CLOSE cuRecord;
			rcDatos := cuRegNulo;
		END IF;
	   CLOSE cuRecord;

       pkg_traza.trace('rcDatos.operating_unit_id: ' || rcDatos.operating_unit_id, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN (rcDatos);
	   
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        pkg_error.setError;
        pkg_traza.trace('Registro no Existe: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERC); 
        raise pkg_error.controlled_error;
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Registro no Existe: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
	END;



    FUNCTION frfgetUnidadOperativa 
	(
		  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN constants_per.TYREFCURSOR
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frfgetUnidadOperativa 
    Descripcion     : retorna el cursor referenciado con información de la unidad operativa
    Autor           : Jhon Soto - Horbath
    Fecha           : 23-10-2023
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad operativa a consultar en la tabla MO_PACKAGES
	
	Parametros de salida
	styUnidadOperativa   Registro de la Unidad Operativa
	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       23-10-2023  OSF-1773 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.frfgetUnidadOperativa';
	
	orfUnidadOperativa 	constants_per.TYREFCURSOR;
    onuCodError 		NUMBER;
    osbMensError 		VARCHAR2(2000);
	
	
    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);

        IF inuUnidadOperativa IS NOT NULL THEN
    		OPEN orfUnidadOperativa FOR
        	SELECT *
			FROM
				(SELECT
				OPER_UNIT_CODE,
				NAME,
				ASSIGN_TYPE,
				ADDRESS,
				PHONE_NUMBER,
				E_MAIL,
				ASSIG_ORDERS_AMOUNT,
				FATHER_OPER_UNIT_ID,
				OPER_UNIT_STATUS_ID,
				OPERATING_SECTOR_ID,
				PERSON_IN_CHARGE,
				OPER_UNIT_CLASSIF_ID,
				ORGA_AREA_ID,
				AIU_VALUE_ADMIN,
				AIU_VALUE_UTIL,
				AIU_VALUE_UNEXPECTED,
				ES_EXTERNA,
				ES_INSPECCIONABLE,
				CONTRACTOR_ID,
				ADMIN_BASE_ID,
				UNIT_TYPE_ID,
				ADD_VALUE_ORDER,
				COMPANY_ID,
				OPERATING_ZONE_ID,
				ASSIGN_CAPACITY,
				USED_ASSIGN_CAP,
				VALID_FOR_ASSIGN,
				SUBSCRIBER_ID
				FROM or_operating_unit o
				WHERE operating_unit_id = inuUnidadOperativa);
        END IF;
        
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN (orfUnidadOperativa);
	   CLOSE orfUnidadOperativa;
	   
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        pkg_error.setError;
		pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Registro no Existe: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERC); 
        RETURN NULL;
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace(onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
		RETURN NULL;
	END;

	FUNCTION fsbObtTelefono
	(
		  inuUnidadOperativa or_operating_unit.operating_unit_id%TYPE
	)
	  RETURN or_operating_unit.phone_number%TYPE
	
	IS
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtTelefono 
    Descripcion     : Consulta el numero telefonico para la unidad operativa 
    Autor           : Jhon Soto - Horbath
    Fecha           : 31/01/2025
	
	Parametros de entrada
	inuUnidadOperativa	Id de la Unidad Operativa a consultar en la tabla OR_OPERATING_UNIT
	
	Parametros de salida

	
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       31/01/2025  OSF-3911 Creacion
    ***************************************************************************/

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbObtTelefono';
	
    nuPhoneNumber 		or_operating_unit.phone_number%TYPE;
    osbMensError 		VARCHAR2(2000);
    onuCodError         NUMBER;
	
    CURSOR cuUnidadOperativa IS
    SELECT phone_number
    FROM or_operating_unit
    WHERE operating_unit_id = inuUnidadOperativa;


    BEGIN
	
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   pkg_traza.trace('inuUnidadOperativa: ' || inuUnidadOperativa, cnuNVLTRC);
	   
	   IF cuUnidadOperativa%ISOPEN THEN 
	      CLOSE cuUnidadOperativa;
	   END IF;
		
	   OPEN cuUnidadOperativa;
	   FETCH cuUnidadOperativa INTO nuPhoneNumber;
	   CLOSE cuUnidadOperativa;

       pkg_traza.trace('nuPhoneNumber: ' || nuPhoneNumber, cnuNVLTRC);
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

	   RETURN nuPhoneNumber;
	   
    EXCEPTION
        WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.getError(onuCodError,osbMensError);
        pkg_traza.trace('Termina con error: '||onuCodError||':'||osbMensError || csbMT_NAME, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC,pkg_traza.csbFIN_ERR); 
        RETURN nuPhoneNumber;
	END fsbObtTelefono;
	
END pkg_bcunidadoperativa;
/
PROMPT Otorgando permisos de ejecución para adm_person.pkg_bcunidadoperativa
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCUNIDADOPERATIVA', 'ADM_PERSON');
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre el paquete PKG_BCUNIDADOPERATIVA
GRANT EXECUTE ON ADM_PERSON.PKG_BCUNIDADOPERATIVA TO REXEREPORTES;
/