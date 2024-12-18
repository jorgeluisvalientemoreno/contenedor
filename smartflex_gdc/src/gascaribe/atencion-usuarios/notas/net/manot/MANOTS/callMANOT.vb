Imports System
Imports System.Collections.Generic
Imports OpenSystems.Common.Interfaces

Public Class callMANOT
    Implements IOpenExecutable

    Public Sub Execute(ByVal parameters As Dictionary(Of String, Object)) Implements IOpenExecutable.Execute
        '' --- verificar los parametros enviados
        ''Cuando la aplicacion se ejecute "DIRECTAMENTE", validar que los parametros no esten vacios
        ''Parameter Keys: CallerName, ExecMode, NodeLevel, NodeId, BaseTable, Header, ExecutableName
        'Dim Parametros As String = "" : Dim b As String = ""
        'Try
        '    For Each c As KeyValuePair(Of String, Object) In parameters
        '        Parametros += c.Key.ToString + " | " + c.Value.ToString + vbCrLf
        '    Next
        'Catch ex As Exception
        '    'MsgBox(Parametros)
        '    MsgBox("Error al iterar los parametros." + vbCrLf + ex.Message)
        'End Try

        'MsgBox("prueba arranque dvm")

        Try
            Dim NodeID As Integer
            If IsNumeric(parameters.Item("NodeId")) Then
                NodeID = Convert.ToInt64(parameters("NodeId").ToString)
            End If

            Dim FRM As New MANOT(NodeID)
            Using FRM
                FRM.ShowDialog()
            End Using
        Catch ex As Exception
            RaiseError("Error al cargar Form. " + vbCrLf + ex.Message, 0, MsgBoxStyle.Exclamation)
        End Try
    End Sub
End Class

