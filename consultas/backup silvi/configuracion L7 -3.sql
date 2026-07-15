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
 
  
insert into open.ic_recoclco (
  rccccons,
  rcccclcr,
  rcccnatu,
  rcccvalo,
  rccccuco,
  rcccfecr,
  rcccusua,
  rcccterm,
  rcccprog,
  rcccpopa,
  rcccpore
)
select 
  sq_ic_recoclco_rccccons.nextval,
  c_new.clcrcons,
  r.rcccnatu,
  r.rcccvalo,
  r.rccccuco,
  sysdate,
  usuario,
  terminal,
  r.rcccprog,
  r.rcccpopa,
  r.rcccpore
from open.ic_confreco f_old
inner join open.ic_clascore c_old on c_old.clcrcorc = f_old.corccons
inner join open.ic_recoclco r on r.rcccclcr = c_old.clcrcons
inner join open.ic_confreco f_new on f_new.corctido = f_old.corctido and f_new.corctimo = f_old.corctimo and f_old.corccrit =  f_new.corccrit and f_new.corccoco = codigo_id
inner join open.ic_clascore c_new on c_new.clcrcorc = f_new.corccons and c_new.clcrclco  = c_old.clcrclco  and c_new.clcrcrit = c_old.clcrcrit 
where f_old.corccoco = codigoAnt_id;

insert into open.open.ic_crcoreco
select sq_ic_crcoreco_ccrccons.nextval as ccrccons,
c_new.clcrcorc as ccrccorc ,
c_new.clcrcons as ccrcclcr,
cr.ccrccamp,
cr.ccrcoper,
cr.ccrcvalo,
sysdate,
usuario,
terminal,
cr.ccrcprog
from open.ic_confreco f_old
inner join open.ic_clascore c_old on c_old.clcrcorc = f_old.corccons
inner join open.ic_crcoreco cr on  cr.ccrcclcr = c_old.clcrcons and c_old.clcrcorc = cr.ccrccorc 
inner join open.ic_confreco f_new on f_new.corctido = f_old.corctido and f_new.corctimo = f_old.corctimo and f_old.corccrit =  f_new.corccrit and f_new.corccoco = codigo_id
inner join open.ic_clascore c_new on c_new.clcrcorc = f_new.corccons and c_new.clcrclco  = c_old.clcrclco  and c_new.clcrcrit = c_old.clcrcrit 
where f_old.corccoco = codigoant_id;

END ; 
 

