PL/SQL Developer Test script 3.0
253
-- Created on 13/07/2022 by JORGE VALIENTE 
declare

csbOSS_PNO_SMS_200398 CONSTANT VARCHAR2(100) := 'OSS_PNO_SMS_200398_1';

  NUORDEN open.OR_ORDER.ORDER_ID%TYPE := 129971199;--129426821;
  NUGRUPO_PREGUNTA_ID open.LDC_PREGUNTA_GRUPO.GRUPO_PREGUNTA_ID%TYPE:=82;
  NUPREGUNTA_ID open.LDC_PREGUNTA_GRUPO.PREGUNTA_ID%TYPE := 85;
  SBRESPUESTA open.LDC_ENCUESTA.RESPUESTA%TYPE := 1044;--1045;
  
    --CUROSR PARA ESTABLECER QUE TIPO DE PROCESO SE DEBE GENERAR
    --SI UNA SOLCIITUD O UNA ACTIVIDAD
    CURSOR CUDATORESPUESTA(NUSESUCATE open.SERVSUSC.SESUCATE%TYPE) IS
      SELECT LRG.GRUPO_RESPUESTA_ID,
             LRG.RESPUESTA_ID,
             (SELECT LR.DESCRIPCION
                FROM open.LDC_RESPUESTA LR
               WHERE LR.RESPUESTA_ID = LRG.RESPUESTA_ID) RESPUESTA,
             LRG.ORDEN,
             LRG.PACKAGE_TYPE_ID,
             LRG.ITEMS_ID,
             LRG.CATECODI,
             LRG.OBSERVACION
        FROM open.LDC_RESPUESTA_GRUPO LRG
       WHERE LRG.GRUPO_RESPUESTA_ID IN
             (SELECT LPG.GRUPO_RESPUESTA_ID
                FROM open.LDC_PRE_GRUPO_RES LPG
               WHERE LPG.PREGUNTA_ID = NUPREGUNTA_ID)
         AND LRG.RESPUESTA_ID = TO_NUMBER(SBRESPUESTA)
         AND LRG.CATECODI =
             DECODE(LRG.CATECODI, -1, LRG.CATECODI, NUSESUCATE);

    TEMPCUDATORESPUESTA CUDATORESPUESTA%ROWTYPE;

    --CURSOR PARA OBTENER DATOS DEL PRODUCTO
    CURSOR CUSERVICIO IS
      SELECT S.*
        FROM OPEN.OR_ORDER_ACTIVITY OOA, open.SERVSUSC S
       WHERE OOA.ORDER_ID = NUORDEN
         AND S.SESUNUSE = OOA.PRODUCT_ID
         AND S.SESUSERV = 7014;
             --DALD_PARAMETER.fnuGetNumeric_Value('COD_SERV_GAS', NULL);

    TEMPCUSERVICIO CUSERVICIO%ROWTYPE;

    --CURSOR PARA OBTENER DATOS DEL PRODUCTO
    CURSOR CUGRUPOPREGUNTAACTIVO IS
      SELECT LGP.*
        FROM open.LDC_PREGUNTA_GRUPO LPG,
             open.LDC_PREGUNTA       LP,
             open.LDC_GRUPO_PREGUNTA LGP
       WHERE LP.PREGUNTA_ID = NUPREGUNTA_ID
         AND LP.PREGUNTA_ID = LPG.PREGUNTA_ID
         AND LGP.GRUPO_PREGUNTA_ID = NUGRUPO_PREGUNTA_ID
         AND LPG.GRUPO_PREGUNTA_ID = LGP.GRUPO_PREGUNTA_ID
         AND LGP.ACTIVO = 'S';

    TEMPCUGRUPOPREGUNTAACTIVO CUGRUPOPREGUNTAACTIVO%ROWTYPE;
    CNUTRAMITECAMBIOUSO       open.PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE := 100225;
    --DALD_PARAMETER.fnuGetNumeric_Value('MOTIVO_CAMBIO_CATEGO',0);

    -- CA 200-398       .
    nuNuevaOT open.or_order.order_id%TYPE; -- Ot generada

    --CASO 200-796
    sberrrorexcepcion varchar2(4000);
    sbcontrol         varchar2(4000) := 'CONTROL';
    --CUROSR PARA VALIDAR QUE LA RESPUESTA TIENE ASOCIADA UNA SOLCIITUD O ACTIVIDAD
    CURSOR CURESPUESTAACTIVIDAD IS
      SELECT LRG.ITEMS_ID ACTIVIDAD
        FROM open.LDC_RESPUESTA_GRUPO LRG
       WHERE LRG.RESPUESTA_ID =
             DECODE(NVL(TRANSLATE(SBRESPUESTA, 'T 0123456789', 'T'), 0),
                    0,
                    SBRESPUESTA,
                    0)
       order by LRG.ITEMS_ID desc;

    rfCURESPUESTAACTIVIDAD CURESPUESTAACTIVIDAD%ROWTYPE;

