CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBILECTESPCONTNL BEFORE INSERT ON LDC_CM_LECTESP_CONTNL
referencing old as old new as new for each row
/*******************************************************************************
    Propiedad intelectual de CSC

    Trigger   : LDC_TRGBILECTESPPRNOLE

    Descripcion  : Trigger para hallar Ciclo y Nombre del Contrato (CA90)

    Autor     : HB
    Fecha     : 22/01/2020

    Historia de Modificaciones
    Fecha        ID Entrega     Modificacion
	07-02-2023 	 cgonzalez		OSF-784: Se modifica servicio RAISE_APPLICATION_ERROR por GE_BOERRORS.SETERRORCODEARGUMENT

*******************************************************************************/

DECLARE
 nuCiclo      Servsusc.sesucicl%type;
 sbNombre     varchar2(2000);
 sbMensaje    varchar2(2000) := null;
 nuCicloValido      Servsusc.sesucicl%type;
 
 cursor cuDatosContrato (nucont servsusc.sesususc%type) is
   SELECT gs.subscriber_name || '  ' || gs.subs_last_name nombre, susccicl
     FROM suscripc c, ge_subscriber gs
    WHERE suscclie=gs.subscriber_id
      and susccodi = nucont;
      
 cursor cuCicloEsp (nucicl ciclo.ciclcodi%type) is 
 select c.pecscico
   from LDC_CM_LECTESP_CICL c
  where c.pecscico = nucicl;


BEGIN
    ut_trace.Trace('Inicio: LDC_TRGBILECTESPCONTNL', 15);

    open  cuDatosContrato(:new.contrato_id);
    fetch cuDatosContrato into sbNombre, nuCiclo;
    if cuDatosContrato%notfound then
      nuCiclo := null;
      sbNombre := null;
    end if;
    close cuDatosContrato;
 
    :new.ciclo_id := nuCiclo;
    :new.description := sbNombre;
    
    open  cuCicloEsp(nuCiclo);
    fetch cuCicloEsp into nuCicloValido;
    if cuCicloEsp%notfound then
      sbMensaje := 'El Ciclo ' || nuCiclo || ' al que pertenece el contrato no es un ciclo de Lectursa Especiales';
    end if;
    close cuCicloEsp;
    
    if sbMensaje is not null then
       GE_BOERRORS.SETERRORCODEARGUMENT(-20101,sbMensaje);
    end if;

    ut_trace.Trace('Fin: LDC_TRGBILECTESPCONTNL', 15);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;
    WHEN others THEN
          errors.seterror;
          RAISE EX.CONTROLLED_ERROR;
END LDC_TRGBILECTESPCONTNL;
/
