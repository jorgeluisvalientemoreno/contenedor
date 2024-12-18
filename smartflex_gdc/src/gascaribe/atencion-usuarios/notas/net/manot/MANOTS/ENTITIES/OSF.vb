Namespace ENTITIES

    Public Class OSF

        Private VarBandButtonColor As Color = Color.FromArgb(109, 148, 220)
        Public ReadOnly Property BandButtonColor() As Color
            Get
                Return VarBandButtonColor
            End Get
        End Property

        Private VarBodyColor As Color = Color.FromArgb(224, 240, 255)
        Public ReadOnly Property BodyColor() As Color
            Get
                Return VarBodyColor
            End Get
        End Property

        Private VarLineColor As Color = Color.FromArgb(255, 127, 0)
        Public ReadOnly Property LineColor() As Color
            Get
                Return VarLineColor
            End Get
        End Property

        Private VarTabColor As Color = Color.FromArgb(240, 241, 243)
        Public ReadOnly Property TabColor() As Color
            Get
                Return VarTabColor
            End Get
        End Property

        Private VarGridSelectionColor As Color = Color.FromArgb(124, 177, 228)
        Public ReadOnly Property GridSelectionColor() As Color
            Get
                Return VarGridSelectionColor
            End Get
        End Property

        Private VarGridHeaderColor As Color = Color.FromArgb(213, 232, 246)
        Public ReadOnly Property GridHeaderColor() As Color
            Get
                Return VarGridHeaderColor
            End Get
        End Property

        Private VarTextControlColor As Color = Color.White
        Public ReadOnly Property TextControlColor() As Color
            Get
                Return VarTextControlColor
            End Get
        End Property

        Private VarTextControlBlockedColor As Color = Color.FromArgb(241, 240, 238)
        Public ReadOnly Property TextControlBlockedColor() As Color
            Get
                Return VarTextControlBlockedColor
            End Get
        End Property

        Private varLabelTitleColor As Color = Color.FromArgb(80, 114, 179)
        Public ReadOnly Property LabelTitleColor() As Color
            Get
                Return varLabelTitleColor
            End Get
        End Property

        Private VarDefaultControlColor As Color = Color.FromArgb(246, 245, 244)
        Public ReadOnly Property DefaultControlColor() As Color
            Get
                Return VarDefaultControlColor
            End Get
        End Property
    End Class

End Namespace

