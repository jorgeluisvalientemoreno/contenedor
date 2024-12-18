CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBUCC_QUOTATION_ITEM
  BEFORE INSERT OR UPDATE ON cc_quotation_item
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : ldc_trgbucc_quotation_item
  Descripcion    : Trigger para controlar la inserci?n de items de una cotizacion
                   comercial/industrial desde CCQUO.
  Autor          : KCienfuegos
  Fecha          : 15-11-2016
  Caso           : CA200-535

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  15-11-2016    KCienfuegos.CA200-535         Creacion.
  ******************************************************************/

DECLARE
    cnuErrorNumber             CONSTANT NUMBER := 2741;
    nuExiste                   NUMBER:=0;
    rcSolicitud                damo_packages.stymo_packages;
    nuTipoSolCot               ps_package_type.package_type_id%TYPE := dald_parameter.fnuGetNumeric_Value('ID_PKG_COTIZACION',0);
    sbNombreAplicacion         sa_executable.name%TYPE;
    nuSolicitud                mo_packages.package_id%TYPE;

    CURSOR cuExisteCotiComercial IS
      SELECT COUNT(1)
        FROM ldc_cotizacion_comercial cc
       WHERE cc.sol_cotizacion = nuSolicitud;

BEGIN

    sbNombreAplicacion := ut_session.getmodule;

    nuSolicitud := dacc_quotation.fnugetpackage_id(inuquotation_id => :new.quotation_id);

    IF(fblaplicaentrega(ldc_bccotizacioncomercial.csbentrega))THEN
      IF(sbNombreAplicacion <> 'LDC_FCVC')THEN
        IF(nuSolicitud IS NOT NULL)THEN
            rcSolicitud := damo_packages.frcgetrecord(inuPackage_Id => nuSolicitud);
            IF(nuTipoSolCot = rcSolicitud.package_type_id) THEN

               OPEN cuExisteCotiComercial;
               FETCH cuExisteCotiComercial INTO nuExiste;
               CLOSE cuExisteCotiComercial;

               IF(nuExiste>0)THEN
                 errors.seterror(cnuErrorNumber, 'No esta permitido modificar/agregar items desde CCQUO, para una cotizacion '||
                                 'comercial/industrial.');
                 RAISE ex.controlled_error;
               END IF;

            END IF;
        END IF;
      END IF;
    END IF;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR
    THEN RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    NULL;
END LDC_TRGBUCC_QUOTATION_ITEM;
/
