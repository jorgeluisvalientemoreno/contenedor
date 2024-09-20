SELECT  CT.id_contratista CONTR, 
            (select PAIS.GEO_LOCA_FATHER_ID from ge_geogra_location PAIS WHERE PAIS.GEOGRAP_LOCATION_ID IN (select DPTO.GEO_LOCA_FATHER_ID from ge_geogra_location DPTO WHERE DPTO.GEOGRAP_LOCATION_ID = AD.geograp_location_id)) PAIS, 
            (select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = AD.geograp_location_id) DPTO, 
            AD.geograp_location_id LOCA, 
            Decode(ldci_pkinterfazactas.fnuGetTipoTrab(AD.ID_ORDEN),0, OT.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(AD.ID_ORDEN)) TT, 
            2015, 
            2, 
            DECODE(SIGN(Round(Sum(AD.valor_total))),-1,'C','D') SIGNO, 
            ABS(Round(Sum(AD.valor_total))) VALOR, 
            ldci_pkinterfazactas.fvaGetCuGaCoClasi(AD.id_orden) CTA, 
            ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(AD.ID_ORDEN),0, 
            OT.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(AD.ID_ORDEN))) CLACONT, 
            null 
      FROM ge_detalle_acta AD ,ge_items IT, 
           ge_acta AC,ge_contrato CO, 
           ge_subscriber GS,ge_contratista CT, 
           or_order OT 
     WHERE IT.items_id        = AD.id_items 
       AND AD.id_acta         = AC.id_acta 
       AND CO.id_contrato     = AC.id_contrato 
       AND CT.subscriber_id   = GS.subscriber_id 
       AND CO.id_contratista  = CT.id_contratista 
       AND OT.order_id        = AD.id_orden 
       AND AD.valor_total     <> 0 
       AND IT.item_classif_id <> 23 
       AND ac.extern_invoice_num IS NULL   
       AND trunc(OT.legalization_date)  BETWEEN NVL(null,trunc(OT.legalization_date)) AND NVL('28-02-2015',trunc(OT.legalization_date)) 
     GROUP BY AD.geograp_location_id, 
              CT.id_contratista, 
              OT.task_type_id, 
              ldci_pkinterfazactas.fvaGetCuGaCoClasi(AD.id_orden), 
              ldci_pkinterfazactas.fnuGetTipoTrab(AD.id_orden), 
              ldci_pkinterfazactas.fvaGetCuGaCoClasi(AD.id_orden) 
 
     UNION ALL 

     SELECT CT.id_contratista  CONTR, 
            (SELECT PAIS.GEO_LOCA_FATHER_ID from ge_geogra_location PAIS WHERE PAIS.GEOGRAP_LOCATION_ID IN (select DPTO.GEO_LOCA_FATHER_ID from ge_geogra_location DPTO WHERE DPTO.GEOGRAP_LOCATION_ID = AD.geograp_location_id)) PAIS, 
            (select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = AD.geograp_location_id) DPTO, 
            AD.geograp_location_id LOCA, 
            Decode(ldci_pkinterfazactas.fnuGetTipoTrab(OT.order_id),0, OT.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(OT.order_id)) TT, 
            2015, 
            2, 
            DECODE(SIGN(Round(Sum(oi.Value))),-1,'C','D') SIGNO, 
            to_number(ABS(Round(Sum(oi.Value)))) VALOR, 
            ldci_pkinterfazactas.fvaGetCuGaCoClasi(OT.order_id) CTA, 
            ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(OT.order_id),0, 
                                                        OT.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(OT.order_id))) CLACONT, 
            '28-02-2015' 
      FROM or_order OT, 
           or_order_activity OA, 
           ab_address AD, 
           or_operating_unit OU, 
           ge_contratista CT, 
           or_order_items OI, 
           ge_items IT 
     WHERE OT.order_id           = OA.order_id 
       AND IT.items_id           = OI.items_id 
       AND OA.address_id         = AD.address_id 
       AND OU.operating_unit_id  = OT.operating_unit_id 
       AND ou.es_externa       = 'Y'  
       AND OT.order_status_id    = 8  
       AND OU.contractor_id      = CT.id_contratista 
       AND OT.is_pending_liq     = 'Y' 
       AND IT.item_classif_id NOT IN (8,21) 
       AND oi.value              <>  0 
       AND oi.order_id           =  OT.order_id 
       AND trunc(OT.legalization_date)  BETWEEN NVL(null,trunc(OT.legalization_date)) AND NVL('28-02-2015',trunc(OT.legalization_date)) 
    GROUP BY CT.id_contratista, 
             AD.geograp_location_id, 
             OT.task_type_id, 
             ldci_pkinterfazactas.fvaGetCuGaCoClasi(OT.order_id), 
             ldci_pkinterfazactas.fnuGetTipoTrab(OT.order_id), 
             ldci_pkinterfazactas.fvaGetCuGaCoClasi(OT.order_id)
