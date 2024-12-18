CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBRETORNAAPLICAASIGAUTO" (nupatipotrabajo NUMBER,nupacausal NUMBER) RETURN VARCHAR2 IS
 sbasigauto ldc_conftitra_caus_asig_aut.asig_auto%TYPE;
BEGIN
 SELECT x.asig_auto INTO sbasigauto
   FROM ldc_conftitra_caus_asig_aut x
  WHERE x.tipo_trabajo = nupatipotrabajo
    AND nvl(x.causal,-1) = decode(nupacausal,-1,nvl(x.causal,-1),nupacausal)
    AND x.asig_auto IN('S','s')
    AND rownum = 1;
    RETURN sbasigauto;
EXCEPTION
 WHEN OTHERS THEN
  sbasigauto := 'N';
  RETURN sbasigauto;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBRETORNAAPLICAASIGAUTO', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_FSBRETORNAAPLICAASIGAUTO TO REXEREPORTES;
/