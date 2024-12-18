namespace SINCECOMP.FNB.UI
{
    partial class IFIFAP
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
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            this.ultraGroupBox1 = new Infragistics.Win.Misc.UltraGroupBox();
            this.buttonAceptar = new OpenSystems.Windows.Controls.OpenButton();
            this.buttonCancelar = new OpenSystems.Windows.Controls.OpenButton();
            this.rdvNormal = new System.Windows.Forms.RadioButton();
            this.rdvMateriales = new System.Windows.Forms.RadioButton();
            this.ultraGroupBox2 = new Infragistics.Win.Misc.UltraGroupBox();
            this.TmrControl = new System.Windows.Forms.Timer(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox2)).BeginInit();
            this.ultraGroupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // ultraGroupBox1
            // 
            this.ultraGroupBox1.Location = new System.Drawing.Point(0, 0);
            this.ultraGroupBox1.Name = "ultraGroupBox1";
            this.ultraGroupBox1.Size = new System.Drawing.Size(200, 110);
            this.ultraGroupBox1.SupportThemes = false;
            this.ultraGroupBox1.TabIndex = 0;
            // 
            // buttonAceptar
            // 
            appearance2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(243)))), ((int)(((byte)(243)))), ((int)(((byte)(239)))));
            appearance2.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(223)))), ((int)(((byte)(214)))));
            this.buttonAceptar.Appearance = appearance2;
            this.buttonAceptar.Location = new System.Drawing.Point(68, 0);
            this.buttonAceptar.Name = "buttonAceptar";
            this.buttonAceptar.Size = new System.Drawing.Size(80, 25);
            this.buttonAceptar.TabIndex = 2;
            this.buttonAceptar.Text = "Aceptar";
            this.buttonAceptar.Click += new System.EventHandler(this.buttonAceptar_Click);
            // 
            // buttonCancelar
            // 
            this.buttonCancelar.Appearance = appearance2;
            this.buttonCancelar.Location = new System.Drawing.Point(151, 0);
            this.buttonCancelar.Name = "buttonCancelar";
            this.buttonCancelar.Size = new System.Drawing.Size(80, 25);
            this.buttonCancelar.TabIndex = 3;
            this.buttonCancelar.Text = "Cancelar";
            this.buttonCancelar.Click += new System.EventHandler(this.buttonCancelar_Click);
            // 
            // rdvNormal
            // 
            this.rdvNormal.AutoSize = true;
            this.rdvNormal.Checked = true;
            this.rdvNormal.Location = new System.Drawing.Point(12, 44);
            this.rdvNormal.Name = "rdvNormal";
            this.rdvNormal.Size = new System.Drawing.Size(89, 17);
            this.rdvNormal.TabIndex = 0;
            this.rdvNormal.TabStop = true;
            this.rdvNormal.Text = "Venta Normal";
            this.rdvNormal.UseVisualStyleBackColor = true;
            // 
            // rdvMateriales
            // 
            this.rdvMateriales.AutoSize = true;
            this.rdvMateriales.Enabled = false;
            this.rdvMateriales.Location = new System.Drawing.Point(127, 44);
            this.rdvMateriales.Name = "rdvMateriales";
            this.rdvMateriales.Size = new System.Drawing.Size(104, 17);
            this.rdvMateriales.TabIndex = 1;
            this.rdvMateriales.Text = "Venta Materiales";
            this.rdvMateriales.UseVisualStyleBackColor = true;
            // 
            // ultraGroupBox2
            // 
            this.ultraGroupBox2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(122)))), ((int)(((byte)(150)))), ((int)(((byte)(223)))));
            this.ultraGroupBox2.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None;
            this.ultraGroupBox2.Controls.Add(this.buttonAceptar);
            this.ultraGroupBox2.Controls.Add(this.buttonCancelar);
            this.ultraGroupBox2.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.ultraGroupBox2.Location = new System.Drawing.Point(0, 92);
            this.ultraGroupBox2.Name = "ultraGroupBox2";
            this.ultraGroupBox2.Size = new System.Drawing.Size(243, 25);
            this.ultraGroupBox2.SupportThemes = false;
            this.ultraGroupBox2.TabIndex = 33;
            // 
            // TmrControl
            // 
            this.TmrControl.Enabled = true;
            this.TmrControl.Interval = 1000;
            this.TmrControl.Tick += new System.EventHandler(this.TmrControl_Tick);
            // 
            // IFIFAP
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoScroll = true;
            this.AutoSize = true;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(243, 117);
            this.Controls.Add(this.ultraGroupBox2);
            this.Controls.Add(this.rdvMateriales);
            this.Controls.Add(this.rdvNormal);
            this.MaximizeBox = false;
            this.Name = "IFIFAP";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Tipo de Venta";
            this.WindowState = System.Windows.Forms.FormWindowState.Minimized;
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGroupBox2)).EndInit();
            this.ultraGroupBox2.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Infragistics.Win.Misc.UltraGroupBox ultraGroupBox1;
        private System.Windows.Forms.RadioButton rdvNormal;
        private System.Windows.Forms.RadioButton rdvMateriales;
        private OpenSystems.Windows.Controls.OpenButton buttonAceptar;
        private OpenSystems.Windows.Controls.OpenButton buttonCancelar;
        private Infragistics.Win.Misc.UltraGroupBox ultraGroupBox2;
        private System.Windows.Forms.Timer TmrControl;
    }
}