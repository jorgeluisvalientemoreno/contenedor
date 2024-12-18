CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_ORD_DES_ODER_REDES
BEFORE INSERT OR UPDATE ON open.ldc_ordenes_ofertados_redes
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
/*******************************************************************************
Propiedad intelectual de PROYECTO GASES DEL CARIBE

  Autor                :
  Fecha                :

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  13-Feb-2019     ESANTIAGO           Se agregaro validaciones solicitadas en caso 200-2387
  10-04-2018      horbath             Se modifica segun requerimiento caso 200-2391

  08-04-2020      Alain Quintero/OL   Caso 364 se modifico el trigger para que se puedan insertar
                                      valor 0 en metro_lineal en las ordenes nietas y se crearon
                                      validaciones en las cantiades de metro_lineales entre ordenes
                                      padre, hija y nieta a la hora de actualizar algun registro.
  21-05-2020      Mateo Velez/OL      Se modifico y elimino sentencia de logprueba que pertenece algun
									  ambiente bz.

  24-09-2020     dsaltarin           Caso 523: Se recuperara el cambio 237 y se aplicara cambio 443:
  01-12-2019      Eceron             Caso 237: Se ajusta para eliminar la validación del estado de la orden padre.
                                     Se valida que la orden no exista en ge_detalle_Acta
  12-07-2020      OL-Software        Caso 443: Se adicionaron validaciones para que la orden padre no se ingrese
                                     como hija o nieta, para que la hija no se ingrese como padre o nieta,
                                     y para que la nieta no se ingrese como padre o hija.



  *******************************************************************************/

DECLARE

 sbmensaje        VARCHAR2(2000);
 sbtitrredes      VARCHAR2(2000); --200-2391 se almacena tipo de trabajo de redes
 eerror           EXCEPTION;
 nusumaordenhija  open.ldc_ordenes_ofertados_redes.metro_lineal%TYPE;
 nusumaordennieta open.ldc_ordenes_ofertados_redes.metro_lineal%TYPE;
 nusumaordenpadre open.ldc_ordenes_ofertados_redes.metro_lineal%TYPE;
 nutotahijas      open.ldc_ordenes_ofertados_redes.metro_lineal%TYPE;
 nutotanieta      open.ldc_ordenes_ofertados_redes.metro_lineal%TYPE;
 nuconta          NUMBER(4);
 padre  LDC_ORDENES_OFERTADOS_REDES.ORDEN_PADRE%type;
 hija   LDC_ORDENES_OFERTADOS_REDES.ORDEN_HIJA%type;
 nieta  LDC_ORDENES_OFERTADOS_REDES.ORDEN_NIETA%type;
 sbEntrega varchar2(30):='OSS_OL_0000364_2';

 PRAGMA AUTONOMOUS_TRANSACTION;

CURSOR c_padre (or_padre number) IS
    select ORDEN_PADRE,ORDEN_HIJA,ORDEN_NIETA
    from LDC_ORDENES_OFERTADOS_REDES
    WHERE ORDEN_PADRE = or_padre;

CURSOR c_hija (or_hija number) IS
    select ORDEN_PADRE,ORDEN_HIJA
    from LDC_ORDENES_OFERTADOS_REDES
    WHERE ORDEN_HIJA = or_hija
    group by ORDEN_HIJA,ORDEN_PADRE;

CURSOR c_hija_2 (or_hija number) IS
    select ORDEN_PADRE,ORDEN_HIJA,ORDEN_NIETA
    from LDC_ORDENES_OFERTADOS_REDES
    WHERE ORDEN_HIJA = or_hija
    AND ORDEN_NIETA IS NULL;

CURSOR c_relacion (c_hi number, c_ni number ) is
   select count(*) n_reg
   FROM or_related_order
   where ORDER_ID=c_hi
   and RELATED_ORDER_ID=c_ni;

-- varibles del caso 200-2391
diferencia_editar ldc_ordenes_ofertados_redes.PRESUPUESTO_OBRA%type;
estado_hija    or_order.order_status_id%type :=-1;
estado_padre   or_order.order_status_id%type :=-1;
estado_nieta   or_order.order_status_id%type :=-1;
contrato_hija  or_order.DEFINED_CONTRACT_ID%type;
cupo_disponible number;
VALOR_TOTAL_CONTRATO ge_contrato.VALOR_TOTAL_CONTRATO%type;
valor_asignado       ge_contrato.valor_asignado%type;
valor_no_liquidado   ge_contrato.valor_no_liquidado%type;
valor_liquidado      ge_contrato.valor_liquidado%type;

sbFlagAsignar  VARCHAR2(2) :='N';
sbDatos     VARCHAR2(1);

