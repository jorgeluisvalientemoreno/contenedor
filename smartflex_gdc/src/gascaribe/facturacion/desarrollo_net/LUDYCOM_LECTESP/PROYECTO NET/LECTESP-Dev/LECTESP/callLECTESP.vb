Imports System
Imports System.Collections.Generic
Imports OpenSystems.Common.Interfaces
Imports OpenSystems.Common.Data

Public Class callLECTESP
    Implements IOpenExecutable

    ''' <summary>
    ''' -- verificar los parametros enviados --
    ''' Cuando la aplicacion se ejecute "DIRECTAMENTE", validar que los parametros no esten vacios
    ''' </summary>
    ''' <param name="parameters">Keys: CallerName, ExecMode, NodeLevel, NodeId, BaseTable, Header, ExecutableName</param>
    Public Sub Execute(ByVal parameters As Dictionary(Of String, Object)) Implements IOpenExecutable.Execute

        'Dim Parametros As String = "" : Dim b As String = ""
        'Try
        '    For Each c As KeyValuePair(Of String, Object) In parameters
        '        Parametros += c.Key.ToString + " | " + c.Value.ToString + vbCrLf
        '    Next
        'Catch ex As Exception
        '    'MsgBox(Parametros)
        '    MsgBox("Error al iterar los parametros." + vbCrLf + ex.Message)
        'End Try
        'Dim a As String = String.Empty
        'For Each pair As KeyValuePair(Of String, Object) In parameters
        ' Display Key and Value.
        'a += pair.Key.ToString + "|" + pair.Value.ToString + vbCrLf
        'Next


        Dim NodeID As String = parameters.Item("NodeId")

        'If IsNumeric(parameters.Item("NodeId")) Then
        'NodeID = Convert.ToInt64(parameters("NodeId").ToString)
        'End If

        'String.IsNullOrEmpty(OpenDataBase.CurrentUserInfo.DbUserName.ToString)
        'If OpenDataBase.CurrentUserInfo.DbUserName.ToString = "OPEN" Then
        If Not OpenDataBase.DBConnectionState = ConnectionState.Closed And Not OpenDataBase.DBConnectionState = ConnectionState.Broken Then
            General.ModoDesarrollo = False
        Else
            General.ModoDesarrollo = True
            General.BDD = NodeID
            General.Oracle = New DAL.Oracle
        End If


        'MsgBox("Checkconn => " + TipoConexion + vbCrLf + "Modo Desarrollo => " + ModoDesarrollo.ToString + vbCrLf + _
        '       "open current info =>" + OpenDataBase.CurrentUserInfo.DbUserName.ToString + vbCrLf + _
        '       "OpenDataBase.DBConnectionState =>> " + OpenDataBase.DBConnectionState.ToString)

        Try
            Using FRM As LECTESP = New LECTESP(NodeID)
                FRM.ShowDialog()
            End Using
        Catch ex As Exception
            RaiseMensaje("Error: " + vbCrLf + ex.Message, 0, MsgBoxStyle.Exclamation)
        End Try

    End Sub
End Class

