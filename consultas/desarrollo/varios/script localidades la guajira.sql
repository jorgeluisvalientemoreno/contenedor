declare

  nuDepartamId              number := 8978; --La guajira
  nuTipoAreaLoca            number := 3; --Localidad
  nuTipoAreaSect            number := 4; --Sector
  nuTipoAreaBarr            number := 5; --Barrio
  inuLocalidad              number;
  inuSectorId               number;
  inuBarrioId               number;
  nuError                   number;
  sbError                   varchar2(4000);
  nuClassifOperSector       number:=1;
  sbShape                   varchar2(100):=null;
  
  cursor cuDatosLoca is
  with base as(
     SELECT 'XX01' as ID, 'RIOHACHA' as nombre from dual union all
    SELECT 'XX02' as ID, 'MAICAO' as nombre from dual union all
    SELECT 'XX03' as ID, 'PALOMINO' as nombre from dual union all
    SELECT 'XX04' as ID, 'MINGUEO' as nombre from dual union all
    SELECT 'XX05' as ID, 'CAMARONES' as nombre from dual union all
    SELECT 'XX06' as ID, 'DIBULLA' as nombre from dual union all
    SELECT 'XX07' as ID, 'URIBIA' as nombre from dual union all
    SELECT 'XX08' as ID, 'MANAURE' as nombre from dual union all
    SELECT 'XX09' as ID, 'HATONUEVO' as nombre from dual union all
    SELECT 'XX10' as ID, 'PAPAYAL' as nombre from dual union all
    SELECT 'XX11' as ID, 'BARRANCAS' as nombre from dual union all
    SELECT 'XX12' as ID, 'FONSECA' as nombre from dual union all
    SELECT 'XX13' as ID, 'SAN JUAN DEL CESAR' as nombre from dual union all
    SELECT 'XX14' as ID, 'EL MOLINO' as nombre from dual union all
    SELECT 'XX15' as ID, 'VILLANUEVA' as nombre from dual union all
    SELECT 'XX16' as ID, 'URUMITA' as nombre from dual union all
    SELECT 'XX17' as ID, 'DISTRACCION' as nombre from dual union all
    SELECT 'XX18' as ID, 'BUENAVISTA' as nombre from dual union all
    SELECT 'XX19' as ID, 'ALBANIA' as nombre from dual union all
    SELECT 'XX20' as ID, 'CUESTECITA' as nombre from dual union all
    SELECT 'XX21' as ID, 'LA PUNTA DE LOS REMEDIOS' as nombre from dual union all
    SELECT 'XX22' as ID, 'LAS FLORES' as nombre from dual union all
    SELECT 'XX23' as ID, 'RIO ANCHO' as nombre from dual union all
    SELECT 'XX24' as ID, 'LA JAGUA DEL PILAR' as nombre from dual union all
    SELECT 'XX25' as ID, 'EL PAJARO' as nombre from dual union all
    SELECT 'XX26' as ID, 'LOS PONDORES' as nombre from dual union all
    SELECT 'XX27' as ID, 'EL EBANAL' as nombre from dual union all
    SELECT 'XX28' as ID, 'TIGRERAS' as nombre from dual union all
    SELECT 'XX29' as ID, 'COMEJENES' as nombre from dual union all
    SELECT 'XX30' as ID, 'CHOLES' as nombre from dual union all
    SELECT 'XX31' as ID, 'ANAIME' as nombre from dual union all
    SELECT 'XX32' as ID, 'MATITAS' as nombre from dual union all
    SELECT 'XX33' as ID, 'PUENTE BOMBA' as nombre from dual union all
    SELECT 'XX34' as ID, 'PELECHUA' as nombre from dual union all
    SELECT 'XX35' as ID, 'PARAGUACHON' as nombre from dual union all
    SELECT 'XX36' as ID, 'GUAYACANAL' as nombre from dual union all
    SELECT 'XX37' as ID, 'EL HATICO' as nombre from dual union all
    SELECT 'XX38' as ID, 'TABACO RUBIO' as nombre from dual union all
    SELECT 'XX39' as ID, 'CERREJON' as nombre from dual union all
    SELECT 'XX40' as ID, 'AREMASAIN' as nombre from dual union all
    SELECT 'XX41' as ID, 'LA GLORIA' as nombre from dual union all
    SELECT 'XX42' as ID, 'CARRAIPIA' as nombre from dual union all
    SELECT 'XX43' as ID, 'CARRETALITO' as nombre from dual union all
    SELECT 'XX44' as ID, 'NUEVO OREGANAL' as nombre from dual union all
    SELECT 'XX45' as ID, 'CONEJO' as nombre from dual union all
    SELECT 'XX46' as ID, 'PERICO' as nombre from dual union all
    SELECT 'XX47' as ID, 'CANAVERALES' as nombre from dual union all
    SELECT 'XX48' as ID, 'LA JUNTA' as nombre from dual union all
    SELECT 'XX49' as ID, 'CORRALEJA' as nombre from dual union all
    SELECT 'XX50' as ID, 'EL TABLAZO' as nombre from dual union all
    SELECT 'XX51' as ID, 'LA PENA' as nombre from dual union all
    SELECT 'XX52' as ID, 'LOS POZOS' as nombre from dual union all
    SELECT 'XX53' as ID, 'CAMPANA NUEVO' as nombre from dual union all
    SELECT 'XX54' as ID, 'CHORRERA' as nombre from dual union all
    SELECT 'XX55' as ID, 'ZAMBRANO' as nombre from dual union all
    SELECT 'XX56' as ID, 'CURAZAO' as nombre from dual union all
    SELECT 'XX57' as ID, 'MONGUI' as nombre from dual union all
    SELECT 'XX58' as ID, 'GALAN' as nombre from dual union all
    SELECT 'XX59' as ID, 'ARROYO ARENA' as nombre from dual union all
    SELECT 'XX60' as ID, 'TOMARRAZON' as nombre from dual union all
    SELECT 'XX61' as ID, 'BARBACOA' as nombre from dual union all
    SELECT 'XX62' as ID, 'COTOPRIX' as nombre from dual union all
    SELECT 'XX63' as ID, 'VILLA MARTIN' as nombre from dual union all
    SELECT 'XX64' as ID, 'CERRILLO' as nombre from dual union all
    SELECT 'XX65' as ID, 'ROCHE' as nombre from dual union all
    SELECT 'XX66' as ID, 'PATILLA' as nombre from dual union all
    SELECT 'XX67' as ID, 'CHANCLETA' as nombre from dual union all
    SELECT 'XX68' as ID, 'LAS CASITAS' as nombre from dual union all
    SELECT 'XX69' as ID, 'CORRAL DE PIEDRA' as nombre from dual union all
    SELECT 'XX70' as ID, 'EL TOTUMO' as nombre from dual union all
    SELECT 'XX71' as ID, 'GUAYACANAL (SAN JUAN)' as nombre from dual union all
    SELECT 'XX72' as ID, 'LOS HATICOS (SAN JUAN)' as nombre from dual union all
    SELECT 'XX73' as ID, 'VILLA DEL RIO' as nombre from dual union all
    SELECT 'XX74' as ID, 'LAGUNITA' as nombre from dual union all
    SELECT 'XX75' as ID, 'EL ABRA' as nombre from dual union all
    SELECT 'XX76' as ID, 'LOS MORENEROS' as nombre from dual union all
    SELECT 'XX77' as ID, 'JUAN Y MEDIO' as nombre from dual union all
    SELECT 'XX78' as ID, 'LOS HORNITOS' as nombre from dual union all
    SELECT 'XX79' as ID, 'CERRO PERALTA' as nombre from dual union all
    SELECT 'XX80' as ID, 'TAMAQUITO II' as nombre from dual union all
    SELECT 'XX81' as ID, 'POZO HONDO' as nombre from dual union all
    SELECT 'XX82' as ID, 'TOCAPALMA' as nombre from dual
  )
  select *
  from base
  where not exists(select null from open.ge_geogra_location where description=base.nombre and geo_loca_father_id = nuDepartamId );
  
  
  cursor cuDatosSector(nuPadre varchar2) is
  with base as(
    SELECT 'Y001' as ID, 'SECTOR 1 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y002' as ID, 'SECTOR 2 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y003' as ID, 'SECTOR 3 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y004' as ID, 'SECTOR 4 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y005' as ID, 'SECTOR 5 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y006' as ID, 'SECTOR 6 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y007' as ID, 'SECTOR 7 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y008' as ID, 'SECTOR 8 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y009' as ID, 'SECTOR 9 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y010' as ID, 'SECTOR 10 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y011' as ID, 'SECTOR 11 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y012' as ID, 'SECTOR 12 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y013' as ID, 'SECTOR 13 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y014' as ID, 'SECTOR 14 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y015' as ID, 'SECTOR 15 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y016' as ID, 'SECTOR 16 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y017' as ID, 'SECTOR 99 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
    SELECT 'Y018' as ID, 'SECTOR 1 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y019' as ID, 'SECTOR 2 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y020' as ID, 'SECTOR 3 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y021' as ID, 'SECTOR 4 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y022' as ID, 'SECTOR 5 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y023' as ID, 'SECTOR 6 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y024' as ID, 'SECTOR 7 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y025' as ID, 'SECTOR 8 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y026' as ID, 'SECTOR 9 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y027' as ID, 'SECTOR 10 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y028' as ID, 'SECTOR 11 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y029' as ID, 'SECTOR 12 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y030' as ID, 'SECTOR 13 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y031' as ID, 'SECTOR 14 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y032' as ID, 'SECTOR 15 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y033' as ID, 'SECTOR 16 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
    SELECT 'Y034' as ID, 'SECTOR 1 PALOMINO (LAG)' as nombre, 'XX03' as padre from dual union all
    SELECT 'Y035' as ID, 'SECTOR 2 PALOMINO (LAG)' as nombre, 'XX03' as padre from dual union all
    SELECT 'Y036' as ID, 'SECTOR 1 MINGUEO (LAG)' as nombre, 'XX04' as padre from dual union all
    SELECT 'Y037' as ID, 'SECTOR 2 MINGUEO (LAG)' as nombre, 'XX04' as padre from dual union all
    SELECT 'Y038' as ID, 'SECTOR 1 CAMARONES (LAG)' as nombre, 'XX05' as padre from dual union all
    SELECT 'Y039' as ID, 'SECTOR 1 DIBULLA  (LAG)' as nombre, 'XX06' as padre from dual union all
    SELECT 'Y040' as ID, 'SECTOR 1 URIBIA  (LAG)' as nombre, 'XX07' as padre from dual union all
    SELECT 'Y041' as ID, 'SECTOR 2 URIBIA (LAG)' as nombre, 'XX07' as padre from dual union all
    SELECT 'Y042' as ID, 'SECTOR 1 MANURE  (LAG)' as nombre, 'XX08' as padre from dual union all
    SELECT 'Y043' as ID, 'SECTOR 2 MANURE  (LAG)' as nombre, 'XX08' as padre from dual union all
    SELECT 'Y044' as ID, 'SECTOR 1 HATONUEVO  (LAG)' as nombre, 'XX09' as padre from dual union all
    SELECT 'Y045' as ID, 'SECTOR 2 HATONUEVO  (LAG)' as nombre, 'XX09' as padre from dual union all
    SELECT 'Y046' as ID, 'SECTOR 1 PAPAYAL  (LAG)' as nombre, 'XX10' as padre from dual union all
    SELECT 'Y047' as ID, 'SECTOR 2 PAPAYAL  (LAG)' as nombre, 'XX10' as padre from dual union all
    SELECT 'Y048' as ID, 'SECTOR 1 BARRANCAS  (LAG)' as nombre, 'XX11' as padre from dual union all
    SELECT 'Y049' as ID, 'SECTOR 2 BARRANCAS  (LAG)' as nombre, 'XX11' as padre from dual union all
    SELECT 'Y050' as ID, 'SECTOR 3 BARRANCAS  (LAG)' as nombre, 'XX11' as padre from dual union all
    SELECT 'Y051' as ID, 'SECTOR 4 BARRANCAS  (LAG)' as nombre, 'XX11' as padre from dual union all
    SELECT 'Y052' as ID, 'SECTOR 1 FONSECA (LAG)' as nombre, 'XX12' as padre from dual union all
    SELECT 'Y053' as ID, 'SECTOR 2 FONSECA  (LAG)' as nombre, 'XX12' as padre from dual union all
    SELECT 'Y054' as ID, 'SECTOR 3 FONSECA  (LAG)' as nombre, 'XX12' as padre from dual union all
    SELECT 'Y055' as ID, 'SECTOR 4 FONSECA  (LAG)' as nombre, 'XX12' as padre from dual union all
    SELECT 'Y056' as ID, 'SECTOR 5 FONSECA  (LAG)' as nombre, 'XX12' as padre from dual union all
    SELECT 'Y057' as ID, 'SECTOR 6 FONSECA  (LAG)' as nombre, 'XX12' as padre from dual union all
    SELECT 'Y058' as ID, 'SECTOR 1 SAN JUAN DEL CESAR (LAG)' as nombre, 'XX13' as padre from dual union all
    SELECT 'Y059' as ID, 'SECTOR 2 SAN JUAN DEL CESAR  (LAG)' as nombre, 'XX13' as padre from dual union all
    SELECT 'Y060' as ID, 'SECTOR 3 SAN JUAN DEL CESAR  (LAG)' as nombre, 'XX13' as padre from dual union all
    SELECT 'Y061' as ID, 'SECTOR 4 SAN JUAN DEL CESAR  (LAG)' as nombre, 'XX13' as padre from dual union all
    SELECT 'Y062' as ID, 'SECTOR 5 SAN JUAN DEL CESAR  (LAG)' as nombre, 'XX13' as padre from dual union all
    SELECT 'Y063' as ID, 'SECTOR 6 SAN JUAN DEL CESAR  (LAG)' as nombre, 'XX13' as padre from dual union all
    SELECT 'Y064' as ID, 'SECTOR 1 EL MOLINO  (LAG)' as nombre, 'XX14' as padre from dual union all
    SELECT 'Y065' as ID, 'SECTOR 2 EL MOLINO  (LAG)' as nombre, 'XX14' as padre from dual union all
    SELECT 'Y066' as ID, 'SECTOR 1 VILLANUEVA (LAG)' as nombre, 'XX15' as padre from dual union all
    SELECT 'Y067' as ID, 'SECTOR 2 VILLANUEVA  (LAG)' as nombre, 'XX15' as padre from dual union all
    SELECT 'Y068' as ID, 'SECTOR 3 VILLANUEVA  (LAG)' as nombre, 'XX15' as padre from dual union all
    SELECT 'Y069' as ID, 'SECTOR 4 VILLANUEVA  (LAG)' as nombre, 'XX15' as padre from dual union all
    SELECT 'Y070' as ID, 'SECTOR 5 VILLANUEVA  (LAG)' as nombre, 'XX15' as padre from dual union all
    SELECT 'Y071' as ID, 'SECTOR 6 VILLANUEVA  (LAG)' as nombre, 'XX15' as padre from dual union all
    SELECT 'Y072' as ID, 'SECTOR 1 URUMITA  (LAG)' as nombre, 'XX16' as padre from dual union all
    SELECT 'Y073' as ID, 'SECTOR 2 URUMITA  (LAG)' as nombre, 'XX16' as padre from dual union all
    SELECT 'Y074' as ID, 'SECTOR 1 DISTRACCION (LAG)' as nombre, 'XX17' as padre from dual union all
    SELECT 'Y075' as ID, 'SECTOR 1 BUENAVISTA (LAG)' as nombre, 'XX18' as padre from dual union all
    SELECT 'Y076' as ID, 'SECTOR 1 ALBANIA (LAG)' as nombre, 'XX19' as padre from dual union all
    SELECT 'Y077' as ID, 'SECTOR 2 ALBANIA (LAG)' as nombre, 'XX19' as padre from dual union all
    SELECT 'Y078' as ID, 'SECTOR 1 CUESTECITA (LAG)' as nombre, 'XX20' as padre from dual union all
    SELECT 'Y079' as ID, 'SECTOR 1 LA PUNTA DE LOS REMEDIOS (LAG)' as nombre, 'XX21' as padre from dual union all
    SELECT 'Y080' as ID, 'SECTOR 1 LAS FLORES (LAG)' as nombre, 'XX22' as padre from dual union all
    SELECT 'Y081' as ID, 'SECTOR 1 RIO ANCHO (LAG)' as nombre, 'XX23' as padre from dual union all
    SELECT 'Y082' as ID, 'SECTOR 1 LA JAGUA DEL PILAR (LAG)' as nombre, 'XX24' as padre from dual union all
    SELECT 'Y083' as ID, 'SECTOR 1 EL PAJARO (LAG)' as nombre, 'XX25' as padre from dual union all
    SELECT 'Y084' as ID, 'SECTOR 1 LOS PONDORES (LAG)' as nombre, 'XX26' as padre from dual union all
    SELECT 'Y085' as ID, 'SECTOR 1 EL EBANAL (LAG)' as nombre, 'XX27' as padre from dual union all
    SELECT 'Y086' as ID, 'SECTOR 1 TIGRERAS (LAG)' as nombre, 'XX28' as padre from dual union all
    SELECT 'Y087' as ID, 'SECTOR 1 COMEJENES (LAG)' as nombre, 'XX29' as padre from dual union all
    SELECT 'Y088' as ID, 'SECTOR 1 CHOLES (LAG)' as nombre, 'XX30' as padre from dual union all
    SELECT 'Y089' as ID, 'SECTOR 1 ANAIME (LAG)' as nombre, 'XX31' as padre from dual union all
    SELECT 'Y090' as ID, 'SECTOR 1 MATITAS (LAG)' as nombre, 'XX32' as padre from dual union all
    SELECT 'Y091' as ID, 'SECTOR 1 PUENTE BOMBA (LAG)' as nombre, 'XX33' as padre from dual union all
    SELECT 'Y092' as ID, 'SECTOR 1 PELECHUA (LAG)' as nombre, 'XX34' as padre from dual union all
    SELECT 'Y093' as ID, 'SECTOR 1 PARAGUACHON (LAG)' as nombre, 'XX35' as padre from dual union all
    SELECT 'Y094' as ID, 'SECTOR 1 GUAYACANAL (LAG)' as nombre, 'XX36' as padre from dual union all
    SELECT 'Y095' as ID, 'SECTOR 1 EL HATICO (LAG)' as nombre, 'XX37' as padre from dual union all
    SELECT 'Y096' as ID, 'SECTOR 1 TABACO RUBIO (LAG)' as nombre, 'XX38' as padre from dual union all
    SELECT 'Y097' as ID, 'SECTOR 1 CERREJON (LAG)' as nombre, 'XX39' as padre from dual union all
    SELECT 'Y098' as ID, 'SECTOR 1 AREMASAIN (LAG)' as nombre, 'XX40' as padre from dual union all
    SELECT 'Y099' as ID, 'SECTOR 1 LA GLORIA (LAG)' as nombre, 'XX41' as padre from dual union all
    SELECT 'Y100' as ID, 'SECTOR 1 CARRAIPIA (LAG)' as nombre, 'XX42' as padre from dual union all
    SELECT 'Y101' as ID, 'SECTOR 1 CARRETALITO (LAG)' as nombre, 'XX43' as padre from dual union all
    SELECT 'Y102' as ID, 'SECTOR 1 NUEVO OREGANAL (LAG)' as nombre, 'XX44' as padre from dual union all
    SELECT 'Y103' as ID, 'SECTOR 1 CONEJO (LAG)' as nombre, 'XX45' as padre from dual union all
    SELECT 'Y104' as ID, 'SECTOR 1 PERICO (LAG)' as nombre, 'XX46' as padre from dual union all
    SELECT 'Y105' as ID, 'SECTOR 1 CANAVERALES (LAG)' as nombre, 'XX47' as padre from dual union all
    SELECT 'Y106' as ID, 'SECTOR 1 LA JUNTA (LAG)' as nombre, 'XX48' as padre from dual union all
    SELECT 'Y107' as ID, 'SECTOR 1 CORRALEJA (LAG)' as nombre, 'XX49' as padre from dual union all
    SELECT 'Y108' as ID, 'SECTOR 1 EL TABLAZO (LAG)' as nombre, 'XX50' as padre from dual union all
    SELECT 'Y109' as ID, 'SECTOR 1 LA PENA (LAG)' as nombre, 'XX51' as padre from dual union all
    SELECT 'Y110' as ID, 'SECTOR 1 LOS POZOS (LAG)' as nombre, 'XX52' as padre from dual union all
    SELECT 'Y111' as ID, 'SECTOR 1 CAMPANA NUEVO (LAG)' as nombre, 'XX53' as padre from dual union all
    SELECT 'Y112' as ID, 'SECTOR 1 CHORRERA (LAG)' as nombre, 'XX54' as padre from dual union all
    SELECT 'Y113' as ID, 'SECTOR 1 ZAMBRANO (LAG)' as nombre, 'XX55' as padre from dual union all
    SELECT 'Y114' as ID, 'SECTOR 1 CURAZAO (LAG)' as nombre, 'XX56' as padre from dual union all
    SELECT 'Y115' as ID, 'SECTOR 1 MONGUI (LAG)' as nombre, 'XX57' as padre from dual union all
    SELECT 'Y116' as ID, 'SECTOR 1 GALAN (LAG)' as nombre, 'XX58' as padre from dual union all
    SELECT 'Y117' as ID, 'SECTOR 1 ARROYO ARENA (LAG)' as nombre, 'XX59' as padre from dual union all
    SELECT 'Y118' as ID, 'SECTOR 1 TOMARRAZON (LAG)' as nombre, 'XX60' as padre from dual union all
    SELECT 'Y119' as ID, 'SECTOR 1 BARBACOA (LAG)' as nombre, 'XX61' as padre from dual union all
    SELECT 'Y120' as ID, 'SECTOR 1 COTOPRIX (LAG)' as nombre, 'XX62' as padre from dual union all
    SELECT 'Y121' as ID, 'SECTOR 1 VILLA MARTIN (LAG)' as nombre, 'XX63' as padre from dual union all
    SELECT 'Y122' as ID, 'SECTOR 1 CERRILLO (LAG)' as nombre, 'XX64' as padre from dual union all
    SELECT 'Y123' as ID, 'SECTOR 1 ROCHE (LAG)' as nombre, 'XX65' as padre from dual union all
    SELECT 'Y124' as ID, 'SECTOR 1 PATILLA (LAG)' as nombre, 'XX66' as padre from dual union all
    SELECT 'Y125' as ID, 'SECTOR 1 CHANCLETA (LAG)' as nombre, 'XX67' as padre from dual union all
    SELECT 'Y126' as ID, 'SECTOR 1 LAS CASITAS (LAG)' as nombre, 'XX68' as padre from dual union all
    SELECT 'Y127' as ID, 'SECTOR 1 CORRAL DE PIEDRA (LAG)' as nombre, 'XX69' as padre from dual union all
    SELECT 'Y128' as ID, 'SECTOR 1 EL TOTUMO (LAG)' as nombre, 'XX70' as padre from dual union all
    SELECT 'Y129' as ID, 'SECTOR 1 GUAYACANAL (SAN JUAN) (LAG)' as nombre, 'XX71' as padre from dual union all
    SELECT 'Y130' as ID, 'SECTOR 1 LOS HATICOS (SAN JUAN) (LAG)' as nombre, 'XX72' as padre from dual union all
    SELECT 'Y131' as ID, 'SECTOR 1 VILLA DEL RIO (LAG)' as nombre, 'XX73' as padre from dual union all
    SELECT 'Y132' as ID, 'SECTOR 1 LAGUNITA (LAG)' as nombre, 'XX74' as padre from dual union all
    SELECT 'Y133' as ID, 'SECTOR 1 EL ABRA (LAG)' as nombre, 'XX75' as padre from dual union all
    SELECT 'Y134' as ID, 'SECTOR 1 LOS MORENEROS (LAG)' as nombre, 'XX76' as padre from dual union all
    SELECT 'Y135' as ID, 'SECTOR 1 JUAN Y MEDIO (LAG)' as nombre, 'XX77' as padre from dual union all
    SELECT 'Y136' as ID, 'SECTOR 1 LOS HORNITOS (LAG)' as nombre, 'XX78' as padre from dual union all
    SELECT 'Y137' as ID, 'SECTOR 1 CERRO PERALTA (LAG)' as nombre, 'XX79' as padre from dual union all
    SELECT 'Y138' as ID, 'SECTOR 1 TAMAQUITO II (LAG)' as nombre, 'XX80' as padre from dual union all
    SELECT 'Y139' as ID, 'SECTOR 1 POZO HONDO (LAG)' as nombre, 'XX81' as padre from dual union all
    SELECT 'Y140' as ID, 'SECTOR 1 TOCAPALMA (LAG)' as nombre, 'XX82' as padre from dual)
    select *
    from base
    where padre =nuPadre
      and not exists(select null from open.ge_geogra_location where description=base.nombre);
      
   cursor cuBarrios(nuPadre varchar2) is
   with base as(
       SELECT 'Z001' as ID, 'BARRIO 1 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z002' as ID, 'BARRIO 2 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z003' as ID, 'BARRIO 3 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z004' as ID, 'BARRIO 4 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z005' as ID, 'BARRIO 5 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z006' as ID, 'BARRIO 6 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z007' as ID, 'BARRIO 7 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z008' as ID, 'BARRIO 8 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z009' as ID, 'BARRIO 9 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z010' as ID, 'BARRIO 10 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z011' as ID, 'BARRIO 11 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z012' as ID, 'BARRIO 12 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z013' as ID, 'BARRIO 13 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z014' as ID, 'BARRIO 14 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z015' as ID, 'BARRIO 15 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z016' as ID, 'BARRIO 16 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z017' as ID, 'BARRIO 99 RIOHACHA (LAG)' as nombre, 'XX01' as padre from dual union all
      SELECT 'Z018' as ID, 'BARRIO 1 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z019' as ID, 'BARRIO 2 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z020' as ID, 'BARRIO 3 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z021' as ID, 'BARRIO 4 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z022' as ID, 'BARRIO 5 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z023' as ID, 'BARRIO 6 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z024' as ID, 'BARRIO 7 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z025' as ID, 'BARRIO 8 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z026' as ID, 'BARRIO 9 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z027' as ID, 'BARRIO 10 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z028' as ID, 'BARRIO 11 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z029' as ID, 'BARRIO 12 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z030' as ID, 'BARRIO 13 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z031' as ID, 'BARRIO 14 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z032' as ID, 'BARRIO 15 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z033' as ID, 'BARRIO 16 MAICAO (LAG)' as nombre, 'XX02' as padre from dual union all
      SELECT 'Z034' as ID, 'BARRIO 1 PALOMINO (LAG)' as nombre, 'XX03' as padre from dual union all
      SELECT 'Z035' as ID, 'BARRIO 2 PALOMINO (LAG)' as nombre, 'XX03' as padre from dual union all
      SELECT 'Z036' as ID, 'BARRIO 1 MINGUEO (LAG)' as nombre, 'XX04' as padre from dual union all
      SELECT 'Z037' as ID, 'BARRIO 2 MINGUEO (LAG)' as nombre, 'XX04' as padre from dual union all
      SELECT 'Z038' as ID, 'BARRIO 1 CAMARONES (LAG)' as nombre, 'XX05' as padre from dual union all
      SELECT 'Z039' as ID, 'BARRIO 1 DIBULLA  (LAG)' as nombre, 'XX06' as padre from dual union all
      SELECT 'Z040' as ID, 'BARRIO 1 URIBIA  (LAG)' as nombre, 'XX07' as padre from dual union all
      SELECT 'Z041' as ID, 'BARRIO 2 URIBIA (LAG)' as nombre, 'XX07' as padre from dual union all
      SELECT 'Z042' as ID, 'BARRIO 1 MANURE  (LAG)' as nombre, 'XX08' as padre from dual union all
      SELECT 'Z043' as ID, 'BARRIO 2 MANURE  (LAG)' as nombre, 'XX08' as padre from dual union all
      SELECT 'Z044' as ID, 'BARRIO 1 HATONUEVO  (LAG)' as nombre, 'XX09' as padre from dual union all
      SELECT 'Z045' as ID, 'BARRIO 2 HATONUEVO  (LAG)' as nombre, 'XX09' as padre from dual union all
      SELECT 'Z046' as ID, 'BARRIO 1 PAPAYAL  (LAG)' as nombre, 'XX10' as padre from dual union all
      SELECT 'Z047' as ID, 'BARRIO 2 PAPAYAL  (LAG)' as nombre, 'XX10' as padre from dual union all
      SELECT 'Z048' as ID, 'BARRIO 1 BARRANCAS  (LAG)' as nombre, 'XX11' as padre from dual union all
      SELECT 'Z049' as ID, 'BARRIO 2 BARRANCAS  (LAG)' as nombre, 'XX11' as padre from dual union all
      SELECT 'Z050' as ID, 'BARRIO 3 BARRANCAS  (LAG)' as nombre, 'XX11' as padre from dual union all
      SELECT 'Z051' as ID, 'BARRIO 4 BARRANCAS  (LAG)' as nombre, 'XX11' as padre from dual union all
      SELECT 'Z052' as ID, 'BARRIO 1 FONSECA (LAG)' as nombre, 'XX12' as padre from dual union all
      SELECT 'Z053' as ID, 'BARRIO 2 FONSECA  (LAG)' as nombre, 'XX12' as padre from dual union all
      SELECT 'Z054' as ID, 'BARRIO 3 FONSECA  (LAG)' as nombre, 'XX12' as padre from dual union all
      SELECT 'Z055' as ID, 'BARRIO 4 FONSECA  (LAG)' as nombre, 'XX12' as padre from dual union all
      SELECT 'Z056' as ID, 'BARRIO 5 FONSECA  (LAG)' as nombre, 'XX12' as padre from dual union all
      SELECT 'Z057' as ID, 'BARRIO 6 FONSECA  (LAG)' as nombre, 'XX12' as padre from dual union all
      SELECT 'Z058' as ID, 'BARRIO 1 SAN JUAN DEL CESAR (LAG)' as nombre, 'XX13' as padre from dual union all
      SELECT 'Z059' as ID, 'BARRIO 2 SAN JUAN DEL CESAR  (LAG)' as nombre, 'XX13' as padre from dual union all
      SELECT 'Z060' as ID, 'BARRIO 3 SAN JUAN DEL CESAR  (LAG)' as nombre, 'XX13' as padre from dual union all
      SELECT 'Z061' as ID, 'BARRIO 4 SAN JUAN DEL CESAR  (LAG)' as nombre, 'XX13' as padre from dual union all
      SELECT 'Z062' as ID, 'BARRIO 5 SAN JUAN DEL CESAR  (LAG)' as nombre, 'XX13' as padre from dual union all
      SELECT 'Z063' as ID, 'BARRIO 6 SAN JUAN DEL CESAR  (LAG)' as nombre, 'XX13' as padre from dual union all
      SELECT 'Z064' as ID, 'BARRIO 1 EL MOLINO  (LAG)' as nombre, 'XX14' as padre from dual union all
      SELECT 'Z065' as ID, 'BARRIO 2 EL MOLINO  (LAG)' as nombre, 'XX14' as padre from dual union all
      SELECT 'Z066' as ID, 'BARRIO 1 VILLANUEVA (LAG)' as nombre, 'XX15' as padre from dual union all
      SELECT 'Z067' as ID, 'BARRIO 2 VILLANUEVA  (LAG)' as nombre, 'XX15' as padre from dual union all
      SELECT 'Z068' as ID, 'BARRIO 3 VILLANUEVA  (LAG)' as nombre, 'XX15' as padre from dual union all
      SELECT 'Z069' as ID, 'BARRIO 4 VILLANUEVA  (LAG)' as nombre, 'XX15' as padre from dual union all
      SELECT 'Z070' as ID, 'BARRIO 5 VILLANUEVA  (LAG)' as nombre, 'XX15' as padre from dual union all
      SELECT 'Z071' as ID, 'BARRIO 6 VILLANUEVA  (LAG)' as nombre, 'XX15' as padre from dual union all
      SELECT 'Z072' as ID, 'BARRIO 1 URUMITA  (LAG)' as nombre, 'XX16' as padre from dual union all
      SELECT 'Z073' as ID, 'BARRIO 2 URUMITA  (LAG)' as nombre, 'XX16' as padre from dual union all
      SELECT 'Z074' as ID, 'BARRIO 1 DISTRACCION (LAG)' as nombre, 'XX17' as padre from dual union all
      SELECT 'Z075' as ID, 'BARRIO 1 BUENAVISTA (LAG)' as nombre, 'XX18' as padre from dual union all
      SELECT 'Z076' as ID, 'BARRIO 1 ALBANIA (LAG)' as nombre, 'XX19' as padre from dual union all
      SELECT 'Z077' as ID, 'BARRIO 2 ALBANIA (LAG)' as nombre, 'XX19' as padre from dual union all
      SELECT 'Z078' as ID, 'BARRIO 1 CUESTECITA (LAG)' as nombre, 'XX20' as padre from dual union all
      SELECT 'Z079' as ID, 'BARRIO 1 LA PUNTA DE LOS REMEDIOS (LAG)' as nombre, 'XX21' as padre from dual union all
      SELECT 'Z080' as ID, 'BARRIO 1 LAS FLORES (LAG)' as nombre, 'XX22' as padre from dual union all
      SELECT 'Z081' as ID, 'BARRIO 1 RIO ANCHO (LAG)' as nombre, 'XX23' as padre from dual union all
      SELECT 'Z082' as ID, 'BARRIO 1 LA JAGUA DEL PILAR (LAG)' as nombre, 'XX24' as padre from dual union all
      SELECT 'Z083' as ID, 'BARRIO 1 EL PAJARO (LAG)' as nombre, 'XX25' as padre from dual union all
      SELECT 'Z084' as ID, 'BARRIO 1 LOS PONDORES (LAG)' as nombre, 'XX26' as padre from dual union all
      SELECT 'Z085' as ID, 'BARRIO 1 EL EBANAL (LAG)' as nombre, 'XX27' as padre from dual union all
      SELECT 'Z086' as ID, 'BARRIO 1 TIGRERAS (LAG)' as nombre, 'XX28' as padre from dual union all
      SELECT 'Z087' as ID, 'BARRIO 1 COMEJENES (LAG)' as nombre, 'XX29' as padre from dual union all
      SELECT 'Z088' as ID, 'BARRIO 1 CHOLES (LAG)' as nombre, 'XX30' as padre from dual union all
      SELECT 'Z089' as ID, 'BARRIO 1 ANAIME (LAG)' as nombre, 'XX31' as padre from dual union all
      SELECT 'Z090' as ID, 'BARRIO 1 MATITAS (LAG)' as nombre, 'XX32' as padre from dual union all
      SELECT 'Z091' as ID, 'BARRIO 1 PUENTE BOMBA (LAG)' as nombre, 'XX33' as padre from dual union all
      SELECT 'Z092' as ID, 'BARRIO 1 PELECHUA (LAG)' as nombre, 'XX34' as padre from dual union all
      SELECT 'Z093' as ID, 'BARRIO 1 PARAGUACHON (LAG)' as nombre, 'XX35' as padre from dual union all
      SELECT 'Z094' as ID, 'BARRIO 1 GUAYACANAL (LAG)' as nombre, 'XX36' as padre from dual union all
      SELECT 'Z095' as ID, 'BARRIO 1 EL HATICO (LAG)' as nombre, 'XX37' as padre from dual union all
      SELECT 'Z096' as ID, 'BARRIO 1 TABACO RUBIO (LAG)' as nombre, 'XX38' as padre from dual union all
      SELECT 'Z097' as ID, 'BARRIO 1 CERREJON (LAG)' as nombre, 'XX39' as padre from dual union all
      SELECT 'Z098' as ID, 'BARRIO 1 AREMASAIN (LAG)' as nombre, 'XX40' as padre from dual union all
      SELECT 'Z099' as ID, 'BARRIO 1 LA GLORIA (LAG)' as nombre, 'XX41' as padre from dual union all
      SELECT 'Z100' as ID, 'BARRIO 1 CARRAIPIA (LAG)' as nombre, 'XX42' as padre from dual union all
      SELECT 'Z101' as ID, 'BARRIO 1 CARRETALITO (LAG)' as nombre, 'XX43' as padre from dual union all
      SELECT 'Z102' as ID, 'BARRIO 1 NUEVO OREGANAL (LAG)' as nombre, 'XX44' as padre from dual union all
      SELECT 'Z103' as ID, 'BARRIO 1 CONEJO (LAG)' as nombre, 'XX45' as padre from dual union all
      SELECT 'Z104' as ID, 'BARRIO 1 PERICO (LAG)' as nombre, 'XX46' as padre from dual union all
      SELECT 'Z105' as ID, 'BARRIO 1 CANAVERALES (LAG)' as nombre, 'XX47' as padre from dual union all
      SELECT 'Z106' as ID, 'BARRIO 1 LA JUNTA (LAG)' as nombre, 'XX48' as padre from dual union all
      SELECT 'Z107' as ID, 'BARRIO 1 CORRALEJA (LAG)' as nombre, 'XX49' as padre from dual union all
      SELECT 'Z108' as ID, 'BARRIO 1 EL TABLAZO (LAG)' as nombre, 'XX50' as padre from dual union all
      SELECT 'Z109' as ID, 'BARRIO 1 LA PENA (LAG)' as nombre, 'XX51' as padre from dual union all
      SELECT 'Z110' as ID, 'BARRIO 1 LOS POZOS (LAG)' as nombre, 'XX52' as padre from dual union all
      SELECT 'Z111' as ID, 'BARRIO 1 CAMPANA NUEVO (LAG)' as nombre, 'XX53' as padre from dual union all
      SELECT 'Z112' as ID, 'BARRIO 1 CHORRERA (LAG)' as nombre, 'XX54' as padre from dual union all
      SELECT 'Z113' as ID, 'BARRIO 1 ZAMBRANO (LAG)' as nombre, 'XX55' as padre from dual union all
      SELECT 'Z114' as ID, 'BARRIO 1 CURAZAO (LAG)' as nombre, 'XX56' as padre from dual union all
      SELECT 'Z115' as ID, 'BARRIO 1 MONGUI (LAG)' as nombre, 'XX57' as padre from dual union all
      SELECT 'Z116' as ID, 'BARRIO 1 GALAN (LAG)' as nombre, 'XX58' as padre from dual union all
      SELECT 'Z117' as ID, 'BARRIO 1 ARROYO ARENA (LAG)' as nombre, 'XX59' as padre from dual union all
      SELECT 'Z118' as ID, 'BARRIO 1 TOMARRAZON (LAG)' as nombre, 'XX60' as padre from dual union all
      SELECT 'Z119' as ID, 'BARRIO 1 BARBACOA (LAG)' as nombre, 'XX61' as padre from dual union all
      SELECT 'Z120' as ID, 'BARRIO 1 COTOPRIX (LAG)' as nombre, 'XX62' as padre from dual union all
      SELECT 'Z121' as ID, 'BARRIO 1 VILLA MARTIN (LAG)' as nombre, 'XX63' as padre from dual union all
      SELECT 'Z122' as ID, 'BARRIO 1 CERRILLO (LAG)' as nombre, 'XX64' as padre from dual union all
      SELECT 'Z123' as ID, 'BARRIO 1 ROCHE (LAG)' as nombre, 'XX65' as padre from dual union all
      SELECT 'Z124' as ID, 'BARRIO 1 PATILLA (LAG)' as nombre, 'XX66' as padre from dual union all
      SELECT 'Z125' as ID, 'BARRIO 1 CHANCLETA (LAG)' as nombre, 'XX67' as padre from dual union all
      SELECT 'Z126' as ID, 'BARRIO 1 LAS CASITAS (LAG)' as nombre, 'XX68' as padre from dual union all
      SELECT 'Z127' as ID, 'BARRIO 1 CORRAL DE PIEDRA (LAG)' as nombre, 'XX69' as padre from dual union all
      SELECT 'Z128' as ID, 'BARRIO 1 EL TOTUMO (LAG)' as nombre, 'XX70' as padre from dual union all
      SELECT 'Z129' as ID, 'BARRIO 1 GUAYACANAL (SAN JUAN) (LAG)' as nombre, 'XX71' as padre from dual union all
      SELECT 'Z130' as ID, 'BARRIO 1 LOS HATICOS (SAN JUAN) (LAG)' as nombre, 'XX72' as padre from dual union all
      SELECT 'Z131' as ID, 'BARRIO 1 VILLA DEL RIO (LAG)' as nombre, 'XX73' as padre from dual union all
      SELECT 'Z132' as ID, 'BARRIO 1 LAGUNITA (LAG)' as nombre, 'XX74' as padre from dual union all
      SELECT 'Z133' as ID, 'BARRIO 1 EL ABRA (LAG)' as nombre, 'XX75' as padre from dual union all
      SELECT 'Z134' as ID, 'BARRIO 1 LOS MORENEROS (LAG)' as nombre, 'XX76' as padre from dual union all
      SELECT 'Z135' as ID, 'BARRIO 1 JUAN Y MEDIO (LAG)' as nombre, 'XX77' as padre from dual union all
      SELECT 'Z136' as ID, 'BARRIO 1 LOS HORNITOS (LAG)' as nombre, 'XX78' as padre from dual union all
      SELECT 'Z137' as ID, 'BARRIO 1 CERRO PERALTA (LAG)' as nombre, 'XX79' as padre from dual union all
      SELECT 'Z138' as ID, 'BARRIO 1 TAMAQUITO II (LAG)' as nombre, 'XX80' as padre from dual union all
      SELECT 'Z139' as ID, 'BARRIO 1 POZO HONDO (LAG)' as nombre, 'XX81' as padre from dual union all
      SELECT 'Z140' as ID, 'BARRIO 1 TOCAPALMA (LAG)' as nombre, 'XX82' as padre from dual
      )
      select *
    from base
    where padre =nuPadre
      and not exists(select null from open.ge_geogra_location where description=base.nombre);
  
