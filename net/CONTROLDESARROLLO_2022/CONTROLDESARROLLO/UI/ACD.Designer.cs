namespace CONTROLDESARROLLO.UI
{
    partial class ACD
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
            this.menuACD = new System.Windows.Forms.MenuStrip();
            this.menuobjetos = new System.Windows.Forms.ToolStripMenuItem();
            this.menuvalidacion = new System.Windows.Forms.ToolStripMenuItem();
            this.menufuncion = new System.Windows.Forms.ToolStripMenuItem();
            this.menufuncioncreacion = new System.Windows.Forms.ToolStripMenuItem();
            this.procedimientoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.crecionToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.paqueteToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.creacionToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.menuvalidacionarchivo = new System.Windows.Forms.ToolStripMenuItem();
            this.menuvalidacioncodigo = new System.Windows.Forms.ToolStripMenuItem();
            this.menuACD.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuACD
            // 
            this.menuACD.GripMargin = new System.Windows.Forms.Padding(2, 2, 0, 2);
            this.menuACD.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.menuACD.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.menuobjetos});
            this.menuACD.Location = new System.Drawing.Point(0, 0);
            this.menuACD.Name = "menuACD";
            this.menuACD.Size = new System.Drawing.Size(1433, 33);
            this.menuACD.TabIndex = 0;
            this.menuACD.Text = "menuStrip1";
            // 
            // menuobjetos
            // 
            this.menuobjetos.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.menuvalidacion,
            this.menufuncion,
            this.procedimientoToolStripMenuItem,
            this.paqueteToolStripMenuItem});
            this.menuobjetos.Name = "menuobjetos";
            this.menuobjetos.Size = new System.Drawing.Size(91, 29);
            this.menuobjetos.Text = "&Objetos";
            // 
            // menuvalidacion
            // 
            this.menuvalidacion.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.menuvalidacionarchivo,
            this.menuvalidacioncodigo});
            this.menuvalidacion.Name = "menuvalidacion";
            this.menuvalidacion.Size = new System.Drawing.Size(270, 34);
            this.menuvalidacion.Text = "&Validacion";
            // 
            // menufuncion
            // 
            this.menufuncion.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.menufuncioncreacion});
            this.menufuncion.Name = "menufuncion";
            this.menufuncion.Size = new System.Drawing.Size(270, 34);
            this.menufuncion.Text = "&Funcion";
            // 
            // menufuncioncreacion
            // 
            this.menufuncioncreacion.Name = "menufuncioncreacion";
            this.menufuncioncreacion.Size = new System.Drawing.Size(270, 34);
            this.menufuncioncreacion.Text = "&Creacion";
            this.menufuncioncreacion.Click += new System.EventHandler(this.menufuncioncreacion_Click);
            // 
            // procedimientoToolStripMenuItem
            // 
            this.procedimientoToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.crecionToolStripMenuItem});
            this.procedimientoToolStripMenuItem.Name = "procedimientoToolStripMenuItem";
            this.procedimientoToolStripMenuItem.Size = new System.Drawing.Size(270, 34);
            this.procedimientoToolStripMenuItem.Text = "&Procedimiento";
            // 
            // crecionToolStripMenuItem
            // 
            this.crecionToolStripMenuItem.Name = "crecionToolStripMenuItem";
            this.crecionToolStripMenuItem.Size = new System.Drawing.Size(270, 34);
            this.crecionToolStripMenuItem.Text = "&Creacion";
            this.crecionToolStripMenuItem.Click += new System.EventHandler(this.crecionToolStripMenuItem_Click);
            // 
            // paqueteToolStripMenuItem
            // 
            this.paqueteToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.creacionToolStripMenuItem});
            this.paqueteToolStripMenuItem.Name = "paqueteToolStripMenuItem";
            this.paqueteToolStripMenuItem.Size = new System.Drawing.Size(270, 34);
            this.paqueteToolStripMenuItem.Text = "Paquete";
            // 
            // creacionToolStripMenuItem
            // 
            this.creacionToolStripMenuItem.Name = "creacionToolStripMenuItem";
            this.creacionToolStripMenuItem.Size = new System.Drawing.Size(182, 34);
            this.creacionToolStripMenuItem.Text = "Creacion";
            this.creacionToolStripMenuItem.Click += new System.EventHandler(this.creacionToolStripMenuItem_Click);
            // 
            // menuvalidacionarchivo
            // 
            this.menuvalidacionarchivo.Name = "menuvalidacionarchivo";
            this.menuvalidacionarchivo.Size = new System.Drawing.Size(270, 34);
            this.menuvalidacionarchivo.Text = "&Archivo";
            this.menuvalidacionarchivo.Click += new System.EventHandler(this.menuvalidacionarchivo_Click);
            // 
            // menuvalidacioncodigo
            // 
            this.menuvalidacioncodigo.Name = "menuvalidacioncodigo";
            this.menuvalidacioncodigo.Size = new System.Drawing.Size(270, 34);
            this.menuvalidacioncodigo.Text = "&Codigo";
            this.menuvalidacioncodigo.Click += new System.EventHandler(this.menuvalidacioncodigo_Click);
            // 
            // ACD
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(11F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(239)))), ((int)(((byte)(255)))));
            this.ClientSize = new System.Drawing.Size(1433, 542);
            this.Controls.Add(this.menuACD);
            this.MainMenuStrip = this.menuACD;
            this.Margin = new System.Windows.Forms.Padding(5);
            this.Name = "ACD";
            this.Text = "ACD - Administracion de Control Desarrollo";
            this.Load += new System.EventHandler(this.ACD_Load);
            this.menuACD.ResumeLayout(false);
            this.menuACD.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuACD;
        private System.Windows.Forms.ToolStripMenuItem menuobjetos;
        private System.Windows.Forms.ToolStripMenuItem menufuncion;
        private System.Windows.Forms.ToolStripMenuItem menufuncioncreacion;
        private System.Windows.Forms.ToolStripMenuItem menuvalidacion;
        private System.Windows.Forms.ToolStripMenuItem procedimientoToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem crecionToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem paqueteToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem creacionToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem menuvalidacionarchivo;
        private System.Windows.Forms.ToolStripMenuItem menuvalidacioncodigo;
    }
}