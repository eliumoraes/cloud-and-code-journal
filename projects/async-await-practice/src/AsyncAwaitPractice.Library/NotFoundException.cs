namespace AsyncAwaitPractice.Library;

/// <summary>
/// Exceção customizada para quando entidade não é encontrada.
/// </summary>
public class NotFoundException : Exception
{
    public NotFoundException(string message) : base(message) { }
}