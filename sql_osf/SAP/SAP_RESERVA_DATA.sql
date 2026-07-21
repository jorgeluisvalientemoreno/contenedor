--Pedido LDCISOMA
select TSM.TRSMCODI Codigo_FRONT,
       TSM.TRSMCONT || ' - ' || gc.nombre_contratista Contratista,
       TSM.TRSMPROV || ' - ' || OOUPROVEEDOR.NAME Proveedor,
       TSM.TRSMUNOP || ' - ' || OOUUNIDADDESTINO.NAME Unidad_Destino,
       TSM.TRSMFECR Fecha_Creacion,
       DECODE(TSM.TRSMESTA,
              1,
              '1 - Creado',
              2,
              '2 - Enviado',
              3,
              '3 - Recibido',
              4,
              '4 - Anulado',
              5,
              '5 - EN ESPERA DE APROBACION',
              6,
              '6 - APROBADO',
              7,
              '7 - DEVUELTO',
              8,
              '8 - RECHAZAR'),
       TSM.TRSMOFVE Oficina_Venta,
       --TSM.TRSMVTOT,
       --TSM.TRSMDORE,
       --TSM.TRSMDSRE,
       --TSM.TRSMMDPE,
       TSM.TRSMUSMO Usuario,
       --TSM.TRSMMPDI,
       --TSM.TRSMACTI,
       --TSM.TRSMSOL,
       DECODE(TSM.TRSMTIPO, 1, '1 - Solicitud', 2, '2 - Devolucion') Tipo_Pedido,
       --TSM.TRSMPROG,
       --TSM.ORDER_ID,
       TSM.TRSMOBSE Observacion,
       TSM.TRSMCOME Comentario_Rechazo
  from OPEN.LDCI_TRANSOMA TSM
  left join OPEN.GE_CONTRATISTA gc
    on gc.id_contratista = tsm.trsmcont
  left join OPEN.OR_OPERATING_UNIT OOUPROVEEDOR
    on OOUPROVEEDOR.OPERATING_UNIT_ID = tsm.trsmprov
  left join OPEN.OR_OPERATING_UNIT OOUUNIDADDESTINO
    on OOUUNIDADDESTINO.OPERATING_UNIT_ID = tsm.trsmunop
 where TSM.TRSMUSMO = 'DORMEN'
 order by TSM.TRSMFECR DESC;

select GID.*, rowid
  from OPEN.GE_ITEMS_DOCUMENTO GID
 where 1 = 1
      --and GID.ID_ITEMS_DOCUMENTO = &ReservaSAP
   and GID.user_id in
       (select sa.user_id
          from OPEN.SA_USER sa
         where upper(sa.mask) = upper('DORMEN'))
 order by gid.fecha desc;

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
  from open.GE_ITEMS_DOCUMENTO GID
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
 where 1 = 1
      --and GID.ID_ITEMS_DOCUMENTO = &ReservaSAP
   and gid.user_id in
       (select a.user_id
          from OPEN.SA_USER a
         where upper(a.mask) = upper('DORMEN'))
 order by gid.fecha desc;
