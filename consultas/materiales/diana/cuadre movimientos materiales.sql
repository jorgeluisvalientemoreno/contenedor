declare
begin
  delete from open.OR_UNI_ITEM_BALA_MOV_COPIA2  c /*where items_id  not in (10004070)*/ ;--and operating_unit_id=1878;-- WHERE movement_type!='N' and c.operating_unit_id  in (3005);
  --12068,14 segundos
  --201.08 minutos  
  --execute immediate 'truncate table open.OR_UNI_ITEM_BALA_MOV_COPIA2';
  --7827,562
  --130.27
  commit;
end;
/
declare
 cursor cuItems is
 select distinct items_id
 from open.or_ope_uni_item_bala
 --where items_id not in (10004070)
 ;
 --metodo 1 134.11 min 8051.125 segund
 --meodod 2 131.38 min 7898,672 segun
  
 TYPE  bodega  IS RECORD
    (
        item      open.ge_items.items_id%TYPE,
        unidad    open.or_operating_unit.operating_unit_id%TYPE,
        cantidad  open.or_ope_uni_item_bala.balance%TYPE,
        costo     open.or_ope_uni_item_bala.total_costs%TYPE
    );
    
 TYPE saldo is table of bodega index by varchar2(20);
 saldos saldo;
 saldoscopia saldo;
 
 cursor cuMovimientos(nuItem number) is
    select   *
      from open.or_uni_item_bala_mov m
     where items_id=nuItem
       and movement_type in ('D','I')
      and move_date>='01/08/2017'
      -- AND MOVE_DATE<'01/08/2017'
     order by items_id, move_date, 1;

  cursor cuJulio(NUNIDAD NUMBER, NUITEM NUMBER) is
     SELECT SUM(CANT) CANT, SUM(VALOR) VALOR
     FROM (
    select j.balance CANT,TOTAL_COSTS VALOR  
    from open.ldc_osf_salbitemp j 
    where j.nuano=2017 and j.numes=7 
    and j.items_id=NUITEM
    and j.operating_unit_id=NUNIDAD);
  
  Cursor cuLegalizacion (nuOrden varchar2, nuitem number, sbserial varchar, cant number) is
    select legal_item_amount , value
      from open.or_order_items
      where order_id=to_number(nuorden)
        and items_id=nuitem
        and legal_item_amount=cant
        and nvl(serie,'-')=nvl(sbserial,'-');
    
  cursor cuDatosTrasladoSap(nuitem NUMBER, DOCUMENTO NUMBER) is
    select dmitcant cant , dmitcoun valor
          from open.ge_items_documento d, open.ldci_intemmit i, open.ldci_dmitmmit s
          where id_items_documento=DOCUMENTO
           and dmitmmit=mmitcodi
           and dmititem=nuitem
           and mmitnudo=to_char(id_items_documento)
           and mmitdsap is not null
       and dmitcant!=0
           and not exists(select null from open.ldci_seridmit where serimmit=mmitcodi and seridmit=dmitcodi)
     union
     select 1, dmitcoun
          from open.ge_items_documento d, open.ldci_intemmit i, open.ldci_dmitmmit s
          where id_items_documento=DOCUMENTO
           and dmitmmit=mmitcodi
           and dmititem=nuitem
           and mmitnudo=to_char(id_items_documento)
           and mmitdsap is not null
       and dmitcant!=0;
       
  cursor cuModificacionAiosa(nuUnidad number, nuitem Number, dt_fecha date) is
    select cantidad_final, costo_final
    from open.LDC_LOG_ITEMS_MODIF_SIN_ACTA a, open.or_order o
    where o.order_id=a.orden_id
      and o.operating_unit_id=nuUnidad
      and a.item_id=nuitem
      and trunc(a.fecha_modif)=trunc(dt_fecha);
    
  cursor cuDatosIncremento(nuitem NUMBER, SERIADO NUMBER, DOCUMENTO NUMBER, target number) is
    Select sum(cant) cant, sum(valor) valor
    from (
    SELECT SUM(M2.AMOUNT) CANT, SUM(M2.TOTAL_VALUE) VALOR
    FROM OPEN.or_uni_item_bala_mov M, OPEN.or_uni_item_bala_mov_copia2 M2
    WHERE M.SUPPORT_DOCUMENT=TO_CHAR(DOCUMENTO)
     AND M.ITEMS_ID=nuitem
     AND M.ITEMS_ID=M2.ITEMS_ID
     AND M2.ID_ITEMS_DOCUMENTO=M.ID_ITEMS_DOCUMENTO
     AND M2.MOVEMENT_TYPE='D'
     And m.TARGET_OPER_UNIT_ID=target
     and NVL(M.ID_ITEMS_SERIADO,0)=NVL(SERIADO,0)
     AND NVL(M.ID_ITEMS_SERIADO,0)=NVL(M2.ID_ITEMS_SERIADO,0));
     
  cursor cuDatosRechazoOsf(nuitem NUMBER, SERIADO NUMBER, DOCUMENTO NUMBER, nuunidad number) is 
     select sum(m2.amount) cant, sum((m.total_value/m.amount)*m2.amount) valor
   from OPEN.or_uni_item_bala_mov m, OPEN.GE_ITEMS_DOC_REL r , open.or_uni_item_bala_mov m2
   where m.id_items_documento =r.id_items_doc_destino
     and r.id_items_doc_origen=DOCUMENTO
     and m2.id_items_documento=r.id_items_doc_origen
   and m.items_id=nuitem
   and m.operating_unit_id=nuunidad
   and  m.items_id=m2.items_id
   and m.operating_unit_id=m2.operating_unit_id
   and NVL(M2.ID_ITEMS_SERIADO,0)=nvl(seriado,0)
    AND NVL(M2.ID_ITEMS_SERIADO,0)=NVL(M.ID_ITEMS_SERIADO,0) ;
  
  
  cursor cuDatosIncrementoSap(nuitem NUMBER, DOCUMENTO NUMBER) is
    select dmitcant cant , dmitcant*dmitcoun valor
          from open.ge_items_documento d, open.ldci_intemmit i, open.ldci_dmitmmit s
          where id_items_documento=DOCUMENTO
           and dmitmmit=mmitcodi
           and dmititem=nuitem
           and documento_externo like '%'||MMITDSAP
           and mmitdsap is not null
           and not exists(select null from open.ldci_seridmit where serimmit=mmitcodi and seridmit=dmitcodi)
      union
      select 1, dmitcoun
          from open.ge_items_documento d, open.ldci_intemmit i, open.ldci_dmitmmit s
          where id_items_documento=DOCUMENTO
           and dmitmmit=mmitcodi
           and dmititem=nuitem
           and documento_externo like '%'||MMITDSAP
           and mmitdsap is not null
           and exists(select null from open.ldci_seridmit where serimmit=mmitcodi and seridmit=dmitcodi);
       
       
  cursor cuRechazoSap(nuitem NUMBER, DOCUMENTO NUMBER, nuunidad number ) is
     select sum(m2.amount) cant, sum((m.total_value/m.amount)*m2.amount) valor
   from OPEN.or_uni_item_bala_mov m, OPEN.GE_ITEMS_DOC_REL r , open.or_uni_item_bala_mov m2
   where m.id_items_documento =r.id_items_doc_destino
     and r.id_items_doc_origen=DOCUMENTO
     and m2.id_items_documento=r.id_items_doc_origen
   and m.items_id=nuitem
   and m.operating_unit_id=nuunidad
   and  m.items_id=m2.items_id
   and m.operating_unit_id=m2.operating_unit_id ;
  
  CantidadJulio   number:=0;
    ValorJulio     number:=0;
  nuSigno         number:=0;
  ValorTraslado   number;
  rgIncremento cuDatosIncremento%rowtype;
  rgModificacionAiosa cuModificacionAiosa%rowtype;
  CantidadItem number;
    ValorItem    number;
    
    
    cursor cuBodega(nuitem number) is
    select u.operating_unit_id,
       u.items_id,
       sum(decode(movement_type,'D',-1,'I',1)*amount) cantidad,
       sum(decode(movement_type,'D',-1,'I',1)*total_value) valor,
       u.balance, --(select balance from open.ldc_act_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cant_act, (select balance from open.ldc_inv_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cant_inv,
       u.total_costs--, (select total_costs from open.ldc_act_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id)cost_act, (select total_costs from open.ldc_inv_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cost_inv
from (select /*UNI_ITEM_BALA_MOV_ID,  'M' TIPO,*/ operating_unit_id, movement_type, items_id,  amount, total_value from open.or_uni_item_bala_mov_copia2 --where move_date>='01/12/2018'
    /* where operating_unit_id=3006
      and items_id=10007776*/
     union all
     select/* 1 , 'I',*/ operating_unit_id, 'I' movement_type,  items_id, balance, total_costs
       FROM OPEN.ldc_osf_salbitemp where nuano=2017 and numes=07
      -- and items_id=10007776 and operating_unit_id=3006
        /*and B.CUADHOMO=1878
        and  nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0)=10000170*/
        ) m,
       open.or_ope_uni_item_bala u
where u.operating_unit_id=m.operating_unit_id
  and movement_type!='N'
  and m.items_id=u.items_id
  and m.items_id=nuitem
group by u.operating_unit_id,u.items_id, u.balance, u.total_costs;
    
cursor cuTablaCopia(nuItems number) is
select *
from open.OR_UNI_ITEM_BALA_MOV_COPIA2
where items_id=nuItems;

cursor cuTablaOriginal(Codigo number) is
select *
from open.OR_UNI_ITEM_BALA_MOV
where uni_item_bala_mov_id=Codigo;

rgTablaOriginal cuTablaOriginal%rowtype;

nuExiste number;

-- PARAMETROS DE ENTRADA
sbSaocodi       reportes.repoapli%type := '100-85492';
sbNombreArchivo reportes.repodesc%type := 'DatafixCA100-85492';


-- PARAMETROS REPORTE
nuIdReporte         reportes.reponume%type;
sbEncabezadoDatos   repoinco.REINDES2%type;
sbValorDatos        repoinco.reinobse%type;


--Datos Bodega
nuCantidad 			or_ope_uni_item_bala.balance%type;
nuCosto				or_ope_uni_item_bala.total_costs%type;

-- manejo errores
nuErrorCode NUMBER;
sbErrorMessage VARCHAR2(4000);

 cursor cuData(nuitem number) is
    select u.operating_unit_id,
       u.items_id,
       sum(decode(movement_type,'D',-1,'I',1)*amount) cantidad,
       sum(decode(movement_type,'D',-1,'I',1)*total_value) valor,
       u.balance, --(select balance from open.ldc_act_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cant_act, (select balance from open.ldc_inv_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cant_inv,
       u.total_costs--, (select total_costs from open.ldc_act_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id)cost_act, (select total_costs from open.ldc_inv_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cost_inv
from (select operating_unit_id, movement_type, items_id,  amount, total_value from open.or_uni_item_bala_mov_copia2 
     union all
     select/* 1 , 'I',*/ operating_unit_id, 'I' movement_type,  items_id, balance, total_costs
       FROM OPEN.ldc_osf_salbitemp where nuano=2017 and numes=07
        ) m,
       open.or_ope_uni_item_bala u
where u.operating_unit_id=m.operating_unit_id
  and movement_type!='N'
  and m.items_id=u.items_id
  and m.items_id=nuitem
  having sum(decode(movement_type,'D',-1,'I',1)*amount)=u.balance and sum(decode(movement_type,'D',-1,'I',1)*total_value)!=u.total_costs
group by u.operating_unit_id,u.items_id, u.balance, u.total_costs;


  nuCont1          number := 0;
  nusession       number;
  merro           varchar2(2000);
  dtfecejec       date;
  nuAnoc           number(4);
  nuMesc           number(2);

cursor cuSaldosItems is
select /*+ index (o1 PK_OR_OPE_UNI_ITEM_BALA) index (o2 PK_LDC_ACT_OUIB) index (o3 PK_LDC_INV_OUIB)*/
 o1.operating_unit_id CODIGO_UNIDAD_OPERATIVA,
 open.daor_operating_unit.fsbgetname(o1.operating_unit_id, null) DESCRIPCION_UNIDAD_OPERATIVA,
 o1.items_id CODIGO_ITEM,
 open.dage_items.fsbgetdescription(o1.items_id, null) DESCRIPCION_ITEM,
 o1.balance CANTIDAD_EXISTENTE_BODEGA,
 o1.total_costs COSTO_BODEGA,
 (select o2.balance
    from open.ldc_act_ouib o2
   where o2.items_id = o1.items_id
     and o1.operating_unit_id = o2.operating_unit_id) CANTIDAD_EXISTENTE_ACTIVO,
 (select o2.total_costs
    from open.ldc_act_ouib o2
   where o2.items_id = o1.items_id
     and o1.operating_unit_id = o2.operating_unit_id) COSTO_PROMEDIO_ACTIVO,
 (select o3.balance
    from open.ldc_INV_ouib o3
   where o3.items_id = o1.items_id
     and o1.operating_unit_id = o3.operating_unit_id) CANTIDAD_EXISTENTE_INVENTARIO,
 (select o3.total_costs
    from open.ldc_INV_ouib o3
   where o3.items_id = o1.items_id
     and o1.operating_unit_id = o3.operating_unit_id) COSTO_PROMEDIO_INVENTARIO
  from open.OR_OPE_UNI_ITEM_BALA o1
 order by o1.operating_unit_id;
 
 cursor Neutros is
 select  /*+ leading(or_uni_item_bala_mov)
           index(or_uni_item_bala_mov IDX_OR_UNI_ITEM_BALA_MOV01)
           index(ge_items_seriado PK_GE_ITEMS_SERIADO)
           index(ge_items PK_GE_ITEMS)
           index(ge_items_documento PK_GE_ITEMS_DOCUMENTO)*/
        OR_UNI_ITEM_BALA_MOV.uni_item_bala_mov_id,
        OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO,
        OR_UNI_ITEM_BALA_MOV.MOVE_DATE MOVE_DATE,
        GE_ITEMS.ITEMS_ID,
        GE_ITEMS.DESCRIPTION DESCRIPTION,
        GE_ITEMS.CODE CODE,
        OR_UNI_ITEM_BALA_MOV.AMOUNT,
        OR_UNI_ITEM_BALA_MOV.TOTAL_VALUE,
        GE_ITEMS_SERIADO.SERIE,
        OR_UNI_ITEM_BALA_MOV.TARGET_OPER_UNIT_ID OPERATING_UNIT_ID, 
        OR_UNI_ITEM_BALA_MOV.USER_ID,
        OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID TARGET_OPER_UNIT_ID, 
        ge_items.item_classif_id,
        c.movement_type,
        c.amount cantidad_decremento,
        c.total_value valor_decremento,
        (c.total_value/c.amount)*OR_UNI_ITEM_BALA_MOV.amount valor_calculado
  from  OPEN.OR_UNI_ITEM_BALA_MOV,
        OPEN.OR_OPE_UNI_ITEM_BALA,
        OPEN.GE_ITEMS_SERIADO,
        OPEN.GE_ITEMS,
        OPEN.GE_ITEMS_DOCUMENTO,
        open.or_uni_item_bala_mov_copia2 c
 where  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = GE_ITEMS.ITEMS_ID
   and  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = OR_OPE_UNI_ITEM_BALA.ITEMS_ID
   and  OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID = OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID
   and  OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE = 'N' 
   and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO = GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO
   and  OR_UNI_ITEM_BALA_MOV.SUPPORT_DOCUMENT = ' '
   and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_SERIADO = GE_ITEMS_SERIADO.ID_ITEMS_SERIADO (+)
   and OR_UNI_ITEM_BALA_MOV.id_items_documento=c.id_items_documento
   and OR_UNI_ITEM_BALA_MOV.items_id=c.items_id
   and nvl(OR_UNI_ITEM_BALA_MOV.id_items_seriado,0)=nvl(c.id_items_seriado,0)
   
   --dsaltarin 05/12/2018 se agrega esta condición debido a que se identifico con laboratorio y se encuentran movimienots 
   --que no deberian salir, se escalo el tema a open bajo el sao 464787 y la respuesta es que solo se deben tener en cuenta los movimientos con estas causales
   AND  OR_uni_item_bala_mov.item_moveme_caus_id in (15, --ge_boItemsConstants.cnuCausalEntFactCompra
                                                     6,  --ge_boItemsConstants.cnuCausalTranslate,
                                                     20)
   and OR_UNI_ITEM_BALA_MOV.move_date>='01/08/2017'
   and round(OR_UNI_ITEM_BALA_MOV.total_value)!=round((c.total_value/c.amount)*OR_UNI_ITEM_BALA_MOV.amount);
   --1087                                                   --ge_boItemsConstants.cnuMovCauseTrans)


-- crear cabecera deL reporte de seguimiento
    FUNCTION fnuCrReportHeader(isbArchivo reportes.repodesc%type, isbParameter reportes.repostej%type)
    return number
    IS
        rcRecord Reportes%rowtype;
    BEGIN
        rcRecord.REPOAPLI := sbSaocodi;
        rcRecord.REPOFECH := sysdate;
        rcRecord.REPOUSER := ut_session.getTerminal;
        rcRecord.REPODESC := isbArchivo ;
        rcRecord.REPOSTEJ := isbParameter;
        rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');
        pktblReportes.insRecord(rcRecord);
        return rcRecord.Reponume;
    END ;
	
    -- crear detalle de reporte de seguimiento
    PROCEDURE crReportDetail(
                            inuIdReporte        in  repoinco.reinrepo%type,
                            isbEntidad          in  repoinco.reindes1%type,
                            inuUnidad			in  repoinco.REINCOD1%type,
                            inuItem			    in  repoinco.REINVAL1%type,
                            isbAccion           in  repoinco.reindes4%type,
							inuBalance			in  repoinco.REINVAL2%type,
							inuCosto			in  repoinco.REINVAL3%type,
							inuCostoMOv			in  repoinco.REINVAL4%type
                            )
    IS
        rcRepoinco repoinco%rowtype;
    BEGIN
        rcRepoinco.Reinrepo := inuIdReporte;
        rcRepoinco.reindes1 := isbEntidad;
        rcRepoinco.REINCOD1 := inuUnidad;
        rcRepoinco.REINVAL1 := inuItem;
        rcRepoinco.REINDES4 := isbAccion;
        rcRepoinco.REINVAL2 := inuBalance;
		rcRepoinco.REINVAL3 := inuCosto;
		rcRepoinco.REINVAL4 := inuCostoMOv;
	
        rcRepoinco.reincodi :=  seq.getnext('SQ_REPOINCO_REINCODI');
        pktblRepoinco.insrecord(rcRepoinco);
    END ; 


begin
  for item in cuItems loop
    for reg in cuMovimientos(item.items_id) loop
      if NOT saldos.exists(reg.items_id||'|'||reg.operating_unit_id) then
        open cuJulio(reg.operating_unit_id, reg.items_id);
        fetch cuJulio into CantidadJulio, ValorJulio;
        if cuJulio%notfound then
            CantidadJulio :=0;
            ValorJulio :=0;
        end if;
        close cuJulio;
        if CantidadJulio is null then
           CantidadJulio:=0;
        end if; 
        if ValorJulio is null then
           ValorJulio:=0;
        end if;
        saldos(reg.items_id||'|'||reg.operating_unit_id).item:=reg.items_id;
        saldos(reg.items_id||'|'||reg.operating_unit_id).unidad:=reg.operating_unit_id;
        saldos(reg.items_id||'|'||reg.operating_unit_id).cantidad:=CantidadJulio;
        saldos(reg.items_id||'|'||reg.operating_unit_id).costo:=ValorJulio;
      end if;
    if reg.movement_type='D' then
    nuSigno:=-1;
    if open.dage_items_documento.fnugetdocument_type_id(reg.id_items_documento, null) = 118 then
      open cuLegalizacion(open.dage_items_documento.fsbgetdocumento_externo(REG.ID_ITEMS_DOCUMENTO),
                                reg.items_id,
                                open.dage_items_seriado.fsbgetserie(reg.id_items_seriado,null),
                                reg.amount);
            fetch cuLegalizacion into rgIncremento;
            if cuLegalizacion%found then
        CantidadItem:=nvl(reg.amount,0);
                ValorItem:=nvl(rgIncremento.valor,0);
            else
        CantidadItem:=reg.amount;
        ValorItem:=reg.total_value;
            end if;
            close cuLegalizacion; 
    else  --if open.dage_items_documento.fnugetdocument_type_id(reg.id_items_documento, null) = 118 then
      ValorTraslado:=null;
      if saldos(reg.items_id||'|'||reg.operating_unit_id).cantidad >0 then --and reg.comments like 'Se registra debido a que movimientos%' then
        ValorTraslado :=(saldos(reg.items_id||'|'||reg.operating_unit_id).costo/saldos(reg.items_id||'|'||reg.operating_unit_id).cantidad)*reg.amount;
      end if;
      if open.daor_operating_unit.fnugetoper_unit_classif_id(reg.target_oper_unit_id,null)=11 then
       /* open cuDatosTrasladoSap(reg.items_id, reg.id_items_documento);
                fetch cuDatosTrasladoSap into rgIncremento;
                if cuDatosTrasladoSap%found and nvl(rgIncremento.VALOR,0)*reg.amount <=  saldos(reg.items_id||'|'||reg.operating_unit_id).costo then
          CantidadItem:=reg.amount;--nvl(CantidadItem,0)+nvl(rgIncremento.CANT,0);
          ValorItem:=nvl(rgIncremento.VALOR,0)*reg.amount ;
        else*/
          if nvl(ValorTraslado,0)!=0 and ValorTraslado is not null  then
            CantidadItem:=nvl(reg.amount,0);
                        ValorItem:=ValorTraslado;
          else 
            CantidadItem:=nvl(reg.amount,0);
            ValorItem:=NVL(reg.total_value,0);                            
          end if;--if nvl(ValorTraslado,0)!=0 and ValorTraslado is not null  then
        /*end if;--if cuDatosTrasladoSap%found and nvl(rgIncremento.VALOR,0) <=  ValorJulio then
        close cuDatosTrasladoSap;*/
      else
        if nvl(ValorTraslado,0)!=0 and ValorTraslado is not null  then
          CantidadItem:=nvl(reg.amount,0);
          ValorItem:=ValorTraslado;
        else
          CantidadItem:=nvl(reg.amount,0);
          ValorItem:=NVL(reg.total_value,0); 
          open cuModificacionAiosa(reg.operating_unit_id, reg.items_id, reg.move_date);
          fetch cuModificacionAiosa into rgModificacionAiosa;
                    if cuModificacionAiosa%found then
            ValorItem:=rgModificacionAiosa.costo_final;
                    end if;--if cuModificacionAiosa%found then
                    close cuModificacionAiosa;
        end if;--if nvl(ValorTraslado,0)!=0 and ValorTraslado is not null  then
      end if;--if open.daor_operating_unit.fnugetoper_unit_classif_id(reg.target_oper_unit_id,null)=11 then
    end if; --if open.dage_items_documento.fnugetdocument_type_id(reg.id_items_documento, null) = 118 then
    elsif reg.movement_type='I' then--if reg.movement_type='D' then
    nuSigno:=1;
    if open.daor_operating_unit.fnugetoper_unit_classif_id(reg.target_oper_unit_id, null)!=11 then
      OPEN cuDatosIncremento(reg.items_id, reg.id_items_seriado,reg.id_items_documento, reg.TARGET_OPER_UNIT_ID);
            fetch cuDatosIncremento into rgIncremento;
            if cuDatosIncremento%found and rgIncremento.CANT is not null  then
        CantidadItem:=nvl(reg.amount,0);
                ValorItem:=nvl((rgIncremento.VALOR/rgIncremento.CANT)*reg.amount,0);  
      elsif open.dage_items_documento.fnugetdocument_type_id(reg.id_items_documento,null) in (118,112) then
        CantidadItem:=nvl(reg.amount,0);
                ValorItem:=nvl(reg.total_value,0);   
            elsif open.dage_items_documento.fnugetdocument_type_id(reg.id_items_documento,null) in (115) then
        open cuDatosRechazoOsf(reg.items_id, reg.id_items_seriado,reg.id_items_documento, reg.operating_unit_id);
        fetch cuDatosRechazoOsf into rgIncremento;
        if cuDatosRechazoOsf%found then
           CantidadItem:=nvl(reg.amount,0);
           ValorItem:=nvl((rgIncremento.VALOR/rgIncremento.CANT)*reg.amount,0) ;   
        ELSE
          CantidadItem:=nvl(reg.amount,0);
          ValorItem:=reg.total_value;
        end if;
        close cuDatosRechazoOsf;
            ELSE --reg.ITEM_MOVEME_CAUS_ID = 28 THEN
          CantidadItem:=nvl(reg.amount,0);
          ValorItem:=NVL(reg.total_value,0);    
      end if;--if cuDatosIncremento%found and rgIncremento.CANT is not null  then
      close cuDatosIncremento;
    else
      open cuDatosIncrementoSap(reg.items_id, reg.id_items_documento);
            fetch cuDatosIncrementoSap into rgIncremento;
            if cuDatosIncrementoSap%found then
        CantidadItem:=nvl(rgIncremento.CANT,0);
        ValorItem:=nvl(rgIncremento.VALOR,0) ;
            else
        open cuRechazoSap(reg.items_id, reg.id_items_documento, reg.operating_unit_id );
        fetch cuRechazoSap into rgIncremento;
        if cuRechazoSap%found then
         CantidadItem:=nvl(reg.amount,0);
         ValorItem:=nvl((rgIncremento.VALOR/rgIncremento.CANT)*reg.amount,0); 
         --dbms_output.put_line('I8 '||reg.id_items_documento|| ' ' ||reg.amount);
         --dbms_output.put_line('I8 '||reg.id_items_documento|| ' ' ||(rgIncremento.VALOR/rgIncremento.CANT)*reg.amount);
        ELSE
        CantidadItem:=nvl(reg.amount,0);
        ValorItem:=NVL(reg.total_value,0);
        end if; --if cuRechazoSap%found then
        close cuRechazoSap;
      end if; --if cuDatosIncrementoSap%found then
      close cuDatosIncrementoSap;
    end if;--if open.daor_operating_unit.fnugetoper_unit_classif_id(reg.target_oper_unit_id, null)!=11 then
    end if; --if reg.movement_type='D' then
    saldos(reg.items_id||'|'||reg.operating_unit_id).cantidad:=saldos(reg.items_id||'|'||reg.operating_unit_id).cantidad+nvl(CantidadItem,0)*nuSigno;
      saldos(reg.items_id||'|'||reg.operating_unit_id).costo:=saldos(reg.items_id||'|'||reg.operating_unit_id).costo+nvl(ValorItem,0)*nuSigno;
    insert into open.OR_UNI_ITEM_BALA_MOV_COPIA2
        (
      uni_item_bala_mov_id ,
      items_id             ,
      operating_unit_id    ,
      item_moveme_caus_id  ,
      movement_type        ,
      amount               ,
      comments             ,
      move_date            ,
      terminal             ,
      user_id              ,
      support_document     ,
      target_oper_unit_id  ,
      total_value          ,
      id_items_documento   ,
      id_items_seriado     ,
      id_items_estado_inv  ,
      valor_venta          ,
      init_inv_stat_items  
      )
      values (reg.uni_item_bala_mov_id ,
      reg.items_id             ,
      reg.operating_unit_id    ,
      reg.item_moveme_caus_id  ,
      reg.movement_type        ,
      CantidadItem,
      reg.comments             ,
      reg.move_date            ,
      reg.terminal             ,
      reg.user_id              ,
      reg.support_document     ,
      reg.target_oper_unit_id  ,
      ValorItem          ,
      reg.id_items_documento   ,
      reg.id_items_seriado     ,
      reg.id_items_estado_inv  ,
      reg.valor_venta          ,
      reg.init_inv_stat_items   );
      COMMIT;
    end loop;
    for reg2 in cuBodega(item.items_id) loop
           dbms_output.put_line(reg2.operating_unit_id||'|'||reg2.items_id||'|'||reg2.balance||'|'||reg2.total_costs||'|'||reg2.cantidad||'|'||reg2.valor);   
    end loop;
	for reg in cuTablaCopia(item.items_id) loop
	  begin
		select count(1) into nuExiste 
			from open.or_uni_item_bala_mov_original
		where uni_item_bala_mov_id = reg.uni_item_bala_mov_id;
	  exception
	   when others then
		nuExiste :=0 ;
	   end;
	   if nuExiste=0 then
			open cuTablaOriginal(reg.uni_item_bala_mov_id);
			fetch cuTablaOriginal into rgTablaOriginal;
			close cuTablaOriginal;

			insert into or_uni_item_bala_mov_original(UNI_ITEM_BALA_MOV_ID,ITEMS_ID,OPERATING_UNIT_ID,ITEM_MOVEME_CAUS_ID,MOVEMENT_TYPE,AMOUNT,COMMENTS,MOVE_DATE,TERMINAL,USER_ID,SUPPORT_DOCUMENT,TARGET_OPER_UNIT_ID,
													  TOTAL_VALUE,ID_ITEMS_DOCUMENTO,ID_ITEMS_SERIADO,ID_ITEMS_ESTADO_INV,VALOR_VENTA,INIT_INV_STAT_ITEMS)
				values(rgTablaOriginal.UNI_ITEM_BALA_MOV_ID,rgTablaOriginal.ITEMS_ID,rgTablaOriginal.OPERATING_UNIT_ID,rgTablaOriginal.ITEM_MOVEME_CAUS_ID,rgTablaOriginal.MOVEMENT_TYPE,rgTablaOriginal.AMOUNT,rgTablaOriginal.COMMENTS,rgTablaOriginal.MOVE_DATE,rgTablaOriginal.TERMINAL,rgTablaOriginal.USER_ID,rgTablaOriginal.SUPPORT_DOCUMENT,rgTablaOriginal.TARGET_OPER_UNIT_ID,
													  rgTablaOriginal.TOTAL_VALUE,rgTablaOriginal.ID_ITEMS_DOCUMENTO,rgTablaOriginal.ID_ITEMS_SERIADO,rgTablaOriginal.ID_ITEMS_ESTADO_INV,rgTablaOriginal.VALOR_VENTA,rgTablaOriginal.INIT_INV_STAT_ITEMS);
		 commit;
	   end if;
	   update or_uni_item_bala_mov m
		  set total_Value=reg.total_value
		  where m.uni_item_bala_mov_id=reg.uni_item_bala_mov_id;
		  commit;
	end loop;
    -- se crea el encabezado de reporte
    nuIdReporte :=  fnuCrReportHeader(sbNombreArchivo , null);
	begin
    for reg in cuData(item.items_id) loop
		-- se deshabilita el trigger de movimientos
				EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_AUROR_OPE_UNI_ITEM_BALA disable';
				EXECUTE IMMEDIATE 'ALTER TRIGGER LDCTRGBUDI_OR_OUIB disable';
				begin
					if reg.valor >= 0 then 
						crReportDetail(nuIdReporte, 'OR_OPE_UNI_ITEM_BALA',reg.operating_unit_id,reg.items_id,'BEFORE',reg.balance,reg.total_costs,null);
						update or_ope_uni_item_bala a
							set a.total_costs=reg.valor
						where operating_unit_id=reg.operating_unit_id
						and items_id=reg.items_id;
						dbms_output.put_line('Datos bodega '||reg.operating_unit_id||' items_id '||reg.items_id||' CostoBod: '|| reg.total_costs ||' CostoMovimiento: '||reg.valor);
						crReportDetail(nuIdReporte, 'OR_OPE_UNI_ITEM_BALA',reg.operating_unit_id,reg.items_id,'AFTER',reg.balance,reg.valor,reg.valor);
					else
						crReportDetail(nuIdReporte, 'OR_OPE_UNI_ITEM_BALA',reg.operating_unit_id,reg.items_id,'BEFORE',reg.balance,reg.total_costs,null);
						update or_ope_uni_item_bala a
							set a.total_costs=0
						where operating_unit_id=reg.operating_unit_id
						and items_id=reg.items_id;
						dbms_output.put_line('Datos bodega '||reg.operating_unit_id||' items_id '||reg.items_id||' CostoBod: '|| reg.total_costs ||' CostoMovimiento: '||reg.valor);
						crReportDetail(nuIdReporte, 'OR_OPE_UNI_ITEM_BALA',reg.operating_unit_id,reg.items_id,'AFTER',reg.balance,0,reg.valor);
						 INSERT INTO OR_UNI_ITEM_BALA_MOV(UNI_ITEM_BALA_MOV_ID,ITEMS_ID,OPERATING_UNIT_ID,ITEM_MOVEME_CAUS_ID,MOVEMENT_TYPE,AMOUNT,
												  COMMENTS,MOVE_DATE,TERMINAL,USER_ID,SUPPORT_DOCUMENT,TARGET_OPER_UNIT_ID,TOTAL_VALUE,
												  ID_ITEMS_DOCUMENTO,ID_ITEMS_SERIADO,ID_ITEMS_ESTADO_INV,VALOR_VENTA,INIT_INV_STAT_ITEMS) 
					   VALUES(open.SEQ_OR_UNI_ITEM_BALA_MOV.Nextval, REG.ITEMS_ID, REG.OPERATING_UNIT_ID, -1, 'I', 0,
						   'Registra aumento valor a cero', sysdate, NVL(USERENV('TERMINAL'),'SCRIPT'), user, ' ', REG.OPERATING_UNIT_ID, reg.valor*-1,
						   null, null,null, 0, null );
					end if;	
				exception
					when others then
						dbms_output.put_line('Error bodega '||reg.operating_unit_id||' items_id '||reg.items_id||' '||sqlerrm||' CostoBod: '|| reg.total_costs ||'CostoMovimiento: '||reg.valor);
						rollback;
				end;
				EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_AUROR_OPE_UNI_ITEM_BALA enable';
				EXECUTE IMMEDIATE 'ALTER TRIGGER LDCTRGBUDI_OR_OUIB enable';
				commit;
    END loop;
	exception
		when others then
			EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_AUROR_OPE_UNI_ITEM_BALA enable';
			EXECUTE IMMEDIATE 'ALTER TRIGGER LDCTRGBUDI_OR_OUIB enable';
	end;

	commit;
  end loop;
  commit;
  ------------------------------------------------------------------
  --TOMA LA FOTO




BEGIN
  select userenv('sessionid') into nusession from dual;
  select trunc(sysdate) into dtfecejec from dual;
  nuAnoC := to_number(to_char(dtfecejec,'YYYY'));
  nuMesC := to_number(to_char(dtfecejec,'MM'));
  ldc_proinsertaestaprog(nuAnoC,nuMesC,'LDCRBAI_CIE','Inicia ejecucion..',nusession,USER);

  -- borra los registros generados el mismo dia, en el caso de que se ejecute mas de una vez
  delete from open.LDC_OSF_LDCRBAI where fec_corte = dtfecejec;
  commit;

 for rg in cuSaldosItems loop
     nucont1 := nucont1 + 1;
     insert into open.LDC_OSF_LDCRBAI (fec_corte, cod_item , cod_unid_oper ,  cant_exist_bodega ,
                                       costo_bodega, cant_exist_activo, cost_prom_activo,
                                       cant_exist_inven  , cost_prom_inven)
               values (dtFecEjec, rg.CODIGO_ITEM, rg.CODIGO_UNIDAD_OPERATIVA, rg.cantidad_existente_bodega,
                       rg.COSTO_BODEGA, rg.CANTIDAD_EXISTENTE_ACTIVO, rg.COSTO_PROMEDIO_ACTIVO,
                       rg.CANTIDAD_EXISTENTE_INVENTARIO, rg.COSTO_PROMEDIO_INVENTARIO);

     if mod(nucont1,2000) = 0 then
        commit;
     end if;
   end loop;

  COMMIT;

  merro := 'Proceso termino Ok : se procesaron '||to_char(nucont1)||' registros.';
  ldc_proinsertaestaprog(nuAnoC,nuMesC,'LDCRBAI_CIE',merro,nusession,USER);

EXCEPTION
 WHEN OTHERS THEN
  Merro:= 'Error en LDCRBAI_CIE: '|| SQLERRM;
  ldc_proinsertaestaprog(nuAnoC,nuMesC,'LDCRBAI_CIE',merro,nusession,USER);
END;
------neutros
	for reg in Neutros loop
		open cuTablaOriginal(reg.uni_item_bala_mov_id);
		fetch cuTablaOriginal into rgTablaOriginal;
		close cuTablaOriginal;
		insert into or_uni_item_bala_mov_original(UNI_ITEM_BALA_MOV_ID,ITEMS_ID,OPERATING_UNIT_ID,ITEM_MOVEME_CAUS_ID,MOVEMENT_TYPE,AMOUNT,COMMENTS,MOVE_DATE,TERMINAL,USER_ID,SUPPORT_DOCUMENT,TARGET_OPER_UNIT_ID,
												  TOTAL_VALUE,ID_ITEMS_DOCUMENTO,ID_ITEMS_SERIADO,ID_ITEMS_ESTADO_INV,VALOR_VENTA,INIT_INV_STAT_ITEMS)
			values(rgTablaOriginal.UNI_ITEM_BALA_MOV_ID,rgTablaOriginal.ITEMS_ID,rgTablaOriginal.OPERATING_UNIT_ID,rgTablaOriginal.ITEM_MOVEME_CAUS_ID,rgTablaOriginal.MOVEMENT_TYPE,rgTablaOriginal.AMOUNT,rgTablaOriginal.COMMENTS,rgTablaOriginal.MOVE_DATE,rgTablaOriginal.TERMINAL,rgTablaOriginal.USER_ID,rgTablaOriginal.SUPPORT_DOCUMENT,rgTablaOriginal.TARGET_OPER_UNIT_ID,
												  rgTablaOriginal.TOTAL_VALUE,rgTablaOriginal.ID_ITEMS_DOCUMENTO,rgTablaOriginal.ID_ITEMS_SERIADO,rgTablaOriginal.ID_ITEMS_ESTADO_INV,rgTablaOriginal.VALOR_VENTA,rgTablaOriginal.INIT_INV_STAT_ITEMS);
			commit;
		update or_uni_item_bala_mov m
		  set total_Value=reg.valor_calculado
		  where m.uni_item_bala_mov_id=reg.uni_item_bala_mov_id;
		  commit; 
	end loop;
commit;
  end;
/
