CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_SOLICITUD_FAJU99

  /**************************************************************************
  Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : TRG_SOLICITUD_FAJU99
    Descripcion : trigger que garantiza que el usuario GISOSF pueda ejecutar
                  el tramite 289 - Aprobaci¿n de Ajustes de Facturaci¿n.
    Autor       : OLSoftware
    Ticket      : Caso 589
    Fecha       : 21-01-2021

  Historia de Modificaciones
  Fecha               Autor                Modificacion
  =========           =========          ====================
  21-01-2021          JHinestroza        Creacion
  **************************************************************************/
  BEFORE INSERT ON FA_APROMOFA
  FOR EACH ROW

DECLARE

    sbCaso589       LDC_VERSIONENTREGA.CODIGO_CASO%TYPE := '0000589';

BEGIN
  ut_trace.trace('Inicio del trigger TRG_SOLICITUD_FAJU99',1);

  IF FBLAPLICAENTREGAXCASO(sbCaso589) THEN

      IF (:NEW.APMOPRGA = 'R')  THEN
         IF (ut_session.Getuser <> 'GISOSF') THEN
           ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El usuario conectado no puede realizar reestratificaci¿n');
           raise ex.CONTROLLED_ERROR;
         END IF;
      END IF;

  END IF;

  ut_trace.trace('Fin del trigger TRG_SOLICITUD_FAJU99',1);
EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;

END TRG_SOLICITUD_FAJU99;
/
