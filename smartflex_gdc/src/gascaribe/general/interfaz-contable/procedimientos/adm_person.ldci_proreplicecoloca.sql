CREATE OR REPLACE PROCEDURE adm_person.ldci_proRepliCecoloca(inuDepa IN ge_geogra_location.geograp_location_id%TYPE,
                                                  inuLoca IN ge_geogra_location.geograp_location_id%TYPE,
                                                  inuTitr IN or_task_type.task_type_id%TYPE)
/******************************************************************
Propiedad intelectual Efigas S.A. E.S.P.

SCRIPT        : ldci_proRepliCecoloca
AUTOR         : Diego Andrés Cardona García
FECHA         : 16-07-2014
DESCRIPCION   : Copia del método ldci_preplicacecoloca.
                Replica la configuracion de centros de costos por
                las localidades.

HISTORIA DE MODIFICACIONES
AUTOR         FECHA             DESCRIPCION
09/05/2024    Paola Acosta      OSF-2672: Cambio de esquema ADM_PERSON 
------------- ----------- -----------------------------------------
*******************************************************************/
IS

  --<<
  -- Tabla para PL para almacenar los centros de costos por localidad
  -->>
  TYPE gtyldci_cecoubigetra IS TABLE OF ldci_cecoubigetra%ROWTYPE INDEX BY BINARY_INTEGER;
  gvtyldci_cecoubigetra gtyldci_cecoubigetra;

  --<<
  -- Variables
  -->>
  vaCEBE   ldci_centbeneloca.celocebe%TYPE;
  vaCECO   ldci_centrocosto.cecocodi%TYPE;
  vaNWCECO ldci_centrocosto.cecocodi%TYPE;
  nuCant   NUMBER;
  vaerror  VARCHAR2(1000);
  insdepa  NUMBER;
  isnlolca NUMBER;
  institr  NUMBER;
  insceco  VARCHAR2(10);
  nuIDX NUMBER :=0; --Indicador de registro de la tabla PL

  --<<
  -- Centro de Costos por Localidad
  -->>
  CURSOR cuCecoLoca(nuDepa IN ge_geogra_location.geograp_location_id%TYPE,
                    nuLoca IN ge_geogra_location.geograp_location_id%TYPE,
                    nuTitr IN or_task_type.task_type_id%TYPE)
  IS
  SELECT ccbgdpto, ccbgloca, ccbgtitr, ccbgceco, ccbgorin,
         DECODE(ccbgceco,'-1','-1',SubStr(ccbgceco,5,2)) ceco
    FROM ldci_cecoubigetra
   WHERE ccbgdpto = nuDepa
     AND ccbgloca = nuLoca
     AND ccbgtitr = Decode(nuTitr, -1, ccbgtitr, nuTitr);

  --<<
  -- Localidades
  -->>
  CURSOR cuLocalidades(inuDepa IN ge_geogra_location.geograp_location_id%TYPE,
                       inuLoca IN ge_geogra_location.geograp_location_id%TYPE)
  IS
  SELECT geo_loca_father_id locadepa, geograp_location_id locacodi, description locanomb
    FROM ge_geogra_location
   WHERE geog_loca_area_type = 3
     AND geograp_location_id <> -1
   MINUS
  SELECT geo_loca_father_id locadepa, geograp_location_id locacodi, description locanomb
    FROM ge_geogra_location
   WHERE geog_loca_area_type = 3
     AND geo_loca_father_id  = inuDepa
     AND geograp_location_id = inuLoca;

  --<<
  -- Centros de beneficio
  -->>
  CURSOR cuCEBE (inuDepa IN ge_geogra_location.geograp_location_id%TYPE,
                 inuLoca IN ge_geogra_location.geograp_location_id%TYPE)
  IS
  SELECT celodpto, celoloca, celocebe
    FROM ldci_centbenelocal
   WHERE celodpto = inuDepa
     AND celoloca = inuLoca
     AND celocebe != 'A110';

  --<<
  -- Existencia del CECO
  -->>
  CURSOR cu_existCECO(ivaCECO IN ldci_centrocosto.cecocodi%TYPE)
  IS
  SELECT cecocodi
    FROM ldci_centrocosto
   WHERE cecocodi = ivaCECO;

  --<<
  -- Cursor para validar si ya existe configuración para la localidad
  -->>
  CURSOR cu_existconfig (nuDepa  IN ge_geogra_location.geograp_location_id%TYPE,
                         nuLoca  IN ge_geogra_location.geograp_location_id%TYPE,
                         nuTitr  IN or_task_type.task_type_id%TYPE)
  IS
  SELECT Count(*) cant
    FROM ldci_cecoubigetra
   WHERE ccbgdpto = nuDepa
     AND ccbgloca = nuLoca
     AND ccbgtitr = nuTitr;