function fblAplicaEntrega(isbEntrega In Varchar2) return boolean is

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GASES DEL CARIBE E.S.P.

  UNIDAD         : fblAplicaEntrega
  DESCRIPCION    : Funcion usada para verificar si una entrega aplica para la empresa.
  AUTOR          : JVivero (LUDYCOM)
  CASO           : 100-10465
  FECHA          : 08/03/2016

  PARAMETROS            DESCRIPCION
  ============      ===================
  isbEntrega        Nombre de la entrega

  FECHA             AUTOR                   MODIFICACION
  ==========        =========               ====================
  08/03/2016        JVivero (LUDYCOM)       CreaciOn.
  ******************************************************************/

  -- Cursor para consultar si la entrega aplica para la gasera
  Cursor Cu_Aplica Is
    Select a.Aplica
    From   open.Ldc_Versionentrega t, open.Ldc_Versionempresa e, open.Ldc_Versionaplica a, open.Sistema s
    Where  t.Codigo = a.Codigo_Entrega
    And    e.Codigo = a.Codigo_Empresa
    And    e.Nit = s.Sistnitc
    And    t.Nombre_Entrega = isbEntrega;

  -- Variables
  sbAplica Ldc_Versionaplica.Aplica%Type;

BEGIN

  -- Se abre el cursor para validar si aplica la entrega
  Open Cu_Aplica;
  Fetch Cu_Aplica Into sbAplica;
  Close Cu_Aplica;

  -- Si aplica la entrega se retorna True, sino aplica se retorna False
  If Nvl(sbAplica, 'N') = 'S' Then

    Return True;

  Else

    Return False;

  End If;

