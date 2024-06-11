/*
 * Propiedad Intelectual OLSoftware S.A.S
 *
 * Script  : GE_ITEMS_DOCUMENTO.sql
 * RICEF   : 
 * Autor   : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
 * Fecha   : 14-05-2014
 * Descripcion : Consulta para dar soporte en la tabla LDCI_MESAENVWS, mensajes de integración.

 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
 * carlos.virgen  14-05-2014 Version inicial 
 
 -- Documentos:
-- Maestro:
GE_ITEMS_DOCUMENTO
-- Detalle					
GE_ITEMS_REQUEST

-- Paquete de integración LDCI_PKRESERVAMATERIAL

--GEITE / Operación / Items / Reserva de Items (ORSIP)
-- API de extracción de datos:
OS_GET_REQUESTS_REG -- Entrega todas las reservas pendientes
OS_GET_REQUEST      -- Entrega todas las posiciones por reservas
----------------------------------------------------------------------------------------------------
--GEITE / Operación / Items / Traslado de Items (ORPTM) 
OS_GET_TRANSIT_ITEM -- Entrega todos los items en transito de un Unidad Operativa de clasificación 11 - Proveedor Logistico.
 
**/



-- #Reservas #represados
select doc.ID_ITEMS_DOCUMENTO, typ.DOCUMENT_TYPE_ID,
       typ.DESCRIPTION, 
       doc.OPERATING_UNIT_ID, 
       ori.NAME, doc.DESTINO_OPER_UNI_ID, 
       des.NAME, doc.USER_ID, usr.MASK,
       doc.FECHA
       from OPEN.GE_ITEMS_DOCUMENTO doc,
            OPEN.GE_DOCUMENT_TYPE typ,
            OPEN.OR_OPERATING_UNIT ori,
            OPEN.OR_OPERATING_UNIT des,
												OPEN.SA_USER usr
      where doc.DOCUMENT_TYPE_ID = typ.DOCUMENT_TYPE_ID
        and doc.OPERATING_UNIT_ID = ori.OPERATING_UNIT_ID 
        and doc.DESTINO_OPER_UNI_ID = des.OPERATING_UNIT_ID
        and typ.DOCUMENT_TYPE_ID = 102
        and doc.USER_ID = usr.USER_ID
        and doc.OPERATING_UNIT_ID in (select doc.OPERATING_UNIT_ID 
                                         from OPEN.GE_ITEMS_DOCUMENTO doc,
                                              OPEN.GE_DOCUMENT_TYPE typ,
                                              OPEN.OR_OPERATING_UNIT ori,
                                              OPEN.OR_OPERATING_UNIT des
                                        where doc.DOCUMENT_TYPE_ID = typ.DOCUMENT_TYPE_ID
                                          and doc.OPERATING_UNIT_ID = ori.OPERATING_UNIT_ID 
                                          and doc.DESTINO_OPER_UNI_ID = des.OPERATING_UNIT_ID
                                          and typ.DOCUMENT_TYPE_ID = 102
                                      minus
                                      select OPERATING_UNIT_ID from OPEN.LDCI_CECOUNIOPER)
order by doc.OPERATING_UNIT_ID;






-- #Reservas #represados
select doc.ID_ITEMS_DOCUMENTO, typ.DOCUMENT_TYPE_ID,
       typ.DESCRIPTION, 
       doc.OPERATING_UNIT_ID, 
       ori.NAME, doc.DESTINO_OPER_UNI_ID, 
       des.NAME, doc.USER_ID, usr.MASK,
       doc.FECHA
       from OPEN.GE_ITEMS_DOCUMENTO doc,
            OPEN.GE_DOCUMENT_TYPE typ,
            OPEN.OR_OPERATING_UNIT ori,
            OPEN.OR_OPERATING_UNIT des,
												OPEN.SA_USER usr
      where doc.DOCUMENT_TYPE_ID = typ.DOCUMENT_TYPE_ID
        and doc.OPERATING_UNIT_ID = ori.OPERATING_UNIT_ID 
        and doc.DESTINO_OPER_UNI_ID = des.OPERATING_UNIT_ID
        and typ.DOCUMENT_TYPE_ID = 102
        and doc.USER_ID = usr.USER_ID
        and doc.OPERATING_UNIT_ID in (select doc.OPERATING_UNIT_ID 
                                         from OPEN.GE_ITEMS_DOCUMENTO doc,
                                              OPEN.GE_DOCUMENT_TYPE typ,
                                              OPEN.OR_OPERATING_UNIT ori,
                                              OPEN.OR_OPERATING_UNIT des
                                        where doc.DOCUMENT_TYPE_ID = typ.DOCUMENT_TYPE_ID
                                          and doc.OPERATING_UNIT_ID = ori.OPERATING_UNIT_ID 
                                          and doc.DESTINO_OPER_UNI_ID = des.OPERATING_UNIT_ID
                                          and typ.DOCUMENT_TYPE_ID = 102
                                      minus
                                      select OPERATING_UNIT_ID from OPEN.LDCI_CLVAUNOP)
