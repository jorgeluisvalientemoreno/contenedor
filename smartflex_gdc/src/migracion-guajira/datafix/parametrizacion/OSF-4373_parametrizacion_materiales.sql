column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare


  cursor cuItems is
    with base as(select '10000037' CodMaterial, 'AFV INPIRATOR CONTROL LOOP W/ZSC-100 PIL' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000040' CodMaterial, 'ALICATE UNIVERSAL 8" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000044' CodMaterial, 'PINZA SUJETADORA TERMOFUSION D  1/2" IPS' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000046' CodMaterial, 'PINZA SUJETADORA TERMOFUSION D 1" IPS' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000047' CodMaterial, 'ANILLO FRIO D 2" IPS TERMOFUSION' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000048' CodMaterial, 'PINZA SUJETADORA TERMOFUSION D  3/4" IPS' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000050' CodMaterial, 'ARNES MULTIPROPOSITO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000051' CodMaterial, 'AVISO ACRILICO SENALIZACION' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000072' CodMaterial, 'BISELADOR-CALIBRADOR TUB. D 1/2" IPS PE' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000073' CodMaterial, 'BISELADOR-CALIBRADOR TUB. D 3/4" IPS PE' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000088' CodMaterial, 'BRIDA CIEGA AC FORJADO D 4" ANSI 150 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000096' CodMaterial, 'BRIDA WN AC FORJADO D 4" ANSI 150 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000098' CodMaterial, 'BRIDA WN AC FORJADO D 3" ANSI 150 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000100' CodMaterial, 'BROCA CILINDRICA HSS D 1/16" (1.5MM )' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000119' CodMaterial, 'REDUC BUSH HIERRO GAL D  1/2"x1/4" NPT' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000121' CodMaterial, 'REDUC BUSH ACERO D 3/4"x1/2" NPT' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000122' CodMaterial, 'REDUC BUSH HIERRO GAL D 1-1/2"x1" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000123' CodMaterial, 'REDUC BUSH HIERRO GAL D 1-1/2"x1/2" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000124' CodMaterial, 'REDUC BUSH HIERRO GAL D 1-1/2"x3/4" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000125' CodMaterial, 'REDUC BUSH HIERRO GAL D 1-1/4"x3/4" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000126' CodMaterial, 'REDUC BUSH HIERRO GAL D 1"x1/2" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000127' CodMaterial, 'REDUC BUSH HIERRO GAL D 1"x3/4" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000129' CodMaterial, 'REDUC BUSH HIERRO GAL D  1/2"x3/8" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000130' CodMaterial, 'REDUC BUSH HIERRO GAL D 2"x1-1/2" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000132' CodMaterial, 'REDUC BUSH HIERRO GAL D 2"x3/4" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000133' CodMaterial, 'REDUC BUSH HIERRO GAL D  3/4"x1/2" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000209' CodMaterial, 'CINTA METRICA DE  5mts' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000228' CodMaterial, 'CODO AC SCH40 D 4" X 90 GR RADIO LARGO' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000229' CodMaterial, 'CODO AC SCH40 D 6" X 90 GR RADIO LARGO' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000234' CodMaterial, 'CODO HIERRO GALV D 1-1/2"x90 GR' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000235' CodMaterial, 'CODO HIERRO GALV D 1"x90 GR' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000236' CodMaterial, 'CODO HIERRO GALV D  1/2"x90 GR' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000237' CodMaterial, 'CODO HIERRO GALV D  3/4"x90 GR' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000238' CodMaterial, 'CODO HIERRO GALV D  3/8"x90 GR' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000240' CodMaterial, 'CODO PE80 2" IPS x90 GR RDE11 SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000241' CodMaterial, 'CODO   PE80 3" IPS x90 GR RDE11 TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000242' CodMaterial, 'CODO   PE80 4" IPS x90 GR RDE11 TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000245' CodMaterial, 'CODO AC D 1" X 90 GR 3000 LB ROSCADO' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000246' CodMaterial, 'CODO CALLE HIERRO GALV D 1/2"x90 GR' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000254' CodMaterial, 'CONECTOR CURVO HIERRO GALV DE 3/8"' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000258' CodMaterial, 'CONECTOR LAT D M26X1.5 1-PIEZA 1/2"FLARE' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000261' CodMaterial, 'CONECTOR AC INOX 1/4" OD X 1/8" NPTM' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000263' CodMaterial, 'CONECTOR AC INOX D 1/4" OD x 1/4" NPTM' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000278' CodMaterial, 'COPA LAT (TUERCA CONICA) D 1/2" FLARE' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000297' CodMaterial, 'COPA HIERRO GALV D  1/2"x3/8" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000298' CodMaterial, 'COPA HIERRO GALV D  3/4"x1/2" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000302' CodMaterial, 'PINZA CORTATUBO PE D 1/2" A 1-1/4" IPS' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '262' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000333' CodMaterial, 'DOBLA TUBO COBRE FLEXIBLE D 1/2"' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000341' CodMaterial, 'ELEVADOR VALV LAT D 1/2" CTS X1/4" NPTM' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000345' CodMaterial, 'EMPAQUE FLEXITALICO BRIDA D  2" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000346' CodMaterial, 'EMPAQUE FLEXITALICO BRIDA D  3" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000349' CodMaterial, 'EMPAQUE FLEXITALICO BRIDA D  4" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000368' CodMaterial, 'ESPARRAGO AC GR B7 D 3/4" X 4" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000373' CodMaterial, 'ESTUFA SOBREMESA 2 QUEMADOR GAS NATURAL' DescMaterial,'Z003' TipoMaterial,'UN' UNMedida, '041' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000420' CodMaterial, 'SELLANTE LIQUIDO FUERZA MEDIA' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '182' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000427' CodMaterial, 'ABOCINADOR PARA COBRE' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000432' CodMaterial, 'HOJAS PARA SEGUETA' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000434' CodMaterial, 'HOMBRE SOLO 10" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000474' CodMaterial, 'KIT AISLAMIENTO D  3" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000516' CodMaterial, 'LLAVE DE EXPANSION 10" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000517' CodMaterial, 'LLAVE DE EXPANSION 12" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000521' CodMaterial, 'LLAVE DE EXPANSION  8" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000532' CodMaterial, 'LLAVE MIXTA  3/4" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000536' CodMaterial, 'LLAVE DE TUBO 12" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000540' CodMaterial, 'LLAVE DE TUBO  8" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000541' CodMaterial, 'LLAVE DE TUBO 10" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000549' CodMaterial, 'MANERAL PARA  POLIVALVULA POLIETILENO' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '262' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000571' CodMaterial, 'MANOM 160PSI CAR 2-1/2" REC-INOX VERTICA' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000573' CodMaterial, 'MANOMETRO 30 PSI CAR 2-1/2" RECA- INOX' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000588' CodMaterial, 'MARCO SEGUETA DE 12"' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000589' CodMaterial, 'MARTILLO DE OREJA 2 LB' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000593' CodMaterial, 'MEDIDOR 37 M3H DIAF 30 LT IZQ MAOP 25PSI' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000622' CodMaterial, 'NIPLE GALV D 1/2" X 3" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000634' CodMaterial, 'NIPLE GALV D  1/2" X 4" LONG SCH40' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000636' CodMaterial, 'NIPLE GALV D 3/4"x2" LONG SCH40' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000637' CodMaterial, 'NIPLE GALV D 3/4" X 3" LONG SCH40' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000638' CodMaterial, 'NIPLE GALV D 3/4" X 4" LONG SCH40' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000640' CodMaterial, 'NIPLE GALV D 3/4" X 6" LONG SCH40' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000667' CodMaterial, 'ALICATE CORTAFRIO DE 6"' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000680' CodMaterial, 'VALVULA PE80 D 2" IPS RDE11 TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '005' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000681' CodMaterial, 'VALVULA   PE80 D 1" IPS SOCKET RDE 11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '005' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000682' CodMaterial, 'VALVULA   PE80 D  1/2" IPS SOCKET RDE 9' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '005' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000683' CodMaterial, 'VALVULA PE80 D  3/4" IPS SOCKET RDE11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '005' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000698' CodMaterial, 'PRENSA CIERRE MECANICA PE D 1"- 4"' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000700' CodMaterial, 'PRENSA CIERRE HIDRAULICA PE D 2"- 6"' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000717' CodMaterial, 'RACOR LAT D 1/2" FLARE X 1/2" NPT' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000728' CodMaterial, 'REDUCCION CONCENTRICA AC SCH40 4" X 3"' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000729' CodMaterial, 'REDUCCION CONCENTRICA AC SCH40 3" X 2"' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000734' CodMaterial, 'REDUC. PE80 D 3"IPS x2"IPS RDE11 TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000735' CodMaterial, 'REDUC PE80 D  3/4" IPS x 1/2" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000736' CodMaterial, 'REDUC PE80 D 4" IPS x 2" IPS RDE 11 TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000737' CodMaterial, 'REDUC. PE80 D 4"IPS x3"IPS RDE 11 TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000743' CodMaterial, 'REGULADOR 100 M3H 135 PSI CONEX D 1"' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000757' CodMaterial, 'REGULADOR  40 M3H 25 PSI CD 3/4"NPTH-180' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000766' CodMaterial, 'REGULA 38 M3H 80 PSI CD 3/4" NPTH PE R10' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000805' CodMaterial, 'SILLETA PE80 D 3" x1"IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000806' CodMaterial, 'SILLETA PE80 D 2" IPS x3/4"IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000807' CodMaterial, 'SILLETA PE80 D 3" IPS x3/4"IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000808' CodMaterial, 'SILLETA PE80 D 4" IPS x3/4"IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000824' CodMaterial, 'TAPA PLASTICA SEÑALIZACION 15 CM DIAM' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000828' CodMaterial, 'TAPON   PE80 D   1/2" CTS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000833' CodMaterial, 'TAPON HIERRO GALV D 3/4" NPT HEMBRA' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000836' CodMaterial, 'TAPON AC D 1/2" NPTM X 3000 LB ROSCADO' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000841' CodMaterial, 'TAPON HIERRO GALV D 1/2" NPT MACHO' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000844' CodMaterial, 'TAPON   PE80 D   1/2" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000845' CodMaterial, 'TAPON   PE80 D  2" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000846' CodMaterial, 'TAPON   PE80 D  3" IPS TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000847' CodMaterial, 'TAPON   PE80 D   3/4" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000848' CodMaterial, 'TAPON PE80 D 4" IPS TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000860' CodMaterial, 'TEE AC SCH40 D 2" PARA SOLDAR' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000866' CodMaterial, 'TEE HIERRO GALV D 1-1/2" NPT HEMBRA' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000867' CodMaterial, 'TEE HIERRO GALV D 1" NPT HEMBRA' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000868' CodMaterial, 'TEE HIERRO GALV D  1/2" NPT HEMBRA' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000869' CodMaterial, 'TEE HIERRO GALV D  3/4" NPT HEMBRA' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000871' CodMaterial, 'TEE PE80 D 1/2" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000872' CodMaterial, 'TEE PE80 D 2" IPS TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000874' CodMaterial, 'TEE   PE80 D  3/4" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000875' CodMaterial, 'TEE RED PE80 D 3/4" X 1/2" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000876' CodMaterial, 'TEE PE80 D 4" IPS TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000879' CodMaterial, 'TEE RED PE80 D 1/2" IPSx1/2" CTS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000880' CodMaterial, 'TEE RED PE80 D 3/4" IPSx1/2" CTS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000911' CodMaterial, 'TUBERIA ACERO GALV SCH40 D 1-1/2" NPT-M' DescMaterial,'Z002' TipoMaterial,'M' UNMedida, '021' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000912' CodMaterial, 'TUBERIA ACERO GALV SCH40 D 1" NPT-M' DescMaterial,'Z002' TipoMaterial,'M' UNMedida, '021' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000913' CodMaterial, 'TUBERIA ACERO GALV SCH40 D  1/2" NPT-M' DescMaterial,'Z002' TipoMaterial,'M' UNMedida, '021' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000914' CodMaterial, 'TUBERIA ACERO GALV SCH40 D  3/4" NPT-M' DescMaterial,'Z002' TipoMaterial,'M' UNMedida, '021' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000924' CodMaterial, 'TUBERIA PE80  1/2" CTS RDE7 AMARILLA MD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000925' CodMaterial, 'TUBERIA COBRE D 1/2" FLEXIBLE OD E0.032' DescMaterial,'Z008' TipoMaterial,'M' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000930' CodMaterial, 'TUBERIA PE80  1/2" IPS RDE9 AMARILLA MD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000931' CodMaterial, 'TUBERIA PE80 2" IPS RDE11 AMARILLA MD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000932' CodMaterial, 'TUBERIA PE80 3" IPS RDE11 AMARILLA MD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000933' CodMaterial, 'TUBERIA PE80  3/4" IPS RDE11 AMARILLA MD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000934' CodMaterial, 'TUBERIA PE80 4" IPS RDE11 AMARILLA MD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000935' CodMaterial, 'TUBERIA PE80 6" IPS RDE11 AMARILLA MD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000936' CodMaterial, 'TUBERIA PE80 1" IPS RDE11 AMARILLA MD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000937' CodMaterial, 'TUBING AC INOX D 1/4" OD X 0.035" ESP' DescMaterial,'Z013' TipoMaterial,'M' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000939' CodMaterial, 'TUBING AC INOX D 1/2" OD X 0.035" ESP' DescMaterial,'Z013' TipoMaterial,'M' UNMedida, '241' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000946' CodMaterial, 'UNION SIMPLE AC D 1" NPTH X 3000 LB ROSC' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000947' CodMaterial, 'UNION PE80 D  1/2"  CTS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000963' CodMaterial, 'UNION SIMPLE HIERRO GALV D 1-1/2" NPTH' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000964' CodMaterial, 'UNION SIMPLE HIERRO GALV D  1/2" NPTH' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000965' CodMaterial, 'UNION SIMPLE HIERRO GALV D  3/4" NPTH' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000966' CodMaterial, 'UNION SIMPLE HIERRO GALV D   3/8" NPTH' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000967' CodMaterial, 'UNION PE80 D  1/2" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000968' CodMaterial, 'UNION PE80 D 2" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000970' CodMaterial, 'UNION PE80 D 3" IPS ELECTROFUSION' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '004' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000971' CodMaterial, 'UNION PE80 D  3/4" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000972' CodMaterial, 'UNION PE80 D 4" IPS ELECTROFUSION' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '004' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000974' CodMaterial, 'UNION PE80 D 1" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000985' CodMaterial, 'VALVULA CR D  1/2" FLARE-M  X FLARE-M' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000990' CodMaterial, 'VALVULA CR D  1/2" NPT-Hx150 LB' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000993' CodMaterial, 'VALVULA BOLA FLANCHADA AC D 3" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10000995' CodMaterial, 'VALVULA BOLA FLANCHADA AC D 4" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001007' CodMaterial, 'VALVULA CR D  3/4" NPT-Hx150 LB' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001051' CodMaterial, 'UNION SIMPLE HIERRO GALV D 1" NPTH' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001055' CodMaterial, 'CODO AC SCH40 D 3" X 90 GR RADIO LARGO' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001088' CodMaterial, 'BRIDA WN AC FORJADO D 2" ANSI 150 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001089' CodMaterial, 'BRIDA WN AC FORJADO D  3" ANSI 600 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001090' CodMaterial, 'BRIDA WN AC FORJADO D2" ANSI 600 RF SC40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001101' CodMaterial, 'CODO  PE100 D110 MM x90 GR RDE11 TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001118' CodMaterial, 'EMPAQUE FLEXITALICO BRIDA D  2" ANSI 300' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001134' CodMaterial, 'LLAVE MIXTA 7/8" LONG STANLEY' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001146' CodMaterial, 'MANOMETRO 100 PSI CARA 4-1/2" RECA-INOX' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001165' CodMaterial, 'ZSC-320-100 PILOTO REGULADOR AMCO' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001175' CodMaterial, 'REDUC. PE80 D  1/2"IPS x1/2" CTS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001185' CodMaterial, 'SILLETA PE80 D 3" IPS x1/2"IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001188' CodMaterial, 'TAPON PE100 D 4" IPS RDE 11TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001189' CodMaterial, 'TEE AC D 1" X 3000 LB ROSCADA' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001194' CodMaterial, 'TERMOMETRO 100 A 650 G.F. MARCA CENTRAL' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001217' CodMaterial, 'CODO AC SCH40 D 2" X 90 GR RADIO LARGO' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001225' CodMaterial, 'TEE   PE80 D 1" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001226' CodMaterial, 'REDUC. PE80 D 1" IPS x3/4" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001227' CodMaterial, 'TAPON   PE80 D  1" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001228' CodMaterial, 'REDUC. PE80 D 2"IPS x1"IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001236' CodMaterial, 'TEE RED PE80 D 1" x 3/4" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001237' CodMaterial, 'BRIDA ROSCADA AC FORJADO D 2" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001238' CodMaterial, 'SILLETA PE80 D 4" IPS x1"IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001244' CodMaterial, 'SILLETA PE80 D 2" IPS x1/2"IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001247' CodMaterial, 'SILLETA PE80 D 4" IPS x1/2"IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001252' CodMaterial, 'TEE AC SCH40 D 6" PARA SOLDAR' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001253' CodMaterial, 'BRIDA WN AC FORJADO D  6" ANSI 150 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001254' CodMaterial, 'TAPON AC D 3/4" NPTM X 3000 LB' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001283' CodMaterial, 'PENDON' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001289' CodMaterial, 'VALVULA PE80 D 4" IPS RDE11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '005' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001290' CodMaterial, 'TEE AC SCH40 D 4" PARA SOLDAR' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001308' CodMaterial, 'CONECTOR AC INOX 1/2" OD X 1/2" NPTM' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001315' CodMaterial, 'PINZA SUJETADORA TERMOFUSION D  1/2" CTS' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001393' CodMaterial, 'MEDIDOR  85 M3H ROT 12Bar ANSI150 G65 ID' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10001403' CodMaterial, 'ESPARRAGO AC GR B7 D 5/8" X 4-1/2" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001409' CodMaterial, 'TEE   PE80 D 3" IPS TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001429' CodMaterial, 'VALVULA   PE80 D 3" IPS RDE11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '005' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001478' CodMaterial, 'GAFAS PROTECTORAS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001481' CodMaterial, 'MOUSE  OPTICO USB' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001497' CodMaterial, 'VALVULA BOLA FLANCHADA AC D 2" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001505' CodMaterial, 'MALETIN ESTILO MORRAL PARA PORTATIL' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001506' CodMaterial, 'TUBERIA PE100 110 MM RDE11 NARANJA AD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001519' CodMaterial, 'CAJA GRANDE PARA HERRAMIENTAS' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001550' CodMaterial, 'CAMISA MANGA LARGA  LINO OXFORD' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001659' CodMaterial, 'TUBERIA PE100 160 MM RDE11 NARANJA AD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001664' CodMaterial, 'CODO  PE100 D160 MM x90 GR RDE11 TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001665' CodMaterial, 'TEE  PE100 D 160 MM TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001685' CodMaterial, 'CONECTOR CIEGO LAT D M26 X1.5 1-PIEZA' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001694' CodMaterial, 'VALVULA  PE100 D 160 MM RDE11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '005' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001700' CodMaterial, 'BOLSO TERMICO' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001707' CodMaterial, 'TECLADO USB' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001743' CodMaterial, 'REDUCCION PE100 D 160 X  90 MM RDE11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001744' CodMaterial, 'REDUCCION PE100 D  90 X  63 MM RDE 11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001745' CodMaterial, 'UNION PE100 D 90 MM  ELECTROFUSION' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '004' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001801' CodMaterial, 'REDUCCION PE100 D 110  X 63 MM RDE 11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001802' CodMaterial, 'TEE  PE100 D 110 MM TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001815' CodMaterial, 'VALVULA  PE100 D  63 MM RDE11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '005' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001844' CodMaterial, 'REGULADOR  70 M3H 125 PSI CD 1-1/4" NPTH' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001858' CodMaterial, 'REDUCCION CONCENTRICA AC SCH40 4" X 2"' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001876' CodMaterial, 'VALVULA PEALPE 1216 (CR D 1/2")' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001877' CodMaterial, 'VALVULA PEALPE 1216 x1/2" NPT HEMBRA' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001878' CodMaterial, 'CODO PEALPE 1216 (D 1/2)' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001879' CodMaterial, 'TEE PEALPE 1216  (D 1/2")' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001880' CodMaterial, 'CODO PEALPE 1216 x1/2" NPT HEMBRA' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001881' CodMaterial, 'UNION PEALPE 1216 x1/2" NPT MACHO' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001882' CodMaterial, 'UNION PEALPE 1216 (D 1/2")' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001883' CodMaterial, 'TEE PEALPE 1216 x1/2" NPT HEMBRA' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001884' CodMaterial, 'UNION PEALPE 1216 x1/2" NPT HEMBRA' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001889' CodMaterial, 'DOBLA TUBO EXTERNO TUBERIA PE-AL-PE 1216' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001903' CodMaterial, 'ELEVADOR LAT D 1/2" IPS X 1/2" NPTM' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001909' CodMaterial, 'ELEVADOR HIERRO GAL D 1" IPS x1" NPTM' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '144' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001941' CodMaterial, 'VALVULA BOLA AC INOX D 1/4" ODX 1500 PSI' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001948' CodMaterial, 'CODO  PE100 D 63MM x90 GRADOS RDE11 TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001954' CodMaterial, 'DOBLA TUBO INTERNO PARA PE-AL-PE D 1216' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001972' CodMaterial, 'ESPARRAGO AC GR B7 D 5/8" X 3-1/4" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001979' CodMaterial, 'VALVULA BOLA FLANCHADA AC D 6" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001993' CodMaterial, 'VALVULA BOLA FLANCHADA AC D 2" ANSI 600' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10001994' CodMaterial, 'REGULADOR  2 M3H 20-60 PSI CD 1/4" NPTH' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '102' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002000' CodMaterial, 'CINTA REFLECTIVA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002007' CodMaterial, 'CONECTOR AC INOX D 1/4" OD x 1/2" NPTM' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002011' CodMaterial, 'MEDIDOR   6 M3H DIAF (G-4) M26x1.5 IZQ' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10002017' CodMaterial, 'MEDIDOR  16 M3H DIAF 10 LT IZQ 10 PSI' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10002023' CodMaterial, 'MALETIN ESTILO MORRAL' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002055' CodMaterial, 'TUBERIA AC D  2" API 5LX42 S/C SCH40' DescMaterial,'Z004' TipoMaterial,'M' UNMedida, '061' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002060' CodMaterial, 'VALVULA  PE100 D  90 MM RDE11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '005' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002082' CodMaterial, 'UNION PEALPE 1216 x1/2" FLARE MACHO' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002106' CodMaterial, 'MEDIDOR  25 M3H DIAF (G16) 30 LT 25 PSIG' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10002242' CodMaterial, 'MALETIN PORTATIL EJECUTIVO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '287' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002466' CodMaterial, 'ARTICULOS PUBLICITARIOS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002478' CodMaterial, 'EMPAQUE CONECTOR M26x1.5 1PZA FLARE NEOP' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002664' CodMaterial, 'TEE  PE100 D  90 MM SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002721' CodMaterial, 'VALVULA CR D 1" NPT-Hx125 PSI' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002762' CodMaterial, 'REDUCCION CONCENTRICA AC SCH40 6" X 4"' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002797' CodMaterial, 'REGULADOR   2,5 M3H MAOP CD 1/2"NPTH-180' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002823' CodMaterial, 'EMPAQUE BRIDA D 2" ANSI 150 (ESP 1/16)' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002824' CodMaterial, 'EMPAQUE BRIDA D 3" ANSI 150 (ESP 1/16)' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002825' CodMaterial, 'EMPAQUE BRIDA D 4" ANSI 150 (ESP 1/16)' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002826' CodMaterial, 'EMPAQUE BRIDA D 2" ANSI 300 ESP 1/16' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002885' CodMaterial, 'CONECTOR AC INOX 1/4" OD X 1/4" NPTH' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '287' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10002996' CodMaterial, 'SILLETA PE80 D 2"X1" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003082' CodMaterial, 'UNION UNIV GALV D  3/4" NPT-H ASIENTO P' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003135' CodMaterial, 'REJILLA METALICA EN VARILLA GALVANIZADA' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003192' CodMaterial, 'VALVULA  PE100 D 110 MM RDE11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '005' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003194' CodMaterial, 'REDUCCION PE100 D 160 X 110 MM RDE 11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003404' CodMaterial, 'BISELADOR-CALIBRADOR TUB. D 1/2" CTS PE' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003634' CodMaterial, 'REDUCCION PE100 D 110 X 90 MM RDE 11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003635' CodMaterial, 'TAPON  PE100 D  90 MM RDE11 TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003724' CodMaterial, 'VALVULA CHEQUE D 1/4" OD' DescMaterial,'Z011' TipoMaterial,'UN' UNMedida, '206' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003727' CodMaterial, 'FERRULES (JUEGO) AC INOX D 1/2" OD' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003774' CodMaterial, 'UNION RECTA AC INOX D 1/2" OD' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003783' CodMaterial, 'TUBERIA AC D 12" API 5L X42 E=0.406' DescMaterial,'Z004' TipoMaterial,'M' UNMedida, '061' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003869' CodMaterial, 'MERCADO BASICO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003891' CodMaterial, 'UNIFORME DEPORTIVO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003909' CodMaterial, 'CALZADO DOTACION' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003930' CodMaterial, 'DESCANSAPIES' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003931' CodMaterial, 'BASE PARA MONITOR' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003952' CodMaterial, 'LICENCIA SOFTWARE' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10003996' CodMaterial, 'GORRAS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004070' CodMaterial, 'MEDIDOR 2.5 M3H (G-1.6) M26x1.5 IZQ-SE.' DescMaterial,'Z005' TipoMaterial,'UN' UNMedida, '082' GRArticulos, 19 IVA, '' Bloqueado, '' TipoValora, 'X' EsSerial from dual union all
    select '10004097' CodMaterial, 'TELEFONO ANALOGO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004115' CodMaterial, 'CAMISETA TIPO POLO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004226' CodMaterial, 'ACOPLE RAPIDO NPT M AC INOX CUERPO 1/2"' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004232' CodMaterial, 'ADAPTADOR BRIDA PE100 D 4" IPS X 6" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '006' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004234' CodMaterial, 'ADAPTADOR BRIDA PE100 D 6" IPS X 8" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '006' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004242' CodMaterial, 'BATERIA 12V - 26 A/H SELLADA LIBRE MNTO.' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004257' CodMaterial, 'BRIDA WN AC FORJADO D  4" ANSI 600 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004269' CodMaterial, 'BRIDA SLIP-ON AC FORJADO D 3" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004271' CodMaterial, 'BRIDA SLIP-ON AC FORJADO D4" ANSI 150 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004272' CodMaterial, 'BRIDA SLIP-ON AC FORJADO D6" ANSI 150 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004281' CodMaterial, 'CAP AC CARBON D 12" SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004283' CodMaterial, 'CINTA PREVENTIVA RED DE GAS ANCHO 15CM' DescMaterial,'Z015' TipoMaterial,'KG' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004285' CodMaterial, 'CODO HIERRO GALV D 1-1/4" X 90 GR' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004286' CodMaterial, 'CODO HIERRO GALV D 2" X 90 GR' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004290' CodMaterial, 'CODO PE100 D 4" IPS TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004291' CodMaterial, 'CODO PE100 D 6" IPS TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004309' CodMaterial, 'CONECTOR CIEGO LAT D M26 X1.5 2-PIEZAS' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004317' CodMaterial, 'CONECTOR FLEXOMETALICO 1/2" x48" AC INOX' DescMaterial,'Z007' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004319' CodMaterial, 'CONECTOR LAT D M26X1.5 2-PIEZAS' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004330' CodMaterial, 'ELEVADOR HIERRO GAL D 2" IPS x2" NPTM' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '144' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004332' CodMaterial, 'ELEVADOR LAT D 1/2" CTS X 3/8" NPTM' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004339' CodMaterial, 'KIT AISLAMIENTO D  2" ANSI 600' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004344' CodMaterial, 'EMPAQUE BRIDA D 6" ANSI 150 ESP 1/16"' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004367' CodMaterial, 'ESPARRAGO AC GR B7 D 5/8" X 3-3/4" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004368' CodMaterial, 'ESPARRAGO AC GR B7 D 5/8" X 4-1/4" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004369' CodMaterial, 'ESPARRAGO AC GR B7 D 5/8" X 5-1/4" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004372' CodMaterial, 'ESPUMA CILINDRICA D 4.375" LONG 7.25"' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004386' CodMaterial, 'CINCEL 3/4" D X 12" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004398' CodMaterial, 'DESTORNILLADOR ESTRIA 1/4" D X 8" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004401' CodMaterial, 'DESTORNILLADOR PALA 1/4" D X 6" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004421' CodMaterial, 'BISELADOR PARA TUB. PE-AL-PE 1216' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004424' CodMaterial, 'PORTABROCA MANUAL DE DOBLE PUNTA' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004430' CodMaterial, 'MANOMETRO 300 PSI CARA 2-1/2" RECA-INOX' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004431' CodMaterial, 'MANOMETRO 3000 PSI CAR 2-1/2"RECA-INOX.' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004434' CodMaterial, 'MANOMETRO 0-100 PSI RECA CARA D 4"' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004435' CodMaterial, 'MANOMETRO 0-200 PSI RECA CARA D 4-1/2"' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004452' CodMaterial, 'NIPLE GALV D 1" X10" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004453' CodMaterial, 'NIPLE GALV D 1" X 2" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004456' CodMaterial, 'NIPLE GALV D 1" X 4" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004458' CodMaterial, 'NIPLE GALV D 1" X 6" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004460' CodMaterial, 'NIPLE GALV D 1" X 8" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004463' CodMaterial, 'NIPLE GALV D 1-1/2" X 3" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004465' CodMaterial, 'NIPLE GALV D 1-1/2" X 6" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004470' CodMaterial, 'NIPLE GALV D 1-1/4" X 3" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004472' CodMaterial, 'NIPLE GALV D 1-1/4" X 4" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004473' CodMaterial, 'NIPLE GALV D 1-1/4" X 5" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004478' CodMaterial, 'NIPLE GALV D  1/2" X10" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004481' CodMaterial, 'NIPLE GALV D 1/2" X 6" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004483' CodMaterial, 'NIPLE GALV D  1/2" X 8" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004485' CodMaterial, 'NIPLE GALV D 2" X 10" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004487' CodMaterial, 'NIPLE GALV D 2" X  4" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004489' CodMaterial, 'NIPLE GALV D 2" X  6" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004491' CodMaterial, 'NIPLE GALV D 2" X  8" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004498' CodMaterial, 'NIPLE GALV D 3/4" X 8" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004510' CodMaterial, 'MERCAPTANO. 80% TBM, 20% MES. 6.7 LB/GAL' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '284' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004512' CodMaterial, 'RACOR LAT D 1/2" FLARE X  3/8" NPT-M' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004513' CodMaterial, 'RACOR LAT D 1/2" NPT X  1/4" NPT' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004514' CodMaterial, 'RACOR LAT D  1/4" X 3/8" NPT' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004515' CodMaterial, 'RACOR LAT D  3/8" FLARE X 3/8" NPT M' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004518' CodMaterial, 'REDUC BUSH ACERO D 1"x1/2" NPT 3000 LB' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004524' CodMaterial, 'REDUC BUSH HIERRO GAL D 1-1/2"x1-1/4"NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004525' CodMaterial, 'REDUC BUSH HIERRO GAL D 1-1/4"x1" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004526' CodMaterial, 'REDUC BUSH HIERRO GAL D 1-1/4"x1/2" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004527' CodMaterial, 'REDUC BUSH HIERRO GAL D 2" x 1" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004528' CodMaterial, 'REDUC BUSH HIERRO GAL D 2" x 1-1/4" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004529' CodMaterial, 'REDUC BUSH HIERRO GAL D 2" x 1/2" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004544' CodMaterial, 'REDUCCION PE100 D 6" X 4" IPS TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004545' CodMaterial, 'REDUC. PE80 D 1" IPS x1/2" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004550' CodMaterial, 'REDUC. PE80 D 3/4" IPS X 1/2" CTS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004554' CodMaterial, 'REGULADOR ESTABILIZADOR PRESION 10 M3/H' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004558' CodMaterial, 'REGULADOR  15 M3/H CONEXION 3/4" NPTF-18' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004697' CodMaterial, '22GF88 ELEMENTO FILTRANT D 6.5 X 88CM AP' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004902' CodMaterial, 'SILLETA AUTOPER PE80 D 3"X3/4" IPS TERM' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004910' CodMaterial, 'SOCKET D  1/2" CTS, SDR7 TERMOFUSION' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004911' CodMaterial, 'SOCKET D  1/2" IPS, SDR9,3 TERMOFUSION' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004912' CodMaterial, 'SOCKET D 2" IPS, SDR11 TERMOFUSION' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004913' CodMaterial, 'SOCKET D  3/4" IPS, SDR11 TERMOFUSION' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004916' CodMaterial, 'SOCKET D 4" IPS. SDR11 TERMOFUSION' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004925' CodMaterial, 'TAPON LAT D 1/2" FLARE-M X26,90MM LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004931' CodMaterial, 'TAPON HIERRO GALV D 3/8" NPT MACHO' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004935' CodMaterial, 'TAPON PE100 D 6" IPS TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004937' CodMaterial, 'TEE ACERO INOX 1/4" X 1/4" X 1/4" OD' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004939' CodMaterial, 'TEE AC D 1/2" X 3000 LB ROSCADA' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004943' CodMaterial, 'TEE HIERRO GALV D 1-1/4" NPT-H X 150 LB' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004944' CodMaterial, 'TEE HIERRO GALV D 2" NPT-H X 150 LB' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004949' CodMaterial, 'TEE PE100 D 4" IPS TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004950' CodMaterial, 'TEE PE100 D 6" IPS TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004951' CodMaterial, 'TEE  PE80 D 1" X 1/2" X 1" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004957' CodMaterial, 'TERMOPOZO 1/2" NPTH INT X 3/4" NPTM EXT' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '222' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004972' CodMaterial, 'TUBERIA ACERO GALV SCH40 D 2" NPT-M' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '021' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004974' CodMaterial, 'TUBERIA PE100 D 6" IPS RDE11 NARANJA AD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004980' CodMaterial, 'UNION LATON D 1/2" FLARE SIN TUERCA' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004984' CodMaterial, 'UNION PE100 D 4" IPS ELECTROFUSION' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004985' CodMaterial, 'UNION PE100 D 6" IPS ELECTROFUSION' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004990' CodMaterial, 'UNION PE80 D 3" IPS SOCKET AMARILLO' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004991' CodMaterial, 'UNION PE80 D 4" IPS SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004993' CodMaterial, 'UNION SIMPLE HIERRO GALV D 1-1/4" NPTH' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004994' CodMaterial, 'UNION SIMPLE HIERRO GALV D 2" NPTH' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10004997' CodMaterial, 'UNION UNIVERSAL AC D 1" X 3000#' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005000' CodMaterial, 'UNION UNIV GALV D 2" NPT-H ASIENTO P' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005003' CodMaterial, 'VALV AGUJA AC INOX D 1/2" X 4000 NPTMH' DescMaterial,'Z011' TipoMaterial,'UN' UNMedida, '206' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005009' CodMaterial, 'VALVULA CR D 1-1/2" NPT-H' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005010' CodMaterial, 'VALVULA CR D 1-1/4" NPT-H' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005013' CodMaterial, 'VALVULA CR D 2" NPTH X 150 LB' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005014' CodMaterial, 'VALVULA CR D   3/8" NPT-H' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005015' CodMaterial, 'VALVULA CR D   3/8" NPT-H X 1/4" NPT-M' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005019' CodMaterial, 'VALVULA GLOBO ROSC D1" X 800-1500 PSI' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '203' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005037' CodMaterial, 'PANEL SOLAR 130W 12V' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005107' CodMaterial, 'CODO  PE100 D 90 MM' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005150' CodMaterial, 'FERRULES (JUEGO) AC INOX D 1/4" OD' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005171' CodMaterial, 'MANOMETRO  0-15 PSI CARAT. 4"' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005188' CodMaterial, 'MEDID 40 M3H ROT 20 BAR ANSI 150 G25 EP' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005189' CodMaterial, 'MEDIDOR  65 M3H ROT 16BAR ANSI150 G40 EP' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10005352' CodMaterial, 'BROCA CILINDRICA HSS D 3/64" (1.2MM )' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005354' CodMaterial, 'CAJA ARCHIVO 35-14' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005403' CodMaterial, 'CORRECTOR DE FLUJO EAGLE S-INDEX 0-100/0' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '083' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005412' CodMaterial, 'CORTA TUBO DE TUB COBRE D 1/8" A 1-1/8"' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '262' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005454' CodMaterial, 'LAPICEROS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005502' CodMaterial, 'PINZA MECANICA MACHO SOLO 1/2"- 3/4" IPS' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005534' CodMaterial, 'SILLETA AUTOPER PE80 D 4"X3/4" IPS TERM' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005701' CodMaterial, 'SILLETA AUTOPER PE80 D 2"X3/4" IPS TERM' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005800' CodMaterial, 'TUBERIA ACERO GALV SCH40 D 1-1/4" X 6M' DescMaterial,'Z002' TipoMaterial,'M' UNMedida, '021' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005818' CodMaterial, 'COPA LAT (TUERCA CONICA) D 3/8" FLARE' DescMaterial,'Z008' TipoMaterial,'UN' UNMedida, '141' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005916' CodMaterial, 'BOLIGRAFO TINTA NEGRA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005991' CodMaterial, 'CINTA ADHESIVA TRANSPARENTE 2" 48x40' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10005997' CodMaterial, 'CINTA ENMASCARAR DE 1-1/2 CMS HIGHLAND' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006009' CodMaterial, 'CONECTOR FLEXIBLE  5/16" x1MT LONG' DescMaterial,'Z007' TipoMaterial,'UN' UNMedida, '121' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006013' CodMaterial, 'DESINFECTANTE X 960CC PINOLINA LAVANDA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006017' CodMaterial, 'DETERGENTE EN POLVO X250GR' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006111' CodMaterial, 'JABON LIQUIDO X 800CC FAMILIA 8008' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006112' CodMaterial, 'JABON LIQUIDO X 5LTS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006113' CodMaterial, 'JEAN PRE-LAVADO CONTRATISTA AZUL INDIGO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006114' CodMaterial, 'LAPIZ 2B PENTEL' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006132' CodMaterial, 'MANOMETRO  0-60 PSI CAR 2-1/2" NO CALIB' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006146' CodMaterial, 'NOTAS ADHESIVAS POST-IT 6540' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006147' CodMaterial, 'NOTAS ADHESHIVAS POST-IT 653' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006155' CodMaterial, 'PAPEL CARTA BOND 75 GR TROQUELADO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006157' CodMaterial, 'PAPEL HIGIENICO JUMBO DOBLE X250MT' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006162' CodMaterial, 'PAPEL PARA PLOTTER BOND 75 GR 42" X 50MT' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006219' CodMaterial, 'TINTA 51644M PARA PLOTTER HP 750' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006239' CodMaterial, 'TONER CE505A IMPRESORA LASERJET HP P2035' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006289' CodMaterial, 'CARA PLANA PARA CALENTADOR 2SW' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006290' CodMaterial, 'CARA PLANA PARA CALENTADOR 4SW BUTT FUSI' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006324' CodMaterial, 'CODO   PE80  1/2" IPS' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006325' CodMaterial, 'CODO   PE80  3/4" IPS' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006391' CodMaterial, 'MEDIDOR 4 M3/H, (G-2.5) M26X1.5 IZQ-SE' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10006401' CodMaterial, 'TUBERIA PEALPE 1216 (D 1/2") BLANCA' DescMaterial,'Z009' TipoMaterial,'M' UNMedida, '162' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006479' CodMaterial, 'TERMOSWITCH CALENTADOR 2SW -55EB00047' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006480' CodMaterial, 'TERMOSWITCH CALENTADOR 4SW -556EB0400020' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006530' CodMaterial, 'DOBLA TUBO PE-AL-PE D 1/2"  BENDING TOOL' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '262' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006545' CodMaterial, 'TUBERIA PE100 D 4" IPS RDE11 NARANJA AD' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006554' CodMaterial, 'REGULADOR SOLAR 6 AMP 12/24 VDC' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006570' CodMaterial, 'MANOMETRO   30" WC RECA- INO CAR 2-1/2"' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006585' CodMaterial, 'UNION PEALPE 2025 x3/4 NPT MACHO' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006603' CodMaterial, 'PANTALON JEAN INDIGO PRE-LAVADO OPERARIO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006626' CodMaterial, 'LICORES' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006627' CodMaterial, 'MECATOS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006649' CodMaterial, 'JUGUETES' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006650' CodMaterial, 'REGALO INSTITUCIONAL' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006674' CodMaterial, 'INSECTICIDA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006726' CodMaterial, 'UNIFORME DOTACION' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006747' CodMaterial, 'GASOLINA' DescMaterial,'Z015' TipoMaterial,'GLN' UNMedida, '284' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006748' CodMaterial, 'ACPM' DescMaterial,'Z015' TipoMaterial,'GLN' UNMedida, '284' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006763' CodMaterial, 'GAS NATURAL VEHICULAR' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '284' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006766' CodMaterial, 'ACEITES Y LUBRICANTES' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '284' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006846' CodMaterial, 'ARTICULOS PARA DECORACION' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006848' CodMaterial, 'ELEVADOR HIERRO GALV D3/4" IPSX3/4" NPTM' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '144' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006868' CodMaterial, 'ESPUMA CILINDRICA D 2.25" LONG. 3.75"' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006869' CodMaterial, 'ESPUMA CILINDRICA D 3.25" LONG. 5.5"' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006870' CodMaterial, 'SOCKET D 1" IPS, SDR11 TERMOFUSION' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006938' CodMaterial, 'UNION UNIV GALV D 1" NPT-H ASIENTO P' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10006942' CodMaterial, 'VALVULA PEALPE 1216 x1/2 FLARE' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007005' CodMaterial, 'ARTICULOS DECORACION NAVIDEÑA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007047' CodMaterial, 'ARTICULOS VARIOS FIESTA FIN DE AÑO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007050' CodMaterial, 'MEDIDOR 200 M3H ROT 12Bar ANSI150 G160ID' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10007051' CodMaterial, 'MEDID 310 M3H ROT 12 BAR ANSI150 11M ID' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10007056' CodMaterial, 'MEDIDOR TESTIGO G65' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10007061' CodMaterial, 'REGALOS INSTITUCIONALES' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007088' CodMaterial, 'ARTICULOS MEDICOS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007102' CodMaterial, 'POSTE SENALIZACION PLASTICO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '287' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007136' CodMaterial, 'CORRECT EAGLE XARTU/1LDV1  0-300 C/INDEX' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007247' CodMaterial, 'UNION PE100 D 63MM SOCKET' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007296' CodMaterial, 'UNION UNIV GALV D  1/2" NPT-H ASIENTO P' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007297' CodMaterial, 'UNION UNIV GALV D 1-1/2" NPT-H ASIENTO P' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007316' CodMaterial, 'ACOPLE RAPID QTM CUERPO 1/2"HNPT AC INOX' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007373' CodMaterial, 'DOBLA TUBO INTERNO PARA PE-AL-PE D 2025' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007374' CodMaterial, 'DOBLA TUBO EXTERNO TUBERIA PE-AL-PE 2025' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007432' CodMaterial, 'HTA. PARA DISPOSITIVO DE CORTE "CEPO"' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007448' CodMaterial, 'VALVULA BOLA AC INOX D 1/2" NPTH X 1000#' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007452' CodMaterial, 'MANOMETRO 1500 PSI CAR 4-1/2" RECA-INOX' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007529' CodMaterial, 'VALV BOLA FLANCHADA AC D 4" ANSI 600 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007639' CodMaterial, 'CAP AC CARBON D 6" SCH80' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007647' CodMaterial, 'CONECTOR AC INOX 1/2" OD X 1/2" NPTH' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007656' CodMaterial, 'EMPAQUE FLEXITALICO BRIDA D  2" ANSI 600' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007657' CodMaterial, 'ARTICULOS DECORATIVOS PARA OFICINA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007666' CodMaterial, 'BISELADOR PARA TUB. PE-AL-PE 2025' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007670' CodMaterial, 'VALVULA PEALPE 2025 (D 3/4")' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007671' CodMaterial, 'TUBERIA PEALPE 2025 (D 3/4") BLANCA' DescMaterial,'Z009' TipoMaterial,'M' UNMedida, '162' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007672' CodMaterial, 'UNION PEALPE 2025 x3/4" NPT HEMBRA' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007693' CodMaterial, 'SADDLE AC 12" X 4" A234 WPB SCH80' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007694' CodMaterial, 'SADDLE AC 6" X 2" A234 WPB SCH80' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007703' CodMaterial, 'ACTUADOR NEUMÁTICO 4R TORQUE 179.9 N-m' DescMaterial,'Z011' TipoMaterial,'UN' UNMedida, '201' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007706' CodMaterial, 'EMPAQUE FLEXITALICO BRIDA D  3" ANSI 600' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007707' CodMaterial, 'EMPAQUE FLEXITALICO BRIDA D  4" ANSI 600' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007708' CodMaterial, 'EMPAQUE FLEXITALICO BRIDA D  6" ANSI 600' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007710' CodMaterial, 'ESPARRAGO AC GR B7 D 7/8" X 5" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007712' CodMaterial, 'ESPARRAGO AC GR B7 D 1" X 6-3/4" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007717' CodMaterial, 'ESPARRAGO AC GR B7 D 7/8" X 5-3/4" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007736' CodMaterial, 'PORTAFLANCHE PE 100 90MM RDE11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007777' CodMaterial, 'UNION PEALPE 2025 (D 3/4")' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007778' CodMaterial, 'TEE PEALPE 2025 (D 3/4")' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007791' CodMaterial, 'HALF COUPLING ROSC AC D 3/4" NPTX3000 LB' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007792' CodMaterial, 'HALF COUPLING ROSC AC D 1/2" NPTX3000 LB' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007794' CodMaterial, 'VALVULA GLOBO ROSCADA D 1" X 3000#' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '203' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007828' CodMaterial, 'MANOMETRO 0-30 PSI PRES DIF CARAT 2-1/2"' DescMaterial,'Z012' TipoMaterial,'UN' UNMedida, '221' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007836' CodMaterial, 'MATERIALES MNTO/REPARACION EDIFICIOS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '285' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007868' CodMaterial, 'TRANSICION PE 63mm PE100 x 2PE80' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007919' CodMaterial, 'BRIDA WN AC D  6" ANSI 600 CUELLO SCH80' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007930' CodMaterial, 'ESPARRAGO AC GR B7 D 5/8"X 10-3/4" LONG' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007958' CodMaterial, 'TUBERIA AC D  6" API 5L X42 S/C SCH80' DescMaterial,'Z004' TipoMaterial,'M' UNMedida, '061' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007986' CodMaterial, 'BRIDA CIEGA AC FORJADO D 6" ANSI 600 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10007997' CodMaterial, 'IMPERMEABLE TIPO CHAQUETA Y PANTAL - SV' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008008' CodMaterial, 'IMPERMEABLE TIPO SOBRETODO CAPUCHA - SV' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008058' CodMaterial, 'TEE AC INOX 1/2" OD X 1/2" OD X 1/2" OD' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008071' CodMaterial, 'ACTIVOS MENORES EN GENERAL' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '287' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008083' CodMaterial, 'INDICADOR POS ACTUADOR ACCES MONT 30MM' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008240' CodMaterial, 'TUBING AC INOX D 1/2" OD X 0.065" ESP' DescMaterial,'Z013' TipoMaterial,'M' UNMedida, '241' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008324' CodMaterial, 'CODO PEALPE 2025 (D 3/4")' DescMaterial,'Z009' TipoMaterial,'UN' UNMedida, '161' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008327' CodMaterial, 'ACTUADOR NEUMATICO 2" ANSI 150' DescMaterial,'Z011' TipoMaterial,'UN' UNMedida, '201' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008352' CodMaterial, 'GDGU LLAVE DE TUBO 18" LONG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008449' CodMaterial, 'CEPO DE CORTE PARA VALVULA DE GAS' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008530' CodMaterial, 'DISPLAY 4 LINEAS CON SOPORTES, PARA RTU' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008737' CodMaterial, 'CAP AC CARBON D 10" SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008791' CodMaterial, 'DESINFECTANTE X 960CC PINOLINA CITRONELA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008956' CodMaterial, 'CODO ACERO INOX D 1/2" x 1/2" NPTM' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10008958' CodMaterial, 'TUBERIA AC D  1" API5LX42 S/C SCH40' DescMaterial,'Z004' TipoMaterial,'M' UNMedida, '061' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10009130' CodMaterial, 'TUBERIA AC D  3" API 5L X42 S/C SCH40' DescMaterial,'Z004' TipoMaterial,'M' UNMedida, '061' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10009229' CodMaterial, 'REGULADOR   4 M3H 20-60 PSI CD 1/4" NPTH' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '102' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10009287' CodMaterial, 'MED 250 M3H ROT 100 BAR ANSI 600 G160 EP' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10009395' CodMaterial, 'TAPON  PE100 D  63 MM RDE11 SOCKET' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10009396' CodMaterial, 'TAPON  PE100 D 110MM' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10009434' CodMaterial, 'TEE  PE100 D  63MM TOPE' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010015' CodMaterial, 'NIPLE GALV D  3/8" X 1-1/2" LONG SCH40' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010016' CodMaterial, 'TEE REDUCCION 32X20X32MM SW PE80' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '004' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010017' CodMaterial, 'NIPLE GALV D  1/2" X 2" LONG SCH40' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010018' CodMaterial, 'VALVULA DE POLIETILENO 32MM PE80' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '301' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010019' CodMaterial, 'COPA HIERRO GALV D 1"x1/2" NPT' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010020' CodMaterial, 'VALVULA DE POLIETILENO 63MM PE80' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '301' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010021' CodMaterial, 'VALVULA DE POLIETILENO 110MM PE80' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '301' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010022' CodMaterial, 'GDGU VALVULA DE POLIETILENO 110MM PE80' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '301' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010023' CodMaterial, 'VALVULA DE POLIETILENO 160MM PE80' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '301' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010024' CodMaterial, 'GDGU VALVULA DE POLIETILENO 160MM PE80' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '301' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010025' CodMaterial, 'ELEVADOR HIERRO GAL D 63MM' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '144' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010026' CodMaterial, 'EMPAQUE CONECTOR M26x1.5 2PZA NPT NEOPRE' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010027' CodMaterial, 'VALVULA DE POLIETILENO 200MM PE80' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '301' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010028' CodMaterial, 'CINTA METRICA DE 50mts' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010029' CodMaterial, 'SILLETA/TOMA CARGA MEC. 110 X 63MM PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010030' CodMaterial, 'MONA DE 4 LB' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010031' CodMaterial, 'SILLETA/TOMA CARGA MEC. 160 X 63MM PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010032' CodMaterial, 'SILLETA/TOMA CARGA MEC. 200 X 63MM PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010033' CodMaterial, 'UNION 63MM ELECTROFUSION PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010034' CodMaterial, 'CORTA TUBO DE PE HASTA 2"/63mm IPS' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '262' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010035' CodMaterial, 'UNION 110MM ELECTROFUSION PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 16 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010036' CodMaterial, 'RESISTENCIA PARA CALENTADOR 4SW' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010037' CodMaterial, 'UNION 160MM ELECTROFUSION PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010038' CodMaterial, 'UNION 200MM ELECTROFUSION PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010039' CodMaterial, 'TEE TOPE 63MM PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '004' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010040' CodMaterial, 'SOCKET D 3" IPS. SDR11 TERMOFUSION' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010041' CodMaterial, 'TEE 110MM PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '004' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010042' CodMaterial, 'REGULADOR   7 M3H 20-60 PSI (R-7 SE GN)' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '102' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010043' CodMaterial, 'REGULADOR   7 M3H 20-60 PSI (R-7 UE GN)' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '102' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010044' CodMaterial, 'REGULADOR  15 M3/H RSE 20 (SE)' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010045' CodMaterial, 'REGULADOR 500 M3/H (1813B CONEX 2"x2")' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010046' CodMaterial, 'REGULADOR RCSE20 23mbar/13m3/h' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010047' CodMaterial, 'REGULADOR RCSE20-35mbar/13m3/h' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010048' CodMaterial, 'TEE 160MM PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '004' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010049' CodMaterial, 'REJILLA METALICA CARA PLANA 2' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010050' CodMaterial, 'REJILLA METALICA PATAS PARA ABAJO' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010051' CodMaterial, 'REJILLA METALICA ESPECIAL TIPO 1' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010052' CodMaterial, 'TEE ELECTROFUSION 200MM PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '004' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010053' CodMaterial, 'REJILLA METALICA ESPECIAL TIPO 3' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010054' CodMaterial, 'REJILLA METALICA ESPECIAL TIPO 4' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010055' CodMaterial, 'REJILLA METALICA ESPECIAL TIPO 5' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010056' CodMaterial, 'TAPON 200MM (VST) PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010057' CodMaterial, 'TAPA SENALIZADORA PLASTICA 22mm,  PVC' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010058' CodMaterial, 'VALVULA DE POLIETILENO 63MM PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '301' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010059' CodMaterial, 'LUBRICANTE ANTISEIZE LATA DE 1 LIBRA' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '182' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010060' CodMaterial, 'VALVULA DE POLIETILENO 110MM PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '301' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010061' CodMaterial, 'VALVULA DE POLIETILENO 160MM PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '301' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010062' CodMaterial, 'TUBERIA PEALPE 1216 (D 1/2") NEGRA F. UV' DescMaterial,'Z009' TipoMaterial,'M' UNMedida, '162' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010063' CodMaterial, 'TUBERIA PE100  63 MM RDE 11 NARANJA' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010065' CodMaterial, 'VALVULA BOLA FLANCHADA AC D 3"" ANSI 30' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010066' CodMaterial, 'REPUESTOS PARA VEHICULOS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010067' CodMaterial, 'TAPON 63MM PE100' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010068' CodMaterial, 'REPUESTOS EQUIPOS DE COMPUTACI?N' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010069' CodMaterial, 'LINK SEAL TUBERIA AC D3" SCH40 API 5LX42' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010070' CodMaterial, 'ION X40 COBRE/SULFATO ELECTRODO PERMANEN' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '224' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010071' CodMaterial, 'TRANSPALETA MANUAL MOD CT30L DE 3,000 KG' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010072' CodMaterial, 'CARRETILLA/AL MOD GL300B' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010073' CodMaterial, 'CINTA DE SUJECIÓN 4" X 9 M' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '262' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010074' CodMaterial, 'RACHET' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '262' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010075' CodMaterial, 'TABLA DE MADERA 23CM x 4CM x 2.30 M' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, 'A005' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010076' CodMaterial, 'HOJAS EN FORMAS CONTINUAS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010077' CodMaterial, 'TACO DE MADERA 7CM x 8CM x 12CM' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '285' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010078' CodMaterial, 'SEPARADORES A4' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010079' CodMaterial, 'ARCHIVADOR DE CARTON A4' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010080' CodMaterial, 'FORMATO CONSEJO PARA EL BUEN USO DEL GAS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010081' CodMaterial, 'CINTA ADH. DOBLE FAZ 1/2" X 25YRD' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010082' CodMaterial, 'NUMERADOR AUTOMATICO 6 DIGITOS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010083' CodMaterial, 'CLIPS JUMBO CAJA X 50 UNID.' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010084' CodMaterial, 'FORMATO DYCI - DISENO Y  CONST. DE INST.' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010085' CodMaterial, 'FORMATO INFORME DE VISITA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010086' CodMaterial, 'SILLETA AUTOPER PE100 D6"X2" IPS ELECTRO' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '004' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010087' CodMaterial, 'FORMATO PAGARES PERSONA NATURAL' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010088' CodMaterial, 'PALLETS' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010089' CodMaterial, 'FORMATO SOL. DEL SERV GAS NAT Y REQ. PRO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010090' CodMaterial, 'FORMATO ORDEN DE SUSPENSION Y RECONEXION' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010091' CodMaterial, 'FORMATO DE CONTROL Y ENTREGA DE RECIBO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010092' CodMaterial, 'FORMATO SOLICITUD DE CR?DITO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010093' CodMaterial, 'FORMATO AUTORIZACI?N DE DATOS PERSONALES' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010094' CodMaterial, 'FORMATO RECIBOS DE CAJA MENOR' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010095' CodMaterial, 'FORMATO VALES DE SERVICIOS / SUMINISTROS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010096' CodMaterial, 'ART. CAFETERIA/ASEO/COMESTIBLES IVA 0%' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010097' CodMaterial, 'ART. CAFETERIA/ASEO/COMESTIBLES IVA 5%' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010098' CodMaterial, 'TANQUE DE ODORANTE TRANVASE 20 GALONES' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '287' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010099' CodMaterial, 'EQUIPO COMUNICACION SWITCH 8/16/24 PTOS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, 'A006' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010100' CodMaterial, 'TV SMART SAMSUNG 60"' DescMaterial,'ZAF0' TipoMaterial,'UN' UNMedida, 'A005' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010101' CodMaterial, 'PIONER A4' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010102' CodMaterial, 'BANDERITAS MEMO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010103' CodMaterial, 'FORRO VINIFAN' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010104' CodMaterial, 'FUNDA PARA CD' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010105' CodMaterial, 'CINTA ADHESIVA 1/2 X 72 YDS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 16 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010164' CodMaterial, 'VALVULA GLOBO FLANCHADA AC D 4" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '203' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010185' CodMaterial, 'NIPLE GALV D  1/2" X 1-1/2" LONG SCH40' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010186' CodMaterial, 'NIPLE GALV D 1/2"" X 2-1/2"" LONG SCH40' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010187' CodMaterial, 'PORTAFLANCHE PE 100 160MM RDE11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010188' CodMaterial, 'REFLECTOR' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010189' CodMaterial, 'TRANSICION PE 90mm PE100 x 3PE80' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '002' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010190' CodMaterial, 'CONECTOR FLEXIBLE 1/2" x1MT (Rojo/Azul)' DescMaterial,'Z007' TipoMaterial,'UN' UNMedida, '121' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010191' CodMaterial, 'CONECTOR FLEXIBLE 3/4" x1,5MT(Neg Vul.)' DescMaterial,'Z007' TipoMaterial,'UN' UNMedida, '121' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010192' CodMaterial, 'ESTUFA SOBREMESA 4 QUEMADORES GAS N/RAL' DescMaterial,'Z003' TipoMaterial,'UN' UNMedida, '041' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010193' CodMaterial, 'LLAVE PARA MANERAL ANTIFRAUDE TIPO TAPON' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010194' CodMaterial, 'ANILLO FRIO GRAPA D 2" PARA TUB. PE"' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010195' CodMaterial, 'ANILLO FRIO GRAPA D 3" PARA TUB. PE"' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010196' CodMaterial, 'ANILLO FRIO GRAPA D 4" PARA TUB. PE"' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010197' CodMaterial, 'RESISTENCIA PARA CALENTADOR 2SW' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010198' CodMaterial, 'SOCKET PARA SILLETA D 2" IPS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010199' CodMaterial, 'SOCKET PARA SILLETA D 3" IPS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010200' CodMaterial, 'SOCKET PARA SILLETA D 4" IPS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010201' CodMaterial, 'SOCKET D 63MM IPS. SDR11 TERMOFUSION' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010202' CodMaterial, 'REJILLA METALICA CARA PLANA 1' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010203' CodMaterial, 'REJILLA METALICA ESPECIAL TIPO 2' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010204' CodMaterial, 'REJILLA METALICA ESPECIAL TIPO 6' DescMaterial,'Z002' TipoMaterial,'UN' UNMedida, '022' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010205' CodMaterial, 'TAPA SENALIZADORA POLICONCRETO 18mm' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010206' CodMaterial, 'LUBRICANTE SUPER LUB. 225 GR, SPRAY' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '182' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010207' CodMaterial, 'TEE FILTRO EN Y DE 2"" AC' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010208' CodMaterial, 'TUBERIA PE100  90 MM RDE 11 NARANJA' DescMaterial,'Z001' TipoMaterial,'M' UNMedida, '001' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010209' CodMaterial, 'REPUESTOS PARA VEHICULOS, EXENT DE IVA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010210' CodMaterial, 'REPUESTOS EQUIPOS DE COMUNICACION' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010211' CodMaterial, 'REPUESTOS E INSUMOS DE PLANTAS ELECTRICA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010212' CodMaterial, 'REPUESTOS E INSUMOS DE AIRES ACONDICIONA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010213' CodMaterial, 'REPUESTOS E INSUMOS DETECTORES DE GASES' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010214' CodMaterial, 'GASES PARA CALIBRACION' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '284' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010215' CodMaterial, 'MATERIALES MTTO DE PLOMERIA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '285' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010216' CodMaterial, 'UTILES PARA OFICINA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '281' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010217' CodMaterial, 'HOJAS TAMAÑO CARTA LOGO GASGUAJIRA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010218' CodMaterial, 'HOJAS TAMAÑO CARTA LOGO BRILLA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010219' CodMaterial, 'VOLANTES DE CIRCULAR DE ROBO MEDIDORES' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010220' CodMaterial, 'FORMATO SUSPENSION POR OPERACIONES' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010221' CodMaterial, 'FORMATO INFORME TECNICO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010222' CodMaterial, 'FORMATO COTIZACION O CUENTA DE COBRO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010223' CodMaterial, 'FORMATO COTIZACION PARA MANTENIMIENTO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010224' CodMaterial, 'FORMATO COTIZACION DE VENTA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '289' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010225' CodMaterial, 'ART. CAFETERIA/ASEO/COMESTIBLES IVA 16%' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010226' CodMaterial, 'AGUA POTABLE (BOTELLONES)' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010227' CodMaterial, 'UTILES PARA ASEO Y LIMPIEZA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010228' CodMaterial, 'SERVILLETA DE REPUESTO TIPO ECOLOGICA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010229' CodMaterial, 'SERVILLETA DE REPUESTO TIPO BLANCA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010230' CodMaterial, 'JABON REPUESTO PARA DISPENSADOR' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '282' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010231' CodMaterial, 'BOTA DE SUGURIDAD PUNTA DE ACERO' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010232' CodMaterial, 'GUANTES' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010233' CodMaterial, 'REDUCCION PE100 D 110 X 3"" RDE 11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010259' CodMaterial, 'REGULADOR 630M3H, CONEX 2", ORI 1/2, LP' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010266' CodMaterial, 'CORTA TUBO DE PE DE 50 MM A 140 MM' DescMaterial,'Z014' TipoMaterial,'UN' UNMedida, '262' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010512' CodMaterial, 'REGULADOR AFV D 2" ANSI 600 ZSC100 MG-H7' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010550' CodMaterial, 'TUBERIA AC D  4" API 5LX42 S/C SCH40' DescMaterial,'Z004' TipoMaterial,'M' UNMedida, '061' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010566' CodMaterial, 'CHALECO IMPERMEABLE DE TRES PIEZAS' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '283' GRArticulos, 0 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010568' CodMaterial, 'REGALO INSTITUCIONAL GAS GUAJIRA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 0 IVA, 'X' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010607' CodMaterial, 'TUBERIA AC D  6" API 5L X42 S/C SCH40' DescMaterial,'Z004' TipoMaterial,'M' UNMedida, '061' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010635' CodMaterial, 'REGUL RCABP SE30M3 4-6PSI CD1"H SIN VENT' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010748' CodMaterial, 'MATERIALES PARA MEJORA PROPIEDAD AJENA' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '288' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010768' CodMaterial, 'HTA. DISPOSITIVO CORTE-SELLO EXPANDIBLE' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010770' CodMaterial, 'SELLO EXPANDIBLE 1/2"- CORTE EN ELEVADOR' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010772' CodMaterial, 'SELLO EXPANDIBLE 3/8"- CORTE EN ELEVADOR' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '261' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010846' CodMaterial, 'VALV BOLA TRUNNION AC D 4" ANSI 150 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010856' CodMaterial, 'VALV BOLA TRUNNION AC D 2" ANSI 600 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010911' CodMaterial, 'VALVULA PE100 D 6" IPS RDE11 TOPE BYPASS' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '005' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010917' CodMaterial, 'NIPLE AC D 1/2" X 3" LONG SCH40' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10010986' CodMaterial, 'REGULADOR 1883 CPB2 ORIF. 3/8' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011036' CodMaterial, 'TUBERIA AC D 10" API 5LX42 SCH40 DESNUDA' DescMaterial,'Z004' TipoMaterial,'M' UNMedida, '061' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011037' CodMaterial, 'REGULADOR ESTABILIZADOR PRESION 30 M3/H' DescMaterial,'Z006' TipoMaterial,'UN' UNMedida, '101' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011121' CodMaterial, 'EMPAQUE BRIDA D 12" ANSI 150 ESP 1/16' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011124' CodMaterial, 'BRIDA SLIP-ON AC FORJADO D 12" ANSI 150' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011125' CodMaterial, 'BRIDA CIEGA AC FORJADO D 12" ANSI 150 RF' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '062' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011173' CodMaterial, 'UNION PE80 D 6" IPS ELECTRO AMARILLO' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011399' CodMaterial, 'TUBERIA AC D 1" API 5LX42 S/C SCH40' DescMaterial,'Z004' TipoMaterial,'M' UNMedida, '061' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011435' CodMaterial, 'VALVULA CHEQUE AC D 2" ANSI 150, RF' DescMaterial,'Z011' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011688' CodMaterial, 'MEDIDOR DIGITAL 6M3H DIAF G4 IZQ' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10011689' CodMaterial, 'MEDIDOR DIGITAL 10M3H DIAF G6 IZQ' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10011691' CodMaterial, 'MEDIDOR DIGITAL 16M3H DIAF G10 IZQ' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10011693' CodMaterial, 'MEDIDOR DIGITAL 25M3H DIAF G16 IZQ' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, 'X' EsSerial from dual union all
    select '10011736' CodMaterial, 'REDUCCION PE100 D 110 X 4"" RDE 11' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011760' CodMaterial, 'MEDIDOR G 250' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011761' CodMaterial, 'STUDENDPORTA BRIDA DE 4"' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '007' GRArticulos, 16 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011763' CodMaterial, 'SPOOL DE 4" CM' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '003' GRArticulos, 16 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011892' CodMaterial, 'UNION PE100 GAS 160 MM METR RDE 11 ELECT' DescMaterial,'Z001' TipoMaterial,'UN' UNMedida, '004' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011896' CodMaterial, 'CONECTOR CURVO 1/2"NPT X 1/2" OD INOXIDA' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011898' CodMaterial, 'CONECTOR CURVO 1/2" NPT x 1/4" OD INOX' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011899' CodMaterial, 'REDUC BUSH 1/2"x1/4" NPT INOX' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011900' CodMaterial, 'REDU BUSHIN ¾” NPT X ½” NPT INOX' DescMaterial,'Z015' TipoMaterial,'UN' UNMedida, '286' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011901' CodMaterial, 'UNION DE ½” OD X ½” OD INOX' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011903' CodMaterial, 'VALVULA BOLA ½” OD X ½”' DescMaterial,'Z004' TipoMaterial,'UN' UNMedida, '063' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011906' CodMaterial, 'ACOPLE RAPIDO ½” SS-QC8-B-810' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011907' CodMaterial, 'ACOPLE RAPIDO ESPIGO ½” SS-QC8-S-810' DescMaterial,'Z013' TipoMaterial,'UN' UNMedida, '242' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011917' CodMaterial, 'PLAQUETAS PLASTICAS SEÑALIZACION 6"x 6"' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '300' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10011929' CodMaterial, 'COMPUTADOR FLUJO MPPLUS II S-INDEX 0-100' DescMaterial,'Z017' TipoMaterial,'UN' UNMedida, '083' GRArticulos, 0 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual union all
    select '10012029' CodMaterial, 'MODEM DATOS 4G LTE' DescMaterial,'Z010' TipoMaterial,'UN' UNMedida, '081' GRArticulos, 19 IVA, '' Bloqueado, 'S' TipoValora, '' EsSerial from dual )
    select *
    from base;
    
    sbEmpresa varchar2(1000):='GDGU';
begin
    update ge_items set item_classif_id=21 where items_id=10006391;
    update ge_items set item_classif_id=21 where items_id=10011691;

    for reg in cuItems loop
        begin
          ldci_maestromaterial.proNotificarMaterial(isbEmpresa => sbEmpresa,
                                                    Isbcodmaterial => reg.CodMaterial,
                                                    Isbdescmaterial => reg.DescMaterial,
                                                    Isbtipomaterial => reg.TipoMaterial,
                                                    Isbgrarticulos => reg.GRArticulos,
                                                    Isbunmedida => reg.UNMedida,
                                                    Isbestadomat => reg.Bloqueado,
                                                    Inuporciva => reg.IVA,
                                                    isbItemDoVal => reg.TipoValora,
                                                    isbItemSeri => reg.EsSerial);
         commit;
         dbms_output.put_line(reg.CodMaterial||'|'||'OK');
        exception
          when others then
            rollback;
            dbms_output.put_line(reg.CodMaterial||'|'||sqlerrm);
        end;
    end loop;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/