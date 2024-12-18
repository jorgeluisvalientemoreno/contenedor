CREATE OR REPLACE PACKAGE adm_person.ldc_actuapericose IS

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  20/06/2024   Adrianavg   OSF-2848: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
 PROCEDURE processActuaPeriodos (inuPeriodo     IN  pericose.pecscons%type,
                                                      inuRegistro   IN  number,
                                                      inuTotal      IN  number,
                                                      onuErrorCode  OUT number,
                                                      osbErrorMess  OUT varchar2);

 FUNCTION frfgetPeriodosCon RETURN constants.tyRefCursor;

END LDC_ACTUAPERICOSE;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_ACTUAPERICOSE IS

    /**************************************************************************
    Funcion     :  processActuaPeriodos
    Descripcion : Proceso que actualiza los periodos de consumo seleccionados
    Autor       : Cesar Figueroa
    Fecha       : 07/01/2020

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    **************************************************************************/
    PROCEDURE processActuaPeriodos (inuPeriodo     IN  pericose.pecscons%type,
                                                      inuRegistro   IN  number,
                                                      inuTotal      IN  number,
                                                      onuErrorCode  OUT number,
                                                      osbErrorMess  OUT varchar2) AS

    nuErrorCode             NUMBER;
    sbErrorMessage          VARCHAR2(4000);
    sbUser varchar2(50);

    BEGIN

    select user
    INTO sbUser
    from dual;

    update pericose
    set PECSPROC = 'S', PECSFLAV = 'S'
    where pecscons = inuPeriodo;

    INSERT INTO LDC_LOG_APC values (inuPeriodo, sysdate, sbUser);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    end processActuaPeriodos;

    /**************************************************************************
    Funcion     :  frfgetPeriodosCon
    Descripcion : Funcion que obtiene los periodos de consumo
    Autor       : Cesar Figueroa
    Fecha       : 07/01/2020

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    **************************************************************************/
FUNCTION frfgetPeriodosCon
RETURN constants.tyRefCursor IS

        ocuCursor     constants.tyRefCursor;
        sbSql            varchar2(4000);
        sbCiclo         ge_boInstanceControl.stysbValue;

    BEGIN

    UT_Trace.Trace('Inicia LDC_ACTUAPERICOSE.frfgetPeriodosFac',8);

    sbCiclo  := ge_boInstanceControl.fsbGetFieldValue ('CICLO', 'CICLCODI');


    sbSql := 'select PECSCONS Periodo,
         PECSFECI Fecha_inicial_consumo,
         PECSFECF Fecha_final_consumo,
         PECSFLAV Cierre_critica,
         PECSPROC genera_lecturas
from open.pericose
where pecscico = '||sbCiclo||'
 and (select pefafimo
          from open.perifact
          where pefacicl = pecscico
              and pefaactu = ''S'')  > pecsfeci
order by pecsfeci asc';

    UT_Trace.Trace('Consulta: '||sbSql,8);

    open ocuCursor for sbSql;

    UT_Trace.Trace('Finaliza LDC_ACTUAPERICOSE.frfgetPeriodosCon',8);

    RETURN ocuCursor;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfgetPeriodosCon;

END LDC_ACTUAPERICOSE;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_ACTUAPERICOSE
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_ACTUAPERICOSE', 'ADM_PERSON'); 
END;
/