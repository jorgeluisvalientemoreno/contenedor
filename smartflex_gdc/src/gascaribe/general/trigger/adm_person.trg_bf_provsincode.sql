CREATE OR REPLACE trigger ADM_PERSON.TRG_BF_PROVSINCODE
  before insert or update on LDC_PROVSINCODE
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
declare

  cursor cusublineaproveedor(inusubline_id number, inuSUPPLIER_ID number) is
    select la.subline_id, la.supplier_id
      from ld_article la
     where la.subline_id = inusubline_id
       and la.SUPPLIER_ID = inuSUPPLIER_ID;

  rfcusublineaproveedor cusublineaproveedor%rowtype;

  nusubline_id  number;
  nusupplier_id number;

begin

  if INSERTING then

    nusubline_id  := :new.subline_id;
    nusupplier_id := :new.supplier_id;

    open cusublineaproveedor(nusubline_id, nusupplier_id);
    fetch cusublineaproveedor
      into rfcusublineaproveedor;
    if cusublineaproveedor%notfound then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'El proveedor[' || :new.supplier_id ||
                                       '] no tiene relacionada la Sublinea[' ||
                                       :new.subline_id || ']');
    end if;
    close cusublineaproveedor;

  elsif DELETING then

    null;

  elsif UPDATING then

    nusubline_id  := nvl(:new.subline_id, :old.subline_id);
    nusupplier_id := nvl(:new.supplier_id, :old.supplier_id);

    open cusublineaproveedor(nusubline_id, nusupplier_id);
    fetch cusublineaproveedor
      into rfcusublineaproveedor;
    if cusublineaproveedor%notfound then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'El proveedor[' || :new.supplier_id ||
                                       '] no tiene relacionada la Sublinea[' ||
                                       :new.subline_id || ']');
    end if;
    close cusublineaproveedor;

  end if;

end TRG_BF_PROVSINCODE;
/
