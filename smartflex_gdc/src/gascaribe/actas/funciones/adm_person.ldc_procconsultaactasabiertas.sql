CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_PROCCONSULTAACTASABIERTAS" RETURN constants.tyRefCursor IS
  sbProcessInstance          ge_boinstancecontrol.stysbname;
  nuIndex                    ge_boInstanceControl.stynuIndex;
  rcResult                   constants.tyrefcursor;
  sbtipocontrato             VARCHAR2(1000);
  nutipocontrato             ge_contrato.id_tipo_contrato%TYPE;
  sbcontratista              VARCHAR2(1000);
  nucontratista              ge_contrato.id_contratista%TYPE;
  sbtipoacta                 VARCHAR2(1000);
  nuidtipoacta               ge_acta.id_tipo_acta%TYPE;
  /*****************************************************************
    Propiedad intelectual de JM GESTIONINFORMATICA S.A (c).

    Unidad         : ldc_procconsultaactasabiertas
    Descripcion    : Retorna actas abiertas para un tipo de contrato y contratista
                    comando : LDCCIMAAC
    Autor          : John Jairo Jimenez Marimón
    Fecha          :18/07/2016

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    28/07/2016      JJJM                 Se agrega el parametro tipo de acta
  ******************************************************************/
BEGIN
  ge_boinstancecontrol.GetCurrentInstance(sbProcessInstance);
  -- se obtiene el valor de la instancia si existe
  IF ge_boinstancecontrol.fblAcckeyAttributeStack(sbProcessInstance,
                                                  Null,
                                                  'GE_TIPO_CONTRATO',
                                                  'ID_TIPO_CONTRATO',
                                                  nuIndex) THEN
    GE_BOInstanceControl.GetAttributeNewValue(sbProcessInstance,
                                              null,
                                              'GE_TIPO_CONTRATO',
                                              'ID_TIPO_CONTRATO',
                                              sbtipocontrato);
   GE_BOInstanceControl.GetAttributeNewValue(sbProcessInstance,
                                              null,
                                              'GE_CONTRATISTA',
                                              'ID_CONTRATISTA',
                                              sbcontratista);
  GE_BOInstanceControl.GetAttributeNewValue(sbProcessInstance,
                                              null,
                                              'GE_ACTA',
                                              'ID_TIPO_ACTA',
                                              sbtipoacta);

    -- Se obtiene el valor del tipo de contrato y contratista
    nutipocontrato := to_number(TRIM(sbtipocontrato));
    nucontratista  := to_number(TRIM(sbcontratista));
    nuidtipoacta   := to_number(TRIM(sbtipoacta));
  END IF;
  OPEN rcResult FOR
    SELECT ac.id_acta nro_acta
      ,ac.nombre descripcion
      ,to_char(ac.valor_total,'999,999,999,999,999.99') valor_total_acta
      ,ac.fecha_creacion
      ,ac.fecha_inicio
      ,ac.fecha_fin
      ,ac.id_tipo_acta||' - '||decode(ac.id_tipo_acta,1,'Liquidación de Trabajos',2,'Facturación de contratista',3,'Acta de Suspensión',4,'Acta de Reactivación',5,'Acta de Apertura',6,'Acta de Modificación',7,'Acta de Anulación',8,'Acta de Inactivación') tipo_acta
      ,co.id_tipo_contrato tipo_contrato
      ,(SELECT tc.descripcion FROM ge_tipo_contrato tc WHERE tc.id_tipo_contrato = co.id_tipo_contrato) Descripcion_tipo_contrato
      ,co.id_contratista contratista
      ,(SELECT gc.nombre_contratista FROM ge_contratista gc WHERE gc.id_contratista = co.id_contratista) nombre_contratista
  FROM ge_acta ac,ge_contrato co
 WHERE ac.estado IN('a','A')
   AND ac.id_tipo_acta     = decode(nuidtipoacta,-1,ac.id_tipo_acta,nuidtipoacta)
   AND co.id_tipo_contrato = decode(nutipocontrato,-1,co.id_tipo_contrato,nutipocontrato)
   AND co.id_contratista   = decode(nucontratista,-1,co.id_contratista,nucontratista)
   AND ac.id_contrato      = co.id_contrato
 ORDER BY 1;
  RETURN rcResult;
EXCEPTION
  WHEN ex.controlled_error THEN
    RAISE ex.controlled_error;
  WHEN OTHERS THEN
    errors.seterror;
    RAISE ex.controlled_error;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROCCONSULTAACTASABIERTAS', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_PROCCONSULTAACTASABIERTAS TO REPORTES;
/
