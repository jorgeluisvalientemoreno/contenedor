CREATE OR REPLACE trigger "UNIPREDIAL_ADRSCHANGE_UPDATE"
  before update ON GISPETI.UNIDADPREDIAL
  for each row
declare
  -- local variables here
  PRAGMA AUTONOMOUS_TRANSACTION;
  mensaje         varchar2(2000) := '';
  idaddress       number := 0;
  idpremise       number := 0;
  idsegm          number := 0;
  strinddire      varchar2(2000);
  isbNewAddress   varchar2(2000);
  ruta            varchar2(50) := '';
  onuerrorcode    number;
  osberrormessage varchar2(2000);
  validar         number;
  una_Direccion   VARCHAR2(2000);
  segmento        number;
begin
  /* validar:=gispeti.manejopredial.EsPotencial(:old.departamento,
  :old.localidad,
  :old.zonacatastral,
  :old.sectorcatastral,
  :old.manzanacatastral,
  :old.numeropredio,
  :old.numeromejora,
  :old.consecutivo,
  :old.tag);*/
  
  if (:old.idaddress is not null) then

  validar := gispeti.manejopredial.EsPotencial(:old.departamento,
                                               :old.localidad,
                                               :old.zonacatastral,
                                               :old.sectorcatastral,
                                               :old.manzanacatastral,
                                               :old.numeropredio,
                                               :old.numeromejora,
                                               :old.consecutivo);

  if (validar = 0) then
    if (:new.tipoviainicial <> :old.tipoviainicial or
       :new.numeroviainicial <> :old.numeroviainicial or
       nvl(:new.letraunoviainicial, '0') <>
       nvl(:old.letraunoviainicial, '0') or
       nvl(:new.letradosviainicial, '0') <>
       nvl(:old.letradosviainicial, '0') or
       nvl(:new.letrazonaviainicial, '0') <>
       nvl(:old.letrazonaviainicial, '0') or
       :new.tipoviacruce <> :old.tipoviacruce or
       :new.numeroviacruce <> :old.numeroviacruce or
       nvl(:new.letraunoviacruce, '0') <> nvl(:old.letraunoviacruce, '0') or
       nvl(:new.letradosviacruce, '0') <> nvl(:old.letradosviacruce, '0') or
       nvl(:new.letrazonaviacruce, '0') <>
       nvl(:old.letrazonaviacruce, '0') or
       :new.numerocasa <> :old.numerocasa or
       nvl(:new.letracasa, '0') <> nvl(:old.letracasa, '0') or
       nvl(:new.tipolugar1, '0') <> nvl(:old.tipolugar1, '0') or
       nvl(:new.numerolugar1, '0') <> nvl(:old.numerolugar1, '0') or
       nvl(:new.tipolugar2, '0') <> nvl(:old.tipolugar2, '0') or
       nvl(:new.numerolugar2, '0') <> nvl(:old.numerolugar2, '0') or
       nvl(:new.tipolugar3, '0') <> nvl(:old.tipolugar3, '0') or
       nvl(:new.numerolugar3, '0') <> nvl(:old.numerolugar3, '0')) then

      if (:new.rutareparto <> :old.rutareparto) then
        ruta := :new.rutareparto;
      else
        ruta := :old.rutareparto;
      end if;

      gispeti.manejopredial.CambioDirClientePotencial(:new.tipoviainicial,
                                                      :new.numeroviainicial,
                                                      :new.letraunoviainicial,
                                                      :new.letradosviainicial,
                                                      :new.letrazonaviainicial,
                                                      :new.tipoviacruce,
                                                      :new.numeroviacruce,
                                                      :new.letraunoviacruce,
                                                      :new.letradosviacruce,
                                                      :new.letrazonaviacruce,
                                                      :new.numerocasa,
                                                      :new.letracasa,
                                                      :new.tipolugar1,
                                                      :new.numerolugar1,
                                                      :new.tipolugar2,
                                                      :new.numerolugar2,
                                                      :new.tipolugar3,
                                                      :new.numerolugar3,
                                                      :new.observacionmodificacion,
                                                      :new.idaddress,
                                                      :new.tag,
                                                      ruta,
                                                      mensaje,
                                                      idaddress,
                                                      idpremise,
                                                      idsegm);

      if (idaddress <> 0) then

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
            segmento := idsegm;
        end;

        :new.idsegmento := segmento;
        :new.idaddress  := idaddress;
        :new.idpremise  := idpremise;
        -- :new.idsegmento := idsegm;
        :new.observacionmodificacion := mensaje;

        --  insert into logcambiodireccion values (idaddress,'desde el trigger');

      end if;
    end if;
  end if;

/*
  -- cambio de categoria y subcategoria

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
  end if;*/

  :new.usuarioultimamodificacion := user;
  :new.fechaultimamodificacion   := sysdate;
  
  end if;

end UniPredial_AdrsChange_Update;

/
