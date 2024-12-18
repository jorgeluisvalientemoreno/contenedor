Imports LUDYCOM.MANOT.ENTITIES
Imports LUDYCOM.MANOT.DAL

Namespace BL

    Public Class BLMANOTS

#Region "Declaraciones"
        Dim Open As New OSF
        Dim DAL As New DAL.DALMANOT
#End Region

        Public Function BL_GetSubcription(ByVal inusubscription As Integer) As DataRow
            Dim Mytable As New DataTable
            'Se valida que se pasen el parametro correcto para traer los datos del contrato.
            If Not IsDBNull(inusubscription) Then
                Mytable = DAL.GetSubscription(inusubscription)
            Else
                RaiseError("Debe proporcionar un numero de subscripción.", 0, MsgBoxStyle.Information)
            End If
            Return Mytable.Rows(0)
        End Function

#Region "GRIDS"

#Region "Funciones que devuelven cursores"

        ' Cargan los combos de MANOT
        Public Function BL_GetListado(ByVal Tipo As String) As BindingSource
            BL_GetListado = DAL.GetListado(Tipo)
            Return BL_GetListado
        End Function

#End Region

#Region "Funciones Escalares"

        Public Function BL_ObtenerDeudaCorrienteProducto(ByVal inuproduct As Int64) As Int64
            'Se valida que se pasen el parametro correcto para traer la deuda corriente.
            If Not IsDBNull(inuproduct) Then
                Contrato.DeudaCorriente = DAL.ObtenerDeudaCorrienteProducto(inuproduct)
                If Not IsNumeric(Contrato.DeudaCorriente) Then
                    RaiseError(String.Format("Error al devolver la deuda corriente del Producto {0}.", inuproduct), 0, MsgBoxStyle.Critical)
                End If
            Else
                RaiseError("Codigo de Producto No Válido", 0, MsgBoxStyle.Critical)
            End If
            Return Contrato.DeudaCorriente
        End Function

        Public Function BL_ObtenerDeudaCtaCobro(ByVal inuProducto As Int64, ByVal inuCuenCobr As Int64) As Int64
            Dim osbError As String = String.Empty
            Dim Deuda As Int64
            'Se valida que se pasen el parametro correcto para traer la deuda corriente.
            If Not IsDBNull(inuProducto) And Not IsDBNull(inuCuenCobr) Then
                Deuda = DAL.ObtenerDeudaCtaCobro(inuProducto, inuCuenCobr, osbError)
                If Not IsNumeric(Deuda) Then
                    RaiseError(String.Format("Error al devolver la deuda de la Cuenta de Cobro {0}." + vbCrLf _
                                             + "Detalle: " + osbError, inuCuenCobr), 0, MsgBoxStyle.Critical)
                End If
            Else
                RaiseError("Codigo de Producto o Cuenta de Cobro No Válido", 0, MsgBoxStyle.Critical)
            End If

            Return Deuda
        End Function

        Public Function BL_ObtenerDeudaConcepto(ByVal inuProducto As Int64, ByVal inuConcepto As Int64) As Int64
            Dim osbError As String = String.Empty
            Dim Deuda As Int64
            'Se valida que se pasen el parametro correcto para traer la deuda corriente.
            If Not IsDBNull(inuProducto) And Not IsDBNull(inuConcepto) Then
                Deuda = DAL.ObtenerDeudaConcepto(inuProducto, inuConcepto, osbError)
                If Not IsNumeric(Deuda) Then
                    RaiseError(String.Format("Error al devolver la deuda del Concepto {0}." + vbCrLf _
                                             + "Detalle: " + osbError, inuConcepto), 0, MsgBoxStyle.Critical)
                End If
            Else
                RaiseError("Codigo de Producto o Concepto No Válido", 0, MsgBoxStyle.Critical)
            End If

            Return Deuda
        End Function

        Public Function BL_ObtenerDeudaConceptoCtaCobro(ByVal inuCuenCobr As Int64, ByVal inuConcepto As Int64) As Int64
            Dim osbError As String = String.Empty
            Dim Deuda As Int64 = 0
            'Se valida que se pasen el parametro correcto para traer la deuda corriente.
            If Not IsDBNull(inuCuenCobr) And Not IsDBNull(inuConcepto) Then
                Deuda = DAL.ObtenerDeudaConceptoCtaCobro(inuCuenCobr, inuConcepto, osbError)
                If Not IsNumeric(Deuda) Then
                    RaiseError(String.Format("Error al devolver la deuda del concepto {0} en la Cuenta de Cobro {1}." + vbCrLf _
                                             + "Detalle: " + osbError, inuConcepto, inuCuenCobr), 0, MsgBoxStyle.Critical)
                End If
            Else
                RaiseError("Codigo de Producto o Cuenta de Cobro No Válido", 0, MsgBoxStyle.Critical)
            End If

            Return Deuda
        End Function

