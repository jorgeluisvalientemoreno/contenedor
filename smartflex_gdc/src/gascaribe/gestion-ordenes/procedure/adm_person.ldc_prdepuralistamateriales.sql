create or replace procedure ADM_PERSON.LDC_PRDEPURALISTAMATERIALES as
    /**************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Funcion     :  ldc_prDepuraListaMateriales
    Descripcion :  Procedimiento que crea depura que no existan materiales ni materiales
				   tipo actividad en la lista generica de materiales y estos no existan en la
				   lista generica que no es de materiales.
    Autor       : dsaltarin
    Fecha       : 07/10/2019
	Caso:		:2019080627

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    **************************************************************************/

	cursor cuMateriales(nuLista number) is
	select i.items_id,i.description, case when i.item_classif_id in (3,8,21) then 'MATERIAL'
                                      when NVL((select 'S' from open.LDC_HOMOITMAITAC l where l.item_actividad=i.items_id),'N')='S' then 'MATERIAL TIPO ACTIVIDAD'
                                      ELSE NULL END TIPO
  from open.ge_items i, open.ge_unit_cost_ite_lis li
  where i.items_id=li.items_id
    and li.list_unitary_cost_id=nuLista;

	cursor cuListaCosto is
	select list_unitary_cost_id, description, validity_start_date, validity_final_date
	from open.ge_list_unitary_cost
	where operating_unit_id is null
	  and geograp_location_id is null
	  and contractor_id is null
	  and contract_id is null
	  and sysdate between validity_start_date and validity_final_date;

	nuIdReporte	 NUMBER;
	nuConsecutivo      number:=0;
	sbMaterial	 varchar2(1);

	-- crear cabecera deL reporte de seguimiento
	FUNCTION fnuCrReportHeader
		return number
		IS
		rcRecord Reportes%rowtype;
	BEGIN
		rcRecord.REPOAPLI := 'DEPURA_MAT';
		rcRecord.REPOFECH := sysdate;
		rcRecord.REPOUSER := ut_session.getTerminal;
		rcRecord.REPODESC := 'DEPURA LISTAS DE COSTOS DE MATERIALES' ;
		rcRecord.REPOSTEJ := null;
		rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');
		pktblReportes.insRecord(rcRecord);
		return rcRecord.Reponume;
	END ;

	PROCEDURE crReportDetail(
					  inuIdReporte	in  repoinco.reinrepo%type,
					  inuCodItem	in  repoinco.REINVAL1%type,
					  inuCodLista	in  repoinco.REINVAL2%type,
					  isbObservacion in repoinco.REINOBSE%type
					  )
	IS
	rcRepoinco repoinco%rowtype;

	BEGIN
	rcRepoinco.Reinrepo := inuIdReporte;
	rcRepoinco.REINVAL1 := inuCodItem;
	rcRepoinco.REINVAL2 := inuCodLista;
	rcRepoinco.REINOBSE := isbObservacion;
	rcRepoinco.reincodi := nuConsecutivo;
	pktblRepoinco.insrecord(rcRepoinco);
	END ;

begin
	for reg in cuListaCosto loop
		if reg.description like '%MATERIAL%' then
			sbMaterial:='S';
		else
			sbMaterial:='N';
		end if;
		nuIdReporte:=NULL;
		for reg2 in cuMateriales(reg.list_unitary_cost_id) loop
			begin
			if reg2.TIPO is null and sbMaterial='S' then
				if  nuIdReporte is null then
					nuIdReporte := fnuCrReportHeader;
				end if;
				delete ge_unit_cost_ite_lis l where l.list_unitary_cost_id=reg.list_unitary_cost_id and l.items_id=reg2.items_id;
				nuConsecutivo:=nuConsecutivo+1;
				crReportDetail(nuIdReporte,reg2.items_id,reg.list_unitary_cost_id, 'SE ELIMINA DE LA LISTA :'||reg.list_unitary_cost_id||' DEBIDO A QUE NO ES MATERIAL/MATERAIL TIPO ACTIVIDAD');
			elsif reg2.TIPO is not null and sbMaterial='N' then
				if  nuIdReporte is null then
					nuIdReporte := fnuCrReportHeader;
				end if;
				delete ge_unit_cost_ite_lis l where l.list_unitary_cost_id=reg.list_unitary_cost_id and l.items_id=reg2.items_id;
				nuConsecutivo:=nuConsecutivo+1;
				crReportDetail(nuIdReporte,reg2.items_id,reg.list_unitary_cost_id, 'SE ELIMINA DE LA LISTA :'||reg.list_unitary_cost_id||' DEBIDO A QUE ES'||REG2.TIPO);
			end if;
			commit;
			exception
			when others then
				rollback;
			end;
		end loop;
	end loop;
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRDEPURALISTAMATERIALES', 'ADM_PERSON');
END;
/
