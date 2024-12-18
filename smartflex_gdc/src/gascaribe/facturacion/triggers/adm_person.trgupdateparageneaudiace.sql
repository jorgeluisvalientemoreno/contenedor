CREATE OR REPLACE TRIGGER ADM_PERSON.TRGUPDATEPARAGENEAUDIACE
  BEFORE UPDATE or DELETE ON ld_fa_paragene
  FOR EACH ROW

    /*Este trigger se dispara cuando se va a  realizar una  actualizaciรณn sobre   la entidad  LD_FA_PARAGENE (parรกmetros generales)
    y se encargarรก  de  llamar   a  los  procesos  encargados  de  realizar  las respectivas inserciones .*/
DECLARE

      /*Declaraciรณn de Variables*/
      consecutivo Number; /*consecutivo para el cรณdigo de registro de la tabla auditoria*/
      session     Number; /*sesiรณn en la que se autentica el usuario*/
      terminal    Varchar2(60); /*terminal desde la cual se inicia sesiรณn*/
      nuResp      Number; /*variable para cรณdigo de error*/

    BEGIN

    /*si se va a actualizar trae el el consecutivo, la sesiรณn y la terminal*/
      if (Updating) then

	   begin
        SELECT USERENV('SESSIONID')
        INTO session
        FROM dual;
       end;
       begin
        SELECT USERENV('TERMINAL')
        INTO terminal
        FROM dual;
      end;
        if (:new.pagevanu IS NOT NULL) then /*valida que el nuevo valor numรฉrico sea diferente a nulo*/
          PKLD_FA_AUDIACE.Insertaudiace(SEQ_LD_FA_AUDIDESC.NEXTVAL, /*realiza la inserciรณn*/
                                        'UPDATE',
                                        'LD_FA_PARAGENE',
                                        :OLD.PAGENDES,
                                        'PAGEVANU',
                                        :OLD.PAGEVANU,
                                        :NEW.PAGEVANU,
                                        session,
                                        :NEW.PAGEUSUA,
                                        SYSDATE,
                                        'D',
                                        terminal,
                                        consecutivo,
                                        nuResp);
        end if;

        if (:new.pagevate IS NOT NULL) then /*valida que el nuevo valor de texto sea diferente a nulo*/
          PKLD_FA_AUDIACE.Insertaudiace(SEQ_LD_FA_AUDIDESC.NEXTVAL, /*realiza la inserciรณn*/
                                        'UPDATE',
                                        'LD_FA_PARAGENE',
                                        :OLD.PAGENDES,
                                        'PAGEVATE',
                                        :OLD.PAGEVATE,
                                        :NEW.PAGEVATE,
                                        session,
                                        :NEW.PAGEUSUA,
                                        SYSDATE,
                                        'D',
                                        terminal,
                                        consecutivo,
                                        nuResp);
        end if;
      elsif (deleting) then
	   begin
        SELECT USERENV('SESSIONID')
        INTO session
        FROM dual;
       end;
       begin
        SELECT USERENV('TERMINAL')
        INTO terminal
        FROM dual;
      end;
        PKLD_FA_AUDIACE.Insertaudiace(SEQ_LD_FA_AUDIDESC.NEXTVAL, /*realiza la inserciรณn*/
                                      'DELETE',
                                      'LD_FA_PARAGENE',
                                      'TODOS',
                                      'TODOS',
                                      -1,
                                      -1,
                                      session,
                                      :OLD.PAGEUSUA,
                                      SYSDATE,
                                      'D',
                                      terminal,
                                      consecutivo,
                                      nuResp);

      end if;

END TRGUPDATEPARAGENEAUDIACE;
/
