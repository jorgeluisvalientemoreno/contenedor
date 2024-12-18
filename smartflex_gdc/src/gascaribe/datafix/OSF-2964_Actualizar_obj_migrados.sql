set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Julio 2024 
    JIRA:           OSF-2964   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
            'ESCRIBIR',
            'GDC_PRTSDWFINSTATTRIB03092021',
            'GDC_PRTSDWFINSTATTRIB0609211',
            'GDC_PRTSDWFINSTATTRIB0609212',
            'GDC_PRTSDWFINSTATTRIB0609213',
            'GDC_PRTSDWFINSTATTRIB0609214',
            'GDC_PRTSDWFINSTATTRIB0609215',
            'GDC_PRTSDWFINSTATTRIB0609216',
            'GDC_PRTSDWFINSTATTRIB1210211',
            'GDC_PRTSDWFINSTATTRIB1210212',
            'GDC_PRTSDWFINSTATTRIB1210213',
            'GDC_PRTSDWFINSTATTRIB1210214',
            'GDC_PRTSDWFINSTATTRIB1210215',
            'GDC_PRTSDWFINSTATTRIB1210216',
            'GDC_PRTSDWFINSTATTRIB2210211',
            'GDC_PRTSDWFINSTATTRIB2310211',
            'GDC_PRTSDWFINSTATTRIB28072021',
            'GDC_PRTSDWFINSTATTRIB280720212',
            'GDC_PRTSDWFINSTATTRIB31082021',
            'GDC_PRWFINSTANCEATTRIB1932021',
            'GDC_PRWFINSTATTRIB',
            'GDC_PRWFINSTATTRIBCONTEO',
            'GDC_PRWFINSTATTRIBPNO',
            'GDC_PRWFINSTATTRIBSN',
            'GEGE_EXERULVAL_CT69E121393087',
            'GEGE_EXERULVAL_CT69E121393089',
            'GEGE_EXERULVAL_CT69E121393091',
            'LDC_2021101623',
            'LDC_2021101623B',
            'LDC_DBA_PRC_TRUNCATE',
            'LDCBI_PRUEBA',
            'LDCBI_PRUEBAENDPOINT',
            'LDCBI_TRUNCATETABLE',
            'MO_INITATRIB_CT23E121393074',
            'MO_INITATRIB_CT23E121393075',
            'MO_INITATRIB_CT23E121393076',
            'MO_INITATRIB_CT23E121393077',
            'MO_INITATRIB_CT23E121393080',
            'MO_INITATRIB_CT23E121393081',
            'MO_INITATRIB_CT23E121393082',
            'MO_INITATRIB_CT23E121393083',
            'MO_INITATRIB_CT23E121393084',
            'MO_INITATRIB_CT23E121393085',
            'MO_INITATRIB_CT23E121393086',
            'MO_VALIDATTR_CT26E121393078',
            'MO_VALIDATTR_CT26E121393079',
            'PRDATAFIXTARITRAN',
            -- 23/07/2024 añadidos a la entrega
            'JOB_PRTSDWFINSTATTRIB03092021',
            'JOB_PRTSDWFINSTATTRIB0609211',
            'JOB_PRTSDWFINSTATTRIB0609212',
            'JOB_PRTSDWFINSTATTRIB0609213',
            'JOB_PRTSDWFINSTATTRIB0609214',
            'JOB_PRTSDWFINSTATTRIB0609215',
            'JOB_PRTSDWFINSTATTRIB0609216',
            'JOB_PRTSDWFINSTATTRIB1210211',
            'JOB_PRTSDWFINSTATTRIB1210212',
            'JOB_PRTSDWFINSTATTRIB1210213',
            'JOB_PRTSDWFINSTATTRIB1210214',
            'JOB_PRTSDWFINSTATTRIB1210215',
            'JOB_PRTSDWFINSTATTRIB1210216',
            'JOB_PRTSDWFINSTATTRIB2210211',
            'JOB_PRTSDWFINSTATTRIB2310211',
            'JOB_PRTSDWFINSTATTRIB28072021',
            'JOB_PRTSDWFINSTATTRIB280720212',
            'JOB_PRTSDWFINSTATTRIB31082021',
            'LDC_PRWFINSTANCEATTRIB1932021',
            'JOB_PRWFINSTATTRIBCONTEO',
            'JOB_PRWFINSTATTRIBPNO',
            'JOB_PRWFINSTATTRIBSN'
            );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;  
        
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en master_personalizaciones, '||sqlerrm);
END;
/
  
PROMPT **** Termina actualizar registro entidad master_personalizaciones**** 
PROMPT =========================================

set timing off
set serveroutput off
/