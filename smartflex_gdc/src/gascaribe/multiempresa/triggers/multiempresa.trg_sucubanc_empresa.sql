create or replace TRIGGER multiempresa.trg_sucubanc_empresa
  FOR INSERT or UPDATE  ON SUCUBANC COMPOUND TRIGGER
 /**************************************************************************
    Autor       : JHON JAIRO SOTO
    Fecha       : 2025-04-07
    Ticket      : OSF-4134
    Descripcion : trigger que valida el departamento de la direccion para definir la empresa de la sucursal
    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION

  ***************************************************************************/

   nuCodDepartamento    NUMBER;
   nuCodDireccion       NUMBER;
   regSucBancaria       pkg_sucursal_bancaria.cuSUCURSAL_BANCARIA%ROWTYPE;
   sbCodEmpresaActual   VARCHAR2(10);
   sbCodEmpresa         VARCHAR2(10);
   nuCodBanco           NUMBER;
   sbCodSucursal        NUMBER;
   
   
     -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   nuError        NUMBER;
   sbError        VARCHAR2(4000);

-- Ejecucion antes de cada fila, variables :NEW, :OLD son permitidas
  BEFORE EACH ROW IS
    csbMT_NAME  VARCHAR2(100) := csbSP_NAME || '.BEFORE EACH ROW';

  BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        nuCodDireccion  := :new.subaadid;
        nuCodBanco      := :new.subabanc;
        sbCodSucursal   := :new.subacodi;
        
        IF nuCodDireccion IS NULL THEN
           pkg_error.seterrormessage(isbMsgErrr=> 'La dirección de la sucursal no puede ser NULO ');
        END IF;
        
        nuCodDepartamento := pkg_bcdirecciones.fnuGetDepartamento(nuCodDireccion);

        sbCodEmpresa := pkg_empresa.fsbObtEmpresaDepartamento(nuCodDepartamento);

        pkg_traza.trace(' nuCodDireccion => ' || nuCodDireccion, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' nuCodDepartamento => ' || nuCodDepartamento, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' sbCodEmpresa => ' || sbCodEmpresa, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' sbCodEmpresaActual => ' || sbCodEmpresaActual, pkg_traza.cnuNivelTrzDef);


        IF inserting THEN
            regSucBancaria.banco		:= nuCodBanco;
            regSucBancaria.sucursal	        := sbCodSucursal;
            regSucBancaria.empresa              := sbCodEmpresa;
      
            pkg_sucursal_bancaria.prinsRegistro(regSucBancaria);
        END IF;

        IF updating THEN
            sbCodEmpresaActual := pkg_boconsultaempresa.fsbObtEmpresaSucursal(nuCodBanco,sbCodSucursal);        
            IF sbCodEmpresa <> sbCodEmpresaActual THEN
                pkg_sucursal_bancaria.prAcEMPRESA(nuCodBanco,sbCodSucursal,sbCodEmpresa);
            END IF;
        END IF;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
	  RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	  RAISE pkg_error.CONTROLLED_ERROR;
  END BEFORE EACH ROW;

END trg_sucubanc_empresa;
/