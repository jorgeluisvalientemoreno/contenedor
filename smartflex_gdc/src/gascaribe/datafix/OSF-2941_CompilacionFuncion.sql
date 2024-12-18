/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Julio 2024 
JIRA:           OSF-2941

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    15/07/2024 - jcatuch
    Creación
    
***********************************************************/
declare

    cursor cudata is
    select 
    f.formcodi,f.formdesc,
    fj.francodi,fj.frandesc,
    bq.bloqcodi,bq.bloqdesc,
    ib.itblcodi,it.itemdesc,it.itemceid,it.itemcons,it.itemobna,e.code
    from ed_formato f, ed_franform ff, ed_franja fj,ed_bloqfran bf, ed_bloque bq, ed_itembloq ib, ed_item it,gr_config_expression e
    where f.formiden in ('<264>')
    and ff.frfoform(+) = f.formcodi
    and fj.francodi(+) = ff.frfofran
    and bf.blfrfrfo(+) = ff.frfocodi
    and bq.bloqcodi(+) = bf.blfrbloq
    and ib.itblblfr(+) = bf.blfrcodi
    and it.itemcodi(+) = ib.itblitem
    and bloqdesc = 'LDC_BRILLA'
    and e.config_expression_id = it.itemceid
    order by f.formcodi,ff.frfoorde,bf.blfrorde,ib.itblorde
    ;
    
    sbcode      gr_config_expression.code%type;
    
begin
    for rc in cudata loop
        EXECUTE IMMEDIATE rc.code; 
    end loop;
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
quit
/
