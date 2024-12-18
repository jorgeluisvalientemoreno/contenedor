CREATE OR REPLACE PROCEDURE adm_person.ldc_prconunopsup( inuProducto IN NUMBER,
                                              onuUnidadOper OUT NUMBER)  IS
/**************************************************************************
  Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : LDC_PRCONUNOPSUP
    Descripcion : Proceso que consulta unidad operativa de ultima actividad suspension
    Autor       : Horbath
    Ticket      : 147
    Fecha       : 22-12-2019

  Historia de Modificaciones
  Fecha               Autor                Modificacion
=========           =========          ====================
08/05/2024          Adrianavg          OSF-2668: Se migra del esquema OPEN al esquema ADM_PERSON
**************************************************************************/
 PRAGMA autonomous_transaction;
 sbTramiSusp VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_SOLSUSPRP',NULL);-- se almacena tramite de suspension

 --se obtiene unidad operativa de la ultima orden de suspension legalizada
 CURSOR cugetUnidadOpera IS
 SELECT o.OPERATING_UNIT_ID
 FROM or_order o, or_order_activity oa, mo_packages p
 WHERE o.order_id = oa.order_id
  AND oa.product_id = inuProducto
  AND dage_causal.fnugetCLASS_CAUSAL_ID(o.causal_id,null) = 1
  AND p.package_id = oa.package_id
  AND p.package_type_id IN ( SELECT TO_NUMBER(column_value) tipo
                             FROM TABLE(open.ldc_boutilities.splitstrings(sbTramiSusp,',')))
 ORDER BY o.LEGALIZATION_DATE desc;


BEGIN
 --se obtiene unidad operativa
 OPEN cugetUnidadOpera;
 FETCH cugetUnidadOpera INTO onuUnidadOper;
 IF cugetUnidadOpera%NOTFOUND THEN
   onuUnidadOper := -1;
 END IF;
 CLOSE cugetUnidadOpera;
EXCEPTION
 WHEN OTHERS THEN
    onuUnidadOper := -1;
END LDC_PRCONUNOPSUP;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_PRCONUNOPSUP
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRCONUNOPSUP', 'ADM_PERSON'); 
END;
/
