DECLARE

  sbCodigo parametros.codigo%TYPE := 'EST_ACTI_PROD_SUSP';

  CURSOR cuUsuarioTerminal IS
    SELECT SYS_CONTEXT('USERENV', 'TERMINAL') terminal,
           SYS_CONTEXT('USERENV', 'CURRENT_USER') usuario
      FROM DUAL;

  rcUsuarioTerminal cuUsuarioTerminal%ROWTYPE;

  CURSOR cuParametros IS
    SELECT * FROM parametros WHERE codigo = sbCodigo;

  rcParametroBD   parametros%ROWTYPE;
  rcParametroOrig parametros%ROWTYPE;

  PROCEDURE prcParametros IS
  BEGIN
  
    rcParametroOrig.codigo         := sbCodigo;
    rcParametroOrig.descripcion    := 'ESTADO PARA ACTIVAR PRODUCTO SUSPENDIDO. OSF-2477';
    rcParametroOrig.valor_numerico := 2;
    rcParametroOrig.valor_cadena   := NULL;
    rcParametroOrig.fecha_creacion := sysdate;
    rcParametroOrig.usuario        := rcUsuarioTerminal.usuario;
    rcParametroOrig.terminal       := rcUsuarioTerminal.terminal;
    rcParametroOrig.proceso        := 7;
  
  END prcParametros;

BEGIN

  OPEN cuParametros;
  FETCH cuParametros
    INTO rcParametroBD;
  CLOSE cuParametros;

  OPEN cuUsuarioTerminal;
  FETCH cuUsuarioTerminal
    INTO rcUsuarioTerminal;
  CLOSE cuUsuarioTerminal;

  prcParametros;

  IF rcParametroBD.codigo IS NULL THEN
  
    dbms_output.put_line('Inicia creacion parametro EST_ACTI_PROD_SUSP');
    INSERT INTO parametros values rcParametroOrig;
    dbms_output.put_line('Termina creacion parametro EST_ACTI_PROD_SUSP');
  
  ELSE
    dbms_output.put_line('Inicia actualizacion parametro EST_ACTI_PROD_SUSP');
    UPDATE parametros
       SET descripcion         = rcParametroOrig.descripcion,
           valor_numerico      = rcParametroOrig.valor_numerico,
           valor_cadena        = rcParametroOrig.valor_cadena,
           fecha_actualizacion = sysdate,
           usuario             = rcUsuarioTerminal.usuario,
           terminal            = rcUsuarioTerminal.terminal,
           proceso             = rcParametroOrig.proceso
     WHERE codigo = sbCodigo;
  
    dbms_output.put_line('Termina actualizacion parametro EST_ACTI_PROD_SUSP');
  END IF;

  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    dbms_output.put_line('Error creando en personaliacioens.parametros EST_ACTI_PROD_SUSP|' ||
                         SQLERRM);
END;
/
