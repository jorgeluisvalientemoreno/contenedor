CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LDCCAG
/**************************************************************************

  UNIDAD      :  LDC_TRG_LDCCAG
  Descripcion :  Trigger que valida campos de la tabla LDCCAG y validaciones del a forma
                 LDCMDCAG
  Fecha       :  24-05-2020
  AUTOR       :  JOSH BRITO

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================

  **************************************************************************/
BEFORE INSERT ON LDCCAG
FOR EACH ROW
DECLARE
 sbActividad_garantia     LDCCAG.ACT_GARA%type;
 sbActividad_cobro        LDCCAG.ACT_COBR%type;
 sbTipoTrab_cobro         LDCCAG.TP_TRACO%type;
 nuCont                   number;


 CURSOR cuExisteActCobroConfig is
 select count(1)
 from   LDCCAG
 where   act_cobr = sbActividad_cobro;

 CURSOR cuExisteTTCobroConfig is
 select count(1)
 from   LDCCAG
 where  TP_TRACO = sbTipoTrab_cobro;

 CURSOR cuExisteActGarConfig is
 select count(1)
 from   LDCCAG
 where act_gara = sbActividad_garantia;

 CURSOR cuExisteConfig is
 select count(1)
 from   LDCCAG
 where   act_gara = sbActividad_garantia
 and act_cobr = sbActividad_cobro;


BEGIN
     ut_trace.trace('INICIA  TRIGGER LDC_TRG_LDCCAG ',1);

     --Se cargan los datos del registro al cual se le esta actualizando
     sbActividad_garantia:= :NEW.ACT_GARA;--Estado a actualizar
     sbActividad_cobro:= :NEW.ACT_COBR;--Estado a actualizar
     sbTipoTrab_cobro:= :NEW.TP_TRACO;--Estado a actualizar

     open cuExisteConfig;
     fetch cuExisteConfig into nuCont;
     close cuExisteConfig;

     IF nuCont > 0 then
        GE_BOERRORS.SETERRORCODEARGUMENT(2741,'ERROR, La actividad de garantia ya esta asociada a la actividad de cobro');
     END IF;

     open cuExisteActGarConfig;
     fetch cuExisteActGarConfig into nuCont;
     close cuExisteActGarConfig;

     IF nuCont > 0 then
        GE_BOERRORS.SETERRORCODEARGUMENT(2741,'ERROR, La actividad de garantia ya ha sido configurada');
     END IF;

     open cuExisteTTCobroConfig;
     fetch cuExisteTTCobroConfig into nuCont;
     close cuExisteTTCobroConfig;

     IF nuCont > 0 then
        GE_BOERRORS.SETERRORCODEARGUMENT(2741,'ERROR, El Tipo de Trabajo ya ha sido configurado');
     END IF;

     open cuExisteActCobroConfig;
     fetch cuExisteActCobroConfig into nuCont;
     close cuExisteActCobroConfig;

     IF nuCont > 0 then
        GE_BOERRORS.SETERRORCODEARGUMENT(2741,'ERROR, La actividad de Cobro ya ha sido configurada');
     END IF;


     ut_trace.trace('INICIA  TRIGGER LDC_TRG_LDCCAG ',1);

    EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDC_TRG_LDCCAG;
/
