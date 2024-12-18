CREATE OR REPLACE PACKAGE adm_person.pkg_clienteestacional AS

	/******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_clienteestacional </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 09-10-2024 </Fecha>
    <Descripcion> 
        Paquete de primer nivel de clientes_estacionales
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="09-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
	
    /**************************************************************************
    <TABLA Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> tytbRegistros </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 09-10-2024 </Fecha>
    <Descripcion> 
        Tipo tabla de clientes_estacionales
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="09-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </TABLA>
    **************************************************************************/
	TYPE tytbRowIds IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    TYPE tytbRegistros IS TABLE OF clientes_estacionales%ROWTYPE INDEX BY BINARY_INTEGER;

    /**************************************************************************
    <CURSOR Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> cuRegistroRId </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 09-10-2024 </Fecha>
    <Descripcion> 
        Cursor de registros de clientes_estacionales
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 			Identificador del contrato
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="09-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </CURSOR>
    **************************************************************************/
	CURSOR cuRegistroRId
    (
        inuCONTRATO    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM clientes_estacionales tb
        WHERE
        CONTRATO = inuCONTRATO;
     
    /**************************************************************************
    <CURSOR Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> cuRegistroRIdLock </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 09-10-2024 </Fecha>
    <Descripcion> 
        Cursor de registros de clientes_estacionales
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 			Identificador del contrato
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="09-10-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </CURSOR>
    **************************************************************************/
	CURSOR cuRegistroRIdLock
    (
        inuCONTRATO    NUMBER
    )
    IS
        SELECT tb.*, tb.Rowid
        FROM clientes_estacionales tb
        WHERE
        CONTRATO = inuCONTRATO
        FOR UPDATE NOWAIT;
	
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> frcObtRegistroRId </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Retorna el record de los registros de clientes_estacionales
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			iblBloquea			default false
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION frcObtRegistroRId(inuCONTRATO    NUMBER, 
							   iblBloquea 	  BOOLEAN DEFAULT FALSE
							   ) 
	RETURN cuRegistroRId%ROWTYPE;
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fblExiste </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Retorna boolean si el contrato existe
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION fblExiste(inuCONTRATO    NUMBER) 
	RETURN BOOLEAN;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fblExiste </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Valida si el contrato existe
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prValExiste(inuCONTRATO    NUMBER);
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prinsRegistro </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Inserta el record de clientes_estacionales
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			
		Salida:
			oRowId				Retorna el RowId
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prinsRegistro(ircRegistro clientes_estacionales%ROWTYPE, 
							oRowId OUT ROWID
							);
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prBorRegistro </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Borra el registro del contrato
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prBorRegistro(inuCONTRATO    NUMBER);
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prBorRegistroxRowId </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Borra el registro por rowid
    </Descripcion>
	<parametros>
		Entrada: 
			oRowId				Retorna el RowId
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prBorRegistroxRowId(iRowId ROWID);
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuObtPRODUCTO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Obtiene el producto asociado al contrato
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION fnuObtPRODUCTO(inuCONTRATO    NUMBER) 
	RETURN clientes_estacionales.PRODUCTO%TYPE;
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtFECHA_REGISTRO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Obtiene la fecha de registro asociado al contrato
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION fdtObtFECHA_REGISTRO(inuCONTRATO    NUMBER) 
	RETURN clientes_estacionales.FECHA_REGISTRO%TYPE;
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtFECHA_INICIAL_VIGENCIA </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Obtiene la fecha inicial de vigencia asociado al contrato
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION fdtObtFECHA_INICIAL_VIGENCIA(inuCONTRATO    NUMBER) 
	RETURN clientes_estacionales.FECHA_INICIAL_VIGENCIA%TYPE;
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtFECHA_FINAL_VIGENCIA </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Obtiene la fecha final de vigencia asociado al contrato
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION fdtObtFECHA_FINAL_VIGENCIA(inuCONTRATO    NUMBER) 
	RETURN clientes_estacionales.FECHA_FINAL_VIGENCIA%TYPE;
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fsbObtACTIVO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Obtiene si el contrato esta activo
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION fsbObtACTIVO(inuCONTRATO    NUMBER) 
	RETURN clientes_estacionales.ACTIVO%TYPE;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcPRODUCTO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza el producto del contrato
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			inuPRODUCTO			Identificador del producto
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcPRODUCTO(inuCONTRATO    NUMBER,
						   inuPRODUCTO    NUMBER
						   );
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcFECHA_REGISTRO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza la fecha de registro del contrato
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			idtFECHA_REGISTRO	Fecha de registro
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcFECHA_REGISTRO(inuCONTRATO    		NUMBER,
							     idtFECHA_REGISTRO    	DATE
								 );
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcFECHA_INICIAL_VIGENCIA </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza la fecha inicial de vigencia del contrato
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 		Identificador del contrato
			idtFECHA_REGISTRO	Fecha de registro
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcFECHA_INICIAL_VIGENCIA(inuCONTRATO    			NUMBER,
										 idtFECHA_INICIAL_VIGENCIA  DATE
										 );
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcFECHA_FINAL_VIGENCIA </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza la fecha final de vigencia del contrato
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 			Identificador del contrato
			idtFECHA_FINAL_VIGENCIA	Fecha final de vigencia
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcFECHA_FINAL_VIGENCIA(inuCONTRATO    			NUMBER,
									   idtFECHA_FINAL_VIGENCIA  DATE
									   );
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcACTIVO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza el activo del contrato
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 	Identificador del contrato
			isbACTIVO		Flag activo 
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcACTIVO(inuCONTRATO    NUMBER,
						 isbACTIVO    VARCHAR2
						 );
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prActRegistro </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza con un record  el registro
    </Descripcion>
	<parametros>
		Entrada: 
			ircRegistro 	Record de clientes estacionales
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prActRegistro( ircRegistro clientes_estacionales%ROWTYPE);
 
END pkg_clienteestacional;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_clienteestacional AS

	/******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_clienteestacional </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 09-10-2024 </Fecha>
    <Descripcion> 
        Paquete de primer nivel de clientes_estacionales
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="09-1-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/
	
	--------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
	
	-----------------------------------
    -- Variables privadas del package
    -----------------------------------
	
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> frcObtRegistroRId </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Retorna el record de los registros de clientes_estacionales
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION frcObtRegistroRId(inuCONTRATO  NUMBER, 
							   iblBloquea 	BOOLEAN DEFAULT FALSE
							   ) 
	RETURN cuRegistroRId%ROWTYPE 
	IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'frcObtRegistroRId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId   cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iblBloquea THEN
            OPEN cuRegistroRIdLock(inuCONTRATO);
            FETCH cuRegistroRIdLock INTO rcRegistroRId;
            CLOSE cuRegistroRIdLock;
        ELSE
            OPEN cuRegistroRId(inuCONTRATO);
            FETCH cuRegistroRId INTO rcRegistroRId;
            CLOSE cuRegistroRId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END frcObtRegistroRId;
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fblExiste </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Retorna boolean si el contrato existe
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION fblExiste(inuCONTRATO    NUMBER) 
	RETURN BOOLEAN 
	IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroRId  cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroRId := frcObtRegistroRId(inuCONTRATO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroRId.CONTRATO IS NOT NULL;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fblExiste;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fblExiste </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Valida si el contrato existe
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prValExiste(inuCONTRATO    NUMBER) 
	IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prValExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NOT fblExiste(inuCONTRATO) THEN
            pkg_error.setErrorMessage( isbMsgErrr =>'No existe el registro ['||inuCONTRATO||'] en la tabla[clientes_estacionales]');
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prValExiste;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prInsRegistro </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Inserta el record de clientes_estacionales
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prInsRegistro(ircRegistro clientes_estacionales%ROWTYPE, 
							oRowId OUT ROWID
							) 
	IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prInsRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        INSERT INTO clientes_estacionales(
            CONTRATO,PRODUCTO,FECHA_REGISTRO,FECHA_INICIAL_VIGENCIA,FECHA_FINAL_VIGENCIA,ACTIVO
        )
        VALUES (
            ircRegistro.CONTRATO,ircRegistro.PRODUCTO,ircRegistro.FECHA_REGISTRO,ircRegistro.FECHA_INICIAL_VIGENCIA,ircRegistro.FECHA_FINAL_VIGENCIA,ircRegistro.ACTIVO
        ) RETURNING ROWID INTO oRowId;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prInsRegistro;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prBorRegistro </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Borra el registro del contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prBorRegistro(inuCONTRATO    NUMBER) 
	IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCONTRATO, TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            DELETE clientes_estacionales
            WHERE 
            ROWID = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prBorRegistro;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prBorRegistroxRowId </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Borra el registro por rowid
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prBorRegistroxRowId(iRowId ROWID) 
	IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prBorRegistroxRowId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF iRowId IS NOT NULL THEN
            DELETE clientes_estacionales
            WHERE RowId = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prBorRegistroxRowId;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuObtPRODUCTO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Obtiene el producto asociado al contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuObtPRODUCTO(inuCONTRATO    NUMBER) 
	RETURN clientes_estacionales.PRODUCTO%TYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fnuObtPRODUCTO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCONTRATO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.PRODUCTO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fnuObtPRODUCTO;
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtFECHA_REGISTRO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Obtiene la fecha de registro asociado al contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION fdtObtFECHA_REGISTRO(inuCONTRATO    NUMBER) 
	RETURN clientes_estacionales.FECHA_REGISTRO%TYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_REGISTRO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCONTRATO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_REGISTRO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_REGISTRO;
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtFECHA_INICIAL_VIGENCIA </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Obtiene la fecha inicial de vigencia asociado al contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION fdtObtFECHA_INICIAL_VIGENCIA(inuCONTRATO    NUMBER) 
	RETURN clientes_estacionales.FECHA_INICIAL_VIGENCIA%TYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_INICIAL_VIGENCIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCONTRATO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_INICIAL_VIGENCIA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_INICIAL_VIGENCIA;
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fdtObtFECHA_FINAL_VIGENCIA </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Obtiene la fecha final de vigencia asociado al contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION fdtObtFECHA_FINAL_VIGENCIA(inuCONTRATO    NUMBER) 
	RETURN clientes_estacionales.FECHA_FINAL_VIGENCIA%TYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fdtObtFECHA_FINAL_VIGENCIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCONTRATO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.FECHA_FINAL_VIGENCIA;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fdtObtFECHA_FINAL_VIGENCIA;
 
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fsbObtACTIVO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Obtiene si el contrato esta activo
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
	FUNCTION fsbObtACTIVO(inuCONTRATO    NUMBER) 
	RETURN clientes_estacionales.ACTIVO%TYPE
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'fsbObtACTIVO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCONTRATO);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN rcRegistroAct.ACTIVO;
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END fsbObtACTIVO;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcPRODUCTO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza el producto del contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcPRODUCTO(inuCONTRATO    NUMBER,
						   inuPRODUCTO    NUMBER
						   )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRODUCTO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCONTRATO,TRUE);
        IF NVL(inuPRODUCTO,-1) <> NVL(rcRegistroAct.PRODUCTO,-1) THEN
            UPDATE clientes_estacionales
            SET PRODUCTO=inuPRODUCTO
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcPRODUCTO;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcFECHA_REGISTRO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza la fecha de registro del contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcFECHA_REGISTRO(inuCONTRATO    	NUMBER,
								 idtFECHA_REGISTRO  DATE
								 )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_REGISTRO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCONTRATO,TRUE);
        IF NVL(idtFECHA_REGISTRO,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_REGISTRO,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE clientes_estacionales
            SET FECHA_REGISTRO=idtFECHA_REGISTRO
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFECHA_REGISTRO;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcFECHA_INICIAL_VIGENCIA </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza la fecha inicial de vigencia del contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcFECHA_INICIAL_VIGENCIA(inuCONTRATO    			NUMBER,	
										 idtFECHA_INICIAL_VIGENCIA  DATE
										 )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_INICIAL_VIGENCIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCONTRATO,TRUE);
        IF NVL(idtFECHA_INICIAL_VIGENCIA,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_INICIAL_VIGENCIA,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE clientes_estacionales
            SET FECHA_INICIAL_VIGENCIA=idtFECHA_INICIAL_VIGENCIA
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFECHA_INICIAL_VIGENCIA;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcFECHA_FINAL_VIGENCIA </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza la fecha final de vigencia del contrato
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 			Identificador del contrato
			idtFECHA_FINAL_VIGENCIA	Fecha final de vigencia
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcFECHA_FINAL_VIGENCIA(inuCONTRATO    			NUMBER,
									   idtFECHA_FINAL_VIGENCIA  DATE
									   )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_FINAL_VIGENCIA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCONTRATO,TRUE);
        IF NVL(idtFECHA_FINAL_VIGENCIA,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(rcRegistroAct.FECHA_FINAL_VIGENCIA,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE clientes_estacionales
            SET FECHA_FINAL_VIGENCIA=idtFECHA_FINAL_VIGENCIA
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFECHA_FINAL_VIGENCIA;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcACTIVO </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza el activo del contrato
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcACTIVO(inuCONTRATO  NUMBER,
						 isbACTIVO    VARCHAR2
						 )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcACTIVO';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(inuCONTRATO,TRUE);
        IF NVL(isbACTIVO,'-') <> NVL(rcRegistroAct.ACTIVO,'-') THEN
            UPDATE clientes_estacionales
            SET ACTIVO=isbACTIVO
            WHERE Rowid = rcRegistroAct.RowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcACTIVO;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcPRODUCTO_RId </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza el producto por rowid
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcPRODUCTO_RId(iRowId 			ROWID,
							   inuPRODUCTO_O    NUMBER,
							   inuPRODUCTO_N    NUMBER
							   )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcPRODUCTO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(inuPRODUCTO_O,-1) <> NVL(inuPRODUCTO_N,-1) THEN
            UPDATE clientes_estacionales
            SET PRODUCTO=inuPRODUCTO_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcPRODUCTO_RId;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcFECHA_REGISTRO_RId </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza la fecha de registro por rowid
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcFECHA_REGISTRO_RId(iRowId 				ROWID,
									 idtFECHA_REGISTRO_O    DATE,
									 idtFECHA_REGISTRO_N    DATE
									 )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_REGISTRO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_REGISTRO_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_REGISTRO_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE clientes_estacionales
            SET FECHA_REGISTRO=idtFECHA_REGISTRO_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFECHA_REGISTRO_RId;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcFECHA_INICIAL_VIGENCIA_RId </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza la fecha inicial de vigencia por rowid
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcFECHA_INICIAL_VIGENCIA_RId(iRowId 						ROWID,
											 idtFECHA_INICIAL_VIGENCIA_O    DATE,
											 idtFECHA_INICIAL_VIGENCIA_N    DATE
											 )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_INICIAL_VIGENCIA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_INICIAL_VIGENCIA_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_INICIAL_VIGENCIA_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE clientes_estacionales
            SET FECHA_INICIAL_VIGENCIA=idtFECHA_INICIAL_VIGENCIA_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFECHA_INICIAL_VIGENCIA_RId;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcFECHA_FINAL_VIGENCIA_RId </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza la fecha final de vigencia por rowid
    </Descripcion>
	<parametros>
		Entrada: 
			inuCONTRATO 				Identificador del contrato
			idtFECHA_FINAL_VIGENCIA		Fecha vieja final de vigencia
			idtFECHA_FINAL_VIGENCIA_N	Fecha nueva final de vigencia
			
		Salida:
	</parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcFECHA_FINAL_VIGENCIA_RId(iRowId 						ROWID,
										   idtFECHA_FINAL_VIGENCIA_O    DATE,
										   idtFECHA_FINAL_VIGENCIA_N    DATE
										   )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcFECHA_FINAL_VIGENCIA_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(idtFECHA_FINAL_VIGENCIA_O,TO_DATE('01/01/1900','dd/mm/yyyy')) <> NVL(idtFECHA_FINAL_VIGENCIA_N,TO_DATE('01/01/1900','dd/mm/yyyy')) THEN
            UPDATE clientes_estacionales
            SET FECHA_FINAL_VIGENCIA=idtFECHA_FINAL_VIGENCIA_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcFECHA_FINAL_VIGENCIA_RId;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prAcACTIVO_RId </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza el activo por rowid
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prAcACTIVO_RId(iRowId 		ROWID,
							 isbACTIVO_O    VARCHAR2,
							 isbACTIVO_N    VARCHAR2
							 )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prAcACTIVO_RId';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        IF NVL(isbACTIVO_O,'-') <> NVL(isbACTIVO_N,'-') THEN
            UPDATE clientes_estacionales
            SET ACTIVO=isbACTIVO_N
            WHERE Rowid = iRowId;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prAcACTIVO_RId;
 
    /**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prActRegistro </Unidad>
    <Autor> Jhon Eduar Erazo </Autor>
    <Fecha> 21-01-2024 </Fecha>
    <Descripcion> 
        Actualiza con un record  el registro
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="21-01-2024" Inc="OSF-3241" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
	PROCEDURE prActRegistro( ircRegistro clientes_estacionales%ROWTYPE) 
	IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME||'prActRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        rcRegistroAct cuRegistroRId%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        rcRegistroAct := frcObtRegistroRId(ircRegistro.CONTRATO,TRUE);
        IF rcRegistroAct.RowId IS NOT NULL THEN
            prAcPRODUCTO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.PRODUCTO,
                ircRegistro.PRODUCTO
            );
 
            prAcFECHA_REGISTRO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_REGISTRO,
                ircRegistro.FECHA_REGISTRO
            );
 
            prAcFECHA_INICIAL_VIGENCIA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_INICIAL_VIGENCIA,
                ircRegistro.FECHA_INICIAL_VIGENCIA
            );
 
            prAcFECHA_FINAL_VIGENCIA_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.FECHA_FINAL_VIGENCIA,
                ircRegistro.FECHA_FINAL_VIGENCIA
            );
 
            prAcACTIVO_RId(
                rcRegistroAct.RowId,
                rcRegistroAct.ACTIVO,
                ircRegistro.ACTIVO
            );
 
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => '||sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
    END prActRegistro;
 
END pkg_clienteestacional;
/
BEGIN
    -- OSF-3241
    pkg_Utilidades.prAplicarPermisos( UPPER('pkg_clienteestacional'), UPPER('adm_person'));
END;
/
