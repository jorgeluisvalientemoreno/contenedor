CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUCENTRMEDCOTI" (nuordencargo OR_ORDER.order_id%TYPE)
RETURN NUMBER IS


/*
Desarrollado: José Cristobal Filigrana Paz
Descripción: Retornar el codigo del item de centro de medidición para una venta cotizada
Fecha: 23/11/2014
NC 3877

*/
	--- Cursor para obterner el item de centro de medición

  CURSOR ItemCotizado(NuOT OR_ORDER.order_id%TYPE) IS
  SELECT  a.ITEMS_ID,c.package_id
  FROM CC_QUOTATION C,
       CC_QUOTATION_ITEM a, 
       GE_ITEMS b, 
       MO_PACKAGES d, 
       PS_PACKAGE_TYPE f
  WHERE a.ITEMS_ID=b.ITEMS_ID
  AND C.QUOTATION_ID=a.QUOTATION_ID
  AND d.package_id=c.package_id
  AND d.package_type_id=f.package_type_id
  AND f.package_type_id=100229    --- solo venta de gas cotizada
  AND UPPER(b.DESCRIPTION) LIKE '%CENTR%MEDI%'
  AND c.package_id = (SELECT DISTINCT g.PACKAGE_ID
                      FROM OR_ORDER_ACTIVITY g
                      WHERE order_id=NuOT);

  --nuordencargo NUMBER;
  NuItemMedi GE_ITEMS.items_id%TYPE;
  NuSoliCotiz MO_PACKAGES.package_id%TYPE;
  NuOtCoti    OR_ORDER.order_id%TYPE;

BEGIN

    OPEN ItemCotizado(nuordencargo);
    FETCH ItemCotizado INTO NuItemMedi,NuSoliCotiz;
    IF ItemCotizado%NOTFOUND THEN
	  --Si no encuentra item devuelve cero
      NuItemMedi:=0;
    END IF;

	Ut_Trace.TRACE('Item '||NuItemMedi||' Solicitud '||NuSoliCotiz||' OT '||nuordencargo, 10);

	RETURN NuItemMedi;

	EXCEPTION WHEN OTHERS THEN
		Ut_Trace.TRACE('FnuCentrMedCoti--> Error en la OT '||nuordencargo||' '||SQLERRM,10);


END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUCENTRMEDCOTI', 'ADM_PERSON');
END;
/