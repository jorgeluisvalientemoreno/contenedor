CREATE OR REPLACE package adm_person.ldc_bo_gestunitper is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  20/06/2024   Adrianavg   OSF-2848: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  
--REQ.233
  /********************************************************************************
      Propiedad intelectual de Gases del Caribe E.S.P (c).

  Unidad         : Ld_BcFacturacion
  Descripcion    : Realizar logica para personalizaciones Factuarcion GDC

  Autor          : gdc
  Fecha          : 25/12/2019   Horbath (EHGv1). Caso 233. Gesti?n y auditor?a de personas asociadas a Unidades Operativas
  ********************************************************************************/
 --REQ.233
  --Funsi?n de busqueda para el PB "GESUNITPER"
  Function GESTUNITPER return pkConstante.tyRefCursor;
  --Procedimiento para el PB "GESUNITPER"
  PROCEDURE PROGESTUNITPER (nuperson_id     GE_PERSON.PERSON_ID%TYPE,
                           InuActReg       number default 1,
                           InuTotalReg     number default 1,
                           OnuErrorCode    out number,
                           OsbErrorMessage out varchar2);
end Ldc_Bo_gestunitper;
/
CREATE OR REPLACE package body adm_person.Ldc_Bo_gestunitper is
--REQ.233++
  /********************************************************************************
      Propiedad intelectual de Gases del Caribe E.S.P (c).

  Unidad         : Ld_BcFacturacion
  Descripcion    : Realizar logica para personalizaciones Factuarcion GDC

  Autor          : gdc
  Fecha          : 25/12/2019   Horbath (EHGv1++). Caso 233. Gesti?n y auditor?a de personas asociadas a Unidades Operativas
                   23/01/2020   Horbath (EHGv2). Caso 233 Cambio de alcance. Se valida el -1 para el area organizacional de la
                   uunidad operativa, para permitir el uso normal de la solución cuando se presente dicho escenario.
  ********************************************************************************/
  --REQ.233++
--Funsi?n de busqueda para el PB "GESUNITPER"
Function GESTUNITPER return pkConstante.tyRefCursor IS

  sbmensaje        VARCHAR2(2000);
  eerror           EXCEPTION;
  sbsqlmaestro   ge_boutilities.stystatement; -- se almacena la consulta
  sbsqlfiltro    ge_boutilities.stystatement; -- se almacena la filtro

  rfcursor   pkConstante.tyRefCursor;

  sbparuser varchar2(100);
  nusesion  number;
  nuexiste  number :=0;
  userid    number;
  nuorgarea_user number;
  nuorgaarea_unit number;
  nuoperunit number;
  nuaccion number;

BEGIN
  --Se valida el usuario conectado
  SELECT userenv('SESSIONID'), USER INTO nusesion, sbparuser
  FROM dual;

  --Se obtiene la informacion de la unidad operativa ingresada en la busqueda desde el PB GESUNITPER
  nuoperunit   := ge_boinstancecontrol.fsbgetfieldvalue('LDC_AUDOR_OPER_UNIT_PERSON', 'AUDUNID_OPER_ID');

  --Se obtiene la accion a realizar por el PB (Utilizando un campo reutilizado)
  nuaccion := ge_boinstancecontrol.fsbgetfieldvalue('LDC_USSFMACO', 'USSESTADO');

  --Se obtiene el ID del usuario conectado.
  userid := dage_person.fnugetuser_id(GE_BOPERSONAL.FNUGETPERSONID());

  --Se  obtiene el area organizacional del usuario conectado.
  Select g.organizat_area_id into nuorgarea_user
  from GE_PERSON g
  where g.user_id = userid;

  --xlogpno_ehg('User Id del usuario conectado: '|| userid ||' - '|| 'Area Organizacional Usuario conectado ' ||nuorgarea_user);

  --Se optiene la unidad organizacional de la unidad operativa buscada desde el PB
  select o.orga_area_id into nuorgaarea_unit
  from or_operating_unit o
  where o.operating_unit_id = nuoperunit;

  --xlogpno_ehg('Area Organizacional Unidad Operativa ' ||nuorgaarea_unit);

  --Se valida que se elija una acci?n antes de presionar el bot?n [Buscar].
  /*If (nuaccion is null) then
    Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                    'No ha seleccionado una accion valida para el proceso. Verifique!.');
    raise ex.CONTROLLED_ERROR;
  End if;*/

  IF (nuorgarea_user is not null and nuorgaarea_unit is not null) then
      --Se valida que el usuario conectado y la unidad operativa buscada, tengan la misma unidad organizacional
      --CASO 233-Cambio de alcance. Se incluye el (-1 Todos) para la validación de la unidad operativa.
      IF ( (nuorgarea_user = nuorgaarea_unit) or (nuorgaarea_unit = -1) ) THEN

      --Se cargan los registros de OR_OPER_UNIT_PERSONS (opcion #1)
       sbsqlmaestro := 'select
                        PERSON_ID           ID_Persona,
                        GE_BOPERSONAL.FSBGETPERSONNAME(PERSON_ID)  Nombre_persona
                        from OR_OPER_UNIT_PERSONS ';

       sbsqlfiltro := ' WHERE OPERATING_UNIT_ID = '|| nuoperunit;

      ELSE
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'El area organizacional del usuario '|| USER ||' y la unidad Operativa '|| nuoperunit ||' no coinciden. Verifique!.');
        raise ex.CONTROLLED_ERROR;
      END IF;

   ELSE
     ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'Error!. No se encuentra el area organizacional del usuario '|| USER ||', o el de la unidad Operativa '|| nuoperunit ||'. Verifique!.');
     raise ex.CONTROLLED_ERROR;
   END IF;

  if sbsqlmaestro is null then
    Open rfcursor For 'select * from dual';
  else
  Open rfcursor For sbsqlmaestro || sbsqlfiltro;
  end if;

  return rfcursor;

