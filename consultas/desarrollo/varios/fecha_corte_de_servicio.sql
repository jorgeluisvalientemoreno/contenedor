declare



  cursor cufechacortenulo is

    select a.product_id PRODUCTO,

           --a.suspension_type_id,

           --A.APLICATION_DATE,

           (select pp.suspen_ord_act_id

              from open.pr_product pp

             where pp.product_id = a.product_id) ORDEN_SUSPENSION,

           a.aplication_date FECHA_APLICA_SUSPENSION

      from open.pr_prod_suspension A

     WHERE A.ACTIVE = 'Y'

       and a.suspension_type_id = 2

       and (select ss.sesufeco

              from open.servsusc ss

             where ss.sesunuse = a.product_id) is null;



  rfcufechacortenulo cufechacortenulo%rowtype;



  cursor cufechaejecucion(nuorder_activity_id number) is

    select oo.execution_final_date

      from open.or_order oo, open.or_order_activity ooa

     where oo.order_id = ooa.order_id

       and ooa.order_activity_id = nuorder_activity_id;



  dtexecution_final_date open.or_order.execution_final_date%type;



begin



  --Inicio Ciclo

  for rfcufechacortenulo in cufechacortenulo loop

  

    dtexecution_final_date := null;

    if rfcufechacortenulo.ORDEN_SUSPENSION is not null then

      open cufechaejecucion(rfcufechacortenulo.ORDEN_SUSPENSION);

      fetch cufechaejecucion

        into dtexecution_final_date;

      close cufechaejecucion;

    

      begin

        update open.servsusc ss

           set ss.sesufeco = dtexecution_final_date

         where ss.sesunuse = rfcufechacortenulo.PRODUCTO;

        commit;

        dbms_output.put_line('Producto [' || rfcufechacortenulo.PRODUCTO ||

                             '] - Fecha Ejecucion [' ||

                             dtexecution_final_date || ']');

      

      exception

        when others then

          rollback;

          dbms_output.put_line('Producto [' || rfcufechacortenulo.PRODUCTO ||

                               '] - Eror: ' || sqlerrm);

      end;

    

    else

    

      begin

        update open.servsusc ss

           set ss.sesufeco = rfcufechacortenulo.FECHA_APLICA_SUSPENSION

         where ss.sesunuse = rfcufechacortenulo.PRODUCTO;

        commit;

        dbms_output.put_line('Producto [' || rfcufechacortenulo.PRODUCTO ||

                             '] - Fecha Suspension Activa[' ||

                             rfcufechacortenulo.FECHA_APLICA_SUSPENSION || ']');

      

      exception

        when others then

          rollback;

          dbms_output.put_line('Producto [' || rfcufechacortenulo.PRODUCTO ||

                               '] - Eror: ' || sqlerrm);

      end;

    

    end if;

  

  end loop;

  --Fin Ciclo



  --dbms_output.put_line('Ok');



exception

  when others then

    rollback;

    dbms_output.put_line('Error: ' || sqlerrm);

end;

/

