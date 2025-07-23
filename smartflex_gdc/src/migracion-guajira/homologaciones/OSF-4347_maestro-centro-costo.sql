begin
 insert into ldci_centrocosto
 with base as(
select '611340' as codigo, 'BRILLA-SAN JUAN DEL CESAR' descripcion, '' bloqprim, '' bloqing from dual union all
select '611440' as codigo, 'BRILLA-EL MOLINO' descripcion, '' bloqprim, '' bloqing from dual union all
select '680132' as codigo, 'IMPUESTOS-BARRANQUILLA' descripcion, '' bloqprim, 'X' bloqing from dual union all
select '610340' as codigo, 'BRILLA-DISTRACCION' descripcion, '' bloqprim, '' bloqing from dual union all
select '610640' as codigo, 'BRILLA-DIBULLA' descripcion, '' bloqprim, '' bloqing from dual union all
select '610740' as codigo, 'BRILLA-URIBIA' descripcion, '' bloqprim, '' bloqing from dual union all
select '610940' as codigo, 'BRILLA-HATONUEVO' descripcion, '' bloqprim, '' bloqing from dual union all
select '611040' as codigo, 'BRILLA-ALBANIA' descripcion, '' bloqprim, '' bloqing from dual union all
select '610101' as codigo, 'CityGate-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610102' as codigo, 'Estaci??n de Reg y Med-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610103' as codigo, 'Red de Acero-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610104' as codigo, 'Redes de Polietileno-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610106' as codigo, 'Acometida y Centros de Medici??n-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610107' as codigo, 'Instalaciones Internas-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610108' as codigo, 'Revisi??n Peri??dica-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610109' as codigo, 'Servicios Varios-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610120' as codigo, 'Compresi??n Virtual-.Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610130' as codigo, 'Oficinas Atenci??n Usuario-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610131' as codigo, 'Centro de Recaudo-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610132' as codigo, 'Impuestos-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610133' as codigo, 'Cartera-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610134' as codigo, 'Facturaci??n-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610140' as codigo, 'BRILLA-RIOHACHA' descripcion, '' bloqprim, '' bloqing from dual union all
select '610141' as codigo, 'Seguros-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610142' as codigo, 'Kit Vehicular-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610150' as codigo, 'Laboratorio de Metrolog?-a-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610151' as codigo, 'Servicios Varios Industrial-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610152' as codigo, 'Back Office E2' descripcion, '' bloqprim, '' bloqing from dual union all
select '610153' as codigo, 'Bodega-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610154' as codigo, 'Unidad T??cnica de inspecci??n-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610155' as codigo, 'Call Center Negocio' descripcion, '' bloqprim, '' bloqing from dual union all
select '610160' as codigo, 'Gas Natural y Uso L?-neas Redes-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610191' as codigo, 'Emergencia-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610199' as codigo, 'Manejo Inter Sistema-Riohacha' descripcion, '' bloqprim, '' bloqing from dual union all
select '610201' as codigo, 'CityGate-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610202' as codigo, 'Estaci??n de Reg y Med-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610203' as codigo, 'Red de Acero-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610204' as codigo, 'REDES DE POLIETILENO-MAICAO' descripcion, '' bloqprim, '' bloqing from dual union all
select '610206' as codigo, 'ACOMETIDA Y CENTROS DE MEDICION-MAICAO' descripcion, '' bloqprim, '' bloqing from dual union all
select '610207' as codigo, 'Instalaciones Internas-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610208' as codigo, 'Revisi??n Peri??dica-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610209' as codigo, 'Servicios Varios-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610230' as codigo, 'OFICINAS ATENCION USUARIO-MAICAO' descripcion, '' bloqprim, '' bloqing from dual union all
select '610231' as codigo, 'Centro de Recaudo-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610232' as codigo, 'Impuestos-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610233' as codigo, 'Cartera-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610234' as codigo, 'Facturaci??n-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610251' as codigo, 'Servicios Varios Industrial-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610253' as codigo, 'Bodega-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610260' as codigo, 'Gas Natural y Uso L?-neas Redes-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610291' as codigo, 'Emergencia-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610299' as codigo, 'Manejo Inter Sistema-Maicao' descripcion, '' bloqprim, '' bloqing from dual union all
select '610301' as codigo, 'CityGate-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610302' as codigo, 'Estaci??n de Reg y Med-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610303' as codigo, 'Red de Acero-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610304' as codigo, 'Redes de Polietileno-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610306' as codigo, 'Acometida y Centros de Medici??n-Distracc' descripcion, '' bloqprim, '' bloqing from dual union all
select '610307' as codigo, 'Instalaciones Internas-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610308' as codigo, 'Revisi??n Peri??dica-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610309' as codigo, 'Servicios Varios-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610330' as codigo, 'Oficinas Atenci??n Usuario-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610331' as codigo, 'Centro de Recaudo-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610332' as codigo, 'Impuestos-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610333' as codigo, 'Cartera-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610334' as codigo, 'Facturaci??n-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610351' as codigo, 'Servicios Varios Industrial-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610353' as codigo, 'Bodega-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610360' as codigo, 'Gas Natural y Uso L?-neas Redes-Distracc' descripcion, '' bloqprim, '' bloqing from dual union all
select '610391' as codigo, 'Emergencia-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610399' as codigo, 'Manejo Inter Sistema-Distracci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '610401' as codigo, 'CityGate-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610402' as codigo, 'Estaci??n de Reg y Med-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610403' as codigo, 'Red de Acero-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610404' as codigo, 'Redes de Polietileno-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610406' as codigo, 'Acometida y Centros de Medici??n-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610407' as codigo, 'Instalaciones Internas-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610408' as codigo, 'Revisi??n Peri??dica-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610409' as codigo, 'Servicios Varios-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610430' as codigo, 'OFICINAS ATENCION USUARIO-URUMITA' descripcion, '' bloqprim, '' bloqing from dual union all
select '610431' as codigo, 'Centro de Recaudo-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610432' as codigo, 'Impuestos-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610433' as codigo, 'Cartera-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610434' as codigo, 'Facturaci??n-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610451' as codigo, 'Servicios Varios Industrial-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610453' as codigo, 'Bodega-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610460' as codigo, 'Gas Natural y Uso L?-neas Redes-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610491' as codigo, 'Emergencia-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610499' as codigo, 'Manejo Inter Sistema-Urumita' descripcion, '' bloqprim, '' bloqing from dual union all
select '610501' as codigo, 'CityGate-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610502' as codigo, 'Estaci??n de Reg y Med-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610503' as codigo, 'Red de Acero-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610504' as codigo, 'Redes de Polietileno-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610506' as codigo, 'Acometida y Centros de Medici??n-La Jagua' descripcion, '' bloqprim, '' bloqing from dual union all
select '610507' as codigo, 'Instalaciones Internas-La Jagua' descripcion, '' bloqprim, '' bloqing from dual union all
select '610508' as codigo, 'Revisi??n Peri??dica-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610509' as codigo, 'Servicios Varios-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610530' as codigo, 'Oficinas Atenci??n Usuario-La Jagua' descripcion, '' bloqprim, '' bloqing from dual union all
select '610531' as codigo, 'Centro de Recaudo-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610532' as codigo, 'Impuestos-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610533' as codigo, 'Cartera-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610534' as codigo, 'Facturaci??n-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610551' as codigo, 'Servicios Varios Industrial-La Jagua' descripcion, '' bloqprim, '' bloqing from dual union all
select '610553' as codigo, 'Bodega-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610560' as codigo, 'Gas Natural y Uso L?-neas Redes-La Jagua' descripcion, '' bloqprim, '' bloqing from dual union all
select '610591' as codigo, 'Emergencia-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610599' as codigo, 'Manejo Inter Sistema-La Jagua del Pilar' descripcion, '' bloqprim, '' bloqing from dual union all
select '610601' as codigo, 'CityGate-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610602' as codigo, 'Estaci??n de Reg y Med-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610603' as codigo, 'Red de Acero-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610604' as codigo, 'Redes de Polietileno-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610606' as codigo, 'Acometida y Centros de Medici??n-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610607' as codigo, 'Instalaciones Internas-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610608' as codigo, 'Revisi??n Peri??dica-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610609' as codigo, 'Servicios Varios-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610630' as codigo, 'Oficinas Atenci??n Usuario-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610631' as codigo, 'Centro de Recaudo-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610632' as codigo, 'Impuestos-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610633' as codigo, 'Cartera-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610634' as codigo, 'Facturaci??n-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610651' as codigo, 'Servicios Varios Industrial-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610653' as codigo, 'Bodega-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610660' as codigo, 'Gas Natural y Uso L?-neas Redes-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610691' as codigo, 'Emergencia-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610699' as codigo, 'Manejo Inter Sistema-Dibulla' descripcion, '' bloqprim, '' bloqing from dual union all
select '610701' as codigo, 'CityGate-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610702' as codigo, 'Estaci??n de Reg y Med-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610703' as codigo, 'Red de Acero-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610704' as codigo, 'Redes de Polietileno-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610706' as codigo, 'Acometida y Centros de Medici??n-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610707' as codigo, 'Instalaciones Internas-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610708' as codigo, 'Revisi??n Peri??dica-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610709' as codigo, 'Servicios Varios-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610730' as codigo, 'Oficinas Atenci??n Usuario-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610731' as codigo, 'Centro de Recaudo-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610732' as codigo, 'Impuestos-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610733' as codigo, 'Cartera-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610734' as codigo, 'Facturaci??n-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610751' as codigo, 'Servicios Varios Industrial-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610753' as codigo, 'Bodega-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610760' as codigo, 'Gas Natural y Uso L?-neas Redes-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610791' as codigo, 'Emergencia-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610799' as codigo, 'Manejo Inter Sistema-Uribia' descripcion, '' bloqprim, '' bloqing from dual union all
select '610801' as codigo, 'CityGate-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610802' as codigo, 'Estaci??n de Reg y Med-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610803' as codigo, 'Red de Acero-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610804' as codigo, 'Redes de Polietileno-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610806' as codigo, 'Acometida y Centros de Medici??n-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610807' as codigo, 'Instalaciones Internas-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610808' as codigo, 'Revisi??n Peri??dica-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610809' as codigo, 'Servicios Varios-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610830' as codigo, 'OFICINAS ATENCION USUARIO-MANAURE' descripcion, '' bloqprim, '' bloqing from dual union all
select '610831' as codigo, 'Centro de Recaudo-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610832' as codigo, 'Impuestos-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610833' as codigo, 'Cartera-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610834' as codigo, 'Facturaci??n-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610851' as codigo, 'Servicios Varios Industrial-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610853' as codigo, 'Bodega-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610860' as codigo, 'Gas Natural y Uso L?-neas Redes-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610891' as codigo, 'Emergencia-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610899' as codigo, 'Manejo Inter Sistema-Manaure' descripcion, '' bloqprim, '' bloqing from dual union all
select '610901' as codigo, 'CityGate-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610902' as codigo, 'Estaci??n de Reg y Med-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610903' as codigo, 'Red de Acero-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610904' as codigo, 'Redes de Polietileno-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610906' as codigo, 'Acometida y Centros de Medici??n-Hatonuev' descripcion, '' bloqprim, '' bloqing from dual union all
select '610907' as codigo, 'Instalaciones Internas-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610908' as codigo, 'Revisi??n Peri??dica-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610909' as codigo, 'Servicios Varios-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610930' as codigo, 'Oficinas Atenci??n Usuario-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610931' as codigo, 'Centro de Recaudo-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610932' as codigo, 'Impuestos-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610933' as codigo, 'Cartera-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610934' as codigo, 'Facturaci??n-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610951' as codigo, 'Servicios Varios Industrial-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610953' as codigo, 'Bodega-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610960' as codigo, 'Gas Natural y Uso L?-neas Redes-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610991' as codigo, 'Emergencia-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '610999' as codigo, 'Manejo Inter Sistema-Hatonuevo' descripcion, '' bloqprim, '' bloqing from dual union all
select '611001' as codigo, 'CityGate-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611002' as codigo, 'Estaci??n de Reg y Med-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611003' as codigo, 'Red de Acero-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611004' as codigo, 'Redes de Polietileno-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611006' as codigo, 'Acometida y Centros de Medici??n-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611007' as codigo, 'Instalaciones Internas-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611008' as codigo, 'Revisi??n Peri??dica-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611009' as codigo, 'Servicios Varios-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611030' as codigo, 'Oficinas Atenci??n Usuario-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611031' as codigo, 'Centro de Recaudo-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611032' as codigo, 'Impuestos-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611033' as codigo, 'Cartera-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611034' as codigo, 'Facturaci??n-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611051' as codigo, 'Servicios Varios Industrial-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611053' as codigo, 'Bodega-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611060' as codigo, 'Gas Natural y Uso L?-neas Redes-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611091' as codigo, 'Emergencia-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611099' as codigo, 'Manejo Inter Sistema-Albania' descripcion, '' bloqprim, '' bloqing from dual union all
select '611101' as codigo, 'CityGate-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611102' as codigo, 'Estaci??n de Reg y Med-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611103' as codigo, 'Red de Acero-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611104' as codigo, 'Redes de Polietileno-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611106' as codigo, 'Acometida y Centros de Medici??n-Barranca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611107' as codigo, 'Instalaciones Internas-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611108' as codigo, 'Revisi??n Peri??dica-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611109' as codigo, 'Servicios Varios-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611130' as codigo, 'Oficinas Atenci??n Usuario-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611131' as codigo, 'Centro de Recaudo-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611132' as codigo, 'Impuestos-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611133' as codigo, 'Cartera-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611134' as codigo, 'Facturaci??n-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611151' as codigo, 'Servicios Varios Industrial-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611153' as codigo, 'Bodega-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611160' as codigo, 'Gas Natural y Uso L?-neas Redes-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611191' as codigo, 'Emergencia-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611199' as codigo, 'Manejo Inter Sistema-Barrancas' descripcion, '' bloqprim, '' bloqing from dual union all
select '611201' as codigo, 'CityGate-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611202' as codigo, 'Estaci??n de Reg y Med-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611203' as codigo, 'Red de Acero-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611204' as codigo, 'Redes de Polietileno-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611206' as codigo, 'ACOMETIDA Y CENTROS DE MEDICION-FONSECA' descripcion, '' bloqprim, '' bloqing from dual union all
select '611207' as codigo, 'Instalaciones Internas-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611208' as codigo, 'Revisi??n Peri??dica-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611209' as codigo, 'Servicios Varios-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611230' as codigo, 'OFICINAS ATENCION USUARIO-FONSECA' descripcion, '' bloqprim, '' bloqing from dual union all
select '611231' as codigo, 'Centro de Recaudo-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611232' as codigo, 'Impuestos-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611233' as codigo, 'Cartera-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611234' as codigo, 'Facturaci??n-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611251' as codigo, 'Servicios Varios Industrial-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611253' as codigo, 'Bodega-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611260' as codigo, 'Gas Natural y Uso L?-neas Redes-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611291' as codigo, 'Emergencia-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611299' as codigo, 'Manejo Inter Sistema-Fonseca' descripcion, '' bloqprim, '' bloqing from dual union all
select '611301' as codigo, 'CityGate-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611302' as codigo, 'Estaci??n de Reg y Med-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611303' as codigo, 'Red de Acero-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611304' as codigo, 'Redes de Polietileno-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611306' as codigo, 'ACOMETIDA Y CENTROS DE MEDICION-SANJUAN' descripcion, '' bloqprim, '' bloqing from dual union all
select '611307' as codigo, 'Instalaciones Internas-SanJuan' descripcion, '' bloqprim, '' bloqing from dual union all
select '611308' as codigo, 'Revisi??n Peri??dica-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611309' as codigo, 'Servicios Varios-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611330' as codigo, 'OFICINAS ATENCION USUARIO-SANJUAN' descripcion, '' bloqprim, '' bloqing from dual union all
select '611331' as codigo, 'Centro de Recaudo-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611332' as codigo, 'Impuestos-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611333' as codigo, 'Cartera-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611334' as codigo, 'Facturaci??n-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611351' as codigo, 'Servicios Varios Industrial-SanJuan' descripcion, '' bloqprim, '' bloqing from dual union all
select '611353' as codigo, 'Bodega-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611360' as codigo, 'Gas Natural y Uso L?-neas Redes-SanJuan' descripcion, '' bloqprim, '' bloqing from dual union all
select '611391' as codigo, 'Emergencia-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611399' as codigo, 'Manejo Inter Sistema-San Juan del Cesar' descripcion, '' bloqprim, '' bloqing from dual union all
select '611401' as codigo, 'CityGate-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611402' as codigo, 'Estaci??n de Reg y Med-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611403' as codigo, 'Red de Acero-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611404' as codigo, 'Redes de Polietileno-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611406' as codigo, 'Acometida y Centros de Medici??n-ElMolino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611407' as codigo, 'Instalaciones Internas-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611408' as codigo, 'Revisi??n Peri??dica-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611409' as codigo, 'Servicios Varios-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611430' as codigo, 'Oficinas Atenci??n Usuario-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611431' as codigo, 'Centro de Recaudo-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611432' as codigo, 'Impuestos-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611433' as codigo, 'Cartera-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611434' as codigo, 'Facturaci??n-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611451' as codigo, 'Servicios Varios Industrial-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611453' as codigo, 'Bodega-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611460' as codigo, 'Gas Natural y Uso L?-neas Redes-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611491' as codigo, 'Emergencia-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611499' as codigo, 'Manejo Inter Sistema-El Molino' descripcion, '' bloqprim, '' bloqing from dual union all
select '611501' as codigo, 'CityGate-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611502' as codigo, 'Estaci??n de Reg y Med-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611503' as codigo, 'Red de Acero-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611504' as codigo, 'REDES DE POLIETILENO-VILLANUEVA' descripcion, '' bloqprim, '' bloqing from dual union all
select '611506' as codigo, 'Acometida y Centros de Medici??n-Villanue' descripcion, '' bloqprim, '' bloqing from dual union all
select '611507' as codigo, 'Instalaciones Internas-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611508' as codigo, 'Revisi??n Peri??dica-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611509' as codigo, 'Servicios Varios-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611530' as codigo, 'Oficinas Atenci??n Usuario-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611531' as codigo, 'Centro de Recaudo-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611532' as codigo, 'Impuestos-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611533' as codigo, 'Cartera-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611534' as codigo, 'Facturaci??n-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611551' as codigo, 'Servicios Varios Industrial-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611553' as codigo, 'Bodega-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611560' as codigo, 'Gas Natural y Uso L?-neas Redes-Villanue' descripcion, '' bloqprim, '' bloqing from dual union all
select '611591' as codigo, 'Emergencia-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '611599' as codigo, 'Manejo Inter Sistema-Villanueva' descripcion, '' bloqprim, '' bloqing from dual union all
select '690000' as codigo, 'Corporativo' descripcion, '' bloqprim, '' bloqing from dual union all
select '690101' as codigo, 'GERENCIA GENERAL' descripcion, '' bloqprim, '' bloqing from dual union all
select '690111' as codigo, 'AUDITORIA INTERNA' descripcion, '' bloqprim, '' bloqing from dual union all
select '690201' as codigo, 'SUBGERENCIA FINANCIERA' descripcion, '' bloqprim, '' bloqing from dual union all
select '690202' as codigo, 'Planeaci??n' descripcion, '' bloqprim, '' bloqing from dual union all
select '690203' as codigo, 'JURIDICO' descripcion, '' bloqprim, '' bloqing from dual union all
select '690204' as codigo, 'INFORMATICA' descripcion, '' bloqprim, '' bloqing from dual union all
select '690205' as codigo, 'AREA FNB' descripcion, '' bloqprim, '' bloqing from dual union all
select '690206' as codigo, 'GESTION HUMANA' descripcion, '' bloqprim, '' bloqing from dual union all
select '690211' as codigo, 'VENTAS' descripcion, '' bloqprim, '' bloqing from dual union all
select '690212' as codigo, 'ATENCION AL USUARIO' descripcion, '' bloqprim, '' bloqing from dual union all
select '690213' as codigo, 'CARTERA' descripcion, '' bloqprim, '' bloqing from dual union all
select '690214' as codigo, 'FACTURACION' descripcion, '' bloqprim, '' bloqing from dual union all
select '690221' as codigo, 'COMPRAS Y SUMINSITROS' descripcion, '' bloqprim, '' bloqing from dual union all
select '690222' as codigo, 'SERVICIOS GENERALES' descripcion, '' bloqprim, '' bloqing from dual union all
select '690231' as codigo, 'Tesorer?-a' descripcion, '' bloqprim, '' bloqing from dual union all
select '690232' as codigo, 'Recaudos tesorer?-a' descripcion, '' bloqprim, '' bloqing from dual union all
select '690241' as codigo, 'Contabilidad' descripcion, '' bloqprim, '' bloqing from dual union all
select '690251' as codigo, 'CONTROL DE CALIDAD' descripcion, '' bloqprim, '' bloqing from dual union all
select '690252' as codigo, 'GESTION DOCUMENTAL' descripcion, '' bloqprim, '' bloqing from dual union all
select '690301' as codigo, 'SUBGERENCIA TECNICA' descripcion, '' bloqprim, '' bloqing from dual union all
select '690311' as codigo, 'OPERACION Y MANTENIMIENTO' descripcion, '' bloqprim, '' bloqing from dual union all
select '690321' as codigo, 'Construcciones e Instalaciones' descripcion, '' bloqprim, '' bloqing from dual union all
select '690322' as codigo, 'Instalaciones' descripcion, '' bloqprim, '' bloqing from dual union all
select '690323' as codigo, 'REDES' descripcion, '' bloqprim, '' bloqing from dual union all
select '690331' as codigo, 'Sistema Info. Geogr?!fica GIS' descripcion, '' bloqprim, '' bloqing from dual union all
select '690341' as codigo, 'REVISION PERIODICA' descripcion, '' bloqprim, '' bloqing from dual union all
select '699992' as codigo, 'AJUSTES COLGAAP GDGU' descripcion, '' bloqprim, '' bloqing from dual union all
select '699998' as codigo, 'CIERRE FI GDGU' descripcion, '' bloqprim, '' bloqing from dual union all
select '699999' as codigo, 'CIERRE FI-GDGU' descripcion, '' bloqprim, '' bloqing from dual union all
select '610240' as codigo, 'BRILLA-MAICAO' descripcion, '' bloqprim, '' bloqing from dual union all
select '610440' as codigo, 'BRILLA-URUMITA' descripcion, '' bloqprim, '' bloqing from dual union all
select '611240' as codigo, 'BRILLA-FONSECA' descripcion, '' bloqprim, '' bloqing from dual union all
select '690401' as codigo, 'SUBGERENCIA COMERCIAL' descripcion, '' bloqprim, '' bloqing from dual union all
select '680232' as codigo, 'IMPUESTOS-MANIZALES' descripcion, '' bloqprim, 'X' bloqing from dual union all
select '610540' as codigo, 'BRILLA-LA JAGUA DEL PILAR' descripcion, '' bloqprim, '' bloqing from dual union all
select '610840' as codigo, 'BRILLA-MANAURE' descripcion, '' bloqprim, '' bloqing from dual union all
select '611140' as codigo, 'BRILLA-BARRANCAS' descripcion, '' bloqprim, '' bloqing from dual union all
select '611540' as codigo, 'BRILLA-VILLANUEVA' descripcion, '' bloqprim, '' bloqing from dual union all
select '690210' as codigo, 'JEFE DE VENTAS Y CONSUMO CERO' descripcion, '' bloqprim, '' bloqing from dual )
select *
from base
where not exists (select null from open.ldci_centrocosto c where c.cecocodi = base.codigo);
    dbms_output.put_line('Se insertaron '||sql%rowcount||' registros');
    commit;
exception
  when others then
    rollback;
    dbms_output.put_line('Error '||sqlerrm);


end;
/