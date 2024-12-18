create or replace procedure pr_registerRequestEnergy is

/*****************************************************************

  Propiedad intelectual de Gases del Caribe (c).



  Unidad         : pr_registerRequesEnergy
  Descripcion    : Proceso invocado por la regla del tramite de venta de energía solar
  Autor          : dsaltarin
  Fecha          : 05/06/2023

  Historia de Modificaciones
  Fecha            Autor           Caso        Modificacion
  =========        =========       =========   =============
  

  ******************************************************************/

  nuPackageId            mo_packages.package_id%type;
  nuAction               ge_action_module.action_id%type:=60;
  nuProdStatusActive     ps_product_status.product_status_id%type := 1;
begin
  
  --obtiene la solicitud
  nuPackageId := MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE;
  
  --Crea el producto
  Pr_Bocreationproduct.initialCreationProduct(nuPackageId);
  --Activa el producto y atiende la solicitud.
  MO_BOATTENTION.ATTENDCREATIONPRODBYPACKMASS(nuPackageId, nuAction, nuProdStatusActive);
  
EXCEPTION
  WHEN ex.Controlled_error then
    RAISE ex.Controlled_error;
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    RAISE ex.Controlled_error;
END;
/
GRANT EXECUTE ON pr_registerRequestEnergy TO SYSTEM_OBJ_PRIVS_ROLE
/