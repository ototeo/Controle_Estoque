using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Data;
namespace DAL
{
    public class Operacoes
    {
        private MySqlConnection connection = null;

        private void abreConexao()
        {
            if (this.connection.State == ConnectionState.Closed)
            {
                this.connection.Open();
            }
        }

        private void fechaConexao()
        {
            if (this.connection.State == ConnectionState.Open)
            {
                this.connection.Close();
            }
        }

        public Operacoes(MySqlConnection connection)
        {
            this.connection = connection;
        }

        public void insert()
        {
            this.abreConexao();

            this.fechaConexao();
        }
    }
}
