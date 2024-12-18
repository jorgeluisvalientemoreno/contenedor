CREATE OR REPLACE trigger gispeti."UNIPREDIAL_DATOS_UPDATE"
  before update ON GISPETI.UNIDADPREDIAL
  for each row
declare
  -- local variables here
  --PRAGMA AUTONOMOUS_TRANSACTION;
  mensaje         varchar2(2000) := '';
  idaddress       number := 0;
  idpremise       number := 0;
  strinddire      varchar2(2000);
  isbNewAddress   varchar2(2000);
  ruta            varchar2(20) := '';
  onuerrorcode    number;
  osberrormessage varchar2(2000);
  validar         number;
  una_Direccion   VARCHAR2(2000);
begin

  -- LO QUE HACE EL UPDATE CATEGORIA

  if (:new.categoria <> :old.categoria) and
     (:new.subcategoria <> :old.subcategoria) then

    manejopredial.actualizapremiseestra(:old.idpremise,
                                   :old.numeropredio,
                                   null, --inunumberdivision,
                                   :old.tipopredio, --inupremisetypeid,
                                   :old.numeroapartamentos,
                                   :old.numeropisos,
                                   null, --isbsetbackbuilding,
                                   :old.pasoservidumbre,
                                   null,
                                   :NEW.categoria,
                                   :new.subcategoria,
                                   :old.rutalectura,
                                   onuerrorcode,
                                   osberrormessage);

    if (onuerrorcode > 0) then

      raise_application_error(-20053,
                              'Error ocuRrido en el trigger cambio de UNIPREDIAL_CATEGORIA_UPDATE, osf_os_updpremise ' ||
                              osberrormessage);
    end if;

  else

    if (:new.categoria = :old.categoria) and
       (:new.subcategoria <> :old.subcategoria) then

      manejopredial.actualizapremiseestra(:old.idpremise,
                                     :old.numeropredio,
                                     null, --inunumberdivision,
                                     :old.tipopredio, --inupremisetypeid,
                                     :old.numeroapartamentos,
                                     :old.numeropisos,
                                     null, --isbsetbackbuilding,
                                     :old.pasoservidumbre,
                                     null,
                                     :old.categoria,
                                     :new.subcategoria,
                                     :old.rutalectura,
                                     onuerrorcode,
                                     osberrormessage);

      if (onuerrorcode > 0) then

        raise_application_error(-20053,
                                'Error ocuRrido en el trigger cambio de UNIPREDIAL_CATEGORIA_UPDATE, osf_os_updpremise ' ||
                                osberrormessage);
      end if;

    else

      if (:new.categoria <> :old.categoria) and
         (:new.subcategoria = :old.subcategoria) then

        manejopredial.actualizapremiseESTRA(:old.idpremise,
                                       :old.numeropredio,
                                       null, --inunumberdivision,
                                       :old.tipopredio, --inupremisetypeid,
                                       :old.numeroapartamentos,
                                       :old.numeropisos,
                                       null, --isbsetbackbuilding,
                                       :old.pasoservidumbre,
                                       null,
                                       :new.categoria,
                                       :old.subcategoria,
                                       :old.rutalectura,
                                       onuerrorcode,
                                       osberrormessage);

        if (onuerrorcode > 0) then

          raise_application_error(-20053,
                                  'Error ocuRrido en el trigger cambio de UNIPREDIAL_CAMBIO CATEGORIA, osf_os_updpremise ' ||
                                  osberrormessage);
        end if;

      end if;
    end if;
  end if;

   :new.usuarioultimamodificacion:=user;
      :new.fechaultimamodificacion:=sysdate;

end UniPredial_DATOS_Update;

/
