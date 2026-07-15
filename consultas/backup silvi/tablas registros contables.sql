select * from IC_TIPOMOVI ; --63 y 64 
select * from IC_TIPODOCO  ;--77 actas
select * from IC_TICOCONT  ; --Tipo de comprobante 4 - L7 ACTAS

-- Consulta básica para ver los datos de cada tabla con sus alias

SELECT * FROM OPEN.IC_COMPCONT A where cococodi = 77;
SELECT * FROM OPEN.IC_CONFRECO C where c.corccoco= 77;
SELECT * FROM OPEN.IC_CLASCORE F where f.clcrcorc in (100359 , 100358);
SELECT * FROM OPEN.IC_CLASCONT G where G.CLCOCODI in (SELECT  F.CLCRCLCO FROM OPEN.IC_CLASCORE F where f.clcrcorc in (100359 , 100358)) ; 
SELECT * FROM OPEN.IC_RECOCLCO I where  I.RCCCCLCR in (SELECT F.CLCRCONS FROM OPEN.IC_CLASCORE F where f.clcrcorc in (100359 , 100358));
