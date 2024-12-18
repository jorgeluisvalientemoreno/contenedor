CREATE OR REPLACE PROCEDURE adm_person.ldc_prregisternewcharge(inuoperunit     IN or_operating_unit.operating_unit_id%TYPE,
                                                               inuitem         IN ct_item_novelty.items_id%TYPE,
                                                               inutecunit      IN ge_person.person_id%TYPE,
                                                               inuorderid      IN or_order.order_id%TYPE,
                                                               inuvalue        IN NUMBER,
                                                               inuamount       IN NUMBER,
                                                               inuuserid       IN sa_user.user_id%TYPE,
                                                               inucommentype   IN ge_comment_type.comment_type_id%TYPE,
                                                               isbcomment      IN or_order_comment.order_comment%TYPE,
                                                               onuerrorcode    OUT ge_error_log.error_log_id%TYPE,
                                                               osberrormessage OUT ge_error_log.description%TYPE,
                                                               onuordernovelty OUT or_order.order_id%TYPE) IS
  /***************************************************************************
    Propiedad intelectual de PETI
      
    Procedure   :  LDC_prRegisterNewCharge
    Descripcion :  Crea la orden de novedad LDC
      
    Autor       :  Sayra Ocoro
    Fecha       :  22-02-2012
  
    Parametros de Entrada
    Nombre          Descripcion
    -----------------------------------------------
    inuoperunit     Codigo de unidad Operativa
    inuitem         Codigo de actividad novedad
    inutecunit      Codigo del tecnico
    inuorderid      Codigo de orden 
    inuvalue        Valor
    inuamount       Cantidad Legalizada
    inuuserid       Codigo de usuario conectado
    inucommentype   Codigo Tipo Comentario
    isbcomment      Coemntario
                                     
    Parametros de Salida  
    Nombre         Descripcion
    -----------------------------------------------
    onuerrorcode    Codigo de Error
    osberrormessage Mensaje de Error
    onuordernovelty Novedad generada
      
    FECHA               AUTOR             MODIFICACION
    =========           =========         ====================
    14/05/2024          Paola Acosta      OSF-2674: Cambio de esquema ADM_PERSON  
    24/06/2024          Jorge Valiente    OSF-2472: Adicionar logica para establecer novedad 
                                                    a contrato abiertos y vigentes  
  ***************************************************************************/

  cursor cuTipoTrabajo is
    select otti.task_type_id
      from or_task_types_items otti
     where otti.items_id = inuitem;

  sbExisteContrato varchar2(1) := 'N';
  nuTipoTrabajo    number;
  nuContratista    number;

  csbMetodo VARCHAR2(70) := 'fsbContratoVigentexTipTra';
  cnuNVLTRC CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;

BEGIN

  pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);

  open cuTipoTrabajo;
  fetch cuTipoTrabajo
    into nuTipoTrabajo;
  close cuTipoTrabajo;

  nuContratista := PKG_BCUNIDADOPERATIVA.FNUGETCONTRATISTA(inuoperunit);

  pkg_traza.trace('Tipo Trabajo: ' || nuTipoTrabajo, cnuNVLTRC);
  pkg_traza.trace('Contratista: ' || nuContratista, cnuNVLTRC);

  if nuContratista is null then
  
    onuerrorcode    := 2741;
    osberrormessage := 'La unidad no pertenece a un contratista.';
  
  else
  
    sbExisteContrato := pkg_BcContratoContratista.fsbContratoVigentexTipTra(nuTipoTrabajo,
                                                                            nuContratista);
  
    pkg_traza.trace('Existe Contrato Vigente: ' || sbExisteContrato,
                    cnuNVLTRC);
  
    if sbExisteContrato = 'S' then
    
      --Valida los datos antes de crear la orden de novedad
      Ct_Bonovelty.validatenovelty(inuoperunit,
                                   inuitem,
                                   inutecunit,
                                   inuorderid,
                                   inuvalue,
                                   inuamount,
                                   inuuserid,
                                   inucommentype,
                                   isbcomment);
      --Crea la orden de novedad
      Ct_Bonovelty.createnovelty(NULL,
                                 inuoperunit,
                                 inuitem,
                                 inutecunit,
                                 inuorderid,
                                 inuvalue,
                                 inuamount,
                                 inuuserid,
                                 inucommentype,
                                 isbcomment,
                                 onuordernovelty);
    
    else
    
      onuerrorcode    := 2741;
      osberrormessage := 'Contrato No Vigente y/o Tipo de Trabajo No relacionado al Contrato o Tipo de contrato.';
    
    end if;
  
  end if;

  pkg_traza.trace('Error: ' || onuerrorcode || ' - ' || osberrormessage,
                  cnuNVLTRC);

  pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);

EXCEPTION

  WHEN pkg_Error.Controlled_Error THEN
    pkg_Error.getError(onuerrorcode, osberrormessage);
    pkg_traza.trace('Error: ' || osberrormessage, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(onuerrorcode, osberrormessage);
    pkg_traza.trace('Error: ' || osberrormessage, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
  
END ldc_prregisternewcharge;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRREGISTERNEWCHARGE
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRREGISTERNEWCHARGE', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_PRREGISTERNEWCHARGE para reportes
GRANT EXECUTE ON adm_person.LDC_PRREGISTERNEWCHARGE TO rexereportes;
/