order by doc.OPERATING_UNIT_ID;

-- Reporte de items en transito
 select  /*+ leading(or_uni_item_bala_mov)
           index(or_uni_item_bala_mov IDX_OR_UNI_ITEM_BALA_MOV01)
           index(ge_items_seriado PK_GE_ITEMS_SERIADO)
           index(ge_items PK_GE_ITEMS)
           index(ge_items_documento PK_GE_ITEMS_DOCUMENTO)*/
        OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO,
        TRUNC(MOVE_DATE) MOVE_DATE,
        GE_ITEMS.ITEMS_ID||' - '||GE_ITEMS.DESCRIPTION DESCRIPTION,
        GE_ITEMS.CODE CODE,
        OR_UNI_ITEM_BALA_MOV.AMOUNT,
        OR_UNI_ITEM_BALA_MOV.TOTAL_VALUE,
        GE_ITEMS_SERIADO.SERIE,
        OR_UNI_ITEM_BALA_MOV.TARGET_OPER_UNIT_ID OPERATING_UNIT_ID,
        OR_UNI_ITEM_BALA_MOV.USER_ID,
        OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID TARGET_OPER_UNIT_ID
  from  OPEN.OR_UNI_ITEM_BALA_MOV,
        OPEN.OR_OPE_UNI_ITEM_BALA,
        OPEN.GE_ITEMS_SERIADO,
        OPEN.GE_ITEMS,
        OPEN.GE_ITEMS_DOCUMENTO
 where  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = GE_ITEMS.ITEMS_ID
   and  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = OR_OPE_UNI_ITEM_BALA.ITEMS_ID
   and  OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID = OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID
   and  OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE = 'N' --or_boitemsmove.csbNeutralMoveType
   and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO = GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO
   and  OR_UNI_ITEM_BALA_MOV.SUPPORT_DOCUMENT = ' '
   and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_SERIADO = GE_ITEMS_SERIADO.ID_ITEMS_SERIADO (+)
   and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO = 30127
   and  GE_ITEMS.ITEMS_ID = 10007717;
   
select OR_UNI_ITEM_BALA_MOV.UNI_ITEM_BALA_MOV_ID,
       OR_UNI_ITEM_BALA_MOV.AMOUNT,
       ID_ITEMS_DOCUMENTO, 
       MOVE_DATE,
       OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID
  from OPEN.OR_UNI_ITEM_BALA_MOV
 where OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID = 1931
   and ITEMS_ID = 10007717;

			
			
select doc.ID_ITEMS_DOCUMENTO, typ.DESCRIPTION, doc.DOCUMENTO_EXTERNO, doc.OPERATING_UNIT_ID, doc.DESTINO_OPER_UNI_ID, mov.ITEMS_ID, mov.AMOUNT, mov.TOTAL_VALUE
 from open.GE_ITEMS_DOCUMENTO doc,
      open.GE_DOCUMENT_TYPE typ,
      open.OR_UNI_ITEM_BALA_MOV mov
    where doc.ID_ITEMS_DOCUMENTO = mov.ID_ITEMS_DOCUMENTO(+)
       and doc.DOCUMENT_TYPE_ID = typ.DOCUMENT_TYPE_ID
       and doc.ID_ITEMS_DOCUMENTO in (49559, 49777,49799,49773)
     order by doc.ID_ITEMS_DOCUMENTO;		
     
select * from 
  OPEN.GE_ITEMS_DOCUMENTO DOC, OPEN.GE_ITEMS_REQUEST REQ
 where trunc(FECHA) = trunc(SYSDATE)
   and DOC.ID_ITEMS_DOCUMENTO = REQ.ID_ITEMS_DOCUMENTO
   and DOC.OPERATING_UNIT_ID = 3208
   and REQ.ITEMS_ID = 4295604;   


   
 select POSI.ID_ITEMS_DOCUMENTO as "Documento" ,
        POSI.ITEMS_ID as "Item",
        POSI.REQUEST_AMOUNT as "Cantidad_Solicitada",
        POSI.CONFIRMED_AMOUNT as "Cantidad_Confirmada",
        ITEM.DESCRIPTION as "Descripción",
        ITEM.ITEM_CLASSIF_ID as "Clase_Item"
   from OPEN.GE_ITEMS_DOCUMENTO DOCU, 
        OPEN.GE_ITEMS_REQUEST POSI,
        OPEN.GE_ITEMS ITEM
   where DOCU.ID_ITEMS_DOCUMENTO in (25379 /*Identificador de la reserva*/)
     and DOCU.ID_ITEMS_DOCUMENTO = POSI.ID_ITEMS_DOCUMENTO 
     and POSI.ITEMS_ID = ITEM.ITEMS_ID;   
	 
	 
