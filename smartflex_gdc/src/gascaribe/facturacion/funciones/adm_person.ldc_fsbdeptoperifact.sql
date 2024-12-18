CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBDEPTOPERIFACT" (iNuPeriFact perifact.pefacodi%TYPE)
  RETURN VARCHAR2 IS

  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : Ldc_FsbDeptoPeriFact
  Descripcion : Funcion que retorna:
                Nombre del departamento asociado a un periodo de Facturacion.
  Autor       : Sebastian Tapias
  Fecha       : 18/05/2018

  --------------------------
  --Variables de entrada -->
  --------------------------
  iNuPeriFact --> Periodo de Facturacion

  -------------------------
  --Variables de salida -->
  -------------------------
  oSbDepartamento --> Variable de retorno

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========          ====================
  18-05-2018          STAPIAS            REQ.2001859 - Creacion.
  ***************************************************************************************/

  oSbDepartamento ge_geogra_location.description%TYPE := NULL;

BEGIN
  BEGIN
    SELECT depa.description
      INTO oSbDepartamento -- Se obtiene el nombre del departamento.
      FROM open.ge_geogra_location depa
     WHERE depa.geograp_location_id =
           (SELECT loca.geo_loca_father_id -- Se obtiene el id del departamento.
              FROM open.ge_geogra_location loca
             WHERE loca.geograp_location_id =
                   (SELECT dir.geograp_location_id -- Se obtiene la localidad de la direccion.
                      FROM open.ab_address dir
                     WHERE dir.address_id =
                           (SELECT sus.susciddi --Se obtiene direccion de un contrato.
                              FROM open.suscripc sus
                             WHERE sus.susccicl IN
                                   (SELECT peri.pefacicl ciclo -- Se obtiene el Ciclo.
                                      FROM open.perifact peri
                                     WHERE peri.pefacodi = iNuPeriFact)
                               AND ROWNUM = 1)));
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      oSbDepartamento := NULL;
  END;
  RETURN oSbDepartamento; -- Retornamos la variable.
EXCEPTION
  WHEN OTHERS THEN
    RETURN NULL;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBDEPTOPERIFACT', 'ADM_PERSON');
END;
/
