CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_ACTFORMULARIO
IS

  /*=======================================================================
	Unidad         : LDC_ACTFORMULARIO
	Descripcion    : Proceso programable para de la forma LDCACTFOR
	Autor          : horbath
	Caso           : CA844
	Fecha          : 01.08.2021

	Historia de Modificaciones

	Fecha             Autor                    ModificaciOn
	=========   ==================             ====================
	23.07.2021  horbath.                       CreaciOn
	=======================================================================*/
  nusession               NUMBER;                                     --Numero de sesion
  cnuNULL_ATTRIBUTE       constant number := 2126;
  sbUser                  Varchar2(30);
  sbTerminal			  Varchar2(60);

  nuFormulario            ge_boInstanceControl.stysbValue;
  nuTypeForm              ge_boInstanceControl.stysbValue;


  dtFechaEstFinCerAc      date;
  dtFechPen               date;
  dtFechasig              date;
  dtnewfech               date;
  nuExec_id               NUMBER;
  nuValtypedoc            NUMBER;




  CURSOR cuValtypedoc(inuformulario number) is
	select count(1) from FA_HISTCODI
    where  HICDNUME=inuformulario
    and HICDTICO in (SELECT TO_NUMBER(column_value)
    FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(
                open.dald_parameter.fsbgetvalue_chain('DOCUMENT_TYPE',NULL),  ',')));

  CURSOR cuFechPen(inuformulario number, inuTipoForm number) is
	select HICDFECH from
	FA_HISTCODI
	where HICDESTA='P'
	and HICDNUME= inuformulario
	and HICDTICO= inuTipoForm;

 CURSOR cuFechasig(inuformulario number, inuTipoForm number ) is
	Select HICDFECH from
    (select * from
        FA_HISTCODI
        where HICDESTA='A'
        and HICDNUME= inuformulario
        and HICDTICO= inuTipoForm
         order by HICDFECH desc) where rownum=1;




BEGIN



	IF FBLAPLICAENTREGAXCASO('0000844') THEN

		--Obtenemos los datos que vienen  del PB
		nuFormulario      := ge_boInstanceControl.fsbGetFieldValue ('FA_HISTCODI', 'HICDNUME');
		nuTypeForm        := ge_boInstanceControl.fsbGetFieldValue ('FA_HISTCODI', 'HICDTICO');

		OPEN cuValtypedoc(nuFormulario);
		FETCH cuValtypedoc INTO nuValtypedoc;
		CLOSE cuValtypedoc;

		if (nuValtypedoc=0) then
			ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'El tipo de formulario no esta configurado para este proceso');
			  RAISE ex.CONTROLLED_ERROR;
		end if;



		sbuser := SYS_CONTEXT( 'USERENV', 'OS_USER' );
		sbTerminal := SYS_CONTEXT( 'USERENV', 'TERMINAL' );




		--Validacion de atributos o filtros requeridos:
		if (nuFormulario IS NULL) then
		  Errors.SetError (cnuNULL_ATTRIBUTE, 'Numero de formulario');
		  RAISE ex.CONTROLLED_ERROR;
		end if;
	  -----------------------------------------------
		OPEN cuFechPen(nuFormulario,nuTypeForm);
		FETCH cuFechPen INTO dtFechPen;
		CLOSE cuFechPen;

		OPEN cuFechasig(nuFormulario,nuTypeForm);
		FETCH cuFechasig INTO  dtFechasig ;
		CLOSE cuFechasig;

		if (dtFechPen > dtFechasig) then
			ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'La fecha de pendiente es mayor a fecha de asignación');
			  RAISE ex.CONTROLLED_ERROR;
		end if;

		dtnewfech := dtFechasig + 1 / 86400;

		begin
			update FA_HISTCODI
			set HICDFECH= dtnewfech
			where HICDESTA='P'
			and HICDNUME= nuFormulario
			and HICDTICO= nuTypeForm;
		end;

		INSERT INTO LDC_LOG_ACTFOR
		(LOG_ACTFOR_ID, NUM_FORMULARIO,USUARIO,TERMINAL,FECHA_REG,FECHA_OLD,FECHA_NEW)
		VALUES
		(SEQ_LDC_LOG_ACTFOR.nextval, nuFormulario,sbuser,sbTerminal,sysdate,dtFechPen,dtnewfech);

		commit;

	end if;



EXCEPTION
when ex.CONTROLLED_ERROR then
  rollback;
  RAISE ex.CONTROLLED_ERROR;

when others then
  Errors.setError;
  rollback;
  RAISE ex.CONTROLLED_ERROR;
END LDC_ACTFORMULARIO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_ACTFORMULARIO', 'ADM_PERSON');
END;
/
