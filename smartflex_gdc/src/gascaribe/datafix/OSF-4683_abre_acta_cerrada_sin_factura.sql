begin
  DECLARE
  
    nuError   NUMBER;
    sbError   VARCHAR2(4000);
    sbComm    VARCHAR2(200) := 'Apertura acta CASO OSF-4683';
    sbfactura ge_acta.extern_invoice_num%type;
  
    -- Cursor para validar si el acta fue cancelada
    Cursor Cu_Actas is
      select a.id_acta, a.extern_invoice_num -- nro de factura
        from open.ge_Acta a
       where a.id_acta in (248151, 248152, 248153);
  
    rfCu_Actas Cu_Actas%ROWTYPE;
  
  BEGIN
    --
    sbfactura := NULL;
    --
    execute immediate 'alter trigger TRG_GE_CONTRATO_AU_SAO604282 disable';
    FOR rfCu_Actas in cu_Actas loop
    
      If rfCu_Actas.extern_invoice_num is NULL then
      
        ldc_prAbrirActaCerrada(rfCu_Actas.id_acta,
                               sbComm,
                               nuError,
                               sbError);
      
        IF nuError = 0 THEN
          COMMIT;
          DBMS_OUTPUT.PUT_LINE('ACTA ' || rfCu_Actas.id_acta ||
                               ' REVERSADA OK ');
        ELSE
          ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('ERROR ACTA ' || rfCu_Actas.id_acta || ' ' ||
                               sbError);
        END IF;
      
      Else
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR ACTA ' || rfCu_Actas.id_acta ||
                             ' Con Nro de factura, ' ||
                             rfCu_Actas.extern_invoice_num ||
                             ', no se puede abrir, valide con contabilidad.');
      End If;
    
    END LOOP;
    execute immediate 'alter trigger TRG_GE_CONTRATO_AU_SAO604282  enable';
  
  exception
    when others then
      rollback;
      execute immediate 'alter trigger TRG_GE_CONTRATO_AU_SAO604282 enable';
  END;

end;
/
