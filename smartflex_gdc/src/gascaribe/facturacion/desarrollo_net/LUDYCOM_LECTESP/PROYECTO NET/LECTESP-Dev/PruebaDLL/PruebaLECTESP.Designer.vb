<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Prueba
    Inherits System.Windows.Forms.Form

    'Form reemplaza a Dispose para limpiar la lista de componentes.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Requerido por el Diseñador de Windows Forms
    Private components As System.ComponentModel.IContainer

    'NOTA: el Diseñador de Windows Forms necesita el siguiente procedimiento
    'Se puede modificar usando el Diseñador de Windows Forms.  
    'No lo modifique con el editor de código.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.TxtNodeId = New System.Windows.Forms.TextBox()
        Me.BASE = New System.Windows.Forms.TextBox()
        Me.SuspendLayout()
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(149, 23)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(96, 24)
        Me.Button1.TabIndex = 0
        Me.Button1.Text = "Mostrar Forma"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'TxtNodeId
        '
        Me.TxtNodeId.Location = New System.Drawing.Point(12, 23)
        Me.TxtNodeId.Name = "TxtNodeId"
        Me.TxtNodeId.Size = New System.Drawing.Size(58, 20)
        Me.TxtNodeId.TabIndex = 1
        Me.TxtNodeId.Text = "QH"
        '
        'BASE
        '
        Me.BASE.Location = New System.Drawing.Point(76, 22)
        Me.BASE.Name = "BASE"
        Me.BASE.Size = New System.Drawing.Size(67, 20)
        Me.BASE.TabIndex = 2
        '
        'Prueba
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(280, 73)
        Me.Controls.Add(Me.BASE)
        Me.Controls.Add(Me.TxtNodeId)
        Me.Controls.Add(Me.Button1)
        Me.Name = "Prueba"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Form1"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents TxtNodeId As System.Windows.Forms.TextBox
    Friend WithEvents BASE As System.Windows.Forms.TextBox

End Class
