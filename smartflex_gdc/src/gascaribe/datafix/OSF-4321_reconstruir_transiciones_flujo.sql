column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  nuSolicitudBase wf_data_external.package_id%TYPE := 27082084;
  nuSolicitud     wf_data_external.package_id%TYPE := 29295814;

  CURSOR cuSolicitudBase(inuSolcitud IN wf_data_external.package_id%TYPE) IS
    WITH instancias AS
     (select i.*
        from wf_instance i, wf_data_external de
       where i.plan_id = de.plan_id
         and de.package_id = inuSolcitud)
    SELECT distinct it.origin_id,
                    it.target_id,
                    it.geometry,
                    it.group_id,
                    it.expression,
                    it.expression_type,
                    it.description,
                    it.transition_type_id,
                    it.original,
                    it.status
      FROM wf_instance_trans it, instancias ins
     WHERE it.TARGET_ID = ins.instance_id
        OR it.origin_id = ins.instance_id;

  CURSOR cuInstanciaBase(inuSolcitud IN wf_data_external.package_id%TYPE,
                         inuIntancia IN wf_instance.instance_id%TYPE) IS
    SELECT i.*
      FROM wf_instance i, wf_data_external de
     WHERE i.plan_id = de.plan_id
       AND de.package_id = inuSolcitud
       AND i.instance_id = inuIntancia;

  rcInstanciaBase     cuInstanciaBase%ROWTYPE;
  rcInstanciaBaseNulo cuInstanciaBase%ROWTYPE;

  rcInstanciaDestino     cuInstanciaBase%ROWTYPE;
  rcInstanciaDestinoNulo cuInstanciaBase%ROWTYPE;

  CURSOR cuInstanciaClonar(inuSolcitud IN wf_data_external.package_id%TYPE,
                           inuUnidad   IN wf_instance.unit_id%TYPE) IS
    select i.*
      from wf_instance i, wf_data_external de
     where i.plan_id = de.plan_id
       and de.package_id = inuSolcitud
       and i.unit_id = inuUnidad;

  rcInstanciaOrigin     cuInstanciaClonar%ROWTYPE;
  rcInstanciaOriginNulo cuInstanciaClonar%ROWTYPE;

  rcInstanciaTarget     cuInstanciaClonar%ROWTYPE;
  rcInstanciaTargetNulo cuInstanciaClonar%ROWTYPE;

  nuCodigoInstancia NUMBER := SEQ_WF_INSTANCE_TRANS.nextval;

BEGIN

  FOR rcTrasicionBase IN cuSolicitudBase(nuSolicitudBase) LOOP
    dbms_output.put_line('Instancia [' || nuCodigoInstancia ||
                         '] - Origen [' || rcTrasicionBase.origin_id ||
                         '] - Destino [' || rcTrasicionBase.target_id || ']');
  
    rcInstanciaBase    := rcInstanciaBaseNulo;
    rcInstanciaDestino := rcInstanciaDestinoNulo;
  
    rcInstanciaOrigin := rcInstanciaOriginNulo;
    rcInstanciaTarget := rcInstanciaTargetNulo;
  
    IF (cuInstanciaBase%ISOPEN) THEN
      CLOSE cuInstanciaBase;
    END IF;
  
    OPEN cuInstanciaBase(nuSolicitudBase, rcTrasicionBase.origin_id);
    FETCH cuInstanciaBase
      INTO rcInstanciaBase;
    CLOSE cuInstanciaBase;
  
    OPEN cuInstanciaBase(nuSolicitudBase, rcTrasicionBase.target_id);
    FETCH cuInstanciaBase
      INTO rcInstanciaDestino;
    CLOSE cuInstanciaBase;
  
    IF (cuInstanciaClonar%ISOPEN) THEN
      CLOSE cuInstanciaClonar;
    END IF;
  
    OPEN cuInstanciaClonar(nuSolicitud, rcInstanciaBase.unit_id);
    FETCH cuInstanciaClonar
      INTO rcInstanciaOrigin;
    CLOSE cuInstanciaClonar;
  
    OPEN cuInstanciaClonar(nuSolicitud, rcInstanciaDestino.unit_id);
    FETCH cuInstanciaClonar
      INTO rcInstanciaTarget;
    CLOSE cuInstanciaClonar;
  
    Insert into OPEN.WF_INSTANCE_TRANS
      (INST_TRAN_ID,
       ORIGIN_ID,
       TARGET_ID,
       GEOMETRY,
       GROUP_ID,
       EXPRESSION,
       EXPRESSION_TYPE,
       DESCRIPTION,
       TRANSITION_TYPE_ID,
       ORIGINAL,
       STATUS)
    Values
      (nuCodigoInstancia,
       rcInstanciaOrigin.instance_id,
       rcInstanciaTarget.instance_id,
       rcTrasicionBase.GEOMETRY,
       rcTrasicionBase.GROUP_ID,
       rcTrasicionBase.EXPRESSION,
       rcTrasicionBase.EXPRESSION_TYPE,
       rcTrasicionBase.DESCRIPTION,
       rcTrasicionBase.TRANSITION_TYPE_ID,
       rcTrasicionBase.ORIGINAL,
       rcTrasicionBase.STATUS);
  
    nuCodigoInstancia := nuCodigoInstancia + 1;
  
  END LOOP;

  COMMIT;

  dbms_output.put_line('Recuperar Instancia 228906696 detenida y continuar con el flujo');
  WF_BOEIFINSTANCE.RecoverInstance(228906696);

EXCEPTION
  WHEN OTHERS THEN
    rollback;
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> ' || sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/
