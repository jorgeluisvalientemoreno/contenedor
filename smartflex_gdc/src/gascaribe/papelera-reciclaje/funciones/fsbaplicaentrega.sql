
  CREATE OR REPLACE FUNCTION "OPEN"."FSBAPLICAENTREGA" (isbEntrega VARCHAR2) RETURN VARCHAR2 IS

        blGDO      BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDO(isbEntrega);
        blEFIGAS   BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaEfigas(isbEntrega);
        blSURTIGAS BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaSurtigas(isbEntrega);
        blGDC      BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDC(isbEntrega);
    BEGIN

        -- Valida si la entrega aplica para la gasera
        IF blGDO = TRUE OR blEFIGAS = TRUE OR blSURTIGAS = TRUE OR blGDC = TRUE THEN

            RETURN 'S';
        ELSE

           RETURN 'N';
        END IF;
    END fsbAplicaEntrega;

/
