CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_FECHASOLICITUD
  BEFORE INSERT ON LDC_COMEORDORCD
  FOR EACH ROW
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRG_FECHASOLICITUD
    Descripcion    : Disparador que obtiene la fecha de registro de la solcitud de la orden registrada en la entidad.
    Autor          : Jorge Valiente
    Fecha          : XX/XX/2022

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
DECLARE

  sbEntrega varchar2(30) := 'OSF-327';

  cursor cufecharegistrosol is
    select mp.request_date
      from mo_packages mp
     inner join or_order_activity ooa
        on ooa.package_id = mp.package_id
       and ooa.order_id = :new.orden_id;

  dtrequest_date mo_packages.request_date%type;

BEGIN

  IF fblaplicaentrega(sbEntrega) THEN

    OPEN cufecharegistrosol;
    FETCH cufecharegistrosol
      INTO dtrequest_date;
    CLOSE cufecharegistrosol;

    if dtrequest_date is not null then
      :NEW.FECHAREGSOL := dtrequest_date;
    end if;
  END IF;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    raise;
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    RAISE EX.CONTROLLED_ERROR;
END;
/
