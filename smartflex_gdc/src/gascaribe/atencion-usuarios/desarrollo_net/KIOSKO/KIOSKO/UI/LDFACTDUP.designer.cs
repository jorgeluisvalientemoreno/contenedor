namespace KIOSKO.UI
{
    partial class LDFACTDUP
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LDFACTDUP));
            this.txt_dato = new System.Windows.Forms.TextBox();
            this.txt_municipio = new System.Windows.Forms.TextBox();
            this.txt_direccion = new System.Windows.Forms.TextBox();
            this.txt_categoria = new System.Windows.Forms.TextBox();
            this.txt_facturaant = new System.Windows.Forms.TextBox();
            this.txt_facturaact = new System.Windows.Forms.TextBox();
            this.cmb_imprimir = new System.Windows.Forms.ComboBox();
            this.btn_imprimir = new System.Windows.Forms.Button();
            this.shapeContainer1 = new Microsoft.VisualBasic.PowerPacks.ShapeContainer();
            this.os_selcontrato = new Microsoft.VisualBasic.PowerPacks.OvalShape();
            this.os_selcednit = new Microsoft.VisualBasic.PowerPacks.OvalShape();
            this.rs_buscar = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.rs_0 = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.rs_limpiar = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.rs_9 = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.rs_8 = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.rs_7 = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.rs_6 = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.rs_5 = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.rs_4 = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.rs_3 = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.rs_2 = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.rs_1 = new Microsoft.VisualBasic.PowerPacks.RectangleShape();
            this.crv_factura = new CrystalDecisions.Windows.Forms.CrystalReportViewer();
            this.lbl_mensaje1 = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.lbl_mensaje2 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // txt_dato
            // 
            this.txt_dato.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txt_dato.Font = new System.Drawing.Font("Verdana", 25F);
            this.txt_dato.Location = new System.Drawing.Point(363, 177);
            this.txt_dato.Name = "txt_dato";
            this.txt_dato.Size = new System.Drawing.Size(357, 48);
            this.txt_dato.TabIndex = 0;
            this.txt_dato.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.txt_dato.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txt_dato_KeyDown);
            this.txt_dato.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txt_dato_KeyPress);
            // 
            // txt_municipio
            // 
            this.txt_municipio.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txt_municipio.Font = new System.Drawing.Font("Verdana", 14F);
            this.txt_municipio.Location = new System.Drawing.Point(20, 574);
            this.txt_municipio.Multiline = true;
            this.txt_municipio.Name = "txt_municipio";
            this.txt_municipio.Size = new System.Drawing.Size(143, 68);
            this.txt_municipio.TabIndex = 4;
            this.txt_municipio.Visible = false;
            // 
            // txt_direccion
            // 
            this.txt_direccion.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txt_direccion.Font = new System.Drawing.Font("Verdana", 14F);
            this.txt_direccion.Location = new System.Drawing.Point(171, 574);
            this.txt_direccion.Multiline = true;
            this.txt_direccion.Name = "txt_direccion";
            this.txt_direccion.Size = new System.Drawing.Size(143, 68);
            this.txt_direccion.TabIndex = 5;
            this.txt_direccion.Visible = false;
            // 
            // txt_categoria
            // 
            this.txt_categoria.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txt_categoria.Font = new System.Drawing.Font("Verdana", 14F);
            this.txt_categoria.Location = new System.Drawing.Point(320, 574);
            this.txt_categoria.Multiline = true;
            this.txt_categoria.Name = "txt_categoria";
            this.txt_categoria.Size = new System.Drawing.Size(143, 68);
            this.txt_categoria.TabIndex = 6;
            this.txt_categoria.Visible = false;
            // 
            // txt_facturaant
            // 
            this.txt_facturaant.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txt_facturaant.Font = new System.Drawing.Font("Verdana", 14F);
            this.txt_facturaant.Location = new System.Drawing.Point(470, 574);
            this.txt_facturaant.Multiline = true;
            this.txt_facturaant.Name = "txt_facturaant";
            this.txt_facturaant.Size = new System.Drawing.Size(143, 68);
            this.txt_facturaant.TabIndex = 7;
            this.txt_facturaant.Visible = false;
            // 
            // txt_facturaact
            // 
            this.txt_facturaact.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txt_facturaact.Font = new System.Drawing.Font("Verdana", 14F);
            this.txt_facturaact.Location = new System.Drawing.Point(621, 574);
            this.txt_facturaact.Multiline = true;
            this.txt_facturaact.Name = "txt_facturaact";
            this.txt_facturaact.Size = new System.Drawing.Size(143, 68);
            this.txt_facturaact.TabIndex = 8;
            this.txt_facturaact.Visible = false;
            // 
            // cmb_imprimir
            // 
            this.cmb_imprimir.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmb_imprimir.Font = new System.Drawing.Font("Verdana", 10F);
            this.cmb_imprimir.FormattingEnabled = true;
            this.cmb_imprimir.Items.AddRange(new object[] {
            "SELECCIONE",
            "ANTERIOR",
            "ACTUAL"});
            this.cmb_imprimir.Location = new System.Drawing.Point(769, 598);
            this.cmb_imprimir.Name = "cmb_imprimir";
            this.cmb_imprimir.Size = new System.Drawing.Size(144, 24);
            this.cmb_imprimir.TabIndex = 9;
            this.cmb_imprimir.Visible = false;
            // 
            // btn_imprimir
            // 
            this.btn_imprimir.Font = new System.Drawing.Font("Verdana", 8.25F, System.Drawing.FontStyle.Bold);
            this.btn_imprimir.Location = new System.Drawing.Point(921, 598);
            this.btn_imprimir.Name = "btn_imprimir";
            this.btn_imprimir.Size = new System.Drawing.Size(144, 24);
            this.btn_imprimir.TabIndex = 10;
            this.btn_imprimir.Text = "IMPRIMIR";
            this.btn_imprimir.UseVisualStyleBackColor = true;
            this.btn_imprimir.Visible = false;
            this.btn_imprimir.Click += new System.EventHandler(this.btn_imprimir_Click);
            // 
            // shapeContainer1
            // 
            this.shapeContainer1.Location = new System.Drawing.Point(0, 0);
            this.shapeContainer1.Margin = new System.Windows.Forms.Padding(0);
            this.shapeContainer1.Name = "shapeContainer1";
            this.shapeContainer1.Shapes.AddRange(new Microsoft.VisualBasic.PowerPacks.Shape[] {
            this.os_selcontrato,
            this.os_selcednit,
            this.rs_buscar,
            this.rs_0,
            this.rs_limpiar,
            this.rs_9,
            this.rs_8,
            this.rs_7,
            this.rs_6,
            this.rs_5,
            this.rs_4,
            this.rs_3,
            this.rs_2,
            this.rs_1});
            this.shapeContainer1.Size = new System.Drawing.Size(1084, 652);
            this.shapeContainer1.TabIndex = 11;
            this.shapeContainer1.TabStop = false;
            // 
            // os_selcontrato
            // 
            this.os_selcontrato.BorderColor = System.Drawing.Color.Transparent;
            this.os_selcontrato.FillColor = System.Drawing.Color.Black;
            this.os_selcontrato.FillStyle = Microsoft.VisualBasic.PowerPacks.FillStyle.Solid;
            this.os_selcontrato.Location = new System.Drawing.Point(373, 230);
            this.os_selcontrato.Name = "os_selcontrato";
            this.os_selcontrato.Size = new System.Drawing.Size(15, 15);
            this.os_selcontrato.Click += new System.EventHandler(this.os_selcontrato_Click);
            // 
            // os_selcednit
            // 
            this.os_selcednit.BorderColor = System.Drawing.Color.Transparent;
            this.os_selcednit.Enabled = false;
            this.os_selcednit.FillColor = System.Drawing.Color.Transparent;
            this.os_selcednit.FillStyle = Microsoft.VisualBasic.PowerPacks.FillStyle.Solid;
            this.os_selcednit.Location = new System.Drawing.Point(471, 230);
            this.os_selcednit.Name = "os_selcednit";
            this.os_selcednit.Size = new System.Drawing.Size(15, 15);
            this.os_selcednit.Click += new System.EventHandler(this.os_selcednit_Click);
            // 
            // rs_buscar
            // 
            this.rs_buscar.BorderColor = System.Drawing.Color.Transparent;
            this.rs_buscar.Location = new System.Drawing.Point(592, 444);
            this.rs_buscar.Name = "rs_buscar";
            this.rs_buscar.Size = new System.Drawing.Size(67, 46);
            this.rs_buscar.Click += new System.EventHandler(this.rs_buscar_Click);
            // 
            // rs_0
            // 
            this.rs_0.BorderColor = System.Drawing.Color.Transparent;
            this.rs_0.Location = new System.Drawing.Point(507, 444);
            this.rs_0.Name = "rs_0";
            this.rs_0.Size = new System.Drawing.Size(67, 46);
            this.rs_0.Click += new System.EventHandler(this.rs_0_Click);
            // 
            // rs_limpiar
            // 
            this.rs_limpiar.BorderColor = System.Drawing.Color.Transparent;
            this.rs_limpiar.Location = new System.Drawing.Point(422, 444);
            this.rs_limpiar.Name = "rs_limpiar";
            this.rs_limpiar.Size = new System.Drawing.Size(67, 46);
            this.rs_limpiar.Click += new System.EventHandler(this.rs_limpiar_Click);
            // 
            // rs_9
            // 
            this.rs_9.BorderColor = System.Drawing.Color.Transparent;
            this.rs_9.Location = new System.Drawing.Point(592, 387);
            this.rs_9.Name = "rs_9";
            this.rs_9.Size = new System.Drawing.Size(67, 46);
            this.rs_9.Click += new System.EventHandler(this.rs_9_Click);
            // 
            // rs_8
            // 
            this.rs_8.BorderColor = System.Drawing.Color.Transparent;
            this.rs_8.Location = new System.Drawing.Point(507, 387);
            this.rs_8.Name = "rs_8";
            this.rs_8.Size = new System.Drawing.Size(67, 46);
            this.rs_8.Click += new System.EventHandler(this.rs_8_Click);
            // 
            // rs_7
            // 
            this.rs_7.BorderColor = System.Drawing.Color.Transparent;
            this.rs_7.Location = new System.Drawing.Point(422, 387);
            this.rs_7.Name = "rs_7";
            this.rs_7.Size = new System.Drawing.Size(67, 46);
            this.rs_7.Click += new System.EventHandler(this.rs_7_Click);
            // 
            // rs_6
            // 
            this.rs_6.BorderColor = System.Drawing.Color.Transparent;
            this.rs_6.Location = new System.Drawing.Point(592, 329);
            this.rs_6.Name = "rs_6";
            this.rs_6.Size = new System.Drawing.Size(67, 46);
            this.rs_6.Click += new System.EventHandler(this.rs_6_Click);
            // 
            // rs_5
            // 
            this.rs_5.BorderColor = System.Drawing.Color.Transparent;
            this.rs_5.Location = new System.Drawing.Point(507, 329);
            this.rs_5.Name = "rs_5";
            this.rs_5.Size = new System.Drawing.Size(67, 46);
            this.rs_5.Click += new System.EventHandler(this.rs_5_Click);
            // 
            // rs_4
            // 
            this.rs_4.BorderColor = System.Drawing.Color.Transparent;
            this.rs_4.Location = new System.Drawing.Point(422, 329);
            this.rs_4.Name = "rs_4";
            this.rs_4.Size = new System.Drawing.Size(67, 46);
            this.rs_4.Click += new System.EventHandler(this.rs_4_Click);
            // 
            // rs_3
            // 
            this.rs_3.BorderColor = System.Drawing.Color.Transparent;
            this.rs_3.Location = new System.Drawing.Point(592, 273);
            this.rs_3.Name = "rs_3";
            this.rs_3.Size = new System.Drawing.Size(67, 46);
            this.rs_3.Click += new System.EventHandler(this.rs_3_Click);
            // 
            // rs_2
            // 
            this.rs_2.BorderColor = System.Drawing.Color.Transparent;
            this.rs_2.Location = new System.Drawing.Point(507, 273);
            this.rs_2.Name = "rs_2";
            this.rs_2.Size = new System.Drawing.Size(67, 46);
            this.rs_2.Click += new System.EventHandler(this.rs_2_Click);
            // 
            // rs_1
            // 
            this.rs_1.BorderColor = System.Drawing.Color.Transparent;
            this.rs_1.Location = new System.Drawing.Point(422, 273);
            this.rs_1.Name = "rs_1";
            this.rs_1.Size = new System.Drawing.Size(67, 46);
            this.rs_1.Click += new System.EventHandler(this.rs_1_Click);
            // 
            // crv_factura
            // 
            this.crv_factura.ActiveViewIndex = -1;
            this.crv_factura.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.crv_factura.Cursor = System.Windows.Forms.Cursors.Default;
            this.crv_factura.Location = new System.Drawing.Point(697, 224);
            this.crv_factura.Name = "crv_factura";
            this.crv_factura.Size = new System.Drawing.Size(215, 260);
            this.crv_factura.TabIndex = 12;
            this.crv_factura.Visible = false;
            // 
            // lbl_mensaje1
            // 
            this.lbl_mensaje1.BackColor = System.Drawing.Color.Transparent;
            this.lbl_mensaje1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbl_mensaje1.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_mensaje1.ForeColor = System.Drawing.Color.Yellow;
            this.lbl_mensaje1.Location = new System.Drawing.Point(0, 0);
            this.lbl_mensaje1.Name = "lbl_mensaje1";
            this.lbl_mensaje1.Size = new System.Drawing.Size(629, 60);
            this.lbl_mensaje1.TabIndex = 13;
            this.lbl_mensaje1.Text = "► Ingrese un Mensaje";
            this.lbl_mensaje1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.Transparent;
            this.panel1.Controls.Add(this.lbl_mensaje1);
            this.panel1.Location = new System.Drawing.Point(154, 102);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(629, 60);
            this.panel1.TabIndex = 14;
            this.panel1.Visible = false;
            // 
            // panel2
            // 
            this.panel2.BackColor = System.Drawing.Color.Transparent;
            this.panel2.Controls.Add(this.lbl_mensaje2);
            this.panel2.Location = new System.Drawing.Point(20, 518);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(901, 21);
            this.panel2.TabIndex = 15;
            // 
            // lbl_mensaje2
            // 
            this.lbl_mensaje2.BackColor = System.Drawing.Color.Transparent;
            this.lbl_mensaje2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbl_mensaje2.Font = new System.Drawing.Font("Arial", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbl_mensaje2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(64)))), ((int)(((byte)(0)))));
            this.lbl_mensaje2.Location = new System.Drawing.Point(0, 0);
            this.lbl_mensaje2.Name = "lbl_mensaje2";
            this.lbl_mensaje2.Size = new System.Drawing.Size(901, 21);
            this.lbl_mensaje2.TabIndex = 13;
            this.lbl_mensaje2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(837, 195);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 16;
            this.button1.Text = "button1";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Visible = false;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // LDFACTDUP
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackgroundImage = ((System.Drawing.Image)(resources.GetObject("$this.BackgroundImage")));
            this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.ClientSize = new System.Drawing.Size(1084, 652);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.crv_factura);
            this.Controls.Add(this.btn_imprimir);
            this.Controls.Add(this.cmb_imprimir);
            this.Controls.Add(this.txt_facturaact);
            this.Controls.Add(this.txt_facturaant);
            this.Controls.Add(this.txt_categoria);
            this.Controls.Add(this.txt_direccion);
            this.Controls.Add(this.txt_municipio);
            this.Controls.Add(this.txt_dato);
            this.Controls.Add(this.shapeContainer1);
            this.DoubleBuffered = true;
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(1100, 691);
            this.MinimumSize = new System.Drawing.Size(1100, 691);
            this.Name = "LDFACTDUP";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "LDFACTDUP";
            this.panel1.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txt_dato;
        private System.Windows.Forms.TextBox txt_municipio;
        private System.Windows.Forms.TextBox txt_direccion;
        private System.Windows.Forms.TextBox txt_categoria;
        private System.Windows.Forms.TextBox txt_facturaant;
        private System.Windows.Forms.TextBox txt_facturaact;
        private System.Windows.Forms.ComboBox cmb_imprimir;
        private System.Windows.Forms.Button btn_imprimir;
        private Microsoft.VisualBasic.PowerPacks.ShapeContainer shapeContainer1;
        private Microsoft.VisualBasic.PowerPacks.OvalShape os_selcontrato;
        private Microsoft.VisualBasic.PowerPacks.OvalShape os_selcednit;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_buscar;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_0;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_limpiar;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_9;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_8;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_7;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_6;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_5;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_4;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_3;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_2;
        private Microsoft.VisualBasic.PowerPacks.RectangleShape rs_1;
        private CrystalDecisions.Windows.Forms.CrystalReportViewer crv_factura;
        private System.Windows.Forms.Label lbl_mensaje1;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label lbl_mensaje2;
        private System.Windows.Forms.Button button1;
    }
}