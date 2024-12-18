CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALITEMCOTI214
  BEFORE INSERT OR UPDATE OR DELETE ON cc_quotation_item
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW

  /**************************************************************************************
  Propiedad intelectual de Olsoftware.

  Unidad         : LDC_TRGVALITEMCOTI214
  Descripcion    : Trigger para controlar la modificacion de items de una cotizacion
                   comercial/industrial desde CCQUO.

  Autor          : OLSOFTWARE/Miguel Angel Ballesteros Gomez
  Fecha          : 11/05/2020
  Caso           : 214

  Parametros           Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha         		Autor                        				 Modificacion
  =======================================================================================
  11/05/2020   			OLSOFTWARE/Miguel Angel Ballesteros Gomez        Creacion.
  10/09/2020			GDC / Miguel Angel Ballesteros Gomez   		 Se añade un nuevo parametro para
																	 permtir la ediccion de las cotizaciones
																	 de acuerdo al tipo de solicitud configurados
																	 en el parametro
  ***************************************************************************************/

DECLARE

	nuCaso 		   			   varchar2(30):='0000214';
    sbNombreAplicacion         sa_executable.name%TYPE;
    sbmensa					   varchar2(100);
	NUTIPOSOLICITUD			   MO_PACKAGES.PACKAGE_TYPE_ID%TYPE;
	NUVAL					   NUMBER;

	-- CURSOR QUE VALIDA EL TIPO DE SOLICITUD ASOCIADA A LA COTIZACION
	CURSOR CUVALIDATIPOSOLICITUD IS
		select mo.package_type_id
			from open.cc_quotation c,
				 open.mo_packages mo
			where  c.package_id = mo.package_id
			and   c.quotation_id = :NEW.QUOTATION_ID;

	-- CURSOR QUE COMPARA EL TIPO DE SOLICITUD DEL PARAMETRO CON EL DE LA COTIZACION
	CURSOR CUVALTIPOSOLEXCLUSION (NUTIPOSOL   NUMBER) IS
		select COUNT(1)
		 from table(ldc_boutilities.splitstrings(
					DALD_PARAMETER.fsbGetValue_Chain('LDC_PRTIPOSOLCOTI_214', NULL), ','))
		 WHERE To_Number(column_value) = NUTIPOSOL;

BEGIN

    IF fblAplicaEntregaxCaso(nuCaso)THEN

		IF(CUVALIDATIPOSOLICITUD%ISOPEN)THEN
			CLOSE CUVALIDATIPOSOLICITUD;
		END IF;

		OPEN CUVALIDATIPOSOLICITUD;
		FETCH CUVALIDATIPOSOLICITUD INTO NUTIPOSOLICITUD;
		CLOSE CUVALIDATIPOSOLICITUD;

		IF(CUVALTIPOSOLEXCLUSION%ISOPEN)THEN
			CLOSE CUVALTIPOSOLEXCLUSION;
		END IF;

		OPEN CUVALTIPOSOLEXCLUSION(NUTIPOSOLICITUD);
		FETCH CUVALTIPOSOLEXCLUSION INTO NUVAL;
		CLOSE CUVALTIPOSOLEXCLUSION;

		-- SI EL TIPO DE SOLICITUD DE LA COTIZACION NO ESTA EN EL PARAMETRO HARA EL PROCESO DE VALIDACION ACTUAL
		IF(NUVAL = 0)THEN

			-- se obtiene el nombre de la forma en sesion --
			sbNombreAplicacion := ut_session.getmodule;
			sbmensa := 'No se permite la modificacion en los valores del item asociados a esta cotizacion ['||:old.quotation_id||']';

			-- se valida que no se ejecute ninguna modificacion a esta tabla cuando se ejecute la forma CCQUO en el CNCRM
			IF(sbNombreAplicacion = 'CNCRM')THEN

				-- se impide que se eliminen los datos de la tabla cc_quotation_item
				IF(:new.unit_value IS NULL)THEN
					ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
					RAISE ex.controlled_error;
				END IF;

				IF(:new.items_quantity IS NULL)THEN
					ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
					RAISE ex.controlled_error;
				END IF;

				IF(:new.sequence_ IS NULL)THEN
					ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
					RAISE ex.controlled_error;
				END IF;

				IF(:new.unit_discount_value IS NULL)THEN
					ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
					RAISE ex.controlled_error;
				END IF;

			END IF;

		END IF;

    END IF;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR
    THEN RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    NULL;
END LDC_TRGVALITEMCOTI214;
/