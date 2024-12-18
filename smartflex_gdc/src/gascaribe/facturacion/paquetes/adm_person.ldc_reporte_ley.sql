CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_REPORTE_LEY
AS
----
    PROCEDURE ProcessDLRAPIR;

    PROCEDURE ProcessLDRREPB;

    PROCEDURE ProcessLDRPGREG;

    PROCEDURE ProcessLDUSPR;

    PROCEDURE ProcessLDRRECOPR;

    PROCEDURE ProcessLDRCONCDE;

    PROCEDURE ProcessLDCRBAI_CIE;

    PROCEDURE ProcessLDRGPRCB;

    PROCEDURE ProcessDLRESPOPB;

END LDC_REPORTE_LEY;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_REPORTE_LEY
AS
---
    PROCEDURE ProcessDLRAPIR
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbFATHER_ADDRESS_ID ge_boInstanceControl.stysbValue;
    sbGEOGRAP_LOCATION_ID ge_boInstanceControl.stysbValue;
    sbDIRECTORY_ID ge_boInstanceControl.stysbValue;

    BEGIN

        sbFATHER_ADDRESS_ID := ge_boInstanceControl.fsbGetFieldValue ('AB_ADDRESS', 'FATHER_ADDRESS_ID');
        sbGEOGRAP_LOCATION_ID := ge_boInstanceControl.fsbGetFieldValue ('AB_ADDRESS', 'GEOGRAP_LOCATION_ID');
        sbDIRECTORY_ID := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'DIRECTORY_ID');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbFATHER_ADDRESS_ID is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Departamento');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbGEOGRAP_LOCATION_ID is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Localidad');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbDIRECTORY_ID is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Directorio Reporte');
            raise ex.CONTROLLED_ERROR;
        end if;


        ------------------------------------------------
        -- User code
        ------------------------------------------------

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessDLRAPIR;

    --------------------------------------------------------------------------------------------------------------

    PROCEDURE ProcessLDRREPB
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbOBJECT_TYPE_ID ge_boInstanceControl.stysbValue;
    sbTEPFANO ge_boInstanceControl.stysbValue;
    sbTEPFMES ge_boInstanceControl.stysbValue;

    BEGIN

        sbOBJECT_TYPE_ID := ge_boInstanceControl.fsbGetFieldValue ('GE_OBJECT_TYPE', 'OBJECT_TYPE_ID');
        sbTEPFANO := ge_boInstanceControl.fsbGetFieldValue ('TEMPPEFA', 'TEPFANO');
        sbTEPFMES := ge_boInstanceControl.fsbGetFieldValue ('TEMPPEFA', 'TEPFMES');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbOBJECT_TYPE_ID is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Tipo de reporte');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbTEPFANO is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbTEPFMES is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
            raise ex.CONTROLLED_ERROR;
        end if;


        ------------------------------------------------
        -- User code
        ------------------------------------------------

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessLDRREPB;

    --------------------------------------------------------------------------------------------------------------
    PROCEDURE ProcessLDRPGREG
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbOBJECT_TYPE_ID ge_boInstanceControl.stysbValue;
    sbTEPFANO ge_boInstanceControl.stysbValue;
    sbTEPFMES ge_boInstanceControl.stysbValue;

    sbEnEjec      ld_parameter.value_chain%type := DALD_PARAMETER.fsbGetValue_Chain('FLAG_EJEC_LDRPCRE');

    BEGIN


        sbTEPFANO := ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAANO');
        sbTEPFMES := ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAMES');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------


        if (sbTEPFANO is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbTEPFMES is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
            raise ex.CONTROLLED_ERROR;
        end if;

        if sbEnEjec = 'S' then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'PROCESO ESTA EN EJECUCION ... DEBE ESPERAR QUE TERMINE');
            raise ex.CONTROLLED_ERROR;
        end if;
        ------------------------------------------------
        -- User code
        ------------------------------------------------

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessLDRPGREG;

  --------------------------------------------------------------------------------------------------------------
    PROCEDURE ProcessLDUSPR
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbOBJECT_TYPE_ID ge_boInstanceControl.stysbValue;
    sbTEPFANO ge_boInstanceControl.stysbValue;
    sbTEPFMES ge_boInstanceControl.stysbValue;

    BEGIN


        sbTEPFANO := ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAANO');
        sbTEPFMES := ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAMES');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------


        if (sbTEPFANO is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbTEPFMES is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
            raise ex.CONTROLLED_ERROR;
        end if;


        ------------------------------------------------
        -- User code
        ------------------------------------------------

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessLDUSPR;
  --------------------------------------------------------------------------------------------------------------

    PROCEDURE ProcessLDRRECOPR
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbTEPFANO        ge_boInstanceControl.stysbValue;
    sbTEPFMES        ge_boInstanceControl.stysbValue;
    sbOBJECT_TYPE_ID ge_boInstanceControl.stysbValue;
    sbCICLCODI       ge_boInstanceControl.stysbValue;

    nuanoact         number;
    nuciclo          open.ciclo.ciclcodi%type;

   cursor cuCiclo (cnuciclo open.ciclo.ciclcodi%type) is
    SELECT ciclcodi
      FROM OPEN.CICLO
     where ciclcodi = cnuciclo;

    BEGIN
        sbTEPFANO := ge_boInstanceControl.fsbGetFieldValue ('TEMPPEFA', 'TEPFANO');
        sbTEPFMES := ge_boInstanceControl.fsbGetFieldValue ('TEMPPEFA', 'TEPFMES');
        sbOBJECT_TYPE_ID := ge_boInstanceControl.fsbGetFieldValue ('GE_OBJECT_TYPE', 'OBJECT_TYPE_ID');
        sbCICLCODI := ge_boInstanceControl.fsbGetFieldValue ('CICLO', 'CICLCODI');

        select to_number(TO_CHAR(SYSDATE,'YYYY')) into nuanoact from dual;
        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbOBJECT_TYPE_ID is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'TIPO DE REPORTE');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbTEPFANO is null or sbTEPFANO < 2000 or sbTEPFANO > nuanoact) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?O INVALIDO');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbTEPFMES is null or sbTEPFMES < 1 or sbTEPFMES > 12) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'MES INVALIDO');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbCICLCODI is null ) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'CICLO NO PUEDE SER NULO');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbOBJECT_TYPE_ID = 3 and (sbCICLCODI = -1 )) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'DEBE ESCOGER UN CICLO');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbOBJECT_TYPE_ID != 3 and sbCICLCODI != -1 ) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'CICLO DEBE SER -1');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbOBJECT_TYPE_ID = 3 and sbCICLCODI != -1 ) then
          open cuciclo(sbCICLCODI);
          fetch cuciclo into nuciclo;
          if cuciclo%notfound then
            close cuciclo;
            Errors.SetError (cnuNULL_ATTRIBUTE, 'CICLO NO EXISTE');
            raise ex.CONTROLLED_ERROR;
          else
            close cuciclo;
          end if;
        end if;

       ------------------------------------------------
        -- User code
        ------------------------------------------------

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessLDRRECOPR;

