using AsyncAwaitPractice.Library;
using AsyncAwaitPractice.Services;
using Moq;
using Xunit;

namespace AsyncAwaitPractice.Tests;

public class ProdutoServicesTests
{

    [Fact]
    public async Task BuscarProdutoAsync_QuandoExiste_DeveRetornarProduto()
    {
        // Arrange - Configurar mock para quando chamar BuscarPorIdAsync com 1, retorne produto
        var mockRepository = new Mock<IRepository<Produto>>();
        var produtoEsperado = new Produto { Id = 1, Nome = "Produto Teste", Preco = 100.00m };

        mockRepository
            .Setup(_repository => _repository.BuscarPorIdAsync(1, It.IsAny<CancellationToken>()))
            .ReturnsAsync(produtoEsperado);

        var service = new ProdutoService(mockRepository.Object);

        // Act - Executar método assíncrono com await
        var resultado = await service.BuscarProdutoAsync(1);

        // Assert - verificar resultado e que método foi chamado
        Assert.NotNull(resultado);
        Assert.Equal(produtoEsperado.Nome, resultado.Nome);
        Assert.Equal(produtoEsperado.Preco, resultado.Preco);

        // Verificar que o método BuscarPorIdAsync foi chamado exatamente 1 vez com id 1
        mockRepository.Verify(_repository => _repository.BuscarPorIdAsync(1, It.IsAny<CancellationToken>()), Times.Once);    
    }

    [Fact]
    public async Task BuscarProdutoAsync_QuandoNaoExiste_DeveLancarNotFoundException()
    {
        var mockRepository = new Mock<IRepository<Produto>>();
        mockRepository
            .Setup(_repository => _repository.BuscarPorIdAsync(It.IsAny<int>(), It.IsAny<CancellationToken>()))
            .ThrowsAsync(new NotFoundException("Produto não encontrado."));

        var service = new ProdutoService(mockRepository.Object);

        // Act & Assert - Verificar se a exceção é lançada ao chamar o método
        var excessaoMensagem = await Assert.ThrowsAsync<NotFoundException>(async () => await service.BuscarProdutoAsync(999));

        Assert.Contains("Produto não encontrado.", excessaoMensagem.Message);
    }

    [Fact]
    public async Task BuscarTodosProdutosAsync_DeveRetornarListaDeProdutos()
    {
        // Arrange - Preparar lista de produtos
        IEnumerable<Produto> produtos = new List<Produto> 
        {
            new Produto { Id = 1, Nome = "Caneta", Preco = 0.50m },
            new Produto { Id = 2, Nome = "Lápis", Preco = 0.80m },
            new Produto { Id = 3, Nome = "Caderno", Preco = 10.00m },
            new Produto { Id = 4, Nome = "Mochila", Preco = 55.00m }
        };

        var mockRepository = new Mock<IRepository<Produto>>();
        mockRepository
            .Setup(_repository => _repository.BuscarTodosAsync(It.IsAny<CancellationToken>()))
            .ReturnsAsync(produtos);

        var service = new ProdutoService(mockRepository.Object);

        // Act - Executar métodos
        var resultado = await service.BuscarTodosProdutosAsync();

        // Assert
        Assert.True(resultado.Count() > 0);
        Assert.IsAssignableFrom<IEnumerable<Produto>>(resultado);
        Assert.Contains(resultado, p => p.Nome == "Caneta");
    }

    [Fact]
    public async Task BuscarTodosProdutosAsync_DeveRetornarListaVazia()
    {
        // Arrange - Preparar lista
        IEnumerable<Produto> produtos = new List<Produto>();

        var mockRepository = new Mock<IRepository<Produto>>();
        mockRepository
            .Setup(_repositoryDependency => _repositoryDependency.BuscarTodosAsync(It.IsAny<CancellationToken>()))
            .ReturnsAsync(produtos);
        
        var service = new ProdutoService(mockRepository.Object);

        // Act - Executar métodos
        var resultado = await service.BuscarTodosProdutosAsync();

        // Assert
        Assert.True(resultado.Count() == 0);
        Assert.Empty(resultado);
    }
}
