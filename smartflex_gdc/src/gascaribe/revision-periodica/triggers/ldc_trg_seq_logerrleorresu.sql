CREATE OR REPLACE TRIGGER personalizaciones.LDC_TRG_SEQ_LOGERRLEORRESU
    /************************************************************************************************************
      Autor       :  Horbath
      Fecha       : 2020-OCT-25
      Proceso     : ldc_trg_seq_logerrleorresa
      Ticket      : 516
      Descripcion : Trigger para obtener el valor del campo id

      Parametros Entrada
       nmpaorder_id  Orden
       sbpaproc      Proceso

      Valor de salida
       Retorna el rowid de la tabla

      Historia de Modificaciones
      Fecha             Autor           Modificacion
      =========         =========       ====================
      09/02/2023        jpinedc         OSF-858: Se cambia de open a personalizaciones
     *************************************************************************************************************/
    BEFORE INSERT
    ON personalizaciones.LDC_LOGERRLEORRESU
    REFERENCING NEW AS New OLD AS Old
    FOR EACH ROW
DECLARE
    nmid   NUMBER;
BEGIN
    SELECT personalizaciones.seq_LDC_LOGERRLEORRESU.NEXTVAL
      INTO nmid
      FROM DUAL;

    :NEW.ID := nmid;
EXCEPTION
    WHEN OTHERS
    THEN
        RAISE;
END;
/

DECLARE

    sbUsuarioOrigen     VARCHAR2(30) := 'OPEN';
    sbUsuarioDestino    VARCHAR2(30) := 'PERSONALIZACIONES';
    sbTrigger           VARCHAR2(30) := 'LDC_TRG_SEQ_LOGERRLEORRESU';

    sbSentencia         VARCHAR2(32000);
    
    CURSOR cuTrigger( isbUsuario VARCHAR2, isbTrigger VARCHAR2)
    IS
    SELECT trigger_name
    FROM all_triggers
    WHERE owner = isbUsuario
    AND trigger_name = isbTrigger;
    
    rcTriggerOrigen cuTrigger%ROWTYPE;

    rcTriggerDestino cuTrigger%ROWTYPE;
        
    PROCEDURE pExecImmediate( isbSentencia VARCHAR2)
    IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSentencia;
    
        EXCEPTION WHEN OTHERS THEN
            dbms_output.put_line( 'Error pExecImmediate[' || isbSentencia || '][' || SQLERRM || ']');
            RAISE;
    END pExecImmediate;    

BEGIN

    OPEN cuTrigger( sbUsuarioOrigen, sbTrigger );
    FETCH cuTrigger INTO rcTriggerOrigen;
    CLOSE cuTrigger;    

    OPEN cuTrigger( sbUsuarioDestino, sbTrigger );
    FETCH cuTrigger INTO rcTriggerDestino;
    CLOSE cuTrigger;    
    
    IF rcTriggerDestino.trigger_name IS NOT NULL THEN
    
        IF rcTriggerOrigen.trigger_name IS NOT NULL THEN
        
            sbSentencia := 'DROP TRIGGER ' || sbUsuarioOrigen || '.' || sbTrigger;

            pExecImmediate(sbSentencia);
            
            dbms_output.put_line('Se hizo drop al trigger  ' || sbUsuarioOrigen || '.' || sbTrigger );        

        ELSE

            dbms_output.put_line('NO Se hizo drop al trigger  ' || sbUsuarioOrigen || '.' || sbTrigger || ' porque no existe' );            
            
        END IF;
    
    ELSE

        dbms_output.put_line('NO Se hizo drop al trigger  ' || sbUsuarioOrigen || '.' || sbTrigger || ' porque no existe el trigger destino' );            

    END IF;
    
END;
/
