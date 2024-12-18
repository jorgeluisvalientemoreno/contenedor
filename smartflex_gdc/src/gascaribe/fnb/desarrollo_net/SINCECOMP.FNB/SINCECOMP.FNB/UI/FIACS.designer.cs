namespace SINCECOMP.FNB.UI
{
    partial class FIACS
    {
        /// <summary>
        /// Variable del diseñador requerida.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén utilizando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben eliminar; false en caso contrario, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido del método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            this.ultraGroupBox1 = new Infragistics.Win.Misc.UltraGroupBox();
            this.btn_process = new OpenSystems.Windows.Controls.OpenButton();
            this.btn_cancel = new OpenSystems.Windows.Controls.OpenButton();
            this.openTitle1 = new OpenSystems.Windows.Controls.OpenTitle();
            this.openHeaderTitles1 = new OpenSystems.Windows.Controls.OpenHeaderTitles();
            this.panel1 = new System.Windows.Forms.Panel();
            this.cb_geograph_location = new SINCECOMP.FNB.Controls.TreeCombo();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).BeginInit();
            this.ultraGroupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // ultraGroupBox1
            // 
            this.ultraGroupBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.ultraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None;
            this.ultraGroupBox1.Controls.Add(this.btn_process);
            this.ultraGroupBox1.Controls.Add(this.btn_cancel);
            this.ultraGroupBox1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.ultraGroupBox1.Location = new System.Drawing.Point(0, 162);
            this.ultraGroupBox1.Name = "ultraGroupBox1";
            this.ultraGroupBox1.Size = new System.Drawing.Size(633, 28);
            this.ultraGroupBox1.SupportThemes = false;
            this.ultraGroupBox1.TabIndex = 32;
            // 
            // btn_process
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btn_process.Appearance = appearance1;
            this.btn_process.Location = new System.Drawing.Point(452, 2);
            this.btn_process.Name = "btn_process";
            this.btn_process.Size = new System.Drawing.Size(80, 25);
            this.btn_process.TabIndex = 0;
            this.btn_process.Text = "&Procesar";
            this.btn_process.Click += new System.EventHandler(this.btn_process_Click);
            // 
            // btn_cancel
            // 
            this.btn_cancel.Appearance = appearance1;
            this.btn_cancel.Location = new System.Drawing.Point(535, 2);
            this.btn_cancel.Name = "btn_cancel";
            this.btn_cancel.Size = new System.Drawing.Size(80, 25);
            this.btn_cancel.TabIndex = 1;
            this.btn_cancel.Text = "&Cancelar";
            this.btn_cancel.Click += new System.EventHandler(this.btn_cancel_Click);
            // 
            // openTitle1
            // 
            this.openTitle1.BackColor = System.Drawing.Color.Transparent;
            this.openTitle1.Caption = "   Datos";
            this.openTitle1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openTitle1.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.openTitle1.Location = new System.Drawing.Point(0, 52);
            this.openTitle1.Name = "openTitle1";
            this.openTitle1.Size = new System.Drawing.Size(633, 35);
            this.openTitle1.TabIndex = 31;
            this.openTitle1.TabStop = false;
            // 
            // openHeaderTitles1
            // 
            this.openHeaderTitles1.BackColor = System.Drawing.Color.White;
            this.openHeaderTitles1.Dock = System.Windows.Forms.DockStyle.Top;
            this.openHeaderTitles1.HeaderProtectedFields = null;
            this.openHeaderTitles1.HeaderSubtitle1 = "Asignación de Cupo de Crédito para Financiaciones no Bancarias Simulación";
            this.openHeaderTitles1.HeaderTitle = "Asignación de Cupo de Crédito para Financiaciones no Bancarias Simulación";
            this.openHeaderTitles1.Location = new System.Drawing.Point(0, 0);
            this.openHeaderTitles1.MaxWidth = -1;
            this.openHeaderTitles1.Name = "openHeaderTitles1";
            this.openHeaderTitles1.ParsedHeaderSubtitle2 = "";
            this.openHeaderTitles1.RowInformationHeader = null;
            this.openHeaderTitles1.Size = new System.Drawing.Size(633, 52);
            this.openHeaderTitles1.TabIndex = 30;
            this.openHeaderTitles1.TabStop = false;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.cb_geograph_location);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(0, 87);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(633, 75);
            this.panel1.TabIndex = 33;
            // 
            // cb_geograph_location
            // 
            this.cb_geograph_location.Caption = "Ubicación geográfica";
            this.cb_geograph_location.SqlSelect = "";
            this.cb_geograph_location.Location = new System.Drawing.Point(294, 26);
            this.cb_geograph_location.Name = "cb_geograph_location";
            this.cb_geograph_location.Size = new System.Drawing.Size(286, 20);
            this.cb_geograph_location.TabIndex = 4;
            // 
            // FIACS
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(633, 190);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.ultraGroupBox1);
            this.Controls.Add(this.openTitle1);
            this.Controls.Add(this.openHeaderTitles1);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(641, 217);
            this.MinimumSize = new System.Drawing.Size(641, 217);
            this.Name = "FIACS";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Asignación de Cupo de Crédito para Financiaciones no Bancarias Simulación (FIACS)" +
                "";
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).EndInit();
            this.ultraGroupBox1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private Infragistics.Win.Misc.UltraGroupBox ultraGroupBox1;
        private OpenSystems.Windows.Controls.OpenButton btn_process;
        private OpenSystems.Windows.Controls.OpenButton btn_cancel;
        private OpenSystems.Windows.Controls.OpenTitle openTitle1;
        private OpenSystems.Windows.Controls.OpenHeaderTitles openHeaderTitles1;
       private System.Windows.Forms.Panel panel1;
       private SINCECOMP.FNB.Controls.TreeCombo cb_geograph_location;
    }
}