#End Region

#Region "Proyeccion"

        Public Function Proyeccion(ByRef Grid1 As DataGridView, ByRef GridDeuda As DataGridView, ByRef GridProyeccion As DataGridView) As Boolean

            Dim Resultado As Boolean = True 'Se inicializa True, si alguna operacion finaliza mal se devuelve false en la funcion.
            Dim MyCol As New DataGridViewTextBoxColumn

            Contrato.DataTableNotas = New DataTable
            'Se agregan las columnas
            For i As Integer = 0 To Grid1.Columns.Count - 1
                Contrato.DataTableNotas.Columns.Add(Grid1.Columns(i).Name)
            Next
            'Recorro cada fila del Grid
            For Each Row As DataGridViewRow In Grid1.Rows
                Dim dtRow As DataRow = Contrato.DataTableNotas.NewRow
                Dim CeldasVacias As Integer = 0
                'If CheckContenidoMinimoFila(Row) = True Then
                'Recorro cada celda de la fila
                For Each Cell As DataGridViewCell In Grid1.Rows(Row.Index).Cells
                    'Valida que se rellenen correctamente los datos en el DataTable
                    If Cell.Value Is DBNull.Value Or Cell.Value Is Nothing Or String.IsNullOrEmpty(Cell.Value) Then
                        'MsgBox(Cell.ValueType.ToString)
                        dtRow(Cell.ColumnIndex) = String.Empty
                        CeldasVacias += 1
                    Else
                        dtRow(Cell.ColumnIndex) = Cell.Value
                    End If
                Next
                'Valida que el total de las celdas de la fila no estén vacias para insertar la fila.
                If Not Grid1.Rows(Row.Index).Cells.Count = CeldasVacias Then
                    Contrato.DataTableNotas.LoadDataRow(dtRow.ItemArray, True)
                End If
                'End If
            Next
            If Contrato.DataTableNotas.Rows.Count >= 1 Then
                'Se rellena el DataTable Principal.
                If Me.BL_InsertarNotaEncabezado(Contrato.DataTableNotas) = True Then
                    'Se hacen los calculos que generan las proyecciones con los datos previamente insertados.

                    If Me.BL_CalcularProyectado() = True Then
                        'Se muestra la proyeccion.
                        GridDeuda.DataSource = Me.BL_CargarGridDeudaActual()
                        GridProyeccion.DataSource = Me.BL_CargarGridProyeccion()
                    Else
                        Resultado = False
                    End If


                Else
                    Resultado = False
                End If
            End If
            Return Resultado
        End Function

        Private Function BL_InsertarNotaEncabezado(ByVal MyDT As DataTable) As Boolean
            Dim Resultado As Boolean = True
            Dim osbError As String = String.Empty
            'Se valida que se pasen el parametro correcto para traer la deuda corriente.
            If Not MyDT Is Nothing And MyDT.Rows.Count > 0 Then
                'Borro las tablas temporales con las notas almacenadas previamente para hacer una proyeccion en limpio.
                osbError = DAL.BorrarTablasTemporales()
                If String.IsNullOrEmpty(osbError) Or osbError = "null" Then 'Si Tablas borradas correctamente
                    For Each row As DataRow In MyDT.Rows
                        '***** Llamo al procedimiento de insercion de las notas en la BD
                        'Importante: Orden de los parametros
                        osbError = DAL.InsertarNotaEncabezado(inuProducto:=row(0), isbNovedad:=row(1), inuCuenta_cobro:=row(2), inuConcepto:=row(3), _
                                                                inuValor:=row(4), inuCausa_cargo:=row(5), inuCuotas:=row(6), inuPlan_diferido:=row(7))
                        If Not osbError = "" And Not osbError = "null" Then 'Cuando genera error la insercion.
                            Resultado = False
                            RaiseError("BL_InsertarNotaEncabezado" + vbCrLf + "Hubo un error al insertar las notas de encabezado para la proyección." + vbCrLf + osbError, 0, MsgBoxStyle.Critical)
                        End If
                    Next
                Else
                    Resultado = False
                    RaiseError("BL_BorrarNotaEncabezado" + vbCrLf + "Hubo un error al borrar las notas de encabezado para la proyección." + vbCrLf + osbError, 0, MsgBoxStyle.Critical)
                End If
            Else
                Resultado = False
                RaiseError("Parametros incorrectos para insertar las notas de encabezado o no hay datos que ingresar.", 0, MsgBoxStyle.Critical)
            End If

            Return Resultado
        End Function

        Public Function BL_CalcularProyectado() As Boolean
            Dim Resultado As Boolean = True
            Dim osbError As String = String.Empty
            Try
                If Not IsDBNull(Contrato.ProductoSeleccionado) Then
                    'Importante: Orden de los parametros
                    osbError = DAL.CalcularProyectado(Contrato.ProductoSeleccionado, osbError) 'Call DAL
                    If Not osbError = "" And Not osbError = "null" Then 'Con Error

                        Resultado = False
                        'RaiseError("Error al calcular la proyección." + vbCrLf + _
                        '           "Detalle: " + osbError + vbCrLf, 0, MsgBoxStyle.Critical)
                        MessageBox.Show(osbError, "MANNOT", MessageBoxButtons.OK, MessageBoxIcon.Error)
                        Exit Function
                    End If
                End If
            Catch ex As Exception
                'RaiseError("Error al calcular la proyeccion de la deuda.", 0, MsgBoxStyle.Critical)
                MessageBox.Show("Error: " + ex.Message, "MANNOT", MessageBoxButtons.OK, MessageBoxIcon.Error)
                Resultado = False
            End Try
            Return Resultado
        End Function

        Public Function BL_ValidarMonto() As String
            Dim osbError As String = String.Empty
            Try
                If Not IsDBNull(Contrato.ProductoSeleccionado) Then
                    'Importante: Orden de los parametros
                    osbError = DAL.ValidarMonto(Contrato.ProductoSeleccionado, osbError) 'Call DAL
                End If
            Catch ex As Exception
                RaiseError("Error al validar monto.", 0, MsgBoxStyle.Critical)
            End Try
            Return osbError
        End Function

        Private Function BL_CargarGridDeudaActual() As BindingSource
            BL_CargarGridDeudaActual = DAL.GetListado("GridDeudaActual")

            Return BL_CargarGridDeudaActual
        End Function

        ''DANVAL MODIFICACION 10.12.18
        Public Function BL_CargarGridDeudaActual_1(ByVal inuProducto As Integer) As String
            BL_CargarGridDeudaActual_1 = DAL.ObtenerDatatableGridDeudaActual_1(inuProducto)

            Return BL_CargarGridDeudaActual_1
        End Function

        Private Function BL_CargarGridProyeccion() As BindingSource
            BL_CargarGridProyeccion = DAL.GetListado("GridProyeccion")

            Return BL_CargarGridProyeccion
        End Function

