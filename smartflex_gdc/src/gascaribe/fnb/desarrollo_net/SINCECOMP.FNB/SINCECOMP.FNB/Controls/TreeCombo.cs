using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using System.ComponentModel.Design.Serialization;
using System.Data.Common;
using System.Resources;
using System.Reflection;

using Infragistics.Win.UltraWinGrid;
using Infragistics.Win;

using OpenSystems.Windows.Resources.OpenGrid;

using OpenSystems.Windows.Controls;
using OpenSystems.Windows.ApplicationConfiguration;
using OpenSystems.Common.Data;
using OpenSystems.Common.Util;

using SINCECOMP.FNB.Controls.OpenTreeComboLocal;

namespace SINCECOMP.FNB.Controls
{
    [ToolboxBitmap(typeof(Infragistics.Win.UltraWinTree.UltraTree))]
    [Localizable(true)]
    [Bindable(true)]
    [DesignerSerializer(typeof(OpenSystems.Windows.ApplicationConfiguration.OrderedCodeDomSerializer),
         typeof(CodeDomSerializer))]
    public partial class TreeCombo : UserControl, IOpenEnterQueryLocal
    {

        private Infragistics.Win.Appearance appearanceNormal = new Infragistics.Win.Appearance("Normal", 1);
        private Infragistics.Win.Appearance appearanceEnter = new Infragistics.Win.Appearance("MouseEnter", 2);
        private Infragistics.Win.Appearance appearanceFocus = new Infragistics.Win.Appearance("Focused", 3);
        
        private FrmTreeLocal frmTree = new FrmTreeLocal();        
        private String _ImageField = String.Empty;               
       private String sqlSelect = String.Empty;
        private char _Required = 'N';
        private Boolean _IsUsedInGrid = false;

        private System.Windows.Forms.Label caption = new System.Windows.Forms.Label();
        private OpenSystems.Windows.Controls.CaptionLocations captionLocations = OpenSystems.Windows.Controls.CaptionLocations.Left;
        private System.Drawing.Font defaultCaptionfont = new System.Drawing.Font
            ("Verdana", 8F,
            System.Drawing.FontStyle.Regular,
            System.Drawing.GraphicsUnit.Point,
            ((System.Byte)(0))
            );

        #region Atributos Publicos
        public event ChangedEventHandler ValueChanged;
        #endregion Atributos Publicos

        public TreeCombo()
        {
            InitializeComponent();

            this.Controls.Remove(this.pbxRequired);
            this.caption.Visible = false;
            this.caption.AutoSize = true;
            this.caption.BackColor = System.Drawing.Color.Transparent;
            this.caption.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.caption.Font = new Font("Verdana", 8F);
            this.Caption = String.Empty;
            this.InitializeFunction();

        }


        public void ToggleDropdown()
        {
            this.ultraComboWithTree.BringToFront();
            Application.DoEvents();
            this.ultraComboWithTree.ToggleDropdown();
        }


        private void SetRequired()
        {
            this.pbxRequired.Parent = null;
            if (this._Required == 'N')
            {
                return;
            }
            if (this.Parent == null)
            {
                return;
            }
            this.pbxRequired.Location = new Point(
                    this.Location.X - (this.pbxRequired.ClientSize.Width + 1),
                    this.Location.Y + (this.Height - this.pbxRequired.ClientSize.Height)
                );
            this.pbxRequired.Parent = this.Parent;
        }

        private void SetLocationCaption()
        {
            switch (this.captionLocations)
            {

                case OpenSystems.Windows.Controls.CaptionLocations.Left:

                    int X;
                    X = this.Location.X - this.caption.Width;
                    this.caption.Location = new Point
                        (
                        X - 6,
                        this.Location.Y + (this.Size.Height - this.caption.Size.Height) / 2
                        );
                    break;

                case OpenSystems.Windows.Controls.CaptionLocations.Top:
                    this.caption.Location = new Point
                        (
                        (this.Location.X),
                        this.Location.Y - this.caption.Size.Height
                        );
                    break;

            }
        }


