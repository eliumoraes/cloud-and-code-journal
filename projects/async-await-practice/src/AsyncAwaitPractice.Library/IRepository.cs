namespace AsyncAwaitPractice.Library;

/// <summary>
/// Interface de repositório genério para demonstrar padrões assíncronos.
/// </summary>
/// <typeparam name="T"></typeparam>
public interface IRepository<T>
{
    /// <summary>
    /// Busca uma entidade por seu ID de forma assíncrona.
    /// Obs: Recebe um CancellationToken para suportar cancelamento da operação.
    /// </summary>
    /// <param name="id"></param>
    /// <param name="cancellationToken"></param>
    /// <returns></returns>
    Task<T?> BuscarPorIdAsync(int id, CancellationToken cancellationToken = default);

    /// <summary>
    /// Salva uma entidade de forma assíncrona.
    /// </summary>
    /// <param name="entity"></param>
    /// <param name="cancellationToken"></param>
    /// <returns></returns>
    Task SalvarAsync(T entity, CancellationToken cancellationToken = default);

    /// <summary>
    /// Busca todas as entidades de forma assíncrona.
    /// </summary>
    /// <param name="cancellationToken"></param>
    /// <returns></returns>
    Task<IEnumerable<T>> BuscarTodosAsync(CancellationToken cancellationToken = default);
}