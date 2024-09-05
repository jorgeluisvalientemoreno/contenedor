--Se identifica una bodega con materiales de inventario.
SELECT b.operating_unit_id Unidad, b.items_id,UO.NAME DESC_UNI,uo.es_externa Externa, b.items_id Item,
       it.description DESC_ITEM,       it.item_classif_id Clas, b.quota,b.balance,
       (select LAOUIB.Balance from OPEN.LDC_ACT_OUIB LAOUIB where LAOUIB.Items_Id = b.items_id and LAOUIB.Operating_Unit_Id = b.operating_unit_id ) Cant_act,
       (select LIOUIB.Balance from OPEN.LDC_INV_OUIB LIOUIB where LIOUIB.Items_Id = b.items_id and LIOUIB.Operating_Unit_Id = b.operating_unit_id ) Cant_inv,
       b.total_costs Costo_total,
       (select LAOUIB.Total_Costs from OPEN.LDC_ACT_OUIB LAOUIB where LAOUIB.Items_Id = b.items_id and LAOUIB.Operating_Unit_Id = b.operating_unit_id ) Cost_act,
       (select LIOUIB.Total_Costs from OPEN.LDC_INV_OUIB LIOUIB where LIOUIB.Items_Id = b.items_id and LIOUIB.Operating_Unit_Id = b.operating_unit_id ) Cost_inv,
       b.transit_in,
       b.transit_out,
       CASE NVL(uo.contractor_id, 0)
         WHEN 0 THEN
          'N'
         ELSE
          'S'
       END Es_contratista,
       b.total_costs costo_general,
       b.balance balance_general,
       b.transit_in transito_entrada,
       b.transit_out transito_salida
  FROM open.OR_OPE_UNI_ITEM_BALA b,
       open.ge_items             it,
       open.or_operating_unit    uo
 WHERE b.items_id = it.items_id
   AND uo.operating_unit_id = b.operating_unit_id
   AND b.operating_unit_id = 2680
   AND b.items_id IN (10000088,10004070,10000228,10000345);

--Se crea una requisición para inventario desde OSF a SAP
--Mediante GEITE/Operacion/Items/Requision de Items 
--Se regitra el tralado Ejemplo
--unidad de trabajo 2680
--unidad proveedora 1773
--Item a solicitar 10004170 y las cantidad pueden ser de 2 a 10.

--Se procesa la requision del envio de OSF a SAP
--Original
/*set serveroutput on*/
declare
 osbMesjErr varchar2(3000);
 ol_Payload CLOB;
 sesion number;
begin
  DBMS_OUTPUT.PUT_LINE('inicia el proceso pl_movimiento_material.sql');
  
  --"OPEN".LDCI_PKPEDIDOVENTAMATERIAL.PRONOTIFICASOLICITUDESERP;  -- Envia Solicitudes y Devoluciones de Pedidos de Venta de OSF a SAP
  --"OPEN".LDCI_PKMOVIVENTMATE.proConfirmarSolicitud(-1);         -- Procesa Movimientos de Pedidos de Venta de SAP en OSF
  lDCI_PKRESERVAMATERIAL.proNotificaDocumentosERP;       -- Servicio para el Envio relacionado a un despacho y Devoluciones de Reservas de OSF a SAP  
  /*SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  LDCI_PKMOVIMATERIAL.proConfirmarSolicitud(25717);         -- Procesa Movimiento de Reservas de SAP en OSF*/
  
  DBMS_OUTPUT.PUT_LINE('osbMesjErr: ' || osbMesjErr);     
  DBMS_OUTPUT.PUT_LINE('termina el proceso pl_movimiento_material.sql');  
  commit;
exception
   when others then
       DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
       DBMS_OUTPUT.PUT_LINE('Backtrace:' || DBMS_UTILITY.format_error_backtrace);
end;
/

--Actualizado
declare
 osbMesjErr varchar2(3000);
 ol_Payload CLOB;
 sesion number;
