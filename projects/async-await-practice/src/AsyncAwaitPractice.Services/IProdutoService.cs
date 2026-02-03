using AsyncAwaitPractice.Library;

namespace AsyncAwaitPractice.Services;

/// <summary>
/// Interface do serviço de produtos.
/// </summary>
public interface IProdutoService
{
    Task<Produto> BuscarProdutoAsync(int id, CancellationToken cancellationToken = default);
    Task<Produto> CriarProdutoAsync(string nome, decimal preco, CancellationToken cancellationToken = default);
    Task<IEnumerable<Produto>> BuscarTodosProdutosAsync(CancellationToken cancellationToken = default);
}
