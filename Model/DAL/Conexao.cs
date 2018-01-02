using MySql.Data.MySqlClient;

namespace Model.DAL
{
    public class Conexao
    {
        MySqlConnection connection = new MySqlConnection("Server=localhost;Database=controle_estoque;Uid=root;Pwd=122333");

        public MySqlConnection getConexao()
        {
            return this.connection;
        }
    }
}
