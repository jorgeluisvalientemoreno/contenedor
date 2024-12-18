create or replace TRIGGER adm_person.ldctrg_confirepsuia
  BEFORE INSERT OR UPDATE ON ldc_sui_confirepsuia
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
  /**************************************************************
  Propiedad intelectual JM GESTIONINFORMATICA S.A.S.

  Trigger  :  LDCTRG_ldcresolsui

  DescripciÂ¿n  : Valida fecha inicial y final de la vigencia de la resoluciÃ³n

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 27-04-2016

  Historia de Modificaciones
  dsaltarin   	12/08/2022    OSF-506: Se corrige error que arroja al configurar una nueva causal debido a
                            que la consulta no tiene el codigo del tramite. Se adicionan excepciones para 
                            indicar en donde se esta arrojando el error
  jpinedc   	17/10/2024    OSF-3383: Se migra a ADM_PERSON
  **************************************************************/
DECLARE
  eerror      EXCEPTION;
  nucodtipres ldc_sui_tipres.codigo%TYPE;
  sbnombpal   ps_package_type.description%TYPE;
  sbnombpal2  ldc_sui_tipres.descripcion%TYPE;
  nuconta     NUMBER(8);
  nuconta2    NUMBER(8);
  nuconta3    NUMBER(8);
  nuconta4    NUMBER(8);
  nuconta5    NUMBER(8);
  nuconta6    NUMBER(8);
  nuconta7    NUMBER(8);
  nusession   NUMBER(15);
  sbequipo    ldc_sui_inconhomo.equipo%TYPE;
  nuError     NUMBER;
  sbError     VARCHAR2(4000);