BEGIN

  --<<
  -- Se recorren los centros de costo por localidad
  -->>
  FOR rc_cuCecoLoca IN cuCecoLoca(inuDepa, inuLoca, inuTitr) LOOP

     --<<
     -- Se recorren las localides a replicar
     -->>
     FOR rc_cuLocalidades IN cuLocalidades(rc_cuCecoLoca.ccbgdpto, rc_cuCecoLoca.ccbgloca) LOOP

         --<<
         -- Se inicializan las variables
         -->>
         vaCEBE    := NULL;
         vaCECO    := NULL;
         vaNWCECO  := NULL;

         --<<
         -- Se obtiene el centro de beneficio
         -->>
         FOR rc_cuCEBE IN cuCEBE(rc_cuLocalidades.locadepa,rc_cuLocalidades.locacodi) LOOP

             vaCEBE := rc_cuCEBE.celocebe;

         END LOOP;

         --<<
         -- Se valida el Centro de Costo y si es diferente de -1 se concatenan los ultimos dos digitos
         -- con el centro de beneficio
         -->>
         IF rc_cuCecoLoca.ccbgceco != '-1' THEN

             vaCECO := vaCEBE||rc_cuCecoLoca.ceco;

         --<<
         -- De lo contrario se deja el centro de costo -1
         -->>
         ELSE
              vaCECO := rc_cuCecoLoca.ccbgceco;
         END IF;

         --<<
         -- Si el centro de beneficio no es nulo
         -->>
         IF vaCEBE IS NOT NULL THEN

            --<<
            -- Se valida si existe el centro de costo
            -->>
            FOR rc_cu_existCECO IN cu_existCECO(vaCECO) LOOP
                vaNWCECO := rc_cu_existCECO.cecocodi;
            END LOOP;

            --<<
            -- Si existe el centro de costo
            -->>
            IF vaNWCECO IS NOT NULL THEN

               --<<
               -- Valida que la configuracion no exista en la tabla para realizar la inserccion
               -->>
               FOR rc_cu_existconfig IN cu_existconfig(rc_cuLocalidades.locadepa,
                                                       rc_cuLocalidades.locacodi,
                                                       rc_cuCecoLoca.ccbgtitr)  LOOP

                  nuCant := rc_cu_existconfig.cant;

               END LOOP;

               --<<
               -- Si No existe configuracion
               -->>
               IF nuCant = 0 THEN

                  insdepa  := rc_cuLocalidades.locadepa;
                  isnlolca := rc_cuLocalidades.locacodi;
                  institr  := rc_cuCecoLoca.ccbgtitr;
                  insceco  := vaNWCECO;

                  vaerror :=(insdepa||'-'||isnlolca||'-'||institr||'-'||insceco);

                  gvtyldci_cecoubigetra(nuIDX).ccbgdpto := rc_cuLocalidades.locadepa;
                  gvtyldci_cecoubigetra(nuIDX).ccbgloca := rc_cuLocalidades.locacodi;
                  gvtyldci_cecoubigetra(nuIDX).ccbgtitr := rc_cuCecoLoca.ccbgtitr;
                  gvtyldci_cecoubigetra(nuIDX).ccbgorin := rc_cuCecoLoca.ccbgorin;
                  gvtyldci_cecoubigetra(nuIDX).ccbgceco := vaNWCECO;

                  nuIDX := nuIDX +1;

               --<<
               -- Se actualiza la información del registro ya existente
               -->>
               ELSE

                  UPDATE ldci_cecoubigetra
                     SET ccbgceco = vaNWCECO,
                         ccbgorin = rc_cuCecoLoca.ccbgorin
                   WHERE ccbgdpto = rc_cuLocalidades.locadepa
                     AND ccbgloca = rc_cuLocalidades.locacodi
                     AND ccbgtitr = rc_cuCecoLoca.ccbgtitr;

               END IF;

            END IF;

         END IF;

     END LOOP;

  END LOOP;

  --<<
  -- Proceso de volver persistente los datos
  -->>
  FORALL y IN gvtyldci_cecoubigetra.First..gvtyldci_cecoubigetra.Last
     INSERT INTO ldci_cecoubigetra VALUES gvtyldci_cecoubigetra(y);


EXCEPTION
  WHEN OTHERS THEN
    Dbms_Output.Put_Line('[ldci_proRepliCecoloca] Error al Replica los Centros de Costo por Localidad - '||SQLERRM);

END LDCI_PROREPLICECOLOCA;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PROREPLICECOLOCA
BEGIN
    pkg_utilidades.praplicarpermisos('LDCI_PROREPLICECOLOCA', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDCI_PROREPLICECOLOCA para reportes
GRANT EXECUTE ON adm_person.LDCI_PROREPLICECOLOCA TO rexereportes;
/

