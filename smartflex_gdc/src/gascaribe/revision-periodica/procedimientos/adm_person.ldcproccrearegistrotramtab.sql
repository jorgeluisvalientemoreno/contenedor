CREATE OR REPLACE PROCEDURE adm_person.ldcproccrearegistrotramtab (
    nucodigo      NUMBER,
    nuproducto    pr_product.product_id%TYPE,
    nusolicitud   mo_packages.package_id%TYPE,
    numarcaantes  ldc_marca_producto.suspension_type_id%TYPE,
    numarcaactual ldc_marca_producto.suspension_type_id%TYPE,
    dtfecha       DATE,
    sbobservacion VARCHAR2
) AS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : ldcproccrearegistrotramtab
    Descripcion : Procedimiento que crea registro en la tabla ldc_creatami_revper
                  siempre que se ingrese una nueva solicitud  de revisión periodica
    Autor       : John Jairo Jimenez Marimón
    Fecha       : 20-02-2017

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    14/05/2024          Paola Acosta       OSF-2674: Cambio de esquema ADM_PERSON 
    **************************************************************************/
    
BEGIN
 -- Actualizamos marca producto en ldc_creatami_revper
    INSERT INTO ldc_creatami_revper (
        codigo,
        producto,
        solicitud,
        marca_antes,
        marca_actal,
        fecha,
        observacion
    ) VALUES (
        nucodigo,
        nuproducto,
        nusolicitud,
        numarcaantes,
        numarcaactual,
        dtfecha,
        sbobservacion
    );

EXCEPTION
    WHEN OTHERS THEN
        errors.seterror;
        RAISE ex.controlled_error;
END ldcproccrearegistrotramtab;
/
PROMPT Otorgando permisos de ejecucion a LDCPROCCREAREGISTROTRAMTAB
BEGIN
    pkg_utilidades.praplicarpermisos('LDCPROCCREAREGISTROTRAMTAB', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDCPROCCREAREGISTROTRAMTAB para reportes
GRANT EXECUTE ON adm_person.LDCPROCCREAREGISTROTRAMTAB TO rexereportes;
/