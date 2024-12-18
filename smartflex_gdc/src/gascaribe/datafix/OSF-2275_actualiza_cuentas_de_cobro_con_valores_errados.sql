column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare

      NUCUENTA CUENCOBR.CUCOCODI%TYPE;     
      
      CURSOR CUCUENTAS
      IS
          SELECT  *
          FROM    (
                  SELECT  CARGCUCO,
                          CUCOVATO,
                          CUCOVAAB,
                          NVL(CUCOSACU,0) CUCOSACU,
                          NVL(SUM(DECODE( CARGSIGN,
                                      'DB',CARGVALO,
                                      'CR',-CARGVALO
                                    )),0) VATO,
                          NVL(SUM(DECODE(CARGSIGN,
                                      'PA',CARGVALO,
                                      'AS',CARGVALO,
                                      'NS',CARGVALO,
                                      'SA',-CARGVALO,
                                      'AP',-CARGVALO
                                    )),0) VAAB
                  FROM    CARGOS, CUENCOBR, FACTURA
                  WHERE   CARGCUCO = CUCOCODI
                          AND FACTCODI = CUCOFACT
                          AND CUCOCODI in (3042333372,3041970118)
                  GROUP BY CARGCUCO, CUCOVATO, CUCOVAAB, CUCOSACU
                  )
          WHERE  CUCOVATO <> VATO  OR  CUCOVAAB <> VAAB OR VATO-VAAB<>CUCOSACU;

  BEGIN

      ROLLBACK;

      FOR CUENTA IN CUCUENTAS LOOP
      
          NUCUENTA := CUENTA.CARGCUCO;
          PKTBLCUENCOBR.UPDCUCOVATO(CUENTA.CARGCUCO,CUENTA.VATO);
          PKTBLCUENCOBR.UPDCUCOVAAB(CUENTA.CARGCUCO,CUENTA.VAAB);
          
          COMMIT;

      END LOOP;

      DBMS_OUTPUT.PUT_LINE('Proceso termino Ok');

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK; 
      --
      DBMS_OUTPUT.PUT_LINE('Error actualizando la cuenta de cobro ' || NUCUENTA);
      --
  END;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/