Imports System.Data

Imports Microsoft.VisualStudio.TestTools.UnitTesting

Imports LUDYCOM.LECTESP.DAL



'''<summary>
'''Se trata de una clase de prueba para DALTBLEXCELTest y se pretende que
'''contenga todas las pruebas unitarias DALTBLEXCELTest.
'''</summary>
<TestClass()> _
Public Class DALTBLEXCELTest


    Private testContextInstance As TestContext

    '''<summary>
    '''Obtiene o establece el contexto de la prueba que proporciona
    '''la información y funcionalidad para la ejecución de pruebas actual.
    '''</summary>
    Public Property TestContext() As TestContext
        Get
            Return testContextInstance
        End Get
        Set(ByVal value As TestContext)
            testContextInstance = Value
        End Set
    End Property

#Region "Atributos de prueba adicionales"
    '
    'Puede utilizar los siguientes atributos adicionales mientras escribe sus pruebas:
    '
    'Use ClassInitialize para ejecutar código antes de ejecutar la primera prueba en la clase 
    '<ClassInitialize()>  _
    'Public Shared Sub MyClassInitialize(ByVal testContext As TestContext)
    'End Sub
    '
    'Use ClassCleanup para ejecutar código después de haber ejecutado todas las pruebas en una clase
    '<ClassCleanup()>  _
    'Public Shared Sub MyClassCleanup()
    'End Sub
    '
    'Use TestInitialize para ejecutar código antes de ejecutar cada prueba
    '<TestInitialize()>  _
    'Public Sub MyTestInitialize()
    'End Sub
    '
    'Use TestCleanup para ejecutar código después de que se hayan ejecutado todas las pruebas
    '<TestCleanup()>  _
    'Public Sub MyTestCleanup()
    'End Sub
    '
#End Region


    '''<summary>
    '''Una prueba de ObtenerDatosValidacion
    '''</summary>
    <TestMethod()> _
    Public Sub ObtenerDatosValidacionTest()
        Dim target As DALTBLEXCEL = New DALTBLEXCEL() ' TODO: Inicializar en un valor adecuado
        Dim orfData As DataSet = Nothing ' TODO: Inicializar en un valor adecuado
        Dim orfDataExpected As DataSet = Nothing ' TODO: Inicializar en un valor adecuado
        Dim onuerrorcode As Long = 0 ' TODO: Inicializar en un valor adecuado
        Dim onuerrorcodeExpected As Long = 0 ' TODO: Inicializar en un valor adecuado
        Dim osberrormessage As String = String.Empty ' TODO: Inicializar en un valor adecuado
        Dim osberrormessageExpected As String = String.Empty ' TODO: Inicializar en un valor adecuado
        target.ObtenerDatosValidacion(orfData, onuerrorcode, osberrormessage)
        Assert.AreEqual(orfDataExpected, orfData)
        Assert.AreEqual(onuerrorcodeExpected, onuerrorcode)
        Assert.AreEqual(osberrormessageExpected, osberrormessage)
        Assert.Inconclusive("Un método que no devuelve ningún valor no se puede comprobar.")
    End Sub
End Class
