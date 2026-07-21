select count(1), s.sesucicl, f.factpefa
  from facturas_emitidas fe
 inner join factura f
    on f.factcodi = fe.documento
 inner join servsusc s
    on s.sesususc = f.factsusc
 group by s.sesucicl, f.factpefa;

select f.factcodi, s.sesucicl, f.factpefa
  from facturas_emitidas fe
 inner join factura f
    on f.factcodi = fe.documento
 inner join servsusc s
    on s.sesususc = f.factsusc
 where s.sesucicl = 1707
   and f.factpefa = 49405;

SELECT --+ choose parallel (auto)
 UNIQUE FA.FACTCODI AS "Estado de Cuenta",
 SE.SESUSUSC AS "Contrato",
 SE.SESUNUSE AS "Producto",
 SE.SESUSERV || ' - ' || SO.SERVDESC AS "Tipo de Producto",
 AB.ADDRESS AS "Direccion del Producto",
 GS.SUBSCRIBER_ID AS "Codigo del Cliente",
 GS.IDENTIFICATION AS "Identificacion",
 GS.Subscriber_Name || ' ' || GS.SUBS_LAST_NAME AS "Nombre del Cliente",
 to_number(SUBSTR(CA.CARGDOSO, 4, 15)) AS "Solicitud de Venta",
 PS.PACKAGE_TYPE_ID || ' - ' || PS.DESCRIPTION AS "Tipo de Solicitud",
 CU.CUCOCODI AS "Cuenta de Cobro",
 '$' || to_char(CU.CUCOVATO, 'FM999,999,9990.00') AS "Valor Cuenta de Cobro"
  FROM FACTURA         FA,
       CUENCOBR        CU,
       CARGOS          CA,
       SERVSUSC        SE,
       SERVICIO        SO,
       PR_PRODUCT      PR,
       AB_ADDRESS      AB,
       SUSCRIPC        SC,
       GE_SUBSCRIBER   GS,
       MO_PACKAGES     MO,
       PS_PACKAGE_TYPE PS
 WHERE CU.CUCOFACT = FA.FACTCODI
   AND CA.CARGCUCO = CU.CUCOCODI
   AND SE.SESUNUSE = CA.CARGNUSE
   AND SO.SERVCODI = SE.SESUSERV
   AND PR.PRODUCT_ID = SE.SESUNUSE
   AND AB.ADDRESS_ID = PR.ADDRESS_ID
   AND SC.SUSCCODI = SE.SESUSUSC
   AND GS.SUBSCRIBER_ID = SC.SUSCCLIE
   AND CA.CARGDOSO LIKE 'PP-%'
   AND MO.PACKAGE_ID = to_number(SUBSTR(CA.CARGDOSO, 4, 15))
   AND PS.PACKAGE_TYPE_ID = MO.PACKAGE_TYPE_ID 
   AND FA.FACTPEFA = to_number(49405) 
   AND SE.SESUSERV NOT IN
       (SELECT to_number(regexp_substr('7055,7054,7053', '[^,]+', 1, LEVEL)) AS ServExcIMFC
          FROM dual
        CONNECT BY regexp_substr('7055,7054,7053', '[^,]+', 1, LEVEL) IS NOT NULL)
   AND PS.PACKAGE_TYPE_ID IN
       (SELECT to_number(regexp_substr('271,100229,329,323,100101,300',
                                       '[^,]+',
                                       1,
                                       LEVEL)) AS IdSolicVentaGas
          FROM dual
        CONNECT BY regexp_substr('271,100229,329,323,100101,300',
                                 '[^,]+',
                                 1,
                                 LEVEL) IS NOT NULL)
   AND CA.CARGCACA NOT IN
       (SELECT to_number(regexp_substr('50', '[^,]+', 1, LEVEL)) AS CausExcIMFC
          FROM dual
        CONNECT BY regexp_substr('50', '[^,]+', 1, LEVEL) IS NOT NULL)
        and  exists (select count(1)
  from facturas_emitidas fe where fe.documento = FA.FACTCODI )
