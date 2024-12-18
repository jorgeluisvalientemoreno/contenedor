CREATE OR REPLACE PACKAGE adm_person.LDC_PKGCAMVAC IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    25/06/2024              PAcosta         OSF-2878: Cambio de esquema ADM_PERSON                              
    ****************************************************************/  
    
    FUNCTION FUNCGETPBMULCAMVAC RETURN constants.tyrefcursor;
   /**************************************************************************
		Autor       : Horbath / Horbath
		Fecha       : 2019-10-03
		Ticket      : 32
		Proceso     : FUNCGETPBMULCAMVAC
		Descripcion : Funcion para obtener el conjunto de registros para la forma LDCCAMVAC

		HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
    procedure PRPBMULCAMVAC(isbcodigo    In Varchar2,
                                          inucurrent   In Number,
                                          inutotal     In Number,
                                          onuerrorcode Out ge_error_log.message_id%Type,
                                          osberrormess Out ge_error_log.description%Type);
   /**************************************************************************
		Autor       : Horbath / Horbath
		Fecha       : 2019-10-06
		Ticket      : 32
		Proceso     : LDCCAMVAC
		Descripcion : procedimiento que se encarga de setear como medidor chatarra los escogidos en la forma LDCCAMVAC

		HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

END LDC_PKGCAMVAC;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGCAMVAC IS

FUNCTION FUNCGETPBMULCAMVAC RETURN constants.tyrefcursor Is
   /**************************************************************************
		Autor       : Horbath / Horbath
		Fecha       : 2019-10-03
		Ticket      : 32
		Proceso     : FUNCGETPBMULCAMVAC
		Descripcion : Funcion para obtener el conjunto de registros para la forma LDCCAMVAC

		HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
sbmensaje        VARCHAR2(2000);
 eerror           EXCEPTION;
 rfresult constants.tyrefcursor;
sbsqlmaestro   ge_boutilities.stystatement; -- se almacena la consulta
sbsqlfiltro   ge_boutilities.stystatement; -- se almacena la filtro
obser   MO_NOTIFY_LOG_PACK.OBSERVATION%type; -- observacion
serie   ge_items_seriado.SERIE%type; -- serie
estados_med ld_parameter.value_chain%type:= open.dald_parameter.fsbGetValue_Chain('EST_MED');
begin
   --se obtienen los datos o criterios de validacion del PB, en este caso la serie
   serie :=  ge_boinstancecontrol.fsbgetfieldvalue('GE_ITEMS_SERIADO', 'SERIE'); --'F-7985721-14'
   -- se estructura la consulta
   sbsqlmaestro :='select GE_ITEMS_SERIADO.ID_ITEMS_SERIADO IDENTIFICADOR,GE_ITEMS_SERIADO.COSTO COSTO,GE_ITEMS_SERIADO.ITEMS_ID CODIGO_ITEM ,GE_ITEMS.CODE CODIGO_SAP, GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV ESTADO_MEDIDOR , GE_ITEMS_ESTADO_INV.DESCRIPCION DESCRIPCION_ESTADO
                 from ge_items_seriado,GE_ITEMS, GE_ITEMS_ESTADO_INV where ge_items.items_id=ge_items_seriado.items_id and ge_items_seriado.costo<>0 AND GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV=GE_ITEMS_ESTADO_INV.ID_ITEMS_ESTADO_INV AND GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV in ('||ESTADOS_MED||')and SERIE='''||serie||'''';

   Open rfresult For sbsqlmaestro;
   Return rfresult;
Exception
    WHEN eerror THEN
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
       ut_trace.trace('FUNCGETPBMULCAMVAC '||sbmensaje||' '||SQLERRM, 11);

    When ex.controlled_error THEN
      Raise;

    When Others THEN
      errors.seterror;
      Raise ex.controlled_error;
end FUNCGETPBMULCAMVAC;

procedure PRPBMULCAMVAC(isbcodigo    In Varchar2,
                                          inucurrent   In Number,
                                          inutotal     In Number,
                                          onuerrorcode Out ge_error_log.message_id%Type,
                                          osberrormess Out ge_error_log.description%Type) Is
   /**************************************************************************
		Autor       : Horbath / Horbath
		Fecha       : 2019-10-06
		Ticket      : 32
		Proceso     : LDCCAMVAC
		Descripcion : procedimiento que se encarga de setear como medidor chatarra los escogidos en la forma LDCCAMVAC

		HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/


  sbFlag VARCHAR2(2);
  codigo number;
  obser MO_NOTIFY_LOG_PACK.OBSERVATION%type; -- observacion
  costoold ge_items_seriado.costo%type;
begin

    codigo := to_number(isbcodigo) ;

	obser :=  ge_boinstancecontrol.fsbgetfieldvalue('MO_NOTIFY_LOG_PACK', 'OBSERVATION');
	select costo into costoold from ge_items_seriado where id_items_seriado=codigo;
	update ge_items_seriado set costo = 0 where id_items_seriado=codigo;

	insert into GE_ITEMS_SERIADO_COST (ID_ITEMS_SERIADO,OLD_COSTO,NEW_COSTO,FECHA_CAMBIO,OBSERVACION,USER_ID,TERMINAL) values
	(codigo, costoold, 0, sysdate, obser, user, Userenv('TERMINAL' ));


Exception

    When ex.controlled_error THEN
    rollback;
      Raise;

    When Others THEN
      rollback;
      errors.seterror;
      Raise ex.controlled_error;
end PRPBMULCAMVAC;
END LDC_PKGCAMVAC;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGCAMVAC
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKGCAMVAC', 'ADM_PERSON');
END;
/