#End Region

#Region "Grabacion"

        Public Function BL_GrabarNotas(ByVal isbObservacion As String) As Boolean
            Dim Resultado As Boolean = True
            Dim monto As String = String.Empty

            Dim osbError As String = String.Empty : Dim onuSolicitud As String = String.Empty
            Try
                If Not IsDBNull(Contrato.ProductoSeleccionado) Then
                    'Importante: Orden de los parametros
                    monto = BL_ValidarMonto()

                    If (monto = "0") Then
                        Dim response As DialogResult = MessageBox.Show("El monto de la nota excede el perfil financiero. Se generará una orden que deberá ser aprobada.", "MANOT", MessageBoxButtons.YesNo)

                        If response = MsgBoxResult.Yes Then
                            osbError = DAL.GrabarNotas(Contrato.ProductoSeleccionado, isbObservacion, onuSolicitud, osbError)
                            If Not osbError = "" And Not osbError = "null" Then
                                Resultado = False
                                RaiseError(osbError + vbCrLf, 0, MsgBoxStyle.Critical)
                            Else
                                Resultado = True
                                If String.IsNullOrEmpty(onuSolicitud) Then
                                    RaiseError("Notas grabadas exitosamente!", 0, MsgBoxStyle.Information)
                                    ' *** En caso que se requiera devolver la solicitud generada ***
                                Else
                                    RaiseError("Se generó la solicitud Nro. " + onuSolicitud, 0, MsgBoxStyle.Information)
                                    'Borro las tablas temporales con las notas almacenadas previamente para hacer una proyeccion en limpio.
                                End If
                                osbError = DAL.BorrarTablasTemporales()
                                If Not String.IsNullOrEmpty(osbError) And Not osbError = "null" Then
                                    RaiseError(osbError, 0, MsgBoxStyle.Critical)
                                End If
                            End If
                        Else
                            Exit Function
                        End If
                    Else
                        osbError = DAL.GrabarNotas(Contrato.ProductoSeleccionado, isbObservacion, onuSolicitud, osbError)
                        If Not osbError = "" And Not osbError = "null" Then
                            Resultado = False
                            RaiseError(osbError + vbCrLf, 0, MsgBoxStyle.Critical)
                        Else
                            Resultado = True
                            If String.IsNullOrEmpty(onuSolicitud) Then
                                RaiseError("Notas grabadas exitosamente!", 0, MsgBoxStyle.Information)
                                ' *** En caso que se requiera devolver la solicitud generada ***
                            Else
                                RaiseError("Se generó la solicitud Nro. " + onuSolicitud, 0, MsgBoxStyle.Information)
                                'Borro las tablas temporales con las notas almacenadas previamente para hacer una proyeccion en limpio.
                            End If
                            osbError = DAL.BorrarTablasTemporales()
                            If Not String.IsNullOrEmpty(osbError) And Not osbError = "null" Then
                                RaiseError(osbError, 0, MsgBoxStyle.Critical)
                            End If
                        End If
                    End If

                End If
            Catch ex As Exception
                RaiseError("Parametros incorrectos para grabar las notas o no hay datos que ingresar.", 0, MsgBoxStyle.Critical)
            End Try
            Return Resultado
        End Function