END fblAplicaEntrega;


  BEGIN

    dbms_output.put_line('INICIO LDC_BOENCUESTA.PRGENERAPROCESO');

    OPEN CURESPUESTAACTIVIDAD;
    FETCH CURESPUESTAACTIVIDAD
      INTO rfCURESPUESTAACTIVIDAD;
    --VALIDA QUE EL GRUPO DE LA PREGUNTA ESTE ACTIVO PARA GENERAR SOLCITUD O ACTIVIDAD
    sberrrorexcepcion := 'Servicio LDC_BOENCUESTA.PRGENERAPROCESO - Error validando el codigo de la respuesta en el cursor CURESPUESTAACTIVIDAD';
    CLOSE CURESPUESTAACTIVIDAD;

    IF nvl(rfCURESPUESTAACTIVIDAD.ACTIVIDAD, 0) > 0 THEN

      /*LDC_PRLOGENCUESTA(NUORDEN,
                        NUGRUPO_PREGUNTA_ID,
                        NUPREGUNTA_ID,
                        SBRESPUESTA,
                        sbcontrol);*/

      OPEN CUGRUPOPREGUNTAACTIVO;
      FETCH CUGRUPOPREGUNTAACTIVO
        INTO TEMPCUGRUPOPREGUNTAACTIVO;
      --VALIDA QUE EL GRUPO DE LA PREGUNTA ESTE ACTIVO PARA GENERAR SOLCITUD O ACTIVIDAD
      sberrrorexcepcion := 'Servicio LDC_BOENCUESTA.PRGENERAPROCESO - Error generado antes de validar el cursor CUGRUPOPREGUNTAACTIVO';
      IF CUGRUPOPREGUNTAACTIVO%FOUND THEN

        OPEN CUSERVICIO;
        FETCH CUSERVICIO
          INTO TEMPCUSERVICIO;
        --VALIDACION SERVICIOS
        sberrrorexcepcion := 'Servicio LDC_BOENCUESTA.PRGENERAPROCESO - Error generado antes de validar el cursor CUSERVICIO';
        IF CUSERVICIO%FOUND THEN
          OPEN CUDATORESPUESTA(TEMPCUSERVICIO.SESUCATE);
          FETCH CUDATORESPUESTA
            INTO TEMPCUDATORESPUESTA;
          --VALIDA LA EXISTENCIA REGSITRO PARA RESPUESTA
          sberrrorexcepcion := 'Servicio LDC_BOENCUESTA.PRGENERAPROCESO - Error generado antes de validar el cursor CUDATORESPUESTA';
          IF CUDATORESPUESTA%FOUND THEN
            --VALIDA SI CREA SOLCITUD A LA RESPUESTA
            IF TEMPCUDATORESPUESTA.PACKAGE_TYPE_ID IS NOT NULL THEN
              IF TEMPCUDATORESPUESTA.PACKAGE_TYPE_ID = 100101 THEN
                dbms_output.put_line('LDC_BOENCUESTA.PRTRAMITE100101('||NUORDEN||','||
                                               TEMPCUDATORESPUESTA.ITEMS_ID||','||
                                               TEMPCUDATORESPUESTA.OBSERVACION||')');
                sberrrorexcepcion := 'Servicio LDC_BOENCUESTA.PRGENERAPROCESO - Error generado al llamar el servicio LDC_BOENCUESTA.PRTRAMITE100101';
              END IF;
              IF TEMPCUDATORESPUESTA.PACKAGE_TYPE_ID = CNUTRAMITECAMBIOUSO THEN
                IF (FBLAPLICAENTREGA('OSS_PNO_KCM_1009194_1')) THEN
                  --SE CREAR? EL TR?MITE DE CAMBIO DE USO DE SERVICIO
                  dbms_output.put_line('LDC_BOENCUESTA.PRTRAMITE100225('||NUORDEN||','||
                                                 TEMPCUDATORESPUESTA.RESPUESTA_ID||')');
                  sberrrorexcepcion := 'Servicio LDC_BOENCUESTA.PRGENERAPROCESO - Error generado al llamar el servicio LDC_BOENCUESTA.PRTRAMITE100225';
                END IF;
              END IF;
              --VALIDA SI CREA ACTIVIDAD A LA RESPUESTA
            ELSIF TEMPCUDATORESPUESTA.ITEMS_ID IS NOT NULL THEN
              dbms_output.put_line('LDC_BOENCUESTA.PRACTIVIDAD('||NUORDEN||','||
                                         TEMPCUDATORESPUESTA.ITEMS_ID||','||
                                         TEMPCUDATORESPUESTA.OBSERVACION||')');
              sberrrorexcepcion := 'Servicio LDC_BOENCUESTA.PRGENERAPROCESO - Error generado al llamar el servicio LDC_BOENCUESTA.PRACTIVIDAD';
              IF fblAplicaEntrega(csbOSS_PNO_SMS_200398) THEN
                dbms_output.put_line('proLegalizaCierrePNO(inuOrden => '||nuOrden||')');
                sberrrorexcepcion := 'Servicio LDC_BOENCUESTA.PRGENERAPROCESO - Error generado al llamar el servicio proLegalizaCierrePNO';
              END IF;
            END IF;
            --CASO 200-796
            --control de errores
          ELSE
            dbms_output.put_line('Servicio LDC_BOENCUESTA.PRGENERAPROCESO - La pregunta junto con la respuesta y categor?a no tienen configurada ning?n tipo de actividad en la respuesta');
            --CASO 200-796
          END IF;
          CLOSE CUDATORESPUESTA;
        ELSE
          --CASO 200-796
          --control de errores
          dbms_output.put_line('Servicio LDC_BOENCUESTA.PRGENERAPROCESO - La orden no est? asociada a un producto de GAS');
          --CASO 200-796
          DBMS_OUTPUT.put_line('NO GENERO NINGUN TRAMITE O ACTIVIDAD');
        END IF; --FIN VALIDACION SERVICIOS

        CLOSE CUSERVICIO;

        --CASO 200-796
        --control de errores
      ELSE
        dbms_output.put_line('Servicio LDC_BOENCUESTA.PRGENERAPROCESO - El c?digo de la pregunta no est? activa o no est? configurada en ning?n grupo');
        --CASO 200-796
      END IF;
      CLOSE CUGRUPOPREGUNTAACTIVO;

      /*begin
        delete ldc_log_encuesta lle
         where lle.orden_id = NUORDEN
           and lle.inconveniente = sbcontrol;
      end;*/

    END IF;
    --CLOSE CURESPUESTAACTIVIDAD;

    dbms_output.put_line('FIN LDC_BOENCUESTA.PRGENERAPROCESO');

  /*EXCEPTION
    WHEN ex.controlled_error THEN
      ROLLBACK;
      LDC_PRLOGENCUESTA(NUORDEN,
                        NUGRUPO_PREGUNTA_ID,
                        NUPREGUNTA_ID,
                        SBRESPUESTA,
                        sberrrorexcepcion);
      --RAISE;
    WHEN OTHERS THEN
      ROLLBACK;
      LDC_PRLOGENCUESTA(NUORDEN,
                        NUGRUPO_PREGUNTA_ID,
                        NUPREGUNTA_ID,
                        SBRESPUESTA,
                        sberrrorexcepcion);
      NULL;*/

end;
0
0
