column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;



DECLARE

    nuExistenPlazos         NUMBER;
    nuExisteCertificado  NUMBER;
    blCreacionCertifOK  boolean;
    
    cursor cuPoblacion is
        with tbl_poblacion as (
                                --SELECT  67220290 as contrato, to_date('07/05/1999', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL 
                                --SELECT  67169796 as contrato, to_date('28/11/2000', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL 
                                --SELECT  67172577 as contrato, to_date('26/03/2014', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66541383 as contrato, to_date('27/01/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL 
                                SELECT  66509881 as contrato, to_date('04/02/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66509878 as contrato, to_date('04/02/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL 
                                SELECT  66509877 as contrato, to_date('04/02/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL 
                                SELECT  66509876 as contrato, to_date('04/02/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66509879 as contrato, to_date('04/02/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66509873 as contrato, to_date('04/02/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66509882 as contrato, to_date('04/02/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66509874 as contrato, to_date('04/02/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66556309 as contrato, to_date('22/02/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66558105 as contrato, to_date('28/02/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66531105 as contrato, to_date('02/03/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66531149 as contrato, to_date('02/03/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66558376 as contrato, to_date('04/03/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66558434 as contrato, to_date('06/03/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66560921 as contrato, to_date('10/03/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66563134 as contrato, to_date('18/03/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66557578 as contrato, to_date('07/04/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66569767 as contrato, to_date('08/04/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66561928 as contrato, to_date('21/04/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL 
                                SELECT  66562628 as contrato, to_date('21/04/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66563462 as contrato, to_date('26/04/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66573420 as contrato, to_date('28/04/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66574566 as contrato, to_date('29/04/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66572115 as contrato, to_date('04/05/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66577799 as contrato, to_date('12/05/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66580369 as contrato, to_date('31/05/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66563391 as contrato, to_date('01/06/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66563261 as contrato, to_date('01/06/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66554637 as contrato, to_date('03/06/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66588535 as contrato, to_date('13/06/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66598464 as contrato, to_date('29/07/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66598446 as contrato, to_date('29/07/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66609172 as contrato, to_date('10/08/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66609153 as contrato, to_date('10/08/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66609150 as contrato, to_date('10/08/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66609165 as contrato, to_date('10/08/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66607059 as contrato, to_date('10/08/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66609157 as contrato, to_date('10/08/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66619433 as contrato, to_date('15/09/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66581822 as contrato, to_date('22/09/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66581856 as contrato, to_date('22/09/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66623468 as contrato, to_date('29/09/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66616147 as contrato, to_date('30/09/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66628978 as contrato, to_date('31/10/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66644253 as contrato, to_date('04/12/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66646224 as contrato, to_date('12/12/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66645925 as contrato, to_date('12/12/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66634347 as contrato, to_date('14/12/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66647039 as contrato, to_date('15/12/2017', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66643610 as contrato, to_date('18/01/2018', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66657490 as contrato, to_date('31/01/2018', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL 
                                SELECT  66670339 as contrato, to_date('10/02/2018', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66675428 as contrato, to_date('19/02/2018', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66642503 as contrato, to_date('26/02/2018', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual  UNION ALL
                                SELECT  66680090 as contrato, to_date('27/02/2018', 'dd/mm,yyyy') as fecha_revision,'NO' as tieneCertificado from dual
        )
        select  tbl_poblacion.contrato,
                tbl_poblacion.fecha_revision,
                s.sesunuse as producto,
                tbl_poblacion.tieneCertificado
        from    tbl_poblacion
                inner join open.servsusc s on s.sesususc = tbl_poblacion.contrato
        where   s.sesuserv = 7014;

    CURSOR cuExisteSinFechas(nuProducto open.LDC_PLAZOS_CERT.id_producto%type)
    IS
        SELECT  count(1)
        FROM    open.LDC_PLAZOS_CERT
        WHERE   id_producto = nuProducto
        and     PLAZO_MIN_REVISION is not null
        and     PLAZO_MIN_SUSPENSION is not null
        and     PLAZO_MAXIMO is not null; 
BEGIN
    dbms_output.put_line('---- Inicia OSF-915-1 ----');
    FOR reg_poblacion IN cuPoblacion
    LOOP
        -- reset de variable
        nuExistenPlazos     := 0;
            
        OPEN cuExisteSinFechas(reg_poblacion.producto);
        FETCH cuExisteSinFechas INTO nuExistenPlazos;
        CLOSE cuExisteSinFechas;
        
        -- valida NO tiene un registro en plazos con fechas
        IF (nuExistenPlazos < 1 ) THEN
                -- llama al proceso para que las cree o actualice
                BEGIN
                    LDC_CERTIFICATE_RP(inuProduct_id => reg_poblacion.producto, inuContrato_id => reg_poblacion.contrato, idtFechaRevision => reg_poblacion.fecha_revision );
                    COMMIT;
                    DBMS_OUTPUT.PUT_LINE('OK - [LDC_PLAZOS_CERT] - '
                                        ||' Contrato ['||reg_poblacion.contrato||']'
                                        ||' Producto ['||reg_poblacion.producto||']'
                                        ||' Fecha Revision ['||reg_poblacion.fecha_revision||']');
                EXCEPTION
                    WHEN OTHERS THEN
                    rollback;
                    DBMS_OUTPUT.PUT_LINE('ERROR [LDC_PLAZOS_CERT] -  Contrato ['||reg_poblacion.contrato||'] Producto ['||reg_poblacion.producto||'] Fecha Revision ['||reg_poblacion.fecha_revision||'] Error --> '||sqlerrm);
                END;                
        END IF;-- IF (nuExistenPlazos < 1 ) THEN

    END LOOP;

  dbms_output.put_line('---- Fin OSF-915-1 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-915-1 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/