--------------------------------------------------------------------------------------------------------------
    PROCEDURE ProcessLDRCONCDE
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbTPPRODUCTO ge_boInstanceControl.stysbValue;
    sbTEPFANO ge_boInstanceControl.stysbValue;
    sbTEPFMES ge_boInstanceControl.stysbValue;

    BEGIN

        sbTPPRODUCTO := ge_boInstanceControl.fsbGetFieldValue ('SERVICIO', 'SERVCODI');
        sbTEPFANO := ge_boInstanceControl.fsbGetFieldValue ('TEMPPEFA', 'TEPFANO');
        sbTEPFMES := ge_boInstanceControl.fsbGetFieldValue ('TEMPPEFA', 'TEPFMES');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbTPPRODUCTO is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Tipo de producto');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbTEPFANO is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbTEPFMES is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
            raise ex.CONTROLLED_ERROR;
        end if;


        ------------------------------------------------
        -- User code
        ------------------------------------------------

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessLDRCONCDE;

 --------------------------------------------------------------------------------------------------------------

    PROCEDURE ProcessLDCRBAI_CIE
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;
    nuAnoAct number;


    BEGIN

       ------------------------------------------------
        -- User code
        ------------------------------------------------
     nuanoact := 2000; -- se puso cualquier cosa ya que se requiere que el PB tenga un procedimniento de validacion
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessLDCRBAI_CIE;

 --------------------------------------------------------------------------------------------------------------

    PROCEDURE ProcessLDRGPRCB
    IS
	/*******************************************************************************************************************

	   HISTORIA DE MODIFICACIONES
		FECHA              AUTOR                             DESCRIPCION
	 27/OCT/2020  John Jairo Jimenez Marimon(JJJJM)   CA533 Se agregan los parametros sbtipdef(Tipo de diferido)
                                                            y sbamormm(AmortizaciÃ³n mes a mes).
															Se invoca el procedimiento ldc_consultapercier para
															que valide si existe informaciÃ³n para el periodo digitado
    ********************************************************************************************************************/


    cnuNULL_ATTRIBUTE constant number := 2126;

    sbTEPFANO         ge_boInstanceControl.stysbValue;
    sbTEPFMES         ge_boInstanceControl.stysbValue;
    sbPRODUCT_TYPE_ID ge_boInstanceControl.stysbValue;
    sbtipdef          ge_boInstanceControl.stysbValue;
    sbamormm          ge_boInstanceControl.stysbValue;
    nmvalordif        NUMBER(10);


    nuanoact         number;
    nuserv          open.pr_product.product_type_id%type;

   cursor cuServ (cnuserv open.servicio.servcodi%type) is
    select servcodi
      from OPEN.SERVICIO
     where servcodi =  cnuserv;

    BEGIN
        sbTEPFANO         := ge_boInstanceControl.fsbGetFieldValue ('TEMPPEFA', 'TEPFANO');
        sbTEPFMES         := ge_boInstanceControl.fsbGetFieldValue ('TEMPPEFA', 'TEPFMES');
        sbPRODUCT_TYPE_ID := ge_boInstanceControl.fsbGetFieldValue ('PR_PRODUCT', 'PRODUCT_TYPE_ID');
		-- CA533 JJJM
        sbtipdef          := ge_boInstanceControl.fsbGetFieldValue ('SM_STATUS', 'DESCRIPTION');
        sbamormm          := ge_boInstanceControl.fsbGetFieldValue ('SM_EVENTS_CONF', 'IS_INITIALIZATION');


        select to_number(TO_CHAR(SYSDATE,'YYYY')) into nuanoact from dual;
        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbTEPFANO is null or sbTEPFANO < 2000 or sbTEPFANO > nuanoact) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?O INVALIDO');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbTEPFMES is null or sbTEPFMES < 1 or sbTEPFMES > 12) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'MES INVALIDO');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbPRODUCT_TYPE_ID is null or sbPRODUCT_TYPE_ID = -1) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'TIPO PRODUCTO INVALIDO');
            raise ex.CONTROLLED_ERROR;
        end if;
		-- Inicio CA533 JJJM
		if (sbtipdef is null) then
         Errors.SetError (cnuNULL_ATTRIBUTE, 'Tipo de diferido');
         raise ex.CONTROLLED_ERROR;
       end if;

       if (sbamormm is null) then
         Errors.SetError (cnuNULL_ATTRIBUTE, 'Amortizaci?n mes a mes');
         raise ex.CONTROLLED_ERROR;
       end if;
	   -- Fin CA533 JJJM

          open cuServ (sbPRODUCT_TYPE_ID);
          fetch cuServ into nuServ;
          if cuServ%notfound then
            close cuServ;
            Errors.SetError (cnuNULL_ATTRIBUTE, 'TIPO PRODUCTO NO EXISTE');
            raise ex.CONTROLLED_ERROR;
          else
            close cuServ;
          end if;

         -- CA533 JJJM
		 ldc_consultapercier(
                             sbtepfano
			     	        ,sbtepfmes
    					    ,nmvalordif
		    			    );

         IF nmvalordif = 0 THEN
          Errors.SetError (cnuNULL_ATTRIBUTE, 'No se ha generado la informaci?n de los diferidos para el periodo de cierre : '||sbtepfano||' - '||sbtepfmes);
          raise ex.CONTROLLED_ERROR;
         END IF;


       ------------------------------------------------
        -- User code
        ------------------------------------------------

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessLDRGPRCB;
--------------------------------------------------------------------------------------------------------------

