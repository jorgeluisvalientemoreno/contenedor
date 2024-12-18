CREATE OR REPLACE PROCEDURE PERSONALIZACIONES.OAL_CAMBIOCATEGORIAPROD  
( 
  inuOrden      IN   NUMBER,
  InuCausal     IN   NUMBER,
  InuPersona    IN   NUMBER,
  idtFechIniEje IN   DATE,
  idtFechaFinEje IN DATE,
  IsbDatosAdic  IN  VARCHAR2,
  IsbActividades IN VARCHAR2,
  IsbItemsElementos IN VARCHAR2,
  IsbLecturaElementos IN  VARCHAR2,
  IsbComentariosOrden IN VARCHAR2 
)
IS

  /*****************************************************************************************************************
  Propiedad intelectual de PETI.

  Unidad         : OAL_CAMBIOCATEGORIAPROD
  Descripcion    : Proceso para registrar tramite 100225  - Cambio de Uso del Servicio


  Autor          : diana.montes@globalmvm.com
  Fecha          : 30/08/2023

  Parametros              Descripcion
  ============         ===================      
  inuOrden              numero de orden
  InuCausal             causal de legalizacion
  InuPersona            persona que legaliza
  idtFechIniEje         fecha de inicio de ejecucion
  idtFechaFinEje        fecha fin de ejecucion
  IsbDatosAdic          datos adicionales
  IsbActividades        actividad principal y de apoyo
  IsbItemsElementos     items a legalizar
  IsbLecturaElementos   lecturas
  IsbComentariosOrden   comentario de la orden  

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  22/09/2023       jose.pineda        OSF-1478: * Se actualiza siempre 
								      sin importar el tipo de causal
  21/09/2023       jose.pineda        OSF-1478: * Se obtiene el contrato justo
                                      después del producto
  11/09/2023       jose.pineda        OSF-1478: * Se ajustan agregan parametros 
                                      de entrada
                                      * Se cambia manejo de excepciones para hacer
                                      raise
                                      * Se procesa con la causal de entrada
  30/08/2023       diana.montes       OSF-1478: Creación
  *******************************************************************************************************************/
     
    nuCausalClass   ge_causal.CLASS_CAUSAL_ID%type;
    nuPackageId     mo_packages.package_id%type;
    nuMotiveId      mo_motive.motive_id%type;
    nuProductId     pr_product.product_id%type;
    nuCategAnt      pr_product.category_id%type;
    nuCategAct      pr_product.category_id%type;
    nuSuscripc      suscripc.susccodi%type;
    nuCambioAnt number := 0;  
    nuCambioAct number := 0;
    nuBillDataChange number; 
    sbNoReg VARCHAR2(2000) :=DALD_PARAMETER.fsbGetValue_Chain('CATEG_IDUSTRIA_NO_REG');
    SBReg VARCHAR2(2000) := pkg_parametros.fsbGetValorCadena('CATEG_INDUSTRIA_REG');
    v_tStringTable ldc_bcConsGenerales.tyTblStringTable ;
    
