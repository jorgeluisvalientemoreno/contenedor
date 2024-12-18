column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare

  Cursor CuDiferidos Is
      select d.difecodi, d.difesusc, d.difenuse, d.difeconc, cargcuco, substr(cargdoso,4) poliza
        from open.diferido d, open.cargos c, open.movidife m
      where d.difecodi in (106052383,
106050493,
106051290,
106051180,
106051642,
106051824,
106052235,
106052340,
106052345,
106052371,
106052427,
106051792,
106053439,
106052785,
106052899,
106053090,
106053158,
106047445,
106048336,
106048587,
106048689,
106047132,
106050693,
106051333,
106051576,
106051591,
106051978,
106051986,
106052126,
106052466,
106052693,
106052724,
106050558,
106050142,
106049726)
        and m.modidife = d.difecodi
        and m.modicuap = 0
        and c.cargnuse = d.difenuse
        and c.cargcaca = 72
        and c.cargfecr >= '07-12-2023'
        and c.cargcuco in (select cg.cargcuco from open.cargos cg
                            where cg.cargnuse = d.difenuse 
                              and cg.cargdoso = 'FD-'||d.difecodi 
                              and cg.cargcaca = 50
                              and cg.cargfecr >= m.modifech);

  
  Cursor CuCargos(nuProducto diferido.difenuse%type, nuDifecodi diferido.difecodi%type) Is   
      SELECT DISTINCT cargcuco, cargvalo
        FROM cargos
      WHERE cargnuse =  nuProducto
        AND trunc(cargfecr) = trunc(SYSDATE)
        AND cargsign =  'DB'
        AND cargdoso =  'DF-'||nuDifecodi
        AND cargcaca =  dald_parameter.fnuGetNumeric_Value('CAUSCAR_CANC_DIFERIDO', 0)
        AND cargcuco <> -1
        AND cargvalo >  0;


  Cursor CuValCargos(nuProducto diferido.difenuse%type) Is   
      SELECT count(1)
        FROM cargos
      WHERE cargnuse = nuProducto
        AND cargcuco = -1;
    

  nuErrorCode     number;
  sbErrorMessage  varchar2(2000);
  isbDescripcion  notas.notaobse%type := 'Cancela Diferido por renovacion Duplicada, Caso OSF-2173';
  
  Nucuencobr      diferido.difecodi%type;
  nuvaldifer      diferido.difesape%type;
  nuNote          notas.notanume%type;
  nuctrlcar       number;

  Begin
    
    For reg in Cudiferidos Loop
      
        -- Valida que el producto no tenga cargos con cuenta de cobro a la -1
        If cuValcargos%isopen then
          close cuValcargos;
        end if;
        --
        open cuValcargos(reg.difenuse);
        fetch CuValCargos into nuctrlcar;
        close CuValCargos;
        --
        If nuctrlcar <= 0 then
        
          -- Trae deuda a presente mes
          CC_BODefToCurTransfer.GlobalInitialize;

          CC_BODefToCurTransfer.AddDeferToCollect(reg.difecodi);

          CC_BODefToCurTransfer.TransferDebt
          (
              'FINAN',
              nuErrorCode,
              sbErrorMessage,
              false,
              ld_boconstans.cnuCero_Value,
              sysdate
          );
              
          If Cucargos%isopen then
            close cucargos;
          end if;
          --
          open cucargos(reg.difenuse, reg.difecodi);
          fetch cucargos into Nucuencobr,nuvaldifer;
          close cucargos;
                          
          --  Crea la nota credito
          pkBillingNoteMgr.CreateBillingNote
          (
              reg.difenuse,
              Nucuencobr,
              GE_BOConstants.fnuGetDocTypeCreNote,
              sysdate,
              isbDescripcion,
              pkBillConst.csbTOKEN_NOTA_CREDITO,
              nuNote
          );

                  
          -- Crea detalle de la nota credito, causal 1
          FA_BOBillingNotes.DetailRegister
          (
              nuNote,
              reg.difenuse,
              reg.difesusc,
              Nucuencobr,
              reg.difeconc,
              1,           -- inuCausa,
              nuvaldifer,  -- inuValue,
              NULL,
              pkBillConst.csbTOKEN_NOTA_CREDITO || nuNote,
              pkBillConst.CREDITO,
              ld_boconstans.csbYesFlag,
              NULL,
              pkConstante.NO,
              FALSE
          );
          
          --
          -- Anulamos las polizas correspondientes a los diferidos anulados
          update open.ld_policy p
            set p.state_policy = 2
          where p.policy_id = reg.poliza;   
    
          commit;
          
      Else
        
          Dbms_Output.put_line('Producto ' || reg.difenuse || ' tiene cargos a la -1');
          
      End if;
          
    End Loop;

    Dbms_Output.put_line('Proceso de notas realizado satisfactoriamente.');
    --
    commit;
    --
    Dbms_Output.put_line('Proceso de anulacion de polizas realizado satisfactoriamente.');
    --
    Exception
      When others Then
        Rollback;
        Dbms_Output.put_line('Error en proceso Producto ' || Nucuencobr || ' ' || sqlerrm);
          
  End;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/