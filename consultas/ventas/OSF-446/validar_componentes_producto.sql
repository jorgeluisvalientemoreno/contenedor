select c2.cmssidco    compomente,
       c2.cmsssesu    producto,
       c2.cmssescm    Estado_Componente,
       c3.description Desc_Estado_Componente
  From open.compsesu c2
 Inner join open.ps_product_status c3 on c2.cmssescm = c3.product_status_id
 Where c2.cmsssesu in (52111493, 51446390, 50891018);
