CREATE OR REPLACE PACKAGE adm_person.LDC_PKGAPUSSOTECO
IS
    /*****************************************************************
    Unidad         : LDC_PKGAPUSSOTECO
    Descripcion    :
    Autor          : OLSOFTWARE SAS/ Miguel Ballesteros
    Fecha          : 17/01/2021

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================

    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
   /*******************************************************************************

    Unidad     :   FsbGetUserPermit
    Descripcion:   obtiene el codigo de los usuarios que pueden acceder a la forma,
				   estos estan configurados en un parametro
    *******************************************************************************/
    FUNCTION FsbGetUserPermit return VARCHAR2;


	/*******************************************************************************

    Unidad     :   fnGetDatosContrato
    Descripcion:   Obtiene los contratos en estado pendiente
    *******************************************************************************/
	FUNCTION fnGetDatosContrato
     RETURN PKCONSTANTE.TYREFCURSOR;


	/*******************************************************************************

    Unidad     :   Ldc_UpdateContratos
    Descripcion:   Actualiza la informacion de los contratos en la tabla LDC_CONTRATPENDTERMI
    *******************************************************************************/
	PROCEDURE Ldc_UpdateContratos(nuContrato 		in	suscripc.susccodi%type,
                                  sbEstado      	in	varchar2,
								  sbObservacion		in	varchar2,
								  coderror          out number,
                                  messerror         out varchar2);




END LDC_PKGAPUSSOTECO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGAPUSSOTECO
IS

     /*****************************************************************
    Unidad         : LDC_PKGAPUSSOTECO
    Descripcion:
    Autor          : OLSOFTWARE SAS
    Fecha          : 17/01/2021

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

	/*******************************************************************************
	Metodo: FsbGetUserPermit
	Descripcion:  obtiene el codigo de los usuarios que pueden acceder a la forma,
				   estos estan configurados en un parametro

	Autor: Miguel Angel Ballesteros Gomez
	Fecha: 17/01/2021

	Historia de Modificaciones
	Fecha             Autor             Modificacion
	=========       =========           ====================

	*******************************************************************************/
   FUNCTION FsbGetUserPermit
   return VARCHAR2 is

    sbUsuario       varchar2(100);

    CURSOR cuValUserConect is
       select To_Number(column_value)
			from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('LDC_PARUSERPERMI', NULL), ','))
			where column_value = ge_bopersonal.fnuGetPersonId;

    BEGIN

        if(cuValUserConect%isopen)then
            close cuValUserConect;
        end if;

        open cuValUserConect;
        fetch cuValUserConect into sbUsuario;
            if(cuValUserConect%notfound)then
                sbUsuario := 'NotFind';
            end if;
        close cuValUserConect;


        return  sbUsuario;

      EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END FsbGetUserPermit;



	/*******************************************************************************
    Metodo: fnGetDatosContrato
    Descripcion:  Funcion que obtiene todos los contratos en estado pendiente de la tabla
				  LDC_CONTRATPENDTERMI

    Autor: Miguel Angel Ballesteros Gomez
    Fecha: 17/01/2021

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================

    *******************************************************************************/
   FUNCTION fnGetDatosContrato
   RETURN PKCONSTANTE.TYREFCURSOR IS

    cuLista   PKCONSTANTE.TYREFCURSOR;


	BEGIN

		 OPEN cuLista FOR
		  select contrato_id contrato
			FROM LDC_CONTRATPENDTERMI
			where estado = 'P';


		RETURN cuLista;


	  EXCEPTION
		when ex.CONTROLLED_ERROR then
			raise ex.CONTROLLED_ERROR;
		when others then
			Errors.setError;
			raise ex.CONTROLLED_ERROR;

	END fnGetDatosContrato;


	/*******************************************************************************
	Metodo: Ldc_UpdateContratos
	Descripcion:  Actualiza la informacion de los contratos en la tabla LDC_CONTRATPENDTERMI

	Autor: Miguel Angel Ballesteros Gomez
	Fecha: 17/01/2021

	Historia de Modificaciones
	Fecha             Autor             Modificacion
	=========       =========           ====================

	*******************************************************************************/

    PROCEDURE Ldc_UpdateContratos(nuContrato 		in	suscripc.susccodi%type,
                                  sbEstado      	in	varchar2,
								  sbObservacion		in	varchar2,
								  coderror          out number,
                                  messerror         out varchar2)IS

    sberror            varchar2(3000);
    nuExist             number;

    CURSOR cuValContrato IS
		SELECT count(*)
			FROM ldc_contratpendtermi
			WHERE contrato_id = nuContrato;

    BEGIN

        coderror :=0;
        messerror:='Sin error';

		if(cuValContrato%isopen)then
			close cuValContrato;
		end if;

        OPEN cuValContrato;
        FETCH cuValContrato INTO nuExist;
        CLOSE cuValContrato;

        IF nuExist > 0 THEN
            update LDC_CONTRATPENDTERMI set estado = sbEstado,
											observacion = sbObservacion,
											ident_user = ut_session.getuser,
											fecha_ejecucion = sysdate
											where contrato_id = nuContrato;
        END IF;

        commit;

       EXCEPTION
     when others then
          rollback;
          sberror:=sqlerrm;
          coderror:=-1;
          messerror:='Error guardando informacion de los contratos # '||nuContrato||'. '||substr(sberror,1,100);


    END Ldc_UpdateContratos;




END LDC_PKGAPUSSOTECO;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGAPUSSOTECO
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKGAPUSSOTECO', 'ADM_PERSON');
END;
/