END;

--Procedimiento para el PB "GESUNITPER"
PROCEDURE PROGESTUNITPER  (nuperson_id     GE_PERSON.PERSON_ID%TYPE,
                           InuActReg       number default 1,
                           InuTotalReg     number default 1,
                           OnuErrorCode    out number,
                           OsbErrorMessage out varchar2) IS


  sbmensaje        VARCHAR2(2000);
  eerror           EXCEPTION;
  sbsqlmaestro   ge_boutilities.stystatement; -- se almacena la consulta
  sbsqlfiltro    ge_boutilities.stystatement; -- se almacena la filtro

  rfcursor   pkConstante.tyRefCursor;

  sbparuser varchar2(100);
  nusesion  number;
  nuexiste  number :=0;
  userid    number;
  nuorgarea_user number;
  nuorgaarea_unit number;
  nuoperunit number;
  nuaccion number;
  cont_per_exist number :=0;
  cont1 number :=0;
  nu_newperson_id ge_person.Person_Id%type;

BEGIN

   --Se valida el usuario conectado
  SELECT userenv('SESSIONID'), USER INTO nusesion, sbparuser
  FROM dual;

  --Se busca la informacion de la unidad operativa a buscar desde el PB GESUNITPER
  nuoperunit   := ge_boinstancecontrol.fsbgetfieldvalue('LDC_AUDOR_OPER_UNIT_PERSON', 'AUDUNID_OPER_ID');

  --Se obtiene la accion a realizar por el PB (Utilizando un campo reutilizado)
  nuaccion := ge_boinstancecontrol.fsbgetfieldvalue('LDC_USSFMACO', 'USSESTADO');

  --Se obtiene el ID del nuevo Asociado si es una insersi?n.
  nu_newperson_id := ge_boinstancecontrol.fsbgetfieldvalue('LDC_AUDOR_OPER_UNIT_PERSON', 'AUDPERSON_ID');

  If (nuoperunit is null) then
    Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                    'No ha ingresado una unidad operativa valida para el proceso. Verifique!.');
    raise ex.CONTROLLED_ERROR;
  End if;

  --Se valida la acci?n y se realiza el proceso seleccionado
  If nuaccion is null then
    Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                    'No ha seleccionado una accion valida para el proceso. Verifique!.');
    raise ex.CONTROLLED_ERROR;
  else
    --Si la acci?n es Insertar / Asociar nueva persona a la unidad operativa.
    If (nuaccion) = 1 then

    --Se valida que se haya elegido un person_id de la lista de valores desde el PB
     If (nu_newperson_id is null) then
        Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                        'No ha ingresado/seleccionado una Persona valida, para asociar a la unidad operativa. Verifique!.');
        raise ex.CONTROLLED_ERROR;
     End if;

     --Se valida si la persona ingresada se encuentra en GE_PERSON
     cont_per_exist := 0;
     Begin
       select count(1) into cont1
       from ge_person g
       where g.person_id = nu_newperson_id;
     Exception
       when others then
         null;
     End;

     If (cont1 >0) then

         /*Se valida si ya se encuentra asociada dicha persona a la unidad operativa.
           Sino existe se procede a insertar el registro de OR_OPER_UNIT_PERSONS.*/
         cont_per_exist := 0;
         Begin
           select count(1) into cont_per_exist
           from OR_OPER_UNIT_PERSONS o
           where o.operating_unit_id = nuoperunit
           and   o.person_id         = nu_newperson_id;
           Exception
             when others then
               null;
         end;

         If (cont_per_exist >0) then
           Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                           'La persona con ID '||nu_newperson_id||', ya se encuentra asociada a la unidad operativa '||nuoperunit ||'. Verfique!.');
           raise ex.CONTROLLED_ERROR;
         else
           --Se procede a insertar el registro en la tabla OR_OPER_UNIT_PERSONS, asociandolo a la unidad operativa.
           Begin
             insert into OR_OPER_UNIT_PERSONS
                        (OPERATING_UNIT_ID,
                          PERSON_ID
                         )
                  values (nuoperunit,
                          nu_newperson_id
                          );
           Exception
             When others then
               null;
           End;
         End if;
     Else
        Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                        'La persona con ID '||nu_newperson_id||', no existe en el sistema en la tabla GE_PERSON. Verfique!.');
        raise ex.CONTROLLED_ERROR;
     End if;

    --Si la acci?n es Eliminar / Desasociar persona de la unidad operativa.
    Elsif(nuaccion) = 0 then

    --Se valida que se haya elegido un person_id de la lista de valores desde el PB
     If (nuperson_id is null) then
        Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                        'No ha seleccionado un registro valido, para eliminar/desasociar de la unidad operativa. Verifique!.');
        raise ex.CONTROLLED_ERROR;
     End if;

     --Se valida si existe en la BD y si existe se procede a eliminar el registro de OR_OPER_UNIT_PERSONS.
     cont_per_exist := 0;
     Begin
       select count(1) into cont_per_exist
       from OR_OPER_UNIT_PERSONS o
       where o.operating_unit_id = nuoperunit
       and   o.person_id         = nuperson_id; --Id de entrada resultado del buscar desde el PB
       Exception
         when others then
           null;
     end;

     If (cont_per_exist =0) then
       Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                       'La persona con ID '||nuperson_id||', No se encuentra asociada actualmente a la unidad operativa '||nuoperunit ||'. Verifique!.');
     else
       --Si la persona existe, se procede a eliminar/ desasociar de la unidad operativa en la tabla OR_OPER_UNIT_PERSONS.
       Begin
         delete from OR_OPER_UNIT_PERSONS o
         where o.operating_unit_id = nuoperunit
         and   o.person_id         = nuperson_id;
       Exception
         when others then
           null;
       End;

     End if;

    End if;--Fin de Acci?n (1 / 2)


    --Se registra en la tabla de auditoria "LDC_AUDOR_OPER_UNIT_PERSON", los cambios de (Asociar / Desasociar)
    Begin
      Insert into LDC_AUDOR_OPER_UNIT_PERSON(AUDUNID_OPER_ID,
                                              AUDPERSON_ID,
                                              AUDFECREG,
                                              AUDPROCESO,
                                              AUDUSER,
                                              AUDIP_USER,
                                              AUDTERMINAL,
                                              AUDHOST_USER
                                              )
                                        values(nuoperunit,
                                               decode(nuaccion,1,nu_newperson_id,nuperson_id),
                                               sysdate,
                                               decode(nuaccion,1,'Asociar','Eliminar'),
                                               USER,
                                               sys_context('userenv', 'ip_address'),
                                               userenv('TERMINAL'),
                                               sys_context('userenv', 'host')
                                               );
    Exception
      when others then
        null;
    End;

    --

  End if;


  /*Hacer commit si todo OK*/
    commit;

    ut_trace.trace('Fin Ldc_Bo_gestunitper.PROGESTUNITPER', 10);
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
END;


end Ldc_Bo_gestunitper;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_BO_GESTUNITPER
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BO_GESTUNITPER', 'ADM_PERSON'); 
END;
/