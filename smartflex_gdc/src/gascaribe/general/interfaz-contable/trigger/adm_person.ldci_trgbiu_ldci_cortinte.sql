CREATE OR REPLACE TRIGGER ADM_PERSON.LDCI_TRGBIU_LDCI_CORTINTE
BEFORE INSERT OR UPDATE ON LDCI_CORTINTE
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  LDC_TRGBIU_LDCI_CORTINTE

  Descripcion  : Valida ingreso de datos en la forma de mantenimiento
                 de la tabla

  Autor  : F.Castro
  Fecha  : 01-11-2016

  Historia de Modificaciones
  **************************************************************/

DECLARE
nuCompany number;
BEGIN
 if :new.ACTIVO not in ('S','N') then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Activo debe ser S o N');
 end if;


END LDCI_TRGBIU_LDCI_CORTINTE;
/