--523--------------------------------
csbENTREGA237    CONSTANT varchar2(10) := '0000237';
csbENTREGA443    VARCHAR2(30):='0000443';
--523--------------------------------

--200-2391 se valida titr de redes
CURSOR cuValidaTitrRed IS
SELECT 'X'
FROM or_order
WHERE order_id = hija
  and task_type_id in ( SELECT TO_NUMBER(COLUMN_VALUE)
					    FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(sbtitrredes, ',')));
BEGIN

    padre := :new.ORDEN_PADRE;
    hija  := :new.ORDEN_HIJA;
    nieta := :new.ORDEN_NIETA;

    IF fblaplicaentrega(LDC_PKGASIGNARCONT.FSBVERSION) THEN
        sbFlagAsignar := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ASIGCONT', Null);  --TICKET 200-810 LJLB -- se consulta si se va asignar el contrato o no
        sbtitrredes:=open.dald_parameter.fsbgetvalue_chain('LDC_TITRVALREDES',null);
    END IF;

    -- 200-2391 se determina estado orden hija y contrato asociado a la orden hija
    if hija is not null then

        begin
               select ORDER_STATUS_ID	, DEFINED_CONTRACT_ID into estado_hija, contrato_hija from or_order where order_id=hija;
        exception
          when no_data_found then
               null;
          when others then
               null;
        end;

        ut_trace.trace('Es orden Hija: '||hija||' estado: '||estado_hija||' contrato '||contrato_hija, 10);

        --200-2391 -- se valida si la orden hija esta configurada en el parametro LDC_TITRVALREDES
        OPEN cuValidaTitrRed;
        FETCH cuValidaTitrRed INTO sbDatos;
        IF cuValidaTitrRed%NOTFOUND THEN
          sbmensaje := 'El tipo de trabajo de la orden Hija no esta configurado en el parametro LDC_TITRVALREDES';
          RAISE eerror;
        END IF;
        CLOSE cuValidaTitrRed;
    end if;
    --523--------------------------------
    --237 Se elimina validación de estado por tanto no se necesita variable estado_padre
    /*if padre  is not null then
    begin
    select ORDER_STATUS_ID	 into estado_padre from or_order where order_id=padre;
    exception
    when no_data_found then
      null;
    when others then
      null;
    end;

    end if;*/
    --523--------------------------------

    if nieta  is not null then
        begin
              select ORDER_STATUS_ID	 into estado_nieta from or_order where order_id=nieta;
        exception
           when no_data_found then
                null;
           when others then
                null;
        end;
    end if;
    IF inserting THEN

         --se valida si el flag de contrato esta activo
         IF sbFlagAsignar = 'S' THEN
            if estado_hija<>-1 then
                 --200-2391
                 /* Se valida Al momento de asignar (cargar por primera vez, es decir No Editar) el presupuesto de Obra, para ordenes hijas, se valide lo siguiente:
                 Si la orden se encuentra anulada o cerrada, no se debe permitir realizar modificaciones sobre el registro.
                 Si la orden no ha sido asignada (es decir, se encuentra registrada), asignar el valor al registro correspondiente.
                 Si la orden ya está asignada, el sistema no deberá permitir guardar presupuesto en la forma y notificará al usuario de que la
                 orden ya se encuentra asignada y presenta inconsistencias. Que debe revisar el caso. */

                  if estado_hija in (12,8) /*and  :new.PRESUPUESTO_OBRA is not null*/ then
                    sbmensaje := 'No se permite esta accion porque la orden hija se encuentra anulada o cerrada.';
                    RAISE eerror;
                  end if;


                  if estado_hija in (5) and nieta is null /*and :new.PRESUPUESTO_OBRA is not null */ then
                    sbmensaje := 'No se permite guardar presupuesto porque la orden hija se encuentra asignada. Revise caso.';
                    RAISE eerror;
                  end if;

		        end if; --if estado_hija<>-1 then
            --523--------------------------------
            --237
            --No se debe validar estado Ot Padre
            /*if (estado_padre<>-1 and hija is null) or estado_nieta<>-1 then
              if estado_padre in (8,12) then
                  sbmensaje := 'No se permite esta accion porque la orden padre se encuentra anulada o cerrada.';
                  RAISE eerror;
                 end if;

                 if estado_nieta in (8,12) then
                  sbmensaje := 'No se permite esta accion porque la orden nieta se encuentra anulada o cerrada.';
                  RAISE eerror;
                 end if;
            end if;
           END IF;*/
           if estado_nieta<>-1 then
             if estado_nieta in (8,12) then
                 sbmensaje := 'No se permite esta accion porque la orden nieta se encuentra anulada o cerrada.';
                 RAISE eerror;
             end if;
           end if;
         end if;--IF sbFlagAsignar = 'S' THEN
           --523--------------------------------
          --------------------------CASO 364------------------------
          IF fblaplicaentrega(sbEntrega) THEN
            IF :new.orden_nieta IS NULL THEN
              IF :new.metro_lineal = 0 THEN
               sbmensaje := 'El valor del metro lineal debe ser mayor a cero.';
               RAISE eerror;
              END IF;
            END IF;
          ELSE
            -- Validamos que el campo metro lineal sea diferente de 0
            IF :new.metro_lineal = 0 THEN
              sbmensaje := 'El valor del metro lineal debe ser mayor a cero.';
              RAISE eerror;
            END IF;
          END IF;
          -------------------------FIN CASO 364--------------


          -- Validamos que la orden hija sea diferente a la orden padre y la nieta
          IF :new.orden_nieta IS NOT NULL AND :new.orden_hija IS NOT NULL AND :new.orden_padre IS NOT NULL AND
           ((:new.orden_nieta = :new.orden_hija) OR (:new.orden_nieta = :new.orden_padre) OR (:new.orden_hija = :new.orden_padre)) THEN
            sbmensaje := 'La ordénes nietas, las hijas y las padres deben ser diferentes.';
            RAISE eerror;
          END IF;
          -- Validamos que la orden hija sea diferente a la orden padre
          IF :new.orden_nieta IS NULL AND :new.orden_hija IS NOT NULL AND :new.orden_padre IS NOT NULL AND (:new.orden_hija = :new.orden_padre) THEN
            sbmensaje := 'La ordén hija debe ser diferente a la ordén padre.';
            RAISE eerror;
          END IF;
          -- Validamos que exista la combinacion ot_padre,ot_hija y ot_nieta
          SELECT COUNT(1) INTO nuconta
            FROM ldc_ordenes_ofertados_redes mn
           WHERE mn.orden_padre = :new.orden_padre
             AND nvl(mn.orden_hija,-1)  = nvl(:new.orden_hija,-1)
             AND nvl(mn.orden_nieta,-1) = nvl(:new.orden_nieta,-1);
          IF nuconta >= 1 THEN
            sbmensaje := 'Existe el registro ot_padre : '||to_char(:new.orden_padre)||' ot_hija : '||to_char(:new.orden_hija)||' ot_nieta : '||to_char(:new.orden_nieta);
            RAISE eerror;
          END IF;
          -- Consultamos total ordenes nietas diferentes a la q se esta insertando
          IF :new.orden_nieta IS NOT NULL THEN
              -- Verificamos que la orden nieta exista en or_order
              nuconta := 0;
              SELECT COUNT(1) INTO nuconta
               FROM or_order otp
              WHERE otp.order_id = :new.orden_nieta;
              IF nuconta = 0 THEN
                sbmensaje := 'La orden nieta : '||to_char(:new.orden_nieta)||' no existe como orden, favor consultar por ORCAO.';
                RAISE eerror;
              END IF;
              -- Validamos que no se duplique la orden nieta
              nuconta := 0;
              SELECT COUNT(1) INTO nuconta
               FROM ldc_ordenes_ofertados_redes mn
              WHERE mn.orden_nieta = :new.orden_nieta
                AND mn.orden_nieta IS NOT NULL;
              IF nuconta >= 1 THEN
                  sbmensaje := 'Existe un registro con la orden nieta : '||to_char(:new.orden_nieta);
                  RAISE eerror;
              END IF;
              nusumaordennieta := 0;
              BEGIN
               SELECT nvl(SUM(rx.metro_lineal),0) INTO nusumaordennieta
                 FROM ldc_ordenes_ofertados_redes rx
                WHERE rx.orden_nieta <> :new.orden_nieta
                  AND rx.orden_hija  = :new.orden_hija
                  AND rx.orden_padre = :new.orden_padre
                  AND rx.orden_padre IS NOT NULL
                  AND rx.orden_hija  IS NOT NULL
                  AND rx.orden_nieta IS NOT NULL;
              EXCEPTION
               WHEN no_data_found THEN
                nusumaordennieta := 0;
              END;
              nutotanieta := nusumaordennieta + nvl(:new.metro_lineal,0);
              -- Consultamos metros lineales orden hija
              nusumaordenhija := 0;
              BEGIN
               SELECT nvl(SUM(rx.metro_lineal),0) INTO nusumaordenhija
                 FROM ldc_ordenes_ofertados_redes rx
                WHERE rx.orden_hija  = :new.orden_hija
                  AND rx.orden_padre = :new.orden_padre
                  AND rx.orden_padre IS NOT NULL
                  AND rx.orden_hija  IS NOT NULL
                  AND rx.orden_nieta IS NULL;
              EXCEPTION
               WHEN no_data_found THEN
                nusumaordenhija := 0;
              END;
              -- Validamos que la sumatoria de las ordenes nietas no sobrepasen a la hija
              IF nutotanieta > nusumaordenhija THEN
                 sbmensaje := 'La sumatoria de los metros lineales de las ordenes nietas : '||to_char(nutotanieta)||' superan la cantidad de metros lineales de la orden hija :'||to_char(nusumaordenhija);
                 RAISE eerror;
              END IF;
          END IF;--IF :NEW.ORDEN_NIETA IS NOT NULL THEN
          -- Consultamos total ordenes hijas diferentes a la q se esta insertando
          IF :new.orden_hija IS NOT NULL AND :new.orden_nieta IS NULL THEN
              -- Verificamos que la orden hija exista en or_order
              nuconta := 0;
              SELECT COUNT(1) INTO nuconta
               FROM or_order otp
              WHERE otp.order_id = :new.orden_hija;

              IF nuconta = 0 THEN
                  sbmensaje := 'La orden hija : '||to_char(:new.orden_hija)||' no existe como orden, favor consultar por ORCAO.';
                  RAISE eerror;
              END IF;

              nusumaordenhija := 0;
              BEGIN
               SELECT nvl(SUM(rx.metro_lineal),0) INTO nusumaordenhija
                 FROM ldc_ordenes_ofertados_redes rx
                WHERE rx.orden_hija <> :new.orden_hija
                  AND rx.orden_padre = :new.orden_padre
                  AND rx.orden_padre IS NOT NULL
                  AND rx.orden_hija  IS NOT NULL
                  AND rx.orden_nieta IS NULL;
              EXCEPTION
               WHEN no_data_found THEN
                nusumaordenhija := 0;
              END;
              nutotahijas := nusumaordenhija + nvl(:new.metro_lineal,0);
              -- Consultamos metros lineales orden padre
              nusumaordenpadre := 0;
              BEGIN
               SELECT nvl(SUM(rx.metro_lineal),0) INTO nusumaordenpadre
                 FROM ldc_ordenes_ofertados_redes rx
                WHERE rx.orden_padre = :new.orden_padre
                  AND rx.orden_hija  IS NULL
                  AND rx.orden_nieta IS NULL;
              EXCEPTION
               WHEN no_data_found THEN
                nusumaordenpadre := 0;
              END;
              -- Validamos que la sumatoria de las ordenes hijas no sobrepasen a la padre
              IF nutotahijas > nusumaordenpadre THEN
                 sbmensaje := 'La sumatoria de los metros lineales de las ordenes hijas '||to_char(nutotahijas)||' superan la cantidad de metros lineales de la orden padre.'||to_char(nusumaordenpadre);
                 RAISE eerror;
              END IF;
              -- Validamos sumatoria ordenes nietas
              nusumaordennieta := 0;
              BEGIN
               SELECT nvl(SUM(rx.metro_lineal),0) INTO nusumaordennieta
                 FROM ldc_ordenes_ofertados_redes rx
                WHERE rx.orden_hija  = :new.orden_hija
                  AND rx.orden_padre = :new.orden_padre
                  AND rx.orden_padre IS NOT NULL
                  AND rx.orden_hija  IS NOT NULL
                  AND rx.orden_nieta IS NOT NULL;
              EXCEPTION
               WHEN no_data_found THEN
                nusumaordennieta := 0;
              END;
              IF nusumaordennieta > :new.metro_lineal THEN
                 sbmensaje := 'El valor del metro lineal de la orden hija : '||:new.orden_hija||' Valor : '||to_char(:new.metro_lineal)||', es menor La sumatoria de los metros lineales de las ordenes nietas '||to_char(nusumaordennieta);
                 RAISE eerror;
              END IF;
          END IF; --IF :NEW.ORDEN_HIJA IS NOT NULL AND :NEW.ORDEN_NIETA IS NULL THEN

          -- Validamos Orden padre
          IF :new.orden_padre IS NOT NULL AND :new.orden_hija IS NULL AND :new.orden_nieta IS NULL THEN
              -- Verificamos que la orden padre exista en or_order
              nuconta := 0;
              SELECT COUNT(1) INTO nuconta
               FROM or_order otp
              WHERE otp.order_id = :new.orden_padre;
              IF nuconta = 0 THEN
                  sbmensaje := 'La orden padre : '||to_char(:new.orden_padre)||' no existe como orden, favor consultar por ORCAO.';
                  RAISE eerror;
              END IF;
              -- Consultamos metros lineales orden padre
              nusumaordenhija := 0;
              BEGIN
               SELECT nvl(SUM(rx.metro_lineal),0) INTO nusumaordenhija
                 FROM ldc_ordenes_ofertados_redes rx
                WHERE rx.orden_padre = :new.orden_padre
                  AND rx.orden_hija  IS NOT NULL
                  AND rx.orden_nieta IS NULL;
              EXCEPTION
               WHEN no_data_found THEN
                nusumaordenhija := 0;
              END;
              nutotahijas := nusumaordenhija;
              -- Validamos que la sumatoria de las ordenes hijas no sobrepasen a la padre
              IF nutotahijas > :new.metro_lineal THEN
                sbmensaje := 'El valor del metro lineal de la orden padre : '||:new.orden_padre||' Valor : '||to_char(:new.metro_lineal)||', es menor La sumatoria de los metros lineales de las ordenes hijas '||to_char(nutotahijas);
                RAISE eerror;
              END IF;
          END IF; --IF :new.orden_padre IS NOT NULL AND :new.orden_hija IS NULL AND :new.orden_nieta IS NULL THEN

          --------------------ht.santiago caso: 2002387------------------------------------
          --------------------------------NO debe existir OT NIETA sin OT HIJA y OT PADRE.--------------------------------------------------
          IF ( hija is NULL and nieta is not NULL ) THEN
            sbmensaje := 'Debe existir OT HIJA y OT PADRE para registrar la OT NIETA';
            RAISE eerror;
          END IF;
          IF ( hija is not NULL ) THEN
              ----------------------------------NO debe existir la misma OT HIJA más de una vez si tiene OT PADRE DIFERENTE. ---------------------------------------------------
              for v_reg in c_HIJA (hija ) loop
                  IF c_HIJA%FOUND THEN
                      IF ( v_reg.ORDEN_padre <> padre  ) THEN
                          sbmensaje := 'No puede repetirse la misma OT HIJA en dos órdenes padres.';
                          RAISE eerror;
                      END IF;
                  END IF;
              end loop;
              -------------------------------NO debe existir la misma OT HIJA más de una vez si tiene la misma OT PADRE y NO tiene OT NIETA--------------------------------
              for v_reg in c_hija_2 (hija ) loop
                  IF c_hija_2%FOUND THEN
                      IF ( v_reg.ORDEN_NIETA is null and nieta is null ) THEN
                          sbmensaje := 'Solo puede haber una OT HIJA sin OT NIETA.';
                          RAISE eerror;
                      END IF;
                  END IF;
              end loop;
          END IF;--IF ( hija is not NULL ) THEN
          ----------------------------------NO debe permitir registrar OT NIETA si no existe relación entre la OT HIJA.--------------------------------------
          IF ( hija is not NULL and nieta is not  NULL ) THEN
              for v_reg in c_relacion (hija ,nieta ) loop
                  IF ( v_reg.n_reg = 0 ) THEN
                      sbmensaje:='No existe relacion entre la OT HIJA '||hija||' y la OT NIETA '||nieta;
                      RAISE eerror;
                  END IF;
              end loop;
          END IF;

          --523-----------------------
          --443-----------------------
          IF fblaplicaentregaxcaso(csbENTREGA443) THEN
              ut_trace.trace('Si aplica para el caso 443 y llamado al servicio LDC_VALIDA_ORDER_REDES.VALIDA_ORDENES',10);
              LDC_VALIDA_ORDER_REDES.VALIDA_ORDENES(:new.ORDEN_PADRE, :new.ORDEN_HIJA, :new.ORDEN_NIETA);
          END IF;
          --443-----------------------
          --523-----------------------
          --------------------------------------------------------
    ELSIF updating THEN

        --se valida si el flag de contrato esta activo
        IF sbFlagAsignar = 'S' THEN
            if estado_hija<>-1 then
               ut_trace.trace('Ingreso validacion orden Hija: '||hija||' estado: '||estado_hija||' contrato '||contrato_hija, 10);
                --200-2391
                /* Al momento de Editar la información de Presupuesto de Obra en la forma, para ordenes hijas, el sistema validará lo siguiente:
                Si la orden hija se encuentra anulada o cerrada, no se debe permitir realizar modificaciones sobre la forma.
                Si la orden hija no ha sido asignada o se encuentra bloqueada, permitir editar la información del valor de Presupuesto en la forma.
                */

                if estado_hija in (12,8) and :new.PRESUPUESTO_OBRA is not null then
                    sbmensaje := 'No se permite esta accion porque la orden hija se encuentra anulada o cerrada.';
                    RAISE eerror;
                end if;

                if estado_hija in (1,11) then
                   null;
                end if;

                -- 200-2391
                diferencia_editar := :new.presupuesto_obra-:old.presupuesto_obra;
                ut_trace.trace('Diferencia: '||diferencia_editar, 10);
                if estado_hija in (5,6,7) then
                    if diferencia_editar < 0 then
                        update or_order set Estimated_Cost = Estimated_Cost + Diferencia_Editar where order_id=hija;
                        if contrato_hija is not null then
                           update ge_contrato set valor_asignado = valor_asignado + diferencia_editar where ID_CONTRATO=contrato_hija;
                        end if;
                        commit;
                    else
                        if diferencia_editar > 0 then
                            ut_trace.trace('Ingreso a aumentar: '||diferencia_editar, 10);
                            if contrato_hija is not null then
                                -- determina valores del contrato si el contrato no es nulo
                                select VALOR_TOTAL_CONTRATO,valor_asignado,valor_no_liquidado,valor_liquidado
                                into VALOR_TOTAL_CONTRATO,valor_asignado,valor_no_liquidado,valor_liquidado
                                from ge_contrato
                                where ID_CONTRATO=contrato_hija;
                                -- 200-2391 calcula cupo disponible del contrato
                                cupo_disponible:= nvl(VALOR_TOTAL_CONTRATO,0) - (nvl(valor_asignado,0) + nvl(valor_no_liquidado,0) + nvl(valor_liquidado,0));
                                ut_trace.trace('Cupo Disponible: '||cupo_disponible, 10);
                                if cupo_disponible >= diferencia_editar then
                                    ut_trace.trace('Ingreso a Actualizar costo: '||diferencia_editar, 10);
                                    update or_order set Estimated_Cost = Estimated_Cost + Diferencia_Editar where order_id=hija;
                                    if contrato_hija is not null then
                                            update ge_contrato set valor_asignado = valor_asignado + diferencia_editar where ID_CONTRATO=contrato_hija;
                                    end if;
                                    commit;
                                else
                                    sbmensaje := 'No se permite esta accion, de modificar presupuesto, porque no se tiene cupo disponible en el contrato['||contrato_hija||'] de la orden hija.';
                                    RAISE eerror;
                                end if;--if cupo_disponible >= diferencia_editar then
                            end if;--if contrato_hija is not null then
                        end if;--if diferencia_editar > 0 then
                    end if;	--f diferencia_editar < 0 then
                 end if;--if estado_hija in (5,6,7) then
            end if; --if estado_hija<>-1 then -- final validacion estado orden hija
        end if;--IF sbFlagAsignar = 'S' THEN

        IF :old.orden_padre <> :new.orden_padre OR :old.orden_hija <> :new.orden_hija OR :old.orden_nieta <> :new.orden_nieta THEN
            --523--
            --443-
            --sbmensaje := 'Solo es posible actualizar los metros lineales si la orden no esta en acta.';
            sbmensaje := 'No se puede cambiar el número de la orden padre, hija o nieta';
            --443
            --523
            RAISE eerror;
        END IF;

        -- 200-2391 se quita validacion de editar metros lineales
        /* IF :old.metro_lineal <> :new.metro_lineal THEN
        sbmensaje := 'No es posible actualizar los metros lineales, debe borrar el registro y crearlo nuevamente con el valor corregido.';
        RAISE eerror;
        END IF; */
        --------------------------ht.santiago caso: 2002387----------------------------------
        --------------------------------NO debe existir OT NIETA sin OT HIJA y OT PADRE.--------------------------------------------------
        IF ( hija is NULL and nieta is not NULL ) THEN
            sbmensaje := 'Debe existir OT HIJA y OT PADRE para registrar la OT NIETA';
            RAISE eerror;
        END IF;

        IF ( hija is not NULL ) THEN
            ----------------------------------NO debe existir la misma OT HIJA más de una vez si tiene OT PADRE DIFERENTE. ---------------------------------------------------
            for v_reg in c_HIJA (hija ) loop
              IF c_HIJA%FOUND THEN
                IF ( v_reg.ORDEN_padre <> padre  ) THEN
                    sbmensaje := 'No puede repetirse la misma OT HIJA en dos órdenes padres.';

                    RAISE eerror;
                END IF;
              END IF;
            end loop;
            -------------------------------NO debe existir la misma OT HIJA más de una vez si tiene la misma OT PADRE y NO tiene OT NIETA
            ---------------------------------------------------
            for v_reg in c_hija_2 (hija ) loop
                IF c_hija_2%FOUND THEN
                    IF ( v_reg.ORDEN_NIETA is null and nieta is null and :old.ORDEN_NIETA <> nieta ) THEN
                        sbmensaje := 'Solo puede haber una OT HIJA sin OT NIETA.';
                        RAISE eerror;
                    END IF;
                END IF;
            end loop;

        END IF;--IF ( hija is not NULL ) THEN
        ----------------------------------NO debe permitir registrar OT NIETA si no existe relación entre la OT HIJA.--------------------------------------
        IF ( hija is not NULL and nieta is not  NULL ) THEN
            for v_reg in c_relacion (hija ,nieta ) loop
              IF ( v_reg.n_reg = 0 ) THEN
                  sbmensaje:= 'No existe relación entre la OT HIJA '||hija||' y la OT NIETA '||nieta;
                  raise eerror ;
              END IF;
            end loop;
        END IF;
        -----------------------------------------------------------
        --------------------------------------	CASO 364 -----------------------------------------------
        -- 1. con esta validacion no se permitirá ingresar/actualizar los metros lineales de la orden nieta si la suma de los metros de las
        --ordenes nietas supera los metros lineales de la orden hija.

        IF fblaplicaentrega(sbEntrega) THEN
        -- Consultamos total ordenes nietas diferentes a la q se esta insertando--

          IF :new.orden_nieta IS NOT NULL THEN
              nusumaordennieta := 0;
              BEGIN
                  SELECT
                      nvl(SUM(rx.metro_lineal), 0)
                  INTO nusumaordennieta
                  FROM
                      ldc_ordenes_ofertados_redes rx
                  WHERE
                      rx.orden_nieta <> :new.orden_nieta
                      AND rx.orden_hija = :new.orden_hija
                      AND rx.orden_padre = :new.orden_padre
                      AND rx.orden_padre IS NOT NULL
                      AND rx.orden_hija IS NOT NULL
                      AND rx.orden_nieta IS NOT NULL;

              EXCEPTION
                  WHEN no_data_found THEN
                      nusumaordennieta := 0;
              END;

              nutotanieta := nusumaordennieta + nvl(:new.metro_lineal, 0);
              -- Consultamos metros lineales orden hija
              nusumaordenhija := 0;
              BEGIN
                SELECT
                    nvl(SUM(rx.metro_lineal), 0)
                INTO nusumaordenhija
                FROM
                    ldc_ordenes_ofertados_redes rx
                WHERE
                    rx.orden_hija = :new.orden_hija
                    AND rx.orden_padre = :new.orden_padre
                    AND rx.orden_padre IS NOT NULL
                    AND rx.orden_hija IS NOT NULL
                    AND rx.orden_nieta IS NULL;

              EXCEPTION
                WHEN no_data_found THEN
                    nusumaordenhija := 0;
              END;
              -- Validamos que la sumatoria de las ordenes nietas no sobrepasen a la hija

              IF nutotanieta > nusumaordenhija THEN
                  sbmensaje := 'La sumatoria de los metros lineales de las ordenes nietas : '
                               || to_char(nutotanieta)
                               || ' superan la cantidad de metros lineales de la orden hija :'
                               || to_char(nusumaordenhija);

                  RAISE eerror;
              END IF;
          END IF;--IF :new.orden_nieta IS NOT NULL THEN

          IF :new.orden_hija IS NOT NULL AND :new.orden_nieta IS NULL THEN
              ------------------------------------------------------------------------------------------------------------------------------------------------
              -- 2. con esta validacion no se permitirá ingresar/actualizar los metros lineales de la orden hija si la suma de los metros de las
              --ordenes hijas supera los metros lineales de la orden padre.
              -- Consultamos total ordenes hijas diferentes a la q se esta insertando--
              nusumaordenhija := 0;
              BEGIN
                  SELECT
                      nvl(SUM(rx.metro_lineal), 0)
                  INTO nusumaordenhija
                  FROM
                      ldc_ordenes_ofertados_redes rx
                  WHERE
                      rx.orden_hija <> :new.orden_hija
                      AND rx.orden_padre = :new.orden_padre
                      AND rx.orden_padre IS NOT NULL
                      AND rx.orden_hija IS NOT NULL
                      AND rx.orden_nieta IS NULL;

              EXCEPTION
                  WHEN no_data_found THEN
                      nusumaordenhija := 0;
              END;

              nutotahijas := nusumaordenhija + nvl(:new.metro_lineal, 0);
              -- Consultamos metros lineales orden padre
              nusumaordenpadre := 0;
              BEGIN
              SELECT
                nvl(SUM(rx.metro_lineal), 0)
              INTO nusumaordenpadre
              FROM
                ldc_ordenes_ofertados_redes rx
              WHERE
                rx.orden_padre = :new.orden_padre
                AND rx.orden_hija IS NULL
                AND rx.orden_nieta IS NULL;

              EXCEPTION
              WHEN no_data_found THEN
                nusumaordenpadre := 0;
              END;
              -- Validamos que la sumatoria de las ordenes hijas no sobrepasen a la padre

              IF nutotahijas > nusumaordenpadre THEN
                  sbmensaje := 'La sumatoria de los metros lineales de las ordenes hijas '
                                || to_char(nutotahijas)
                                || ' superan la cantidad de metros lineales de la orden padre.'
                                || to_char(nusumaordenpadre);

                  RAISE eerror;
              END IF;

        END IF; --IF fblaplicaentrega(sbEntrega) THEN

        IF :new.orden_padre IS NOT NULL AND :new.orden_nieta IS NULL AND :new.orden_hija IS NULL THEN
            -------------------------------------------------------------------------------------------------------------------
            -- 3. con esta validacion no se permitirá bajar los metros de la ordenes padre si es menor que la suma de los metros de las ordenes hijas.
            -- Consultamos metros lineales orden padre
            nusumaordenhija := 0;
            BEGIN
                SELECT
                    nvl(SUM(rx.metro_lineal), 0)
                INTO nusumaordenhija
                FROM
                    ldc_ordenes_ofertados_redes rx
                WHERE
                    rx.orden_padre = :new.orden_padre
                    AND rx.orden_hija IS NOT NULL
                    AND rx.orden_nieta IS NULL;

            EXCEPTION
                WHEN no_data_found THEN
                    nusumaordenhija := 0;
            END;

            nutotahijas := nusumaordenhija;
			      -- Validamos que la sumatoria de las ordenes hijas no sobrepasen a la padre
            IF nutotahijas > :new.metro_lineal THEN
                sbmensaje := 'El valor del metro lineal de la orden padre : '
                             || :new.orden_padre
                             || ' Valor : '
                             || to_char(:new.metro_lineal)
                             || ', es menor a la sumatoria de los metros lineales de las ordenes hijas '
                             || to_char(nutotahijas);

                RAISE eerror;
            END IF;

        END IF;

        IF :new.orden_hija IS NOT NULL AND :new.orden_nieta IS NULL AND :new.orden_padre IS NOT NULL THEN
            ------------------------------------------------------------------------------------------------------------------------------------
            -- 4. con esta validacion no se permitirá bajar los metros de la ordenes hijas si es menor que la suma de los metros de las ordenes nietas.
            -- Validamos sumatoria ordenes nietas
            nusumaordennieta := 0;
            BEGIN
                SELECT
                    nvl(SUM(rx.metro_lineal), 0)
                INTO nusumaordennieta
                FROM
                    ldc_ordenes_ofertados_redes rx
                WHERE
                    rx.orden_hija = :new.orden_hija
                    AND rx.orden_padre = :new.orden_padre
                    AND rx.orden_padre IS NOT NULL
                    AND rx.orden_hija IS NOT NULL
                    AND rx.orden_nieta IS NOT NULL;

            EXCEPTION
                WHEN no_data_found THEN
                    nusumaordennieta := 0;
            END;
            -- Validamos que la sumatoria de las ordenes nietas no sobrepasen a la hija

            IF nusumaordennieta > :new.metro_lineal THEN
                sbmensaje := 'El valor del metro lineal de la orden hija : ' || :new.orden_hija
                                                                              || ' Valor : '
                                                                              || to_char(:new.metro_lineal)
                                                                              || ', es menor a la sumatoria de los metros lineales de las ordenes nietas '
                                                                              || to_char(nusumaordennieta);
                RAISE eerror;
            END IF;
        END IF;
     END IF;
		 --------------------------------------	FIN CASO 364 -------------------------------------------
 END IF;
 ---523-------------
 --237--------------
 IF fblaplicaentregaxcaso(csbENTREGA237) THEN
    PKG_LDC_ORDENES_OFERT_RED.PR_VALIDATE_ORDERS(:NEW.ORDEN_PADRE,:NEW.ORDEN_HIJA,:NEW.ORDEN_NIETA);
 END IF;
 --237-------------
 --523-------------

EXCEPTION
  WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('ldc_trg_ord_des_oder_redes '||sbmensaje||' '||SQLERRM, 11);
--523------------------------
--443------------------------
WHEN ex.CONTROLLED_ERROR THEN
     RAISE ex.CONTROLLED_ERROR;
--443------------------------
--523---------- -------------
 WHEN OTHERS THEN
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
  ut_trace.trace('ldc_trg_ord_des_oder_redes '||' '||SQLERRM, 11);
END;
/
