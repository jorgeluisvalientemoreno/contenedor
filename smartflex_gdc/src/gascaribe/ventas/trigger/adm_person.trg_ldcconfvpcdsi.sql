CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCCONFVPCDSI BEFORE INSERT OR UPDATE
ON LDC_CONFVPCDSI FOR EACH ROW
/*****************************************************************
   Propiedad intelectual de GDC.

   Unidad         : TRG_LDCCONFVPCDSI
   Descripcion    : Trigger que se encarga de validar los datos registrados en la tabla
                    LDC_CONFVPCDSI
   Autor          : LJLB
   caso           : 200-1628
   Fecha          : 21/01/2018

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================

   ******************************************************************/

DECLARE
   --Ticket 2001628 LJLB -- Se valida si existe una configuracion activa
   CURSOR cuExisteConf IS
   SELECT 'X'
   FROM LDC_CONFVPCDSI
   WHERE COVPACTI = :NEW.COVPACTI
      AND (:NEW.COVPFEIN BETWEEN COVPFEIN AND COVPFEFI
         OR :NEW.COVPFEFI BETWEEN COVPFEIN AND COVPFEFI
         OR COVPFEIN BETWEEN :NEW.COVPFEIN  AND :NEW.COVPFEFI
         OR COVPFEFI BETWEEN :NEW.COVPFEIN  AND :NEW.COVPFEFI
         )
      AND COVPSUCA = :new.covpsuca
      AND COVPFLAG = 'S'
      and covpcodi <> :new.covpcodi;

 sbDato    VARCHAR2(1); --Ticket 2001628 LJLB -- Se almacena dato de si existe configuracion
 sbError   VARCHAR2(4000); --Ticket 2001628 LJLB -- Se almacena el error
 erProceso EXCEPTION;  --Ticket 2001628 LJLB -- Se almacena excepcion
PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN

  IF INSERTING THEN
     --Ticket 2001628 LJLB -- Se valida si la fecha final es menor a la fecha inicial
     IF :NEW.COVPFEFI < :NEW.COVPFEIN THEN
       sbError := 'La Fecha Final no puede ser Menor a la Fecha Inicial';
       RAISE erProceso;
     END IF;
     --Ticket 2001628 LJLB -- Se valida si existe una configuracion activa con la misma actividad
     OPEN cuExisteConf;
     FETCH cuExisteConf INTO sbDato;
     IF cuExisteConf%FOUND THEN
       sbError := 'Ya existe una Configuracion Vigente para la Actividad ['||:NEW.COVPACTI||'-'||DAGE_ITEMS.FSBGETDESCRIPTION(:NEW.COVPACTI, null)||'] y Estrato ['||:new.covpsuca||']';
       CLOSE cuExisteConf;
       RAISE erProceso;
     END IF;
     CLOSE cuExisteConf;
     --Ticket 2001628 LJLB -- se valdia si la fecha final es mayor a la del sistema
     IF :NEW.COVPFEFI > SYSDATE THEN
        :NEW.COVPFLAG := 'S';
     ELSE
       sbError := 'La Fecha Final no puede ser Menor a la Fecha del sistema';
       RAISE erProceso;
     END IF;

  END IF;

  IF UPDATING THEN

   --Ticket 2001628 LJLB -- se valida que la fecha final nueva no sea menor a la vieja
    IF :NEW.COVPFEFI < :OLD.COVPFEFI THEN
       sbError := 'La Fecha Final Nueva ['||:NEW.COVPFEFI||' no puede ser menor a la anterior ['||:OLD.COVPFEFI||']';
       RAISE erProceso;
    END IF;
    --Ticket 2001628 LJLB -- Se valida si existe una configuracion activa con la misma actividad
     OPEN cuExisteConf;
     FETCH cuExisteConf INTO sbDato;
     IF cuExisteConf%FOUND THEN
       sbError := 'Ya existe una Configuracion Vigente para la Actividad ['||:NEW.COVPACTI||'-'||DAGE_ITEMS.FSBGETDESCRIPTION(:NEW.COVPACTI, null)||'] y Estrato ['||:new.covpsuca||']';
       CLOSE cuExisteConf;
       RAISE erProceso;
     END IF;
     CLOSE cuExisteConf;

  END IF;
EXCEPTION
  WHEN  erProceso  THEN
     ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbError);
     Raise ex.CONTROLLED_ERROR;
  when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
     ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Error no controlado en TRG_LDCCONFVPCDSI '||sqlerrm);
     Raise ex.CONTROLLED_ERROR;
END;
/
