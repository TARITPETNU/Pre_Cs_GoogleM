using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoogleMap
{
    public partial class _Default : Page
    {
        public  float bangrakLatitude { get; set; }
        public float bangrakLongitude { get; set; }

        public float bangkokjaiLatitude { get; set; }
        public float bangkokjaiLongitude { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Bang Rak
                foreach (DataTable table in MySqlConnection("Bang Rak").Tables)
                {
                    foreach (DataRow row in table.Rows)
                    {
                        bangrakLatitude = float.Parse(row["latitude"].ToString());
                        bangrakLongitude = float.Parse(row["longitude"].ToString());
                    }
                }
                //Bangkok Yai
                foreach (DataTable table in MySqlConnection("Bangkok Yai").Tables)
                {
                    foreach (DataRow row in table.Rows)
                    {
                        bangkokjaiLatitude = float.Parse(row["latitude"].ToString());
                        bangkokjaiLongitude = float.Parse(row["longitude"].ToString());
                    }
                }
            }
        }
        //https://www.c-sharpcorner.com/UploadFile/47548d/simple-insert-select-update-and-delete-in-Asp-Net-using-mysq/
        private DataSet MySqlConnection(String city)
        {
            string connectionString = @"Data Source=localhost; Database=bankok; User ID=root; Password=''";
            using (MySqlConnection connect = new MySqlConnection(connectionString))
            {
                    string command = "SELECT * FROM bankokmap WHERE Name = '"+city+"'";
                    MySqlCommand sqlCommand = new MySqlCommand(command, connect);
                    MySqlDataAdapter sqlDataAdapter = new MySqlDataAdapter(sqlCommand);
                    DataSet dataset = new DataSet();
                    sqlDataAdapter.Fill(dataset);
                    connect.Close();
                    return dataset;
            }
        }
    }
}