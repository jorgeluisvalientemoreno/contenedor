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
      where d.difecodi in (106052379,
  106052383,
  106052388,
  106052392,
  106052401,
  106052406,
  106052410,
  106052416,
  106050476,
  106050485,
  106050493,
  106050699,
  106050708,
  106050717,
  106050726,
  106050735,
  106050906,
  106050917,
  106050925,
  106050946,
  106050953,
  106050965,
  106051240,
  106051247,
  106051255,
  106051269,
  106051282,
  106051290,
  106051452,
  106051467,
  106051482,
  106051507,
  106051524,
  106051724,
  106047101,
  106047106,
  106050402,
  106050413,
  106050420,
  106050426,
  106050433,
  106050447,
  106050454,
  106050459,
  106050466,
  106050780,
  106050785,
  106050790,
  106050795,
  106050801,
  106050807,
  106050812,
  106050883,
  106050892,
  106051158,
  106051168,
  106051175,
  106051180,
  106051187,
  106051195,
  106051209,
  106051217,
  106051232,
  106051399,
  106051405,
  106051412,
  106051417,
  106051637,
  106051642,
  106051647,
  106051652,
  106051658,
  106051663,
  106051668,
  106051678,
  106051684,
  106051810,
  106051819,
  106051824,
  106051829,
  106047086,
  106052200,
  106052211,
  106052217,
  106052221,
  106052227,
  106052235,
  106052240,
  106052246,
  106052251,
  106052257,
  106052261,
  106052272,
  106052326,
  106052335,
  106052340,
  106052345,
  106052350,
  106052354,
  106052358,
  106052369,
  106052371,
  106052375,
  106052423,
  106052427,
  106052432,
  106052496,
  106052500,
  106052504,
  106052509,
  106052519,
  106052523,
  106052541,
  106052554,
  106052558,
  106052568,
  106052574,
  106052578,
  106052600,
  106052608,
  106052620,
  106052625,
  106052629,
  106052633,
  106052654,
  106052658,
  106052662,
  106050359,
  106050368,
  106050377,
  106050385,
  106050396,
  106050742,
  106050750,
  106050762,
  106050767,
  106050774,
  106050974,
  106050982,
  106050989,
  106050996,
  106051002,
  106051027,
  106051035,
  106051041,
  106051050,
  106051065,
  106051073,
  106051078,
  106051086,
  106051305,
  106051311,
  106051318,
  106051323,
  106051379,
  106051384,
  106051389,
  106051394,
  106051533,
  106051539,
  106051596,
  106051601,
  106051607,
  106051617,
  106051622,
  106051627,
  106051632,
  106051730,
  106051735,
  106051740,
  106051748,
  106051754,
  106051759,
  106051766,
  106051772,
  106051777,
  106051782,
  106051787,
  106051792,
  106051798,
  106051803,
  106052190,
  106052194,
  106053287,
  106053304,
  106053312,
  106053338,
  106053342,
  106053370,
  106053387,
  106053391,
  106053395,
  106053399,
  106053403,
  106053409,
  106053414,
  106053418,
  106053422,
  106053428,
  106053432,
  106053439,
  106053447,
  106053456,
  106053461,
  106053465,
  106053469,
  106053473,
  106053491,
  106053495,
  106053502,
  106053506,
  106053516,
  106053520,
  106053525,
  106053539,
  106053545,
  106053551,
  106053557,
  106053565,
  106053578,
  106053584,
  106053590,
  106053601,
  106053605,
  106053610,
  106053614,
  106053618,
  106053670,
  106053676,
  106053687,
  106053691,
  106053719,
  106052740,
  106052754,
  106052759,
  106052785,
  106052797,
  106052802,
  106052810,
  106052816,
  106052829,
  106052843,
  106052848,
  106052865,
  106052870,
  106052875,
  106052889,
  106052894,
  106052899,
  106052910,
  106052946,
  106052956,
  106052961,
  106052988,
  106053002,
  106053007,
  106053012,
  106053018,
  106053029,
  106053043,
  106053051,
  106053070,
  106053075,
  106053082,
  106053090,
  106053100,
  106053104,
  106053109,
  106053129,
  106053152,
  106053158,
  106053186,
  106053216,
  106053220,
  106053232,
  106053236,
  106053245,
  106053251,
  106053272,
  106053279,
  106047137,
  106047152,
  106047164,
  106047192,
  106047218,
  106047240,
  106047272,
  106047309,
  106047340,
  106047376,
  106047445,
  106047485,
  106047508,
  106047540,
  106047573,
  106047606,
  106047628,
  106047656,
  106047702,
  106047735,
  106047767,
  106047799,
  106047832,
  106047870,
  106047907,
  106047965,
  106048225,
  106048285,
  106048001,
  106048047,
  106048131,
  106048336,
  106048395,
  106048441,
  106048490,
  106048536,
  106048587,
  106048636,
  106048689,
  106048741,
  106048795,
  106048844,
  106048953,
  106049008,
  106049051,
  106049105,
  106049170,
  106047117,
  106047124,
  106047132,
  106052156,
  106052164,
  106052170,
  106052176,
  106052184,
  106050296,
  106050337,
  106050343,
  106050618,
  106050624,
  106050631,
  106050636,
  106050655,
  106050666,
  106050672,
  106050677,
  106050682,
  106050688,
  106050693,
  106050842,
  106050853,
  106050862,
  106051091,
  106051098,
  106051107,
  106051120,
  106051127,
  106051134,
  106051139,
  106051146,
  106051151,
  106051328,
  106051333,
  106051343,
  106051348,
  106051361,
  106051369,
  106051374,
  106051544,
  106051548,
  106051567,
  106051571,
  106051576,
  106051581,
  106051586,
  106051591,
  106051689,
  106051694,
  106051707,
  106051713,
  106051835,
  106051840,
  106051850,
  106051857,
  106051862,
  106051869,
  106051875,
  106051883,
  106051892,
  106051899,
  106051920,
  106051927,
  106051932,
  106051942,
  106051951,
  106051956,
  106051978,
  106051986,
  106051990,
  106051994,
  106051998,
  106052012,
  106052016,
  106052024,
  106052036,
  106052071,
  106052079,
  106052086,
  106052093,
  106052100,
  106052108,
  106052113,
  106052118,
  106052122,
  106052126,
  106052143,
  106052148,
  106052152,
  106052280,
  106052304,
  106052308,
  106052315,
  106052319,
  106052436,
  106052440,
  106052444,
  106052454,
  106052458,
  106052462,
  106052466,
  106052492,
  106052670,
  106052675,
  106052688,
  106052693,
  106052698,
  106052719,
  106052724,
  106052735,
  106050510,
  106050527,
  106050535,
  106050545,
  106050553,
  106050558,
  106050571,
  106050605,
  106050610,
  106050824,
  106050829,
  106049952,
  106049969,
  106049982,
  106049991,
  106049996,
  106050008,
  106050016,
  106050030,
  106050038,
  106050044,
  106050062,
  106050067,
  106050094,
  106050112,
  106050119,
  106050142,
  106050150,
  106050156,
  106050165,
  106050178,
  106050185,
  106050194,
  106050210,
  106050225,
  106050260,
  106050279,
  106049283,
  106049338,
  106049411,
  106049468,
  106049485,
  106049495,
  106049502,
  106049518,
  106049532,
  106049539,
  106049544,
  106049565,
  106049574,
  106049589,
  106049596,
  106049602,
  106049611,
  106049624,
  106049629,
  106049652,
  106049672,
  106049677,
  106049684,
  106049692,
  106049714,
  106049726,
  106049741,
  106049764,
  106049775,
  106049789,
  106049811,
  106049823,
  106049841,
  106049856,
  106049869,
  106049886,
  106049919,
  106049947,
  106052003,
  106052008,
  106052051,
  106052056,
  106052064,
  106049747)
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
  isbDescripcion  notas.notaobse%type := 'Cancela Diferido por renovacion Duplicada, Caso OSF-2151';
  
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