select a.sesususc contrato,
       a.Sesunuse Servicio,
       a.sesuserv Tipo_Servicio,
       A.SESUCATE Categoria
  from open.SERVSUSC a
 where a.Sesuserv = 7014
   AND A.SESUESFN in ('M', 'D')