PROCEDURE ProcessDLRESPOPB
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    dtFecha_inicial_creacion   ge_boInstanceControl.stysbValue;
    dtFecha_final_creacion               ge_boInstanceControl.stysbValue;
    dtFecha_inicial_cancelacion       ge_boInstanceControl.stysbValue;
    dtFecha_final_cancelacion         ge_boInstanceControl.stysbValue;


    BEGIN
        dtFecha_inicial_creacion :=         ge_boInstanceControl.fsbGetFieldValue ('LD_POLICY', 'DTCREATE_POLICY');
        dtFecha_final_creacion :=         ge_boInstanceControl.fsbGetFieldValue ('LD_POLICY', 'DT_EN_POLICY');
        dtFecha_inicial_cancelacion := ge_boInstanceControl.fsbGetFieldValue ('LD_POLICY', 'DT_IN_POLICY');
        dtFecha_final_cancelacion := ge_boInstanceControl.fsbGetFieldValue ('LD_POLICY', 'DTRET_POLICY');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------
        if dtFecha_inicial_creacion is not null and dtFecha_final_creacion is null then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Debe digitar la fecha de creacion final');
            raise ex.CONTROLLED_ERROR;
        end if;

        if dtFecha_inicial_creacion is null and dtFecha_final_creacion is not null then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Debe digitar la fecha de creacion inicial');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (dtFecha_inicial_creacion is not null and to_date(dtFecha_inicial_creacion) >  to_date(dtFecha_final_creacion)) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Fecha inicial no debe ser mayor a la final');
            raise ex.CONTROLLED_ERROR;
        end if;

        if dtFecha_inicial_cancelacion is not null and dtFecha_final_cancelacion is null then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Debe digitar la fecha de cancelacion final');
            raise ex.CONTROLLED_ERROR;
        end if;

        if dtFecha_inicial_cancelacion is null and dtFecha_final_cancelacion is not null then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Debe digitar la fecha de cancelacion inicial');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (dtFecha_inicial_cancelacion is not null and to_date(dtFecha_inicial_cancelacion) >  to_date(dtFecha_final_cancelacion)) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Fecha inicial no debe ser mayor a la final');
            raise ex.CONTROLLED_ERROR;
        end if;



       ------------------------------------------------
        -- User code
        ------------------------------------------------

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessDLRESPOPB;
--------------------------------------------------------------------------------------------------------------

END LDC_REPORTE_LEY;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_REPORTE_LEY', 'ADM_PERSON'); 
END;
/