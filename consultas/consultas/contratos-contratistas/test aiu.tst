PL/SQL Developer Test script 3.0
14
begin
  -- Call the procedure
  "OPEN".ldc_acta.obteneraiu(inuorder_id => :inuorder_id,
                      inucontratista => :inucontratista,
                      onuaui_admin => :onuaui_admin,
                      onuaui_imprev => :onuaui_imprev,
                      onuaui_util => :onuaui_util);
                      
  
  :nuPORCENTAJE := OPEN.LDC_ACTA.FNUVALIDARETENT(:nuTASK_TYPE_ID, 'RI');
  
  :sbTipo:="OPEN".LDC_ACTA.FSBTIPOITEM(:nuTASK_TYPE_ID, :nuPORCENTAJE, 'RI');
  --IF TIPO = O CALCULA LA UTILIDAD SINO NO
end;
8
inuorder_id
1
54048934
4
inucontratista
1
1328
3
onuaui_admin
1
10
4
onuaui_imprev
1
1
4
onuaui_util
1
10
4
:nuTASK_TYPE_ID
1
10775
3
:nuPORCENTAJE
1
15
4
:sbTipo
1
-1
5
0
