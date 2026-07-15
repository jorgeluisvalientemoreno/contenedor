declare
  
codigo_id open.ic_compcont.cococodi%type ;
usuario open.ic_compcont.cocousua%type;
terminal open.ic_compcont.cocoterm%type;

begin
  
 select max(cococodi) + 1 
 into codigo_id
 from open.ic_compcont ; 

 usuario:='USER';
 terminal:= pkg_session.fsbgetterminal;
  
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
 where cocotcco = 4
 and cococodi= 4  ;
 
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
 where corccoco =4;

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
 left join open.ic_confreco cc on cc.corctido= c.corctido and cc.corctimo= c.corctimo and cc.corccoco = 4
 left join open.ic_clascore ca on cc.corccons = ca.clcrcorc
 where c.corccoco =codigo_id;
 
 insert into open.ic_recoclco 
 select sq_ic_recoclco_rccccons.nextval,
 cc.clcrcons, 
 i.rcccnatu,
 i.rcccvalo,
 i.rccccuco,
 sysdate,
 usuario,
 terminal,
 i.rcccprog,
 i.rcccpopa, 
 i.rcccpore
 from ic_recoclco i  
 inner join ic_clascore c on  i.rcccclcr = c.clcrcons 
 inner join  ic_confreco f on c.clcrcorc =  f.corccons and  f.corccoco =4   
 left join  ic_confreco ff on f.corctido= ff.corctido and f.corctimo= ff.corctimo and ff.corccoco = codigo_id
 left join ic_clascore cc on  cc.clcrcorc =  ff.corccons

 ; 
 
end; 


 
/*SELECT * 
FROM IC_RECOCLCO 
LEFT JOIN IC_CLASCORE ON  RCCCCLCR = CLCRCONS 
left join  ic_confreco on clcrcorc =  corccons 
WHERE CORCCOCO = 77 */
