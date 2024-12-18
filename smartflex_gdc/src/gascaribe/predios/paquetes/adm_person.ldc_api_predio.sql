CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_API_PREDIO AS

/*******************************************************************************
Propiedad intelectual de PROYECTO PETI

Autor                :  Emiro Leyva Hernandez
Fecha                :  14/Feb/2013

Fecha                IDEntrega           Modificacion
============    ================    ============================================
14-Feb-2013    Emiro Leyva         Api para hacer llamado a paquete de primer nivel
                                   y realizar mantenimiento a los datos del predio
                                   para zona nueva o zona saturada

*******************************************************************************/

  --  Registro



   PROCEDURE PROInsPredio(inuPREMISE_ID       in LDC_INFO_PREDIO.PREMISE_ID%type,
                          insbIS_ZONA         in LDC_INFO_PREDIO.IS_ZONA%type,
                          inuPORC_PENETRACION in LDC_INFO_PREDIO.PORC_PENETRACION%type,
                          onuErrorCode        OUT ge_message.message_id%type,
                          osbErrorMessage     OUT ge_error_log.description%type);

   PROCEDURE PROUpdPredio(inuPREMISE_ID       in LDC_INFO_PREDIO.PREMISE_ID%type,
                          insbIS_ZONA         in LDC_INFO_PREDIO.IS_ZONA%type,
                          inuPORC_PENETRACION in LDC_INFO_PREDIO.PORC_PENETRACION%type,
                          onuErrorCode        OUT ge_message.message_id%type,
                          osbErrorMessage     OUT ge_error_log.description%type);

   PROCEDURE PROGetPredio(inuPREMISE_ID       in  LDC_INFO_PREDIO.PREMISE_ID%type,
                          onsbIS_ZONA         out LDC_INFO_PREDIO.IS_ZONA%type,
                          onuPORC_PENETRACION out LDC_INFO_PREDIO.PORC_PENETRACION%type,
                          onuErrorCode        OUT ge_message.message_id%type,
                          osbErrorMessage     OUT ge_error_log.description%type);

   PROCEDURE PRODelPredio(inuPREMISE_ID       in  LDC_INFO_PREDIO.PREMISE_ID%type,
                          onuErrorCode        OUT ge_message.message_id%type,
                          osbErrorMessage     OUT ge_error_log.description%type);

