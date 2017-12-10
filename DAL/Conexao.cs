using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class Conexao
    {
        MySqlConnection connection = new MySqlConnection("Server=localhost;Database=controle_estoque;Uid=root;Pwd=122333");
    }
}
