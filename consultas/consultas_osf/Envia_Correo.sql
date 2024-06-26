declare
  sbRemitente ld_parameter.value_chain%TYPE;
BEGIN

  sbRemitente := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
  ldc_enviamail(recipients => 'jvaliente@horbath.com',
                subject    => 'CORREO SERVICIO',
                message    => 'aaaaaaaaaaaaaaaaaaaaaaaaaaa');

  pkg_Correo.prcEnviaCorreo(isbRemitente        => sbRemitente,
                            isbDestinatarios    => 'jvaliente@horbath.com',
                            isbAsunto           => 'RESULTADO TRUE',
                            isbMensaje          => 'PRUEBA CORREO',
                            isbDestinatariosCC  => NULL,
                            isbDestinatariosBCC => NULL,
                            isbArchivos         => NULL);

ENd;