BEGIN
    ut_trace.trace('INICIO OAL_CAMBIOCATEGORIAPROD ', 10);
   
    ut_trace.trace('inuOrden => ' || inuOrden, 10);

    ut_trace.trace('InuCausal => ' || InuCausal, 10);

    if InuCausal is not null then
        nuCausalClass := to_number(LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('ge_causal','causal_id ','class_causal_id ',InuCausal));
    else
        pkg_error.setErrorMessage( isbMsgErrr => 'No se encontró causal' );
    end if;
    if nuCausalClass is null  then
        pkg_error.setErrorMessage( isbMsgErrr => 'No se encontró clase de causal' );
    end if;

    ut_trace.trace('nuCausalClass => ' || nuCausalClass, 10);
     
    --Obtener identificador del paquete
    nuMotiveId:= to_number(LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('or_order_activity','order_id ','motive_id ',inuOrden));
     ut_trace.trace('nuMotiveId => ' || to_char(nuMotiveId), 10);
    if nuMotiveId  = -1  then
        pkg_error.setErrorMessage( isbMsgErrr => 'No se encontró motivo asociado a la solicitud '||to_char(nuPackageId) );
    end if;
    nuPackageId := to_number(LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('mo_motive','motive_id ','package_id ',nuMotiveId));

    ut_trace.trace(' nuPackageId => ' || nuPackageId, 10);
    if nuPackageId is null  then
         pkg_error.setErrorMessage( isbMsgErrr => 'No se encontró identificador de solicitud' );
    end if;
  
    --Obtener producto
    nuProductId := to_number(LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('or_order_activity','order_id ','product_id ',inuOrden));
    ut_trace.trace('nuProductId => ' || nuProductId, 10);
    if nuProductId is null  then
         pkg_error.setErrorMessage( isbMsgErrr => 'No se encontró identificador de producto' );
    end if;

    --Obtener suscriptor
    nuSuscripc := to_number(LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('pr_product','product_id ','subscription_id ',nuProductId));
    if nuSuscripc is null then
       pkg_error.setErrorMessage( isbMsgErrr => 'No se encontró contrato para el producto '||to_char(nuProductId) );
    end if;        
    
    --Obtener categoria anterior
    if (nuPackageId IS not null) then
        -- Obtiene id de mo_bill_data_change
        nuBillDataChange := to_number(LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('mo_bill_data_change','package_id ','bill_data_change_id ',nuPackageId));
        ut_trace.trace('nuBillDataChange => ' || nuBillDataChange,10);
       if (nuBillDataChange IS not null) then
            --- obtiene categoria vieja
            nuCategAnt := to_number(LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('mo_bill_data_change','bill_data_change_id ','old_category_id ',nuBillDataChange));
            
            ut_trace.trace('nuCategAnt => ' || nuCategAnt,10);
       else
             pkg_error.setErrorMessage( isbMsgErrr => 'No se encontró identificador de registro en mo_bill_data_change para la solicitud '||to_char(nuPackageId) );
        END if;
    END if;

    --Obtener categoría actual
    nuCategAct := to_number(LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA('mo_bill_data_change','bill_data_change_id ','new_category_id ',nuBillDataChange));
    ut_trace.trace(' nuCategAct => ' || to_char(nuCategAct), 10);
    if nuCategAct is null  then
         pkg_error.setErrorMessage( isbMsgErrr => 'No se encontró identificador de categoría para el motivo '||to_char(nuMotiveId) );
    end if;
    
    IF INSTR( '|' || sbNoReg || '|' , '|' || nuCategAct || '|' ) > 0 then
        nuCambioAct:= 1; 
        ut_trace.trace(' nuCategAct es no regulado ' , 10);
    ELSIF INSTR( '|' || sbReg || '|' , '|' || nuCategAct || '|' ) > 0 then
        nuCambioAct:= 2;
        ut_trace.trace(' nuCategAct es regulado ' , 10);
    END IF;
    
    IF INSTR( '|' || sbNoReg || '|' , '|' || nuCategAnt || '|' ) > 0 then
        nuCambioAnt:= 1; 
        ut_trace.trace(' nuCategAnt es no regulado ' , 10);
    ELSIF INSTR( '|' || sbReg || '|' , '|' || nuCategAnt || '|' ) > 0 then
        nuCambioAnt:= 2;
        ut_trace.trace(' nuCategAnt es regulado ' , 10);
    END IF;
    ut_trace.trace(' nuCambioAct '||nuCambioAct||' - nuCambioAnt ' ||nuCambioAnt, 10);
    IF ( nuCambioAct=nuCambioAnt or 
        nuCambioAct is null or 
        nuCambioAnt is null)
    then
    -- no actualiza categoria
        ut_trace.trace('No realizo cambio de Regulado a No Regulado o visceversa' , 10);
        return;
    elsif (nuCambioAct=1)
    then
        ut_trace.trace('Va a realizar cambio a industrial no regulado' , 10);  

        ut_trace.trace('nuSuscripc => ' || to_char(nuSuscripc), 10);  
        v_tStringTable := ldc_bcConsGenerales.ftbAllSplitString
                (
                    pkg_parametros.fsbGetValorCadena('FORMATO_INDUSTRIA_NO_REG'),
                    '|'
                );
         if v_tStringTable is null then
           pkg_error.setErrorMessage( isbMsgErrr => 'No se encontró valor para el parametro FORMATO_INDUSTRIA_NO_REG' );
        end if;
        if(v_tStringTable.count=3)then
            pkg_bccontrato.UPDSUSCCEMF(nuSuscripc ,v_tStringTable(1));
            pkg_bccontrato.UPDSUSCCEMD(nuSuscripc ,v_tStringTable(2));
            pkg_bccontrato.UPDSUSCCOEM(nuSuscripc ,v_tStringTable(3));    
        end if;      
     
    elsif (nuCambioAct=2)
    then
        ut_trace.trace('Va a realizar cambio a industrial  regulado' , 10);
        pkg_bccontrato.UPDSUSCCEMF(nuSuscripc ,null);
        pkg_bccontrato.UPDSUSCCEMD(nuSuscripc ,null);
        pkg_bccontrato.UPDSUSCCOEM(nuSuscripc ,null);

    end if;
         
    ut_trace.trace('FIN OAL_CAMBIOCATEGORIAPROD ', 10);

    EXCEPTION
        when pkg_error.CONTROLLED_ERROR then
            raise pkg_error.CONTROLLED_ERROR;
        when OTHERS then
            Pkg_Error.setError;
            raise pkg_error.CONTROLLED_ERROR;
END OAL_CAMBIOCATEGORIAPROD ;
/

PROMPT Otorgando permisos de ejecución a OAL_CAMBIOCATEGORIAPROD
BEGIN
  pkg_utilidades.prAplicarPermisos('OAL_CAMBIOCATEGORIAPROD', 'PERSONALIZACIONES'); 
END;
/

