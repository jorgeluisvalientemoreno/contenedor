CREATE OR REPLACE TRIGGER "UNIPREDIAL_BEFORE_INS_TRG"
  before insert on unidadpredial
  for each row
declare
  --PRAGMA AUTONOMOUS_TRANSACTION;
  -- local variables here
  nuId     NUMBER;
  segmento number := 0;
  segm     number;

  idaddress_         number;
  idpremise_         number;
  Message            varchar2(2000);
  response           number;
  inuneighborthood   number;
  inugeograplocation number;
  isbNewAddress      varchar2(2000);
  una_direccion      varchar2(2000);
  un_mensaje         varchar2(2000);

  --nuError  NUMBER;
  --sbError  VARCHAR2(2000);
begin
  nuId := USECUENCIA_UP.NEXTVAL;

  --Actualizar
  :new.secuenciapredio := nuId;

  begin

    begin

      SELECT l.codigosegmento
        into segmento
        FROM predio m, segmento l
       WHERE sdo_relate(l.shape,
                        sdo_geom.sdo_buffer(m.shape, 0.01, 0.005),
                        'MASK=ANYINTERACT') = 'TRUE'
         AND m.tag = :new.tag
         and rownum = 1;

    exception
      when others then
        segmento := 0;

    end;

    if segmento <> 0 then

      begin
        select idubicaciongeografica
          into inuneighborthood
          from BARRIO
         where departamento = :new.departamento
           and localidad = :new.localidad
           and codigo = :new.barrio
           and rownum = 1;

      exception
        when others then
          -- codbarrio        := -1;
          inuneighborthood := -1;
      end;

      begin

        select idubicaciongeografica
          into inugeograplocation
          from localidad
         where departamento = :new.departamento
           and codigo = :new.localidad
           and rownum = 1;
      exception
        when others then
          inugeograplocation := -1;
      end;

      isbNewAddress := armadireccion_t(:new.departamento,
                                       :new.localidad,
                                       :new.tipoviainicial,
                                       :new.numeroviainicial,
                                       :new.tipoviacruce,
                                       :new.numeroviacruce,
                                       :new.letraunoviainicial,
                                       :new.letradosviainicial,
                                       :new.letrazonaviainicial,
                                       :new.letraunoviaCruce,
                                       :new.letradosviaCruce,
                                       :new.letrazonaviaCruce,
                                       :new.numerocasa,
                                       :new.letracasa,
                                       :new.tipolugar1,
                                       :new.numerolugar1,
                                       :new.tipolugar2,
                                       :new.numerolugar2,
                                       :new.tipolugar3,
                                       :new.numerolugar3,
                                       una_Direccion);

      ICT_APLICACIONES.INSERTARDIRECCION_OSF(isbNewAddress,
                                             inugeograplocation,
                                             inuneighborthood,
                                             :new.esurbano,
                                             null,
                                             :new.numeropredio,
                                             null, -- inunumberdivision,
                                             :new.tipopredio,
                                             :new.numeroapartamentos,
                                             :new.numeropisos,
                                             null, --isbsetbackbuilding,
                                             null, --isbservantspassage,
                                             null, -- inupremisestatusid,
                                             :new.categoria,
                                             :new.subcategoria,
                                             :New.Rutalectura,
                                             :new.anillado,
                                             :new.fechaanillado,
                                             null, --isbconnection,
                                             :new.interna,
                                             :new.tipointerna, --inuinternaltype,
                                             null, --isbmeauserment,
                                             null, --inunumpoints,
                                             :new.riesgo, --inulevelrisk,
                                             null, -- isbdescrisk,
                                             idaddress_,
                                             idpremise_,
                                             Message,
                                             response);

      IF response > 0 THEN

        raise_application_error(-20000,
                                'Error de OSF al momento de creacion la direccion' ||
                                Message);
        un_Mensaje := Message;
        rollback;
      END IF;

      :new.idaddress  := idaddress_;
      :new.idpremise  := idpremise_;
      :new.idsegmento := segmento;

      update ab_address a
         set a.segment_id = segmento
       where a.address_id = idaddress_;

      --select a.address_id into segm from ab_address a
      -- where address_id=:new.idaddress;

    else

      null;
      --segm:=segmento;

    end if;

    /*update ab_address a
      set a.segment_id = segmento
    where a.address_id = :new.idaddress;*/

    --   :new.idsegmento := segm;

    IF (:NEW.ANILLADO IS NULL) THEN
      :new.anillado := 'N';
    END IF;

    --:new.esurbano := 'Y';

  exception

    when others then
      null;
  end;

end UNIPREDIAL_BEFORE_INS_TRG;
/
