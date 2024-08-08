select *
from open.ldci_transoma
where trsmcodi in (29506,
29501,
29701,
29505,
29507
);

select distinct substr((SYS.XMLTYPE.createxml(replace(to_char(mesaxmlpayload),'urn:',''))).extract('/PedidoCrearRequest/PedCli').getStringVal(),13, instr((SYS.XMLTYPE.createxml(replace(to_char(mesaxmlpayload),'urn:',''))).extract('/PedidoCrearRequest/PedCli').getStringVal(),'<',1,2)-13), 
       (SYS.XMLTYPE.createxml(replace(to_char(mesaxmlpayload),'urn:',''))).extract('/PedidoCrearRequest/PedCli').getStringVal() /*, SYS.XMLTYPE.createxml(a.mesaxmlenv) , (SYS.XMLTYPE.createxml(a.mesaxmlenv)).extract('/ClasPed')--.getStringVal() 
,extract(SYS.XMLTYPE.createxml(a.mesaxmlenv), 'ClasPed').getStringVal()*/
from open.ldci_mesaenvws a
where mesadefi='WS_PEDIDO_MATERIALES'
  and mesafech>='28/03/2016'
  and mesaestado =-1
 -- and mesacodi=710696119;
  --GDC-29501
  
