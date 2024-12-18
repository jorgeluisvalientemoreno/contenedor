CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDC_CONDIT_COMMERC
  BEFORE INSERT OR UPDATE ON LDC_CONDIT_COMMERC_SEGM
  FOR EACH ROW

when (new.order_exe < 0 or new.time<>old.time or new.order_exe <> old.order_exe or new.order_exe is not null)
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    cnunull_attribute CONSTANT NUMBER := 2741;
    nuCont  number := 0;
    isNumber number := 0;

    cursor cu_ldc_commer_seg is
      select count(1)
        from ldc_condit_commerc_segm sc
       where sc.order_exe = :new.order_exe;

    cursor cu_isNumber is
      select 1
        from DUAL
       where regexp_like('12', '^[\-]?[0-9]*\.?[0-9]+$');

BEGIN

   if (:new.time <> :old.time) then
     begin
       select count(1)
         into isNumber
        from DUAL
       where regexp_like(:new.time, '^[\-]?[0-9]*\.?[0-9]+$');

     exception
       when ex.CONTROLLED_ERROR then
         raise ex.CONTROLLED_ERROR;
     end;

     if isNumber > 0 then
       if (:new.time < 0) then
         errors.seterror(cnunull_attribute, 'El campo [Tiempo] no puede ser negativo.');
        RAISE ex.controlled_error;
       end if;
     else
       errors.seterror(cnunull_attribute, 'El valor para el campo [Tiempo] debe ser numérico.');
        RAISE ex.controlled_error;
     end if;

   end if;

   if (:new.order_exe < 0) then
       errors.seterror(cnunull_attribute, 'El campo [Orden de Validación] no puede ser negativo.');
      RAISE ex.controlled_error;
   end if;

   if (:new.order_exe <> nvl(:old.order_exe,-1)) then
     open cu_ldc_commer_seg;
     fetch cu_ldc_commer_seg into nuCont;
     close cu_ldc_commer_seg;

     if nuCont >0 then
        errors.seterror(cnunull_attribute, 'Ya existe una configuración con Orden de Validación '|| :new.order_exe);
        RAISE ex.controlled_error;
     end if;

   end if;

EXCEPTION
  when ex.CONTROLLED_ERROR then raise ex.CONTROLLED_ERROR;
  when others then Errors.setError; raise ex.CONTROLLED_ERROR;
END TRG_LDC_CONDIT_COMMERC;
/
