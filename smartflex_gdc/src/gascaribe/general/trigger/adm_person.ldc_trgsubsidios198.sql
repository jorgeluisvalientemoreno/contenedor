CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGSUBSIDIOS198
BEFORE insert or  UPDATE  ON OR_ORDER_ACTIVITY
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
WHEN (NEW.ORDER_ID IS NOT NULL)

/*******************************************************************************
    Metodo:       LDC_TRGSUBSIDIOS198
    Descripcion:  TRIGGER QUE SE ENCARGA DE VALIDAR SI SON REGISTRADAS ORDENES EN EL PROCESO
				  DEL REGISTRO DE VENTA DE GAS COTIZADA Y POR FORMULARIO CASO 198

    Autor:        Olsoftware/Miguel Ballesteros
    Fecha:        30/01/2020

    Historia de Modificaciones
    FECHA        		AUTOR                       		DESCRIPCION
	12/05/2020			Olsoftware/Miguel Ballesteros		modificacion del trigger, se comenta una sentencia del cursor ValTaskType
															que estaba presentando errores al realizar el proceso de asignacion de ordenes
	21/10/2024			jpinedc                     		OSF-3450: Se migra a ADM_PERSON
*******************************************************************************/
DECLARE

  VALSOL      NUMBER;
  VALTTYPE    NUMBER;
  VALSUBSI    NUMBER;

    CURSOR ValTypeSoli is
    SELECT 1
      FROM MO_PACKAGES M
      WHERE M.PACKAGE_ID = :NEW.PACKAGE_ID
      AND   M.PACKAGE_TYPE_ID IN (select To_Number(column_value)
									from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('LDC_PARTYPESOL', NULL), ',')));


  CURSOR ValTaskType is
	 SELECT 1
      FROM dual
	  where :new.TASK_TYPE_ID IN (select To_Number(column_value)
									from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('LDC_PARTTCASO198', NULL), ',')));
    /*SELECT 1
      FROM OR_ORDER O
      WHERE O.ORDER_ID = :NEW.ORDER_ID
      AND   O.TASK_TYPE_ID IN (select To_Number(column_value)
									from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('LDC_PARTTCASO198', NULL), ',')));*/

  CURSOR ValSoliSub is
    select COUNT(1)
      from ldc_subsidios s
      where package_id = :NEW.PACKAGE_ID;

      nuerror number;
      sberror varchar2(4000);

BEGIN
        -- Se lanzara despues de cada fila actualizada

      OPEN ValTypeSoli;
      FETCH ValTypeSoli INTO VALSOL;
      CLOSE ValTypeSoli;

      IF VALSOL > 0 THEN

        OPEN ValTaskType;
        FETCH ValTaskType INTO VALTTYPE;
        CLOSE ValTaskType;

        IF VALTTYPE > 0 THEN

          OPEN ValSoliSub;
          FETCH ValSoliSub INTO VALSUBSI;
          CLOSE ValSoliSub;

          IF VALSUBSI = 0 THEN

            LDC_PRSETSUBSIDIOS(:NEW.PACKAGE_ID);

          END IF;

        END IF;

      END IF;


EXCEPTION
   WHEN EX.CONTROLLED_ERROR THEN
      errors.geterror(nuerror, sberror);
     raise EX.CONTROLLED_ERROR;
   WHEN OTHERS THEN
     ERRORS.SETERROR;
   RAISE EX.CONTROLLED_ERROR;

END LDC_TRGSUBSIDIOS198;
/
