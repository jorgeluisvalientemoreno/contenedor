CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNC_GETSEGMENTSUSC" (inususc open.pr_product.subscription_id%type)
                                                   return varchar2 is
/**************************************************************************
  Autor       : Francisco Castro
  Fecha       : 2015-05-27
  Descripcion : Funcion que retorna el segmento de Brilla actual de un contrato

  Parametros Entrada
    inususc contrato


  Valor de salida
    codigo del segmento concatenado con la descripcion


 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION


***************************************************************************/


nuCodSegmen OPEN.LDC_CONDIT_COMMERC_SEGM.COND_COMMER_SEGM_ID%type;
sbacrSegmen OPEN.LDC_CONDIT_COMMERC_SEGM.ACRONYM%type;
sbDesSegmen OPEN.LDC_CONDIT_COMMERC_SEGM.DESCRIPTION%type;
sbSegmento varchar2(200);


cursor cuSegmentacion is
select a.segment_id, d.acronym, d.description  from
(select segment_id
  from (select segment_id
          from open.LDC_SEGMENT_SUSC s
         where s.subscription_id = inususc
       order by s.register_date desc)
  where rownum=1) a
left outer join OPEN.LDC_CONDIT_COMMERC_SEGM d on (d.cond_commer_segm_id = a.segment_id);

begin
  open cuSegmentacion;
  fetch cuSegmentacion into nuCodSegmen, sbacrSegmen, sbDesSegmen;
  if cuSegmentacion%notfound or nuCodSegmen is null then
     sbSegmento := 'NO ESTA SEGMENTADO';
  else
     sbSegmento := sbacrSegmen || ' - ' || sbDesSegmen;
  end if;
  close cuSegmentacion;
  return (sbSegmento);
exception when others then
  return ('Error en ldc_fnc_getsegmentsusc: (Contrato ' || inususc || ': ' || sqlerrm);
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNC_GETSEGMENTSUSC', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_FNC_GETSEGMENTSUSC TO REPORTES;
/