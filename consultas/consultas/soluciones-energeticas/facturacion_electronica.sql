-- Se valida ejecucion del JOB
SELECT *
FROM PERSONALIZACIONES.ESTAPROC
WHERE PROCESO LIKE 'PRJOBPROCESARFACELEC%';

-- Con esto se seleccionan las facturas que va a leer el JOB
SELECT perifact.pefacodi
    FROM open.perifact, open.ldc_pecofact
    WHERE perifact.pefacicl = 2201
     AND perifact.pefaactu = 'S'
     AND ldc_pecofact.pcfapefa = perifact.pefacodi
     AND ldc_pecofact.pcfaesta = 'T'
     AND  NOT EXISTS ( SELECT *--1
                        FROM OPEN.periodo_factelect
                        WHERE periodo_factelect.periodo = perifact.pefacodi
                       );

-- Con esto se valida si el JOB corrio
SELECT * FROM OPEN.periodo_factelect

-- Cuando Corre el JOB
select * from personalizaciones.factura_electronica;

begin
    pkg_bofactelectronica.prJobProcesarFacElec;
end;
/

--Enviar a la dian
begin
    "OPEN".LDCI_PKFACTELECTRONICA_EMI.PROSELFACTESOLARENVIAR;
end;
/

--colocar en estado que la vuelva a tomar el job
update personalizaciones.factura_electronica
set    estado = 5
where contrato = 67519525

select *
from open.reportes, open.repoinco
where repoapli ='JOBFACTELE'
 and reinrepo = reponume;