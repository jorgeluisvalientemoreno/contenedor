CREATE OR REPLACE PACKAGE PKLOG_MIGRACION AS

  PROCEDURE prInsLogMigra ( LOMIPROC number,
                            LOMISUPR number,
                            LOMITIPR number,
                            LOMIDESC varchar2,
                            LOMIREIN varchar2,
                            LOMIREFI number,
                            LOMIOBSE varchar2,
                            lomicode varchar2,
                            LOMICODI    out number
                            );
  PROCEDURE prUpdLogMigra ( iLOMICODI number,
                            iLOMIFEFI date,
                            iLOMIREFI  number
                            );

END PKLOG_MIGRACION; 
/
CREATE OR REPLACE PACKAGE BODY PKLOG_MIGRACION AS

    sbUser varchar2(250) := USER;
    sbMaquina varchar2(250);
    nuSESSIONID number;
    
  function cargacontexto (sbContexto varchar2) return varchar2 IS
    CURSOR cuContexto (sbValor varchar2)IS
        SELECT sys_context('USERENV', sbValor) FROM DUAL;
    sbValor varchar2(250);
  BEGIN
    open cuContexto (sbContexto);
    fetch cuContexto INTO sbValor;
    close cuContexto;
    return sbValor;
  END;
  
  PROCEDURE prInsLogMigra ( LOMIPROC number,
                            LOMISUPR number,
                            LOMITIPR number,
                            LOMIDESC varchar2,
                            LOMIREIN varchar2,
                            LOMIREFI number,
                            LOMIOBSE varchar2,
                            LOMICODE varchar2,
                            LOMICODI out number
                            ) AS
  PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN
    LOMICODI := seq_logmigra.nextval;

   INSERT INTO LOG_MIGRACION (LOMICODI,
                                LOMIPROC,
                                LOMISUPR,
                                LOMITIPR,
                                LOMIUSER,
                                LOMITERM,
                                LOMIFEIN,
                                LOMISESI,
                                LOMIDESC,
                                LOMIFEFI,
                                LOMIREIN,
                                LOMIREFI,
                                LOMIOBSE
                                )
           VALUES ( LOMICODI,
                    LOMIPROC,
                    LOMISUPR,
                    LOMITIPR,
                    sbUser,
                    LOMICODE,
                    sysdate,
                    nuSESSIONID,
                    LOMIDESC,
                    sysdate,
                    LOMIREIN,
                    LOMIREFI,
                    LOMIOBSE
           );
      COMMIT;

END prInsLogMigra;

  PROCEDURE prUpdLogMigra ( iLOMICODI number,
                            iLOMIFEFI date,
                            iLOMIREFI  number
                            ) AS
  PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN
      UPDATE  LOG_MIGRACION
      SET LOMIFEFI = iLOMIFEFI,
       LOMIREFI = iLOMIREFI
       WHERE LOMICODI = iLOMICODI;
       
      COMMIT;

END prUpdLogMigra;

BEGIN
    sbUser := USER;
    sbMaquina := cargacontexto('HOST')||' '||cargacontexto('OS_USER');
    NUSESSIONID :=  CARGACONTEXTO('SESSIONID');
END PKLOG_MIGRACION; 
/
