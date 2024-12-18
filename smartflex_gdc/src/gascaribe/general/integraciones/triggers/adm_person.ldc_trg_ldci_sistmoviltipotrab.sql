CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LDCI_SISTMOVILTIPOTRAB
BEFORE INSERT OR UPDATE ON LDCI_SISTMOVILTIPOTRAB
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  LDC_TRGBIU_LDCI_SISTMOVILTIPOTRAB

  Descripcion  : Valida ingreso de datos en la forma de mantenimiento
                 de la tabla

  Autor  : F.Castro
  Fecha  : 14-11-2016

  Historia de Modificaciones
  **************************************************************/

DECLARE
sbfin      varchar2(1);
 sbError    varchar2(1);
 nuI        number;
 sbExiste   varchar2(1);
 nuOcu      number;
 sbEstVal   varchar2(20);
 nuEstVal   number;
 sbestados  varchar2(100);

 cursor cuValEstado (inuestado number) is
   select 'x'
     from or_order_status o
    where o.order_status_id = inuestado;

--------------
function Ocurrencias(CADENA IN VARCHAR2, SUBCADENA IN VARCHAR2) RETURN NUMBER IS
 RESPUESTA NUMBER;
BEGIN
 SELECT
 (LENGTH(CADENA)-LENGTH(REPLACE(CADENA,SUBCADENA,'')))/LENGTH(SUBCADENA)
 INTO RESPUESTA
 FROM DUAL;
 RETURN RESPUESTA;
 EXCEPTION
    WHEN OTHERS THEN
       RETURN 0;
END Ocurrencias;
--------------
function Extraer (sbcadena varchar2, nuOrden number) return varchar2 is
 sbSubst varchar2(50);
begin
 if nuorden = 1 then
    sbSubst:= substr(sbcadena,  1, instr(sbcadena, '|', 1, 1) - 1);
 else
    sbSubst:= substr(sbcadena, instr(sbcadena, '|', 1, nuorden-1) + 1,
                               (instr(sbcadena, '|', 1, nuorden)) -
                               (instr(sbcadena, '|', 1, nuorden-1) + 1));
 end if;
 return sbSubst;
exception when others then
 return null;
end Extraer;
--------------
function ToNumber (sbnumero varchar2) return number is
  nuNumero  number;
begin
 begin
   nuNumero := to_number(sbnumero);
 exception when others then
   nuNumero := -2;
 end;
 return nuNumero;
exception when others then
 return -2;
end ToNumber;
--------------


BEGIN
 -- Valida columna PERMITE_ANULACION
 if :new.PERMITE_ANULACION is null or :new.PERMITE_ANULACION not in ('S','N') then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Permite Anulacion debe ser S o N');
 end if;

  -- Valida columna order_status_id
  sbestados := :new.order_status_id;
  if sbestados is not null then
   if substr(sbEstados,length(sbEstados),1) = '|' then
    nuOcu := Ocurrencias(sbEstados,'|');
    if nuOcu > 0 then
      nuI := 1;
      sbError := 'N';
      sbfin := 'N';
      while sbfin = 'N' loop
        sbEstVal := Extraer(sbestados, nuI);
        if sbEstVal is not null then
           nuEstVal := ToNumber(sbEstVal);
           if nuEstVal != -2 then
             open cuValEstado(nuEstVal);
             fetch cuValEstado into sbExiste;
             if cuValEstado%notfound then
               sbfin := 'S';
               sbError := 'S';
             end if;
              close cuValEstado;
           else
             sbfin := 'S';
             sbError := 'S';
           end if;
        else
          sbfin := 'S';
          sbError := 'S';
        end if;
        nuI := nuI + 1;
        if nuI > nuOcu then
          sbfin := 'S';
        end if;
      end loop;

      if sbError = 'S' then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Cadena de Estados con Errores (No existe algun estado o no es numerico)');
      end if;

    else
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'No se encontro el separador pipe (|) en Cadena de Estados');
    end if;
   else
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Cadena de Estados debe finalizar con el caracter pipe (|)');
   end if;
  else
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Cadena no puede ser nula');
  end if;


 -- Valida columna est_per_gen_anul
  sbestados := :new.est_per_gen_anul;
  if sbestados is not null then
   if substr(sbEstados,length(sbEstados),1) = '|' then
    nuOcu := Ocurrencias(sbEstados,'|');
    if nuOcu > 0 then
      nuI := 1;
      sbError := 'N';
      sbfin := 'N';
      while sbfin = 'N' loop
        sbEstVal := Extraer(sbestados, nuI);
        if sbEstVal is not null then
           nuEstVal := ToNumber(sbEstVal);
           if nuEstVal != -2 then
             open cuValEstado(nuEstVal);
             fetch cuValEstado into sbExiste;
             if cuValEstado%notfound then
               sbfin := 'S';
               sbError := 'S';
             end if;
              close cuValEstado;
           else
             sbfin := 'S';
             sbError := 'S';
           end if;
        else
          sbfin := 'S';
          sbError := 'S';
        end if;
        nuI := nuI + 1;
        if nuI > nuOcu then
          sbfin := 'S';
        end if;
      end loop;

      if sbError = 'S' then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Cadena de Estados con Errores (No existe algun estado o no es numerico)');
      end if;

    else
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'No se encontro el separador pipe (|) en Cadena de Estados');
    end if;
   else
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Cadena de Estados debe finalizar con el caracter pipe (|)');
   end if;
  else
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Cadena no puede ser nula');
  end if;



END LDC_TRG_LDCI_SISTMOVILTIPOTRAB;
/
