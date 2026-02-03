using AsyncAwaitPractice.Library;

namespace AsyncAwaitPractice.Services;

/// <summary>
/// SErviço de produtos que demonstra padrões assíncronos seguros.
/// Este é código de aplicação, não biblioteca, então ConfigureAwait(false) é opecional.
/// </summary>
public class ProdutoService : IProdutoService
{
    private readonly IRepository<Produto> _repository;

    /// <summary>
    /// Construtor que recebe dependência de repositório. (DI)
    /// </summary>
    /// <param name="repository"></param>
    /// <exception cref="ArgumentNullException"></exception>
    public ProdutoService(IRepository<Produto> repository)
    {
        _repository = repository ?? throw new ArgumentNullException(nameof(repository));
    }

    /// <summary>
    /// Busca um produto por ID.
    /// Se não encontrar, lança NotFoundException.
    /// </summary>
    /// <param name="id"></param>
    /// <param name="cancellationToken"></param>
    /// <returns></returns>
    /// <exception cref="NotImplementedException"></exception>
    public async Task<Produto> BuscarProdutoAsync(int id, CancellationToken cancellationToken = default)
    {
        var produto = await _repository.BuscarPorIdAsync(id, cancellationToken);

        if (produto == null)
        {
            throw new NotFoundException($"Produto com Id {id} não encontrado.");
        }

        return produto;
    }


    /// <summary>
    /// Busca todos os produtos.
    /// </summary>
    /// <param name="cancellationToken"></param>
    /// <returns></returns>
    /// <exception cref="NotImplementedException"></exception>
    public async Task<IEnumerable<Produto>> BuscarTodosProdutosAsync(CancellationToken cancellationToken = default)
    {
        return await _repository.BuscarTodosAsync(cancellationToken);
    }

    public async Task<Produto> CriarProdutoAsync(string nome, decimal preco, CancellationToken cancellationToken = default)
    {
        var produto = new Produto
        {
            Id = new Random().Next(1, 1000),
            Nome = nome,
            Preco = preco
        };

        await _repository.SalvarAsync(produto, cancellationToken);

        return produto;
    }
}