CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_GENOTINTERACCIONJOB IS

  /*******************************************************************************
   Metodo:       LDC_GENOTINTERACCIONJOB
   Descripcion:  Procedimiento para generar orden ESCRITO o VERBAL de la solicitude
                 creada con orden sin legalizar

   Autor:        GDC
   Fecha:        24/07/2020

   Historia de Modificaciones
   FECHA        AUTOR              DESCRIPCION
   06/06/2022   Jorge Valiente     * Cambio de c�digo de versi�n del 0000377 a la nueva versi�n OSF-327

  *******************************************************************************/

  onuCodFluNot NUMBER;

  nuOrderId number;

  RegCategoria LDC_CONFLUNOTATEACL.CATECODI%type;
  RegContrato  mo_motive.subscription_id%type;
  TempFlujo    NUMBER; --LDC_CONFLUNOTATEACL.flujo_notific%type;

  ingresoTupla boolean;
  nuError      number;
  sbError      VARCHAR2(4000);
  nuCaso       varchar2(30) := 'OSF-327';--'0000703';--
  nuparano     NUMBER;
  nuparmes     NUMBER;
  nutsess      NUMBER;
  sbparuser    VARCHAR2(4000);

  cursor cu_orden is
    select o.order_id
      from LDC_CONFLUNOTATEACL lc,
           or_order            o,
           or_order_activity   a,
           mo_packages         mp
     where o.order_id = a.order_id
       and a.package_id = mp.package_id
       and lc.task_type_id = o.task_type_id
       and lc.package_type_id = mp.package_type_id
       and o.order_status_id in (0, 5)
       and lc.flagjob='Y'
       and trunc(o.created_date) = trunc(sysdate)
     group by o.order_id; ---trunc(sysdate - 560); --

  rfcu_orden cu_orden%rowtype;

BEGIN

  --ut_trace.trace('INICIO LDC_GENOTINTERACCIONJOB', 10);
  dbms_output.put_line('INICIO LDC_GENOTINTERACCIONJOB');

  IF fblAplicaEntregaxCaso(nuCaso) THEN
    -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,
                           nuparmes,
                           'LDC_GENOTINTERACCIONJOB',
                           'En ejecucion',
                           nutsess,
                           sbparuser);

    for rfcu_orden in cu_orden loop

      nuOrderId := rfcu_orden.order_id; --30178971;

      dbms_output.put_line('ORDEN[' || nuOrderId || ']');

      LDC_PKFLUNOTATECLI.PRGENOTINTERACCION(nuOrderId);

      commit;

    end loop;

    ut_trace.trace('Finaliza LDC_GENOTINTERACCIONJOB', 10);
    Ldc_proactualizaestaprog(nutsess,
                             sbError,
                             'LDC_GENOTINTERACCIONJOB',
                             'Ok');

    --ut_trace.trace('FIN LDC_GENOTINTERACCIONJOB', 10);
    dbms_output.put_line('FIN LDC_GENOTINTERACCIONJOB');

  END IF;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    Errors.GETERROR(nuError, sbError);
    Ldc_proactualizaestaprog(nutsess,
                             sbError,
                             'LDC_GENOTINTERACCIONJOB',
                             'ERROR');
    raise;

  when OTHERS then
    Errors.setError;
    Errors.GETERROR(NUERROR, sbError);
    Ldc_proactualizaestaprog(nutsess,
                             sbError,
                             'LDC_GENOTINTERACCIONJOB',
                             'ERROR');
    raise ex.CONTROLLED_ERROR;

END LDC_GENOTINTERACCIONJOB;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_GENOTINTERACCIONJOB', 'ADM_PERSON');
END;
/

