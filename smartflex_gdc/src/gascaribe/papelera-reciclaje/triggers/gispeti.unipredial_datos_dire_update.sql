CREATE OR REPLACE trigger gispeti."UNIPREDIAL_DATOS_DIRE_UPDATE"
  before insert or update ON GISPETI.UNIDADPREDIAL
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


  --recalcula el campo preddire

  isbNewAddress  := armadireccion_t(:new.departamento,
                                    :new.localidad,
                                    :new.tipoviainicial,
                                    :new.numeroviainicial,
                                    :new.tipoviacruce,
                                    :new.numeroviacruce,
                                    :new.letraunoviainicial,
                                    :new.letradosviainicial,
                                    :new.letrazonaviainicial,
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
                                    una_Direccion);
  :new.direccion := una_Direccion;





end UniPredial_DATOS_DIRE_Update;

/
