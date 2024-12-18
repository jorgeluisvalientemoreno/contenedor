CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGAUASIGAUTO
AFTER UPDATE ON OPEN.OR_ORDER_ACTIVITY
--BEFORE INSERT ON OR_ORDER_ACTIVITY
/**************************************************************
  Propiedad intelectual de peti.

  Trigger      : LDC_TRGAUASIGAUTO
  Descripcion  : trigger de asignacion automatica a la cada ot
                 Despues de ser registrada en la entidad.
  Autor        : jorge luis valiente moreno
  Fecha        : 11/11/2013

  Historia de modificaciones
  Fecha        identrega               modificacion
  26/06/2019   200-2391                se modiica para que se guarde al causal de la orden que se esta legalizando
  **************************************************************/
DECLARE

  SBDATAIN varchar2(4000);

  CURSOR CUOR_ORDER_1 IS
    SELECT * FROM OR_ORDER_1;

  NUUO NUMBER;

  onuerrorcode    NUMBER;
  osberrormessage VARCHAR2(4000);
  sbFlagAsignar  VARCHAR2(2) := 'N';

BEGIN

  UT_TRACE.TRACE('INICIO LDC_TRGARSIGAUTO', 10);

  LDC_BOASIGAUTO.PRREGSITROASIGAUTO(NULL, NULL, 'LDC_TRGARSIGAUTO');

  FOR TEMPCUOR_ORDER_1 IN CUOR_ORDER_1 LOOP
    NUUO := TEMPCUOR_ORDER_1.OPERATING_UNIT_ID;

    /*
    LDC_BOASIGAUTO.PRREGSITROASIGAUTO(NULL,
                                      TEMPCUOR_ORDER_1.ORDER_ID,
                                      'LDC_TRGARSIGAUTO ORDEN POR ASIGNAR');
    --*/
    BEGIN

      os_assign_order(TEMPCUOR_ORDER_1.ORDER_ID,
                      NUUO,
                      sysdate,
                      sysdate,
                      onuerrorcode,
                      osberrormessage);

      IF onuerrorcode <> 0 THEN
        LDC_BOASIGAUTO.PRREGSITROASIGAUTO(NULL,
                                          TEMPCUOR_ORDER_1.ORDER_ID,
                                          'UNIDAD DE TRABAJO [' || NUUO ||
                                          ']  CODIGO [' || onuerrorcode ||
                                          '] DESCRIPCION [' ||
                                          osberrormessage || ']');
      ELSE
        LDC_BOASIGAUTO.PRREGSITROASIGAUTO(NULL,
                                          TEMPCUOR_ORDER_1.ORDER_ID,
                                          'LDC_TRGARSIGAUTO ASIGNO ORDEN');
        EXIT WHEN onuerrorcode = 0;
      END IF;

    EXCEPTION
      WHEN OTHERS then
        SBDATAIN := 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                    DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                    DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

        LDC_BOASIGAUTO.PRREGSITROASIGAUTO(NULL,
                                          TEMPCUOR_ORDER_1.ORDER_ID,
                                          'EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
                                          SBDATAIN || ']');
    END;

  END LOOP;

  UT_TRACE.TRACE('FIN LDC_TRGARSIGAUTO', 10);
  --INICIO CA 200-2391
  IF fblaplicaentrega(LDC_PKGASIGNARCONT.FSBVERSION) THEN
     sbFlagAsignar := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ASIGCONT', Null);  --TICKET 200-810 LJLB -- se consulta si se va asignar el contrato o no
  END IF;

  IF sbFlagAsignar = 'S' THEN
	PRGUARDATMPCAUSAL;
  END IF;
  --FIN CA 200-2391

EXCEPTION
WHEN OTHERS THEN
    UT_TRACE.TRACE('INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                   DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                   DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']',
                   10);

END LDC_TRGAUASIGAUTO;
/
