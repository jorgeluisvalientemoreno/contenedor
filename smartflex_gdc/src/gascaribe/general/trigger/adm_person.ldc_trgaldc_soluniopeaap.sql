CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGALDC_SOLUNIOPEAAP
  AFTER INSERT OR UPDATE ON LDC_SOLUNIOPEAAP

DECLARE

  nuTotalPorcentaje NUMBER := 0;

  CURSOR CUVALORNEGATIVO IS
    SELECT SUM(LDC_SOLUNIOPEAAP.PORCENTAJE) TOTALPORCENTAJE
      FROM LDC_SOLUNIOPEAAP
     WHERE LDC_SOLUNIOPEAAP.PORCENTAJE <= 0
     GROUP BY LDC_SOLUNIOPEAAP.SOLASIAUTPOR_ID;

  RFCUVALORNEGATIVO CUVALORNEGATIVO%ROWTYPE;

  CURSOR CUSOLUNIOPEAAP IS
    SELECT SUM(LDC_SOLUNIOPEAAP.PORCENTAJE) TOTALPORCENTAJE
      FROM LDC_SOLUNIOPEAAP
     GROUP BY LDC_SOLUNIOPEAAP.SOLASIAUTPOR_ID;

  RFCUSOLUNIOPEAAP CUSOLUNIOPEAAP%ROWTYPE;

BEGIN

  FOR RFCUSOLUNIOPEAAP IN CUSOLUNIOPEAAP LOOP

    if RFCUSOLUNIOPEAAP.TOTALPORCENTAJE > 100 then
      Errors.SetError(2741,
                      'No se permite un Total Porcentaje Mayor a 100.');
      raise ex.controlled_error;
    end if;
    if RFCUSOLUNIOPEAAP.TOTALPORCENTAJE <= 0 then
      Errors.SetError(2741,
                      'No se permite un Total Porcentaje Menor o igual a 0.');
      raise ex.controlled_error;
    end if;

  END loop;

  FOR RFCUVALORNEGATIVO IN CUVALORNEGATIVO LOOP

    if RFCUVALORNEGATIVO.TOTALPORCENTAJE > 1 then
      Errors.SetError(2741,
                      'No se permite permite Porcentaje con valor negativo o igual a 0.');
      raise ex.controlled_error;
    end if;

  END loop;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    pkErrors.Pop;
    raise;

END LDC_SOLUNIOPEAAP;
/