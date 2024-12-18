CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDC_CONDIT_COMMERC_SC
  BEFORE INSERT OR UPDATE ON LDC_CONDIT_COMMERC_SEGM
  FOR EACH ROW

DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    cnunull_attribute CONSTANT NUMBER := 2741;
    nuTimeC NUMBER;
    nuTimeM NUMBER;
    nuTimeL NUMBER;
    nuTimeN NUMBER;
    nuTimeR NUMBER;

       cursor cu_Segm_FutC is
       select Nvl(sc.TIME,0) time
         from open.LDC_CONDIT_COMMERC_SEGM sc
        where cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTURO')
          AND active = 'Y';

       cursor cu_Segm_FutM is
       select Nvl(sc.TIME,0) time
         from open.LDC_CONDIT_COMMERC_SEGM sc
        where cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTUROM')
        AND active = 'Y';

        cursor cu_Segm_FutL is
       select Nvl(sc.TIME,0) time
         from open.LDC_CONDIT_COMMERC_SEGM sc
        where cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTUROL')
        AND active = 'Y';

         cursor cu_Segm_NueR is
       select Nvl(sc.TIME,0) time
         from open.LDC_CONDIT_COMMERC_SEGM sc
        where cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_NUEVORE')
        AND active = 'Y';

         cursor cu_Segm_Nue is
       select Nvl(sc.TIME,0) time
         from open.LDC_CONDIT_COMMERC_SEGM sc
        where cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_NUEVO')
        AND active = 'Y';



BEGIN

        OPEN cu_Segm_FutC;
        FETCH cu_Segm_FutC INTO nuTimeC;
        CLOSE cu_Segm_FutC;

        OPEN cu_Segm_FutM;
        FETCH cu_Segm_FutM INTO nuTimeM;
        CLOSE cu_Segm_FutM;

        OPEN cu_Segm_FutL;
        FETCH cu_Segm_FutL INTO nuTimeL;
        CLOSE cu_Segm_FutL;

        OPEN cu_Segm_Nue;
        FETCH cu_Segm_Nue INTO nuTimeN;
        CLOSE cu_Segm_Nue;

        OPEN cu_Segm_NueR;
        FETCH cu_Segm_NueR INTO nuTimeR;
        CLOSE cu_Segm_NueR;


   if (:old.cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTURO')) then



      IF (:new.TIME >= nuTimeM) THEN

        errors.seterror(cnunull_attribute, 'El tiempo futuro Cercano no puede ser igual o superior al Mediano ');
        RAISE ex.controlled_error;


      end if;

   END IF;

   if (:old.cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTUROM')) then


      IF (:new.TIME >= nuTimeL) THEN

        errors.seterror(cnunull_attribute, 'El tiempo futuro Mediano no puede ser igual o superior al Lejano ');
        RAISE ex.controlled_error;


      end if;

   END IF;

   if (:old.cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTUROM')) then


      IF (:new.TIME <= nuTimeC) THEN

        errors.seterror(cnunull_attribute, 'El tiempo futuro Mediano no puede ser igual o Inferior al Cercano ');
        RAISE ex.controlled_error;


      end if;

   END IF;

  if (:old.cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTUROL')) then


      IF (:new.TIME <= nuTimeM OR :new.TIME <= nuTimeC) THEN

        errors.seterror(cnunull_attribute, 'El tiempo futuro Lejano no puede ser igual o Inferior al Mediano ó Cercano ');
        RAISE ex.controlled_error;


      end if;

   END IF;

  if (:old.cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_NUEVO')) then


      IF (:new.TIME >= nuTimeR) THEN

        errors.seterror(cnunull_attribute, 'El tiempo Nuevo Nuevo no puede ser igual o Superior al Nuevo regular');
        RAISE ex.controlled_error;


      end if;

   END IF;

   if (:old.cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_NUEVORE')) then


      IF (:new.TIME <= nuTimeN) THEN

        errors.seterror(cnunull_attribute, 'El tiempo Nuevo Regular no puede ser igual o Inferior al Nuevo Nuevo');
        RAISE ex.controlled_error;


      end if;

   END IF;

EXCEPTION
  when ex.CONTROLLED_ERROR then raise ex.CONTROLLED_ERROR;
  when others then Errors.setError; raise ex.CONTROLLED_ERROR;
END TRG_LDC_CONDIT_COMMERC_SC;
/
