column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_inicio from dual;

declare

  SBCOMMENT     VARCHAR2(4000) := 'CASO OSF-2815 - Se elimina exclusion de orden - Fecha final exclusion ';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);

  cursor cuEliminaExclucionOrden is
    select *
      from open.ct_excluded_order
     where order_id in (261270894,
                        261271522,
                        324052261,
                        324052102,
                        324052108,
                        323792384,
                        323490543,
                        323315996,
                        323196984,
                        323087885,
                        321858567,
                        321916333,
                        323192725,
                        322148809,
                        321920148,
                        274719745,
                        274719720,
                        274719717,
                        274719683,
                        274719707,
                        323840574,
                        323840573,
                        323840570,
                        285556538,
                        285556533,
                        285556606,
                        285556531,
                        285556528,
                        285556489,
                        285556495,
                        285556652,
                        285556713,
                        285556593,
                        285556582,
                        285556437,
                        260809762,
                        260809769,
                        260809770,
                        260809725,
                        260809818,
                        239837524,
                        285070504,
                        320430544,
                        320430561,
                        321511749,
                        321841960,
                        321856575,
                        320205522,
                        274719670,
                        274719673,
                        324520838,
                        323840565,
                        318649027,
                        318649042,
                        318649051,
                        318649056,
                        318649066,
                        318649054,
                        318649052,
                        318649060,
                        318649064,
                        318649061,
                        321607816,
                        321920124,
                        318649069,
                        318649075,
                        318649072,
                        318649074,
                        318649079,
                        318649081,
                        318649076,
                        274719694,
                        325348001,
                        322548182,
                        322548238,
                        322548012,
                        322548224,
                        322548214,
                        322548213,
                        322548204,
                        322548191,
                        322548188,
                        322548184,
                        322548179,
                        322548166,
                        322548127,
                        325348096,
                        325348095,
                        325348105,
                        325348094,
                        325348107,
                        325348098,
                        325348108,
                        325348088,
                        325348100,
                        325348016,
                        325348120,
                        325348081,
                        325348113,
                        322548207,
                        322548144,
                        322548153,
                        322548091,
                        322548135,
                        322548139,
                        322548130,
                        322548028,
                        322548021,
                        322548000,
                        322548030,
                        322548230,
                        322548232,
                        322548222,
                        322548218,
                        322548199,
                        322548195,
                        322548192,
                        322548185,
                        322548168,
                        322548164,
                        322548157,
                        322548149,
                        322548123,
                        322548125,
                        322548118,
                        322548116,
                        322548117,
                        322548111,
                        322548115,
                        322548110,
                        322548101,
                        322548103,
                        322548096,
                        322548089,
                        322548078,
                        322548075,
                        322548077,
                        322548070,
                        322548068,
                        322548066,
                        322548064,
                        322548061,
                        322548053,
                        322548057,
                        322548060,
                        322548054,
                        322548049,
                        322548048,
                        322548046,
                        322548044,
                        322548042,
                        322548035,
                        322548022,
                        322548019,
                        322548018,
                        322548017,
                        322548013,
                        322548003,
                        322548002,
                        322548001,
                        322548233,
                        322548228,
                        325043053,
                        322548174,
                        322548169,
                        322548121,
                        322548106,
                        322548209,
                        322548220,
                        322548026,
                        322548147,
                        322548087,
                        322548072,
                        322548047,
                        322548039,
                        322548038,
                        322548173,
                        322548105,
                        322548140,
                        322548094,
                        322548065,
                        322548016,
                        322548141,
                        322548004,
                        324538084,
                        325391391,
                        325525084,
                        325524749,
                        324792976,
                        324792059,
                        324969235,
                        324793718,
                        325406143,
                        325403612,
                        325525227,
                        325419139,
                        325525092,
                        325456982,
                        325348083,
                        325348027,
                        325348071,
                        325348051,
                        325348057,
                        325348068,
                        325348054,
                        325348034,
                        325348089,
                        325348118,
                        325348119,
                        325348012,
                        325348085,
                        325348087,
                        325348112,
                        325348052,
                        325348097,
                        325348104,
                        325348079,
                        325348021,
                        325348038,
                        325348032,
                        325546861,
                        325546699,
                        325348073,
                        325348041,
                        325550748,
                        325348056,
                        325348109,
                        325550756,
                        325348078,
                        325348047,
                        325348040,
                        325348074,
                        325348061,
                        325348011,
                        325348065,
                        325348058,
                        325348090,
                        325348106,
                        325348084,
                        325348116,
                        325348076,
                        325348020,
                        325348059,
                        325550754,
                        325348067,
                        325348102,
                        325348017,
                        325348048,
                        325348115,
                        325550747,
                        325348101,
                        325348045,
                        325348014,
                        325348063,
                        325348024,
                        325348026,
                        325348069,
                        325348042,
                        325348055,
                        325348035,
                        325348070,
                        325550752,
                        325348044,
                        325348064,
                        325348091,
                        325348036,
                        325348092,
                        325348022,
                        325348053,
                        325348028,
                        325348013,
                        325550745,
                        325348110,
                        325550751,
                        325550750,
                        325550749,
                        325348029,
                        325348072,
                        325348086,
                        325348015,
                        325348018,
                        325348031,
                        325348080,
                        325348077,
                        325525052,
                        325456829,
                        325525170,
                        325456447,
                        325456358,
                        325525035,
                        325525011,
                        325417012,
                        325617375,
                        325951894,
                        325951875,
                        325951878,
                        325343587,
                        325343572,
                        325397104,
                        325391304,
                        325601648,
                        325547043,
                        325601655,
                        325547050,
                        325525058,
                        325418736,
                        325525230,
                        325456818,
                        325525135,
                        325524731,
                        325343582,
                        325343626,
                        325041187,
                        325546855,
                        325527804,
                        325042403,
                        325343576,
                        325525192,
                        325457154,
                        325951916,
                        325951340,
                        325040957,
                        325397446,
                        325361296,
                        325343596,
                        325043447,
                        325525251,
                        325456567,
                        325525175,
                        325456165,
                        325395639,
                        325372470,
                        325343610,
                        325045566,
                        325343593,
                        325046601,
                        325343641,
                        325046740,
                        324969245,
                        324805588,
                        325390931,
                        325397512,
                        325378288,
                        325395659,
                        325381230,
                        325395635,
                        325378200,
                        325415752,
                        325408457,
                        325343612,
                        325042629,
                        325406127,
                        325401826,
                        325397479,
                        326312355,
                        326210976,
                        325406152,
                        325405251,
                        325951908,
                        325942077,
                        322548036,
                        322548099,
                        325397494,
                        325394599,
                        325397507,
                        325392827,
                        325951906,
                        325941994,
                        325343648,
                        325176721,
                        324792949,
                        324688186,
                        325406124,
                        325400760,
                        326182507,
                        326107809,
                        326182505,
                        326145696,
                        325406101,
                        325402531,
                        325525038,
                        325418642,
                        325415821,
                        325415092,
                        325406208,
                        325403955,
                        325415837,
                        325409759,
                        325415782,
                        325414886,
                        326312345,
                        326210989,
                        325933835,
                        325759233,
                        325343643,
                        325176794,
                        325343625,
                        325176761,
                        326182495,
                        326107237,
                        326182512,
                        326106703,
                        324792954,
                        324792020,
                        326447793,
                        324681104,
                        324611962,
                        326672187,
                        324519406,
                        325942076,
                        325951911,
                        326312348,
                        325397057,
                        325951876,
                        326211088,
                        325951882,
                        326312340,
                        274719727,
                        326312329,
                        325942087,
                        325941979,
                        324427515,
                        325348030,
                        325348066,
                        326182492,
                        325406215,
                        325406084,
                        325402628,
                        325525079,
                        325419053,
                        325343860,
                        324605818,
                        324681097,
                        324519701,
                        324181874,
                        324066656,
                        326447797,
                        326561165,
                        326563304,
                        326665682,
                        326665689,
                        326563307,
                        326312363,
                        326211077,
                        326312334,
                        326211072,
                        325951919,
                        325942078,
                        325951896,
                        325942085,
                        325951886,
                        325941976,
                        324977024,
                        326106074,
                        325397869,
                        326665674,
                        326561167,
                        326665675,
                        326563300,
                        326182513,
                        326180228,
                        326182511,
                        326106398,
                        325415791,
                        325409316,
                        325409427,
                        325408131,
                        325409424,
                        325407855,
                        326665688,
                        325933816,
                        325406125,
                        325405185,
                        285556592,
                        325406109,
                        325404665,
                        285556676,
                        285556609,
                        326680162,
                        285556665,
                        285556563,
                        285556530,
                        285556488,
                        285556445,
                        285556432,
                        325941993,
                        285556583,
                        285556560,
                        325951884,
                        326312333,
                        326211089,
                        325951885,
                        325941980,
                        325934895,
                        325934891,
                        326843172,
                        325409416,
                        325407105,
                        326447773,
                        326325126,
                        325415787,
                        325409332,
                        325415754,
                        325408685,
                        325415800,
                        325414986,
                        325525189,
                        325418545,
                        325415842,
                        325415402,
                        326182522,
                        326107931,
                        325525136,
                        325416786,
                        325525069,
                        325418244,
                        326561159,
                        325525138,
                        325418062,
                        326190482,
                        273971110,
                        273971071,
                        273971028,
                        273971032,
                        273971034,
                        273971074,
                        273971075,
                        273971080,
                        273971081,
                        273971060,
                        273971115,
                        273971027,
                        273971031,
                        273971037,
                        273971077,
                        273971094,
                        273971096,
                        273971103,
                        273971105,
                        273971108,
                        273971111,
                        273971067,
                        273971112,
                        273971030,
                        273971035,
                        273971039,
                        273971051,
                        273971076,
                        273971085,
                        273971092,
                        273971093,
                        273971058,
                        273971099,
                        273971101,
                        273971104,
                        273971070,
                        273971116,
                        273971040,
                        273971049,
                        273971052,
                        273971084,
                        273971054,
                        273971055,
                        273971057,
                        273971095,
                        273971100,
                        273971065,
                        273971069,
                        273971113,
                        273971029,
                        273971033,
                        273971042,
                        273971047,
                        273971048,
                        273971050,
                        273971073,
                        273971079,
                        273971082,
                        273971086,
                        273971090,
                        273971091,
                        273971053,
                        273971056,
                        273971106,
                        273971062,
                        273971064,
                        273971044,
                        273971078,
                        273971097,
                        273971102,
                        273971109,
                        273971026,
                        273971043,
                        273971046,
                        273971072,
                        273971083,
                        273971087,
                        273971089,
                        273971059,
                        273971098,
                        273971107,
                        273971063,
                        273971066,
                        273971068,
                        273971114,
                        273971036,
                        273971038,
                        273971041,
                        273971045,
                        273971088,
                        273971061,
                        273971120,
                        273971123,
                        273971138,
                        273971121,
                        273971122,
                        273971124,
                        273971125,
                        273971117,
                        273971127,
                        273971134,
                        273971126,
                        273971133,
                        273971118,
                        273971119,
                        273971128,
                        273971129,
                        273971131,
                        273971135,
                        273971130,
                        273971132,
                        273971136,
                        326765889,
                        326766167,
                        325618401,
                        326843169,
                        326669560,
                        326183625,
                        326190473,
                        325933822,
                        325623252,
                        325525010,
                        325416629,
                        325395607,
                        325364452,
                        327122377);

  rfEliminaExclucionOrden cuEliminaExclucionOrden%rowtype;

begin

  for rfEliminaExclucionOrden in cuEliminaExclucionOrden loop
  
    begin
    
      GE_BOCERTIFICATE.DELEXCLUDEORDER(rfEliminaExclucionOrden.Order_id);
    
      --Adicionamos comentario a la OT 
      OS_ADDORDERCOMMENT(rfEliminaExclucionOrden.Order_id,
                         nuCommentType,
                         SBCOMMENT ||
                         rfEliminaExclucionOrden.FINAL_EXCLUSION_DATE,
                         nuErrorCode,
                         sbErrorMesse);
    
      if nuErrorCode = 0 then
        COMMIT;
        dbms_output.put_line('Elimino exclusion de orden ' ||
                            rfEliminaExclucionOrden.Order_id);
      else
        rollback;
        dbms_output.put_line('Error - No se pudo eliminar exclusion de orden ' ||
                             rfEliminaExclucionOrden.Order_id || ' - ' ||
                             sbErrorMesse);
      end if;
    
    exception
      when others then
        rollback;
        dbms_output.put_line('Error - No se pudo eliminar exclusion de orden ' ||
                             rfEliminaExclucionOrden.Order_id || ' - ' ||
                             sqlerrm);
    end;
  
  end loop;

end;
/

select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/