CREATE OR REPLACE PROCEDURE FIX_FEULLICO IS
CURSOR C1 IS
SELECT *
FROM servsusc, cuencobr, factura, (select * FROM perifact WHERE pefaano = 2014 AND pefames = 1 AND pefacicl not
in(289,186,326,138,277,290,192,18,1,69)) a , feullico WHERE sesuserv = 7055 AND sesunuse = cuconuse AND cucofact = factcodi AND factpefa = a.pefacodi AND ((cucosacu > 0 AND cucofeve < '31-01-2014')  OR (cucosacu IS null and cucofepa > cucofeve)) AND sesunuse = felisesu (+) AND feliconc = 220
AND (trunc(felifeul) != trunc(a.pefaffmo) OR felisesu IS null);
CURSOR C2 IS
SELECT DISTINCT SESUNUSE,SESUCICL
FROM servsusc, cuencobr, factura,
(select * FROM perifact WHERE pefaano = 2014 AND pefames = 1 AND pefacicl not
in(289,186,326,138,277,290,192,18,1,69)) a WHERE sesuserv = 7055 AND
sesunuse = cuconuse AND cucofact = factcodi AND factpefa = a.pefacodi AND
((cucosacu > 0 AND cucofeve < '31-01-2014')  OR (cucosacu IS null and cucofepa > cucofeve))
AND not exists (select 'y' FROM feullico WHERE cuconuse = felisesu AND feliconc = 220) ;
F DATE;
BEGIN
  FOR C IN C1 LOOP
      SELECT PEFAFFMO INTO F FROM PERIFACT WHERE PEFACICL=C.SESUCICL AND
             PEFACICL=C.SESUCICL AND PEFAANO=2014 AND PEFAMES=1;
      UPDATE FEULLICO SET FELIFEUL=F WHERE FELICONC=220 AND FELISESU=C.SESUNUSE;
  END LOOP;

  FOR C IN C2 LOOP
      SELECT PEFAFFMO INTO F FROM PERIFACT WHERE PEFACICL=C.SESUCICL AND
             PEFACICL=C.SESUCICL AND PEFAANO=2014 AND PEFAMES=1;
      INSERT INTO FEULLICO VALUES(220,C.SESUNUSE,F);
  END LOOP;
END;
/
