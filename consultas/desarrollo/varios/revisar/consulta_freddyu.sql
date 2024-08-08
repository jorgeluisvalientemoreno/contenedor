SELECT Enc.Orden_padre,
           Enc.Causal_padre,
           Enc.ini_ejec_padre ini_ejec_padre,
           Enc.fin_ejec_padre fin_ejec_padre,
           Enc.observ_padre,
           Enc.tecnico_padre,
           Enc.XMLOrdenesdatosAdpa,
           Det.TipoTrabAdic,
           Det.activAdic,
           Det.Causal_Ot_Adic,
           Det.observaAdic,
           Det.Tecnico_Ot_Adic,
           det.XMLOrdenesDatoHija,
           detitem.itemtrabadi,
           detitem.catntrabadi,
           case
             when XMLEXISTS('/DatosAdic/DatoAdic' passing by ref
                            Enc.XMLOrdenesdatosAdpa) then
              1
             else
              0
           end AS datoAdicionalPadre,
           case
             when XMLEXISTS('/DatosAdic/DatoAdic' passing by ref
                            det.XMLOrdenesDatoHija) THEN
              1
             ELSE
              0
           END AS datoAdicionalHija
      FROM XMLTable('/legalizacionOrden/orden' Passing
                    XMLType(  (select  XMLTYPE.CREATEXML(xml_solicitud).EXTRACT('/').getclobval() from LDCI_INFGESTOTMOV where order_id=197111645  and mensaje_id=2534084) ||
                   '') Columns Orden_padre NUMBER Path
                    'idOrden',
                    Causal_padre NUMBER Path 'idCausal',
                    ini_ejec_padre VARCHAR2(30) PATH 'fechaIniEjec',
                    fin_ejec_padre VARCHAR2(30) PATH 'fechaFinEjec',
                    observ_padre VARCHAR2(2000) PATH 'observ_padre',
                    tecnico_padre NUMBER Path 'idTecnico',
                    XMLOrdenesAdicionales XMLType Path 'ordenesAdic',
                    XMLOrdenesdatosAdpa XMLType Path 'DatosAdic') As Enc,
           XMLTable('/ordenesAdic/ordenAdic' Passing
                    Enc.XMLOrdenesAdicionales Columns TipoTrabAdic NUMBER Path
                    'idTipoTrab',
                    activAdic NUMBER Path 'idActividad',
                    Causal_Ot_Adic NUMBER Path 'idCausal',
                    observaAdic VARCHAR2(2000) Path 'observacion',
                    Tecnico_Ot_Adic VARCHAR2(200) Path 'idTecnico',
                    XMLitemsotadic XMLType Path 'items',
                    XMLOrdenesDatoHija XMLType Path 'DatosAdic') As Det,
           XMLTable('/items/item' Passing det.XMLitemsotadic Columns
                    itemtrabadi NUMBER Path 'idItem',
                    catntrabadi NUMBER Path 'cantidad') AS Detitem
     WHERE existsNode(XMLType( (select  XMLTYPE.CREATEXML(xml_solicitud).EXTRACT('/').getclobval()
from LDCI_INFGESTOTMOV
where order_id=197111645
 and mensaje_id=2534084)||
                   ''
                   ),
                      '/legalizacionOrden/orden/ordenesAdic/ordenAdic') NOT IN (0)
