create or replace FUNCTION adm_person.FNUGETVALIDAESPERALEGA (solicitud in mo_packages.PACKAGE_ID%type) RETURN NUMBER IS

/**************************************************************************
        Autor       : Esantiago / Horbath
        Fecha       : 10-06-2019
        Ticket      : 200-2687
        Descripción : Función para validar que la solicitud se encuente en 
					  el proceso 'Espera Legalización de Ordenes'.

        Parámetros Entrada
        
         solicitud   numero de solicitud que en tramite.
        

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
		02/01/2024	cgonzalez	OSF-2095: Migrar del esquema OPEN al esquema ADM_PERSON
***************************************************************************/
   
   val number:=1;
   unit number;
   cant number;
   
CURSOR cugetvalproc(NUSOLICITUD number) IS   
SELECT COUNt(1)
FROM WF_INSTANCE I, wf_data_external P 
WHERE P.PACKAGE_id = NUSOLICITUD  
    AND P.PLAN_ID = I.PLAN_ID
    AND I.UNIT_ID = dald_parameter.fnugetnumeric_value('PARMUNIT',null) --402
    AND STATUS_ID = 4;
   

  BEGIN

		OPEN cugetvalproc(solicitud);
        FETCH cugetvalproc INTO cant;
        CLOSE cugetvalproc;   
		
		IF(cant = 0)THEN		  
		val :=0;		
		END IF;	
     
        return(val);

EXCEPTION
    when others then
      return(val);
END FNUGETVALIDAESPERALEGA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETVALIDAESPERALEGA', 'ADM_PERSON');
END;
/