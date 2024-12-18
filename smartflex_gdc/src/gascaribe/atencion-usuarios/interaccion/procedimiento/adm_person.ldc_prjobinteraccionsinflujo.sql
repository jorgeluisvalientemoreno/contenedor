CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRJOBINTERACCIONSINFLUJO IS

  /*****************************************************************
  Unidad         : LDC_prJobInteraccionSinFlujo
  Descripcion    : Servicio para esabelcer si todas las solicitudes asociadas a la interacion fueron atendidas
                   para marcar la interaccion y no volver a ser utilizado por el JOB
  CASO           : 679
  Autor          : Jorge Valiente
  Fecha          : 9/11/2022
  
  Consideraciones de Uso
  ============================================================================
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========   ==================      ====================
  
  ******************************************************************/

  sbdatain varchar2(4000);

  --Cursor para obtener las interaccion que al menos una solicitud asociada que
  --este atendida con el flag parcial en S y que el flag total este en N
  cursor culdc_interaccion_sin_flujo is
    select *
      from open.ldc_interaccion_sin_flujo
     where ldc_interaccion_sin_flujo.parcial = 'S'
       and ldc_interaccion_sin_flujo.procesado = 'N';

  rfculdc_interaccion_sin_flujo culdc_interaccion_sin_flujo%rowtype;

  nuPackageId NUMBER;
  DtNotiDate  DATE;
  nuTipoFecha NUMBER;

  nuparano  NUMBER(4);
  nuparmes  NUMBER(2);
  nutsess   NUMBER;
  sbparuser VARCHAR2(30);

BEGIN

  SELECT to_number(to_char(SYSDATE, 'YYYY')),
         to_number(to_char(SYSDATE, 'MM')),
         userenv('SESSIONID'),
         USER
    INTO nuparano, nuparmes, nutsess, sbparuser
    FROM dual;

  ldc_proinsertaestaprog(nuparano,
                         nuparmes,
                         'LDC_prJobInteraccionSinFlujo',
                         'En ejecucion',
                         nutsess,
                         sbparuser);

  for rfculdc_interaccion_sin_flujo in culdc_interaccion_sin_flujo loop
    --Servicio de OPEN para estabelcer si todas o o algunas de las solicitudes
    --asociadas a la interaccion se encuentran en estado registrada retoran (TRUE) - Todas Atendidas(FALSE)
    if open.MO_BOPACKAGES_ASSO.FBOHASACTIVEASSOPACKS(rfculdc_interaccion_sin_flujo.package_id) = FALSE then
    
      begin
      
        --Atiende la solicitud y motivo de la interaccion
        nuPackageId := rfculdc_interaccion_sin_flujo.package_id;
        DtNotiDate  := open.LDC_FDTGETNOFICATIONDATE(nuPackageId);
        nuTipoFecha := open.GE_BOPARAMETER.FNUVALORNUMERICO('RECE_CONF_DATE_TYPE');
        cc_bopackaddidate.RegisterPackageDate(nuPackageId,
                                              nuTipoFecha,
                                              DtNotiDate);
      
        "OPEN".MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU(nuPackageId, 58);
      
        --actualizar entidad para establecer que todas las solciitudes asociadas a la
        --interaccion ya no estan registradas
        update open.ldc_interaccion_sin_flujo
           set ldc_interaccion_sin_flujo.procesado = 'S',
               ldc_interaccion_sin_flujo.mensaje   = null
         where ldc_interaccion_sin_flujo.package_id = nuPackageId;
        commit;
      
      exception
        when others then
        
          ---Mensaje de error
          sbdatain := 'INCONSISTENCIA ERROR [' || SQLCODE || '] - [' ||
                      SQLERRM || '] - Error Traza [' ||
                      dbms_utility.format_error_stack || ' - ' ||
                      dbms_utility.format_error_backtrace || ']';
        
          rollback;
          update open.ldc_interaccion_sin_flujo
             set ldc_interaccion_sin_flujo.mensaje = sbdatain
           where ldc_interaccion_sin_flujo.package_id = nuPackageId;
          commit;
        
      end;
    
    end if;
  
  end loop;

  ldc_proactualizaestaprog(nutsess,
                           'Proceso termino Ok',
                           'LDC_prJobInteraccionSinFlujo',
                           'Ok');

EXCEPTION
  when others then
    ---Mensaje de error
    sbdatain := 'ERROR [' || SQLCODE || '] - [' || SQLERRM ||
                '] - Error Traza [' || dbms_utility.format_error_stack ||
                ' - ' || dbms_utility.format_error_backtrace || ']';
    ldc_proactualizaestaprog(nutsess,
                             sbdatain,
                             'LDC_prJobInteraccionSinFlujo',
                             'Termino con error.');
    raise;
  
END LDC_prJobInteraccionSinFlujo;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRJOBINTERACCIONSINFLUJO', 'ADM_PERSON');
END;
/
