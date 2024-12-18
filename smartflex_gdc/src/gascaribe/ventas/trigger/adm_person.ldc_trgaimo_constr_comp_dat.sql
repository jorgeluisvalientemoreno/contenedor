CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGAIMO_CONSTR_COMP_DAT
  AFTER INSERT OR UPDATE ON MO_CONSTR_COMPANY_DAT
   REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
    /*****************************************************************
    Propiedad intelectual de Gascaribe

    Unidad         : LDC_TRGAIMO_CONSTR_COMP_DAT
    Descripcion    : Trigger para registrar el programa de vivienda para los
                     contratos hijos de la venta constructora. (GDC)
    Autor          : KCienfuegos
    Fecha          : 02-06-2017

    Historia de Modificaciones
    Fecha           Autor                        Modificacion
    =========      =========                    ====================
    06-07-2017     KCienfuegos.CA200-1372       Se condiciona para que valide si los contratos
                                                son nulos.
    02-06-2017     KCienfuegos.CA200-473        Creacion.
  ******************************************************************/
DECLARE

  PRAGMA                     AUTONOMOUS_TRANSACTION;
  nuProyecto                 ldc_proyecto_constructora.id_proyecto%TYPE;
  nuPrograma                 ldc_proyecto_constructora.tipo_vivienda%TYPE;
  nuContratoPrinc            suscripc.susccodi%TYPE;
  nuSolicitud                mo_packages.package_id%TYPE;
  rcTipoVivienda             daldc_tipo_vivienda_cont.styLDC_TIPO_VIVIENDA_CONT;

  CURSOR cuObtieneProyecto IS
    SELECT id_proyecto
      FROM ldc_proyecto_constructora
     WHERE id_solicitud = nuSolicitud;

  CURSOR cuObtieneContratos IS
    SELECT Datos.contrato contrato
      FROM XMLTable('/DocumentElement/RECORDS' Passing XMLType(:new.additional_data) Columns
           contrato Number Path 'Subscrip') As Datos;

  CURSOR cuObtContratoPrinc IS
    SELECT m.Subscription_Id
      FROM mo_motive m
     WHERE m.package_id = nuSolicitud
       AND product_type_id = 6121
       AND m.subscription_id IS NOT NULL;

BEGIN

  ut_trace.trace('Inicia LDC_TRGAIMO_CONSTR_COMP_DAT',10);

  nuSolicitud := :new.Package_Id;

  IF(fblaplicaentrega('FNB_BRI_KCM_200473_5'))THEN

    OPEN cuObtieneProyecto;
    FETCH cuObtieneProyecto INTO nuProyecto;
    CLOSE cuObtieneProyecto;

    IF(nuProyecto IS NULL)THEN

       ut_trace.trace('se busca contrato padre',10);

       OPEN  cuObtContratoPrinc;
       FETCH cuObtContratoPrinc INTO nuContratoPrinc;
       CLOSE cuObtContratoPrinc;

       IF(nuContratoPrinc IS NOT NULL)THEN
         IF(daldc_tipo_vivienda_cont.fblExist(nuContratoPrinc))THEN
            nuPrograma := daldc_tipo_vivienda_cont.fnuGetTIPO_VIVIENDA(nuContratoPrinc);

            IF(nuPrograma IS NOT NULL)THEN

              FOR i IN cuObtieneContratos LOOP
               IF(i.contrato IS NOT NULL)THEN
                 IF(daldc_tipo_vivienda_cont.fblExist(i.contrato))THEN
                    IF(daldc_tipo_vivienda_cont.fnuGetTIPO_VIVIENDA(i.contrato)<>nuPrograma)THEN
                       ut_trace.trace('actualiza tipo de vivienda: '||i.contrato,10);
                       daldc_tipo_vivienda_cont.updTIPO_VIVIENDA(i.contrato, nuPrograma);
                    END IF;
                 ELSE
                    ut_trace.trace('registra contrato: '||i.contrato,10);
                    rcTipoVivienda.contrato           := i.contrato;
                    rcTipoVivienda.tipo_vivienda      := nuPrograma;
                    rcTipoVivienda.fecha_registro     := SYSDATE;
                    rcTipoVivienda.solicitud          := :new.PACKAGE_ID;

                    daldc_tipo_vivienda_cont.insRecord(rcTipoVivienda);
                 END IF;
               END IF;
              END LOOP;

            END IF;
         END IF;
       END IF;

    ELSE
       ut_trace.trace('se busca programa del proyecto',10);
       nuPrograma := daldc_proyecto_constructora.fnuGetTIPO_VIVIENDA(nuProyecto);

       IF(nuPrograma IS NOT NULL)THEN

         FOR i IN cuObtieneContratos LOOP
           IF(i.contrato IS NOT NULL)THEN
             ut_trace.trace('contrato '||i.contrato,10);
             IF(daldc_tipo_vivienda_cont.fblExist(i.contrato))THEN
                IF(daldc_tipo_vivienda_cont.fnuGetTIPO_VIVIENDA(i.contrato)<>nuPrograma)THEN
                   ut_trace.trace('actualiza tipo de vivienda: '||i.contrato,10);
                   daldc_tipo_vivienda_cont.updTIPO_VIVIENDA(i.contrato, nuPrograma);
                END IF;
             ELSE
                 ut_trace.trace('registra contrato: '||i.contrato,10);
                 rcTipoVivienda.contrato           := i.contrato;
                 rcTipoVivienda.tipo_vivienda      := nuPrograma;
                 rcTipoVivienda.fecha_registro     := SYSDATE;
                 rcTipoVivienda.solicitud          := :new.PACKAGE_ID;

                 daldc_tipo_vivienda_cont.insRecord(rcTipoVivienda);
             END IF;
           END IF;
         END LOOP;

       END IF;
    END IF;

    COMMIT;

  END IF;

  ut_trace.trace('Finaliza LDC_TRGAIMO_CONSTR_COMP_DAT',10);

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END LDC_TRGAIMO_CONSTR_COMP_DAT;
/
