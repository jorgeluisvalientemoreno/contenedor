select oro.order_id Orden_Legalizada,
       oro.related_order_id Orden_Generada,
       oo_generada.task_type_id ||' - '|| ott_generada.description Tipo_Trabajo,
       oo_generada.order_status_id Estado,
       oo_generada.operating_unit_id || ' - ' || oou.name Unidad_operativa
  from open.or_related_order oro
  left join open.or_order oo_generada
    on oo_generada.order_id = oro.related_order_id
  left join open.or_operating_unit oou
    on oou.operating_unit_id = oo_generada.operating_unit_id
  left join open.or_task_type ott_generada
    on ott_generada.task_type_id =  oo_generada.task_type_id
 where oro.order_id in (264369138,
                        280537918,
                        315328075,
                        285693547,
                        291786527,
                        301084115,
                        280537916,
                        288435011,
                        319207984,
                        316663246,
                        299829975,
                        324131699,
                        321856002,
                        288167284,
                        288588117,
                        288653296,
                        318976625,
                        322678468,
                        318668178,
                        269495719,
                        324521471,
                        306589556,
                        271966513,
                        284885404,
                        280521465,
                        319773045,
                        323180367,
                        324793112,
                        323082440,
                        310130993,
                        284260746,
                        280521452,
                        299937022,
                        319772556,
                        324058662,
                        323481082,
                        280538326,
                        283718474,
                        283718460,
                        324621338,
                        311436127,
                        280538176,
                        315470208,
                        322934802,
                        310207975,
                        291618987,
                        322537512,
                        305527873,
                        286502544,
                        310230575,
                        317665347,
                        318056371,
                        298450637,
                        284625518,
                        288548361,
                        317898252,
                        279088966,
                        282411706,
                        313048551,
                        288547546,
                        308988674,
                        308107226,
                        257546123,
                        308501197,
                        320463597,
                        299934439,
                        296618060,
                        320463387,
                        315067043,
                        297622654,
                        326669943,
                        289256235,
                        297070833,
                        288660543,
                        296396680,
                        309406695,
                        317672829,
                        274397556,
                        281015105,
                        301817837,
                        288410899,
                        303558848,
                        313482506,
                        252756326,
                        326848463,
                        288269630,
                        299345902,
                        280538373,
                        322834443,
                        272260806,
                        313980288,
                        283718483,
                        323345938,
                        304019256,
                        284789608,
                        310996219,
                        297345665,
                        326225403,
                        288547270,
                        288319204,
                        288537786,
                        323084388,
                        272435168,
                        296779413,
                        323083165,
                        288547613,
                        314553443,
                        321919412,
                        321284418,
                        319176158,
                        324030159,
                        298849174,
                        315358422,
                        280537982,
                        296044815,
                        302353614,
                        290527971,
                        288279665,
                        317904880,
                        290532609,
                        323083891,
                        288523216,
                        298828164,
                        285859541,
                        281000685,
                        315016581,
                        290701972,
                        288555286,
                        287761304,
                        314637090,
                        288365545,
                        297346616,
                        288546100,
                        318976963,
                        286327818,
                        316661243,
                        286353585,
                        288168122,
                        289984917,
                        323082874,
                        288655386,
                        306400015,
                        318233242,
                        286768858,
                        314555373,
                        322207659,
                        324680190,
                        282223370,
                        289846377,
                        315542025,
                        288650657,
                        288654713,
                        288182876,
                        312123205,
                        263611849,
                        319146937,
                        288355525,
                        312262719,
                        313160379,
                        313160502,
                        288279449,
                        319175455,
                        320489142,
                        317665530,
                        321988467,
                        324523266,
                        292000874,
                        253844624,
                        288176108,
                        284258736,
                        295853383,
                        294396910,
                        281101103,
                        318244438,
                        288277861,
                        323063793,
                        298641098,
                        321850271,
                        297254457,
                        315211322,
                        296215818,
                        311503591,
                        316904000,
                        322677734,
                        281358745,
                        266816144,
                        277964843,
                        280324064,
                        271654746,
                        281012386,
                        271388051,
                        273806969,
                        280021843,
                        280016633,
                        275096065,
                        266476506,
                        277677549,
                        283398009,
                        280538016,
                        283718437,
                        286657954,
                        280521447,
                        279203334,
                        278109998,
                        263466236,
                        274199597,
                        274907730,
                        275842298,
                        270447867,
                        273178476,
                        264318468,
                        264518366,
                        282830058,
                        258516588,
                        280521394,
                        280521251,
                        270568376,
                        285062068,
                        280521274,
                        270407765,
                        279194162,
                        283718391,
                        280521264,
                        284206217,
                        283380530,
                        271636564,
                        280160258,
                        237598731,
                        272262094,
                        279665076,
                        279664926,
                        272439034,
                        271794584,
                        283718377,
                        280521259,
                        280521262,
                        278262380,
                        283718384,
                        237117584,
                        280521263,
                        281899603,
                        280521265,
                        280521267,
                        252754637,
                        280538275,
                        280521453,
                        280521462,
                        283718480,
                        271096806,
                        270442520,
                        280903396,
                        271390322,
                        280538369,
                        280970350,
                        280538333,
                        280521469,
                        280521468,
                        280538051,
                        283238172,
                        274904161,
                        281351329,
                        271386564,
                        280538019,
                        275305345,
                        270604244,
                        281691307,
                        282287724,
                        278771761,
                        280538026,
                        280521348,
                        280538090,
                        284291666,
                        269256581,
                        262857385,
                        284292122,
                        284201401,
                        278437915,
                        276040190,
                        278448858,
                        280798527,
                        280521266,
                        262035452,
                        269258138,
                        239534655,
                        252255082,
                        271817239,
                        262434115,
                        280538292,
                        280538375,
                        283247077,
                        284293067,
                        254399610,
                        265363253,
                        278262345,
                        281382392,
                        280538089,
                        271654551,
                        280537855,
                        282302643,
                        280521272,
                        274201208,
                        283021413,
                        270890155,
                        280538126,
                        272975812,
                        273944616)