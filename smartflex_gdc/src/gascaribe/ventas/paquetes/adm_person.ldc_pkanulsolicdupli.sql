CREATE OR REPLACE PACKAGE adm_person.ldc_pkanulsolicdupli
IS
    /*****************************************************************
    Unidad         : LDC_PKANULSOLICDUPLI
    Descripcion    : PAQUETE QUE BUSCA SOLICITUDES DE DUPLICADO REPETIDAS Y LAS ELIMINA
    Autor          : MIGUEL BALLESTEROS / OLSOFTWARE SAS
    Fecha          : 23/10/2019

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    5/11/2019    MABG                       se modifica el procedimiento LDC_SEARCHSOLIREPET
                                            que validará primero los contratos antes de validar las
                                            fechas de las solicitudes
    26/06/2024   Adrianavg                  OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON   
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /*******************************************************************************

    Unidad     :   LDC_SEARCHSOLIREPET
    Descripcion:   Se encarga de buscar las solicitudes de duplicado que esten repetidas
                   para anularlas y que no sean visualizadas en la forma LDCIEC
    *******************************************************************************/
      PROCEDURE LDC_SEARCHSOLIREPET
    (
       nuTipoSolicitud         IN   ps_package_type.package_type_id%TYPE,
       nuEstSolicitud          IN   mo_packages.motive_status_id%TYPE,
       sbREQUEST_DATE          IN   mo_packages.request_date%TYPE,
       sbATTENTION_DATE        IN   mo_packages.attention_date%TYPE,
       nuTipoTrabajo           IN   VARCHAR2
    );

    /*******************************************************************************
    Unidad     :   LDC_ANULASOLICDUPLI
    Descripcion:   Anula las solicitudes de duplicado y elimina cargos
    *******************************************************************************/
    PROCEDURE LDC_ANULASOLICDUPLI
    (
       inuOrderId              IN   or_order.order_id%type,
       nuSolicitud             IN   MO_PACKAGES.PACKAGE_ID%TYPE,
       onuError                OUT  number,
       osbErrorMessage         OUT  varchar2
    );

