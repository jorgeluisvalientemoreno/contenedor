with configuracion as
(
select distinct 
       comproba.tccocodi "IdTipoCompro",
       comproba.tccodesc "tipoComprob",
       
       a.cococodi        "IdCompro",
       a.cocodesc        "Comprob",
       tip_doc.tidccodi  "IdTipoDocu",
       tip_doc.tidcdesc  "TipoDocu",
       tm.timocodi       "IdTipoMov",
       tm.timodesc       "TipoMov",
       (select '1=1'||replace(replace(CRITMOV.CORCCRIT,'--',''),'AND (MOVISIPR = 99  OR   MOVISIRE = 99  OR   MOVISIFA = 99  OR   MOVISICI = 99)', null)  
       from OPEN.IC_CONFRECO CRITMOV 
       WHERE CRITMOV.CORCCOCO=A.COCOCODI 
       and CRITMOV.CORCCOCO=a.cococodi 
       and CRITMOV.CORCTIDO=tip_doc.tidccodi 
       and CRITMOV.CORCTIMO=tm.timocodi
       and trim(replace(replace(CRITMOV.CORCCRIT,'--',''),'AND (MOVISIPR = 99  OR   MOVISIRE = 99  OR   MOVISIFA = 99  OR   MOVISICI = 99)')) is not null) "Criterio compro",
       f.CLCRCORC,
       f.CLCRCONS,
       cl.clcocodi,
       cl.clcodesc,
       decode(cl.clcodomi, 'C','C-Concepto','B','B-Banco','T','T-Tipo Trabajo') dominio,
       case when f.clcrcrit ='--' then null else '1=1'||replace(replace(f.clcrcrit,'--',''),'AND (MOVISIPR = 99  OR   MOVISIRE = 99  OR   MOVISIFA = 99  OR   MOVISICI = 99)', null) end  clcrcrit,
       (select count(J.CCRCCAMP||' '||J.CCRCOPER||' '||J.CCRCVALO) from OPEN.IC_CRCORECO j where CCRCCORC=f.CLCRCORC and ccrcclcr=f.clcrcons) crit2,
       (select rc.rccccuco  from OPEN.IC_RECOCLCO rc where rc.rcccclcr=f.Clcrcons and rc.rcccnatu='D' and rownum=1) debito,
       (select rc.rccccuco  from OPEN.IC_RECOCLCO rc where rc.rcccclcr=f.Clcrcons and rc.rcccnatu='C' and rownum=1) credito,
       I.RCCCPOPA porcentaje
  from OPEN.IC_CONFRECO C
  inner join OPEN.IC_COMPCONT A on a.cococodi=c.corccoco  
  inner join OPEN.IC_TICOCONT comproba on comproba.tccocodi=a.cocotcco
  inner join OPEN.IC_TIPODOCO tip_doc on tip_doc.tidccodi= c.corctido
  inner join open.ic_tipomovi tm on tm.timocodi=c.corctimo
  inner join OPEN.IC_CLASCORE F on f.CLCRCORC = c.CORCCONS
  inner join OPEN.IC_RECOCLCO I on f.CLCRCONS = I.RCCCCLCR
  inner join open.ic_clascont cl on cl.clcocodi=f.clcrclco 
  where tip_doc.tidccodi in (71 -- FACTURACION
                             )
    and comproba.tccocodi = 1    -- Interfaz de Ingresos
    and tm.timocodi in (1 -- Facturacion por Concepto
                        
                       )
)
select "IdCompro", "Comprob", periodo, movitido, movitimo, timo, movitihe, /*CONCEPTO, DESC_CONCEPTO,*/ concclco, Desc_Clasi, PRODUCTO, Desc_Serv, CATEGO, CAUSAL, 
       Des_Caca, 
       VALOR, 
       debito,
       credito,
       tipo,
       FACTCODI,
       cargprog
