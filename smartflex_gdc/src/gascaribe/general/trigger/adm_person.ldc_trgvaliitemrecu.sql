CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALIITEMRECU
BEFORE INSERT ON GE_ITEMS_REQUEST
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
/**************************************************************************
    Autor       : Horbath
    Fecha       : 2019-12-12
    Ticket      : 226
    Descripcion : Trigger que valida que si el item esta marcado como recuperado en la
                  tabla LDCI_MATERECU solo se haga requisicion de unidad activa

    Parametros Entrada
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    
***************************************************************************/
Declare
 onuError NUMBER; --se almacena codigo de error
 osbError VARCHAR2(4000); --se almacena mensaje de error
 sbUnidadOpera VARCHAR2(4000);--se almacenan las unidades operativa activos
 sbMsj VARCHAR2(4000); --mensaje de error
 nuExisteItem NUMBER;  --se almacena si existe el items como recuperado
 sbDatos VARCHAR2(1);--se alamcena resultado de validacion del centreo logistico

 --se valdia si el centro logistivo es activo
 CURSOR cuValiCentroActivo IS
 SELECT 'X'
 FROM GE_ITEMS_DOCUMENTO i
 WHERE i.ID_ITEMS_DOCUMENTO = :new.ID_ITEMS_DOCUMENTO
  AND I.DESTINO_OPER_UNI_ID IN ( SELECT to_number(regexp_substr(sbUnidadOpera,'[^;]+', 1, LEVEL)) AS titr
                              FROM   dual
                              CONNECT BY regexp_substr(sbUnidadOpera, '[^;]+', 1, LEVEL) IS NOT NULL);

begin
  IF FBLAPLICAENTREGAXCASO('0000226') THEN
   ut_trace.trace('INICIA  -LDC_TRGVALIITEMRECU DOCUMENTO'||:new.ID_ITEMS_DOCUMENTO,10);
	LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_RESERVA_MATERIALES', 'LST_CENTROS_SOL_ACT', sbUnidadOpera, sbMsj); --se obtienen unidad operativas activo
	ut_trace.trace('UNIDADES OPERATIVAS '||sbUnidadOpera,10);
     --se valida si el items es recuperado
     SELECT COUNT(1) INTO nuExisteItem
     FROM LDCI_MATERECU
     WHERE ITEMS_ID = :NEW.ITEMS_ID;
     ut_trace.trace('ITEMS '||:NEW.ITEMS_ID||' EXISTE '||nuExisteItem,10);
     IF nuExisteItem > 0 THEN

		OPEN cuValiCentroActivo;
        FETCH cuValiCentroActivo INTO sbdatos;
        IF cuValiCentroActivo%NOTFOUND THEN
            ERRORS.SETERROR (2741, 'El items recuperado ['||:NEW.ITEMS_ID||'-'||dage_items.fsbgetdescription(:NEW.ITEMS_ID,null)||'] solo se puede solicitar como activo');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        CLOSE cuValiCentroActivo;

     END IF;
  END IF;
ut_trace.trace('FIN  -LDC_TRGVALIITEMRECU' ,10);
exception
  WHEN ex.CONTROLLED_ERROR then
    Errors.geterror(onuError, osbError);
    raise ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
  osbError := 'Error no controlado: '||sqlerrm ||
                     DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
    raise ex.CONTROLLED_ERROR;
end LDC_TRGVALIITEMRECU;
/
