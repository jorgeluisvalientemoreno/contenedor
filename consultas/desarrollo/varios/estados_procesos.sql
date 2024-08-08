--FGCC SE PUEDE VOLVER A EJECUTAR SI Y SOLO SI EN PROCEJEC ESTA EN E Y HAY SUSCNUPR EN 2
SELECT *
  FROM OPEN.estaprog
  where esprfein>='08/11/2017'
    --and esprfefi<'05/09/2017'                    
  and UPPER(esprprog) like 'LDCPAO%'
  order by esprfein;
  
  SELECT *
  FROM OPEN.PERIFACT
  WHERE PEFACODI IN (394962,394963);
  
  select *
  from gv$session
  where username in ('JOVANG','OPEN');
  
SELECT *
FROM OPEN.CONCPROC
WHERE COPRPROG like 'FGCC'
 AND COPRFERE>='10/10/2017';
 
SELECT *
FROM OPEN.GE_ERROR_LOG
WHERE ERROR_LOG_ID=1103863662;

 SELECT *
 FROM OPEN.ESTAPROG
 WHERE ESPRPROG LIKE '%FGCC%'
  AND ESPRFEIN>='20/10/2017'
  ;
  
  SELECT *
  FROM OPEN.PROCEJEC
  WHERE PREJFECH>='19/10/2017'
  AND PREJCOPE=34022;
  
SELECT * FROM ldc_log_pb WHERE ldlpproc =  'PBRCD' ORDER BY 5 desc
  
  SELECT *
  FROM OPEN.ESPRSEPE
  WHERE EPSPIDPR LIKE '%FGCC%';
  
  SELECT  *
        FROM    open.concproc
        WHERE   coprprog = 'FGCC'
                AND  copresta = 'E';
                
                  select *
  from open.reportes,  open.repoinco
  where repofech>='19/10/2017 17:00:00'
  AND REPOFECH<'20/10/2017'
   --and repoapli='FIDF'
   AND  reinrepo=reponume;
  where reponume in (230865,  230866, 230867, 230868);

select repofech, reinobse,substr(reinobse,51, instr(reinobse,']',1,2)-instr(reinobse,'[',1,2)-1),  sesuesco, product_status_id, sesuesfn, reportes.*
from open.repoinco, open.reportes, open.servsusc s, open.pr_product p
where reinrepo=reponume
and repofech>='01/01/2017'
AND REPOFECH<'01/02/2017'
and repoapli='FIDF'
and p.product_id=sesunuse
and sesususc=substr(reinobse,51, instr(reinobse,']',1,2)-instr(reinobse,'[',1,2)-1)
and sesuserv=7014
and reinobse like '%[Tipo Documento: 66] Error procesando el contrato[%]: No se encontr� producto %'
--group by repofech, reinobse, sesuesco, product_status_id, sesuesfn
;




select *
from OPEN.CONFESCO
where coecserv=7014;
select *
from open.hicaesco
where hcecsusc IN (1090029,649281 )
order by hcecsusc, hcecfech desc;

select *
from open.factura
where factsusc=203858
order by factfege desc;
  --1:07
  --1:26
  --1:00r
  
select *
from open.hicaesco
where hcecsusc in (78196)
and hcecfech>='01/09/2017';
select *
from open.servsusc
where sesususc in (649281)
--sesususc=512036
  and sesuserv=7014;
  select *
  from open.ge_Database_version
  where install_init_date>='22/12/2016'
  and install_init_date<'06/01/2017';
  
  SELECT *
FROM OPEN.LDCI_ESTAPROC
WHERE  PROCFEIN>='07/11/2017'
 --and proccodi=35084495;
 and procdefi='WS_ENVIO_ORDENES'
 and procpara like '%<VALOR>242</VALOR>%';
 
 
 OPEN.GE_CONTROL_PROCESS	OPEN.GE_RECORD_PROCESS
 
 SELECT *
FROM OPEN.GE_CONTROL_PROCESS C, OPEN.GE_OBJECT  O, OPEN.GE_RECORD_PROCESS H
WHERE RECORD_INITIAL_DATE>='19/09/2017'
AND RECORD_INITIAL_DATE<'20/09/2017'
AND O.OBJECT_ID=C.OBJECT_ID
AND DESCRIPTION='LDC - GENERA ORDEN DE PERSECUCION CONSUMO CERO - GOPC'
AND H.CONTROL_PROCESS_ID= C.CONTROL_PROCESS_ID;

select R.EXEC_INITIAL_DATE
from open.GE_CONTROL_PROCESS P, OPEN.GE_RECORD_PROCESS R
WHERE P.CONTROL_PROCESS_ID=176495
  AND R.CONTROL_PROCESS_ID=P.CONTROL_PROCESS_ID
  AND TO_CHAR(R.ARGUMENTS)='INUPRODUCT_ID=>1013014';
  


SELECT *
FROM OPEN.Ge_Statement
WHERE UPPER(STATEMENT) LIKE '%FECHA_MARCACI�N_CONSUMO%';
select *
from open.GE_REPORT_STATEMENT s, open.sa_executable e
where statement_id=120118776
  and s.executable_id=e.executable_id;
