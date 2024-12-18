CREATE OR REPLACE trigger sys.TRGINTEGRACIONES after logon on database
/**************************************************************************************
 .   Autor           :  Carlos H Giraldo Z | DBA  SETI S.A.S                          .
 .   Descripción     :  TRIGGER para cambiar los parametros de optimizacion en las    .
 .                      sessiones del usuario INTEGRACIONES, para mejorar los planes  .
 .                      de ejecucion.                                                 .
 .   Notas           :                                                                .
 .                                                                                    .
 .   Variables       :                                                                .
 .                                                                                    .
 .                                                                                    .
 **************************************************************************************
 .   Modificaciones  :                                                                .
 .   25.03.2015 -- Se anexa    DB_FILE_MULTIBLOCK_READ_COUNT=16 -- CHG                .
 .                                                                                    .
 .                                                                                    .
 **************************************************************************************
 .   Quien             Cuando            Que                                          .
 .                                                                                    .
 .                                                                                    .
 .                                                                                    .
 **************************************************************************************
 .   Revision Historica                                                               .
 .   Version 1.0                                                                      .
 **************************************************************************************/
begin
 if user in ('INTEGRACIONES') then
  execute immediate 'ALTER SESSION set optimizer_index_cost_adj=10';
  execute immediate 'ALTER SESSION set optimizer_dynamic_sampling=0';
  execute immediate 'ALTER SESSION SET DB_FILE_MULTIBLOCK_READ_COUNT=16';
  execute immediate 'ALTER SESSION session_cached_cursors=400';
 end if;
exception
 when others then
  null;
end;
/
