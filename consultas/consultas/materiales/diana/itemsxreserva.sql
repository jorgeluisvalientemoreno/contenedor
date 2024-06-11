select POSI.ID_ITEMS_DOCUMENTO as "Documento" ,
        POSI.ITEMS_ID as "Item",
        POSI.REQUEST_AMOUNT as "Cantidad_Solicitada",
        POSI.CONFIRMED_AMOUNT as "Cantidad_Confirmada",
        ITEM.DESCRIPTION as "Descripción",
        ITEM.ITEM_CLASSIF_ID as "Clase_Item"
   from OPEN.GE_ITEMS_DOCUMENTO DOCU, 
        OPEN.GE_ITEMS_REQUEST POSI,
        OPEN.GE_ITEMS ITEM
   where DOCU.ID_ITEMS_DOCUMENTO in (25680 /*Identificador de la reserva*/)
     and DOCU.ID_ITEMS_DOCUMENTO = POSI.ID_ITEMS_DOCUMENTO 
     and POSI.ITEMS_ID = ITEM.ITEMS_ID;
