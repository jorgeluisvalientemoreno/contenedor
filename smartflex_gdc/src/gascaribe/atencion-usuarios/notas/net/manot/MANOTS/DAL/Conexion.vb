Imports Oracle.DataAccess.Client
Imports Oracle.DataAccess.Types
Imports OpenSystems.Common
Imports OpenSystems.Common.Data
Imports OpenSystems.Common.Util
Imports OpenSystems.Common.ExceptionHandler

Namespace DAL

    Public Class Oracle
        Public OracleConnection As New OracleConnection
        Dim BDD As String = "QH"

        Sub New()

            Dim oradb As String 
            If BDD = "QH" Then
                'QH
                OracleConnection.ConnectionString = "Data Source=(DESCRIPTION=" _
    + "(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.25.6.11)(PORT=1521)))" _
    + "(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=SFQH0707)));" _
    + "User Id=Open;Password=O28E1019194E69D3F7A0B2A2953F97;"

            ElseIf BDD = "BD" Then
                'BD
                OracleConnection.ConnectionString = "Data Source=(DESCRIPTION=" _
          + "(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.25.6.10)(PORT=1521)))" _
          + "(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=SFBD0707)));" _
          + "User Id=Open;Password=O93F9274DF73D7426E522DD5C2C2D8;"
            ElseIf BDD = "BZ" Then
                'BZ
                OracleConnection.ConnectionString = "Data Source=(DESCRIPTION=" _
     + "(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.10.40)(PORT=1521)))" _
     + "(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=SFBZ0707)));" _
     + "User Id=Open;Password=OA12AA88FE6681A4F02BB5E712D1D6;"

            End If


            'OracleConnection.ConnectionString = oradb
            Try
                ''DANVAL - RONCOL : 13.12.18 SE BLOQUEA PARA PRUEBAS PARA EVITAR ERRORES EN POSIBLES CAIDAS DE LOS SERVIDORES
                'CODIGO PARA CONEXION A BASE DE DATOS SIN OSF
                'If OracleConnection.State = ConnectionState.Broken Or OracleConnection.State = ConnectionState.Closed Then
                '    OracleConnection.Open()
                'End If
            Catch ex As OracleException
                Select Case ex.Number
                    Case 1
                        MessageBox.Show("Error al intentar insertar datos duplicados.")
                    Case 12545
                        MessageBox.Show("Base de datos no disponible.")
                    Case Else
                        MessageBox.Show("Error de Conexión: " + ex.Message.ToString())
                End Select
            End Try
        End Sub

        Sub Cerrar()
            With OracleConnection
                If Not (.State = ConnectionState.Closed Or .State = ConnectionState.Broken) Then
                    .Close()
                End If
            End With

        End Sub

    End Class

End Namespace
