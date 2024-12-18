
Declare 

  cursor CuValidacion Is
    select f.*, 
           length(f.ident_nueva) Longitud,
           substr(f.ident_nueva,-1) DigVerif
    from FE_VALIDACION_IDENTIFICACION f
    where nvl(valido,'N') = 'N';

   Mensaje  varchar2(200);
   Validado varchar2(2);
   modDigitoVer number(2);
   DigitoVer number(2);

Begin

  for i in CuValidacion loop    
    -- Calculo el digito de verificacion
    Begin 
      select MOD(CAST(SUBSTR(i.ident_nueva, 1, 1) AS NUMBER) * 41 +
             CAST(SUBSTR(i.ident_nueva, 2, 1) AS NUMBER) * 37 +
             CAST(SUBSTR(i.ident_nueva, 3, 1) AS NUMBER) * 29 +
             CAST(SUBSTR(i.ident_nueva, 4, 1) AS NUMBER) * 23 +
             CAST(SUBSTR(i.ident_nueva, 5, 1) AS NUMBER) * 19 +
             CAST(SUBSTR(i.ident_nueva, 6, 1) AS NUMBER) * 17 +
             CAST(SUBSTR(i.ident_nueva, 7, 1) AS NUMBER) * 13 +
             CAST(SUBSTR(i.ident_nueva, 8, 1) AS NUMBER) * 7 +
             CAST(SUBSTR(i.ident_nueva, 9, 1) AS NUMBER) * 3, 11) mod_dv
      into ModDigitoVer        
      from dual;
    End; 
    
    If ModDigitoVer in (0, 1) then
      DigitoVer := ModDigitoVer;
    Else   
      DigitoVer := 11 - ModDigitoVer;
    End If;
      
   -- Comienza las validaciones
    if i.Longitud <> 10 then
      Mensaje := 'Longitud diferente de 10';
      Validado := 'N';
    elsif DigitoVer <> to_number(i.DigVerif) then
      Mensaje := 'Digito de Verificacion no Coincide';
      Validado := 'N';
    else 
      Mensaje := 'Id Validado';
      Validado := 'S';
    end if;
    
    If Validado = 'S' then
      update ge_subscriber
      set    identification = i.ident_nueva
      where  subscriber_id = i.id_cliente;
    End If;  
    
    update fe_validacion_identificacion
      set valido = Validado,
          observacion = Mensaje
      where id_cliente = i.id_cliente;
      
  end loop;
  commit;
End;
/

