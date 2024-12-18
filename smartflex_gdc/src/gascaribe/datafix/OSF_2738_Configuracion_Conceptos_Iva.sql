column dt new_value vdt
column db new_value vdb
select TO_CHAR(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 2388');
SELECT TO_CHAR(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
 
DECLARE
  CURSOR cuGetConceBAse IS
  SELECT  C1.*,
        C2.CONCCODI CONCEPTO_BASE,
        C2.CONCDESC CONC_BASE,
        CONCBALI.rowid id_reg,
        ( select COSEFUFA
          from open.concserv
          where COSECONC = C1.CONCCODI
           and COSESERV = 7014) regla_gas,
         ( select COSEFUFA
          from open.concserv
          where COSECONC = C1.CONCCODI
           and COSESERV = 3) regla_cobros,
             ( select COSEFUFA
          from open.concserv
          where COSECONC = C1.CONCCODI
           and COSESERV = 6121) regla_generico
    FROM OPEN.CONCEPTO C1, OPEN.CONCBALI, OPEN.CONCEPTO C2
    WHERE C1.CONCTICL = 4
     AND concbali.coblconc = C1.CONCCODI
     AND CONCBALI.COBLCOBA = C2.CONCCODI
     and C1.conccodi  in (137,287)
     and CONCBALI.COBLCOBA not in (30, 674);
    
    CURSOR cuGetConfTAco(inuConcepto NUMBER) IS
    SELECT *
    FROM ta_vigetaco, ta_conftaco, ta_tariconc
    WHERE ta_conftaco.cotcconc = 137
     AND ta_tariconc.tacocons = ta_vigetaco.vitctaco
     AND ta_tariconc.tacocotc =ta_conftaco.cotccons
     AND ta_vigetaco.vitcfefi > sysdate 
     AND ta_conftaco.COTCVIGE = 'S';
     
     CURSOR cugetTarifProy(inuVigetaco NUMBER) IS
     SELECT *
    FROM ta_taricopr, ta_vigetacp
    WHERE ta_taricopr.TACPCONS = ta_vigetacp.vitptacp
     and ta_vigetacp.VITPVITC =  inuVigetaco;
        

     
     nuContador number;
     nuConsCofTaco NUMBER;
     nuConTariCons NUMBER;
     nuConsTarProy number;
     nuConsVitaproy  number;
     NUCONSVIGETACO  number;
BEGIN
  
  execute immediate 'alter trigger TRGBIRTA_RANGVITP disable';

  SELECT MAX(CONCCODI)  INTO nuContador
  FROM OPEN.CONCEPTO
  WHERE CONCCODI <> 2087;

  FOR reg  IN cuGetConceBAse LOOP
     nuContador := nuContador +1;
     INSERT INTO CONCEPTO(CONCCODI, CONCDESC, CONCCOCO, CONCORLI, CONCPOIV, CONCORIM, CONCORGE, CONCDIFE, CONCCORE, CONCCOIN, CONCFLDE, CONCUNME, CONCDEFA, CONCFLIM, CONCSIGL, CONCTICO, CONCNIVE, CONCCLCO, CONCTICC, CONCTICL, CONCAPPR, CONCCONE, CONCAPCP)
       VALUES (nuContador, 
            substr('IVA '||REG.CONC_BASE,1,30), 
            REG.CONCCOCO, 
            REG.CONCORLI, 
            REG.CONCPOIV, 
            REG.CONCORIM,
            REG.CONCORGE, 
            REG.CONCDIFE,
            603/*REG.CONCCORE*/, 	
            761/*REG.CONCCOIN*/,
            REG.CONCFLDE, 
            REG.CONCUNME, 
            'IVA', 
            REG.CONCFLIM, 
            REG.CONCSIGL, 
            REG.CONCTICO, 
            REG.CONCNIVE, 
            106/*REG.CONCCLCO*/, 
            REG.CONCTICC, 
            REG.CONCTICL,
            REG.CONCAPPR, 
            REG.CONCCONE, 
            REG.CONCAPCP);
            
    update CONCBALI set coblconc = nuContador where rowid = reg.id_reg;
    
    INSERT INTO concserv 
    SELECT nuContador COSECONC ,
            COSESERV ,
            COSEFUFA ,
            COSEORGE ,
            COSEACTI ,
            COSEFLIM ,
            COSECLCO ,
            COSEREGL ,
            COSENIRO ,
            COSEFELI 
    FROM concserv
    WHERE COSECONC = REG.CONCCODI;
    --INSERTAR CONFTACO
    FOR regT IN cuGetConfTAco(REG.CONCCODI) LOOP
      nuConsCofTaco := SQ_TA_CONFTACO_COTCCONS.NEXTVAL ;
      INSERT INTO ta_conftaco (COTCCONS, COTCCONC,
           COTCDECT, COTCSERV, COTCVIGE, COTCFEIN, COTCFEFI, COTCPROG, COTCUSUA, COTCTERM)
           VALUES(nuConsCofTaco, nuContador,
           regT.COTCDECT, regT.COTCSERV, regT.COTCVIGE, regT.COTCFEIN, regT.COTCFEFI, regT.COTCPROG, regT.COTCUSUA, regT.COTCTERM);
     nuConTariCons := SQ_TA_TARICONC_TACOCONS.NEXTVAL;
     
     INSERT INTO ta_tariconc(   TACOCONS, 
                                TACOCOTC, 
                                TACOTIMO,
                                TACOSUSC,
                                TACOSESU, 
                                TACOCR01, TACOCR02, TACOCR03, TACOCR04, 
                                TACOCR05, TACOCR06, TACOCR07, TACOCR08,
                                TACOCR09, TACOCR10, TACOCR11, TACOCR12, 
                                TACOCR13, TACOCR14, TACOCR15, TACOCR16, 
                                TACOPROG, TACOUSUA, TACOTERM, TACODESC)
     VALUES( nuConTariCons, 
            nuConsCofTaco , 
            regT.TACOTIMO,
            regT.TACOSUSC,
            regT.TACOSESU, 
            regT.TACOCR01, regT.TACOCR02, regT.TACOCR03, regT.TACOCR04, 
            regT.TACOCR05, regT.TACOCR06, regT.TACOCR07, regT.TACOCR08,
            regT.TACOCR09, regT.TACOCR10, regT.TACOCR11, regT.TACOCR12, 
            regT.TACOCR13, regT.TACOCR14, regT.TACOCR15, regT.TACOCR16, 
            regT.TACOPROG, regT.TACOUSUA, regT.TACOTERM, regT.TACODESC);
      
     nuConsVigeTaco := SQ_TA_VIGETACO_VITCCONS.nextval;
     
     INSERT INTO ta_vigetaco (VITCCONS, VITCTACO, VITCFEIN, VITCFEFI, VITCVIGE, VITCVALO, VITCPORC, VITCPROG, VITCUSUA, VITCTERM)
       VALUES(nuConsVigeTaco, nuConTariCons, regT.VITCFEIN, regT.VITCFEFI, regT.VITCVIGE, regT.VITCVALO, regT.VITCPORC, regT.VITCPROG, regT.VITCUSUA, regT.VITCTERM);
     
     insert into ta_rangvitc
     select SQ_TA_RANGVITP_RAVPCONS.NEXTVAL RAVTCONS, 
            nuConsVigeTaco RAVTVITC,
            RAVTLIIN, 
            RAVTLISU,
            RAVTVALO,
            19 RAVTPORC,
            RAVTPROG, RAVTUSUA, RAVTTERM
     from ta_rangvitc --SQ_TA_RANGVITC_RAVTCONS.NEXTVAL;
     where ravtvitc = regT.VITCCONS;
     
      FOR regTp IN cugetTarifProy(regT.VITCCONS) LOOP
          nuConsTarProy := SQ_TA_TARICOPR_TACPCONS.NEXTVAL;
          
          INSERT INTO ta_taricopr(TACPCONS, TACPPRTA, TACPCOTC, TACPTIMO, TACPRESO, TACPDESC, TACPSESU, TACPSUSC, TACPCR01, TACPCR02, TACPCR03, TACPCR04, TACPCR05, TACPCR06, TACPCR07, TACPCR08, TACPCR09, TACPCR10, TACPCR11, TACPCR12, TACPCR13, TACPCR14, TACPCR15, TACPCR16, TACPTACC, TACPPROG, TACPUSUA, TACPTERM)
            VALUES (nuConsTarProy, regTp.TACPPRTA, nuConsCofTaco, regTp.TACPTIMO, regTp.TACPRESO, regTp.TACPDESC, regTp.TACPSESU, 
            regTp.TACPSUSC, regTp.TACPCR01, regTp.TACPCR02, regTp.TACPCR03, regTp.TACPCR04, regTp.TACPCR05, regTp.TACPCR06, 
            regTp.TACPCR07, regTp.TACPCR08, regTp.TACPCR09, regTp.TACPCR10, regTp.TACPCR11, regTp.TACPCR12, regTp.TACPCR13, 
            regTp.TACPCR14, regTp.TACPCR15, regTp.TACPCR16, nuConTariCons, regTp.TACPPROG, regTp.TACPUSUA, regTp.TACPTERM);
           
          nuConsVitaproy :=  SQ_TA_VIGETACP_VITPCONS.NEXTVAL;
          INSERT INTO ta_vigetacp(VITPCONS, VITPTACP, VITPVITC, VITPTIPO, VITPESTA, VITPMOCR, VITPFEIN, VITPFEFI, VITPVALO, VITPPORC, VITPPROG, VITPUSUA, VITPTERM, VITPMEEP)
            VALUES (nuConsVitaproy, nuConsTarProy, nuConsVigeTaco, regTp.VITPTIPO, regTp.VITPESTA, regTp.VITPMOCR, regTp.VITPFEIN, regTp.VITPFEFI, regTp.VITPVALO, regTp.VITPPORC, regTp.VITPPROG, regTp.VITPUSUA, regTp.VITPTERM, regTp.VITPMEEP);
           
          INSERT INTO ta_rangvitp
           SELECT SQ_TA_RANGVITP_RAVPCONS.NEXTVAL ravpcons, nuConsVitaproy ravpvitp, ravpliin, ravplisu, ravpvalo, 19 ravpporc, ravpprog, ravpusua, ravpterm
            FROM ta_rangvitp  --
            WHERE RAVPVITP = regTp.VITPCONS;

       END LOOP;
 
    END LOOP;
    
    END LOOP;
	commit;
	execute immediate 'alter trigger TRGBIRTA_RANGVITP enable';
EXCEPTION
   when others THEN
     dbms_output.put_line('Error no controlado ' ||sqlerrm);
     rollback;
	 execute immediate 'alter trigger TRGBIRTA_RANGVITP enable';
	 
END;
/
SELECT TO_CHAR(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
/