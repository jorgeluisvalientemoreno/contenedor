--GIS
--Direccion
select * from open.ab_address;
--Direccion
select a.address_id,
       a.segment_id,
       a.geograp_location_id,
       a.neighborthood_id,
       a.address
  from open.ab_address a
 where a.neighborthood_id is not null;
--Direccion, segmento y sector operativo
select a.address_id Codigo_Direccion,
       f.geograp_location_id || ' - ' || f.description Departamento,
       a.geograp_location_id || ' - ' || e.description Localidad,
       a.segment_id Segmento,
       c.operating_sector_id || ' - ' || c.description Sector_Operativo,
       --h.operating_zone_id || ' - ' || h.description Zona,
       a.neighborthood_id || ' - ' || d.description Barrio,
       a.address Direccion
  from open.ab_address a
 inner join ab_segments b
    on b.segments_id = a.segment_id
 inner join OR_OPERATING_SECTOR c
    on c.operating_sector_id = b.operating_sector_id
 inner join ge_geogra_location d
    on d.geograp_location_id = a.neighborthood_id
 inner join ge_geogra_location e
    on e.geograp_location_id = a.geograp_location_id
 inner join ge_geogra_location f
    on f.geograp_location_id = e.geo_loca_father_id
/*inner join  GE_SECTOROPE_ZONA g
on g.id_sector_operativo = c.operating_sector_id*/
 where a.neighborthood_id is not null;

select * from GE_ZONE_CLASSIF; -- (Clasificación de las Zonas) 
select * from OR_OPERATING_ZONE; -- (Zona Operativa)
select * from OR_OPERATING_SECTOR; -- (Sector Operativo) 
select * from OR_ZONA_BASE_ADM; -- (Zonas por Bases Administrativas)
select * from GE_SECTOROPE_ZONA; -- (Sector Operativo por Zona)
select * from GE_DISTADMI_GEOGLOCA; -- (Distribución Administrativa por Ubicación Geográfica)
select * from OR_TMP_OPT_ROUTES; -- (Candidatos)
select * from GE_BASE_ADMINISTRA; -- (Base Administrativa)

--Zona
select * from OR_OPERATING_ZONE;
--Zona X Sector Operativo
select * from GE_SECTOROPE_ZONA;
--TABLE SECTOR GEOGRÁFICO N:[NORTE], S:[SUR], W:[OESTE], O:[OESTE], U:[INDEFINIDO]
select * from open.GE_GEOGRA_SECTOR;
--TABLE CLASIFICACION DE SECTORES OPERATIVOS
select * from open.GE_OPERA_SEC_CLASSIF;
--TABLE SECTOR OPERATIVO POR ZONA
select * from open.GE_SECTOROPE_ZONA;
--TABLE PROPOSITO DE ELEMENTO DE MEDICION POR SECTOR DE SUMINISTRO
select * from open.IF_PROV_SECT_ELEMMEDI;
--TABLE Entidad de Relación entre la central de riesgo, sector y producto
select * from open.LD_CENTR_SECT_PROD;
--TABLE TABLA TEMPORAL PRODUCTOS POR SECTORES DE CENTRAL DE RIESGO ESPECÍFICO
select * from open.LD_PRODUCTSSECTTEMP;
--TABLE Relación Entre Sector y Producto
select * from open.LD_SECTOR_PRODUCT;
--TABLE Tipo de Sector
select * from open.LD_TYPE_SECTOR;
--TABLE OBTENCIÓN DEL SECTOR OPERATIVO DE LA ORDEN POR TIPO DE TRABAJO
select * from open.OR_GET_OPESEC_BY_TT;
--TABLE OBTENCIÓN DEL SECTOR OPERATIVO DE LA ORDEN POR CLASIFICACIÓN DEL TIPO DE TRABAJO
select * from open.OR_GET_OPESEC_BY_TTC;
--TABLE SECTOR OPERATIVO
select * from open.OR_OPERATING_SECTOR;
--TABLE TIPOS DE TRABAJO QUE PUEDE HACER DETERMINADA UNIDAD OPERATIVA EN UN SECTOR OPERATIVO DADO
select * from open.OR_OPSE_OPUNT_TSKTYP;
--TABLE SECTORES OPERATIVOS POR TIPO DE TRABAJO
select * from open.OR_TASKTYPE_OPERSECT;
--TABLE SECTORES OPERATIVOS POR ETAPA (editado) 
select * from open.PM_STAGE_OPER_SECTOR;
--TABLE ZONA POSTAL
select * from open.AB_ZIP_CODE;
--TABLE ZONA COMERCIAL
select * from open.GE_COMMERCIAL_ZONE;
--TABLE SECTOR OPERATIVO POR ZONA
select * from open.GE_SECTOROPE_ZONA;
--TABLE CLASIFICACIÓN DE LA ZONAS
select * from open.GE_ZONE_CLASSIF;
--TABLE CONFIGURACION DE ZONAS PARA FERIA
select * from open.LDC_COFZOFE;
--TABLE Datos Adicionales del Predio para zona nueva o saturada
select * from open.LDC_INFO_PREDIO;
--TABLE Unidades por zona para venta brilla
select * from open.LD_AVAILABLE_UNIT;
--TABLE ZONA OPERATIVA
select * from open.OR_OPERATING_ZONE;
--TABLE Rutas por Zona
select * from open.OR_ROUTE_ZONE;
--TABLE ZONAS POR BASES ADMINISTRATIVAS
select * from open.OR_ZONA_BASE_ADM;
