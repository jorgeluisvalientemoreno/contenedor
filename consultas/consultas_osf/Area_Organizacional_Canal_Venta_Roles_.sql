--AREA ORGANIZACIONAL X CANALES DE VENTA POR VENDEDOR 
SELECT a.organizat_area_id || ' - ' || a.name_
  FROM open.ge_organizat_area a, open.cc_orga_area_seller b
 WHERE a.organizat_area_id = b.organizat_area_id
   AND b.person_id = 19081;

---Roles por actividad
select *
  from open.or_actividades_rol a
 where a.id_actividad in (4295392, 100008473, 4000380);

---Rol X unidad operativa
select * from open.or_rol_unidad_trab w where w.id_unidad_operativa = 3628;

--
select * from open.GE_DISTRIBUT_ADMIN;
