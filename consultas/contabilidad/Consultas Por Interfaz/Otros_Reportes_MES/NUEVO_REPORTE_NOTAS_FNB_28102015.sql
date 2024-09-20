select ss.sesuserv, servdesc, cargnuse, cargdoso, pefacicl, cargtipr, clcocodi, clcodesc,
       cargprog,    upper(procdesc),
       CARGCACA     CausadeCargo,
       csc.cacadesc NombreCausadeCargo,
       CARGCONC     Concepto,
       co.concdesc  Nombreconcepto,
       cargsign,    SESUCATE Categoria,
       sum(cargvalo), c.cargfecr fecha_creacion, 

       (select (select co.nombre_contratista from OPEN.GE_CONTRATISTA co 
                 where co.id_contratista =  ut.contractor_id) nombre                          
        from open.or_order_Activity a, open.or_order o, OPEN.OR_OPERATING_UNIT ut
       where a.package_id   = substr(cargdoso,4,8)
         and a.task_type_id = 10143
         and a.order_id = o.order_id
         and rownum = 1
         and o.operating_unit_id = ut.operating_unit_id) Proveedor,
       (select (select sb.identification from open.ge_subscriber sb 
                 where sb.subscriber_id = (select co.subscriber_id from OPEN.GE_CONTRATISTA co
                                            where co.id_contratista =  ut.contractor_id))                         
         from open.or_order_Activity a, open.or_order o, OPEN.OR_OPERATING_UNIT ut
        where a.package_id   = substr(cargdoso,4,8)
          and a.task_type_id = 10143
          and a.order_id = o.order_id
          and rownum = 1
          and o.operating_unit_id = ut.operating_unit_id) Nit
       
from open.cargos c,open.SERVSUSC ss, open.CONCEPTO CO,
     open.CAUSCARG csc, open.procesos, open.ic_clascont, open.perifact, OPEN.SERVICIO
where c.cargcaca = csc.cacacodi
  and c.cargnuse = ss.sesunuse
  and c.CARGCONC = CO.CONCCODI
  and c.cargfecr between to_date('01/07/2015 00:00:00','dd/mm/yyyy hh24:mi:ss') 
                     and to_date('31/07/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
  and cargprog = proccons
  and clcocodi(+) = concclco
  and cargpefa = pefacodi
  and ss.sesuserv = servcodi
  AND CARGCUCO > 0
  and cargtipr = 'P'
  and cargsign NOT IN ('PA','AP')
  AND substr(cargdoso,1,2) NOT IN ('PA','AP')
  and concclco = 2
  and cargcaca = 19
group by  ss.sesuserv, servdesc, cargnuse, cargdoso, pefacicl, cargtipr, clcocodi, clcodesc, cargprog, upper(procdesc), CARGCACA,csc.cacadesc,
          CARGCONC,co.concdesc, cargsign,SESUCATE, c.cargfecr, cargusua