--Lista reserva de items de reservas 	 
select DOCU.OPERATING_UNIT_ID as "Unidad_Operativa",
        POSI.ID_ITEMS_DOCUMENTO as "Documento" ,
        POSI.ITEMS_ID as "Item",
        POSI.REQUEST_AMOUNT as "Cantidad_Solicitada",
        POSI.CONFIRMED_AMOUNT as "Cantidad_Confirmada",
        ITEM.DESCRIPTION as "Descripción",
        ITEM.ITEM_CLASSIF_ID as "Clase_Item"
   from OPEN.GE_ITEMS_DOCUMENTO DOCU, 
        OPEN.GE_ITEMS_REQUEST POSI,
        OPEN.GE_ITEMS ITEM
   where DOCU.ID_ITEMS_DOCUMENTO = DOCU.ID_ITEMS_DOCUMENTO
     and DOCU.ID_ITEMS_DOCUMENTO = POSI.ID_ITEMS_DOCUMENTO 
     and POSI.ITEMS_ID = ITEM.ITEMS_ID
     and DOCU.OPERATING_UNIT_ID in (1850);
	 
    
desc OPEN.GE_ITEMS_REQUEST;    
desc OPEN.GE_ITEMS;

select CCOP.OPERATING_UNIT_ID, BALA.ITEMS_ID, BALA.BALANCE, BALA.TOTAL_COSTS
  from OPEN.OR_OPERATING_UNIT OPUN, 
       OPEN.LDCI_CECOUNIOPER CCOP, 
       OPEN.LDCI_CLVAUNOP    CVOP,
       OPEN.OR_OPE_UNI_ITEM_BALA BALA 
where OPUN.OPERATING_UNIT_ID = CCOP.OPERATING_UNIT_ID
  and OPUN.OPERATING_UNIT_ID = CVOP.OPERATING_UNIT_ID
  and OPUN.OPERATING_UNIT_ID = BALA.OPERATING_UNIT_ID
  and BALA.TOTAL_COSTS > 100000;	
  
  
select OPUN.OPERATING_UNIT_ID, OPUN.NAME ,BALA.ITEMS_ID, BALA.BALANCE, BALA.TOTAL_COSTS
  from OPEN.OR_OPERATING_UNIT OPUN, 
       OPEN.OR_OPE_UNI_ITEM_BALA BALA 
where OPUN.OPERATING_UNIT_ID = BALA.OPERATING_UNIT_ID
  and BALA.TOTAL_COSTS > 0 /*indica que tiene saldo en bodega*/
  and OPUN.OPER_UNIT_CLASSIF_ID = 20 /*clasificaicon unidad operariva*/;	  
  
  
--#determina saldo de item en bodega
select OPUN.OPERATING_UNIT_ID, OPUN.NAME ,BALA.ITEMS_ID, BALA.BALANCE, BALA.TOTAL_COSTS
  from OPEN.OR_OPERATING_UNIT OPUN, 
       OPEN.OR_OPE_UNI_ITEM_BALA BALA 
where OPUN.OPERATING_UNIT_ID = BALA.OPERATING_UNIT_ID
  and OPUN.OPERATING_UNIT_ID = 1885
  and BALA.ITEMS_ID in (10007707, 10007717,10001258);  
  


--#Reservas confirmadas  
select REQ.ID_ITEMS_DOCUMENTO, REQ.ITEMS_ID, REQ.REQUEST_AMOUNT CANTIDAD_SOL, REQ.CONFIRMED_AMOUNT CANTIDAD_CONFIRMADA
from OPEN.GE_ITEMS_DOCUMENTO DOC, OPEN.GE_ITEMS_REQUEST REQ
 where trunc(FECHA) = trunc(FECHA)
   and DOC.ID_ITEMS_DOCUMENTO = REQ.ID_ITEMS_DOCUMENTO
   and DOC.OPERATING_UNIT_ID = 1002 /*Codigo de la unidad operativa*/
   and REQ.ITEMS_ID = 1000166 /*	codigo del item*/;
   
-- consulta documentos   
select * from 
  OPEN.GE_ITEMS_DOCUMENTO DOC, OPEN.GE_ITEMS_REQUEST REQ
 where trunc(FECHA) = trunc(FECHA)
   and DOC.ID_ITEMS_DOCUMENTO = REQ.ID_ITEMS_DOCUMENTO
   and DOC.OPERATING_UNIT_ID = 3015
   and DOC.ID_ITEMS_DOCUMENTO = 37016;      
   
select * from OPEN.LDCI_CLVAUNOP where OPERATING_UNIT_ID = 3015;
select * from OPEN.LDCI_CECOUNIOPER where OPERATING_UNIT_ID = 3015;   



select * 
  from open.OR_UNI_ITEM_BALA_MOV
 where ID_ITEMS_DOCUMENTO = 30763;













