Imports System.Collections.Generic
Imports OpenSystems.Common.Interfaces
Imports LUDYCOM.MANOT

Public Class PruebaMANOT
    Implements IOpenExecutable

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim parameters As New Dictionary(Of String, Object)
        parameters.Add("NodeId", TxtNodeId.Text.ToUpper)
        Execute(parameters)
    End Sub

    Public Sub Execute(ByVal parameters As Dictionary(Of String, Object)) Implements IOpenExecutable.Execute
        Dim a As New callMANOT
        a.Execute(parameters)
    End Sub
End Class
