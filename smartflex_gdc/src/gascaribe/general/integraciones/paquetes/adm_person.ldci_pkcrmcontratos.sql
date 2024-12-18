CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKCRMCONTRATOS AS
/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

         PAQUETE : LDCI_PKCRMCONTRATOS
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 31/07/2013
         RICEF   : I043
   DESCRIPCION   : Paquete para validar y consultar
				   contratos

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    31/07/2013  Creacion del paquete
************************************************************************/
PROCEDURE proValidaContrato (inuSusccodi        IN   suscripc.susccodi%type,
                             onuCntrtExiste      OUT  VARCHAR2,
                             onuDepartament     OUT NUMBER,
                             onuLocalidad       OUT NUMBER,
                             onuErrorCode       OUT  NUMBER,
                             osbErrorMessage    OUT  VARCHAR2);

END LDCI_PKCRMCONTRATOS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKCRMCONTRATOS AS

/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

   PROCEDIMIENTO : proValidaContrato
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 31/07/2013
         RICEF   : I043
   DESCRIPCION   : Paquete para validar y consultar
				   contratos

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    31/07/2013  Creacion del procedimiento
************************************************************************/
PROCEDURE proValidaContrato (inuSusccodi         IN   suscripc.susccodi%type,
                             onuCntrtExiste      OUT  VARCHAR2,
                             onuDepartament      OUT NUMBER,
                             onuLocalidad        OUT NUMBER,
                             onuErrorCode        OUT  NUMBER,
                             osbErrorMessage     OUT  VARCHAR2)
      IS



         nuExiste number;
      BEGIN
      onuErrorCode:=0;
      onuCntrtExiste := '-1';
         BEGIN
            SELECT count(1)
            INTO   nuExiste
            FROM   open.suscripc
            WHERE  susccodi = inuSusccodi
            AND  susccodi > 0 ; --Se excluye el  codigo -1  comodin
         EXCEPTION
         WHEN NO_DATA_FOUND then
            nuExiste:=-1;
         WHEN OTHERS THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
         END;

         IF (nuExiste = 1) then
           onuCntrtExiste := '1';
         ELSE
           onuCntrtExiste := '0';
         END IF;

         IF  onuCntrtExiste = '1' THEN
         /*
          * Consulta de departamento
          */
           Select Geograp_Location_Id INTO onuDepartament
                         From Ge_Geogra_Location
                         Where Geograp_Location_Id =    (Select Geo_Loca_Father_Id
                                                               From  Ge_Geogra_Location
                                                               Where Geograp_Location_Id= (SELECT abadd.Geograp_Location_Id
                                                                                            FROM SUSCRIPC SUSC,AB_ADDRESS abadd
                                                                                            WHERE SUSC.SUSCCODI=inuSusccodi and
                                                                                            abadd.address_id=SUSC.susciddi));
          /*
           * Consulta de localidad
           *
           */
          Select Geograp_Location_Id INTO onuLocalidad
                         From Ge_Geogra_Location
                         Where Geograp_Location_Id =(SELECT abadd.Geograp_Location_Id
                                                      FROM SUSCRIPC SUSC,AB_ADDRESS abadd
                                                      WHERE SUSC.SUSCCODI=inuSusccodi and
                                                      abadd.address_id=SUSC.susciddi);
     END IF;
     -- RETURN nuResExiste;

      EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
          osbErrorMessage := 'Error validando contrato: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
          pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
          Errors.seterror;
          Errors.geterror (onuErrorCode, osbErrorMessage);
      WHEN OTHERS THEN
        osbErrorMessage := 'Error validando contrato: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
        pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
        Errors.seterror;
        Errors.geterror (onuErrorCode, osbErrorMessage);   END proValidaContrato;
END LDCI_PKCRMCONTRATOS;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKCRMCONTRATOS', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKCRMCONTRATOS to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKCRMCONTRATOS to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKCRMCONTRATOS to REXEINNOVA;
/

