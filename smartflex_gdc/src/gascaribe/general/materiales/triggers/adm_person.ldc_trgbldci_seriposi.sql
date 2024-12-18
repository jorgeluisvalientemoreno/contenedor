CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBLDCI_SERIPOSI
  BEFORE INSERT ON ldci_seriposi

/**************************************************************************
  Trigger     :  LDC_TRGBldci_seriposi
  Descripcion :  Permitira Validar que el item seriado a devolver este relacionado
                 con la unidad operativa definida en el documento SAP
  Autor       :  Jorge Valiente
  Fecha       :  22-06-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  27/09/2017      Jorge Valiente           CASO 200-1460: Validar que el item a devolver sera mediante la forma LDCIDEMA
  **************************************************************************/

  FOR EACH ROW
DECLARE

  ---------------
  -- Variables --
  ---------------
  sbErrMsg  ge_error_log.description%type; -- ge_items_seriado   ldci_seriposi
  nuErrCode number;

  ------------
  -- CURSOR --
  ------------
  --Obtner datos del documento que realizara la devolucion del item seriado
  Cursor CULDCI_TRANSOMA is
    select *
      from LDCI_TRANSOMA l
     where l.trsmmdpe is not null
       and l.trsmcodi in (:new.serisoma);

  rfCULDCI_TRANSOMA CULDCI_TRANSOMA%rowtype;

  Cursor CUge_items_seriado is
    select ITEMS_ID, SERIE, OPERATING_UNIT_ID
      from GE_ITEMS_SERIADO
     where SERIE = :new.serinume
       and OPERATING_UNIT_ID is not null;

  rfCUge_items_seriado CUge_items_seriado%rowtype;

  sbActi    varchar2(5);
  sbActiDel varchar2(5);
  sbProgram varchar2(100);
  nuTipo    number;
  nuTipoDel number;
  nuItemId  number;

  --CASO 200-1460
  --Variable
  sbexecutable sa_executable.name%Type;
  -----------------------------

BEGIN
  pkErrors.PUSH('Inicio LDC_TRGBldci_seriposi');

  begin
    sbexecutable := ut_session.getmodule; --sa_boexecutable.getexecutablename;
  exception
    when others then
      null;
  end;

  --CASO 200-1460
  if sbexecutable is not null then
    if sbexecutable = 'LDCIDEMA' then
      --------------
      if fblAplicaEntrega('OSS_SA_JLV_2001327_1') then
        --cursor para validar codigo de NIVEL DE MATERIALES con el documento SAP
        open CULDCI_TRANSOMA;
        fetch CULDCI_TRANSOMA
          INTO rfCULDCI_TRANSOMA;
        if CULDCI_TRANSOMA%notfound then
          close CULDCI_TRANSOMA;
          Errors.SetError(2741,
                          'El codigo [' || :new.serisoma ||
                          '] no esta registrado en el pesta?a de NIVEL DE MATERIALES');
          raise ex.controlled_error;
        else
          ----cursor para identificar unidad operativa con el item seriado a devolver
          open CUge_items_seriado;
          fetch CUge_items_seriado
            INTO rfCUge_items_seriado;
          if CUge_items_seriado%notfound then
            close CUge_items_seriado;
            Errors.SetError(2741,
                            'No existe el item seriado [' || :new.serinume || ']');
            raise ex.controlled_error;
          else
            if rfCUge_items_seriado.operating_unit_id <>
               rfCULDCI_TRANSOMA.trsmunop then
              close CUge_items_seriado;
              Errors.SetError(2741,
                              'El serial [' || :new.serinume ||
                              '] no se encuentra asociado a la unidad operativa [' ||
                              rfCULDCI_TRANSOMA.trsmunop || ' - ' ||
                              daor_operating_unit.fsbgetname(rfCULDCI_TRANSOMA.trsmunop,
                                                             null) || ']');
              raise ex.controlled_error;
            end if;
          end if;
          close CUge_items_seriado;
          ------------------------------------------------------------------------------------
        end if;
        close CULDCI_TRANSOMA;

      end if; --if fblAplicaEntrega('OSS_SA_JLV_2001327_1') then
      --CASO 200-1460
    end if; --if sbexecutable = 'LDCIDEMA' then
  end if; --if sbexecutable is not null then
  -------------------------------
  pkErrors.Pop;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    pkErrors.Pop;
    raise;

  when OTHERS then
    pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
    pkErrors.pop;
    raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
END LDC_TRGBLDCI_SERIPOSI;
/
