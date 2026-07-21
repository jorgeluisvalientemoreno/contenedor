select MMITCODI,
       MMITNUDO, --Numrto Dcoumento FRONT OSF
       MMITNUPE, ---Codigo pedido FRONT de LDCISOMA
       MMITDSAP, -- Documento SAP
       MMITTIMO, --tipo de movimiento 
       MMITDESC, --descripcion movimiento 
       MMITNATU, --signo naturaleza 
       MMITCLIE, --nit del cliente 
       MMITFESA, --fecha de salida del documento 
       MMITVTOT, --valor total enviado por sap 
       MMITESTA, --estado de la interfaz: 1 creada, 2 procesada, 3 con errores 
       MMITINTE, --fecha creacion 
       MMITFEVE, --fecha vencimiento 
       MMITMENS, --mensaje procesamiento 
       DMITMMIT, --maestro del detalle 
       DMITCODI, --codigo del detalle 
       DMITITEM, --codigo del material 
       DMITCOIN, --codigo interno material 
       DMITCANT, --cantidad de material 
       DMITCAPE, -- cantidad pendiente de material 
       DMITCOUN, --costo unitario 
       DMITVAUN, --valor unitario 
       DMITPIVA, --porcentaje iva 
       DMITNUFA, --numero de factura 
       DMITALDE, -- almacen destino 
       DMITMARC, --marca del material 
       DMITSAFI,--marca salida final 
       DMITMABO, --marca borrado 
       DMITVALO, --valoracion n nuevo / u usado 
       SERIMMIT, -- codigo del maestro 
       SERIDMIT, --codigo del detalle de la interfaz a la cual esta asociada. 
       SERICODI, --codigo que identifica el registro 
       SERINUME, --numero del serial 
       SERIESTR, --estructura serial sap 
       SERIMARC, --marca 
       SERIANO, --a??o 
       SERICAJA, --caja 
       SERIREMA, --referencia por marca 
       SERITIEN --tipo de entrada 
  from open.ldci_intemmit i --TABLA QUE ALMACENA EL MAESTRO DE LA INTERFAZ MOVIMIENTO MATERIALES 
 inner join open.ldci_dmitmmit d --DETALLE INTERFAZ MOVIMIENTO DE MATERIALES 
    on d.dmitmmit = i.mmitcodi
  left join open.ldci_seridmit s -- SERIALES ASOCIADOS AL DETALLE DE LA INTERFAZ 
    on s.serimmit = i.mmitcodi
   and s.seridmit = d.dmitcodi
 where 1 = 1
      --and i.mmitnupe =  'GDCA-275271' --Codigo FRONT generado en LDCISOMA
   and i.mmitdsap = 413065560;
select *
  from open.ldci_intemmit a, open.ldci_dmitmmit b
 WHERE a.mmitcodi = b.dmitmmit
   AND a.mmitdsap = 413065560
