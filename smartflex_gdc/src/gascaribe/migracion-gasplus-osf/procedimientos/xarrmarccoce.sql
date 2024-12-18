CREATE OR REPLACE PROCEDURE XARRMARCCOCE(ini number, fin number) IS
CURSOR SE IS SELECT * FROM SERVSUSC WHERE SESUSERV=7014 and sesunuse>=ini and sesunuse<fin;
F NUMBER;
E NUMBER;
D NUMBER;
C1 NUMBER;
C2 NUMBER;
CURSOR CONS(SU NUMBER) IS SELECT * FROM CONSSESU WHERE COSSMECC<>4 AND COSSSESU=SU;
BEGIN
     FOR S IN SE LOOP
         SELECT COUNT(1) 
                INTO F 
                FROM CONSSESU
                WHERE COSSSESU=S.SESUNUSE AND
                      COSSMECC<>4 AND
                      COSSPEFA IN (SELECT PEFACODI 
                                          FROM PERIFACT
                                          WHERE PEFACICL=S.SESUCICL AND
                                                PEFAANO=2014 AND PEFAMES=2);
         BEGIN
            IF F=1 THEN
               SELECT COSSCOCA
                      INTO C1 
                      FROM CONSSESU
                      WHERE COSSSESU=S.SESUNUSE AND
                            COSSMECC<>4 AND
                            COSSPEFA IN (SELECT PEFACODI 
                                          FROM PERIFACT
                                          WHERE PEFACICL=S.SESUCICL AND
                                                PEFAANO=2014 AND PEFAMES=2);
                SELECT COSSCOCA
                       INTO C2 
                       FROM CONSSESU
                       WHERE COSSSESU=S.SESUNUSE AND
                             COSSMECC<>4 AND
                             COSSPEFA IN (SELECT PEFACODI 
                                          FROM PERIFACT
                                          WHERE PEFACICL=S.SESUCICL AND
                                                PEFAANO=2014 AND PEFAMES=1);
            ELSE
                SELECT COSSCOCA
                       INTO C1 
                       FROM CONSSESU
                       WHERE COSSSESU=S.SESUNUSE AND
                             COSSMECC<>4 AND
                             COSSPEFA IN (SELECT PEFACODI 
                                          FROM PERIFACT
                                          WHERE PEFACICL=S.SESUCICL AND
                                                PEFAANO=2014 AND PEFAMES=1);
                SELECT COSSCOCA
                       INTO C2 
                       FROM CONSSESU
                       WHERE COSSSESU=S.SESUNUSE AND
                             COSSMECC<>4 AND
                             COSSPEFA IN (SELECT PEFACODI 
                                          FROM PERIFACT
                                          WHERE PEFACICL=S.SESUCICL AND
                                                PEFAANO=2013 AND PEFAMES=12);  
            END IF;
         EXCEPTION
            WHEN OTHERS THEN
                 C1:=1;
                 C2:=1;
         END;
         IF C1=0 AND C2=0 THEN
            FOR C IN CONS(S.SESUNUSE) LOOP
                SELECT COUNT(1) INTO E FROM CM_MARCCOCE WHERE MACCSESU=S.SESUNUSE AND MACCPECO=C.COSSPECS;
                IF E=0 THEN
                   INSERT INTO CM_MARCCOCE VALUES (sq_cm_marccoce_185886.NEXTVAL, S.SESUNUSE, C.COSSTCON, C.COSSPECS, DECODE(C.COSSCOCA,0,'Y','N'));
                END IF;
            END LOOP;
            COMMIT;
         END IF;         
     END LOOP;
END; 
/
