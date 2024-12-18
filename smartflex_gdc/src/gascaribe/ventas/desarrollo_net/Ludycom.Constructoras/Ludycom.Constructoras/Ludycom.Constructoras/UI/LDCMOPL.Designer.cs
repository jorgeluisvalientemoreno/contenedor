namespace Ludycom.Constructoras.UI
{
    partial class LDCMOPL
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
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("ListadoInternas", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("selection");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("orden", -1, null, 0, Infragistics.Win.UltraWinGrid.SortIndicator.Ascending, false);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("contrato");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("producto");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn5 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("direccion");
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
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            this.otProjectBasicData = new OpenSystems.Windows.Controls.OpenTitle();
            this.btn_buscup = new OpenSystems.Windows.Controls.OpenButton();
            this.btnCancel = new OpenSystems.Windows.Controls.OpenButton();
            this.generalCheck = new System.Windows.Forms.CheckBox();
            this.dtgOrdenesInterna = new Infragistics.Win.UltraWinGrid.UltraGrid();
            this.bsListadoInternas = new System.Windows.Forms.BindingSource(this.components);
            this.cbx_proyecto = new OpenSystems.Windows.Controls.OpenHeavyListBox();
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.btnProcesar = new OpenSystems.Windows.Controls.OpenButton();
            this.btnLimpiar = new OpenSystems.Windows.Controls.OpenButton();
            ((System.ComponentModel.ISupportInitialize)(this.dtgOrdenesInterna)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bsListadoInternas)).BeginInit();
            this.SuspendLayout();
            // 
            // otProjectBasicData
            // 
            this.otProjectBasicData.BackColor = System.Drawing.Color.Transparent;
            this.otProjectBasicData.Caption = "    Busqueda";
            this.otProjectBasicData.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.otProjectBasicData.Location = new System.Drawing.Point(2, 12);
            this.otProjectBasicData.Name = "otProjectBasicData";
            this.otProjectBasicData.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.otProjectBasicData.Size = new System.Drawing.Size(965, 39);
            this.otProjectBasicData.TabIndex = 36;
            // 
            // btn_buscup
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btn_buscup.Appearance = appearance1;
            this.btn_buscup.Location = new System.Drawing.Point(464, 425);
            this.btn_buscup.Name = "btn_buscup";
            this.btn_buscup.Size = new System.Drawing.Size(101, 23);
            this.btn_buscup.TabIndex = 106;
            this.btn_buscup.Text = "Buscar";
            this.btn_buscup.Click += new System.EventHandler(this.btn_buscup_Click);
            // 
            // btnCancel
            // 
            appearance2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance2.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnCancel.Appearance = appearance2;
            this.btnCancel.Location = new System.Drawing.Point(762, 425);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(98, 23);
            this.btnCancel.TabIndex = 105;
            this.btnCancel.Text = "Cancelar";
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // generalCheck
            // 
            this.generalCheck.AccessibleName = "generalCheck";
            this.generalCheck.AutoSize = true;
            this.generalCheck.Location = new System.Drawing.Point(76, 111);
            this.generalCheck.Name = "generalCheck";
            this.generalCheck.Size = new System.Drawing.Size(15, 14);
            this.generalCheck.TabIndex = 107;
            this.generalCheck.UseVisualStyleBackColor = true;
            this.generalCheck.CheckedChanged += new System.EventHandler(this.generalCheck_CheckedChanged);
            // 
            // dtgOrdenesInterna
            // 
            this.dtgOrdenesInterna.DataSource = this.bsListadoInternas;
            appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            appearance3.BorderColor = System.Drawing.Color.White;
            this.dtgOrdenesInterna.DisplayLayout.Appearance = appearance3;
            this.dtgOrdenesInterna.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ExtendLastColumn;
            ultraGridColumn1.Header.VisiblePosition = 0;
            ultraGridColumn1.Width = 115;
            ultraGridColumn2.Header.VisiblePosition = 1;
            ultraGridColumn2.Width = 144;
            ultraGridColumn3.Header.VisiblePosition = 2;
            ultraGridColumn3.Width = 146;
            ultraGridColumn4.Header.VisiblePosition = 3;
            ultraGridColumn4.Width = 131;
            ultraGridColumn5.Header.VisiblePosition = 4;
            ultraGridColumn5.Width = 160;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2,
            ultraGridColumn3,
            ultraGridColumn4,
            ultraGridColumn5});
            this.dtgOrdenesInterna.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.dtgOrdenesInterna.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.dtgOrdenesInterna.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance4.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance4.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance4.BorderColor = System.Drawing.SystemColors.Window;
            this.dtgOrdenesInterna.DisplayLayout.GroupByBox.Appearance = appearance4;
            appearance5.ForeColor = System.Drawing.SystemColors.GrayText;
            this.dtgOrdenesInterna.DisplayLayout.GroupByBox.BandLabelAppearance = appearance5;
            this.dtgOrdenesInterna.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.dtgOrdenesInterna.DisplayLayout.GroupByBox.Hidden = true;
            appearance6.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance6.BackColor2 = System.Drawing.SystemColors.Control;
            appearance6.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance6.ForeColor = System.Drawing.SystemColors.GrayText;
            this.dtgOrdenesInterna.DisplayLayout.GroupByBox.PromptAppearance = appearance6;
            this.dtgOrdenesInterna.DisplayLayout.MaxColScrollRegions = 1;
            this.dtgOrdenesInterna.DisplayLayout.MaxRowScrollRegions = 1;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            appearance7.ForeColor = System.Drawing.SystemColors.ControlText;
            this.dtgOrdenesInterna.DisplayLayout.Override.ActiveCellAppearance = appearance7;
            appearance8.BackColor = System.Drawing.SystemColors.Highlight;
            appearance8.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.dtgOrdenesInterna.DisplayLayout.Override.ActiveRowAppearance = appearance8;
            this.dtgOrdenesInterna.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.Yes;
            this.dtgOrdenesInterna.DisplayLayout.Override.AllowRowFiltering = Infragistics.Win.DefaultableBoolean.True;
            this.dtgOrdenesInterna.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.dtgOrdenesInterna.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance9.BackColor = System.Drawing.SystemColors.Window;
            this.dtgOrdenesInterna.DisplayLayout.Override.CardAreaAppearance = appearance9;
            appearance10.BorderColor = System.Drawing.Color.Silver;
            appearance10.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.dtgOrdenesInterna.DisplayLayout.Override.CellAppearance = appearance10;
            this.dtgOrdenesInterna.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.dtgOrdenesInterna.DisplayLayout.Override.CellPadding = 0;
            appearance11.BackColor = System.Drawing.SystemColors.Control;
            appearance11.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance11.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance11.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance11.BorderColor = System.Drawing.SystemColors.Window;
            this.dtgOrdenesInterna.DisplayLayout.Override.GroupByRowAppearance = appearance11;
            appearance12.TextHAlign = Infragistics.Win.HAlign.Left;
            this.dtgOrdenesInterna.DisplayLayout.Override.HeaderAppearance = appearance12;
            this.dtgOrdenesInterna.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.dtgOrdenesInterna.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance13.BackColor = System.Drawing.SystemColors.Window;
            appearance13.BorderColor = System.Drawing.Color.Silver;
            this.dtgOrdenesInterna.DisplayLayout.Override.RowAppearance = appearance13;
            this.dtgOrdenesInterna.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance14.BackColor = System.Drawing.SystemColors.ControlLight;
            this.dtgOrdenesInterna.DisplayLayout.Override.TemplateAddRowAppearance = appearance14;
            this.dtgOrdenesInterna.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.dtgOrdenesInterna.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.dtgOrdenesInterna.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.dtgOrdenesInterna.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtgOrdenesInterna.Location = new System.Drawing.Point(25, 127);
            this.dtgOrdenesInterna.Name = "dtgOrdenesInterna";
            this.dtgOrdenesInterna.Size = new System.Drawing.Size(835, 272);
            this.dtgOrdenesInterna.TabIndex = 108;
            this.dtgOrdenesInterna.Text = "ultraGrid1";
            // 
            // bsListadoInternas
            // 
            this.bsListadoInternas.DataSource = typeof(Ludycom.Constructoras.ENTITIES.ListadoInternas);
            // 
            // cbx_proyecto
            // 
            this.cbx_proyecto.BackColor = System.Drawing.Color.Transparent;
            this.cbx_proyecto.Caption = "Proyecto";
            this.cbx_proyecto.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbx_proyecto.DataType = "";
            this.cbx_proyecto.Font = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbx_proyecto.Location = new System.Drawing.Point(83, 44);
            this.cbx_proyecto.Name = "cbx_proyecto";
            this.cbx_proyecto.Size = new System.Drawing.Size(306, 20);
            this.cbx_proyecto.StatementId = ((long)(0));
            this.cbx_proyecto.TabIndex = 211;
            this.cbx_proyecto.Value = "";
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.Transparent;
            this.openTitle1.Caption = "    Ordenes";
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(8, 73);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.openTitle1.Size = new System.Drawing.Size(965, 22);
            this.openTitle1.TabIndex = 212;
            // 
            // btnProcesar
            // 
            appearance15.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance15.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnProcesar.Appearance = appearance15;
            this.btnProcesar.Enabled = false;
            this.btnProcesar.Location = new System.Drawing.Point(568, 425);
            this.btnProcesar.Name = "btnProcesar";
            this.btnProcesar.Size = new System.Drawing.Size(93, 23);
            this.btnProcesar.TabIndex = 213;
            this.btnProcesar.Text = "Procesar";
            this.btnProcesar.Click += new System.EventHandler(this.btnProcesar_Click);
            // 
            // btnLimpiar
            // 
            appearance16.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance16.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnLimpiar.Appearance = appearance16;
            this.btnLimpiar.Location = new System.Drawing.Point(666, 425);
            this.btnLimpiar.Name = "btnLimpiar";
            this.btnLimpiar.Size = new System.Drawing.Size(91, 23);
            this.btnLimpiar.TabIndex = 214;
            this.btnLimpiar.Text = "Limpiar";
            this.btnLimpiar.Click += new System.EventHandler(this.btnLimpiar_Click);
            // 
            // LDCMOPL
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(965, 485);
            this.Controls.Add(this.btnLimpiar);
            this.Controls.Add(this.btnProcesar);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.cbx_proyecto);
            this.Controls.Add(this.generalCheck);
            this.Controls.Add(this.dtgOrdenesInterna);
            this.Controls.Add(this.btn_buscup);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.otProjectBasicData);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "LDCMOPL";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "LDCMOPL - Modificación de Ordenes Interna para Permitir Legalizar";
            ((System.ComponentModel.ISupportInitialize)(this.dtgOrdenesInterna)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bsListadoInternas)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenTitle otProjectBasicData;
        private OpenSystems.Windows.Controls.OpenButton btn_buscup;
        private OpenSystems.Windows.Controls.OpenButton btnCancel;
        private System.Windows.Forms.CheckBox generalCheck;
        private Infragistics.Win.UltraWinGrid.UltraGrid dtgOrdenesInterna;
        private System.Windows.Forms.BindingSource bsListadoInternas;
        private OpenSystems.Windows.Controls.OpenHeavyListBox cbx_proyecto;
        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private OpenSystems.Windows.Controls.OpenButton btnProcesar;
        private OpenSystems.Windows.Controls.OpenButton btnLimpiar;
    }
}