begin
    dbms_output.put_line('CODIGO_EXCEL|NOMBRE|CODIGO_OSF|RESULTADO');
    for loc in cuDatosLoca loop
      inuLocalidad    := null;
      nuError         := null;
      sbError         := null;
      
      OS_INSGEOGRAPLOCATION(loc.nombre, -- Nombre de la ubicacion
                            nuDepartamId, -- Area Padre: Una Localidad
                            nuTipoAreaLoca, -- Tipo de area: 4 = Sector Operativo
                            'Y', -- Assing Level
                            'Y', -- Normalized
                            null, --id oper sector
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL,
                            NULL, --
                            NULL, -- shape
                            inuLocalidad, -- Id de la nueva ubicacion creada
                            nuError,
                            sbError -- Errores
                            );
      if nuError = 0 then
        commit;
        dbms_output.put_line(loc.id||'|'||loc.nombre||'|'||inuLocalidad||'|OK');
        
        for sect in cuDatosSector(loc.id) loop
            inuSectorId     := null;
            nuError         := null;
            sbError         := null;
            OS_INSGEOGRAPLOCATION(sect.nombre, -- Nombre de la ubicacion
                                  inuLocalidad, -- Area Padre: Una Localidad
                                  nuTipoAreaSect, -- Tipo de area: 4 = Sector Operativo
                                  'Y', -- Assing Level
                                  'Y', -- Normalized
                                  null, --id oper sector
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL, --
                                  NULL, -- shape
                                  inuSectorId, -- Id de la nueva ubicacion creada
                                  nuError,
                                  sbError -- Errores
                                  );
            if nuError = 0 then
               nuError := null;
               sbError := null;
               
               OS_CREATE_OPER_SECTOR(inuSectorId,
                                    sect.nombre, -- Nombre de la ubicacion
                                    nuClassifOperSector,
                                    sbShape,
                                    nuError,
                                    sbError);
               if nuError = 0 then
                 
                  os_updgeograplocation(inuSectorId,
                                        sect.nombre,
                                        nuTipoAreaSect,
                                        'Y',
                                        'Y',
                                        inuSectorId,
                                        NULL,
                                        NULL,
                                        NULL,
                                        NULL,
                                        NULL,
                                        NULL, --
                                        NULL, -- shape
                                        nuError,
                                        sbError -- Errores
                                        );
                  if nuError = 0 then                               
                     commit;
                     dbms_output.put_line(sect.id||'|'||sect.nombre||'|'||inuSectorId||'|OK');
                  else
                    rollback;
                    dbms_output.put_line(sect.id||'|'||sect.nombre||'|'||inuSectorId||'|Sector3: '||sbError);

                  end if;
               else
                  rollback;
                  dbms_output.put_line(sect.id||'|'||sect.nombre||'|'||inuSectorId||'|Sector2: '||sbError);
               end if;
               
            else --error sectores
              rollback;
              dbms_output.put_line(sect.id||'|'||sect.nombre||'|'||inuSectorId||'|Sector1: '||sbError);
            end if;
        end loop; --sectores 
        for barr in cuBarrios(loc.id) loop
            inuBarrioId    := null;
            nuError        := null;
            sbError        := null;
            OS_INSGEOGRAPLOCATION(barr.nombre, -- Nombre de la ubicacion
                                  inuLocalidad, -- Area Padre: Una Localidad
                                  nuTipoAreaBarr, -- Tipo de area: 4 = Sector Operativo
                                  'Y', -- Assing Level
                                  'Y', -- Normalized
                                  null, --id oper sector
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL,
                                  NULL, --
                                  NULL, -- shape
                                  inuBarrioId, -- Id de la nueva ubicacion creada
                                  nuError,
                                  sbError -- Errores
                                  );
            if   nuError = 0 then
                 commit;
                 dbms_output.put_line(barr.id||'|'||barr.nombre||'|'||inuBarrioId||'|OK');
            else
                 rollback;
                 dbms_output.put_line(barr.id||'|'||barr.nombre||'|'||inuBarrioId||'|'||sbError);
            end if; --barrios
        end loop;
      else --error localidades
        rollback;
        dbms_output.put_line(loc.id||'|'||loc.nombre||'|'||inuLocalidad||'|'||sbError);
      end if;
    end loop;
end;
/
