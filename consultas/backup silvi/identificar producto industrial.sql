SELECT pp.subscription_id , pp.product_id, pp.product_status_id , pp.category_id ,cc.cucofact,
c.cargconc,c.cargcuco,c.cargtipr,c.cargsign,f.factcodi, c.cargpefa, co.conccodi,  c.cargfecr, c.cargvalo, c.cargdoso,cc.cucocodi
FROM cargos c, concepto co ,cuencobr cc, factura  f , pr_product pp
WHERE c.cargtipr = 'A' --a facturacion y si es p notas 
AND c.cargsign IN ('DB', 'CR')
AND c.cargdoso LIKE 'PP-%' --Cargos asociados a solicitudes
AND c.cargnuse =  pp.product_id
/*AND c.cargcuco > 0 */
AND conccodi = c.cargconc
AND cc.cucocodi = c.cargcuco
AND f.factcodi = cc.cucofact
AND  product_status_id = 1
AND category_id IN (3,6) 
AND subscription_id in (67109088)
AND co.conccodi not IN (select to_number(column_value)
FROM TABLE(open.ldc_boutilities.splitstrings(open.DALD_PARAMETER.fsbGetValue_Chain('CON_INT_RED_INT_IVA_OBR_CIV_1', NULL), ',')))
ORDER BY cargfecr DESC

AND subscription_id = 67229529
/*and f.factcodi = To_Number(2098587514
and c.cargnuse= 52348168
 237880542*/
 
 
 select *
 from factura f
 where f.factsusc in ( 67223885)