END LDC_PKANULSOLICDUPLI;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKANULSOLICDUPLI
    IS
    /*****************************************************************
    Unidad         : LDC_PKANULSOLICDUPLI
    Descripcion    : PAQUETE QUE BUSCA SOLICITUDES DE DUPLICADO REPETIDAS Y LAS ELIMINA
    Autor          : MIGUEL BALLESTEROS / OLSOFTWARE SAS
    Fecha          : 23/10/2019

    Historia de Modificaciones
    Fecha       Autor                       ModificaciÃ¿Â¿Ã¿Â³n
    =========   =========                   ====================
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    /**************************************************************
    Unidad      :  LDC_SEARCHSOLIREPET
    Descripcion :  Se encarga de buscar los contratos que esten repetidos y luego
                   las solicitudes de duplicado que esten repetidas
                   para anularlas y que no sean visualizadas en la forma LDCIEC

    Autor	       : MIGUEL BALLESTEROS / OLSOFTWARE SAS
    Fecha	       : 23/10/2019

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    5/11/2019    MABG                   se validará primero los contratos antes de validar las
                                        fechas de las solicitudes
    ***************************************************************/
    PROCEDURE LDC_SEARCHSOLIREPET
    (
       nuTipoSolicitud         IN   ps_package_type.package_type_id%TYPE,
       nuEstSolicitud          IN   mo_packages.motive_status_id%TYPE,
       sbREQUEST_DATE          IN   mo_packages.request_date%TYPE,
       sbATTENTION_DATE        IN   mo_packages.attention_date%TYPE,
       nuTipoTrabajo           IN   VARCHAR2
    )
    IS

     posicion           number:= 1;
     minuteSoli         number;
     minuteEstab        number; -- los minutos establecidos por el parametro
     onuErrorCode       number;
     sbErrorMessage     varchar2(2000);


    Cursor cuGetSoliRepe is
        select mp.package_id solicitud_duplicado,
               mp.request_date Fecha_Solicitud,
               oo.order_id nuOrden,
			   oa.subscription_id Contrato
        from mo_packages mp,
             or_order_activity oa,
             or_order oo
        where mp.package_type_id = nuTipoSolicitud
        and   mp.motive_status_id = nuEstSolicitud
        and   mp.package_id = oa.package_id
        and   oo.order_id = oa.order_id
        and   oo.order_status_id = 5
        and   mp.request_date BETWEEN to_date(sbREQUEST_DATE, 'dd/mm/yyyy hh24:mi:ss')
                                 and  to_date(sbATTENTION_DATE, 'dd/mm/yyyy hh24:mi:ss')
        and   oa.task_type_id in (nuTipoTrabajo)
        order by Contrato asc;


    --Definimos un Record con los campos similares a los del CURSOR: cuGetSoliRepe
        TYPE typ_contrato IS RECORD
        (
            contrato	   or_order_activity.subscription_id%TYPE,
			solicitud      mo_packages.package_id%TYPE,
            fecha          mo_packages.request_date%TYPE,
            nuOrden        or_order.order_id%TYPE
        );


    --DefiniciÃ³n del Tipo Tabla:
        TYPE typ_assoc_array IS TABLE OF
              typ_contrato    --typ_contrato es el Tipo Record antes creado.
              INDEX BY PLS_INTEGER;


        --Declaramos una Variable del Tipo Tabla anterior:
        v_CellContrato   typ_assoc_array;


 BEGIN

    ut_trace.trace('[INICIO] LDC_PKANULSOLICDUPLI.LDC_SEARCHSOLIREPET', 10);

    minuteEstab := OPEN.DALD_PARAMETER.fnuGetNUMERIC_VALUE('LDCIEC_RANGO', NULL);

    ----------------- Se recorre el cursor y se guarda en un vector -----------------

    FOR item IN cuGetSoliRepe
      LOOP
	    v_CellContrato(posicion).contrato       :=  item.Contrato;
        v_CellContrato(posicion).solicitud      :=  item.solicitud_duplicado;
        v_CellContrato(posicion).fecha          :=  item.Fecha_Solicitud;
        v_CellContrato(posicion).nuOrden        :=  item.nuOrden;

         EXIT WHEN cuGetSoliRepe%NOTFOUND;  ---si no encuentra mas valores dentro del cursor termina el ciclo.
          posicion   :=  posicion+1;
      END LOOP;



     ----------------- Se recorre el vector -----------------
    IF(v_CellContrato.COUNT > 0)THEN

        FOR i IN v_CellContrato.FIRST..v_CellContrato.LAST LOOP

            FOR j IN i+1..v_CellContrato.LAST LOOP

                -- se valida que los contratos sean iguales para la anulación de su solicitud
                IF v_CellContrato(i).contrato = v_CellContrato(j).contrato THEN

                    -- se realiza la resta de fechas para saber los minutos de diferencia
                    minuteSoli := (TO_DATE(v_CellContrato(j).fecha, 'DD.MM.YYYY HH24:MI:SS') -
									TO_DATE(v_CellContrato(i).fecha, 'DD.MM.YYYY HH24:MI:SS')) * (60 * 24);

					-- se hace la comparacion para saber la diferencia de minutos entre solicitudes
					if(minuteSoli <= minuteEstab)then

						if(v_CellContrato(i).solicitud <> v_CellContrato(j).solicitud)then
						  ut_trace.trace('se anula la solicitud con el procedimiento LDC_PKANULSOLICDUPLI.LDC_ANULASOLICDUPLI', 15);

						  --- se llama al procedimiento que se encarga de realizar el proceso de la anulacion de la solicitud
						  LDC_PKANULSOLICDUPLI.LDC_ANULASOLICDUPLI( v_CellContrato(j).nuOrden,
																	v_CellContrato(j).solicitud,
																	onuErrorCode,
																	sbErrorMessage);

                          IF (onuErrorCode <> 0) then
								ge_boerrors.seterrorcodeargument(onuErrorCode,sbErrorMessage);
								RAISE ex.controlled_error;
                          END IF;

						end if;

						v_CellContrato(j) := v_CellContrato(i);

					-- si los minutos no esta en el rango de la 1 solicitud, entonces me posiciono en la solicitud sgte
					else
						EXIT WHEN minuteSoli > minuteEstab;
					end if;

                ELSE
                    EXIT WHEN v_CellContrato(i).contrato <> v_CellContrato(j).contrato;
				END IF;

            END LOOP;

        END LOOP;

    END IF;


    ut_trace.trace('Inicio Metodo LDC_PKANULSOLICDUPLI.LDC_SEARCHSOLIREPET',1);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END LDC_SEARCHSOLIREPET;




    /**************************************************************
    Unidad      :  LDC_ANULASOLICDUPLI
    Descripcion :  Anula las solicitudes de duplicado y elimina cargos

    Autor	       : MIGUEL BALLESTEROS / OLSOFTWARE SAS
    Fecha	       : 23/10/2019

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    ***************************************************************/

    PROCEDURE LDC_ANULASOLICDUPLI
    (
       inuOrderId              IN   OR_order.order_id%type,
       nuSolicitud             IN   MO_PACKAGES.PACKAGE_ID%TYPE,
       onuError                OUT  number,
       osbErrorMessage         OUT  varchar2
    )
    IS

      CURSOR CuGetDataInstance is
      select  instance_id, unit_id
        from   open.wf_instance
        where  external_id = to_char(nuSolicitud)
        and   previous_status_id is not null;


