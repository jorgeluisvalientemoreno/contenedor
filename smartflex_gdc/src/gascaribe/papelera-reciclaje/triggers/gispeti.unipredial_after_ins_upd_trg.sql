CREATE OR REPLACE TRIGGER UNIPREDIAL_AFTER_INS_UPD_TRG
  after insert OR UPDATE ON GISPETI.UNIDADPREDIAL
  for each row
declare

  -- local variables here
  nuId    NUMBER;
  premise number;
  esta    number;
  esta2   number;
  SERVICIO_GAS CONSTANT NUMBER := 7014;
  segmento number;
  codosf   number;
  i number;
  --SATURADO VARCHAR(3);
  --nuError  NUMBER;
  --sbError  VARCHAR2(2000);

  CURSOR CUPRODUCTO IS
    SELECT 1
      FROM osf_pr_product p
     WHERE p.address_id = :new.idAddress
       AND p.product_type_id = SERVICIO_GAS
       AND product_status_id in (1, 2, 15)
       AND ROWNUM = 1;

begin

  premise := 0;
  ESTA    := 0;

  select estate_number
    into premise
    from ab_address
   where address_id = :new.idaddress;

  if premise is null or premise = 0 then
    null;

  ELSE

    SELECT COUNT(1)
      INTO ESTA
      FROM LDC_INFO_PREDIO
     WHERE PREMISE_ID = PREMISE;

    --SATURADO := 'Y';--:NEW.SATURADO  ;

    IF ESTA > 0 THEN

      esta2 := 0;

      SELECT COUNT(1)
        INTO ESTA
        FROM LDC_INFO_PREDIO
       WHERE PREMISE_ID = PREMISE
         and is_zona is not null;

      if esta > 0 then

        OPEN CUPRODUCTO;
        FETCH CUPRODUCTO
          INTO esta2;

        IF CUPRODUCTO%NOTFOUND THEN
          ESTA2 := 0;
        END IF;

      end if;

      if esta2 = 0 then

        UPDATE LDC_INFO_PREDIO
           SET IS_ZONA          = :NEW.SATUrado,
               porc_penetracion = 100,--:new.PORCENTAJESATURACION,
               multivivienda    = :new.codigomultifamiliar
         where premise_id = premise;

        update predio
           set saturado             = :new.saturado,
               porcentajesaturacion = :new.porcentajesaturacion
         where tag = :new.tag;

      else
        --si tiene producto solo se actualiza el porcentaje
        UPDATE LDC_INFO_PREDIO
           SET porc_penetracion = 100,--:new.PORCENTAJESATURACION,
               multivivienda    = :new.codigomultifamiliar
         where premise_id = premise;

        update predio
           set porcentajesaturacion = :new.porcentajesaturacion
         where tag = :new.tag;
      end if;

    ELSE

      insert into LDC_INFO_PREDIO
        (ldc_info_predio_id,
         PREMISE_ID,
         IS_ZONA,
         PORC_PENETRACION,
         MULTIVIVIENDA)
      VALUES
        (open.seq_ldc_info_predio.nextval,
         PREMISE,
         :new.saturado,
         100,--:new.porcentajesaturacion,
         :new.codigomultifamiliar);

    END IF;

  end if;

  select idubicaciongeografica
    into codosf
    from localidad
   where departamento = :new.departamento
     and codigo = :new.localidad;






update ab_address a
    set a.segment_id = :new.idsegmento, a.geograp_location_id = codosf
  where a.address_id = :new.idaddress;

  i := Sql%Rowcount;

  If i = 0 Then
  
    Update ab_address a
    Set    a.geograp_location_id = codosf,
           a.segment_id          = :new.idsegmento
    Where  a.address_id = :OLD.idaddress;
  
  End If;

Exception

  When NO_DATA_FOUND Then
    ESTA2 := 0;
  
  When Others Then
    Null;
  
End;
/