        private void LoadTreeViewData()
        {

            if (base.DesignMode)
                return;
            if (this.DesignMode)
                return;
            // Si alguno de estos atributos estan vacios
            // nada que hacer.
            
            if (this.TreeViewData != null)
            {
                return;
            }
            if (!String.IsNullOrEmpty(sqlSelect))
            {
               OpenSystems.Windows.Resources.TreeHierarchicalData.SchemaDataOnlyMasterDetail auxTreeViewData = new OpenSystems.Windows.Resources.TreeHierarchicalData.SchemaDataOnlyMasterDetail();
               if (!this.DesignMode)
               {
                  DbCommand dbCommand;
                  dbCommand = OpenDataBase.db.GetSqlStringCommand(sqlSelect);
                  OpenDataBase.db.LoadDataSet(dbCommand, auxTreeViewData, "treeview_data");
                  this.TreeViewData = auxTreeViewData;
               }
            }
        }


        protected virtual void OnValueChanged(EventArgs e)
        {
            if (ValueChanged != null)
                ValueChanged(this, e);
        }

        public void InitializeFunction()
        {

            this.appearanceNormal.BackColor = Color.White;
            this.appearanceNormal.BackColor2 = Color.White;

            this.appearanceEnter.BackColor = Color.White;
            this.appearanceEnter.BackColor2 = Color.FromKnownColor(KnownColor.Info);
            this.appearanceEnter.BackGradientAlignment = GradientAlignment.Element;
            this.appearanceEnter.BackGradientStyle = GradientStyle.Vertical;

            this.appearanceFocus.BackColor = Color.White;
            this.appearanceFocus.BackColor2 = Color.FromArgb(225, 243, 253);
            this.appearanceFocus.BackGradientAlignment = GradientAlignment.Element;
            this.appearanceFocus.BackGradientStyle = GradientStyle.Vertical;
            this.ultraComboWithTree.MaxDropDownItems = 15;
            this.SetLocationCaption();
        }

