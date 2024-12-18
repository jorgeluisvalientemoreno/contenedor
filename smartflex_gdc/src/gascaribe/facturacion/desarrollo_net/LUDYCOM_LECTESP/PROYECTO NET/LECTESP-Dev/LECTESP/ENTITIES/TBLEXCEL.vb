
Namespace ENTITIES

    ''' <summary>
    ''' Definicion de Plantilla de Importación
    ''' </summary>
    ''' <remarks></remarks>
    Public Class TBLEXCEL

        Public Ruta As String

        Public Property ID As Int64
        Public Property ANO As Int64
        Public Property MES As Int64
        Public Property CICLO As Int64
        Public Property PERIODO As Int64
        Public Property PRODUCTO As Int64
        Public Property LECTURA As Int64
        Public Property PRESION As Double
        Public Property USUARIO As String
        Public Property FEIMP As DateTime

        Public DtSetValidaciones As New DataSet

        ' -- Datatables Validaciones --
        Public DTValEstrucTablas As New DataTable("VALIDACIONES")
        Public DTImportacion As New DataTable("LDC_CM_LECTESP_EXCEL")
        Public DTValDatosLectespCrit As New DataTable("INFOLECTESPCRIT")
        Public DTValPeriodoFacturacion As New DataTable("PERIFACT")
        Public DTValCicloFacturacion As New DataTable("CICLO")
        Public DTValProductos As New DataTable("SERVSUSC")

        'id       NUMBER(20) not null,
        'ano      NUMBER(4) not null,
        'mes      NUMBER(2) not null,
        'ciclo    NUMBER(6) not null,
        'periodo  NUMBER(6) not null,
        'producto NUMBER(15) not null,
        'lectura  NUMBER(14,4) not null,
        'presion  NUMBER(14,4) not null,
        'usuario  VARCHAR2(50) not null,
        'feimp    DATE default SYSDATE not null

    End Class

    Public Class TBLPLANTILLA
        Public Property ID As Int64
        Public Property FECHA As Date
        Public Property PLANTILLA As String
        Public Property RUTAPLANTILLA As String
        Public Property REGISTROS As Int64
        Public Property USUARIO As String
        Public Property SESION As Int64
        Public Property MAQUINA As String

        'ID	        NUMBER
        'FECHA	    DATE
        'PLANTILLA	VARCHAR2(50)
        'RUTAPLANTILLA	VARCHAR2(1000)
        'REGISTROS	NUMBER(15)
        'USUARIO	VARCHAR2(100)
        'SESION	    NUMBER(15)
        'MAQUINA	VARCHAR2(100)



    End Class
End Namespace