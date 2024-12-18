CREATE OR REPLACE PROCEDURE ldc_prGetPackageInst(onuSolicitud out open.mo_packages.package_id%type) IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Nombre      : ldc_prGetPackageInst
    Caso        : SN-611    
    Descripcion : Procedimiento para obtener la solicitud en la instancia durante 
                  la generación del cobro de la solicitud de venta 271

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
   **************************************************************************/       
    nuSolInstancia open.mo_packages.package_id%type;
BEGIN 
    pkinstancedatamgr.gettg_package( nuSolInstancia );

    IF nuSolInstancia is null THEN
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No se encontro solicitud en la instancia');
        RAISE ex.controlled_error;
    ELSE
        onuSolicitud := nuSolInstancia;
    END IF;
EXCEPTION
 WHEN ex.controlled_error THEN
  RAISE;
 WHEN OTHERS THEN
  errors.seterror;
  RAISE ex.controlled_error;
END ldc_prGetPackageInst;
/
GRANT EXECUTE on ldc_prGetPackageInst to SYSTEM_OBJ_PRIVS_ROLE;
/