        [Localizable(true)]
        [Category("OpenSystems")]
        [Description("Obtiene el valor de la caja de texto, adicionando la respectiva opción de consulta seleccionada")]
        [Browsable(false)]
        [EditorBrowsable(EditorBrowsableState.Always)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public string QueryText
        {
            get
            {
                return this.GetQueryValue();
            }
        }

        private bool _IsEnterQueryModeOn = false;

        [Localizable(true)]
        [Category("OpenSystems")]
        [Description("Propiedad que indica si el modo Enter Query esta activo (true) en el control")]
        [Browsable(false)]
        [EditorBrowsable(EditorBrowsableState.Always)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public bool IsEnterQueryModeOn
        {
            get { return this._IsEnterQueryModeOn; }
        }

        /// <summary>
        /// Obtiene o establece el Caption de la caja de texto.
        /// </summary>
        [Bindable(true)]
        [Localizable(true)]
        [Category("OpenSystems")]
        [DefaultValue("")]
        [Description("Obtiene o establece el Caption de la caja de texto.")]
        [DesignSerializationOrder(0)]
        public String Caption
        {
            set
            {
                if (value == null)
                {
                    this.caption.Text = null;
                    this.caption.Visible = false;
                }
                else
                {
                    this.caption.Text = value;
                    this.SetLocationCaption();
                    this.caption.Visible = true;
                }
            }
            get
            {
                if (this.caption == null)
                    return null;
                else
                    return this.caption.Text;
            }
        }
        /// <summary>
        /// Obtiene o establece la imagen que indica si la información del campo .
        /// es obligatoria
        /// </summary>
        [Bindable(true)]
        [Localizable(true)]
        [Category("OpenSystems")]
        [DefaultValue('N')]
        [Description("Obtiene o establece la imagen que indica si la información del campo es obligatoria.")]
        [DesignSerializationOrder(11)]
        public char Required
        {
            get
            {
                return this._Required;
            }

            set
            {
                this._Required = value;
                this.SetRequired();

            }
        }

        /// <summary>
        /// Obtiene o establece el flag que indica si el control esta siendo usado en una grilla.
        /// </summary>
        [Bindable(true)]
        [Localizable(true)]
        [Category("OpenSystems")]
        [DefaultValue(false)]
        [Description("Obtiene o establece el flag que indica si el control esta siendo usado en una grilla.")]
        [DesignSerializationOrder(12)]
        public Boolean IsUsedInGrid
        {
            get
            {
                return this._IsUsedInGrid;
            }

            set
            {
                this._IsUsedInGrid = value;

            }
        }


        /// <summary>
        /// Obtiene o Establece la Fuente del caption.
        /// </summary>
        [Category("OpenSystems")]
        [DefaultValue(typeof(Font), "Verdana, 8pt")]
        [Description("Obtiene o establece la fuente del caption")]
        [DesignSerializationOrder(1)]
        public System.Drawing.Font CaptionFont
        {
            get { return this.caption.Font; }
            set
            {
                if (this.caption != null)
                {
                    this.defaultCaptionfont = value;
                    this.caption.Font = defaultCaptionfont;
                }
                this.SetLocationCaption();
            }
        }

        /// <summary>
        /// Obtiene o establece la ubicacion del caption
        /// con respecto a la caja de texto
        /// </summary>
        [Description("Obtiene o establece la ubicacion " +
             "del caption con respecto a la caja de texto")]
        [DefaultValue(CaptionLocations.Left)]
        [Category("OpenSystems")]
        [DesignSerializationOrder(2)]
        public OpenSystems.Windows.Controls.CaptionLocations CaptionLocation
        {
            get { return this.captionLocations; }
            set
            {
                if (this.captionLocations != value)
                {
                    this.captionLocations = value;
                    this.SetLocationCaption();
                }
            }
        }

        /// <summary>
        /// Origen de datos para el Arbol y el Combo 
        /// <see cref="OpenSystems.Windows.Resources.TreeHierarchicalData.SchemaData"/>
        /// </summary>
        [DefaultValue(null)]
        [Category("OpenSystems")]
        [DesignSerializationOrder(3)]
        public OpenSystems.Windows.Resources.TreeHierarchicalData.SchemaDataOnlyMasterDetail TreeViewData
        {
            get { return this.frmTree.TreeData; }
            set
            {
                this.frmTree.TreeData = value;
                if (this.DesignMode)
                    return;
                if (this.frmTree.TreeData != null)
                {

                    this.frmTree.TreeData.treeview_data.Columns["node_text"].Caption = "Descripción";
                    this.frmTree.TreeData.treeview_data.Columns["id"].Caption = "Código";
                    this.ultraComboWithTree.DataSource = new DataView(this.frmTree.TreeData.treeview_data, @"assign_level = 'Y'", "id", DataViewRowState.OriginalRows);
                    this.ultraComboWithTree.ValueMember = this.frmTree.TreeData.treeview_data.Columns[0].ColumnName;
                    this.ultraComboWithTree.DisplayMember = this.frmTree.TreeData.treeview_data.Columns[1].ColumnName;
                    if (!base.DesignMode)
                    {
                        this.ultraComboWithTree.DisplayLayout.Bands[0].Columns["id"].CellAppearance.TextHAlign = Infragistics.Win.HAlign.Right;
                        this.ultraComboWithTree.DisplayLayout.Bands[0].SortedColumns.Add("id", false);
                        this.ultraComboWithTree.DisplayLayout.Bands[0].Columns["parent_id"].Hidden = true;
                        this.ultraComboWithTree.DisplayLayout.Bands[0].Columns["assign_level"].Hidden = true;
                    }
                }
                else
                {
                    this.ultraComboWithTree.DataSource = null;
                    this.ultraComboWithTree.DisplayMember = String.Empty;
                    this.ultraComboWithTree.ValueMember = String.Empty;
                }
            }
        }


        

        [DefaultValue("")]
        [Category("OpenSystems")]
        [DesignSerializationOrder(6)]
        public String ImageField
        {
            get { return this._ImageField; }
            set
            {
                this._ImageField = value;
            }
        }

        
        [
         DefaultValue(null),
         Category("OpenSystems"),
         DesignSerializationOrder(9),
         Bindable(BindableSupport.Yes)
        ]
        public object Value
        {
            get
            {
                return this.ultraComboWithTree.Value;
            }
            set
            {
                Object objValue = value;
                objValue = OpenSystems.Common.Util.OpenData.ConvertDBDatatoString(objValue);
                if (this.ultraComboWithTree.Value != objValue)
                {
                    this.ultraComboWithTree.Value = objValue;
                }
            }
        }        

       [
        DefaultValue(null),
        Category("OpenSystems"),
        DesignSerializationOrder(11),
        Bindable(BindableSupport.Yes)
        ]
       public String SqlSelect
       {
          get { return this.sqlSelect; }
          set
          {
             this.sqlSelect = value;
          }
       }



        [DefaultValue(false)]
        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public bool IsDroppedDown
        {
            get { return this.ultraComboWithTree.IsDroppedDown; }
        }


        [DefaultValue(false)]
        public bool ReadOnly
        {
            get
            {
                return this.ultraComboWithTree.ReadOnly;
            }
            set
            {
                if (this.ultraComboWithTree.ReadOnly != value)
                {
                    this.ultraComboWithTree.ReadOnly = value;
                    this.Refresh();
                }
            }
        }

        private void OpenTreeCombo_ParentChanged(object sender, System.EventArgs e)
        {
            this.caption.Parent = this.Parent;
        }

        private void OpenTreeCombo_LocationChanged(object sender, System.EventArgs e)
        {
            this.SetRequired();
            this.SetLocationCaption();

        }
        private void OpenTreeCombo_SizeChanged(object sender, System.EventArgs e)
        {
            this.Size = new Size(this.Width, this.ultraComboWithTree.Height);
        }

        private void OpenTreeCombo_FontChanged(object sender, System.EventArgs e)
        {
            this.SetLocationCaption();
        }

        private void OpenTreeCombo_Enter(object sender, System.EventArgs e)
        {

            ChangedEventHandler eventh = this.ValueChanged;

            if (this.ValueChanged != null)
                this.ValueChanged = null; 

            this.ultraComboWithTree.Focus();

            if (eventh != null)
                this.ValueChanged = eventh;


        }

        public void ShowTree()
        {
            if (!this.DesignMode)
            {

                frmTree.Text = this.caption.Text + " ";
                if (this.ultraComboWithTree.Value != null)
                    frmTree.Selected = Convert.ToInt32(this.ultraComboWithTree.Value);
                else
                    frmTree.Selected = -1;

                frmTree.ShowDialog(Form.ActiveForm);

                if (frmTree.Selected == -1)
                {
                    this.ultraComboWithTree.Value = null;
                }
                else if (this.ultraComboWithTree.SelectedRow == null)
                {
                    this.ultraComboWithTree.Value = Convert.ToInt32(frmTree.Selected);
                }
                else if (this.ultraComboWithTree.Value == null)
                {
                    this.ultraComboWithTree.Value = Convert.ToInt32(frmTree.Selected);
                }
                else if (frmTree.Selected != Convert.ToInt32(this.ultraComboWithTree.Value))
                {
                    this.ultraComboWithTree.Value = Convert.ToInt32(frmTree.Selected);
                }

                if (this.ultraComboWithTree.Tag != null)
                {
                    if (this.ultraComboWithTree.Tag is UltraGridColumn)
                    {
                        UltraGridColumn gridCol = this.ultraComboWithTree.Tag as UltraGridColumn;
                        if (gridCol.Band.Layout.Grid.ActiveRow != null)
                        {
                            if (gridCol.Band.Layout.Grid.ActiveRow.Cells.Exists(gridCol.Key))
                                gridCol.Band.Layout.Grid.ActiveRow.Cells[gridCol.Key].Value = this.ultraComboWithTree.Value;
                        }
                    }
                }
            }
        }

        private void ultraComboWithTree_EditorButtonClick(object sender, Infragistics.Win.UltraWinEditors.EditorButtonEventArgs e)
        {
            this.ShowTree();
        }

        private void ultraComboWithTree_ItemNotInList(object sender, Infragistics.Win.UltraWinEditors.ValidationErrorEventArgs e)
        {
            //Si no encuentra el elemento en la lista desplegar
            e.RetainFocus = false;
            if (e.InvalidText != String.Empty &&
                e.InvalidText != null)
            {
                e.RetainFocus = true;
                this.ToggleDropdown();
            }
        }

        private void OpenTreeCombo_EnabledChanged(object sender, System.EventArgs e)
        {
            this.ultraComboWithTree.Enabled = this.Enabled;
        }

        private void ultraComboWithTree_ValueChanged(object sender, System.EventArgs e)
        {
            OnValueChanged(e);
        }

        private void CreateQueryButton()
        {

            if (this.ultraComboWithTree.ButtonsLeft.Exists("ENTER_QUERY_BOTTON"))
                return;

            Infragistics.Win.UltraWinEditors.DropDownEditorButton dropDrownButton
                = new Infragistics.Win.UltraWinEditors.DropDownEditorButton("ENTER_QUERY_BOTTON");

            Infragistics.Win.UltraWinGrid.UltraDropDown dropDownList = new Infragistics.Win.UltraWinGrid.UltraDropDown();
            dropDrownButton.Appearance.Image = global::SINCECOMP.FNB.Properties.SinceComp.imgQuery;
            dropDrownButton.ButtonStyle = Infragistics.Win.UIElementButtonStyle.Office2003ToolbarButton;
            dropDownList.RowSelected += new Infragistics.Win.UltraWinGrid.RowSelectedEventHandler(DropDownQueryList_RowSelected);

            //Dataset que contiene la lista de valores a mostrar
            DataSet dsOptions = new DataSet();
            dsOptions.Tables.Add("Options");
            dsOptions.Tables[0].Columns.Add("Option");
            dsOptions.Tables[0].Columns.Add("Value");
            dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.EQUAL, "=" });
            dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.GREATERTHAN, ">" });
            dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.LOWERTHAN, "<" });
            dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.GREATEREQUALTHAN, ">=" });
            dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.LOWEREQUALTHAN, "<=" });
            dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.NOEQUAL, "<>" });
            dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.LIKE, "*" });
            dropDownList.DataSource = dsOptions;
            dropDownList.DisplayMember = dsOptions.Tables[0].Columns[0].ColumnName;
            dropDownList.ValueMember = dsOptions.Tables[0].Columns[0].ColumnName;
            dropDownList.DisplayLayout.Scrollbars = Infragistics.Win.UltraWinGrid.Scrollbars.Vertical;
            dropDownList.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            dropDownList.DisplayLayout.Bands[0].ColHeadersVisible = false;
            dropDownList.DisplayLayout.Bands[0].Columns[1].Hidden = true;
            dropDrownButton.Control = dropDownList;
            dropDownList.Width = this.Width;

            if (this.ultraComboWithTree.ButtonsLeft.Count == 0)
                this.ultraComboWithTree.ButtonsLeft.Add(dropDrownButton);
            else
                this.ultraComboWithTree.ButtonsLeft.Insert(0, dropDrownButton);

            this.ultraComboWithTree.ButtonsLeft[0].Visible = false;
        }

        private void DropDownQueryList_RowSelected(object sender, Infragistics.Win.UltraWinGrid.RowSelectedEventArgs e)
        {
            Infragistics.Win.UltraWinGrid.UltraGridRow selectedRow = e.Row;
            this.ultraComboWithTree.ButtonsLeft[0].Appearance.Image = null;
            this.ultraComboWithTree.ButtonsLeft[0].GetType().GetProperty("Text").SetValue(this.ultraComboWithTree.ButtonsLeft[0], 
                OpenConvert.ToString(OpenGridPerformance.GetCellValue(selectedRow, 1)), null);
            (this.ultraComboWithTree.ButtonsLeft[0] as Infragistics.Win.UltraWinEditors.DropDownEditorButton).CloseUp();
        }

        /// <summary>
        /// Método que estable la opción de Consulta por Criterios en el control, mediante
        /// un botón en el lado izquierdo del mismo con las opciones especificadas,
        /// </summary>
        /// <param name="enable">Flag que indica la habilitación o inhabilitación de los criterios de Consulta</param>
        public void SetEnterQueryMode(bool enable)
        {

            this.CreateQueryButton();

            this._IsEnterQueryModeOn = enable;
            this.ultraComboWithTree.ButtonsLeft[0].Appearance.Image = global::SINCECOMP.FNB.Properties.SinceComp.imgQuery;
            this.ultraComboWithTree.ButtonsLeft[0].Visible = enable;
            this.ultraComboWithTree.ButtonsLeft[0].GetType().GetProperty("Text").SetValue(this.ultraComboWithTree.ButtonsLeft[0], string.Empty, null);
            if (enable)
            {
                DataSet tmpDataSet = (((this.ultraComboWithTree.ButtonsLeft[0] as
                                    Infragistics.Win.UltraWinEditors.DropDownEditorButton).Control as
                                    Infragistics.Win.UltraWinGrid.UltraDropDown).DataSource as DataSet).Copy();
                ((this.ultraComboWithTree.ButtonsLeft[0] as
                                    Infragistics.Win.UltraWinEditors.DropDownEditorButton).Control as
                                    Infragistics.Win.UltraWinGrid.UltraDropDown).DataSource = null;
                ((this.ultraComboWithTree.ButtonsLeft[0] as
                                    Infragistics.Win.UltraWinEditors.DropDownEditorButton).Control as
                                    Infragistics.Win.UltraWinGrid.UltraDropDown).DataSource = tmpDataSet;
                ((this.ultraComboWithTree.ButtonsLeft[0] as
                                    Infragistics.Win.UltraWinEditors.DropDownEditorButton).Control as
                                    Infragistics.Win.UltraWinGrid.UltraDropDown).DisplayMember = tmpDataSet.Tables[0].Columns[0].ColumnName;
                ((this.ultraComboWithTree.ButtonsLeft[0] as
                                    Infragistics.Win.UltraWinEditors.DropDownEditorButton).Control as
                                    Infragistics.Win.UltraWinGrid.UltraDropDown).ValueMember = tmpDataSet.Tables[0].Columns[0].ColumnName;
                ((this.ultraComboWithTree.ButtonsLeft[0] as
                                    Infragistics.Win.UltraWinEditors.DropDownEditorButton).Control as
                                    Infragistics.Win.UltraWinGrid.UltraDropDown).DisplayLayout.Scrollbars = Infragistics.Win.UltraWinGrid.Scrollbars.Vertical;
                ((this.ultraComboWithTree.ButtonsLeft[0] as
                                    Infragistics.Win.UltraWinEditors.DropDownEditorButton).Control as
                                    Infragistics.Win.UltraWinGrid.UltraDropDown).DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
                ((this.ultraComboWithTree.ButtonsLeft[0] as
                                    Infragistics.Win.UltraWinEditors.DropDownEditorButton).Control as
                                    Infragistics.Win.UltraWinGrid.UltraDropDown).DisplayLayout.Bands[0].ColHeadersVisible = false;
                ((this.ultraComboWithTree.ButtonsLeft[0] as
                                    Infragistics.Win.UltraWinEditors.DropDownEditorButton).Control as
                                    Infragistics.Win.UltraWinGrid.UltraDropDown).DisplayLayout.Bands[0].Columns[1].Hidden = true;
            }
            this.Refresh();
        }

        /// <summary>
        /// Método que establece las opciones a desplegar en los Criteris de Consulta en el control
        /// los cuales pueden ser: =, <, >, <=, >=, <>, *
        /// </summary>
        /// <param name="queryOptions">Arreglo que contiene los criterios a usar en el control =, <, >, <=, >=, <>, *</param>
        public void SetEnterQueryOptions(string[] queryOptions)
        {

            DataSet dsOptions = new DataSet();
            this.CreateQueryButton();
            dsOptions.Tables.Add("Options");
            dsOptions.Tables[0].Columns.Add("Option");
            dsOptions.Tables[0].Columns.Add("Value");
            foreach (string queryOption in queryOptions)
            {
                //=,<,>,<=,>=,<>,*
                int optionIndex = IsValidQueryOption(queryOption);
                if (optionIndex != -1)
                {
                    switch (optionIndex)
                    {
                        case 0://=
                           dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.EQUAL, queryOption });
                            break;
                        case 1://<
                           dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.GREATERTHAN, queryOption });
                            break;
                        case 2://>
                           dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.LOWERTHAN, queryOption });
                            break;
                        case 3://<=
                           dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.GREATEREQUALTHAN, queryOption });
                            break;
                        case 4://>=
                           dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.LOWEREQUALTHAN, queryOption });
                            break;
                        case 5://<>
                           dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.NOEQUAL, queryOption });
                            break;
                        case 6://*
                           dsOptions.Tables[0].Rows.Add(new string[] { global::SINCECOMP.FNB.Properties.SinceComp.LIKE, queryOption });
                            break;
                    }
                }
            }
            if (dsOptions.Tables[0].Rows.Count > 0)
            {
                ((this.ultraComboWithTree.ButtonsLeft[0] as Infragistics.Win.UltraWinEditors.DropDownEditorButton).Control
                    as Infragistics.Win.UltraWinGrid.UltraDropDown).DataSource = dsOptions;
            }
            ((this.ultraComboWithTree.ButtonsLeft[0] as Infragistics.Win.UltraWinEditors.DropDownEditorButton).Control
                    as Infragistics.Win.UltraWinGrid.UltraDropDown).Width = this.Width;
        }

        private int IsValidQueryOption(string queryOption)
        {
            //Los operadores validos, en su orden son: =,<,>,<=,>=,<>,*
           string[] validOptions = global::SINCECOMP.FNB.Properties.SinceComp.QUERYOPERATORS.Split(',');
            for (int i = 0; i < validOptions.Length; i++)
            {
                if (queryOption == validOptions[i])
                {
                    return i;
                }
            }
            return -1;
        }

        private string GetQueryValue()
        {
            string returnString = string.Empty;
            bool buttonVisible = this.ultraComboWithTree.ButtonsLeft[0].Visible;
            //Validar si esta activo el modo enterquery
            if (buttonVisible)
            {
                string comparator = (this.ultraComboWithTree.ButtonsLeft[0] as Infragistics.Win.UltraWinEditors.DropDownEditorButton).Text;
                string comboValue = string.Empty;
                //Se verifica si existe alguna fila seleccionada
                if (this.ultraComboWithTree.SelectedRow != null)
                {
                    comboValue = (this.Value != null) ? this.Value.ToString() : string.Empty;
                }
                else
                {//No hay filas seleccionadas se obtiene el texto que hay en el combo
                    comboValue = this.Text;
                }
                if (String.IsNullOrEmpty(comparator))
                {
                    comparator = "=";
                }
                if (!String.IsNullOrEmpty(comboValue))
                {
                    if (comparator == "*")
                    {
                        returnString = comparator + "'%" + comboValue + "%'";
                    }
                    else
                    {
                        returnString = comparator + comboValue;
                    }
                }
            }
            return returnString;

        }

		private void LoadDescription() {
			if (this.TreeViewData == null )
				return;
			if (OpenData.ConvertDBDatatoString(this.Value) != String.Empty ){
				DataRow drRow = this.TreeViewData.treeview_data.Rows.Find(this.Value);
				if (drRow != null ){
					this.ultraComboWithTree.Text = OpenData.ConvertDBDatatoString(drRow[this.TreeViewData.treeview_data.node_textColumn]);
				}
			}
		}

        public void OpenTreeCombo_Load(object sender, System.EventArgs e)
        {
            ChangedEventHandler eventh = this.ValueChanged;

            if (this.ValueChanged != null)
                this.ValueChanged = null;
            this.LoadTreeViewData();
            this.Refresh();
            this.LoadDescription();
            this.ultraComboWithTree.ItemNotInList += new ItemNotInListEventHandler(ultraComboWithTree_ItemNotInList);

            if (eventh != null)
                this.ValueChanged = eventh;

        }

		private void ultraComboWithTree_AfterCloseUp(object sender, System.EventArgs e) {
            this.ultraComboWithTree.Textbox.Focus();
            this.ultraComboWithTree.ToggleDropdown();					
		}

		private void ultraComboWithTree_BeforeDropDown(object sender, System.ComponentModel.CancelEventArgs e) {

            if (this.IsUsedInGrid)
                return;
            else
                e.Cancel = !this.ultraComboWithTree.Textbox.Focused;
		}

        private void ultraComboWithTree_Paint(object sender, PaintEventArgs e)
        {
            this.SetRequired();
            this.SetLocationCaption();
        }

        private void OpenTreeCombo_Layout(object sender, LayoutEventArgs e)
        {
            try
            {
                this.LoadTreeViewData();
                foreach (Infragistics.Win.UltraWinGrid.UltraGridColumn ugCol in this.ultraComboWithTree.DisplayLayout.Bands[0].Columns)
                {
                    ugCol.AutoSizeEdit = Infragistics.Win.DefaultableBoolean.True;
                    ugCol.PerformAutoResize(Infragistics.Win.UltraWinGrid.PerformAutoSizeType.AllRowsInBand);
                }
            }
            catch
            {
            }
        }
        //------------------------

    }
}