#End Region

#Region "Filas"

        Public Sub ResetRow(ByRef Grid As DataGridView, ByVal Row As DataGridViewRow) 'No utilizado.
            Dim RowIndex As Integer = Row.Index
            Dim ComboValorPrevio As String = Row.Cells(0).Value
            Dim MyRow As New DataGridViewRow
            MyRow = Row.Clone()
            Grid.Rows.Remove(Row)
            Grid.Rows.Insert(RowIndex, MyRow)
            Grid.Rows(RowIndex).Cells(0).Value = ComboValorPrevio
            Grid.Rows(RowIndex).Cells(0).Selected = True
        End Sub

        Public Function CheckContenidoMinimoFila(ByVal Row As DataGridViewRow, Optional ByRef ChkColValorEsNumerico As Boolean = False) As Boolean
            'Valida que el usuario haya completado todos los datos de la Novedad seleccionada.
            Dim Resultado As Boolean = False
            With Row
                If IsNumeric(.Cells("ColValor").Value) Then
                    ChkColValorEsNumerico = True
                End If
                If Not .Cells("ColComboNovedad").Value = Nothing And Not String.IsNullOrEmpty(.Cells("ColValor").Value) And _
                           Not .Cells("ColComboCausaCargo").Value = Nothing Then
                    Select Case NotaActual.Novedad
                        Case "AD"
                            Resultado = True
                        Case "AC"
                            If Not .Cells("ColComboConcepto").Value = Nothing Then
                                Resultado = True
                            End If
                        Case "ACC", "DCC"
                            If Not .Cells("ColComboCtaCobro").Value = Nothing Then
                                Resultado = True
                            End If
                        Case "ACCC", "DCCC"
                            If Not .Cells("ColComboCtaCobro").Value = Nothing And Not .Cells("ColComboConcepto").Value = Nothing Then
                                If IsNumeric(.Cells("ColValor").Value) Then
                                    ChkColValorEsNumerico = True
                                    Resultado = True
                                End If
                            End If
                        Case "DC"
                            'If Not .Cells("ColComboConcepto").Value = Nothing And Not .Cells("ColComboPlanDife").Value = Nothing And _
                            '    Not String.IsNullOrEmpty(.Cells("ColCuotas").Value) Then
                            Dim msg As String
                            Dim title As String
                            Dim style As MsgBoxStyle
                            Dim response As MsgBoxResult
                            msg = "Señor Usuario, No digitó valores en cuotas y plan de financiación. Si decide continuar, el valor se tomará como un ajuste a presente mes."   ' Define message.
                            style = MsgBoxStyle.DefaultButton2 Or _
                               MsgBoxStyle.Information Or MsgBoxStyle.YesNo
                            title = "MANOTS"

                            If Not .Cells("ColComboConcepto").Value = Nothing Then
                                If IsNumeric(.Cells("ColValor").Value) Then
                                    If Not String.IsNullOrEmpty(.Cells("ColCuotas").Value) And Not .Cells("ColComboPlanDife").Value = Nothing Then
                                        ChkColValorEsNumerico = True
                                        Resultado = True
                                    ElseIf String.IsNullOrEmpty(.Cells("ColCuotas").Value) And .Cells("ColComboPlanDife").Value = Nothing Then
                                        response = MsgBox(msg, style, title)
                                        If response = MsgBoxResult.Yes Then
                                            ChkColValorEsNumerico = True
                                            Resultado = True
                                        Else
                                            ChkColValorEsNumerico = False
                                            Resultado = False
                                        End If
                                    End If
                                    'ChkColValorEsNumerico = True
                                    'Resultado = True
                                End If
                            End If
                    End Select
                Else
                    Resultado = False
                End If
            End With
            Return Resultado
        End Function
#End Region

#End Region

        'MODIFICACION DANVAL - APOYO RONCOL 10.12.18
        Public Sub ServicioSaldos(ByVal inuproductid As Int32, ByVal onucurrentaccounttotal As String, ByVal onudeferredaccounttotal As String, ByVal onucreditbalance As String, ByVal onuclaimvalue As String, ByVal onudefclaimvalue As String)
            DAL.ServicioSaldos(inuproductid, onucurrentaccounttotal, onudeferredaccounttotal, onucreditbalance, onuclaimvalue, onudefclaimvalue)
        End Sub

        Public Sub BorradoTemporales()
            Dim osbError As String = DAL.BorrarTablasTemporales()
            If String.IsNullOrEmpty(osbError) Or osbError = "null" Then 'Si Tablas borradas correctamente
                
            Else
                RaiseError("BL BorradoTemporales" + vbCrLf + "Hubo un error al borrar las tablas temporales." + vbCrLf + osbError, 0, MsgBoxStyle.Critical)
            End If
        End Sub

    End Class

End Namespace