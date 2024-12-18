namespace Ludycom.Constructoras.UI
{
    partial class LDCMDOINT
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LDCMDOINT));
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("OrdenesInternas", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ordenOri");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ordenDest", -1, null, 0, Infragistics.Win.UltraWinGrid.SortIndicator.Ascending, false);
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance6 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance7 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance9 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            this.cbx_proyecto = new OpenSystems.Windows.Controls.OpenHeavyListBox();
            this.otProjectBasicData = new OpenSystems.Windows.Controls.OpenTitle();
            this.btnProcesar = new OpenSystems.Windows.Controls.OpenButton();
            this.btnCancel = new OpenSystems.Windows.Controls.OpenButton();
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.BSordenesInternas = new System.Windows.Forms.BindingSource(this.components);
            this.panel1 = new System.Windows.Forms.Panel();
            this.bnOrdenInterna = new System.Windows.Forms.BindingNavigator(this.components);
            this.bindingNavigatorCountItem = new System.Windows.Forms.ToolStripLabel();
            this.bindingNavigatorMoveFirstItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorMovePreviousItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorSeparator = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorPositionItem = new System.Windows.Forms.ToolStripTextBox();
            this.bindingNavigatorSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.bindingNavigatorMoveNextItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorMoveLastItem = new System.Windows.Forms.ToolStripButton();
            this.bindingNavigatorSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.bnOrdenInternaAddNewItem = new System.Windows.Forms.ToolStripButton();
            this.bnOrdenInternaDeleteItem = new System.Windows.Forms.ToolStripButton();
            this.ugOrdenInterna = new Infragistics.Win.UltraWinGrid.UltraGrid();
            ((System.ComponentModel.ISupportInitialize)(this.BSordenesInternas)).BeginInit();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bnOrdenInterna)).BeginInit();
            this.bnOrdenInterna.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugOrdenInterna)).BeginInit();
            this.SuspendLayout();
            // 
            // cbx_proyecto
            // 
            this.cbx_proyecto.BackColor = System.Drawing.Color.Transparent;
            this.cbx_proyecto.Caption = "Proyecto";
            this.cbx_proyecto.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbx_proyecto.DataType = "";
            this.cbx_proyecto.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.cbx_proyecto.Location = new System.Drawing.Point(177, 61);
            this.cbx_proyecto.Name = "cbx_proyecto";
            this.cbx_proyecto.Required = 'Y';
            this.cbx_proyecto.Size = new System.Drawing.Size(357, 20);
            this.cbx_proyecto.StatementId = ((long)(0));
            this.cbx_proyecto.TabIndex = 212;
            this.cbx_proyecto.Value = "";
            this.cbx_proyecto.ValueChanged += new System.EventHandler(this.cbx_proyecto_ValueChanged);
            // 
            // otProjectBasicData
            // 
            this.otProjectBasicData.BackColor = System.Drawing.Color.Transparent;
            this.otProjectBasicData.Caption = "    Criterios";
            this.otProjectBasicData.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.otProjectBasicData.Location = new System.Drawing.Point(40, 20);
            this.otProjectBasicData.Name = "otProjectBasicData";
            this.otProjectBasicData.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.otProjectBasicData.Size = new System.Drawing.Size(677, 33);
            this.otProjectBasicData.TabIndex = 213;
            // 
            // btnProcesar
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnProcesar.Appearance = appearance1;
            this.btnProcesar.Enabled = false;
            this.btnProcesar.Location = new System.Drawing.Point(321, 379);
            this.btnProcesar.Name = "btnProcesar";
            this.btnProcesar.Size = new System.Drawing.Size(93, 23);
            this.btnProcesar.TabIndex = 215;
            this.btnProcesar.Text = "Procesar";
            this.btnProcesar.Click += new System.EventHandler(this.btnProcesar_Click);
            // 
            // btnCancel
            // 
            appearance2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance2.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnCancel.Appearance = appearance2;
            this.btnCancel.Location = new System.Drawing.Point(435, 379);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(98, 23);
            this.btnCancel.TabIndex = 214;
            this.btnCancel.Text = "Cancelar";
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.Transparent;
            this.openTitle1.Caption = "    Ordenes ";
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(41, 97);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.openTitle1.Size = new System.Drawing.Size(677, 55);
            this.openTitle1.TabIndex = 216;
            // 
            // BSordenesInternas
            // 
            this.BSordenesInternas.DataSource = typeof(Ludycom.Constructoras.ENTITIES.OrdenesInternas);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.bnOrdenInterna);
            this.panel1.Controls.Add(this.ugOrdenInterna);
            this.panel1.Location = new System.Drawing.Point(116, 129);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(417, 226);
            this.panel1.TabIndex = 217;
            // 
            // bnOrdenInterna
            // 
            this.bnOrdenInterna.AddNewItem = null;
            this.bnOrdenInterna.BindingSource = this.BSordenesInternas;
            this.bnOrdenInterna.CountItem = this.bindingNavigatorCountItem;
            this.bnOrdenInterna.DeleteItem = null;
            this.bnOrdenInterna.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.bindingNavigatorMoveFirstItem,
            this.bindingNavigatorMovePreviousItem,
            this.bindingNavigatorSeparator,
            this.bindingNavigatorPositionItem,
            this.bindingNavigatorCountItem,
            this.bindingNavigatorSeparator1,
            this.bindingNavigatorMoveNextItem,
            this.bindingNavigatorMoveLastItem,
            this.bindingNavigatorSeparator2,
            this.bnOrdenInternaAddNewItem,
            this.bnOrdenInternaDeleteItem});
            this.bnOrdenInterna.Location = new System.Drawing.Point(0, 0);
            this.bnOrdenInterna.MoveFirstItem = this.bindingNavigatorMoveFirstItem;
            this.bnOrdenInterna.MoveLastItem = this.bindingNavigatorMoveLastItem;
            this.bnOrdenInterna.MoveNextItem = this.bindingNavigatorMoveNextItem;
            this.bnOrdenInterna.MovePreviousItem = this.bindingNavigatorMovePreviousItem;
            this.bnOrdenInterna.Name = "bnOrdenInterna";
            this.bnOrdenInterna.PositionItem = this.bindingNavigatorPositionItem;
            this.bnOrdenInterna.Size = new System.Drawing.Size(417, 25);
            this.bnOrdenInterna.TabIndex = 103;
            this.bnOrdenInterna.Text = "bindingNavigator1";
            // 
            // bindingNavigatorCountItem
            // 
            this.bindingNavigatorCountItem.Name = "bindingNavigatorCountItem";
            this.bindingNavigatorCountItem.Size = new System.Drawing.Size(35, 22);
            this.bindingNavigatorCountItem.Text = "of {0}";
            this.bindingNavigatorCountItem.ToolTipText = "Número total de elementos";
            // 
            // bindingNavigatorMoveFirstItem
            // 
            this.bindingNavigatorMoveFirstItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveFirstItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveFirstItem.Image")));
            this.bindingNavigatorMoveFirstItem.Name = "bindingNavigatorMoveFirstItem";
            this.bindingNavigatorMoveFirstItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveFirstItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveFirstItem.Text = "Mover primero";
            // 
            // bindingNavigatorMovePreviousItem
            // 
            this.bindingNavigatorMovePreviousItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMovePreviousItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMovePreviousItem.Image")));
            this.bindingNavigatorMovePreviousItem.Name = "bindingNavigatorMovePreviousItem";
            this.bindingNavigatorMovePreviousItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMovePreviousItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMovePreviousItem.Text = "Mover anterior";
            // 
            // bindingNavigatorSeparator
            // 
            this.bindingNavigatorSeparator.Name = "bindingNavigatorSeparator";
            this.bindingNavigatorSeparator.Size = new System.Drawing.Size(6, 25);
            // 
            // bindingNavigatorPositionItem
            // 
            this.bindingNavigatorPositionItem.AccessibleName = "Posición";
            this.bindingNavigatorPositionItem.AutoSize = false;
            this.bindingNavigatorPositionItem.Name = "bindingNavigatorPositionItem";
            this.bindingNavigatorPositionItem.Size = new System.Drawing.Size(58, 23);
            this.bindingNavigatorPositionItem.Text = "0";
            this.bindingNavigatorPositionItem.ToolTipText = "Posición actual";
            // 
            // bindingNavigatorSeparator1
            // 
            this.bindingNavigatorSeparator1.Name = "bindingNavigatorSeparator1";
            this.bindingNavigatorSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // bindingNavigatorMoveNextItem
            // 
            this.bindingNavigatorMoveNextItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveNextItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveNextItem.Image")));
            this.bindingNavigatorMoveNextItem.Name = "bindingNavigatorMoveNextItem";
            this.bindingNavigatorMoveNextItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveNextItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveNextItem.Text = "Mover siguiente";
            // 
            // bindingNavigatorMoveLastItem
            // 
            this.bindingNavigatorMoveLastItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bindingNavigatorMoveLastItem.Image = ((System.Drawing.Image)(resources.GetObject("bindingNavigatorMoveLastItem.Image")));
            this.bindingNavigatorMoveLastItem.Name = "bindingNavigatorMoveLastItem";
            this.bindingNavigatorMoveLastItem.RightToLeftAutoMirrorImage = true;
            this.bindingNavigatorMoveLastItem.Size = new System.Drawing.Size(23, 22);
            this.bindingNavigatorMoveLastItem.Text = "Mover último";
            // 
            // bindingNavigatorSeparator2
            // 
            this.bindingNavigatorSeparator2.Name = "bindingNavigatorSeparator2";
            this.bindingNavigatorSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // bnOrdenInternaAddNewItem
            // 
            this.bnOrdenInternaAddNewItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bnOrdenInternaAddNewItem.Image = ((System.Drawing.Image)(resources.GetObject("bnOrdenInternaAddNewItem.Image")));
            this.bnOrdenInternaAddNewItem.Name = "bnOrdenInternaAddNewItem";
            this.bnOrdenInternaAddNewItem.RightToLeftAutoMirrorImage = true;
            this.bnOrdenInternaAddNewItem.Size = new System.Drawing.Size(23, 22);
            this.bnOrdenInternaAddNewItem.Text = "Agregar nuevo";
            this.bnOrdenInternaAddNewItem.Click += new System.EventHandler(this.bnOrdenesInternasAddNewItem_Click);
            // 
            // bnOrdenInternaDeleteItem
            // 
            this.bnOrdenInternaDeleteItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.bnOrdenInternaDeleteItem.Image = ((System.Drawing.Image)(resources.GetObject("bnOrdenInternaDeleteItem.Image")));
            this.bnOrdenInternaDeleteItem.Name = "bnOrdenInternaDeleteItem";
            this.bnOrdenInternaDeleteItem.RightToLeftAutoMirrorImage = true;
            this.bnOrdenInternaDeleteItem.Size = new System.Drawing.Size(23, 22);
            this.bnOrdenInternaDeleteItem.Text = "Eliminar";
            this.bnOrdenInternaDeleteItem.Click += new System.EventHandler(this.bnOrdenesInternasDeleteItem_Click);
            // 
            // ugOrdenInterna
            // 
            this.ugOrdenInterna.DataSource = this.BSordenesInternas;
            appearance3.BackColor = System.Drawing.SystemColors.Window;
            appearance3.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            appearance3.ThemedElementAlpha = Infragistics.Win.Alpha.Opaque;
            this.ugOrdenInterna.DisplayLayout.Appearance = appearance3;
            ultraGridColumn1.Header.VisiblePosition = 0;
            ultraGridColumn1.Width = 200;
            ultraGridColumn2.Header.VisiblePosition = 1;
            ultraGridColumn2.Width = 209;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2});
            ultraGridBand1.SummaryFooterCaption = "";
            this.ugOrdenInterna.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugOrdenInterna.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance4.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance4.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance4.BorderColor = System.Drawing.SystemColors.Window;
            this.ugOrdenInterna.DisplayLayout.GroupByBox.Appearance = appearance4;
            appearance5.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugOrdenInterna.DisplayLayout.GroupByBox.BandLabelAppearance = appearance5;
            this.ugOrdenInterna.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance6.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance6.BackColor2 = System.Drawing.SystemColors.Control;
            appearance6.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance6.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugOrdenInterna.DisplayLayout.GroupByBox.PromptAppearance = appearance6;
            this.ugOrdenInterna.DisplayLayout.MaxColScrollRegions = 1;
            this.ugOrdenInterna.DisplayLayout.MaxRowScrollRegions = 1;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            appearance7.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugOrdenInterna.DisplayLayout.Override.ActiveCellAppearance = appearance7;
            appearance8.BackColor = System.Drawing.SystemColors.Highlight;
            appearance8.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugOrdenInterna.DisplayLayout.Override.ActiveRowAppearance = appearance8;
            this.ugOrdenInterna.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugOrdenInterna.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance9.BackColor = System.Drawing.SystemColors.Window;
            this.ugOrdenInterna.DisplayLayout.Override.CardAreaAppearance = appearance9;
            appearance10.BorderColor = System.Drawing.Color.Silver;
            appearance10.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugOrdenInterna.DisplayLayout.Override.CellAppearance = appearance10;
            this.ugOrdenInterna.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugOrdenInterna.DisplayLayout.Override.CellPadding = 0;
            appearance11.BackColor = System.Drawing.SystemColors.Control;
            appearance11.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance11.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance11.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance11.BorderColor = System.Drawing.SystemColors.Window;
            this.ugOrdenInterna.DisplayLayout.Override.GroupByRowAppearance = appearance11;
            appearance12.TextHAlign = Infragistics.Win.HAlign.Left;
            this.ugOrdenInterna.DisplayLayout.Override.HeaderAppearance = appearance12;
            this.ugOrdenInterna.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugOrdenInterna.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance13.BackColor = System.Drawing.SystemColors.Window;
            appearance13.BorderColor = System.Drawing.Color.Silver;
            this.ugOrdenInterna.DisplayLayout.Override.RowAppearance = appearance13;
            this.ugOrdenInterna.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance14.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugOrdenInterna.DisplayLayout.Override.TemplateAddRowAppearance = appearance14;
            this.ugOrdenInterna.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugOrdenInterna.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugOrdenInterna.DisplayLayout.UseFixedHeaders = true;
            this.ugOrdenInterna.Location = new System.Drawing.Point(3, 27);
            this.ugOrdenInterna.Name = "ugOrdenInterna";
            this.ugOrdenInterna.Size = new System.Drawing.Size(414, 194);
            this.ugOrdenInterna.TabIndex = 102;
            this.ugOrdenInterna.AfterCellUpdate += new Infragistics.Win.UltraWinGrid.CellEventHandler(this.ugOrdenInterna_AfterCellUpdate);
            this.ugOrdenInterna.AfterRowActivate += new System.EventHandler(this.ugOrdenInterna_AfterRowActivate);
            this.ugOrdenInterna.BeforeRowDeactivate += new System.ComponentModel.CancelEventHandler(this.ugOrdenInterna_BeforeRowDeactivate);
            this.ugOrdenInterna.BeforeCellUpdate += new Infragistics.Win.UltraWinGrid.BeforeCellUpdateEventHandler(this.ugOrdenInterna_BeforeCellUpdate);
            // 
            // LDCMDOINT
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(677, 441);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.btnProcesar);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.otProjectBasicData);
            this.Controls.Add(this.cbx_proyecto);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "LDCMDOINT";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "LDCMDOINT - Modificacion de Ordenes Internas Constructoras";
            ((System.ComponentModel.ISupportInitialize)(this.BSordenesInternas)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bnOrdenInterna)).EndInit();
            this.bnOrdenInterna.ResumeLayout(false);
            this.bnOrdenInterna.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugOrdenInterna)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenHeavyListBox cbx_proyecto;
        private OpenSystems.Windows.Controls.OpenTitle otProjectBasicData;
        private OpenSystems.Windows.Controls.OpenButton btnProcesar;
        private OpenSystems.Windows.Controls.OpenButton btnCancel;
        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private System.Windows.Forms.BindingSource BSordenesInternas;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.BindingNavigator bnOrdenInterna;
        private System.Windows.Forms.ToolStripLabel bindingNavigatorCountItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveFirstItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMovePreviousItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator;
        private System.Windows.Forms.ToolStripTextBox bindingNavigatorPositionItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator1;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveNextItem;
        private System.Windows.Forms.ToolStripButton bindingNavigatorMoveLastItem;
        private System.Windows.Forms.ToolStripSeparator bindingNavigatorSeparator2;
        private System.Windows.Forms.ToolStripButton bnOrdenInternaAddNewItem;
        private System.Windows.Forms.ToolStripButton bnOrdenInternaDeleteItem;
        private Infragistics.Win.UltraWinGrid.UltraGrid ugOrdenInterna;
    }
}