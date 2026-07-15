CREATE OR REPLACE FUNCTION LDC_QA_FNUCALCULADORA(NU1    NUMBER,
                                                 NU2    NUMBER,
                                                 SBOPER VARCHAR2)
  RETURN VARCHAR2 IS
​
  TOTAL       NUMBER := 0;
  SBRESPUESTA VARCHAR2(2000) := '';
BEGIN
  TOTAL       := 0;
  SBRESPUESTA := '';
  IF SBOPER = 'S' OR SBOPER = 's' THEN
    TOTAL       := NU1 + NU2;
    SBRESPUESTA := to_char(TOTAL);
  ELSIF SBOPER = 'R' OR SBOPER = 'r' THEN
    TOTAL       := NU1 - NU2;
    SBRESPUESTA := to_char(TOTAL);
  ELSIF SBOPER = 'M' OR SBOPER = 'm' THEN
    TOTAL       := NU1 * NU2;
    SBRESPUESTA := to_char(TOTAL);
  ELSIF SBOPER = 'D' OR SBOPER = 'd' THEN
    TOTAL       := NU1 / NU2;
    SBRESPUESTA := to_char(TOTAL);
  ELSE
    SBRESPUESTA := 'OPERACION INVALIDA';
  END IF;
​
  RETURN SBRESPUESTA;
​
EXCEPTION
  WHEN OTHERS THEN
    SBRESPUESTA := 'Error no Especificado';
    RETURN SBRESPUESTA;
END;
