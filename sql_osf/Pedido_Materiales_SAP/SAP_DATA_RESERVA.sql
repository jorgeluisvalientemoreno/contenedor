-- reseva documento SAP 
select GID.ID_ITEMS_DOCUMENTO RESERVA_SAP,
       GID.DOCUMENT_TYPE_ID TIPO_RESERVA,
       GID.DOCUMENTO_EXTERNO DOCUMENTO_EXTERNO_OSF,
       DECODE(GID.ESTADO,
              'R',
              'R - REGISTRADO',
              'A',
              'A - ABIERTO',
              'C',
              'C - CERRADO',
              'E',
              'E - EXPORTADO',
              GID.ESTADO) ESTADO_DOCUMENTO,
       GID.OPERATING_UNIT_ID || ' - ' || UNIDADORIGEN.NAME UNIDAD_ORIGEN,
       GID.DESTINO_OPER_UNI_ID || ' - ' || UNIDADDESTINO.NAME UNIDAD_DESTINO,
       GID.COMENTARIO COMENTARIO,
       GID.CAUSAL_ID || ' - ' || gc.description CAUSAL,
       GID.DELIVERY_DATE FECHA_DESPACHO,
       GIR.ITEMS_ID || ' - ' || GI.DESCRIPTION Item,
       GIR.REQUEST_AMOUNT Cantidad_solicitan,
       GIR.UNITARY_COST costo_unitario,
       GIR.CONFIRMED_AMOUNT cantidad_entrega,
       GIR.REJECTED_AMOUNT cantidad_rechazada,
       GIR.ACCEPTED_AMOUNT cantidad_aceptada,
       GIR.CONFIRMED_COST costo_confirmado,
       gis.serie SERIE,
       decode(gis.estado_tecnico,
              'N',
              'N - NUEVO',
              'R',
              'R - REACONDICIONADO',
              'D',
              'D - DAÑADO',
              gis.estado_tecnico) estado_tecnico,
       gis.id_items_estado_inv || ' - ' || giei.descripcion Estado_Inventario,
       DECODE(gis.propiedad,
              'E',
              'E - EMPRESA',
              'T',
              'T - TERCERO',
              'C',
              'C - TRAIDO POR CLIENTE',
              'V',
              'V - VENDIDO AL CLIENTE',
              gis.propiedad) Propietario,
       gis.fecha_ingreso fecha_ingreso,
       gis.fecha_salida fecha_salida,
       gis.fecha_reacon fecha_reacondicionado,
       gis.fecha_baja fecha_baja,
       gis.fecha_garantia fecha_garantia,
       gis.operating_unit_id || ' - ' || UNIDADASOCIADA.NAME unidad_asociada,
       gis.subscriber_id || ' - ' || trim(gs.subscriber_name) || ' ' ||
       trim(gs.subs_last_name) Cliente
  from GE_ITEMS_DOCUMENTO GID
  left join OPEN.GE_ITEMS_REQUEST GIR
    on GIR.ID_ITEMS_DOCUMENTO = GID.ID_ITEMS_DOCUMENTO
  left join open.or_operating_unit UNIDADORIGEN
    on UNIDADORIGEN.OPERATING_UNIT_ID = GID.OPERATING_UNIT_ID
  left join open.or_operating_unit UNIDADDESTINO
    on UNIDADDESTINO.OPERATING_UNIT_ID = GID.DESTINO_OPER_UNI_ID
  left join open.GE_CAUSAL gc
    on gc.causal_id = gid.causal_id
  left join open.GE_ITEMS GI
    on gi.items_id = GIR.ITEMS_ID
  left join open.ge_items_seriado gis
    on gis.items_id = GIR.items_id
   and 'S' = &ValidaSeriado
  left join open.GE_ITEMS_ESTADO_INV giei
    on giei.id_items_estado_inv = gis.id_items_estado_inv
  left join open.or_operating_unit UNIDADASOCIADA
    on UNIDADASOCIADA.OPERATING_UNIT_ID = gis.operating_unit_id
  left join OPEN.GE_SUBSCRIBER gs
    on gs.subscriber_id = gis.subscriber_id
 where GID.ID_ITEMS_DOCUMENTO = &ReservaSAP;
