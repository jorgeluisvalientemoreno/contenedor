UPDATE 	master_personalizaciones 
SET 	comentario = 'MIGRADO ADM_PERSON'
WHERE   nombre IN ('FNUGETPERGRACDIFE', 'FNUGETSALDOACTCUCOCIERRE', 'FNUGETTIEMPOFUERAMEDI', 'FNUGETTOLTALPAGOS', 'FNUGETVALIDAESPERALEGA', 
				'FNU_LDC_GETSALDCONC_ORM', 'FNU_LDC_GETTIPOCONC', 'FNUSALDODIFERIDO', 'FNUSALDOPENDIENTE', 'FRCGETTECUNIDOPERTECCERT');

COMMIT;
/