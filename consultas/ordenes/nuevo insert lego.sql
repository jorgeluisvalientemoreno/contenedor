
 SELECT   Enc.Orden_padre,
           Enc.Causal_padre,
           nvl(Enc.ini_ejec_padre, sysdate) ini_ejec_padre,
           nvl(Enc.fin_ejec_padre, sysdate) fin_ejec_padre,
           Enc.observ_padre,
           Enc.tecnico_padre,
           Det.TipoTrabAdic,
           Det.activAdic,
           Det.Causal_Ot_Adic,
           Det.observaAdic,
           Det.Tecnico_Ot_Adic,
           detitem.itemtrabadi,
           detitem.catntrabadi
    FROM XMLTable('/legalizacionOrden/orden' Passing
                  XMLType('<legalizacionOrden><orden><idOrden>106662825</idOrden><idCausal>3581</idCausal><idTecnico>15902</idTecnico><fechaIniEjec>27/07/18</fechaIniEjec><fechaFinEjec>27/07/18</fechaFinEjec><ordenesAdic><ordenAdic><idTipoTrab>10722</idTipoTrab><idActividad>100003640</idActividad><idCausal>3581</idCausal><observacion>//SE REALIZO LA REPARACION, NO HAY NECESIDAD DE SUSPENDER EL SERVICIO AL CLIENTE</observacion><idTecnico>15902</idTecnico><items><item><idItem>100000310</idItem><cantidad>23.0000</cantidad></item><item><idItem>100000310</idItem><cantidad>2.0000</cantidad></item></items></ordenAdic></ordenesAdic></orden></legalizacionOrden>') Columns Orden_padre NUMBER Path
                  'idOrden', Causal_padre NUMBER Path 'idCausal', ini_ejec_padre DATE PATH
                   'ini_eje_padre', fin_ejec_padre DATE PATH
                   'fin_eje_padre', observ_padre VARCHAR2(2000) PATH
                   'observ_padre', tecnico_padre NUMBER Path 'idTecnico', XMLOrdenesAdicionales
                   XMLType Path
                   'ordenesAdic') As Enc,
         XMLTable('/ordenesAdic/ordenAdic' Passing
                  Enc.XMLOrdenesAdicionales Columns TipoTrabAdic NUMBER Path
                  'idTipoTrab', activAdic NUMBER Path 'idActividad', Causal_Ot_Adic
                   NUMBER Path
                   'idCausal', observaAdic VARCHAR2(2000) Path
                   'observacion', Tecnico_Ot_Adic VARCHAR2(200) Path
                   'idTecnico', XMLitemsotadic XMLType Path 'items') As Det,
         XMLTable('/items/item' Passing det.XMLitemsotadic Columns
                  itemtrabadi NUMBER Path 'idItem', catntrabadi NUMBER Path
                   'cantidad') AS Detitem;
