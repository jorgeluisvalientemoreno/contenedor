column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare

  Cursor CuDiferidos Is
      select * 
        from open.diferido d 
      where difecodi in (100907065);
  --       and difenuse = 51953263;
  
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
  isbDescripcion  notas.notaobse%type := 'Cancela Diferido por renovacion Duplicada, Caso OSF-940';
  
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
    
          commit;
          
      Else
        
          Dbms_Output.put_line('Producto ' || reg.difenuse || ' tiene cargos a la -1');
          
      End if;
          
    End Loop;

    Dbms_Output.put_line('Proceso de notas realizado satisfactoriamente.');
    
    -- Anulamos las polizas correspondientes a los diferidos anulados
    update open.ld_policy p
        set p.state_policy = 2
      where p.policy_id in (1109526);
    --
    commit;

    -- Revivimos polizas que por error se anularon
    update open.ld_policy l
        set l.state_policy = 1
      where l.policy_id in (988479,988221,988026,988033,987938,988075,988095,988492,988420,988149,987800,988432,988218,987807,987810,988491,
      988478,987736,988226,988436,987822,988128,988244,988127,988116,987817,988111,988187,988242,987821,987824,987731,988470,988011,988100,
      988098,988099,988482,988143,988020,988435,988027,988084,988157,988013,988034,988481,988280,987801,987734,988261,988267,987733,988136,
      988092,987945,987798,988016,987794,988211,988086,988224,988494,988141,987804,988151,988203,988206,988486,988009,987874,988498,988228,
      988223,988145,988272,988101,988204,987812,988031,988465,987737,987723,987722,988073,988287,987783,988213,988483,988008,987808,987790,
      988500,988208,988028,988037,987786,988475,987941,987780,988090,988029,988414,988081,988161,988071,988088,988490,988163,988022,988426,
      988018,987943,988201,988289,987940,987792,988139,988283,988039,988070,988274,987802,988489,988214,988423,988418,988269,988155,987720,
      988472,988216,988120,988190,988122,988166,988169,988245,988104,988102,988133,988437,988399,988409,988410,988388,988407,988109,988412,
      988403,988439,988397,988395,988131,988068,988231,988191,988125,988234,988118,988247,988237,988239,988180,988250,988106,988253,988197,
      988179,988393,987818,988114,988182,988184,988233,988176,988194,988405,987772,987773,987964,987962,987968,987997,987998,987849,987971,
      987862,988050,987986,988000,987848,987759,987992,987995,987988,988065,987875,987885,987890,987767,987972,987756,987859,987860,988002,
      987776,987864,987912,988052,987975,988055,987868,987869,987924,987713,987715,988006,987777,987740,987742,987761,987762,987907,987908,
      987870,987851,987915,987916,987919,987935,987843,987763,987877,988057,988059,987717,987921,987872,987893,987894,987896,987899,987887,
      987929,987931,987933,987840,987853,987881,987764,988046,987866,987867,987977,988061,987854,987748,987750,987835,987980,987982,987984,
      987846,987855,987856,987857,987745,987747,987752,987836,987832,987973,988044,987709,987711,987905,987960,987725,987909,987728,987883,
      987826,987863,988256,988333,988295,988297,988317,988348,988352,988339,988342,988335,988321,988311,988329,988304,988258,988331,988293,
      988345,988255,988324,988306,988308,988299);   
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
  
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/