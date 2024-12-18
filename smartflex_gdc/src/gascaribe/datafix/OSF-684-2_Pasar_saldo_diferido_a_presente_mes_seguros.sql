column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

Declare

 Cursor CuDiferidos Is
    select * 
      from open.diferido d 
     where difenuse in (51571810,
                        6599046,
                        51442191,
                        51526860,
                        51817062,
                        50410324,
                        51613831,
                        51747000,
                        50405027,
                        50404957,
                        51814858,
                        51720596,
                        51993576,
                        51704538,
                        51194151,
                        50406042,
                        51231226,
                        51664767,
                        51260592,
                        51979596,
                        17216080,
                        17083849,
                        50406475,
                        51939742,
                        17138673,
                        51793625,
                        52001409,
                        51834796,
                        51820162,
                        50417862,
                        51302769,
                        51814524,
                        51407255,
                        50473938,
                        51857460,
                        51720595,
                        51500512,
                        51984984,
                        51718106,
                        50417864,
                        50412591,
                        51094775,
                        51387313,
                        50263354,
                        51430443,
                        51850881,
                        17071851,
                        6546394,
                        51409667,
                        6548874,
                        51363096,
                        6539961,
                        51985736,
                        51058823,
                        50631490,
                        50407095,
                        51929030,
                        51919407,
                        51500170,
                        51886092,
                        51984535,
                        51819953,
                        50545578,
                        51679766,
                        51720483,
                        50408961,
                        6550796,
                        51781701,
                        17050938,
                        17066444,
                        50450137,
                        51679528,
                        17171040,
                        50498378,
                        51906602,
                        51720482,
                        51699590,
                        6560730,
                        51929276,
                        51595792,
                        51929785,
                        51919408,
                        51985490,
                        51958403,
                        6578599,
                        51958404,
                        51699591,
                        51449496,
                        51589764,
                        51864015,
                        51519561,
                        50713889,
                        51834775,
                        51409755,
                        51377008,
                        51947861,
                        50628980,
                        51815377,
                        50519251,
                        51863634,
                        51906933,
                        6578270,
                        51669445,
                        17116613,
                        51819952,
                        50488871,
                        50462847,
                        51994303,
                        51428829,
                        50212952,
                        6553387,
                        51679767,
                        51886858,
                        51948089,
                        50213862,
                        51874996,
                        51584593,
                        50302919,
                        50212611,
                        51746947,
                        51912877,
                        51912876,
                        50748669,
                        50696979,
                        6540805,
                        50510778,
                        51346800,
                        50238022,
                        6578676,
                        52348553,
                        51906239,
                        51906282,
                        51540928,
                        51147401,
                        51984734,
                        52003827,
                        50890764,
                        50627754,
                        51880914,
                        50654434,
                        51880714,
                        17226454,
                        51028819,
                        50722220,
                        51122486,
                        51984546,
                        50713843,
                        50432294,
                        51930038,
                        51878955,
                        51984569,
                        51118120,
                        51169257,
                        51851286,
                        50494368,
                        51993836,
                        50413056,
                        51430502,
                        51224905,
                        50394629,
                        52001659,
                        51991179,
                        50461095,
                        50204415,
                        51863994,
                        50216478,
                        50762090,
                        51017831,
                        50292365,
                        52348382,
                        51993628,
                        50494298,
                        51814781,
                        51974320,
                        50570452,
                        52001909,
                        52002597,
                        50396556,
                        50497634,
                        17144061,
                        17138625,
                        51976859,
                        51288779,
                        51961689,
                        51961669,
                        51966456,
                        50226125,
                        51667332,
                        51974951,
                        51991180,
                        51994266,
                        51503745,
                        6550667,
                        51851287,
                        51498723,
                        51737653,
                        51984680,
                        51946931,
                        51799594,
                        51993810,
                        51906489,
                        51847460,
                        51667333,
                        50415509,
                        51961690,
                        50414848,
                        50508449,
                        51880177,
                        51886136,
                        51897775,
                        52003670,
                        50209379,
                        51905794,
                        51976860,
                        50242357,
                        51720460,
                        50881893,
                        51979519,
                        50266876,
                        51906488,
                        50218268,
                        50250520)
          and difesape != 0;

 -- Validar si se esta facturando el producto
 Cursor CuValCargos(nuProducto diferido.difenuse%type) Is   
    SELECT count(1)
      FROM cargos
     WHERE cargnuse = nuProducto
       AND cargcuco = -1; 

 nuErrorCode     number;
 sbErrorMessage  varchar2(2000);
 isbDescripcion  notas.notaobse%type := 'Cancela Diferido por Caso OSF-684';
 
 Nudifecodi      diferido.difecodi%type;
 Nudifenuse      diferido.difenuse%type;
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
        -- Inicializamos variables por si hay error
        Nudifecodi := reg.difecodi;
        Nudifenuse := reg.difenuse;
        
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
        
        commit;
        --
    Else
       
      Dbms_Output.put_line('Producto ' || reg.difenuse || '     se esta facturando, tiene cargos a la -1');
        
    End if;      
          
  End Loop;

  Dbms_Output.put_line('Proceso de pasar deuda diferida a presente mes realizado satisfactoriamente.');
   
  Exception
     When others Then
       Rollback;
       Dbms_Output.put_line('Error en proceso Producto ' || Nudifenuse || '  Diferido ' || Nudifecodi || '  ' || sqlerrm);
        
End;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/