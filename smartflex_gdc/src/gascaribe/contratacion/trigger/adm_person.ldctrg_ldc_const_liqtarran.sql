CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRG_LDC_CONST_LIQTARRAN
 BEFORE INSERT OR UPDATE ON ldc_const_liqtarran
 REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
 /*******************************************************************
  Propiedad intelectual JM GESTIONINFORMATICA S.A.S.

  Trigger     :  ldctrg_ldc_const_liqtarran

  Descripci?n : Validaciones de fechas de vigencias y rangos

  Autor       : John Jairo Jimenez Marimon
  Fecha       : 06-07-2016

  Historia de Modificaciones


 21/09/2019   horbath    caso 104. Se modifica para controlar que no permita insertar registros repetidos,
                         sin importar la fecha inicial y final ni la actividad, items, ni la cantidad
                         inicial y final.
 ********************************************************************/
DECLARE


 eerror    EXCEPTION;
 sbmensaje VARCHAR2(2000);
 nureg     ldc_const_liqtarran.iden_reg%TYPE;
 swval     NUMBER(1);
 nuvalrep  number; -- caso 104
 sbliqui   ldc_item_uo_lr.liquidacion%TYPE;
 PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN
 sbmensaje := NULL;
 if FBLAPLICAENTREGAXCASO('0000645') then
	return;
 end if;
 IF inserting THEN
  -- Consultamos modo de liquidaci?n
  BEGIN
   SELECT po.liquidacion INTO sbliqui
     FROM ldc_item_uo_lr po
    WHERE po.unidad_operativa = :new.unidad_operativa
      AND po.actividad        = :new.actividad_orden
      AND po.item             = :new.items;
  EXCEPTION
   WHEN no_data_found THEN
    sbmensaje := 'El registro : '||:new.iden_reg||' no tiene configuraci?n en el comando LDCCUAI.';
    RAISE eerror;
  END;
   -- Validamos modo de liquidaci?n Actividad
   IF sbliqui = 'A' AND :new.items <> -1 THEN
    sbmensaje := 'El registro : '||:new.iden_reg||' la liquidaci?n configurada es por actividad, el campo item debe ser -1.';
    RAISE eerror;
   END IF;
   -- Validamos modo de liquidaci?n Items
   IF sbliqui = 'I' AND :new.items = -1 THEN
    sbmensaje := 'El registro : '||:new.iden_reg||' la liquidaci?n configurada es por Items, el campo item debe ser diferente de -1.';
    RAISE eerror;
   END IF;
   -- Validamos que el registro no exista con una vigencia
   nureg := NULL;
   /*BEGIN
    SELECT l.iden_reg INTO nureg
      FROM ldc_const_liqtarran l
     WHERE l.unidad_operativa = :new.unidad_operativa
       AND l.actividad_orden  = :new.actividad_orden
       AND l.items            = :new.items
       AND l.zona_ofertados   = :new.zona_ofertados
       AND l.cantidad_inicial = :new.cantidad_inicial
       AND l.cantidad_final   = :new.cantidad_final
       AND trunc(SYSDATE) BETWEEN trunc(l.fecha_ini_vigen) AND trunc(l.fecha_fin_vige);
   EXCEPTION
    WHEN no_data_found THEN
     nureg := NULL;
   END;
   -- Validamos si tenemos una vigencia activa
   IF nureg IS NOT NULL THEN
    sbmensaje := 'El registro : '||:new.iden_reg||' tiene una vigencia en el registro : '||nureg;
    RAISE eerror;
   ELSE
    -- Validamos que la cantidad inicial no sea mayor a la final
    IF :new.cantidad_inicial > :new.cantidad_final THEN
       sbmensaje := 'La cantidad inicial no debe ser mayor a la cantidad final. Cantidad inicial : '||:new.cantidad_inicial||' Cantidad final : '||:new.cantidad_final;
       RAISE eerror;
    END IF;
    -- Consultamos si la cantidad inicial esta en un rango
    nureg := NULL;
    BEGIN
     SELECT l.iden_reg INTO nureg
       FROM ldc_const_liqtarran l
      WHERE :new.cantidad_inicial BETWEEN l.cantidad_inicial AND l.cantidad_final
        AND l.unidad_operativa = :new.unidad_operativa
        AND l.actividad_orden  = :new.actividad_orden
        AND l.items            = :new.items
        AND l.zona_ofertados   = :new.zona_ofertados
        AND trunc(SYSDATE) BETWEEN trunc(l.fecha_ini_vigen) AND trunc(l.fecha_fin_vige);
    EXCEPTION
     WHEN no_data_found THEN
      nureg := NULL;
    END;
    -- Validamos que la cantidad inicial no este en un rango
    IF nureg IS NOT NULL THEN
     sbmensaje := 'La cantidad inicial digitada se encuentra contenida en el rango del registro : '||nureg;
     RAISE eerror;
    END IF;
    -- Consultamos si la cantidad final esta en un rango
    nureg := NULL;
    BEGIN

     SELECT l.iden_reg INTO nureg
       FROM ldc_const_liqtarran l
      WHERE :new.cantidad_final BETWEEN l.cantidad_inicial AND l.cantidad_final
        AND l.unidad_operativa = :new.unidad_operativa
        AND l.actividad_orden  = :new.actividad_orden
        AND l.items            = :new.items
        AND l.zona_ofertados   = :new.zona_ofertados
        AND trunc(SYSDATE) BETWEEN trunc(l.fecha_ini_vigen) AND trunc(l.fecha_fin_vige);
    EXCEPTION
     WHEN no_data_found THEN
      nureg := NULL;
    END;
    -- Validamos que la cantidad final no este en un rango
    IF nureg IS NOT NULL THEN
     sbmensaje := 'La cantidad final digitada se encuentra contenida en el rango del registro : '||nureg;
     RAISE eerror;
    END IF;*/
    -- Validamos que la fecha inicial de vigencia no sea mayor a la fecha final de vigencia
    IF :new.fecha_ini_vigen > :new.fecha_fin_vige THEN
     sbmensaje := 'La fecha inicial de vigencia no debe ser mayor a la fecha final de vigencia. Fecha inicial de vigencia : '||:new.fecha_ini_vigen||' Fecha final de vigencia : '|| :new.fecha_fin_vige;
     RAISE eerror;
    END IF;
   --END IF;
 ELSIF updating THEN
  swval := 0;
  IF :new.unidad_operativa <> :old.unidad_operativa THEN
   swval := 1;
  END IF;
  IF :new.actividad_orden <> :old.actividad_orden THEN
   swval := 1;
  END IF;
  IF :new.items <> :old.items THEN
   swval := 1;
  END IF;
  IF :new.zona_ofertados <> :old.zona_ofertados THEN
   swval := 1;
  END IF;
  IF :new.cantidad_inicial <> :old.cantidad_inicial THEN
   swval := 1;
  END IF;
  IF :new.cantidad_final <> :old.cantidad_final THEN
   swval := 1;
  END IF;
  -- Validamos que la fecha inicial de vigencia no sea mayor a la fecha final de vigencia
  IF :new.fecha_ini_vigen > :new.fecha_fin_vige THEN
     sbmensaje := 'La fecha inicial de vigencia no debe ser mayor a la fecha final de vigencia. Fecha inicial de vigencia : '||:new.fecha_ini_vigen||' Fecha final de vigencia : '|| :new.fecha_fin_vige;
     RAISE eerror;
  END IF;
  -- Validamos que el valor a descontar sea mayor a 0
  IF :new.valor_liquidar < 0 THEN
     sbmensaje := 'El valor a descontar no puede ser menor a 0';
     RAISE eerror;
  END IF;
 END IF;
 IF swval = 1 THEN
  sbmensaje := 'El ?nico valor permitido para modificar es el valor a descontar y las fechas de vigencias.';
  RAISE eerror;
 END IF;
 -- caso 104
 if FBLAPLICAENTREGAXCASO('0000104') then -- cambio aplica entrega
    begin
      select l.iden_reg
             into nuvalrep
             from ldc_const_liqtarran l
             where (:new.cantidad_final BETWEEN l.cantidad_inicial AND l.cantidad_final or
                    :new.cantidad_inicial between l.cantidad_inicial AND l.cantidad_final)
                   AND l.unidad_operativa = :new.unidad_operativa
                   AND l.actividad_orden  = :new.actividad_orden
                   AND l.items            = :new.items
                   AND l.zona_ofertados   = :new.zona_ofertados
                   and l.iden_reg!=:new.iden_reg
                   and (trunc(l.fecha_ini_vigen)  between trunc(:new.fecha_ini_vigen) and trunc(:new.fecha_fin_vige)
                   or trunc(l.fecha_fin_vige)    between trunc(:new.fecha_ini_vigen) and trunc(:new.fecha_fin_vige));
    exception
      when others then
          nuvalrep := null;
    end;

    if nuvalrep is not null then
       sbmensaje := 'El rango en cantidades registrado se solapa con otro rango para la misma Unidad Operativa, Actividad, item, zona y rango de fecha:'||nuvalrep;
       RAISE eerror;
    end if;
 end if;



EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
   ut_trace.trace('ldctrg_ldc_const_liqtarran '||sbmensaje||' '||SQLERRM, 11);
 WHEN OTHERS THEN
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
  ut_trace.trace('ldctrg_ldc_const_liqtarran '||' '||SQLERRM, 11);
END;
/
