--Intraccion sin flujos
select t.*, t.rowid
  from open.LDC_INTERACCION_SIN_FLUJO t
 order by t.created_at desc;
--Estado de la interaccion
select mp.package_id Interaccion,
       t.Procesado,
       a.motive_status_id || ' - ' || a.description Estado_Interaccion
  from open.mo_packages mp
 INNER JOIN open.LDC_INTERACCION_SIN_FLUJO t
    ON mp.package_id = t.package_id
 inner join open.ps_motive_status a
    on mp.motive_status_id = a.motive_status_id;

--Estado de la interaccion
select t.parcial,
       t.Procesado,
       a.motive_status_id || ' - ' || a.description Estado_Interaccion,
       count(1) CANTIDAD
  from open.mo_packages mp
 INNER JOIN open.LDC_INTERACCION_SIN_FLUJO t
    ON mp.package_id = t.package_id
 inner join open.ps_motive_status a
    on mp.motive_status_id = a.motive_status_id
 group by t.parcial,
          t.Procesado,
          a.motive_status_id || ' - ' || a.description;
