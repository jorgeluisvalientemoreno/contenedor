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
     where difecodi in (100905901,
100905937,
100905955,
100905958,
100905962,
100905964,
100905965,
100905966,
100905967,
100905969,
100905972,
100905974,
100905986,
100905988,
100906012,
100906017,
100906013,
100906019,
100906020,
100906025,
100906067,
100906071,
100906078,
100906080,
100906082,
100906084,
100906085,
100906086,
100906087,
100906093,
100906102,
100906103,
100906113,
100906118,
100906129,
100906136,
100906131,
100906135,
100906137,
100906141,
100906142,
100906146,
100906172,
100906176,
100906195,
100906197,
100906200,
100906202,
100906221,
100906240,
100906248,
100906250,
100906266,
100906268,
100906274,
100906280,
100906323,
100906329,
100906331,
100906342,
100906349,
100906354,
100906356,
100906361,
100906362,
100906366,
100906385,
100906393,
100906396,
100906410,
100906411,
100906415,
100906417,
100906419,
100906421,
100906425,
100906426,
100906430,
100906431,
100906447,
100906459,
100906460,
100906468,
100906477,
100906479,
100906482,
100906509,
100906514,
100906518,
100906524,
100906525,
100906528,
100906529,
100906555,
100906576,
100906579,
100906580,
100906582,
100906587,
100906595,
100906593,
100906598,
100906606,
100906611,
100906615,
100906620,
100906637,
100906639,
100906683,
100906685,
100906689,
100906692,
100906714,
100906716,
100906722,
100906729,
100906741,
100906745,
100906755,
100906756,
100906757,
100906777,
100906787,
100906795,
100906796,
100906801,
100906806,
100906812,
100906813,
100906815,
100906845,
100906861,
100906850,
100906854,
100906860,
100906864,
100906865,
100906867,
100906878,
100906883,
100906891,
100906893,
100906905,
100906907,
100906911,
100906915,
100906917,
100906919,
100906920,
100906921,
100906924,
100906925,
100906928,
100906929,
100906930,
100906932,
100906939,
100906941,
100906942,
100906945,
100906950,
100906955,
100906958,
100906960,
100906967,
100906971,
100906987,
100906989,
100906990,
100906995,
100906999,
100907004,
100907005,
100907010,
100907026,
100907030,
100907035,
100907041,
100907053,
100907056,
100907057,
100907065,
100907083,
100907084,
100907086,
100907088,
100907097,
100907098,
100907104,
100907101,
100907102,
100907107,
100907108,
100907112,
100907113,
100907114,
100907122,
100907125,
100907126,
100907127,
100907128,
100907130,
100907131,
100907134,
100907140,
100907141,
100907147,
100907149,
100907150,
100907153,
100907170,
100907171,
100907172,
100907173,
100907179,
100907183,
100907185,
100907192,
100907193,
100907195,
100907202,
100907205,
100907209,
100907213,
100907224,
100907225,
100907226,
100907230,
100907242,
100907244,
100907282,
100907285,
100907317,
100907321,
100907340,
100907348,
100907349,
100907355,
100907370,
100907372,
100907375,
100907378,
100907379,
100907381,
100907384,
100907391,
100907392,
100907395,
100907396,
100907403,
100907406,
100907409,
100907412,
100907415,
100907418,
100907421,
100907448,
100907452,
100907453,
100907458,
100907467,
100907471,
100907472,
100907475,
100907476,
100907482,
100907485,
100907487,
100907522,
100907526,
100907528,
100907535,
100907536,
100907547,
100907550,
100907548,
100907559,
100907564,
100907561,
100907566,
100907567,
100907573,
100907570,
100907576,
100907581,
100907583,
100907588,
100907595,
100907610,
100907619,
100907623,
100907630,
100907633,
100907636,
100907638,
100907644,
100907648,
100907652,
100907662,
100907665,
100907689,
100907691,
100907694,
100907699,
100907700,
100907708,
100907709,
100907723,
100907730,
100907731,
100907732,
100907734,
100907735,
100907739,
100907740,
100907742,
100907754,
100907768,
100907779,
100907790,
100907793,
100907799,
100907801,
100907820,
100907845,
100907846,
100907847,
100907849,
100907850,
100907856,
100907857,
100907859,
100907884,
100907892,
100907893,
100907895,
100907897,
100907899,
100907902,
100907911,
100907912,
100907927,
100907934,
100907938,
100907949,
100907951,
100907965,
100907969,
100907973,
100907978,
100907983,
100907997,
100908003,
100908008,
100908035,
100908039,
100908071,
100908073,
100908074,
100908078,
100908079,
100908081,
100908082,
100908086,
100908140,
100908147,
100908153,
100908155,
100908157,
100908163,
100908168,
100908172,
100908196,
100908199,
100908207,
100908208,
100908214,
100908222,
100908225,
100908230,
100908231,
100908237,
100908253,
100908258,
100908268,
100908272,
100908274,
100908275,
100908292,
100908302,
100908303,
100908307,
100908333,
100908342,
100908347,
100908349,
100908350,
100908357,
100908358,
100908366,
100908382,
100908394,
100908404,
100908406,
100905940,
100905950,
100905990,
100906009,
100906026,
100906043,
100906045,
100906053,
100906049,
100906065,
100906073,
100906077,
100906099,
100906101,
100906147,
100906168,
100906174,
100906178,
100906218,
100906220,
100906251,
100906254,
100906255,
100906261,
100906269,
100906273,
100906307,
100906309,
100906312,
100906321,
100906365,
100906373,
100906374,
100906378,
100906484,
100906505,
100906515,
100906522,
100906560,
100906563,
100906602,
100906605,
100906626,
100906629,
100906648,
100906653,
100906658,
100906665,
100906670,
100906682,
100906693,
100906694,
100906717,
100906719,
100906730,
100906734,
100906783,
100906786,
100906842,
100906846,
100906868,
100906876,
100906885,
100906887,
100906894,
100906897,
100906898,
100906902,
100906908,
100906910,
100906947,
100906949,
100906973,
100906976,
100907011,
100907013,
100907019,
100907024,
100907042,
100907043,
100907047,
100907049,
100907066,
100907067,
100907068,
100907072,
100907115,
100907119,
100907120,
100907121,
100907135,
100907136,
100907231,
100907233,
100907236,
100907240,
100907245,
100907248,
100907249,
100907253,
100907258,
100907264,
100907265,
100907276,
100907283,
100907314,
100907327,
100907339,
100907356,
100907358,
100907360,
100907365,
100907416,
100907419,
100907426,
100907447,
100907461,
100907465,
100907490,
100907498,
100907596,
100907608,
100907645,
100907647,
100907655,
100907659,
100907660,
100907661,
100907666,
100907670,
100907671,
100907675,
100907681,
100907687,
100907725,
100907729,
100907747,
100907753,
100907769,
100907774,
100907802,
100907804,
100907821,
100907823,
100907827,
100907831,
100907840,
100907844,
100907931,
100907933,
100907952,
100907956,
100907970,
100907972,
100908011,
100908013,
100908031,
100908034,
100908101,
100908109,
100908110,
100908137,
100908138,
100908144,
100908166,
100908170,
100908190,
100908194,
100908239,
100908250,
100908264,
100908271,
100908286,
100908289,
100908308,
100908330,
100908367,
100908373,
100908395,
100908401,
100905952,
100905954,
100906291,
100906293,
100906297,
100906302,
100906562,
100906575,
100906933,
100906937,
100906977,
100906986,
100907031,
100907034,
100907154,
100907155,
100907176,
100907178,
100907196,
100907200,
100907275,
100907278,
100907320,
100907325,
100907824,
100907826,
100908388,
100908399,
100908409,
100908413,
100906177,
100906180,
100907016,
100907018);
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
    where p.policy_id in (1109148,
1109073,
1109154,
1109076,
1109157,
1109077,
1109159,
1109078,
1109160,
1109079,
1109162,
1109080,
1109164,
1109081,
1109169,
1109170,
1109083,
1109084,
1109172,
1109085,
1109180,
1109089,
1109184,
1109191,
1109187,
1109192,
1109189,
1109193,
1109190,
1109194,
1109213,
1109196,
1109214,
1109197,
1109217,
1109199,
1109198,
1109219,
1109220,
1109200,
1109222,
1109201,
1109227,
1109203,
1109232,
1109206,
1109234,
1109207,
1109239,
1109209,
1109240,
1109210,
1109248,
1109253,
1109272,
1109255,
1109282,
1109260,
1109284,
1109261,
1109287,
1109289,
1109262,
1109263,
1109290,
1109264,
1109297,
1109299,
1109267,
1109300,
1109301,
1109268,
1109303,
1109269,
1109270,
1109306,
1109311,
1109312,
1109307,
1109313,
1109309,
1109310,
1109314,
1109315,
1109332,
1109316,
1109337,
1109318,
1109340,
1109342,
1109320,
1109344,
1109321,
1109322,
1109349,
1109325,
1109326,
1109350,
1109328,
1109330,
1109351,
1109352,
1109373,
1109354,
1109375,
1109355,
1109381,
1109357,
1109390,
1109361,
1109362,
1109391,
1109364,
1109393,
1109367,
1109395,
1109411,
1109397,
1109414,
1109398,
1109415,
1109399,
1109419,
1109401,
1109421,
1109402,
1109424,
1109403,
1109426,
1109404,
1109429,
1109407,
1109406,
1109431,
1109434,
1109408,
1109436,
1109409,
1109439,
1109451,
1109444,
1109453,
1109449,
1109456,
1109471,
1109458,
1109474,
1109459,
1109476,
1109460,
1109477,
1109461,
1109478,
1109462,
1109479,
1109463,
1109484,
1109465,
1109486,
1109466,
1109489,
1109468,
1109491,
1109469,
1109494,
1109470,
1109499,
1109513,
1109501,
1109514,
1109504,
1109515,
1109506,
1109516,
1109534,
1109520,
1109537,
1109522,
1109543,
1109525,
1109544,
1109526,
1109548,
1109529,
1109549,
1109530,
1109550,
1109551,
1109573,
1109571,
1109552,
1109553,
1109575,
1109554,
1109555,
1109577,
1109558,
1109580,
1109559,
1109581,
1109560,
1109582,
1109561,
1109583,
1109563,
1109585,
1109564,
1109586,
1109566,
1109587,
1109568,
1109589,
1109569,
1109590,
1109593,
1109611,
1109595,
1109612,
1109596,
1109613,
1109600,
1109615,
1109603,
1109616,
1109605,
1109617,
1109606,
1109618,
1109633,
1109621,
1109645,
1109627,
1109648,
1109629,
1109655,
1109672,
1109656,
1109673,
1109663,
1109665,
1109676,
1109677,
1109666,
1109668,
1109678,
1109679,
1109670,
1109680,
1109693,
1109681,
1109695,
1109696,
1109682,
1109683,
1109700,
1109685,
1109706,
1109687,
1109708,
1109688,
1109713,
1109690,
1109715,
1109731,
1109716,
1109732,
1109718,
1109733,
1109724,
1109735,
1109726,
1109736,
1109728,
1109737,
1109738,
1109730,
1109754,
1109756,
1109739,
1109740,
1109758,
1109760,
1109741,
1109742,
1109764,
1109743,
1109766,
1109744,
1109770,
1109746,
1109773,
1109747,
1109775,
1109748,
1109776,
1109749,
1109780,
1109791,
1109786,
1109794,
1109815,
1109798,
1109816,
1109799,
1109818,
1109800,
1109820,
1109801,
1109825,
1109803,
1109826,
1109804,
1109828,
1109805,
1109830,
1109806,
1109835,
1109808,
1109838,
1109840,
1109810,
1109843,
1109851,
1109852,
1109875,
1109858,
1109876,
1109859,
1109878,
1109860,
1109880,
1109861,
1109883,
1109862,
1109885,
1109863,
1109886,
1109864,
1109888,
1109865,
1109890,
1109866,
1109896,
1109868,
1109898,
1109869,
1109904,
1109911,
1109908,
1109913,
1109910,
1109914,
1109934,
1109915,
1109940,
1109918,
1109944,
1109919,
1109946,
1109920,
1109948,
1109921,
1109950,
1109922,
1109960,
1109926,
1109964,
1109966,
1109927,
1109928,
1109970,
1109930,
1109976,
1109978,
1109992,
1109993,
1109980,
1109994,
1109984,
1109995,
1109986,
1109996,
1109990,
1109998,
1110016,
1110018,
1110000,
1110001,
1110024,
1110003,
1110026,
1110004,
1110030,
1110006,
1110034,
1110007,
1110036,
1110008,
1110038,
1110009,
1110044,
1110051,
1110055,
1110048,
1109150,
1109074,
1109167,
1109082,
1109174,
1109086,
1109177,
1109179,
1109087,
1109088,
1109182,
1109090,
1109211,
1109195,
1109224,
1109202,
1109229,
1109204,
1109237,
1109208,
1109242,
1109251,
1109244,
1109252,
1109250,
1109254,
1109279,
1109258,
1109280,
1109259,
1109292,
1109265,
1109294,
1109266,
1109334,
1109317,
1109339,
1109319,
1109347,
1109323,
1109371,
1109353,
1109379,
1109356,
1109383,
1109358,
1109385,
1109359,
1109388,
1109360,
1109363,
1109392,
1109366,
1109394,
1109369,
1109396,
1109417,
1109400,
1109427,
1109405,
1109437,
1109410,
1109441,
1109452,
1109446,
1109454,
1109447,
1109455,
1109450,
1109457,
1109487,
1109467,
1109496,
1109511,
1109507,
1109517,
1109531,
1109519,
1109539,
1109540,
1109523,
1109524,
1109546,
1109527,
1109547,
1109528,
1109556,
1109578,
1109557,
1109579,
1109562,
1109584,
1109608,
1109619,
1109610,
1109620,
1109635,
1109622,
1109636,
1109623,
1109638,
1109640,
1109624,
1109625,
1109646,
1109628,
1109653,
1109671,
1109658,
1109674,
1109660,
1109675,
1109698,
1109684,
1109704,
1109686,
1109710,
1109689,
1109720,
1109734,
1109768,
1109745,
1109778,
1109750,
1109783,
1109792,
1109785,
1109793,
1109788,
1109795,
1109790,
1109796,
1109813,
1109797,
1109823,
1109802,
1109833,
1109807,
1109836,
1109809,
1109845,
1109846,
1109853,
1109854,
1109850,
1109856,
1109873,
1109857,
1109894,
1109867,
1109900,
1109870,
1109906,
1109912,
1109936,
1109916,
1109938,
1109917,
1109954,
1109923,
1109956,
1109924,
1109958,
1109925,
1109968,
1109929,
1109974,
1109991,
1109988,
1109997,
1110014,
1109999,
1110020,
1110002,
1110028,
1110005,
1110040,
1110010,
1110054,
1110047,
1109152,
1109075,
1109274,
1109256,
1109277,
1109257,
1109348,
1109324,
1109481,
1109464,
1109497,
1109512,
1109536,
1109521,
1109567,
1109588,
1109591,
1109570,
1109598,
1109614,
1109643,
1109626,
1109650,
1109630,
1109848,
1109855,
1110053,
1110046,
1110056,
1110049,
1109230,
1109205,
1109509,
1109518);
   --
   commit;
   Dbms_Output.put_line('Proceso de anulacion de polizas realizado satisfactoriamente.');
   
   Exception
     When others Then
       Rollback;
       Dbms_Output.put_line('Error en proceso Producto ' || Nucuencobr || ' ' || sqlerrm);
  End;

End;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/