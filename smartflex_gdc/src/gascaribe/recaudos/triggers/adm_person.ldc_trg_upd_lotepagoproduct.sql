CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_UPD_LOTEPAGOPRODUCT
 AFTER UPDATE ON open.ldc_lotepagoproduct
   FOR EACH ROW
   /**************************************************************************
    Propiedad intelectual de CSC. (C).
    Funcion     :  ldc_trg_upd_lotepagoproduct
    Descripcion :  Trigger para controlar las modificaciones cuando no este
                   procesado
    Autor       : Carlos Humberto Gonzalez V
    Fecha       : 15-08-2017

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    15-08-2017          cgonzalezv              Creacion.
  ******************************************************************/

DECLARE


BEGIN
    -- Registro procesado
    IF  :old.flag_proces = 'S' THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
        'El Producto '||:old.id_producto ||' no es posible modificar. Ya se encuentra procesado en recaudo "S". ');
        raise ex.CONTROLLED_ERROR;
   end if;



EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
END;
/
