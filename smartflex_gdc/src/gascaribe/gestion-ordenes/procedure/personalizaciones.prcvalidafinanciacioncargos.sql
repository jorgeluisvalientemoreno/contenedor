CREATE OR REPLACE PROCEDURE personalizaciones.prcValidaFinanciacionCargos IS

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcValidaFinanciacionCargos
    Caso            : OSF-2880
    Descripcion     : servicio para validar si la solcicitud asociada a la orden legalizada tiene un cargo con cuenta de cobro. 
    Autor           : Jorge Valiente
    Fecha           : 22-07-2024
  
    Modificaciones  :
    Autor           Fecha       Caso       Descripcion
    Jorge Valiente  08/08/2024  OSF-3103   Validar tipo de solicitud del parametro TIPO_SOL_EXCLU_VALIDA_FINANCIA
                                           relacionada a la orden legalizada para ser excluiod de la valdacion 
                                           de cargos a la -1
  ***************************************************************************/

  csbSP_NAME     VARCHAR2(70) := 'prcValidaFinanciacionCargos';
  nuCodigoError  number;
  sbMensajeError varchar2(4000);

  cursor cuDataOrden(nuOrden number) is
    select ooa.*
      from Or_Order_Activity ooa
     where ooa.order_id = nuOrden;

  rfDataOrden cuDataOrden%rowtype;

  cursor cuValidaCuentaCobro(nuSolicitud number, nuProducto number) is
    select count(1) cantidad
      from cargos
     where cargnuse = nuProducto
       and cargdoso like 'PP-' || nuSolicitud
       and cargcuco = -1;

  rfValidaCuentaCobro cuValidaCuentaCobro%rowtype;

  nuOrdenLegaliza number;

  sbvalida_financiacion varchar2(4000) := pkg_parametros.fsbGetValorCadena('VALIDA_FINANCIACION');

  --Inicio OSF-3103
  sbTipoSolExcluValidaFinancia varchar2(4000) := pkg_parametros.fsbGetValorCadena('TIPO_SOL_EXCLU_VALIDA_FINANCIA');
  cursor cuTipoSolicitud(inuSolicitud number) is
    select mp.package_type_id
      from mo_packages mp
     where mp.package_id = inuSolicitud;

  rfTipoSolicitud cuTipoSolicitud%rowtype;

  cursor cuExiste(inuValor number, isbValorParametro varchar2) is
    SELECT COUNT(1)
      FROM (SELECT to_number(regexp_substr(isbValorParametro,
                                           '[^,]+',
                                           1,
                                           LEVEL)) AS column_value
              FROM dual
            CONNECT BY regexp_substr(isbValorParametro, '[^,]+', 1, LEVEL) IS NOT NULL)
     WHERE column_value = inuValor;

  nuExiste number;
  --Fin OSF-3103

BEGIN

  pkg_traza.trace(csbSP_NAME,
                  pkg_traza.cnuNivelTrzDef,
                  pkg_traza.csbINICIO);

  pkg_traza.trace('Valida Financiacion: ' || sbvalida_financiacion,
                  pkg_traza.cnuNivelTrzDef);
  if sbvalida_financiacion = 'S' then
  
    nuOrdenLegaliza := pkg_bcordenes.fnuobtenerotinstancialegal; -- Obtenemos la orden que se esta legalizando
  
    ---data de la orden legalizada
    open cuDataOrden(nuOrdenLegaliza);
    fetch cuDataOrden
      into rfDataOrden;
    if cuDataOrden%found then
    
      --Inicio OSF-3103
      --Obtiene el tipo de solicitud que tiene relacion con la orden legalizada
      open cuTipoSolicitud(rfDataOrden.Package_Id);
      fetch cuTipoSolicitud
        into rfTipoSolicitud;
      close cuTipoSolicitud;
      pkg_traza.trace('Tipo de solicitud: ' ||
                      rfTipoSolicitud.Package_Type_Id,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Valor Parametro TIPO_SOL_EXCLU_VALIDA_FINANCIA: ' ||
                      sbTipoSolExcluValidaFinancia,
                      pkg_traza.cnuNivelTrzDef);
    
      --Valida si el tipo de solicitud esta configurado en el parametro
      open cuExiste(rfTipoSolicitud.Package_Type_Id,
                    sbTipoSolExcluValidaFinancia);
      fetch cuExiste
        into nuExiste;
      close cuExiste;
      pkg_traza.trace('Existe en el parametro: ' || nuExiste,
                      pkg_traza.cnuNivelTrzDef);
      --Fin OSF-3103
    
      --solo valida cargos a la -1 si el producto y solicitud no son nulos
      if rfDataOrden.Package_Id is not null and
         rfDataOrden.Product_Id is not null and nuExiste = 0 then
      
        --Data del cargo relacionado a la solicitud de la orden legalizada
        open cuValidaCuentaCobro(rfDataOrden.Package_Id,
                                 rfDataOrden.Product_Id);
        fetch cuValidaCuentaCobro
          into rfValidaCuentaCobro;
      
        --valida cantidad de cargos a la -1
        if cuValidaCuentaCobro%found then
          if rfValidaCuentaCobro.Cantidad > 0 then
            Pkg_Error.SetErrorMessage(isbMsgErrr => 'La solicitud ' ||
                                                    rfDataOrden.Package_Id ||
                                                    ' genera un cargo a la -1 el cual no es financiado.');
          end if;
        end if;
      
        close cuValidaCuentaCobro;
      
      end if; --fin if rfDataOrden.Package_Id is not null and rfDataOrden.Product_Id is not null then
    
    end if; --fin if cuDataOrden%found then
  
    close cuDataOrden;
  
  end if; --fin if sbvalida_financiacion = 'S' then

  pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuCodigoError, sbMensajeError);
    pkg_traza.trace('Error: ' || sbMensajeError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
  
    raise pkg_error.CONTROLLED_ERROR;
  
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuCodigoError, sbMensajeError);
    pkg_traza.trace('Error: ' || sbMensajeError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
  
    raise pkg_error.CONTROLLED_ERROR;
END;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PRCVALIDAFINANCIACIONCARGOS',
                                   'PERSONALIZACIONES');
END;
/