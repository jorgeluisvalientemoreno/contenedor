SET SERVEROUTPUT ON;
DECLARE
  
  PROCEDURE prcInsertaPeriodos IS
      CURSOR cuGetPeriodo IS
      WITH Cicloanio AS (
            SELECT 6002 CICLO,1992 ANIO FROM DUAL UNION ALL
            SELECT 6314 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6108 CICLO,1998 ANIO FROM DUAL UNION ALL
            SELECT 6141 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6084 CICLO,1998 ANIO FROM DUAL UNION ALL
            SELECT 6005 CICLO,1992 ANIO FROM DUAL UNION ALL
            SELECT 6189 CICLO,2009 ANIO FROM DUAL UNION ALL
            SELECT 6054 CICLO,2001 ANIO FROM DUAL UNION ALL
            SELECT 6305 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6048 CICLO,1995 ANIO FROM DUAL UNION ALL
            SELECT 6109 CICLO,2000 ANIO FROM DUAL UNION ALL
            SELECT 6272 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6162 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6004 CICLO,1992 ANIO FROM DUAL UNION ALL
            SELECT 6275 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6024 CICLO,1993 ANIO FROM DUAL UNION ALL
            SELECT 6032 CICLO,2000 ANIO FROM DUAL UNION ALL
            SELECT 6329 CICLO,2025 ANIO FROM DUAL UNION ALL
            SELECT 6031 CICLO,1994 ANIO FROM DUAL UNION ALL
            SELECT 6215 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6230 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6059 CICLO,1995 ANIO FROM DUAL UNION ALL
            SELECT 6218 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6183 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6206 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6009 CICLO,1993 ANIO FROM DUAL UNION ALL
            SELECT 6093 CICLO,1999 ANIO FROM DUAL UNION ALL
            SELECT 6012 CICLO,1992 ANIO FROM DUAL UNION ALL
            SELECT 6224 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6203 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6299 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6095 CICLO,2004 ANIO FROM DUAL UNION ALL
            SELECT 6239 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6040 CICLO,2002 ANIO FROM DUAL UNION ALL
            SELECT 6082 CICLO,2002 ANIO FROM DUAL UNION ALL
            SELECT 6278 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6011 CICLO,2005 ANIO FROM DUAL UNION ALL
            SELECT 6156 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6254 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6064 CICLO,1997 ANIO FROM DUAL UNION ALL
            SELECT 6284 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6074 CICLO,2004 ANIO FROM DUAL UNION ALL
            SELECT 6025 CICLO,2001 ANIO FROM DUAL UNION ALL
            SELECT 6180 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6269 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6245 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6022 CICLO,1992 ANIO FROM DUAL UNION ALL
            SELECT 6186 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6003 CICLO,1992 ANIO FROM DUAL UNION ALL
            SELECT 6227 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6051 CICLO,1997 ANIO FROM DUAL UNION ALL
            SELECT 6500 CICLO,2018 ANIO FROM DUAL UNION ALL
            SELECT 6209 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6323 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6122 CICLO,2004 ANIO FROM DUAL UNION ALL
            SELECT 6127 CICLO,2004 ANIO FROM DUAL UNION ALL
            SELECT 6021 CICLO,1999 ANIO FROM DUAL UNION ALL
            SELECT 6250 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6135 CICLO,2005 ANIO FROM DUAL UNION ALL
            SELECT 6502 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6221 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6266 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6242 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6236 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6296 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6147 CICLO,2006 ANIO FROM DUAL UNION ALL
            SELECT 6293 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6102 CICLO,1999 ANIO FROM DUAL UNION ALL
            SELECT 6157 CICLO,2009 ANIO FROM DUAL UNION ALL
            SELECT 6233 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6163 CICLO,2009 ANIO FROM DUAL UNION ALL
            SELECT 6212 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6073 CICLO,2004 ANIO FROM DUAL UNION ALL
            SELECT 6308 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6083 CICLO,1999 ANIO FROM DUAL UNION ALL
            SELECT 6008 CICLO,1995 ANIO FROM DUAL UNION ALL
            SELECT 6138 CICLO,2005 ANIO FROM DUAL UNION ALL
            SELECT 6029 CICLO,1993 ANIO FROM DUAL UNION ALL
            SELECT 6509 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6508 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6197 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6023 CICLO,1993 ANIO FROM DUAL UNION ALL
            SELECT 6069 CICLO,1999 ANIO FROM DUAL UNION ALL
            SELECT 6260 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6150 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6001 CICLO,1992 ANIO FROM DUAL UNION ALL
            SELECT 6302 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6160 CICLO,2009 ANIO FROM DUAL UNION ALL
            SELECT 6171 CICLO,2009 ANIO FROM DUAL UNION ALL
            SELECT 6026 CICLO,1992 ANIO FROM DUAL UNION ALL
            SELECT 6107 CICLO,1997 ANIO FROM DUAL UNION ALL
            SELECT 6168 CICLO,2009 ANIO FROM DUAL UNION ALL
            SELECT 6287 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6130 CICLO,2005 ANIO FROM DUAL UNION ALL
            SELECT 6072 CICLO,2004 ANIO FROM DUAL UNION ALL
            SELECT 6263 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6507 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6194 CICLO,2007 ANIO FROM DUAL UNION ALL
            SELECT 6290 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6192 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6142 CICLO,2007 ANIO FROM DUAL UNION ALL
            SELECT 6251 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6503 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6043 CICLO,1998 ANIO FROM DUAL UNION ALL
            SELECT 6028 CICLO,1994 ANIO FROM DUAL UNION ALL
            SELECT 6027 CICLO,1993 ANIO FROM DUAL UNION ALL
            SELECT 6094 CICLO,1997 ANIO FROM DUAL UNION ALL
            SELECT 6174 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6257 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6010 CICLO,1992 ANIO FROM DUAL UNION ALL
            SELECT 6153 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6144 CICLO,2005 ANIO FROM DUAL UNION ALL
            SELECT 6030 CICLO,1993 ANIO FROM DUAL UNION ALL
            SELECT 6165 CICLO,2009 ANIO FROM DUAL UNION ALL
            SELECT 6007 CICLO,1995 ANIO FROM DUAL UNION ALL
            SELECT 6178 CICLO,2009 ANIO FROM DUAL UNION ALL
            SELECT 6117 CICLO,2000 ANIO FROM DUAL UNION ALL
            SELECT 6311 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6159 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6281 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6193 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6085 CICLO,2004 ANIO FROM DUAL UNION ALL
            SELECT 6320 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6006 CICLO,1992 ANIO FROM DUAL UNION ALL
            SELECT 6317 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6501 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6092 CICLO,1998 ANIO FROM DUAL UNION ALL
            SELECT 6177 CICLO,2008 ANIO FROM DUAL UNION ALL
            SELECT 6326 CICLO,2008 ANIO FROM DUAL), PerioMigra AS(
        SELECT 
        --select SQ_PERIFACT_PEFACODI.NEXTVAL PEFACODI,
                PEFAANO,
                PEFAMES,
                PEFASACA,
                PEFAFIMO,
                PEFAFFMO,
                PEFAFECO,
                PEFAFEPA,
                PEFAFEPA + 1 PEFAFFPA,
                PEFAFEGE,
                PEFADESC||'- MIGRADO DEL CICLO '||CICLCODI PEFAOBSE,
                ciclhomo PEFACICL,
                PEFADESC,
                PEFAFECO PEFAFCCO,
                null PEFAFGCI,
                PEFAACTU,
                null PEFAFEEM
        FROM Cicloanio
           JOIN homologacion.homociclo ON homociclo.ciclhomo = ciclo
           JOIN gasgg.perifact  ON perifact.pefacicl = homociclo.ciclcodi
        WHERE PEFAANO >= ANIO 
           AND NOT EXISTS ( SELECT 1 
                            FROM perifact po 
                            WHERE perifact.pefaano = po.pefaano
                                AND perifact.pefames = po.pefames
                                AND po.pefacicl = homociclo.ciclhomo) 
        ORDER BY pefaano, pefames)
        SELECT SQ_PERIFACT_PEFACODI.NEXTVAL PEFACODI,
                pefaano PEFAANO,
                pefames PEFAMES,
                pefasaca PEFASACA,
                pefafimo PEFAFIMO,
                pefaffmo PEFAFFMO,
                pefafeco PEFAFECO,
                pefafepa PEFAFEPA,
                pefaffpa PEFAFFPA,
                pefafege PEFAFEGE,
                pefaobse PEFAOBSE,
                pefacicl PEFACICL,
                pefadesc PEFADESC,
                pefafcco PEFAFCCO,
                pefafgci PEFAFGCI,
                pefaactu PEFAACTU,
                pefafeem PEFAFEEM
        FROM PerioMigra;
        
        TYPE tytblPeriodos IS TABLE OF cuGetPeriodo%rowtype;
        tblPeriodos tytblPeriodos;
        
        onuError  NUMBER;
        osbError  VARCHAR2(4000);
    
    BEGIN
       DBMS_OUTPUT.PUT_LINE('Proceso prcInsertaPeriodos Inicio '||sysdate);
        execute immediate 'alter trigger trgInsPeriFact  disable';
        execute immediate 'alter trigger TRGINSPERIFACT disable';
        execute immediate 'alter trigger TRGINSFECHAPEFA disable';
        execute immediate 'alter trigger TRG_AU_AI_PERIFACT_253_432 disable';
        execute immediate 'TRUNCATE TABLE TEMPPEFA';
        OPEN cuGetPeriodo;
          LOOP 
           FETCH cuGetPeriodo BULK COLLECT INTO tblPeriodos LIMIT 100;
             EXIT WHEN tblPeriodos.COUNT = 0;
                 BEGIN
                     FORALL j IN 1 .. tblPeriodos.COUNT SAVE EXCEPTIONS
                       INSERT INTO perifact VALUES tblPeriodos(j);      
                 EXCEPTION
                        WHEN OTHERS THEN
        
                            FOR j IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
                                DECLARE
                                    idx NUMBER := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
                                BEGIN
                                    onuError := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
                                    osbError :=  SQLERRM(-onuError);
                                    dBMS_OUTPUT.PUT_LINE('Error en registro '||tblPeriodos(idx).pefacodi||' error '||osbError);
                                        
                                EXCEPTION
                                    WHEN OTHERS THEN
                                       pkg_error.seterror;
                                       pkg_error.geterror(onuError, osbError);
                                       DBMS_OUTPUT.PUT_LINE('Error no controlado '||osbError||' periodo '||tblPeriodos(idx).pefacodi);
                                END;
                            END LOOP;
                    END;
                      commit;
          END LOOP;
          CLOSE cuGetPeriodo;
          commit;
        
        
        execute immediate 'alter trigger trgInsPeriFact  ENABLE';
        execute immediate 'alter trigger TRGINSPERIFACT ENABLE';
        execute immediate 'alter trigger TRGINSFECHAPEFA ENABLE';
        execute immediate 'alter trigger TRG_AU_AI_PERIFACT_253_432 ENABLE';
        execute immediate 'TRUNCATE TABLE TEMPPEFA'; 
        DBMS_OUTPUT.PUT_LINE('Proceso prcInsertaPeriodos Finaliza '||sysdate);
    
    END prcInsertaPeriodos;
    
    PROCEDURE prcActualizaFechas IS
        CURSOR cugetPeriodos IS
        WITH InfoPeriodos AS(
        SELECT p.*, to_char(add_months('01/'||p.pefames||'/'||p.pefaano, 1), 'YYYY') anosig, 
           to_char(add_months('01/'||P.pefames||'/'||P.pefaano, 1), 'MM') messig
        FROM open.perifact p, homologacion.homociclo
        where homociclo.CICLHOMO = pefacicl
          and REGEXP_LIKE(pefames, '^(0?[1-9]|1[0-2])$')
          AND EXISTS ( SELECT 1 
                       FROM OPEN.perifact p1 
                       WHERE p1.pefacicl = P.pefacicl 
                        AND to_char(add_months('01/'||P.pefames||'/'||P.pefaano, 1), 'YYYY') = p1.pefaano
                        AND to_char(add_months('01/'||P.pefames||'/'||P.pefaano, 1), 'MM') = p1.pefames
                        AND (p1.pefafimo - P.pefaffmo > 1 or round(p1.pefafimo - P.pefaffmo,0) not in ( 0,1)  ) 
                        )
        order by pefacicl, pefafimo)
        
        SELECT PF.PEFACODI PERIODO_ANTE,
                PF.PEFAANO ANIO_ANTE,
                PF.PEFAMES MES_ANTE,
                PF.PEFAFIMO FECHA_INICIO_ANTE,
                PF.PEFAFFMO FECHA_FINAL_ANTE,
                pf.pefacicl ciclo,
                PP.PEFACODI PERIODO_SIG,
                PP.PEFAANO ANIO_SIG,
                PP.PEFAMES MES_SIG,
                PP.PEFAFIMO FECHA_INICIO_SIG,
                PP.PEFAFFMO FECHA_FINAL_SIG,
                trunc(PF.PEFAFFMO) +1 FECHA_INICIO_SIG_act,
                PP.PEFAFEPA, 
                PP.PEFAFFPA
        FROM InfoPeriodos PF, OPEN.PERIFACT PP
        WHERE PF.PEFACICL = PP.PEFACICL
         AND PP.PEFAANO = ANOSIG
         AND PP.PEFAMES = MESSIG;
    BEGIN
         DBMS_OUTPUT.PUT_LINE('Proceso prcActualizaFechas Inicio '||sysdate);
         EXECUTE IMMEDIATE 'ALTER TRIGGER TRGUPPERIFACT DISABLE';
         EXECUTE IMMEDIATE 'ALTER TRIGGER TRGINSFECHAPEFA DISABLE';
         FOR reg IN cugetPeriodos LOOP
            UPDATE PERIFACT SET PEFAFIMO = reg.FECHA_INICIO_SIG_act
            where PEFACODI = REG.PERIODO_SIG;
            COMMIT;
         END LOOP;
         EXECUTE IMMEDIATE 'ALTER TRIGGER TRGUPPERIFACT ENABLE';
         EXECUTE IMMEDIATE 'ALTER TRIGGER TRGINSFECHAPEFA ENABLE';
         EXECUTE IMMEDIATE 'TRUNCATE TABLE TEMPPEFA';
       DBMS_OUTPUT.PUT_LINE('Proceso prcActualizaFechas Finaliza '||sysdate);
    END prcActualizaFechas;
    PROCEDURE prcActualizaHoras IS
    
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Proceso prcActualizaHoras Inicio '||sysdate);
        EXECUTE IMMEDIATE 'alter trigger TRGINSFECHAPEFA disable';
        EXECUTE IMMEDIATE 'alter trigger TRG_AU_AI_PERIFACT_253_432 disable';
        EXECUTE IMMEDIATE 'alter trigger TRGUPPERIFACT disable';
        
        update perifact set pefaffmo = to_date(to_char(pefaffmo, 'dd/mm/yyyy')||' 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
        where pefacodi in (
          SELECT PF.PEFACODI
            FROM OPEN.PERIFACT PF
            where pefacicl in (select CICLHOMO
                                from HOMOLOGACION.HOMOCICLO HC)
                                 and to_number(to_char(PEFAFFMO,'hh24'))=0);
                                 
        COMMIT;
        EXECUTE IMMEDIATE 'alter trigger TRGINSFECHAPEFA ENABLE';
        EXECUTE IMMEDIATE 'alter trigger TRG_AU_AI_PERIFACT_253_432 ENABLE';
        EXECUTE IMMEDIATE 'alter trigger TRGUPPERIFACT ENABLE';
        DBMS_OUTPUT.PUT_LINE('Proceso prcActualizaHoras Finaliza '||sysdate);
   END prcActualizaHoras;
   PROCEDURE prcInsertaPericose IS
        CURSOR cuGetPeriodos IS
        SELECT ci.ciclcico, perifact.pefafimo, perifact.pefaffmo
        FROM OPEN.perifact,
             OPEN.ciclo ci,
             OPEN.ciclcons CL,
             homologacion.homociclo
        WHERE  perifact.pefacicl = ci.ciclcodi
           AND ci.ciclcico = CL.cicocodi
           and perifact.pefacicl = homociclo.ciclhomo
            AND NOT EXISTS (SELECT 1
                            FROM OPEN.pericose
                                WHERE pecsfecf BETWEEN pefafimo AND pefaffmo AND pecscico = ci.ciclcico);
    BEGIN
      DBMS_OUTPUT.PUT_LINE('Proceso prcInsertaPericose Inicia '||sysdate);
      execute immediate 'alter trigger trgbiurPericose disable';
      execute immediate 'alter trigger TRG_AU_AI_PERICOSE_163_278 disable';
      FOR reg IN cuGetPeriodos LOOP
           insert into pericose (PECSCONS,
                                PECSFECI,
                                PECSFECF,
                                PECSPROC,
                                PECSUSER,
                                PECSTERM,
                                PECSPROG,
                                PECSCICO,
                                PECSFLAV,
                                PECSFEAI,
                                PECSFEAF)
            VALUES (
                 OPEN.SQ_PERICOSE_PECSCONS.NEXTVAL ,
                         reg.pefafimo,
                         reg.pefaffmo,
                         'S' ,
                        'MIGRAGG',
                        'MIGRAGG',
                        'MIGRAGG',
                        reg.ciclcico,
                        'S',
                        reg.pefafimo ,
                        reg.pefaffmo );
                COMMIT;
         END LOOP;
      execute immediate 'alter trigger trgbiurPericose enable';
      execute immediate 'alter trigger TRG_AU_AI_PERICOSE_163_278 enable';
      DBMS_OUTPUT.PUT_LINE('Proceso prcInsertaPericose Finaliza '||sysdate);
    END prcInsertaPericose;

BEGIN
  prcInsertaPeriodos;
  prcActualizaFechas;
  prcActualizaHoras;
  prcInsertaPericose;
END;
/
