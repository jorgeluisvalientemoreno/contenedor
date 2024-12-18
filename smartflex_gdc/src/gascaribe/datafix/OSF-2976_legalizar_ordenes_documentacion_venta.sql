column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  cursor cuDATAprodcuto is
    select ooa.subscription_id Contrato
      from open.Or_Order_Activity ooa
     where ooa.order_id in (327024541,
                            327024546,
                            327010132,
                            327010135,
                            327010137,
                            327010140,
                            327010160,
                            327010163,
                            327010165,
                            327010168,
                            327039972,
                            327039975,
                            327039978,
                            327039980,
                            327042492,
                            327042496,
                            327042499,
                            327042502,
                            326987026,
                            326987028,
                            326987029,
                            326987030,
                            327068191,
                            327068193,
                            327068199,
                            327126478,
                            327126479,
                            327126480,
                            327126481,
                            327128994,
                            327128995,
                            327128996,
                            327128997,
                            326858347,
                            326858351,
                            326858353,
                            326858354,
                            327024519,
                            327024531,
                            327068200)
     group by ooa.subscription_id;

  rfDATAprodcuto cuDATAprodcuto%rowtype;

  CURSOR cuSubsisdio(nuContrato number) IS
    SELECT ASIG_SUBSIDY_ID || '-S' codigo
      FROM open.ld_asig_subsidy asu, open.mo_packages s, open.ld_subsidy su
     WHERE asu.susccodi = nuContrato
       AND asu.delivery_doc = open.ld_boconstans.csbNOFlag --'N' --
       AND asu.state_subsidy <> open.ld_boconstans.cnuSubreverstate --5 --
       AND Asu.subsidy_id = su.subsidy_id
       AND S.package_id = asu.package_id;

  rfSubsisdio cuSubsisdio%rowtype;

  onuErrorCode    NUMBER; --TICKET 2001901 LJLB -- se almacena codigo del error
  osbErrorMessage VARCHAR2(4000); --TICKET 2001901 LJLB -- se almacena mensaje de error

BEGIN

  for rfDATAprodcuto in cuDATAprodcuto loop
    dbms_output.put_line('Contrato: ' || rfDATAprodcuto.Contrato);
    for rfSubsisdio in cuSubsisdio(rfDATAprodcuto.Contrato) loop
      dbms_output.put_line('          Subsidio: ' || rfSubsisdio.codigo);
      LDC_PROCCONTDOCUVENT(rfSubsisdio.codigo,
                           onuErrorCode,
                           osbErrorMessage);
      if (onuErrorCode = 0) then
        commit;
        dbms_output.put_line('Cierre Ok de orden asociada al subsidio ' ||
                             rfSubsisdio.codigo);
      else
        rollback;
        dbms_output.put_line('Error: ' || osbErrorMessage);
      end if;
    
    end loop;
  end loop;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/