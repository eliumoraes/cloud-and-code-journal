using AsyncAwaitPractice.Library;
using AsyncAwaitPractice.Services;

namespace AsyncAwaitPractice.PresentationConsole;

class Program
{
    static async Task Main(string[] args)
    {
        Console.WriteLine("=== Demonstração de Async/Await ===");

        // Criar dependências
        var repository = new ProdutoRepository();
        var service = new ProdutoService(repository);

        // Exemplo 1: Criar produto
        Console.WriteLine("\nCriando um novo produto...");
        var produto = await service.CriarProdutoAsync("Notebook", 2500.00m);
        Console.WriteLine($"Produto criado: {produto.Nome} - R$ {produto.Preco:F2}\n");

        // Exemplo 2: Buscar produto
        Console.WriteLine("Buscando o produto criado...");
        var produtoBuscado = await service.BuscarProdutoAsync(produto.Id);
        Console.WriteLine($"Produto encontrado: {produtoBuscado.Nome}\n");

        // Exemplo 3: Buscar todos
        Console.WriteLine("Buscando todos os produtos...");
        var todos = await service.BuscarTodosProdutosAsync();
        Console.WriteLine($"Total de produtos: {todos.Count()}\n");

        Console.WriteLine("Demonstração concluída.");        
    }
}