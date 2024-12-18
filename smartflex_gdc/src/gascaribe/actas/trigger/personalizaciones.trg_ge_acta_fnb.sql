CREATE OR REPLACE TRIGGER PERSONALIZACIONES.TRG_GE_ACTA_FNB
  BEFORE UPDATE ON GE_ACTA
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
 /******************************************************************************************************
  Propiedad intelectual GDCA.

  Trigger  :  TRG_GE_ACTA_FNB

  Descripcion  : Asigna la factura al acta cerrada de FNB

  Autor  : Edmundo Lara
  Fecha  : 03-09-2024

  Historia de Modificaciones

     Autor            Fecha        Caso      Descripcion
     EDMLAR        03-09-2024      OSF-3245  Si el acta que se cierra es de FNB, asigna como numero de factura el mismo numero de acta

 ******************************************************************************************************/

DECLARE

  csbSP_NAME          VARCHAR2(70) := 'TRG_GE_ACTA_FNB';
  nuErrorCode         NUMBER;         -- se almacena codigo de error
  sbMensError         VARCHAR2(2000); -- se almacena descripcion del error
  nuconta             NUMBER DEFAULT 0;


  -- Cursor para validar que el tipo de contrato corresponda a los de FNB
  Cursor CuGe_Contrato is
   SELECT count(1)
     FROM ge_contrato c
    WHERE c.id_contrato = :old.id_contrato
      and c.id_tipo_contrato in ( SELECT to_number(regexp_substr(
                                                                  (SELECT casevalo
                                                                     FROM LDCI_CARASEWE C
                                                                    WHERE C.CASECODI = 'TIPO_CONTRATOS_FNB'),
                                                                   '[^,]+',
                                                                   1,
                                                                   LEVEL
                                                                  )
                                                    ) AS TipoCont
                                      FROM dual
                                   CONNECT BY regexp_substr((SELECT casevalo
                                                               FROM LDCI_CARASEWE C
                                                              WHERE C.CASECODI = 'TIPO_CONTRATOS_FNB'), '[^,]+', 1, LEVEL) IS NOT NULL
                                );


BEGIN

  pkg_traza.trace(csbSP_NAME,
                 pkg_traza.cnuNivelTrzDef,
                 pkg_traza.csbINICIO);


  -- Cuando se actualice
  IF updating THEN
      -- Si el cambio de estado es a "C" y el tipo de acta es 1 = Liquidacion de trabajos..
      If :old.estado in ('A','a') and :new.estado IN ('C','c') and :old.id_tipo_acta = 1 THEN

         -- Buscamos si el tipo de contrato es de FNB
         open  CuGe_Contrato;
         fetch CuGe_Contrato into nuconta;
         close CuGe_Contrato;
         --
         If nuconta = 1 then
           :new.extern_invoice_num := :old.id_acta;
           :new.extern_pay_date := sysdate;
         End if;
         --
      END IF;
      
  END IF;

  pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
 WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);

    raise pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);

    raise pkg_error.CONTROLLED_ERROR;
END TRG_GE_ACTA_FNB;
/