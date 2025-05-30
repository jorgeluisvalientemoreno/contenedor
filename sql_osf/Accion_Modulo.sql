--Regla x Accion
select gce.*, rowid
  from open.gr_config_expression gce
 where gce.config_expression_id in (select gam.config_expression_id
  from open.ge_action_module gam
 where upper(gam.description) like
       upper('Realiza la atenci%n de una suspensi%n voluntaria de un producto'));


--Regla 
select gce.*, rowid
  from open.gr_config_expression gce
 where upper(gce.description) like
       upper('%ValidaCausalGeneraOrdenSuspCDMSeguridadMtto%');

--Identificar Accion x Regla
select gam.*
  from OPEN.GE_ACTION_MODULE gam
 where gam.config_expression_id in
       (select gce.config_expression_id
          from open.gr_config_expression gce
         where --gce.config_expression_id = 121329895
         upper(gce.description) like '%EVE-POST-MOT%');

--Accion(Modulo)
select gam.*
  from open.ge_action_module gam
 where upper(gam.description) like
       upper('Realiza la atenci%n de una suspensi%n voluntaria de un producto');

---Accion(Modulo) - Regla
select gce.*, rowid
  from open.gr_config_expression gce
 where gce.config_expression_id in (select gam.config_expression_id
                                      from open.ge_action_module gam
                                     where upper(gam.description) like
                                           upper('Atiende la Solicitud de Cambio de Uso del Servicio')
                                    --'Generar/Financiar Factura de la Solicitud')
                                    );

--Identifdicar Accion
select gam.action_id Codig_Accion,
       gam.module_id || ' - ' || gm.description Codigo_Modulo,
       gam.config_expression_id Codigo_Regla,
       gam.description Descipcion,
       decode(gam.exe_at_status_change, 'Y', 'SI:[Y]', 'N', 'NO:[N]') Ejecutar_durante_cambio_estado,
       decode(gam.exe_transition_state, 'Y', 'SI:[Y]', 'N', 'NO:[N]') Ejecuta_transicion_estados
  from open.ge_action_module gam
  left join open.ge_module gm
    on gam.module_id = gm.module_id
 where upper(gam.description) like upper('%Registro%Orden%');

--Identifdicar Regla de la accion
select gce.config_expression_id Codig_Regla,
       gce.configura_type_id || ' - ' || gct.description Tipo_Configuracion,
       gce.expression Expresion,
       gce.author Autor,
       gce.creation_date Fecha_Creacion,
       gce.generation_date Fecha_Generacion,
       gce.last_modifi_date Fecha_Ultima_modificacion,
       Decode(gce.status, 'R', 'Registrado', 'G', 'Generado', 'Recompilado') Estado,
       decode(gce.used_other_expresion, 'Y', 'Y - Si', 'N - No') Utilizada_Por_Otra_Regla,
       decode(gce.modification_type, 'PU', 'PU:[Publica]', 'PR:[Private]') Tipo_Modificacion,
       gce.password Password_Tipo_Es_Privado,
       decode(gce.execution_type,
              'EI',
              'EI:[Ejecucion Inhmediata]',
              'DS:[Dbms Sql]',
              '',
              '') Tipo_Ejecucion,
       gce.description Descipcion,
       gce.object_name Nombre,
       decode(gce.object_type, 'PP', 'PP - Procedimiento', 'PF - Funcion') Tipo_objecto,
       gce.code Codigo
  from open.gr_config_expression gce
  left join OPEN.GR_CONFIGURA_TYPE GCT
    on gct.configura_type_id = gce.configura_type_id
 where gce.config_expression_id in
       (select gam.config_expression_id
          from open.ge_action_module gam
         where upper(gam.description) like upper('%EVE-POST-MOT%')
        --'Generar/Financiar Factura de la Solicitud')
        );
