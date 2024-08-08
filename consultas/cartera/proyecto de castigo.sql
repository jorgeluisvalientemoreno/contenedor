 --se llena con PBMAFA
select *
 from open.ldc_usu_eva_cast
 where fecha_generacion>='24/04/2022'
 --se llena con PBMAFA
--creacion de proyecto LDC_PROCINCLUMAS
SELECT *
FROM OPEN.GC_PRODPRCA y
where y.prpcprca=98;

SELECT *
FROM OPEN.GC_PROYCAST r
where r.prcafecr>='01/04/2022'
 and r.prcacons=98;
 
 
 --luego se ejecuta casca desde 
-- FGCB - CASCA
--Excluir productos con error de proyectos de castigo de forma manual
--GCRRPC --Reporte de proceso con los siguienes objetos
--54946	48	32	GC_BOGENACCINFWRITEOFF.PUNPROCESSEXCLUSION	Exclusion Manual de Productos a Castigar
--54947	48	32	GC_BOGENACCINFWRITEOFF.PUNPROCESSINCLUSION	Inclusion Manual de Productos a Castigar


