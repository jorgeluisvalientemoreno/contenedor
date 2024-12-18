CREATE OR REPLACE trigger gispeti."UNIPREDIAL_TIPOPRED_UPDATE"
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
  validar number;
  una_Direccion VARCHAR2 (2000);
begin



  -- verifica si el campo tipo predio cambio
  if (:new.tipopredio <> :old.tipopredio) then

    manejopredial.actualizapremisetippred(:old.idpremise,
                                   :old.numeropredio,
                                   null, --inunumberdivision,
                                   :new.tipopredio, --inupremisetypeid,
                                   :old.numeroapartamentos,
                                   :old.numeropisos,
                                   null, --isbsetbackbuilding,
                                   :old.pasoservidumbre,
                                   :old.estadopredio,
                                   :old.categoria,
                                   :old.subcategoria,
                                   :old.rutalectura,
                                   onuerrorcode,
                                   osberrormessage);


 :new.usuarioultimamodificacion:=user;
      :new.fechaultimamodificacion:=sysdate;
    if (onuerrorcode > 0) then

      raise_application_error(-20053,
                              'Error ocuRrido en el trigger cambio de UNIPREDIAL_TIPO PREDIO_UPDATE, osf_os_updpremise ' ||
                              osberrormessage);
    end if;

  end if;





end UniPredial_TIPOPRED_Update;

/
