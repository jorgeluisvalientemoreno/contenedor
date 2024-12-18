namespace Ludycom.Constructoras.UI
{
    partial class FIAC
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
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            this.btnSelectActPath = new OpenSystems.Windows.Controls.OpenButton();
            this.tbPath = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.btnPrint = new OpenSystems.Windows.Controls.OpenButton();
            this.otActPrinting = new OpenSystems.Windows.Controls.OpenTitle();
            this.fbActPath = new System.Windows.Forms.FolderBrowserDialog();
            this.SuspendLayout();
            // 
            // btnSelectActPath
            // 
            appearance1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance1.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnSelectActPath.Appearance = appearance1;
            this.btnSelectActPath.Location = new System.Drawing.Point(245, 92);
            this.btnSelectActPath.Name = "btnSelectActPath";
            this.btnSelectActPath.Size = new System.Drawing.Size(166, 23);
            this.btnSelectActPath.TabIndex = 187;
            this.btnSelectActPath.Text = "Seleccionar Ruta";
            this.btnSelectActPath.Click += new System.EventHandler(this.btnSelectActPath_Click);
            // 
            // tbPath
            // 
            this.tbPath.Caption = "Ruta de Archivo";
            this.tbPath.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbPath.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbPath.ReadOnly = true;
            this.tbPath.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Integer;
            this.tbPath.Required = 'Y';
            this.tbPath.Length = null;
            this.tbPath.TextBoxValue = "";
            this.tbPath.Enabled = false;
            this.tbPath.Location = new System.Drawing.Point(246, 54);
            this.tbPath.Name = "tbPath";
            this.tbPath.Size = new System.Drawing.Size(316, 20);
            this.tbPath.TabIndex = 186;
            // 
            // btnPrint
            // 
            appearance2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance2.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnPrint.Appearance = appearance2;
            this.btnPrint.Location = new System.Drawing.Point(433, 92);
            this.btnPrint.Name = "btnPrint";
            this.btnPrint.Size = new System.Drawing.Size(129, 23);
            this.btnPrint.TabIndex = 185;
            this.btnPrint.Text = "Imprimir";
            this.btnPrint.Click += new System.EventHandler(this.btnPrint_Click);
            // 
            // otActPrinting
            // 
            this.otActPrinting.BackColor = System.Drawing.Color.Transparent;
            this.otActPrinting.Caption = "    Impresión de Acta";
            this.otActPrinting.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.otActPrinting.Location = new System.Drawing.Point(1, 13);
            this.otActPrinting.Name = "otActPrinting";
            this.otActPrinting.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.otActPrinting.Size = new System.Drawing.Size(576, 33);
            this.otActPrinting.TabIndex = 189;
            // 
            // FIAC
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(576, 136);
            this.Controls.Add(this.otActPrinting);
            this.Controls.Add(this.btnSelectActPath);
            this.Controls.Add(this.tbPath);
            this.Controls.Add(this.btnPrint);
            this.Name = "FIAC";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FIAC - Forma de Impresión de Acta";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenButton btnSelectActPath;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbPath;
        private OpenSystems.Windows.Controls.OpenButton btnPrint;
        private OpenSystems.Windows.Controls.OpenTitle otActPrinting;
        private System.Windows.Forms.FolderBrowserDialog fbActPath;
    }
}