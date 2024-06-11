--componentes compsesu

select c2.cmssidco    compomente,
       c2.cmsssesu    producto,
       c2.cmssescm    Estado_Componente,
       c3.description Desc_Estado_Componente,
       c2.cmssfein    Fecha_Instalacion
  From open.compsesu c2
 Inner join open.ps_product_status c3 on c2.cmssescm = c3.product_status_id
 Where c2.cmsssesu in (52659980);

--componentes pr_component

select pc.component_id    compomente,
       pc.product_id    producto,
       pc.component_status_id    Estado_Componente,
       c3.description Desc_Estado_Componente,
       pc.service_date Fecha_Instalacion,
       pc.last_upd_date  Fecha_modificacion,
       pc.mediation_date  Fecha_mediador
  From open.pr_component pc
 Inner join open.ps_product_status c3 on pc.component_status_id = c3.product_status_id
 Where pc.product_id in (52659980);
