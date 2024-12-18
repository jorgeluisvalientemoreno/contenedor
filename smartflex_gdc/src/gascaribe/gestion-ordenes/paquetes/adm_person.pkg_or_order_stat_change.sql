CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_or_order_stat_change
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_or_order_stat_change </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 17-04-2024 </Fecha>
    <Descripcion> 
        Paquete de la entidad or_order_stat_change
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="17-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 17-04-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="17-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcInsor_order_stat_change </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 17-04-2024 </Fecha>
    <Descripcion> 
        Inserta registros en la entidad or_order_stat_change
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="17-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcInsor_order_stat_change(inuactionId			IN or_order_stat_change.Action_Id%TYPE,
									     inuinitialStatusId		IN or_order_stat_change.Initial_Status_Id%TYPE,
										 inuFinalStatusId		IN or_order_stat_change.Final_Status_Id%TYPE,
										 inuorderId				IN or_order_stat_change.Order_Id%TYPE,
										 isbUserId				IN or_order_stat_change.User_Id%TYPE,
										 isbTerminal			IN or_order_stat_change.Terminal%TYPE,
										 idtExecutionDate		IN or_order_stat_change.Execution_Date%TYPE,
									     isbRangeDescription	IN or_order_stat_change.Range_Description%TYPE,
										 inuProgramingClassId	IN or_order_stat_change.Programing_Class_Id%TYPE,
										 inuInitialOperUnitId	IN or_order_stat_change.Initial_Oper_Unit_Id%TYPE,
										 inuFinalOperUnitId		IN or_order_stat_change.Final_Oper_Unit_Id%TYPE,
										 inuCommentTypeId		IN or_order_stat_change.Comment_Type_Id%TYPE,
										 inuCausalId			IN or_order_stat_change.Causal_Id%TYPE
										 );
	
END pkg_or_order_stat_change;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_or_order_stat_change
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_or_order_stat_change </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 17-04-2024 </Fecha>
    <Descripcion> 
        Paquete de la entidad or_order_stat_change
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="17-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-2556';
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
    <Fecha> 17-04-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="17-04-2024" Inc="OSF-2556" Empresa="GDC"> 
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
    <Unidad> prcInsor_order_stat_change </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 17-04-2024 </Fecha>
    <Descripcion> 
        Inserta registros en la entidad or_order_stat_change
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="17-04-2024" Inc="OSF-2556" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    PROCEDURE prcInsor_order_stat_change(inuactionId			IN or_order_stat_change.Action_Id%TYPE,
									     inuinitialStatusId		IN or_order_stat_change.Initial_Status_Id%TYPE,
										 inuFinalStatusId		IN or_order_stat_change.Final_Status_Id%TYPE,
										 inuorderId				IN or_order_stat_change.Order_Id%TYPE,
										 isbUserId				IN or_order_stat_change.User_Id%TYPE,
										 isbTerminal			IN or_order_stat_change.Terminal%TYPE,
										 idtExecutionDate		IN or_order_stat_change.Execution_Date%TYPE,
									     isbRangeDescription	IN or_order_stat_change.Range_Description%TYPE,
										 inuProgramingClassId	IN or_order_stat_change.Programing_Class_Id%TYPE,
										 inuInitialOperUnitId	IN or_order_stat_change.Initial_Oper_Unit_Id%TYPE,
										 inuFinalOperUnitId		IN or_order_stat_change.Final_Oper_Unit_Id%TYPE,
										 inuCommentTypeId		IN or_order_stat_change.Comment_Type_Id%TYPE,
										 inuCausalId			IN or_order_stat_change.Causal_Id%TYPE
										 )
    IS
	
		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prcInsor_order_stat_change';
		
		nuError						NUMBER;  
		nuSecuenciaOrderStatChange	NUMBER;
		sbmensaje					VARCHAR2(1000);    
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuactionId: ' 			|| inuactionId 			|| chr(10) ||
						'inuinitialStatusId: ' 		|| inuinitialStatusId 	|| chr(10) ||
						'inuFinalStatusId: ' 		|| inuFinalStatusId 	|| chr(10) ||
						'inuorderId: ' 				|| inuorderId 			|| chr(10) ||
						'isbUserId: ' 				|| isbUserId 			|| chr(10) ||
						'isbTerminal: ' 			|| isbTerminal 			|| chr(10) ||
						'idtExecutionDate: ' 		|| idtExecutionDate 	|| chr(10) ||
						'isbRangeDescription: ' 	|| isbRangeDescription 	|| chr(10) ||
						'inuProgramingClassId: ' 	|| inuProgramingClassId || chr(10) ||
						'inuInitialOperUnitId: ' 	|| inuInitialOperUnitId || chr(10) ||
						'inuFinalOperUnitId: ' 		|| inuFinalOperUnitId 	|| chr(10) ||
						'inuCommentTypeId: ' 		|| inuCommentTypeId 	|| chr(10) ||
						'inuCausalId: ' 			|| inuCausalId, cnuNVLTRC);
						
		-- Obtiene el siguiente valor de la entidad or_order_stat_change
		nuSecuenciaOrderStatChange := SEQ_OR_ORDER_STAT_CHANGE.NEXTVAL;			
		pkg_traza.trace('nuSecuenciaOrderStatChange: ' || nuSecuenciaOrderStatChange, cnuNVLTRC);
		
		INSERT into or_order_stat_change
				(
					Order_Stat_Change_Id,
					Action_Id,
					Initial_Status_Id,
					Final_Status_Id,
					Order_Id,
					Stat_Chg_Date,
					User_Id,
					Terminal,
					Execution_Date,
					Range_Description,
					Programing_Class_Id,
					Initial_Oper_Unit_Id,
					Final_Oper_Unit_Id,
					Comment_Type_Id,
					Causal_Id
				)
		values
				(
					nuSecuenciaOrderStatChange,
					inuactionId, 			
					inuinitialStatusId,
					inuFinalStatusId,
					inuorderId,
					SYSDATE,
					isbUserId,
					isbTerminal,
					idtExecutionDate,
					isbRangeDescription,
					inuProgramingClassId,
					inuInitialOperUnitId,
					inuFinalOperUnitId,
					inuCommentTypeId,
					inuCausalId
				);
        
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END prcInsor_order_stat_change;
END pkg_or_order_stat_change;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('pkg_or_order_stat_change'),'ADM_PERSON'); 
END;
/