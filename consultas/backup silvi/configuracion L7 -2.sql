declare
  
codigo_id open.ic_compcont.cococodi%type ;
usuario open.ic_compcont.cocousua%type :='USER' ;
terminal open.ic_compcont.cocoterm%type := pkg_session.fsbgetterminal;
codigoAnt_id open.ic_compcont.cococodi%type :=4 ;


begin
 
 dbms_output.put_line('Generando nuevo comprobante');
 select max(cococodi) + 1 
 into codigo_id
 from open.ic_compcont ; 

 dbms_output.put_line('Nuevo comprobante creado:'|| codigo_id);

 insert into open.ic_compcont
 select  codigo_id,
 cocotcco,
 'L7-ACTA-GDGU',
 sysdate,
 usuario,
 terminal,
 cocoprog,
 cocosist
 from open.ic_compcont 
 where cocotcco =codigoAnt_id
 and cococodi= codigoAnt_id  ;
 
 insert into open.ic_confreco
 select sq_ic_confreco_corccons.nextval,
 codigo_id,
 corctido,
 corctimo,
 corccrit,
 sysdate,
 usuario,
 terminal,
 corcprog
 from open.ic_confreco
 where corccoco =codigoAnt_id;

 insert into open.ic_clascore 
 select sq_ic_clascore_clcrcons.nextval ,
 c.corccons,
 ca.clcrclco,
 ca.clcrcrit , 
 sysdate,
 usuario,
 terminal,
 ca.clcrprog
 from open.ic_confreco  c 
 left join open.ic_confreco cc on cc.corctido= c.corctido and cc.corctimo= c.corctimo and cc.corccoco = codigoAnt_id
 left join open.ic_clascore ca on cc.corccons = ca.clcrcorc
 where c.corccoco =codigo_id;
 
 dbms_output.put_line('Generando nuevo comprobante');
 
insert into open.ic_recoclco 
select 
  sq_ic_recoclco_rccccons.nextval,
  cc_new.clcrcons, 
  r.rcccnatu,
  r.rcccvalo,
  r.rccccuco,
  sysdate,
  usuario,
  terminal,
  r.rcccprog,
  r.rcccpopa, 
  r.rcccpore
from open.ic_clascore cc_old
join open.ic_recoclco r on r.rcccclcr = cc_old.clcrcons
join open.ic_clascore cc_new 
  on cc_new.clcrclco = cc_old.clcrclco 
  and cc_new.clcrcrit = cc_old.clcrcrit
  and cc_new.clcrprog = cc_old.clcrprog
  and cc_new.clcrcorc in (
      select corccons from open.ic_confreco where corccoco = codigo_id
  )
where cc_old.clcrcorc in (
  select corccons from open.ic_confreco where corccoco = codigoAnt_id
);
 
end; 


 

SELECT
  A.COCOCODI COD_COMPROBANTE,
         A.COCODESC DES_COMPROBANTE,
         B.TCCOCODI COD_TIPCOMPROBANTE,
         B.TCCODESC DESC_TIPCOMPROBANTE,
         D.TIDCDESC DESC_TIPODOCUMENTO,
         E.TIMOCODI COD_TIPOMOVIMIENTO,
         E.TIMODESC DESC_TIPOMOVIMIENTO,
         F.CLCRCONS,
         G.CLCOCODI COD_CLASCONT,
         G.CLCODESC DESC_CLASCONT,
         c.corccrit Criterio_Compro,
         DECODE(G.CLCODOMI,'C','Concepto','B','Banco','T''Tipo Trabajo') DOMINIO,
         DECODE(I.RCCCVALO,'V','Valor Total',I.RCCCVALO) VALOR_REPORTAR,
         decode (I.RCCCNATU,'D',I.RCCCCUCO) CTA_CONTABLE_DB,
         decode (I.RCCCNATU,'C',I.RCCCCUCO) CTA_CONTABLE_CR,
         I.RCCCPOPA porcentaje,
         --J.CCRCCAMP||' '||J.CCRCOPER||' '||J.CCRCVALO CRITERIO
         (select listagg(J.CCRCCAMP||' '||J.CCRCOPER||' '||J.CCRCVALO||' ') within group(order by J.CCRCCAMP) as CAMPO
            from OPEN.IC_CRCORECO J
           WHERE J.CCRCCLCR(+)=F.CLCRCONS) Criterio
  FROM  OPEN.IC_COMPCONT A, OPEN.IC_TICOCONT B, OPEN.IC_CONFRECO C , OPEN.IC_TIPODOCO D ,
        OPEN.IC_TIPOMOVI E ,OPEN.IC_CLASCORE F , OPEN.IC_CLASCONT G,OPEN.IC_RECOCLCO I --, OPEN.IC_CRCORECO J
  WHERE
        --J.CCRCCLCR(+)=F.CLCRCONS and
        A.COCOCODI=C.CORCCOCO(+) AND
        C.CORCTIDO=D.TIDCCODI(+) AND
        C.CORCTIMO=E.TIMOCODI(+) AND
        C.CORCCONS=F.CLCRCORC(+) AND
        F.CLCRCLCO=G.CLCOCODI(+) AND
        F.CLCRCONS=I.RCCCCLCR(+) AND
        A.COCOTCCO=B.TCCOCODI(+)
      --  AND G.CLCODOMI = 'C'
       -- and B.TCCOCODI = 1
        and A.COCOCODI = 4
