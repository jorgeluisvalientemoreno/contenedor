CREATE OR REPLACE PROCEDURE adm_person.ldc_prodevuelvevalorescuotas(
                                                         inano       IN NUMBER,
                                                         inmes       IN NUMBER,
                                                         inservicio  IN NUMBER,
                                                         innrocuota  IN NUMBER,
                                                         itipodif    IN VARCHAR2,
                                                         iamormesmes IN VARCHAR2,
                                                         ecuotas     OUT NUMBER,
                                                         eintereses  OUT NUMBER
                                                        ) IS
/******************************************************************************************************************
    Autor       : John Jairo Jimrnrz Marim?n
    Fecha       : 2020-Oct-23
    Descripcion : Obtenemos el valor capital y el valor interes
                  CA 533
    Parametros Entrada
      inano       A?o
      inmes       Mes
      inservicio  Tipo Producto
      innrocuota   Nro cuota
      itipodif     Tipo de calcuclo(Diferido total, Diferido Corriente y Diferido no-corriente)
      iamormesmes  Calculo amortizacion del diferido 1er a?o mes a mes

    Valor de salida
      ecuotas    Capital
      eintereses Interes
   HISTORIA DE MODIFICACIONES
     FECHA              AUTOR               DESCRIPCION
     09/05/2024         Paola Acosta        OSF-2672: Cambio de esquema ADM_PERSON
                                            Retiro marcacion esquema .open objetos de lógica 
******************************************************************************************************************/
BEGIN
 ecuotas := 0;
 eintereses := 0;
 SELECT nvl(SUM(cuota),0),nvl(SUM(interes),0) INTO ecuotas, eintereses
   FROM ldc_osf_proyrecar_temp f
  WHERE f.ano           = inano
    AND f.mes           = inmes
    AND f.servgene      = inservicio
    AND nucuota_i       = innrocuota
    AND f.tipo_calculo  = itipodif
    AND f.amort_mes_mes = iamormesmes;
EXCEPTION
 WHEN OTHERS THEN
  ecuotas    := 0;
  eintereses := 0;
END ldc_prodevuelvevalorescuotas;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRODEVUELVEVALORESCUOTAS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRODEVUELVEVALORESCUOTAS', 'ADM_PERSON');
END;
/