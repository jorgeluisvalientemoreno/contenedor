DECLARE

  sbCodigo parametros.codigo%TYPE := upper('valida_financiacion');

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
    rcParametroOrig.descripcion    := 'PERMITE LA BUSQUEDA DE CARGOS ASOCIADOS A UNA SOLICITUD SIN CUENTA DE COBRO OSF-2880';
    rcParametroOrig.valor_numerico := NULL;
    rcParametroOrig.valor_cadena   := 'S';
    rcParametroOrig.fecha_creacion := sysdate;
    rcParametroOrig.usuario        := rcUsuarioTerminal.usuario;
    rcParametroOrig.terminal       := rcUsuarioTerminal.terminal;
    rcParametroOrig.proceso        := 5;
  
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
  
    dbms_output.put_line('Inicia creacion parametro valida_financiacion');
    INSERT INTO parametros values rcParametroOrig;
    dbms_output.put_line('Termina creacion parametro valida_financiacion');
  
  ELSE
    dbms_output.put_line('Inicia actualizacion parametro valida_financiacion');
    UPDATE parametros
       SET descripcion         = rcParametroOrig.descripcion,
           valor_numerico      = rcParametroOrig.valor_numerico,
           valor_cadena        = rcParametroOrig.valor_cadena,
           fecha_actualizacion = sysdate,
           usuario             = rcUsuarioTerminal.usuario,
           terminal            = rcUsuarioTerminal.terminal,
           proceso             = rcParametroOrig.proceso
     WHERE codigo = sbCodigo;
  
    dbms_output.put_line('Termina actualizacion parametro valida_financiacion');
  END IF;

  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    dbms_output.put_line('Error creando en personaliacioens.parametros valida_financiacion|' ||
                         SQLERRM);
END;
/