begin
  DBMS_OUTPUT.PUT_LINE('inicia el proceso pl_movimiento_material.sql');

  lDCI_PKRESERVAMATERIAL.proNotificaDocumentosERP;       -- Servicio para el Envio relacionado a un despacho y Devoluciones de Reservas de OSF a SAP  
  
  DBMS_OUTPUT.PUT_LINE('osbMesjErr: ' || osbMesjErr);     
  DBMS_OUTPUT.PUT_LINE('termina el proceso pl_movimiento_material.sql');  
  commit;
exception
   when others then
       DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
       DBMS_OUTPUT.PUT_LINE('Backtrace:' || DBMS_UTILITY.format_error_backtrace);
end;
/


--Se le informa a SAP (Adriana Pastrana) de la requision, cuando ella realice el despacho desde SAP

--Se valida el despacho de la requision de SAP a OSF, el campo MMITDSAP debe tener un codigo que proviene de SAP
select a.*, rowid from OPEN.LDCI_INTEMMIT a where a.mmitfecr > trunc(sysdate)

--Se procesa el despacho de SAP teniendo un codigo de SAP
declare
 osbMesjErr varchar2(3000);
 ol_Payload CLOB;
 sesion number;
begin
  DBMS_OUTPUT.PUT_LINE('inicia el proceso pl_movimiento_material.sql');
  
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  LDCI_PKMOVIMATERIAL.proConfirmarSolicitud(-1);         -- Procesa Movimiento de Reservas de SAP en OSF
  
  DBMS_OUTPUT.PUT_LINE('osbMesjErr: ' || osbMesjErr);     
  DBMS_OUTPUT.PUT_LINE('termina el proceso pl_movimiento_material.sql');  
  commit;
exception
   when others then
       DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
       DBMS_OUTPUT.PUT_LINE('Backtrace:' || DBMS_UTILITY.format_error_backtrace);
end;
/

--En el caso que despues de procesar el despacho y se valide el balance de bodeag de la unidad no se refleja la cantidad solciitaad en SAP 
--y no tenga ningún balance se debe validar la entidad para establecer los intentos y el error que se genera, esto se hace con sentencia inicial 
select *
    from LDCI_INTEMMIT
    where MMITCODI = 101255--inuSERIMMIT;