BEGIN
 nusession := NULL;
 sbequipo  := NULL;
 SELECT userenv('SESSIONID') INTO nusession FROM dual;
 BEGIN
  SELECT se.machine INTO sbequipo FROM gv$session se WHERE se.audsid = nusession AND rownum = 1;
 EXCEPTION
  WHEN no_data_found THEN
   sbequipo := '-1';
 END;
 SELECT COUNT(1) INTO nuconta
   FROM ldc_sui_tipsol ts
  WHERE ts.tipo_solicitud = :new.tipo_solicitud;

  SELECT COUNT(1) INTO nuconta2
   FROM ldc_sui_estsol es
  WHERE es.estado_solicitud = :new.estado_solicitud;

 SELECT COUNT(1) INTO nuconta3
   FROM ldc_sui_caus_equ cr
  WHERE cr.causal_registro = :new.causal_reg
    AND cr.TIPO_SOLICITUD  = :new.TIPO_SOLICITUD;

 SELECT COUNT(1) INTO nuconta4
   FROM ldc_sui_titrcale tc, ldc_sui_respuesta tr
  WHERE tc.tipo_trabajo        = :new.tipo_trabajo
    AND tc.causal_legalizacion = :new.causal_legalizacion
    AND tc.respuesta           = tr.idrespu --506
    and tr.tipo_solicitud = :new.tipo_solicitud; --506;



  SELECT COUNT(1) INTO nuconta5
    FROM ldc_sui_medrec mr
   WHERE mr.codigo = :new.medio_recepcion;

  SELECT COUNT(1) INTO nuconta6
    FROM ldc_sui_esot_sspd do
   WHERE do.codigo = :new.otdocume;

 SELECT COUNT(1) INTO nuconta7
   FROM ldc_sui_tipres tr
  WHERE tr.codigo = :new.codigo_rpta;

  IF nuconta = 0 OR nuconta2 = 0 OR nuconta3 = 0 OR nuconta4 = 0 OR nuconta5 = 0 OR nuconta6 = 0 OR nuconta7 = 0 THEN
     INSERT INTO ldc_sui_inconhomo VALUES(
                                        :new.codigo
                                       ,:new.resolucion
                                       ,'Registro no creado, favor validar que existan los registros padres'
                                       ,SYSDATE
                                       ,USER
                                       ,sbequipo
                                        );
  ELSE
   -- Asignamos -1 en caso que la causal de registro sea NULA
   IF :new.causal_reg IS NULL THEN
      :new.causal_reg := -1;
   END IF;
   -- Asignamos -0 en caso de que el tipo de trabajo sea NULO
   IF :new.tipo_trabajo IS NULL THEN
      :new.tipo_trabajo := 0;
   END IF;
   -- Asignamos -1 en caso que la causal de Legalizacion sea NULA
   IF :new.causal_legalizacion IS NULL THEN
      :new.causal_legalizacion := -1;
   END IF;
   -- Validamos que exista causal de registro o tipo de trabajo-causal de legalizacion
   IF ((:new.causal_reg = -1 AND :new.tipo_trabajo = 0 AND :new.causal_legalizacion = -1)
       OR(:new.causal_reg >= 1 AND :new.tipo_trabajo >= 1 AND :new.causal_legalizacion >= 1)
       ) THEN
    INSERT INTO ldc_sui_inconhomo VALUES(
                                          :new.codigo
                                         ,:new.resolucion
                                         ,'Registro invalido, debe traer causal de registro Ã³ (Tipo de trabajo - Causal legalizaciÃ³n))'
                                         ,SYSDATE
                                         ,USER
                                         ,sbequipo
                                          );
     -- Validamos que exista la asociaciÃ³n tipo de trabajo causal de legalizaciÃ³n
   ELSIF ((:new.causal_reg = -1 AND :new.tipo_trabajo >= 1 AND :new.causal_legalizacion = -1)
        OR(:new.causal_reg = -1 AND :new.tipo_trabajo = 0 AND :new.causal_legalizacion >= 1)) THEN
    INSERT INTO ldc_sui_inconhomo VALUES(
                                          :new.codigo
                                         ,:new.resolucion
                                         ,'Registro invalido, No existe causal de registro, debe tener tipo de trabajo y causal de legalizaciÃ³n.)'
                                         ,SYSDATE
                                         ,USER
                                         ,sbequipo
                                          );
   ELSE
    -- Si trae causal de registro obtenemos el grupo de causal y el codigo de la SSPD
     IF :new.causal_reg <> -1 THEN
      BEGIN
       SELECT c.grupo_causal,c.causal_sspd INTO :new.grupo,:new.causal_sspd
         FROM ldc_sui_caus_equ c
        WHERE c.causal_registro = :new.causal_reg
          AND c.TIPO_SOLICITUD  = :new.TIPO_SOLICITUD;
      EXCEPTION
        WHEN no_data_found THEN
         INSERT INTO ldc_sui_inconhomo VALUES(
                                              :new.codigo
                                             ,:new.resolucion
                                             ,'La causal de registro : '||to_char(:new.causal_reg)||' no existe en el comando : LDCCCRCS, validar InformaciÃ³n.'
                                             ,SYSDATE
                                             ,USER
                                             ,sbequipo
                                            );
        WHEN TOO_MANY_ROWS THEN
          ge_boerrors.seterrorcodeargument(2741, 'Error en el registro : '||:new.codigo||'. Error al consultar el grupo y la causal sspd 1: La consulta devuelve mas de un registro');
        WHEN OTHERS THEN
          errors.setError();
          errors.getError(nuError, sbError);
          ge_boerrors.seterrorcodeargument(2741, 'Error en el registro : '||:new.codigo||'. Error al consultar el grupo y la causal sspd 1: '||sbError);
      END;
      -- Validamos que la causal de registro tenga asociado un grupo
      IF :new.grupo = '-1' THEN
       INSERT INTO ldc_sui_inconhomo VALUES(
                                              :new.codigo
                                             ,:new.resolucion
                                             ,'La causal de registro : '||to_char(:new.causal_reg)||' no tiene asociado un grupo de causal en el comando LDCCCRCS, validar InformaciÃ³n.'
                                             ,SYSDATE
                                             ,USER
                                             ,sbequipo
                                            );
      END IF;
      -- Validamos que la causal de registro tenga asociado el codigo causal de la sspd
      IF :new.causal_sspd = -1 THEN
       INSERT INTO ldc_sui_inconhomo VALUES(
                                              :new.codigo
                                             ,:new.resolucion
                                             ,'La causal de registro : '||to_char(:new.causal_reg)||' no tiene asociado codigo causal de la SSPD en el comando LDCCCRCS, validar InformaciÃ³n.'
                                             ,SYSDATE
                                             ,USER
                                             ,sbequipo
                                            );
      END IF;
     ELSE
      BEGIN
       SELECT f.grupo_causal,f.causal_sspd INTO :new.grupo,:new.causal_sspd
         FROM ldc_sui_titrcale f, ldc_sui_respuesta tr
        WHERE f.tipo_trabajo        = :new.tipo_trabajo
          AND f.causal_legalizacion = :new.causal_legalizacion
          AND f.respuesta           = tr.idrespu --506
          and tr.tipo_solicitud = :new.tipo_solicitud --506
          GROUP BY f.grupo_causal,f.causal_sspd;
      EXCEPTION
       WHEN no_data_found THEN
        INSERT INTO ldc_sui_inconhomo VALUES(
                                              :new.codigo
                                             ,:new.resolucion
                                             ,'El tipo de trabajo : '||to_char(:new.tipo_trabajo)||' causal de legalizaciÃ³n : '||to_char(:new.causal_legalizacion)||' no existe en el comando : LDCTTCLRE, validar InformaciÃ³n.'
                                             ,SYSDATE
                                             ,USER
                                             ,sbequipo
                                            );
        WHEN TOO_MANY_ROWS THEN
          ge_boerrors.seterrorcodeargument(2741, 'Error en el registro : '||:new.codigo||'. Error al consultar el grupo y la causal sspd 2: La consulta devuelve mas de un registro');
        WHEN OTHERS THEN
          errors.setError();
          errors.getError(nuError, sbError);
          ge_boerrors.seterrorcodeargument(2741, 'Error en el registro : '||:new.codigo||'. Error al consultar el grupo y la causal sspd 2: '||sbError);
      END;
      -- Validamos que el tipo de trabajo y la causal de legalizaciÃ³n tenga asociado un grupo
      IF :new.grupo = '-1' THEN
       INSERT INTO ldc_sui_inconhomo VALUES(
                                              :new.codigo
                                             ,:new.resolucion
                                             ,'El tipo de trabajo : '||to_char(:new.tipo_trabajo)||' causal de legalizaciÃ³n : '||to_char(:new.causal_legalizacion)||' no tiene grupo de causal asociado en el comando: LDCTTCLRE, validar InformaciÃ³n.'
                                             ,SYSDATE
                                             ,USER
                                             ,sbequipo
                                            );
      END IF;
      -- Validamos que el tipo de trabajo y la causal de legalizaciÃ³n tenga asociado una causal SSPD
      IF :new.causal_sspd = -1 THEN
       INSERT INTO ldc_sui_inconhomo VALUES(
                                              :new.codigo
                                             ,:new.resolucion
                                             ,'El tipo de trabajo : '||to_char(:new.tipo_trabajo)||' causal de legalizaciÃ³n : '||to_char(:new.causal_legalizacion)||' no tiene causal SSPD asociado en el comando : LDCTTCLRE, validar InformaciÃ³n.'
                                             ,SYSDATE
                                             ,USER
                                             ,sbequipo
                                            );
      END IF;
    END IF;
   END IF;
   IF :new.estado_solicitud = 14 THEN
      :new.causal_reg       := -1;
   END IF;
   IF :new.estado_solicitud    != 14 THEN
      :new.tipo_trabajo        := 0;
      :new.causal_legalizacion := -1;
      :new.flag_ate_inme       := 'N';
   END IF;
   nucodtipres := NULL;
   BEGIN
    SELECT sv.tipo_resuesta INTO nucodtipres
      FROM ldc_sui_validaciones sv
     WHERE sv.resolucion        = :new.resolucion
       AND sv.estado_solicitud  = :new.estado_solicitud
       AND sv.aten_inme         = :new.flag_ate_inme
       AND sv.medio_recep       = :new.medio_recepcion
       AND sv.estado_iteraccion = :new.estado_iteraccion
       AND sv.esdocu            = :new.otdocume;
   EXCEPTION
    WHEN no_data_found THEN
      nucodtipres := -1;
    WHEN TOO_MANY_ROWS THEN
      ge_boerrors.seterrorcodeargument(2741, 'Error en el registro : '||:new.codigo||'. Error al consultar el tipo de respuesta 1: La consulta devuelve mas de un registro');
    WHEN OTHERS THEN
      errors.setError();
      errors.getError(nuError, sbError);
      ge_boerrors.seterrorcodeargument(2741, 'Error en el registro : '||:new.codigo||'. Error al consultar el tipo de respuesta 1: '||sbError);
   END;
   IF nucodtipres = -1 THEN
    BEGIN
     SELECT tr.tipo_respuesta INTO nucodtipres
       FROM ldc_sui_titrcale re,ldc_sui_respuesta tr
      WHERE re.tipo_trabajo        = :new.tipo_trabajo
        AND re.causal_legalizacion = :new.causal_legalizacion
        AND re.respuesta           = tr.idrespu
        and tr.tipo_solicitud = :new.tipo_solicitud; --506
    EXCEPTION
      WHEN no_data_found THEN
        nucodtipres := -1;
      WHEN TOO_MANY_ROWS THEN
        ge_boerrors.seterrorcodeargument(2741, 'Error en el registro : '||:new.codigo||'. Error al consultar el tipo de respuesta 2: La consulta devuelve mas de un registro');
      WHEN OTHERS THEN
        errors.setError();
        errors.getError(nuError, sbError);
        ge_boerrors.seterrorcodeargument(2741, 'Error en el registro : '||:new.codigo||'. Error al consultar el tipo de respuesta 2: '||sbError);
    END;
   END IF;
   IF nucodtipres > 0 THEN
    :new.codigo_rpta := nucodtipres;
   ELSE
     nuconta := 0;
   SELECT COUNT(1) INTO nuconta
     FROM ldc_sui_respuesta t
    WHERE t.tipo_respuesta = :new.codigo_rpta
      AND t.tipo_solicitud = :new.tipo_solicitud;
    IF nuconta = 0 THEN
     BEGIN
       SELECT ll.description INTO sbnombpal
         FROM ps_package_type ll
        WHERE ll.package_type_id = :new.tipo_solicitud;
     EXCEPTION
      WHEN no_data_found THEN
       sbnombpal := NULL;
     END;
     BEGIN
      SELECT lg.descripcion INTO sbnombpal2
        FROM ldc_sui_tipres lg
       WHERE lg.codigo = :new.codigo_rpta;
     EXCEPTION
      WHEN no_data_found THEN
       sbnombpal := NULL;
     END;
      INSERT INTO ldc_sui_inconhomo VALUES(
                                              :new.codigo
                                             ,:new.resolucion
                                             ,' No existe la asociaciÃ³n tipo de solicitud : '||to_char(:new.tipo_solicitud)||' - '||sbnombpal||'    tipo de respuesta : '||to_char(:new.codigo_rpta)||' - '||sbnombpal2||' Validar informacion'
                                             ,SYSDATE
                                             ,USER
                                             ,sbequipo
                                            );
    ELSE
     :new.codigo_rpta := :new.codigo_rpta;
    END IF;
   END IF;
  END IF;
EXCEPTION
 WHEN ex.CONTROLLED_ERROR then
   raise;
 WHEN OTHERS THEN
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'Error en el registro : '||:new.codigo||' '||SQLERRM);
  ut_trace.trace('ldc_sui_CONFIREPSUIA '||:new.codigo||' '||SQLERRM, 11);
END;

/