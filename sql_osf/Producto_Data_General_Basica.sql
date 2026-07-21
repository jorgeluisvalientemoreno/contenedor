SELECT /*+ index(servsusc pk_servsusc) */
 SESUNUSE,
 (SELECT /*+ leading(suscripc) index(suscripc pk_suscripc)
                                           use_nl(ge_subscriber) */
   SESUSUSC || ' - ' || SUBSCRIBER_NAME || ' ' || SUBS_LAST_NAME
    FROM SUSCRIPC, GE_SUBSCRIBER
   WHERE SUSCCODI = SESUSUSC
     AND SUBSCRIBER_ID = SUSCCLIE) SESUSUSC,
 (SELECT /*+ index(servicio pk_servicio) */
   SERVCODI || ' - ' || SERVDESC
    FROM SERVICIO
   WHERE SERVCODI = SESUSERV) SESUSERV,
 (SELECT /*+ index(ciclcons pk_ciclcons) */
   SESUCICO || ' - ' || CICODESC
    FROM CICLCONS
   WHERE CICOCODI = SESUCICO) SESUCICO,
 SESUCAIN,
 REPLACE(TO_CHAR(SESUFEIN, 'dd-Month-yyyy'), ' ', '') SESUFEIN,
 REPLACE(TO_CHAR(SESUFERE, 'dd-Month-yyyy'), ' ', '') SESUFERE,
 (SELECT /*+ index(estacort pk_estacort) */
   SESUESCO || ' - ' || ESCODESC
    FROM ESTACORT
   WHERE ESCOCODI = SESUESCO) SESUESCO,
 (SELECT /*+ index(categori pk_categori) */
   SESUCATE || ' - ' || CATEDESC
    FROM CATEGORI
   WHERE CATECODI = SESUCATE) SESUCATE,
 (SELECT /*+ index(subcateg pk_subcateg) */
   SESUSUCA || ' - ' || SUCADESC
    FROM SUBCATEG
   WHERE SUCACATE = SESUCATE
     AND SUCACODI = SESUSUCA) SESUSUCA,
 (SELECT /*+ index(meanvaco pk_meanvaco) */
   SESUMECV || ' - ' || MAVCDESC
    FROM MEANVACO
   WHERE MAVCCODI = SESUMECV) SESUMECV,
 SESUMULT,
 (SELECT /*+ index(ciclo pk_ciclo) */
   SESUCICL || ' - ' || CICLDESC
    FROM CICLO
   WHERE CICLCODI = SESUCICL) SESUCICL,
 (SELECT /*+ index(plansusc pk_plansusc) */
   SESUPLFA || ' - ' || PLSUDESC
    FROM PLANSUSC
   WHERE PLSUCODI = SESUPLFA) SESUPLFA,
 (SELECT /*+ index(sistema pk_sistema) */
   SESUSIST || ' - ' || SISTEMPR
    FROM SISTEMA
   WHERE SISTCODI = SESUSIST) SESUSIST,
 NULL PARENT_ID
  FROM SERVSUSC

 WHERE SERVSUSC.SESUNUSE = 50292693;

select ss.sesunuse Producto,
       (SELECT /*+ index(meanvaco pk_meanvaco) */
         SESUMECV || ' - ' || MAVCDESC
          FROM MEANVACO
         WHERE MAVCCODI = ss.SESUMECV) Metodo_Variacion_Consumo
  from open.servsusc ss
 where ss.sesunuse = 50292693;