--Si se proceso la requision de forma exitosa. Se valida la bodega, esto se hace con sentencia inicial 
--Se validan los seriles esten relacionados a la unidad que realizo el despacho.
SELECT /*+  ORDERED 
          INDEX(GE_ITEMS_TIPO PK_GE_ITEMS_TIPO) 
            INDEX(GE_ITEMS IX_GE_ITEMS13)
        */

 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO ID_ITEMS_SERIADO,
 decode(GE_ITEMS_SERIADO.ITEMS_ID,
        null,
        null,
        DAGE_ITEMS.fsbGetCode(GE_ITEMS_SERIADO.ITEMS_ID) || ' - ' ||
        DAGE_ITEMS.fsbGetDescription(GE_ITEMS_SERIADO.ITEMS_ID)) ITEMS_ID,
 decode(GE_ITEMS.ID_ITEMS_TIPO,
        null,
        null,
        GE_ITEMS.ID_ITEMS_TIPO || ' - ' ||
        DAGE_ITEMS_TIPO.fsbGetDescripcion(GE_ITEMS.ID_ITEMS_TIPO)) ID_ITEMS_TIPO,
 GE_ITEMS.ITEM_CLASSIF_ID || ' - ' ||
 DAGE_ITEM_CLASSIF.fsbGetDescription(GE_ITEMS.ITEM_CLASSIF_ID) ID_ITEMS_CLASIF,
 GE_ITEMS_SERIADO.SERIE SERIE,
 decode(GE_ITEMS_SERIADO.ESTADO_TECNICO,
        'N',
        'Nuevo',
        'R',
        'Reacondicionado',
        'D',
        'Da¿ado') ESTADO_TECNICO,
 decode(GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV,
        null,
        null,
        GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV || ' - ' ||
        DAGE_ITEMS_ESTADO_INV.fsbGetDescripcion(GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV)) ID_ITEMS_ESTADO_INV,
 GE_ITEMS_SERIADO.COSTO COSTO,
 GE_ITEMS_SERIADO.SUBSIDIO SUBSIDIO,
 decode(GE_ITEMS_SERIADO.PROPIEDAD,
        'E',
        'Empresa',
        'T',
        'Tercero',
        'C',
        'Cliente',
        'V',
        'Vendido al cliente') PROPIEDAD,
 GE_ITEMS_SERIADO.FECHA_INGRESO FECHA_INGRESO,
 GE_ITEMS_SERIADO.FECHA_SALIDA FECHA_SALIDA,
 GE_ITEMS_SERIADO.FECHA_REACON FECHA_REACON,
 decode(GE_ITEMS_SERIADO.FECHA_GARANTIA,
        null,
        (SELECT /*+ INDEX (ge_item_warranty IDX_GE_ITEM_WARRANTY01)*/
          max(ge_item_warranty.final_warranty_date)
           FROM ge_item_warranty
          WHERE ge_item_warranty.serie = GE_ITEMS_SERIADO.Serie
            AND ge_item_warranty.is_active = 'Y'),
        GE_ITEMS_SERIADO.FECHA_GARANTIA) FECHA_GARANTIA,
 decode(GE_ITEMS_SERIADO.OPERATING_UNIT_ID,
        null,
        null,
        GE_ITEMS_SERIADO.OPERATING_UNIT_ID || ' - ' ||
        DAOR_Operating_Unit.fsbGetName(GE_ITEMS_SERIADO.OPERATING_UNIT_ID)) OPERATING_UNIT_ID,
 (select NUMERO_SERVICIO
    FROM GE_EMPAQUETAMIENTO
   WHERE GE_EMPAQUETAMIENTO.id_items_seriado =
         GE_ITEMS_SERIADO.id_items_seriado) NUMERO_SERVICIO,
 (select VALID_UNTIL
    FROM OR_ITEM_PATTERN
   WHERE OR_ITEM_PATTERN.id_items_seriado =
         ge_items_seriado.id_items_seriado
     AND OR_ITEM_PATTERN.valid_until >= trunc(sysdate)) VALID_UNTIL,
 (select b.SERIE
    FROM GE_ASSO_SERIAL_ITEMS a, GE_ITEMS_SERIADO b
   WHERE a.SERIAL_ITEMS_ID = b.id_items_seriado
     AND a.asso_serial_items_id = GE_ITEMS_SERIADO.id_items_seriado) SERIAL_ITEMS,
 decode(GE_ITEMS_SERIADO.SUBSCRIBER_ID,
        null,
        null,
        DAGE_subscriber.fsbGetIdentification(GE_ITEMS_SERIADO.SUBSCRIBER_ID)) SUBSCRIBER_ID,
 decode(GE_BOItemsSeriado.fsbIsPattern(GE_ITEMS_SERIADO.ID_ITEMS_SERIADO),
        'Y',
        'Si',
        'No') IS_PATTERN
  FROM GE_ITEMS_SERIADO, GE_ITEMS, GE_ITEMS_TIPO, OR_ITEM_PATTERN
 WHERE GE_ITEMS.id_items_tipo = 20
   and GE_ITEMS_SERIADO.ITEMS_ID = GE_ITEMS.ITEMS_ID
   AND GE_ITEMS.ID_ITEMS_TIPO = GE_ITEMS_TIPO.ID_ITEMS_TIPO
   AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
       OR_ITEM_PATTERN.ID_ITEMS_SERIADO(+)
       and        GE_ITEMS_SERIADO.Operating_Unit_Id = 2680



---Se realiza traslado y/o devoluion del inventario realizado en la requision
--Se crea una requisición para inventario desde OSF a SAP
--Mediante GEITE/Operacion/Items/traslado de Items 
--Se regitra el tralado Ejemplo
--unidad de trabajo 2680
--unidad proveedora 1773
--Causal            Traslado de inventario
--Item a trasladar 10004170 y retornamos la cantidad de seriales.

