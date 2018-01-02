using Model.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Model
{
    public class Categoria
    {
        private CategoriaDAL categoriaDAL;

        public Categoria()
        {
            this.categoriaDAL = new CategoriaDAL();
        }

        private int id = 0;
        private string nome = "";

        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        public string Nome
        {
            get { return this.nome; }
            set { this.nome = value; }
        }

        private bool validaCategoria(Categoria categoria)
        {
            if (categoria.Nome.Trim().Length != 0)
            {
                return true;
            }
            else
            {
                throw new Exception("O nome da categoria é obrigatório");
            }
        }

        public void insert(Categoria categoria)
        {
            if (this.validaCategoria(categoria))
                this.categoriaDAL.insert(categoria);
        }

        public void alterar(Categoria categoria)
        {
            if (this.validaCategoria(categoria))
                this.categoriaDAL.alterar(categoria);
        }

        public void excluir(Categoria categoria)
        {
            this.categoriaDAL.excluir(categoria);
        }

        public DataTable localizar(string valor)
        {
            if (valor.Trim().Length != 0)
                return this.categoriaDAL.localizar(valor);
            else
                throw new Exception("Digite um valor para ser pesquisado");
        }

        public Categoria carregaCategoria(int id)
        {
            if (id.ToString().Trim().Length != 0)
                return this.categoriaDAL.carregaCategoria(id);
            else
                throw new Exception("Digite um id para ser pesquisado");
        }
    }
}