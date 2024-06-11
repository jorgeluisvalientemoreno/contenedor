PL/SQL Developer Test script 3.0
284
declare
nucontratista Number;
nuacta Number:=127371;
  --200-1957 19/07/2018 dsaltarin se modifica para tratar de optimazar la consulta
  --                y para que valide el dato adicional del activo en caso
  --                que no encuentre el dato adicional
 /*  200-2227 09/11/2018 Elkin Alvarez  200-2227 PROCEDIMIENTO : valida_trigger Linea  1100, Se agrega la consulta la sbcuentacosto
                                             Linea  1210, Se valida si la cuenta de costo es null,
                                             devuelva lo configurado en el parametro : LDC_VAL_CONT_CUENTAMULTAS.*/

    sbordenes     Number;
    sbdatoadic    open.ldci_carasewe.casevalo%Type;
    sbclasact     open.ldci_carasewe.casevalo%Type;
    nuorden_id    open.or_order.order_id%Type;
    nuactivo      Number;
    nudatoadic    Number;
    nutipotrabajo open.or_task_type.task_type_id%Type;
    nulocalidad   open.ge_geogra_location.geograp_location_id%Type;
    nucentrocosto open.ldci_cecoubigetra.ccbgceco%Type;
    nuclasicontab open.ic_clascott.clctclco%Type;
    sbttactivo    open.ldc_tt_tb.active_flag%Type;
    sbcuenta      Varchar2(1);
    sbMensaje        varchar2(4000);
    sbcuentacosto open.ldci_cugacoclasi.cuencosto%TYPE;
    nucontacuenta  NUMBER(8);

    Cursor cuordenes(contratista Number) Is
      Select o.order_id,
             decode(o.task_type_id,10336, o.real_task_type_id, task_type_id) task_type_id,
             o.task_type_id titr_validar,
             ab.geograp_location_id,
             o.defined_contract_id
        From open.or_order          o,
             open.or_operating_unit ou,
             open.ab_address             ab,
             open.ct_order_certifica        da
       Where o.order_status_id = 8
         And o.operating_unit_id = ou.operating_unit_id
         And ab.address_id = o.external_address_id
         And upper(ou.es_externa) = 'Y'
         And ou.contractor_id = decode(nvl(contratista,-1), -1, ou.contractor_id, nvl(contratista,-1))
         And da.order_id = o.order_id
         And da.certificate_id = nuacta;

    nucantacta Number;
  nudatoadic2 number;
  sbValidaActivoTabla  open.ld_parameter.value_chain%type:=nvl(open.dald_parameter.fsbgetvalue_chain('LDC_VAL_CONF_ACTIV_EN_TABLA',null),'N');
  nudatoadic2 number;


  Begin
    sbordenes  := 0;
    nucantacta := 0;
    
    Begin
      Select Count(*)
        Into nucantacta
        From open.ge_detalle_acta d
       Where d.id_acta = nuacta;
    Exception
      When no_data_found Then
        nucantacta := 0;
      When Others Then
        nucantacta := 0;
    End;
    Begin
        Select casevalo
          Into sbclasact
          From open.ldci_carasewe
         Where casecodi = 'CLASIACTIVOS';
    Exception
        When no_data_found Then
          sbclasact := Null;
        When Others Then
          sbclasact := Null;
    End;

    Begin
      Select casevalo
        Into sbdatoadic
        From open.ldci_carasewe
       Where casecodi = 'NOMB_ATRIB_ACTIVO_OT';
    Exception
      When no_data_found Then
        sbdatoadic := Null;
      When Others Then
        sbdatoadic := Null;
    End;
    If nucantacta > 0 Then
      For rgcuordenes In cuordenes(nucontratista) Loop
        nuorden_id := rgcuordenes.order_id;

        Begin
          Select ttb.active_flag
            Into sbttactivo
            From open.ldc_tt_tb ttb
           Where ttb.task_type_id = rgcuordenes.task_type_id;
        Exception
          When no_data_found Then
            sbttactivo := 'N';
          When Others Then
            sbttactivo := 'N';
        End;

        If (upper(sbttactivo) = 'Y' /*Or rgcuordenes.defined_contract_id Is Not Null*/) Then
          Begin
            Select ct.clctclco
              Into nuclasicontab
              From open.ic_clascott ct
             Where ct.clcttitr = rgcuordenes.task_type_id;
          Exception
            When no_data_found Then
              nuclasicontab := Null;
            When Others Then
              nuclasicontab := Null;
          End;

          If nuclasicontab Is Not Null Then
            sbcuentacosto := NULL;
            Begin
              Select 'S',cg.cuencosto
                Into sbcuenta,sbcuentacosto
                From open.ldci_cugacoclasi cg
               Where cg.cuenclasifi = nuclasicontab
                 And cg.cuencosto Is Not Null;
            Exception
              When no_data_found Then
                sbcuenta := 'N';
                sbcuentacosto := NULL;
              When Others Then
                sbcuenta := 'N';
                sbcuentacosto := NULL;
            End;

            If sbcuenta = 'S' Then
              Begin
                Select 1
                  Into nuactivo
                  From Table(open.ldc_boutilities.splitstrings(sbclasact, ','))
                 Where column_value Is Not Null
                   And column_value = nuclasicontab;
              Exception
                When no_data_found Then
                  nuactivo := Null;
                When Others Then
                  nuactivo := Null;
              End;

              If nuactivo = 1 Then


                If sbdatoadic Is Not Null Then
                  Begin
          --200-1957
                    select 1
                      into nudatoadic
                    from open.OR_TASKTYPE_ADD_DATA D,open.ge_attrib_set_attrib s,  open.ge_attributes a, open.or_requ_data_value r , open.or_order o
                    where d.task_type_id=O.TASK_TYPE_ID
                      AND D.ATTRIBUTE_SET_ID=s.ATTRIBUTE_SET_ID
                      and s.attribute_id=a.attribute_id
                      and r.attribute_set_id=d.attribute_set_id
                    and r.order_id=o.order_id
                    and O.order_id=nuorden_id
                    and DECODE(S.CAPTURE_ORDER,1, NAME_1,2,NAME_2,3, NAME_3, 4, NAME_4, 5,NAME_5, 6, NAME_6, 7,NAME_7, 8,NAME_8, 9,NAME_9,10,NAME_10,11,NAME_11,12,NAME_12,13, NAME_13, 14,NAME_14, 15, NAME_15, 16, NAME_16, 17, NAME_17,  18, NAME_18, 19, NAME_19, 20,NAME_20, 'NA')=sbdatoadic;
                    /*Select 1
                      Into nudatoadic
                      From or_requ_data_value
                     Where order_id = nuorden_id
                       And name_1 = sbdatoadic
                        Or name_2 = sbdatoadic
                        Or name_3 = sbdatoadic
                        Or name_4 = sbdatoadic
                        Or name_5 = sbdatoadic
                        Or name_6 = sbdatoadic
                        Or name_7 = sbdatoadic
                        Or name_8 = sbdatoadic
                        Or name_9 = sbdatoadic
                        Or name_10 = sbdatoadic
                        Or name_11 = sbdatoadic
                        Or name_12 = sbdatoadic
                        Or name_13 = sbdatoadic
                        Or name_14 = sbdatoadic
                        Or name_15 = sbdatoadic
                        Or name_16 = sbdatoadic
                        Or name_17 = sbdatoadic
                        Or name_18 = sbdatoadic
                        Or name_19 = sbdatoadic
                        Or name_20 = sbdatoadic;*/
          --200-1957
                  Exception
                    When no_data_found Then
                      nudatoadic := Null;
                    When Others Then
                      nudatoadic := Null;
                  End;
          --200-1957
                  if nudatoadic is null and sbValidaActivoTabla = 'S' then
                    select count(1) into nudatoadic
                    from OPEN.ldci_actiubgttra
                   where ACBGLOCA = rgcuordenes.geograp_location_id
                     AND ACBGTITR = rgcuordenes.task_type_id;
                  end if;

                  If nudatoadic Is Null or nudatoadic > 1 or nudatoadic = 0 Then
                    sbordenes := sbordenes + 1;
                    if nvl(instr(sbMensaje,rgcuordenes.task_type_id),0) = 0 then
                      sbMensaje:=sbMensaje||','||rgcuordenes.titr_validar;
                      dbms_output.put_line('Error 1:'||rgcuordenes.order_id);
                    end if;
                  End If;
          --200-1957
                Else
                  sbordenes := sbordenes + 1;
                  if nvl(instr(sbMensaje,rgcuordenes.task_type_id),0) = 0 then
                    sbMensaje:=sbMensaje||','||rgcuordenes.titr_validar;
                     dbms_output.put_line('Error 2:'||rgcuordenes.order_id);
                  end if;
                End If;
              Else
                Begin
                  Select ccbgceco
                    Into nucentrocosto
                    From open.ldci_cecoubigetra
                   Where ccbgloca = rgcuordenes.geograp_location_id
                     And ccbgtitr = rgcuordenes.task_type_id;
                Exception
                  When no_data_found Then
                    nucentrocosto := Null;
                  When Others Then
                    nucentrocosto := Null;
                End;

                If nucentrocosto Is Null Then
                 SELECT COUNT(1) INTO nucontacuenta
                   FROM(
                        SELECT to_number(COLUMN_VALUE) cuenta
                          FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('LDC_VAL_CONT_CUENTAMULTAS',NULL),','))
                        )
                  WHERE cuenta = to_number(TRIM(sbcuentacosto));
                 IF nucontacuenta = 0 THEN
                  sbordenes := sbordenes + 1;
                  if nvl(instr(sbMensaje,rgcuordenes.task_type_id),0) = 0 then
                    sbMensaje:=sbMensaje||','||rgcuordenes.titr_validar;
                    dbms_output.put_line('Error 3:'||rgcuordenes.order_id);
                  end if;
                 END IF;
                Else
                  sbordenes := sbordenes + 0;
                End If;
              End If;
            Else
              sbordenes := sbordenes + 1;
              if nvl(instr(sbMensaje,rgcuordenes.task_type_id),0) = 0 then
                sbMensaje:=sbMensaje||','||rgcuordenes.titr_validar;
              end if;
            End If;
          Else
            sbordenes := sbordenes + 1;---CASO 200-1581}
            if nvl(instr(sbMensaje,rgcuordenes.task_type_id),0) = 0 then
              sbMensaje:=sbMensaje||','||rgcuordenes.titr_validar;
            end if;
          End If;
        Else
          sbordenes := sbordenes + 0;
        End If;
      End Loop;
    End If;

    If sbordenes > 0 Then
      sbMensaje:='Existen ordenes de los siguientes tipos de trabajo sin configuraci?n contable: '||sbMensaje;
      dbms_output.put_line(sbMensaje);
      
    Else
      null;
    End If;
  Exception
    When Others Then
      sbMensaje := Sqlerrm;
      
      dbms_output.put_line(sbMensaje);
      Raise;


  End;
0
0
