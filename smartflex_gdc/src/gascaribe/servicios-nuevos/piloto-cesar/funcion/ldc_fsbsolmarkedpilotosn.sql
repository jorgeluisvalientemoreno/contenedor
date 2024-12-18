create or replace function ldc_fsbIsSolMarkedPilotoSN(nuSolicitud in open.mo_packages.package_id%type)
/**************************************************************************
    Autor       : dsaltarin
    Fecha       : 06/10/2022
    Descripcion : SN:611: funcion para validar si una solicitud se encuentra marcada en el piloto 
                  de servicios nuevos cesar, instalación en 2 visitas

    Parametros Entrada
        nuSolicitud: Solicitud que se esta facturANDo
    Valor de salida
        S: Solicitud Marcada
        N: Solicitud no marcada.

  HISTORIA DE MODIFICACIONES
    FECHA       AUTOR     DESCRIPCION
***************************************************************************/
  RETURN VARCHAR2 IS

  CURSOR cuValMarcado IS
    SELECT count(1)
    FROM open.mo_packages p 
    INNER JOIN open.mo_comment m  on p.package_id=m.package_id and  m.comment_ like '%PLAN_PILOTO_2_VISITAS_V2%'
    WHERE p.package_id=nuSolicitud
    AND   p.package_type_id=271;

    nuMarcado NUMBER;
BEGIN
  IF cuValMarcado%ISOPEN THEN
    CLOSE cuValMarcado;
  END IF;
  OPEN cuValMarcado;
  FETCH cuValMarcado INTO nuMarcado;
  CLOSE cuValMarcado;
  
  IF nuMarcado>0 THEN
     RETURN 'S';
  ELSE
     RETURN 'N';
  END IF;
EXCEPTION
WHEN OTHERS THEN
    errors.seterror;
    RETURN 'N';
END ldc_fsbIsSolMarkedPilotoSN;
/
GRANT EXECUTE on ldc_fsbIsSolMarkedPilotoSN to SYSTEM_OBJ_PRIVS_ROLE;
/