from
(
select "IdCompro", "Comprob", periodo, FACTCODI, movitido, movitimo, timo, movitihe, /*CONCEPTO, DESC_CONCEPTO,*/ concclco, Desc_Clasi, PRODUCTO, Desc_Serv, CATEGO, CAUSAL, 
       Des_Caca, 
       sum(VALOR) VALOR, 
       c.debito,
       c.credito,
       porcentaje,
       tipo,
       cargprog
from
(
-- Facturación por Concepto
SELECT FACTCODI, periodo, movitido, movitimo, TIMO,
       moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
       movicate CATEGO,
       cargdoso,
       moviconc CONCEPTO, concdesc DESC_CONCEPTO,
       concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = concclco) Desc_Clasi,
       movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
       movisuca, 
       sum(MOVIVALO) valor,
       movitihe, 
       tipo ,
       cargprog
from
(
SELECT  /*+ index ( c IX_CARGOS02) index ( cu PK_CUENCOBR)  index ( f PK_FACTURA)*/
        F.FACTCODI,
        cargprog,
        to_char(factfege, 'yyyymm') periodo, 71 movitido, 
        1 movitimo, 'Facturacion por Concepto' timo, 
        sesuserv moviserv, (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Desc_Serv, 
        sesucate movicate, sesusuca movisuca, cargconc moviconc, concdesc,  concclco,
        cargcaca movicaca,
        cargsign movisign,
        cargdoso, 
        sum((decode(cargsign,'DB',cargvalo,-cargvalo))) movivalo,
        'F' Movitihe,
        gp.description Tipo
        -- gs.ident_type_id
FROM    open.cargos c,
        open.servsusc,
        open.suscripc sc,
        open.ge_subscriber gs,
        open.GE_IDENTIFICA_TYPE gi,
        open.GE_PERSON_CLASS gp, 
        open.cuencobr cu,
        open.factura f,
        open.concepto o
WHERE   cucocodi = cargcuco
        AND sesunuse = cargnuse
        AND susccodi = sesususc
        AND gs.subscriber_id = suscclie
        AND gi.ident_type_id = gs.ident_type_id
        AND gi.person_class_id = gp.person_class_id
        AND cucofact = factcodi
        AND cargconc = conccodi
       --- and factcodi =2137277105
        and cucocodi in (select cucocodi
                from open.factura
                inner join open.cuencobr on cucofact=factcodi 
                where trunc(factfege)=trunc(sysdate)
                  and factfege<=to_Date(to_char(sysdate, 'dd/mm/yyyy hh24:')|| to_char(trunc(sysdate), 'mi:ss'),'dd/mm/yyyy hh24:mi:ss')
                  and not exists(select null from personalizaciones.factura_elect_general f where f.documento=factcodi and f.tipo_documento in (1, 2))
 

                           )
        AND cargcuco > 0
        AND cargtipr = 'A'
        and ((cargcaca !=51) or (cargcaca =51 and cargdoso not like 'DF-%'))
        AND cargsign in ('DB','CR')
GROUP BY F.FACTCODI, to_char(factfege, 'yyyymm'), sesuserv, sesucate, cargconc, concdesc, concclco, cargcaca, sesusuca, cargsign,cargdoso, gp.description, cargprog
--

) Group by periodo, movitido, movitimo,FACTCODI,  moviserv, movicate, moviconc, concdesc, concclco, movicaca, movisuca, movitihe, TIMO, tipo, cargdoso, cargprog

) m
LEFT join configuracion c on m.MOVITIDO=c."IdTipoDocu" and m.MOVITIMO=c."IdTipoMov" and m.concclco=c.clcocodi and 
          OPEN.Ldc_fsbValidaExpresion_IC(c."Criterio compro", causal, producto, movitihe, catego, movisuca, null)='S'  and
          OPEN.Ldc_fsbValidaExpresion_IC(c.clcrcrit, causal, producto, movitihe, catego, movisuca, null)='S'
GROUP BY movitido, movitimo, movitihe, /*CONCEPTO, DESC_CONCEPTO,*/ concclco, Desc_Clasi, PRODUCTO, Desc_Serv, CATEGO, CAUSAL, 
         Des_Caca, c.debito, c.credito, timo, periodo, porcentaje,tipo,"IdCompro", "Comprob", FACTCODI, cargprog
) where debito like '4%' or credito like '4%'
ORDER BY periodo, MOVITIMO, CONCCLCO --, CONCEPTO