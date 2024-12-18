namespace Ludycom.Constructoras.UI
{
    partial class POCI
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
            Infragistics.Win.Appearance appearance7 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            this.tbInitialFeePercentage = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.btnAccept = new OpenSystems.Windows.Controls.OpenButton();
            this.tbPath = new OpenSystems.Windows.Controls.OpenSimpleTextBox();
            this.fbdPrecuponPath = new System.Windows.Forms.FolderBrowserDialog();
            this.btnSelectPrecuponPath = new OpenSystems.Windows.Controls.OpenButton();
            this.otPrecuponPrinting = new OpenSystems.Windows.Controls.OpenTitle();
            this.SuspendLayout();
            // 
            // tbInitialFeePercentage
            // 
            this.tbInitialFeePercentage.TypeBox = OpenSystems.Windows.Controls.TypesBox.Numeric;
            this.tbInitialFeePercentage.Caption = "Porcentaje de Cuota Inicial";
            this.tbInitialFeePercentage.CaptionFont = new System.Drawing.Font("Verdana", 8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbInitialFeePercentage.DateTimeFormatMask = OpenSystems.Windows.Controls.DateTimeFormatMasks.ShorDate;
            this.tbInitialFeePercentage.NumberType = Infragistics.Win.UltraWinEditors.NumericType.Double;
            this.tbInitialFeePercentage.NumberComposition = new OpenSystems.Windows.Controls.Number(15, 2);
            this.tbInitialFeePercentage.Required = 'Y';
            this.tbInitialFeePercentage.Length = null;
            this.tbInitialFeePercentage.TextBoxValue = null;
            this.tbInitialFeePercentage.Location = new System.Drawing.Point(387, 60);
            this.tbInitialFeePercentage.Name = "tbInitialFeePercentage";
            this.tbInitialFeePercentage.Size = new System.Drawing.Size(117, 20);
            this.tbInitialFeePercentage.TabIndex = 0;
            // 
            // btnAccept
            // 
            appearance7.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance7.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnAccept.Appearance = appearance7;
            this.btnAccept.Location = new System.Drawing.Point(393, 141);
            this.btnAccept.Name = "btnAccept";
            this.btnAccept.Size = new System.Drawing.Size(111, 23);
            this.btnAccept.TabIndex = 180;
            this.btnAccept.Text = "Aceptar";
            this.btnAccept.Click += new System.EventHandler(this.btnAccept_Click);
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
            this.tbPath.Location = new System.Drawing.Point(233, 96);
            this.tbPath.Name = "tbPath";
            this.tbPath.Size = new System.Drawing.Size(271, 20);
            this.tbPath.TabIndex = 182;
            // 
            // btnSelectPrecuponPath
            // 
            appearance8.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance8.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.btnSelectPrecuponPath.Appearance = appearance8;
            this.btnSelectPrecuponPath.Location = new System.Drawing.Point(233, 141);
            this.btnSelectPrecuponPath.Name = "btnSelectPrecuponPath";
            this.btnSelectPrecuponPath.Size = new System.Drawing.Size(142, 23);
            this.btnSelectPrecuponPath.TabIndex = 183;
            this.btnSelectPrecuponPath.Text = "Seleccionar Ruta";
            this.btnSelectPrecuponPath.Click += new System.EventHandler(this.btnSelectPrecuponPath_Click);
            // 
            // otPrecuponPrinting
            // 
            this.otPrecuponPrinting.BackColor = System.Drawing.Color.Transparent;
            this.otPrecuponPrinting.Caption = "    Impresión de Pre-cupón";
            this.otPrecuponPrinting.Font = new System.Drawing.Font("Verdana", 8.25F);
            this.otPrecuponPrinting.Location = new System.Drawing.Point(0, 9);
            this.otPrecuponPrinting.Name = "otPrecuponPrinting";
            this.otPrecuponPrinting.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.otPrecuponPrinting.Size = new System.Drawing.Size(535, 31);
            this.otPrecuponPrinting.TabIndex = 190;
            // 
            // POCI
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(535, 176);
            this.Controls.Add(this.otPrecuponPrinting);
            this.Controls.Add(this.btnSelectPrecuponPath);
            this.Controls.Add(this.tbPath);
            this.Controls.Add(this.btnAccept);
            this.Controls.Add(this.tbInitialFeePercentage);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "POCI";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Datos para Impresión de Precupón";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbInitialFeePercentage;
        private OpenSystems.Windows.Controls.OpenButton btnAccept;
        private OpenSystems.Windows.Controls.OpenSimpleTextBox tbPath;
        private System.Windows.Forms.FolderBrowserDialog fbdPrecuponPath;
        private OpenSystems.Windows.Controls.OpenButton btnSelectPrecuponPath;
        private OpenSystems.Windows.Controls.OpenTitle otPrecuponPrinting;
    }
}