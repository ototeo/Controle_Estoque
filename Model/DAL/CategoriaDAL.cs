using Model.Model;
using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Windows.Forms;

namespace Model.DAL
{
    public class CategoriaDAL
    {
        MySqlConnection conexao = null;

        public CategoriaDAL ()
        {
            Conexao conexao = new Conexao();
            this.conexao = conexao.getConexao();
        }

        private void open()
        {
            if (this.conexao.State == ConnectionState.Closed)
            {
                try
                {
                    this.conexao.Open();
                }
                catch (Exception e)
                {
                    throw new Exception("Erro em CategoriaDAL.open\n\nErro: " + e.Message);
                }
            }
        }

        private void close()
        {
            if (this.conexao.State == ConnectionState.Open)
            {
                this.conexao.Close();
            }
        }

        public void insert(Categoria categoria)
        {
            this.open();
            string sql = "INSERT INTO categoria (nome) VALUES @nome; SELECT LAST_INSERT_ID();";
            MySqlCommand query = new MySqlCommand();
            query.Connection = this.conexao;
            query.CommandText = sql;
            query.Parameters.AddWithValue("@nome", categoria.Nome);
            try
            {
                categoria.Id = Convert.ToInt32(query.ExecuteScalar());
                MessageBox.Show("Categoria inserida com sucesso.", "Sucesso...", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1);
            }
            catch (Exception e)
            {
                throw new Exception("Erro em CategoriaDAL.insert\n\nErro: " + e.Message);
            }
            finally
            {
                this.close();
            }
        }

        public void alterar(Categoria categoria)
        {
            this.open();
            string sql = "UPDATE categoria SET nome = @nome WHERE id = @id";
            MySqlCommand query = new MySqlCommand();
            query.Connection = this.conexao;
            query.CommandText = sql;
            query.Parameters.AddWithValue("@nome", categoria.Nome);
            query.Parameters.AddWithValue("@id", categoria.Id);
            try
            {
                if (query.ExecuteNonQuery() != 0)
                {
                    MessageBox.Show("Categoria alterada com sucesso.", "Sucesso...", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1);
                }
            }
            catch (Exception e)
            {
                throw new Exception("Erro em CategoriaDAL.alterar\n\nErro: " + e.Message);
            }
            finally
            {
                this.close();
            }
        }

        public void excluir(Categoria categoria)
        {
            this.open();
            MySqlCommand query = new MySqlCommand();
            string sql = "DELETE FROM categoria WHERE id = @id";
            query.Connection = this.conexao;
            query.CommandText = sql;
            query.Parameters.AddWithValue("@id", categoria.Id);
            try
            {
                if (query.ExecuteNonQuery() != 0)
                {
                    MessageBox.Show("Categoria deletada com sucesso", "Sucesso...", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1);
                }
            }
            catch (Exception e)
            {
                throw new Exception("Erro em CategoriaDAL.excluir\n\nErro: " + e.Message);
            }
            finally
            {
                this.close();
            }
        }

        public DataTable localizar(string valor)
        {
            this.open();
            DataTable table = new DataTable();
            string sql = "SELECT * FROM categoria WHERE nome LIKE '%" + valor + "%'";
            try
            {
                MySqlDataAdapter adapter = new MySqlDataAdapter(sql, this.conexao);
                adapter.Fill(table);
                return table;
            }
            catch (Exception e)
            {
                throw new Exception("Erro em CategoriaDAL.localizar\n\nErro: " + e.Message);
            }
            finally
            {
                this.close();
            }
            return null;
        }

        public Categoria carregaCategoria(int id)
        {
            this.open();
            MySqlCommand query = new MySqlCommand();
            string sql = "SELECT * FROM categoria WHERE id = @id";
            query.Connection = this.conexao;
            query.CommandText = sql;
            query.Parameters.AddWithValue("@id", id);
            Categoria categoria = new Categoria();
            try
            {
                MySqlDataReader reader = query.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    categoria.Id = Convert.ToInt32(reader["id"]);
                    categoria.Nome = reader["nome"].ToString();
                }
            }
            catch (Exception e)
            {
                throw new Exception("Erro em CategoriaDAL.carregaCategoria\n\nErro: " + e.Message);
            }
            finally
            {
                this.close();
            }
            return categoria;
        }
    }
}
