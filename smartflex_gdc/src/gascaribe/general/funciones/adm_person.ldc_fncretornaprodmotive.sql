CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNCRETORNAPRODMOTIVE" (nupamotivo NUMBER) RETURN NUMBER IS
/****************************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

Funcion     : ldc_fncretornaprodmotive
Descripcion : Retorna producto asociado a un motivo
Autor       : John Jairo Jimenez Marimon
Fecha       : 21-04-2017

Historia de Modificaciones
  Fecha               Autor                Modificacion
=========           =========          ====================
*****************************************************************************************/

 nuconprod pr_product.product_id%TYPE;
BEGIN
 SELECT mt.product_id INTO nuconprod
   FROM open.mo_motive mt
  WHERE mt.motive_id = nupamotivo
    AND mt.product_id IS NOT NULL
    AND ROWNUM = 1;
 RETURN nuconprod;
EXCEPTION
 WHEN OTHERS THEN
  nuconprod := -1;
  RETURN nuconprod;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRETORNAPRODMOTIVE', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_FNCRETORNAPRODMOTIVE TO REPORTES;
/