----------------------------------------------------------------------------------------
-- Procedimiento Pragma para actualizar la tabla wf_instance
----------------------------------------------------------------------------------------
procedure proUpdwfinstance (inuSolicitud   in  MO_PACKAGES.PACKAGE_ID%TYPE,
                            inuEstado      in  wf_instance.status_id%type,
                            inuEstadoPrev  in  wf_instance.previous_status_id%type,
                            inuInstanceId  in  wf_instance.instance_id%type) is
PRAGMA AUTONOMOUS_TRANSACTION;

    begin

        update open.wf_instance
            set status_id = inuEstado,
            previous_status_id = inuEstadoPrev
            where instance_id = inuInstanceId
            and external_id = inuSolicitud;

        commit;

    exception
      when others then
         null;
    end;
----------------------------------------------------------------------------------------
-- Fin del procedimiento Pragma
----------------------------------------------------------------------------------------


BEGIN

    ut_trace.trace('Inicio Metodo LDC_PKANULSOLICDUPLI.LDC_ANULASOLICDUPLI',1);


      -- se recorre el cursor y por cada solicitud obtenida se actualiza el estado para cancelarla
      for item in CuGetDataInstance
      loop

          -- se actualiza la tabla wf_instance para la anulacion de la solicitud
           if item.unit_id = 102227 OR item.unit_id = 102235 then
                -- se llama al procedimiento pragma que se encarga de hacer la actualizacion
                proUpdwfinstance(nuSolicitud, 14, 4, item.instance_id);
           end if;

           if item.unit_id = 102228 OR item.unit_id = 102233 then
                proUpdwfinstance(nuSolicitud, 6, 5, item.instance_id);
           end if;

           if item.unit_id = 102231 then
                proUpdwfinstance(nuSolicitud, 6, 4, item.instance_id);
           end if;
           -- fin de la actualizaion

         exit when CuGetDataInstance%notfound;
     end loop;



     -- se actualiza el estado de la solicitud
     update open.mo_packages set motive_status_id = 32 where package_id = nuSolicitud;


     -- se actualiza el estado del motivo de la solicitud
    update open.mo_motive set motive_status_id = 5 where package_id = nuSolicitud;

    DBMS_OUTPUT.PUT_LINE('Se termina la anulacion de la solicitud');


    -- Cancela la orden asociada a la solicitud
        Or_BOAnullOrder.AnullOrderWithOutVal(inuOrderId, sysdate);

        ut_trace.trace('Termino la anulacion de la orden de forma correcta', 15);

        onuError := 0;

     commit;

        ut_trace.trace('Fin del Metodo LDC_PKANULSOLICDUPLI.LDC_ANULASOLICDUPLI',1);

   EXCEPTION
        when ex.CONTROLLED_ERROR then
            ROLLBACK;
            onuError := -1;
            osbErrorMessage := 'Error en la anulaciÃ³n de la solicitud';
            raise ex.CONTROLLED_ERROR;
        when others then
            ROLLBACK;
            Errors.setError;
            onuError := -1;
            osbErrorMessage := 'Error en la anulaciÃ³n de la solicitud';
            raise ex.CONTROLLED_ERROR;

    END LDC_ANULASOLICDUPLI;


END LDC_PKANULSOLICDUPLI;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKANULSOLICDUPLI
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKANULSOLICDUPLI', 'ADM_PERSON'); 
END;
/
