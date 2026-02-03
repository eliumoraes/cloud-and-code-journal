
using System.Collections.Concurrent;

namespace AsyncAwaitPractice.Library;

/// <summary>
/// Implementação de repositório que demonstrar ConfigureAwait(false) em biblioteca.
/// IMPORTANTE: Bibliotecas devem SEMPRE usar ConfigureAwait(false) para evitar deadlocks em aplicações que possuem contextos de sincronização (ex: UI, ASP.NET).
/// </summary>
public class ProdutoRepository : IRepository<Produto>
{
    private readonly ConcurrentDictionary<int, Produto> _produtos = new();

    /// <summary>
    /// Busca um produto por ID.
    /// Note ConfigureAwait(false) é usado porque esta é uma biblioteca.
    /// </summary>
    /// <param name="id"></param>
    /// <param name="cancellationToken"></param>
    /// <returns></returns>
    /// <exception cref="NotImplementedException"></exception>
    public async Task<Produto?> BuscarPorIdAsync(int id, CancellationToken cancellationToken = default)
    {
        await Task.Delay(100, cancellationToken).ConfigureAwait(false); // Simula operação assíncrona

        _produtos.TryGetValue(id, out var produto);
        return produto;
    }

    /// <summary>
    /// Busca todos os produtos.
    /// Note ConfigureAwait(false) é usado porque esta é uma biblioteca.
    /// </summary>    
    public async Task<IEnumerable<Produto>> BuscarTodosAsync(CancellationToken cancellationToken = default)
    {
        await Task.Delay(100, cancellationToken).ConfigureAwait(false); // Simula operação assíncrona
        return _produtos.Values.ToList();
    }

    /// <summary>
    /// Salva um produto.
    /// Note ConfigureAwait(false) é usado porque esta é uma biblioteca.
    /// </summary>
    public Task SalvarAsync(Produto entity, CancellationToken cancellationToken = default)
    {
        Task.Delay(100, cancellationToken).ConfigureAwait(false); // Simula operação assíncrona 
        _produtos.AddOrUpdate(entity.Id, entity, (key, oldValue) => entity);
        return Task.CompletedTask;
    }
    
}
