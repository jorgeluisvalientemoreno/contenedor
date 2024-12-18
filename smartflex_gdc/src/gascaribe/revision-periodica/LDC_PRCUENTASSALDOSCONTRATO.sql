CREATE OR REPLACE PROCEDURE LDC_PRCUENTASSALDOSCONTRATO(inuSusc in suscripc.susccodi%type) IS

  /*****************************************************************
  Unidad         : LDC_FNUCUENTASSALDOSPRODUCTO
  Descripcion    : Establece error con base a la cantidad de cuentas con saldos de un contrato
                   Solo si el producto esta uspendido por RP
  Autor          : Jorge Valiente.
  Fecha          : 26/06/2022
  
  Parametros             Descripcion
  ============        ===================
  inuSusc             Codigo del contrato
  
  Historia de Modificaciones
  
  DD-MM-YYYY    <Autor>               Modificacion
  -----------  -------------------    -------------------------------------
  09/08/2022   Jorge Valiente         OSF-479: Cambiar cursor cuProducto para obtener el prodcuto de tipo de serivicio GAS 
                                               y obtener el codigo del producto GAS del contrato.
                                               Realizar el llamado del servicio LDC_FNUCUENTASSALDOSPRODUCTO para 
                                               validar el resultado con el contenido del paremtro CANT_CTA_SALDO_RESTR_RECON
  ******************************************************************/
  --<<
  -- Variables del proceso
  -->>

  --<<
  -- Cursor que obtiene el producto Gas del contrato
  -->>
  CURSOR cuProducto IS
    select s.sesunuse
      from servsusc s
     where s.sesususc = inuSusc
       and s.sesuserv = 7014 --OSF-479 Tipo Gas
     order by s.sesufere desc;

  --Inicio OSF-479
  nuCANT_CTA_SALDO_RESTR_RECON LDC_PARAREPE.PAREVANU%type := daldc_pararepe.fnuGetPAREVANU('CANT_CTA_SALDO_RESTR_RECON',
                                                                                           null);

  nuProdcutoGas number;
  --Fin OSF-479

BEGIN

  IF FBLAPLICAENTREGAXCASO('OSF-369') THEN
  
    OPEN cuProducto;
    FETCH cuProducto
      INTO nuProdcutoGas;
    IF cuProducto%NOTFOUND THEN
      nuProdcutoGas := 0;
    END IF;
    CLOSE cuProducto;
  
    if LDC_FNUCUENTASSALDOSPRODUCTO(nuProdcutoGas) >=
       nuCANT_CTA_SALDO_RESTR_RECON and
       instr(DALD_PARAMETER.fsbGetValue_Chain('LDC_PAR_INSTANCIA', NULL),
             ut_session.getmodule) != 0 then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                       'No se puede generar trámite porque el usuario tiene saldo pendiente');
      RAISE ex.controlled_error;
    end if;
  
  end if;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END LDC_PRCUENTASSALDOSCONTRATO;
/