--Se envía el traslado de OSF a SAP 
declare
 osbMesjErr varchar2(3000);
 ol_Payload CLOB;
 sesion number;
begin
  DBMS_OUTPUT.PUT_LINE('inicia el proceso pl_movimiento_material.sql');

  lDCI_PKRESERVAMATERIAL.proNotificaDocumentosERP;       -- Servicio para el Envio relacionado a un despacho y Devoluciones de Reservas de OSF a SAP  
  
  DBMS_OUTPUT.PUT_LINE('osbMesjErr: ' || osbMesjErr);     
  DBMS_OUTPUT.PUT_LINE('termina el proceso pl_movimiento_material.sql');  
  commit;
exception
   when others then
       DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
       DBMS_OUTPUT.PUT_LINE('Backtrace:' || DBMS_UTILITY.format_error_backtrace);
end;
/

--Se valida bodega disminuyendo la cantidad de inventario y en el campo de salida igual a la cantidad de seriales trasladado de la bodega.
---Adriana despacha con el código del traslado generado por el traslado anterior
--Se valida el despacho de la requision de SAP a OSF, el campo MMITDSAP debe tener un codigo que proviene de SAP
select a.*, rowid from OPEN.LDCI_INTEMMIT a where a.mmitfecr > trunc(sysdate)
--o la sentecia
select *
    from LDCI_INTEMMIT
    where MMITCODI = 101255--inuSERIMMIT;


--Se procesa el despacho que realiza Adriana por SAP a OSF.
declare
 osbMesjErr varchar2(3000);
 ol_Payload CLOB;
 sesion number;
begin
  DBMS_OUTPUT.PUT_LINE('inicia el proceso pl_movimiento_material.sql');
  
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  LDCI_PKMOVIMATERIAL.proConfirmarSolicitud(-1);         -- Procesa Movimiento de Reservas de SAP en OSF
  
  DBMS_OUTPUT.PUT_LINE('osbMesjErr: ' || osbMesjErr);     
  DBMS_OUTPUT.PUT_LINE('termina el proceso pl_movimiento_material.sql');  
  commit;
exception
   when others then
       DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
       DBMS_OUTPUT.PUT_LINE('Backtrace:' || DBMS_UTILITY.format_error_backtrace);
end;

--Se valida si procesa sin novedad
        select *
          from LDCI_INTEMMIT
         inner join LDCI_DMITMMIT
            on DMITMMIT = MMITCODI
           and MMITTIMO in ('Z02','Z14')--(isbDevoMate, isbClasDevMatAct)
         inner join LDCI_SERIDMIT
            on SERIMMIT = MMITCODI
           and SERIDMIT = Dmitcodi
         inner join ge_items_seriado gis
            on gis.items_id = LDCI_DMITMMIT.DMITITEM
           and gis.serie = Serinume
           --and gis.operating_unit_id is not null
         where MMITCODI = 101257--inuSERIMMIT;

--Se valida la bodega quedó correcta.
--La sentencia inicial donde ya bno exista items de salida y que no ese en el balanace

---Se validan los seriales devueltos y sin unidad.
select gis.* from OPEN.LDCI_SERIDMIT a, open.ge_items_seriado gis where gis.serie = a.serinume and a.serimmit = 101257;


---Otras consultas
select mmitcodi, mmitdsap, mmitesta, mmittimo, mmitinte,mmitmens, mmitfecr, dmititem, dmitcant, dmitcoun, dmitcant*dmitcoun
from open.ldci_intemmit i 
inner join ldci_dmitmmit d on d.dmitmmit=i.mmitcodi
where mmitfecr>=trunc(sysdate)
and mmitdsap='4900220919';

select *
from ldci_seridmit
inner join ge_items_seriado s on serinume=serie
where serimmit=99246


