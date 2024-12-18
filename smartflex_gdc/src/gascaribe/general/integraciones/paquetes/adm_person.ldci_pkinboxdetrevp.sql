CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKINBOXDETREVP IS
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : LDCI_PKINBOXDETREVP
   Descripcion : Paquete de integraciones personalizado para revision periodica.
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  PROCEDURE proProcesaXMLArchivoInspeccion(isbcertificate in LDC_CERTIFICADOS_OIA.Certificado%type,
                                           inuOrderid     in LDC_CERTIFICADOS_OIA.Order_Id%type);
END LDCI_PKINBOXDETREVP;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKINBOXDETREVP IS
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : LDCI_PKINBOXDETREVP
   Descripcion : Paquete de integraciones personalizado para revision periodica.
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  /***********************************************************************************************************
  Propiedad Intelectual de Gases del Caribe S.A E.S.P

   Funcion     : proProcesaXMLArchivoInspeccion
   Descripcion : Servicio encargado de actualizar el estado del archivo
                 Teniendo en cuenta el certificado y el # de la orden.
   Autor       : Sebastian Tapias
   Fecha       : 2-01-2018

   Historia de Modificaciones
     Fecha               Autor                Modificacion
   =========           =========          ====================
  ************************************************************************************************************/
  PROCEDURE proProcesaXMLArchivoInspeccion(isbcertificate in LDC_CERTIFICADOS_OIA.CERTIFICADO%type,
                                           inuOrderid     in LDC_CERTIFICADOS_OIA.ORDER_ID%type) AS
  BEGIN
    /* Se actualiza el estado del archivo en la tabla LDC_CERTIFICADOS_OIA*/
    BEGIN
      UPDATE LDC_CERTIFICADOS_OIA LCO
         SET LCO.ARCHIVO       = open.dald_parameter.fsbgetvalue_chain('STATUS_FILE_OIA'), --Estado a aplicar
             LCO.FECHA_ARCHIVO = SYSDATE
       WHERE LCO.CERTIFICADO = isbcertificate -- No del certificado
         AND LCO.ORDER_ID = inuOrderid; -- No de la orden
      commit;
    EXCEPTION
      WHEN OTHERS THEN
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                         'Se presento un error actualizando el estado de archivo para la orden [' ||
                                         to_char(inuOrderid) || ']');
    END;
  EXCEPTION
    WHEN OTHERS THEN
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                       'ERROR: [' || SQLERRM || ']');
  END proProcesaXMLArchivoInspeccion;
END LDCI_PKINBOXDETREVP;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PKINBOXDETREVP
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKINBOXDETREVP','ADM_PERSON');
END;
/
