CREATE OR REPLACE PROCEDURE OPEN.LDC_VCriterioReconexTr(inumeserv open.servsusc.sesunuse%type) IS
    /*
        Propiedad intelectual PETI. (c).

        Procedure  : LDC_VCriterioReconexTr

        Descripcion  : Procedimiento que realiza la validacion del tipo de trabajo permitido para generar la orden.

        Parametros  :
        Retorno     :

        Autor  : Luis Fren G
        Fecha  : 28-06-2017

        Historia de Modificaciones
        ----------------------------------------------------------------------------
        Fecha           Autor                   Descripcion
        ----------------------------------------------------------------------------
		30-01-2023		cgonzalez (Horbath)		OSF-840: Se modifica cursor CU_VAL_TIPO_TRAB para usar expresion regular
*/
    --lmfg
    CURSOR CU_VAL_TIPO_TRAB IS
        SELECT COUNT(1) CONTEO
        FROM or_order o, or_order_activity a
        WHERE A.PRODUCT_ID = inumeserv
              AND
              o.task_type_id IN /*(10169,12521)*/
              (SELECT TO_NUMBER(regexp_substr( open.dald_parameter.fsbgetvalue_chain('COD_TASK_NO_RX',NULL) ,'[^|,]+', 1, level)) as tipo_trabajo
				FROM DUAL A
				CONNECT BY regexp_substr(open.dald_parameter.fsbgetvalue_chain('COD_TASK_NO_RX',NULL), '[^|,]+', 1, level) IS NOT NULL)
              AND o.order_status_id IN (5)
              AND a.order_id = o.order_id;
    csbBSS_CAR_LMF_2001135 CONSTANT VARCHAR2(30) := 'BSS_CAR_LMF_2001135_4';
    nuCONTEO NUMBER := 0;
    --lmfg
    boSuspendProduct BOOLEAN;


BEGIN
    UT_TRACE.TRACE('Inicio Procedimiento LDC_VCriterioReconexTr', 5);



    --LMFG se revisa que no existan ordenes de trabajos (10169 y 12521) en estado registrada, asignada o bloqueada
   IF fblaplicaentrega(csbBSS_CAR_LMF_2001135) THEN
        OPEN CU_VAL_TIPO_TRAB;
        FETCH CU_VAL_TIPO_TRAB
            INTO nuCONTEO;
        CLOSE CU_VAL_TIPO_TRAB;

        IF nuCONTEO > 0 THEN
            boSuspendProduct := FALSE /*TRUE*/
             ;
        END IF;
        --lmfg

        --LMFG
        IF (NOT boSuspendProduct) THEN


            UT_TRACE.TRACE('El producto [' || inumeserv ||
                           '] Tiene una orden de persecución en proceso de atención la cual debe ser legalizada"', 5);
            ERRORS.SETERROR(2741, 'El producto [' || inumeserv ||
                             '] Tiene una orden de persecución en proceso de atención la cual debe ser legalizada');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        --LMFG
    END IF;



    UT_TRACE.TRACE('Fin Procedimiento LDC_VCriterioReconexTr', 5);

    RETURN;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END LDC_VCriterioReconexTr;
/
GRANT EXECUTE ON LDC_VCriterioReconexTr TO SYSTEM_OBJ_PRIVS_ROLE,RSELOPEN,RDMLOPEN,uselopen;