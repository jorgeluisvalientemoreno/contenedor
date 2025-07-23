CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_GESTIONSECUENCIAS
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> PKG_GESTIONSECUENCIAS </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion> 
        Gestiona los procesos programados
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
           <Modificacion Autor="jose.pineda" Fecha="11-10-2024" Inc="OSF-3466" Empresa="GDC">
               Se crea 
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    -- Versión del paquete
    FUNCTION fsbVersion
    RETURN VARCHAR2;

    -- Retorna la secuencia de la entidad GE_PROCESS_SCHEDULE
    FUNCTION fnuSEQ_GE_PROCESS_SCHEDULE
	RETURN Ge_process_schedule.process_schedule_id%type;
					
	-- Retorna el siguiente valor de la secuencia fnuSEQ_SA_TAB
	FUNCTION fnuSEQ_SA_TAB
	RETURN sa_tab.tab_id%type;

	-- Retorna el siguiente valor de la secuencia seq_ldc_actcallcenter
	FUNCTION fnuSEQ_LDC_ACTCALLCENTER
	RETURN ldc_actcallcenter.actcc_id%type;
	
	--funcion que retorna valor de la secuencia SEQ_CUPON
	FUNCTION fnuSEQ_CUPON
	RETURN cupon.cuponume%type;
	
    FUNCTION fnuSEQ_GE_PROC_SCHE_DETAIL	
	RETURN ge_proc_sche_detail.proc_sche_detail_id%type;
	   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuSEQ_GE_PROC_SCHE_DETAIL
        Descripcion     : funcion que devuelve valor de la secuencia SEQ_GE_PROC_SCHE_DETAIL 

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 10-12-2024

        Parametros de Entrada
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       10-12-2024   OSF-3741    Creacion
     ***************************************************************************/

	
END PKG_GESTIONSECUENCIAS;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_GESTIONSECUENCIAS
IS

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3536';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
	
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;

    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuSEQ_GE_PROCESS_SCHEDULE </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion> 
        Retorna la secuencia de la entidad GE_PROCESS_SCHEDULE
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuSEQ_GE_PROCESS_SCHEDULE
	RETURN Ge_process_schedule.process_schedule_id%type
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fnuSEQ_GE_PROCESS_SCHEDULE';
		
		nuError				NUMBER;  
		nuScheduleProcess	Ge_process_schedule.process_schedule_id%type;
		sbError			VARCHAR2(4000);     
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		nuScheduleProcess := SEQ_GE_PROCESS_SCHEDULE.NEXTVAL;
		
		pkg_traza.trace('nuScheduleProcess: ' || nuScheduleProcess, cnuNVLTRC);
        
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuScheduleProcess;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END fnuSEQ_GE_PROCESS_SCHEDULE;
    
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuSEQ_SA_TAB </Unidad>
    <Autor> Lubin Pineda </Autor>
    <Fecha> 11-10-2024 </Fecha>
    <Descripcion> 
        Retorna el siguiente valor de la secuencia SEQ_SA_TAB
    </Descripcion>
    <Historial>
           <Modificacion Autor="Lubin.Pineda" Fecha="11-10-2024" Inc="OSF-3466" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/					
	FUNCTION fnuSEQ_SA_TAB
	RETURN sa_tab.tab_id%type
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fnuSEQ_SA_TAB';
		
		nuError				NUMBER;  
		nuTab	            sa_tab.tab_id%type;
		sbError			    VARCHAR2(4000);     
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		nuTab := SEQ_SA_TAB.NEXTVAL;
		
		pkg_traza.trace('nuTab: ' || nuTab, cnuNVLTRC);
        
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuTab;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END fnuSEQ_SA_TAB;	



    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuSEQ_LDC_ACTCALLCENTER </Unidad>
    <Autor> Jhon Soto </Autor>
    <Fecha> 18-11-2024 </Fecha>
    <Descripcion> 
        Retorna el siguiente valor de la secuencia fnuSEQ_LDC_ACTCALLCENTER
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jsoto" Fecha="18-11-2024" Inc="OSF-3604" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/					

	FUNCTION fnuSEQ_LDC_ACTCALLCENTER
	RETURN ldc_actcallcenter.actcc_id%type
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fnuSEQ_LDC_ACTCALLCENTER';
		
		nuError				NUMBER;  
		nuSeq	            LDC_ACTCALLCENTER.actcc_id%type;
		sbError			    VARCHAR2(4000);     
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		nuSeq := SEQ_LDC_ACTCALLCENTER.NEXTVAL;
		
		pkg_traza.trace('nuSeq: ' || nuSeq, cnuNVLTRC);
        
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuSeq;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END fnuSEQ_LDC_ACTCALLCENTER;	

    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuSEQ_CUPON </Unidad>
    <Autor> Jhon Soto </Autor>
    <Fecha> 03-12-2024 </Fecha>
    <Descripcion> 
        Retorna el siguiente valor de la secuencia fnuSEQ_CUPON
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jsoto" Fecha="03-12-2024" Inc="OSF-3740" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/					

	FUNCTION fnuSEQ_CUPON
	RETURN cupon.cuponume%type
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fnuSEQ_CUPON';
		
		nuError				NUMBER;  
		nuSeq	            cupon.cuponume%type;
		sbError			    VARCHAR2(4000);     
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		nuSeq := SQ_CUPON_CUPONUME.NEXTVAL;
		
		pkg_traza.trace('nuSeq: ' || nuSeq, cnuNVLTRC);
        
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuSeq;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END fnuSEQ_CUPON;	

    FUNCTION fnuSEQ_GE_PROC_SCHE_DETAIL	RETURN ge_proc_sche_detail.proc_sche_detail_id%type IS
	 /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuSEQ_GE_PROC_SCHE_DETAIL
        Descripcion     : funcion que devuelve valor de la secuencia SEQ_GE_PROC_SCHE_DETAIL 

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 10-12-2024

        Parametros de Entrada
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       10-12-2024   OSF-3741    Creacion
     ***************************************************************************/

		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fnuSEQ_GE_PROC_SCHE_DETAIL';

		nuError				NUMBER;  
		nuSeq	            ge_proc_sche_detail.proc_sche_detail_id%type;
		sbError			    VARCHAR2(4000);     

    BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);		
		nuSeq := SEQ_GE_PROC_SCHE_DETAIL.NEXTVAL;		
		pkg_traza.trace('nuSeq: ' || nuSeq, cnuNVLTRC);        
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);		
		RETURN nuSeq;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
     END fnuSEQ_GE_PROC_SCHE_DETAIL;
	    	
END PKG_GESTIONSECUENCIAS;
/

BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_GESTIONSECUENCIAS'),'ADM_PERSON'); 
END;
/
