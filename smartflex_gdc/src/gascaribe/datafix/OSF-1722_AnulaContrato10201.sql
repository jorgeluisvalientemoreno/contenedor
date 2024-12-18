column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  declare 
    --
    Cursor Cuge_contrato IS
      select c.id_contrato, status
        from open.ge_contrato c
      where c.id_contrato = 10201; -- Nro de Contrato
    -- Local variables here
    nuErrorCode  NUMBER;
    sberror      VARCHAR2(1000);
    vnunrocont   ge_contrato.id_contrato%type;
    sbStatus     ge_contrato.status%TYPE;
    SBSTATUSREGISTER          GE_CONTRATO.STATUS%TYPE;
    NUCOMMENTTYPE GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE;
    SBCOMMENT              GE_ACTA.COMMENT_%TYPE;
    --
  begin
  

    -- Test statements here
    open Cuge_contrato;
    fetch Cuge_contrato into vnunrocont,sbStatus;
    close Cuge_contrato;
    SBSTATUSREGISTER := CT_BOCONSTANTS.FSBGETREGISTERSTATUS;
    NUCOMMENTTYPE := 1297; -- Tipo de comentario Genera
    SBCOMMENT := 'Se anula contrato por error en la fecha, reemplaza el 10241';
    IF sbStatus =  SBSTATUSREGISTER then

        CT_BOCONTRACT.CHANGESTATUSCONTRACT(vnunrocont,NUCOMMENTTYPE, SBCOMMENT, CT_BOCONSTANTS.FSBGETCANCELSTATUS);
        dbms_output.put_Line('El contrato '||vnunrocont||' se cancela');
    ELSE
        dbms_output.put_Line('El contrato '||vnunrocont||' no se encuentra en estado registrado');
    END IF;
    
    commit;
    
  EXCEPTION  
    WHEN EX.CONTROLLED_ERROR THEN
        ERRORS.GETERROR(nuErrorCode,sberror);
              DBMS_OUTPUT.put_line(sberror);
        ROLLBACK;
    WHEN OTHERS THEN
            Errors.setError;
          ERRORS.GETERROR(nuErrorCode,sberror); 
          DBMS_OUTPUT.put_line(sberror);
          ROLLBACK;
  END;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/