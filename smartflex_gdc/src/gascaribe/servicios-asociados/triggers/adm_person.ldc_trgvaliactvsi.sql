CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALIACTVSI
BEFORE insert OR UPDATE ON LDC_COTTCLAC
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
/*************************************************************************************************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Funcion     :  LDC_TRGVALIACTVSI
    Descripcion :  valida que no se inserte una actividad que no este en PSESA
    Ticket		:	200-2630
    Autor       : Horbath
    Fecha       : 22-08-2019

**************************************************************************************************************************************************************/

DECLARE
 sbmensaje varchar2(4000);
 error number;
 sbdato VARCHAR2(1);

 --se valida si actividad esta configurada en psesa
 CURSOR cuValdiaActividad IS
 SELECT 'X'
 FROM    ps_engineering_activ a
 WHERE   a.items_id = :NEW.COCLACTI
    AND     a.product_type_id IS null
    AND     a.pay_modality in (2,4);

BEGIN

  IF :NEW.COCLACTI IS NOT NULL THEN
    OPEN cuValdiaActividad;
    FETCH cuValdiaActividad INTO sbdato;
    IF cuValdiaActividad%notfound THEN
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'Actividad ['||:NEW.COCLACTI||'] no esta configurada en PSESA con Modalidad 2 y 4 ');
    END IF;
    CLOSE cuValdiaActividad;

  END IF;

Exception
  when ex.CONTROLLED_ERROR then
        Errors.getError(error, sbmensaje);
    raise;
  when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

END;
/
