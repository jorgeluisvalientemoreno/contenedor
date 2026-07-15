DECLARE
  
  codigo_id     OPEN.ic_compcont.cococodi%TYPE:=72;
  usuario       OPEN.ic_compcont.cocousua%TYPE := 'USER';
  terminal      OPEN.ic_compcont.cocoterm%TYPE := pkg_session.fsbgetterminal;
  codigoAnt_id  OPEN.ic_compcont.cococodi%TYPE := 4;

BEGIN

  DBMS_OUTPUT.PUT_LINE('Generando nuevo comprobante');

/*  SELECT MAX(cococodi) + 1
  INTO codigo_id
  FROM OPEN.ic_compcont;

  INSERT INTO OPEN.ic_compcont
  SELECT  codigo_id,
          cocotcco,
          'L7-ACTA-GDGU',
          SYSDATE,
          usuario,
          terminal,
          cocoprog,
          cocosist
  FROM OPEN.ic_compcont
  WHERE cocotcco = 4
  AND cococodi = codigoAnt_id;*/

  DBMS_OUTPUT.PUT_LINE('Nuevo comprobante creado:' || codigo_id);

  insert into open.ic_confreco
  select  sq_ic_confreco_corccons.nextval,
          codigo_id,
          corctido,
          corctimo,
          corccrit,
          sysdate,
          usuario,
          terminal,
          corcprog
  from open.ic_confreco
  where corccoco = codigoant_id;

 insert into open.ic_auxicorc 
 select sq_ic_auxicorc_187974.nextval as aucrcons,  
        c_new.corccons, 
        aucrsign, 
        aucranme, 
        aucrbare, 
        aucrbatr, 
        aucrcale, 
        aucrcate, 
        aucrceco, 
        aucrcicl, 
        aucrcldp, 
        aucrclie, 
        aucrconc, 
        aucrcupo, 
        aucrdoso, 
        aucredde, 
        aucrfetr, 
        aucrfopa, 
        aucrnibr, 
        aucrnibt, 
        aucrnica, 
        aucrnips, 
        aucrnite, 
        aucrnufa, 
        aucrproy, 
        aucrserv, 
        aucrsici, 
        aucrsifa, 
        aucrsipr, 
        aucrsire, 
        aucrsuca, 
        aucrtibr, 
        aucrtica, 
        aucrtiuo, 
        aucrunne, 
        aucrvaba, 
        aucrubg1, 
        aucrubg2, 
        aucrubg3, 
        aucrubg4, 
        aucrubg5, 
        aucrunco, 
        aucrsuba, 
        aucrdipr, 
        aucrclit, 
        aucrtitr, 
        aucrbaco, 
        aucritem
  from open.ic_auxicorc a
  inner join open.ic_confreco c_old on a.aucrcorc = c_old.corccons 
  inner join open.ic_confreco c_new on c_new.corctido = c_old.corctido 
   and c_new.corctimo = c_old.corctimo 
   and c_old.corccrit = c_new.corccrit 
   and c_new.corccoco = codigo_id 
  where c_old.corccoco = codigoant_id ; 

  insert into open.ic_clascore
  select  sq_ic_clascore_clcrcons.nextval,
          c.corccons,
          ca.clcrclco,
          ca.clcrcrit,
          sysdate,
          usuario,
          terminal,
          ca.clcrprog
  from open.ic_confreco c
  left join open.ic_confreco cc 
    on cc.corctido = c.corctido 
   and cc.corctimo = c.corctimo 
   and cc.corccoco = codigoant_id
  left join open.ic_clascore ca 
    on cc.corccons = ca.clcrcorc
  inner join open.ic_crcoreco j on j.ccrcclcr=ca.clcrcons    
  inner join open.ge_items i 
   on to_char(i.items_id) = to_char(j.ccrcvalo)
  where c.corccoco = codigo_id
  and upper(i.description) not like '%RETEICA%';

  INSERT INTO OPEN.ic_recoclco (
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
  SELECT  sq_ic_recoclco_rccccons.NEXTVAL,
          c_new.clcrcons,
          r.rcccnatu,
          r.rcccvalo,
          r.rccccuco,
          SYSDATE,
          usuario,
          terminal,
          r.rcccprog,
          r.rcccpopa,
          r.rcccpore
  FROM OPEN.ic_confreco f_old
  INNER JOIN OPEN.ic_clascore c_old 
    ON c_old.clcrcorc = f_old.corccons
  INNER JOIN OPEN.ic_recoclco r 
    ON r.rcccclcr = c_old.clcrcons
  INNER JOIN OPEN.ic_confreco f_new 
    ON f_new.corctido = f_old.corctido 
   AND f_new.corctimo = f_old.corctimo 
   AND f_old.corccrit = f_new.corccrit 
   AND f_new.corccoco = codigo_id
  INNER JOIN OPEN.ic_clascore c_new 
    ON c_new.clcrcorc = f_new.corccons 
   AND c_new.clcrclco = c_old.clcrclco 
   AND c_new.clcrcrit = c_old.clcrcrit
  WHERE f_old.corccoco = codigoAnt_id;

  INSERT INTO OPEN.ic_crcoreco
  SELECT  sq_ic_crcoreco_ccrccons.nextval AS ccrccons,
          c_new.clcrcorc AS ccrccorc,
          c_new.clcrcons AS ccrcclcr,
          cr.ccrccamp,
          cr.ccrcoper,
          cr.ccrcvalo,
          SYSDATE,
          usuario,
          terminal,
          cr.ccrcprog
  FROM OPEN.ic_confreco f_old
  INNER JOIN OPEN.ic_clascore c_old 
    ON c_old.clcrcorc = f_old.corccons
  INNER JOIN OPEN.ic_crcoreco cr 
    ON cr.ccrcclcr = c_old.clcrcons 
   AND c_old.clcrcorc = cr.ccrccorc
  INNER JOIN OPEN.ic_confreco f_new 
    ON f_new.corctido = f_old.corctido 
   AND f_new.corctimo = f_old.corctimo 
   AND f_old.corccrit = f_new.corccrit 
   AND f_new.corccoco = codigo_id
  INNER JOIN OPEN.ic_clascore c_new 
    ON c_new.clcrcorc = f_new.corccons 
   AND c_new.clcrclco = c_old.clcrclco 
   AND c_new.clcrcrit = c_old.clcrcrit
   INNER JOIN OPEN.GE_ITEMS I 
   ON TO_CHAR(I.ITEMS_ID) = TO_CHAR(cr.CCRCVALO)
  WHERE f_old.corccoco = codigoAnt_id
  AND UPPER(I.DESCRIPTION) NOT LIKE '%RETEICA%'; 
  
  
   
END;


