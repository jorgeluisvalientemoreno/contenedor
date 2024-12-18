Imports Oracle.DataAccess.Client
Imports Oracle.DataAccess.Types
Imports OpenSystems.Common
Imports OpenSystems.Common.Data
Imports OpenSystems.Common.Util
Imports OpenSystems.Common.ExceptionHandler

Namespace DAL

    ''' <summary>
    ''' Conexion Local (Desarrollo)
    ''' </summary>
    ''' <remarks></remarks>
    Public Class Oracle

        Public Conexion As New OracleConnection


        Sub New()
            If General.ModoDesarrollo = True Then
                If General.BDD = "QH" Then
                    'QH
                    Conexion.ConnectionString = "Data Source=(DESCRIPTION=" _
        + "(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.25.6.11)(PORT=1521)))" _
        + "(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=SFQH0707)));" _
        + "User Id=Open;Password=O28E1019194E69D3F7A0B2A2953F97;"

                ElseIf General.BDD = "BD" Then
                    'BD
                    Conexion.ConnectionString = "Data Source=(DESCRIPTION=" _
              + "(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.25.6.10)(PORT=1521)))" _
              + "(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=SFBD0707)));" _
              + "User Id=Open;Password=O93F9274DF73D7426E522DD5C2C2D8;"
                ElseIf General.BDD = "BZ" Then
                    'BZ
                    Conexion.ConnectionString = "Data Source=(DESCRIPTION=" _
         + "(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.10.76)(PORT=1521)))" _
         + "(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=SFBZ0707)));" _
         + "User Id=Open;Password=OC7D447525E06174B07189F8989773;"

                End If
                If Conexion.ConnectionString <> String.Empty Then
                    Try
                        If Conexion.State = ConnectionState.Broken Or Conexion.State = ConnectionState.Closed Then
                            Conexion.Open()
                        End If
                    Catch ex As OracleException
                        Select Case ex.Number
                            Case 12545
                                MessageBox.Show("Base de datos no disponible.")
                            Case 28000
                                MessageBox.Show(String.Format("La cuenta esta bloqueada. [{0}]", General.BDD))
                            Case Else
                                MessageBox.Show("Error de Conexión: " + ex.Message.ToString())
                        End Select
                    End Try
                End If
            End If
            'Ruta DLL local
            'C:\Windows\assembly\GAC_32\Oracle.DataAccess\2.112.3.0__89b483f429c47342\Oracle.DataAccess.dll
        End Sub

        Sub Cerrar()
            If General.ModoDesarrollo = True Then
                With Conexion
                    If Not (.State = ConnectionState.Closed Or .State = ConnectionState.Broken) Then
                        .Close()
                    End If
                End With
            End If
        End Sub

    End Class

End Namespace
