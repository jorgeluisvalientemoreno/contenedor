DECLARE 
    t_query    varchar2(2000); 
  ocuCursorR SYS_REFCURSOR; 
  varR       varchar2(2000); 
  osbValor   varchar2(1000); 
BEGIN 
  osbValor := null; 

  for i in 1 .. 20 loop 

    --dbms_output.put_line(i); 

    t_query := 'select d.value_' || i || 

               ' from OPEN.or_requ_data_value d where d.name_' || i || ' = ''' || 

               'PRESION_DINAMICA' || ''' and d.attribute_set_id=' || 11212 || 

               ' and d.order_id = ' || 131219913; 

    open ocuCursorR for t_query; 

    LOOP 

      FETCH ocuCursorR 

        INTO varR; 

      EXIT WHEN ocuCursorR%NOTFOUND; 

      if varR is not NULL then 

        osbValor := varR; 

      end if; 

    END LOOP; 

    close ocuCursorR; 

  

    EXIT WHEN osbValor is not null; 

  

  end loop; 

  DBMS_OUTPUT.PUT_LINE('osbValor: '||osbValor); 

   

END; 
