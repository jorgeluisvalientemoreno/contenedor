--Identifdicar Accion
select gce.*, rowid
  from open.gr_config_expression gce
 where upper(gce.description) like
       upper('%VAL - MO_PROCESS.ADDRESS_MAIN_MOTIVE - Carga dir a instancia y valida ciclo del segmento%')