END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_API_PREDIO AS
/*******************************************************************************
Propiedad intelectual de PROYECTO PETI

Autor                :  Emiro Leyva Hernandez
Fecha                :  14/Feb/2013

Fecha                IDEntrega           Modificacion
============    ================    ============================================
14-Feb-2013    Emiro Leyva         Api para hacer llamado a paquete de primer nivel
                                   y realizar mantenimiento a los datos del predio
                                   para zona nueva o zona saturada

*******************************************************************************/

     PROCEDURE PROInsPredio(inuPREMISE_ID       in LDC_INFO_PREDIO.PREMISE_ID%type,
                            insbIS_ZONA         in LDC_INFO_PREDIO.IS_ZONA%type,
                            inuPORC_PENETRACION in LDC_INFO_PREDIO.PORC_PENETRACION%type,
                            onuErrorCode        OUT ge_message.message_id%type,
                            osbErrorMessage     OUT ge_error_log.description%type)
        IS

         nuPredio_id     LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type;

         tyrcLDC_INFO_PREDIO daLDC_INFO_PREDIO.styLDC_INFO_PREDIO;

     BEGIN

          select seq_LDC_INFO_PREDIO.nextval into nuPredio_id from dual;
          tyrcLDC_INFO_PREDIO.LDC_INFO_PREDIO_ID   := nuPredio_id;
          tyrcLDC_INFO_PREDIO.PREMISE_ID           := inuPREMISE_ID;
          tyrcLDC_INFO_PREDIO.IS_ZONA              := insbIS_ZONA;
          tyrcLDC_INFO_PREDIO.PORC_PENETRACION     := inuPORC_PENETRACION;


          DALDC_INFO_PREDIO.insRecord (tyrcLDC_INFO_PREDIO );
     EXCEPTION
        when ex.CONTROLLED_ERROR then
             raise;

        when OTHERS then
             Errors.setError;
             Errors.geterror(onuErrorCode, osbErrorMessage);

      END PROInsPredio;


     PROCEDURE PROUpdPredio(inuPREMISE_ID       in LDC_INFO_PREDIO.PREMISE_ID%type,
                            insbIS_ZONA         in LDC_INFO_PREDIO.IS_ZONA%type,
                            inuPORC_PENETRACION in LDC_INFO_PREDIO.PORC_PENETRACION%type,
                            onuErrorCode        OUT ge_message.message_id%type,
                            osbErrorMessage     OUT ge_error_log.description%type)
        IS

        nuPredio_id     LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type;
        nuOk            number := 0;
     BEGIN

          select LDC_INFO_PREDIO_ID INTO nuPredio_id from LDC_INFO_PREDIO
          WHERE PREMISE_ID = inuPREMISE_ID;


          DALDC_INFO_PREDIO.updIS_ZONA (nuPredio_id, insbIS_ZONA, nuOK );
          DALDC_INFO_PREDIO.updPORC_PENETRACION (nuPredio_id, inuPORC_PENETRACION, nuOK );
     EXCEPTION
        when ex.CONTROLLED_ERROR then
             raise;

        when OTHERS then
             Errors.setError;
             Errors.geterror(onuErrorCode, osbErrorMessage);


      END PROUpdPredio;

     PROCEDURE PROGetPredio(inuPREMISE_ID       in  LDC_INFO_PREDIO.PREMISE_ID%type,
                            onsbIS_ZONA         out LDC_INFO_PREDIO.IS_ZONA%type,
                            onuPORC_PENETRACION out LDC_INFO_PREDIO.PORC_PENETRACION%type,
                            onuErrorCode        OUT ge_message.message_id%type,
                            osbErrorMessage     OUT ge_error_log.description%type)
        IS

        nuPredio_id     LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type;
        nuOk            number := 1;
     BEGIN

          select LDC_INFO_PREDIO_ID INTO nuPredio_id from LDC_INFO_PREDIO
          WHERE PREMISE_ID = inuPREMISE_ID;


           onsbIS_ZONA:=DALDC_INFO_PREDIO.fsbGetIS_ZONA (nuPredio_id, nuOK );
           onuPORC_PENETRACION:=DALDC_INFO_PREDIO.fnuGetPORC_PENETRACION (nuPredio_id, nuOK );
     EXCEPTION
        when ex.CONTROLLED_ERROR then
             raise;

        when OTHERS then
             Errors.setError;
             Errors.geterror(onuErrorCode, osbErrorMessage);


      END PROGetPredio;

    PROCEDURE PRODelPredio(inuPREMISE_ID       in  LDC_INFO_PREDIO.PREMISE_ID%type,
                            onuErrorCode        OUT ge_message.message_id%type,
                            osbErrorMessage     OUT ge_error_log.description%type)

        IS

        nuPredio_id     LDC_INFO_PREDIO.LDC_INFO_PREDIO_ID%type;
        nuOk            number := 1;
     BEGIN

          select LDC_INFO_PREDIO_ID INTO nuPredio_id from LDC_INFO_PREDIO
          WHERE PREMISE_ID = inuPREMISE_ID;


          DALDC_INFO_PREDIO.delRecord (nuPredio_id, nuOK );
     EXCEPTION
        when ex.CONTROLLED_ERROR then
             raise;

        when OTHERS then
             Errors.setError;
             Errors.geterror(onuErrorCode, osbErrorMessage);


      END PRODelPredio;
END LDC_API_PREDIO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_API_PREDIO', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_API_PREDIO TO REXEGISOSF;
/