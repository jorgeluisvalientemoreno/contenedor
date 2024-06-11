CREATE OR REPLACE FUNCTION SYS.SA_SystemPasssVerify
    (sbUsername       IN     varchar2,
     sbPassword       IN     varchar2,
     sbOld_password   IN     varchar2
     )
RETURN boolean IS
/*************************************************
Propiedad intelectual de Open Systems (c).

Unidad		: Modulo de Seguridad y Auditoria Convernet
Descripcion	: Makes the Password Verfication according with the
              System Securitiy Policies establisched

Parámetros			Descripción
============  	===================

Mantains the general password validations, this PACKAGE is
used BY SA_Bosystem PACKAGE in user repositories
Retorno
============

Autor		: Luis Fernando Macias
Fecha		: vie, feb 15, '2002 a las 11:22:31 AM GMT-05:00

  Notes : connect sys/<password> as sysdba before running the script

Historia de Modificaciones
Fecha	  Autor	Modificacion
===== ===== ====================
27-09-2012  sagudeloSAO160212  Se elimina validación de la contraseña, ya que esta
                               se hará por GUI
18-SEP-2002 Cdominguez  Se modifica la función SystemPasssVerify, se adiciona
                        registro en log de cambio de password

*************************************************/
    sbOldPassword       varchar2(50);
    sbPasswordEncrypt   varchar2(50);
BEGIN

        -- envia password encriptado para el LOG

        for i in 1..length(sbPassword) loop
            sbPasswordEncrypt := sbPasswordEncrypt||'*';
        END loop;

        -- Registra LOG de cambio de password

       execute immediate 'begin sa_bopassword_chng_log.insRecord(:sbUsername,:sbPasswordEncrypt,:sbOldPassword); END;'
       using IN sbUsername, IN sbPasswordEncrypt, IN sbOldPassword;

       return TRUE;

   -- Everything is fine; return TRUE ;
  EXCEPTION
    when others then
        return FALSE;
--}
END;
/
