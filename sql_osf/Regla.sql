--Identifdicar Accion
select gce.*, rowid 
  from open.gr_config_expression gce 
 where gce.config_expression_id in 
       (select gam.config_expression_id 
         from open.ge_action_module gam
         where upper(gam.description) like 
               upper( 
               '%Registro%Orden%')) 
               --'Generar/Financiar Factura de la Solicitud')) 
