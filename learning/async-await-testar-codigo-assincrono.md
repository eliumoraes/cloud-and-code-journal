# Como Testar Código Assíncrono em .NET

**Data de Criação**: 2025-11-28  
**Última Atualização**: 2025-11-28

## 🎯 Objetivo

Aprender como escrever testes unitários para código assíncrono, incluindo mocking de operações assíncronas, testes de timeout e cancelamento.

---

## 🤔 Por que Testar Código Assíncrono é Diferente?

### Desafios Específicos

1. **Métodos retornam Task/Task<T>**: Não pode apenas chamar e verificar resultado
2. **Operações assíncronas**: Precisam ser aguardadas corretamente
3. **Mocking assíncrono**: Mocks precisam retornar Tasks
4. **Timeout e cancelamento**: Testar cenários de erro específicos
5. **Deadlocks em testes**: Pode acontecer se não usar await corretamente

---

## ✅ Fundamentos: Testar Métodos Assíncronos

### Regra de Ouro: SEMPRE usar `await` em testes assíncronos

```csharp
// ❌ ERRADO - Não usar .Result em testes
[Fact]
public void TesteErrado()
{
    var resultado = MetodoAsync().Result; // 💀 Pode causar deadlock
    Assert.Equal("esperado", resultado);
}

// ✅ CORRETO - Usar await
[Fact]
public async Task TesteCorreto()
{
    var resultado = await MetodoAsync();
    Assert.Equal("esperado", resultado);
}
```

### Estrutura Básica de Teste Assíncrono

```csharp
using Xunit;

public class MeuServicoTests
{
    [Fact]
    public async Task BuscarDadosAsync_DeveRetornarDados()
    {
        // Arrange
        var servico = new MeuServico();
        
        // Act
        var resultado = await servico.BuscarDadosAsync();
        
        // Assert
        Assert.NotNull(resultado);
        Assert.Equal("dados esperados", resultado);
    }
}
```

**Pontos importantes:**
- Método de teste deve ser `async Task` (não `async void`)
- Sempre usar `await` ao chamar métodos assíncronos
- Xunit suporta testes assíncronos nativamente

---

## 🔧 Mocking de Operações Assíncronas

### Mocking com Moq

#### Exemplo 1: Mock Simples

```csharp
using Moq;
using Xunit;

public class ProdutoServiceTests
{
    [Fact]
    public async Task BuscarProdutoAsync_DeveRetornarProduto()
    {
        // Arrange
        var mockRepository = new Mock<IProdutoRepository>();
        var produtoEsperado = new Produto { Id = 1, Nome = "Produto 1" };
        
        // Configurar mock para retornar Task
        mockRepository
            .Setup(x => x.BuscarPorIdAsync(1))
            .ReturnsAsync(produtoEsperado); // ✅ ReturnsAsync para métodos async
        
        var service = new ProdutoService(mockRepository.Object);
        
        // Act
        var resultado = await service.BuscarProdutoAsync(1);
        
        // Assert
        Assert.NotNull(resultado);
        Assert.Equal("Produto 1", resultado.Nome);
        mockRepository.Verify(x => x.BuscarPorIdAsync(1), Times.Once);
    }
}
```

#### Exemplo 2: Mock com Exceção

```csharp
[Fact]
public async Task BuscarProdutoAsync_DeveLancarExcecaoQuandoNaoEncontrado()
{
    // Arrange
    var mockRepository = new Mock<IProdutoRepository>();
    
    mockRepository
        .Setup(x => x.BuscarPorIdAsync(999))
        .ThrowsAsync(new NotFoundException("Produto não encontrado")); // ✅ ThrowsAsync
    
    var service = new ProdutoService(mockRepository.Object);
    
    // Act & Assert
    await Assert.ThrowsAsync<NotFoundException>(
        () => service.BuscarProdutoAsync(999)
    );
}
```

#### Exemplo 3: Mock com Diferentes Retornos

```csharp
[Fact]
public async Task ProcessarAsync_DeveProcessarCorretamente()
{
    // Arrange
    var mockHttpClient = new Mock<IHttpClient>();
    
    // Primeira chamada retorna dados, segunda retorna vazio
    mockHttpClient
        .SetupSequence(x => x.GetStringAsync(It.IsAny<string>()))
        .ReturnsAsync("dados 1")
        .ReturnsAsync("dados 2");
    
    var service = new MeuServico(mockHttpClient.Object);
    
    // Act
    var resultado1 = await service.BuscarAsync("url1");
    var resultado2 = await service.BuscarAsync("url2");
    
    // Assert
    Assert.Equal("dados 1", resultado1);
    Assert.Equal("dados 2", resultado2);
}
```

### Métodos do Moq para Async

| Método | Quando Usar |
|--------|-------------|
| `ReturnsAsync(value)` | Mock retorna Task com valor |
| `ThrowsAsync(exception)` | Mock lança exceção assíncrona |
| `Returns(Task.FromResult(value))` | Alternativa ao ReturnsAsync |
| `Returns(Task.CompletedTask)` | Para métodos `Task` (sem retorno) |

---

## ⏱️ Testar Timeout e Cancelamento

### Testar Timeout

```csharp
[Fact]
public async Task ProcessarAsync_DeveLancarTimeoutException()
{
    // Arrange
    var mockService = new Mock<IServico>();
    
    // Simular operação que demora muito
    mockService
        .Setup(x => x.ProcessarAsync(It.IsAny<CancellationToken>()))
        .Returns(async (CancellationToken ct) =>
        {
            await Task.Delay(5000, ct); // Simula operação longa
            return "resultado";
        });
    
    var service = mockService.Object;
    using var cts = new CancellationTokenSource(TimeSpan.FromMilliseconds(100));
    
    // Act & Assert
    await Assert.ThrowsAsync<TaskCanceledException>(
        () => service.ProcessarAsync(cts.Token)
    );
}
```

### Testar Cancelamento

```csharp
[Fact]
public async Task ProcessarAsync_DeveRespeitarCancellationToken()
{
    // Arrange
    var mockService = new Mock<IServico>();
    var cancelado = false;
    
    mockService
        .Setup(x => x.ProcessarAsync(It.IsAny<CancellationToken>()))
        .Returns(async (CancellationToken ct) =>
        {
            try
            {
                await Task.Delay(1000, ct);
            }
            catch (OperationCanceledException)
            {
                cancelado = true;
                throw;
            }
            return "resultado";
        });
    
    var service = mockService.Object;
    using var cts = new CancellationTokenSource();
    cts.CancelAfter(100);
    
    // Act
    try
    {
        await service.ProcessarAsync(cts.Token);
    }
    catch (OperationCanceledException)
    {
        // Esperado
    }
    
    // Assert
    Assert.True(cancelado);
}
```

---

## 🔄 Testar Múltiplas Tasks (Paralelismo)

### Testar Task.WhenAll

```csharp
[Fact]
public async Task ProcessarMultiplosAsync_DeveProcessarTodos()
{
    // Arrange
    var mockService = new Mock<IServico>();
    var chamadas = new List<int>();
    
    mockService
        .Setup(x => x.ProcessarAsync(It.IsAny<int>()))
        .ReturnsAsync((int id) =>
        {
            chamadas.Add(id);
            return $"resultado-{id}";
        });
    
    var service = mockService.Object;
    
    // Act
    var tasks = new[]
    {
        service.ProcessarAsync(1),
        service.ProcessarAsync(2),
        service.ProcessarAsync(3)
    };
    
    var resultados = await Task.WhenAll(tasks);
    
    // Assert
    Assert.Equal(3, chamadas.Count);
    Assert.Equal(3, resultados.Length);
    Assert.Contains("resultado-1", resultados);
    Assert.Contains("resultado-2", resultados);
    Assert.Contains("resultado-3", resultados);
}
```

### Testar Task.WhenAny

```csharp
[Fact]
public async Task ProcessarAsync_DeveRetornarPrimeiroCompletado()
{
    // Arrange
    var mockService = new Mock<IServico>();
    
    mockService
        .Setup(x => x.ProcessarAsync(1))
        .ReturnsAsync("rápido", TimeSpan.FromMilliseconds(100));
    
    mockService
        .Setup(x => x.ProcessarAsync(2))
        .ReturnsAsync("lento", TimeSpan.FromMilliseconds(1000));
    
    var service = mockService.Object;
    
    // Act
    var tasks = new[]
    {
        service.ProcessarAsync(1),
        service.ProcessarAsync(2)
    };
    
    var primeiraCompletada = await Task.WhenAny(tasks);
    var resultado = await primeiraCompletada;
    
    // Assert
    Assert.Equal("rápido", resultado);
}
```

---

## 🎯 Testar ConfigureAwait(false)

### Verificar que ConfigureAwait foi Usado

```csharp
[Fact]
public async Task BuscarDadosAsync_DeveUsarConfigureAwaitFalse()
{
    // Arrange
    var mockHttpClient = new Mock<IHttpClient>();
    mockHttpClient
        .Setup(x => x.GetStringAsync(It.IsAny<string>()))
        .ReturnsAsync("dados");
    
    var service = new MeuServico(mockHttpClient.Object);
    
    // Act
    var resultado = await service.BuscarDadosAsync();
    
    // Assert
    Assert.NotNull(resultado);
    // Nota: Não há forma direta de verificar ConfigureAwait em runtime
    // Mas o teste garante que o método funciona corretamente
}
```

**Nota**: Não é possível verificar diretamente se `ConfigureAwait(false)` foi usado em runtime. O importante é testar que o método funciona corretamente.

---

## ⚠️ Armadilhas Comuns em Testes Assíncronos

### Armadilha 1: Esquecer await

```csharp
// ❌ ERRADO
[Fact]
public void TesteErrado()
{
    var resultado = MetodoAsync().Result; // 💀 Pode causar deadlock
    Assert.Equal("esperado", resultado);
}

// ✅ CORRETO
[Fact]
public async Task TesteCorreto()
{
    var resultado = await MetodoAsync();
    Assert.Equal("esperado", resultado);
}
```

### Armadilha 2: Mock sem ReturnsAsync

```csharp
// ❌ ERRADO
mockService
    .Setup(x => x.BuscarAsync())
    .Returns("dados"); // 💀 Erro: método retorna Task<string>, não string

// ✅ CORRETO
mockService
    .Setup(x => x.BuscarAsync())
    .ReturnsAsync("dados"); // ✅ Retorna Task<string>
```

### Armadilha 3: Teste async void

```csharp
// ❌ ERRADO
[Fact]
public async void TesteErrado() // 💀 async void em testes
{
    await MetodoAsync();
}

// ✅ CORRETO
[Fact]
public async Task TesteCorreto() // ✅ async Task
{
    await MetodoAsync();
}
```

**Veja seção detalhada abaixo**: "Por que async void é Problemático?"

### Armadilha 4: Não aguardar Assert.ThrowsAsync

```csharp
// ❌ ERRADO
[Fact]
public void TesteErrado()
{
    Assert.ThrowsAsync<Exception>(() => MetodoAsync()); // 💀 Não aguarda
}

// ✅ CORRETO
[Fact]
public async Task TesteCorreto()
{
    await Assert.ThrowsAsync<Exception>(() => MetodoAsync()); // ✅ Aguarda
}
```

---

## 📊 Exemplos Práticos Completos

### Exemplo 1: Teste de Service com Repository

```csharp
public class ProdutoServiceTests
{
    private readonly Mock<IProdutoRepository> _mockRepository;
    private readonly ProdutoService _service;
    
    public ProdutoServiceTests()
    {
        _mockRepository = new Mock<IProdutoRepository>();
        _service = new ProdutoService(_mockRepository.Object);
    }
    
    [Fact]
    public async Task BuscarProdutoAsync_QuandoExiste_DeveRetornarProduto()
    {
        // Arrange
        var produto = new Produto { Id = 1, Nome = "Produto 1", Preco = 100 };
        _mockRepository
            .Setup(x => x.BuscarPorIdAsync(1))
            .ReturnsAsync(produto);
        
        // Act
        var resultado = await _service.BuscarProdutoAsync(1);
        
        // Assert
        Assert.NotNull(resultado);
        Assert.Equal("Produto 1", resultado.Nome);
        Assert.Equal(100, resultado.Preco);
        _mockRepository.Verify(x => x.BuscarPorIdAsync(1), Times.Once);
    }
    
    [Fact]
    public async Task BuscarProdutoAsync_QuandoNaoExiste_DeveLancarExcecao()
    {
        // Arrange
        _mockRepository
            .Setup(x => x.BuscarPorIdAsync(999))
            .ReturnsAsync((Produto)null);
        
        // Act & Assert
        await Assert.ThrowsAsync<NotFoundException>(
            () => _service.BuscarProdutoAsync(999)
        );
    }
}
```

### Exemplo 2: Teste com HttpClient Mock

```csharp
public class ApiClientTests
{
    [Fact]
    public async Task BuscarDadosAsync_DeveRetornarDados()
    {
        // Arrange
        var mockHttpClient = new Mock<HttpClient>();
        var mockHandler = new Mock<HttpMessageHandler>();
        
        mockHandler
            .Protected()  // ← Acessa membros protegidos
            .Setup<Task<HttpResponseMessage>>(
                "SendAsync",
                ItExpr.IsAny<HttpRequestMessage>(),
                ItExpr.IsAny<CancellationToken>()
            )
            .ReturnsAsync(new HttpResponseMessage
            {
                StatusCode = HttpStatusCode.OK,
                Content = new StringContent("{\"dados\": \"teste\"}")
            });
        
        var httpClient = new HttpClient(mockHandler.Object);
        var apiClient = new ApiClient(httpClient);
        
        // Act
        var resultado = await apiClient.BuscarDadosAsync("https://api.com");
        
        // Assert
        Assert.NotNull(resultado);
        Assert.Contains("teste", resultado);
    }
}
```

**Veja seção detalhada abaixo**: "O que é Protected() no Moq?"

### Exemplo 3: Teste de Integração Assíncrono

```csharp
public class IntegracaoTests : IClassFixture<TestFixture>
{
    private readonly TestFixture _fixture;
    
    public IntegracaoTests(TestFixture fixture)
    {
        _fixture = fixture;
    }
    
    [Fact]
    public async Task ProcessarAsync_DeveProcessarCorretamente()
    {
        // Arrange
        var service = _fixture.GetService<MeuServico>();
        
        // Act
        var resultado = await service.ProcessarAsync();
        
        // Assert
        Assert.NotNull(resultado);
        Assert.True(resultado.Sucesso);
    }
}
```

**Veja seção detalhada abaixo**: "O que é Fixture?"

---

## 🎯 Padrões de Teste Assíncrono

### Padrão 1: Teste Simples com await

```csharp
[Fact]
public async Task MetodoAsync_DeveRetornarResultadoEsperado()
{
    // Arrange
    var servico = new MeuServico();
    
    // Act
    var resultado = await servico.MetodoAsync();
    
    // Assert
    Assert.Equal("esperado", resultado);
}
```

### Padrão 2: Teste com Mock Assíncrono

```csharp
[Fact]
public async Task MetodoAsync_DeveChamarDependenciaCorretamente()
{
    // Arrange
    var mockDependencia = new Mock<IDependencia>();
    mockDependencia
        .Setup(x => x.BuscarAsync())
        .ReturnsAsync("dados");
    
    var servico = new MeuServico(mockDependencia.Object);
    
    // Act
    var resultado = await servico.MetodoAsync();
    
    // Assert
    mockDependencia.Verify(x => x.BuscarAsync(), Times.Once);
}
```

**Veja seção detalhada abaixo**: "O que está Acontecendo no Teste com Mock? (Dependency Injection)"

### Padrão 3: Teste de Exceção Assíncrona

```csharp
[Fact]
public async Task MetodoAsync_QuandoErro_DeveLancarExcecao()
{
    // Arrange
    var mockService = new Mock<IServico>();
    mockService
        .Setup(x => x.ProcessarAsync())
        .ThrowsAsync(new InvalidOperationException("Erro"));
    
    var servico = mockService.Object;
    
    // Act & Assert
    var excecao = await Assert.ThrowsAsync<InvalidOperationException>(
        () => servico.ProcessarAsync()
    );
    
    Assert.Equal("Erro", excecao.Message);
}
```

**Veja seção detalhada abaixo**: "O que é ThrowsAsync? (Moq e xUnit)"

---

## 📋 Checklist: Escrever Testes Assíncronos

Antes de escrever um teste assíncrono, verifique:

- [ ] Método de teste é `async Task` (não `async void`)
- [ ] Uso `await` ao chamar métodos assíncronos
- [ ] Mocks usam `ReturnsAsync` ou `ThrowsAsync`
- [ ] `Assert.ThrowsAsync` é aguardado com `await`
- [ ] Não uso `.Result` ou `.Wait()` em testes
- [ ] Testo cenários de timeout e cancelamento quando relevante
- [ ] Verifico que mocks foram chamados corretamente

---

## 🎯 Resumo

### Regras de Ouro para Testes Assíncronos

1. **Sempre `async Task`**: Métodos de teste devem ser `async Task`, nunca `async void`
2. **Sempre `await`**: Use `await` ao chamar métodos assíncronos
3. **Mocking assíncrono**: Use `ReturnsAsync` e `ThrowsAsync` do Moq
4. **Exceções assíncronas**: Use `await Assert.ThrowsAsync<T>()`
5. **Nunca `.Result`**: Não use `.Result` ou `.Wait()` em testes

### Ferramentas

- **Xunit**: Suporta testes assíncronos nativamente
- **Moq**: `ReturnsAsync` e `ThrowsAsync` para mocks assíncronos
- **FluentAssertions**: Biblioteca alternativa com suporte a async

---

## 📚 Próximos Passos

Agora que entendemos como testar código assíncrono, podemos:
- Criar exemplos práticos de testes
- Aprofundar em testes de integração assíncronos
- Explorar ferramentas avançadas de teste

---

## 🔤 Expressões Lambda (Lambda Expressions)

### 🤔 O que são Expressões Lambda?

**Expressões Lambda** (ou **Lambda Expressions**) são funções anônimas em C# que permitem escrever código mais conciso. Em JavaScript são chamadas de **arrow functions**.

### 📝 Sintaxe Básica

```csharp
// Expressão lambda simples
x => x.ProcessarAsync()

// Com parâmetros
(x, y) => x + y

// Com corpo (múltiplas linhas)
x => {
    var resultado = x.Processar();
    return resultado;
}
```

### 🎯 Uso em Testes (Moq)

Expressões lambda são muito usadas em testes com Moq:

```csharp
// Setup com expressão lambda
mockService
    .Setup(x => x.ProcessarAsync())  // ← Expressão lambda
    .ReturnsAsync("resultado");

// Verify com expressão lambda
mockService.Verify(x => x.ProcessarAsync(), Times.Once);  // ← Expressão lambda

// It.IsAny com expressão lambda
mockService
    .Setup(x => x.ProcessarAsync(It.IsAny<string>()))  // ← Expressão lambda
    .ReturnsAsync("resultado");
```

### 🗣️ Como Ler/Falar Expressões Lambda

#### Em Português

**Forma 1: Literal**
```
x => x.ProcessarAsync()
```
"x seta x ponto ProcessarAsync"

**Forma 2: Descritiva (Recomendada)**
```
x => x.ProcessarAsync()
```
"Para cada x, chama x ponto ProcessarAsync"  
ou  
"x tal que chama ProcessarAsync de x"

**Forma 3: Em Contexto de Moq**
```
mockService.Setup(x => x.ProcessarAsync())
```
"Mock service ponto Setup de x tal que chama ProcessarAsync de x"  
ou  
"Configurar mock para que quando chamar ProcessarAsync, retorne..."

#### Em Inglês

**Forma 1: Literal**
```
x => x.ProcessarAsync()
```
"x arrow x dot ProcessarAsync"

**Forma 2: Descritiva (Recomendada)**
```
x => x.ProcessarAsync()
```
"For each x, call x dot ProcessarAsync"  
ou  
"x such that calls ProcessarAsync of x"

**Forma 3: Em Contexto de Moq**
```
mockService.Setup(x => x.ProcessarAsync())
```
"Mock service dot Setup of x such that calls ProcessarAsync of x"  
ou  
"Setup mock so that when ProcessarAsync is called, return..."

### 📚 Exemplos de Leitura

#### Exemplo 1: Setup Simples

```csharp
mockService.Setup(x => x.BuscarAsync(1))
```

**Português:**
- "Mock service ponto Setup de x tal que chama BuscarAsync de x com parâmetro 1"
- "Configurar mock para que quando chamar BuscarAsync com 1, retorne..."

**Inglês:**
- "Mock service dot Setup of x such that calls BuscarAsync of x with parameter 1"
- "Setup mock so that when BuscarAsync is called with 1, return..."

#### Exemplo 2: Com It.IsAny

```csharp
mockService.Setup(x => x.ProcessarAsync(It.IsAny<string>()))
```

**Português:**
- "Mock service ponto Setup de x tal que chama ProcessarAsync de x com qualquer string"
- "Configurar mock para que quando chamar ProcessarAsync com qualquer string, retorne..."

**Inglês:**
- "Mock service dot Setup of x such that calls ProcessarAsync of x with any string"
- "Setup mock so that when ProcessarAsync is called with any string, return..."

#### Exemplo 3: Verify

```csharp
mockService.Verify(x => x.BuscarAsync(1), Times.Once)
```

**Português:**
- "Mock service ponto Verify de x tal que chama BuscarAsync de x com 1, uma vez"
- "Verificar que BuscarAsync foi chamado com 1 uma vez"

**Inglês:**
- "Mock service dot Verify of x such that calls BuscarAsync of x with 1, once"
- "Verify that BuscarAsync was called with 1 once"

### 🎯 Dicas para Explicar

**Ao explicar para alguém:**

1. **Comece pelo contexto**: "Estamos configurando um mock..."
2. **Explique a sintaxe**: "O `x =>` significa 'para cada x' ou 'x tal que'"
3. **Descreva a ação**: "...chama o método ProcessarAsync de x"
4. **Complete o sentido**: "...e retorna um valor mockado"

**Exemplo completo:**
> "Estamos configurando um mock do serviço. A expressão `x => x.ProcessarAsync()` significa: para cada x (que é o serviço), chama o método ProcessarAsync. E então configuramos que quando esse método for chamado, deve retornar 'resultado'."

### 📊 Comparação: JavaScript vs C#

| JavaScript | C# | Pronúncia |
|------------|-----|------------|
| Arrow function | Lambda expression | "Lambda expression" |
| `x => x.processar()` | `x => x.Processar()` | "x arrow x dot Processar" |
| `(x, y) => x + y` | `(x, y) => x + y` | "x y arrow x plus y" |

### 🔑 Pontos-Chave

- **Nome em C#**: Expressão Lambda (Lambda Expression)
- **Símbolo**: `=>` (seta ou arrow)
- **Lado esquerdo**: Parâmetros (`x` ou `(x, y)`)
- **Lado direito**: Corpo da função (expressão ou bloco)
- **Uso comum**: Moq, LINQ, delegates, eventos

---

## 🔍 Por que async void é Problemático?

### 🤔 Pergunta: "Por que não usar async void em testes? Qual a diferença entre async void e async Task?"

### 📚 Diferenças Fundamentais

#### async Task

```csharp
public async Task ProcessarAsync()
{
    await MetodoAsync();
}
```

**Características:**
- ✅ Retorna `Task` (pode ser aguardado)
- ✅ Pode usar `await` para aguardar
- ✅ Exceções são capturadas na Task
- ✅ Framework de teste pode aguardar conclusão
- ✅ Pode verificar se completou com sucesso

#### async void

```csharp
public async void Processar()
{
    await MetodoAsync();
}
```

**Características:**
- ❌ Não retorna nada (void)
- ❌ **NÃO pode ser aguardado** (não há Task para aguardar)
- ❌ Exceções podem não ser capturadas
- ❌ Framework de teste **não pode aguardar** conclusão
- ❌ Teste pode passar mesmo se houver erro

### 🎬 Analogia: async Task vs async void

**async Task = Promessa com Ticket**
```
Você: "Vou processar e te dou um ticket"
Framework: "Ok, vou aguardar o ticket ser completado"
[Processa...]
Framework: "Ticket completo! Verifico resultado"
```

**async void = Promessa sem Ticket**
```
Você: "Vou processar" (sem ticket)
Framework: "Ok... mas como vou saber quando terminar?"
[Processa...]
Framework: "Não sei se terminou, não tenho como aguardar"
```

### 💻 Exemplo do Problema

#### Com async Task (Correto)

```csharp
[Fact]
public async Task TesteCorreto()
{
    // Arrange
    var service = new MeuServico();
    
    // Act
    var resultado = await service.ProcessarAsync();
    
    // Assert
    Assert.Equal("esperado", resultado);
    // ✅ Framework aguarda Task completar antes de verificar
}
```

**O que acontece:**
1. Framework inicia o teste
2. Framework aguarda a Task completar
3. Framework verifica o resultado
4. ✅ Teste passa ou falha corretamente

#### Com async void (Problemático)

```csharp
[Fact]
public async void TesteErrado()
{
    // Arrange
    var service = new MeuServico();
    
    // Act
    var resultado = await service.ProcessarAsync();
    
    // Assert
    Assert.Equal("esperado", resultado);
    // ❌ Framework NÃO aguarda - pode verificar antes de completar!
}
```

**O que acontece:**
1. Framework inicia o teste
2. Framework **não pode aguardar** (não há Task)
3. Framework pode verificar **antes** de completar
4. ❌ Teste pode passar mesmo com erro
5. ❌ Exceções podem não ser capturadas

### ⚠️ Problemas Específicos com async void

#### Problema 1: Exceções Não Capturadas

```csharp
// ❌ PROBLEMÁTICO
[Fact]
public async void TesteErrado()
{
    await MetodoQueLancaExcecaoAsync();
    // ❌ Exceção pode não ser capturada pelo framework
    // ❌ Teste pode passar mesmo com erro!
}

// ✅ CORRETO
[Fact]
public async Task TesteCorreto()
{
    await Assert.ThrowsAsync<Exception>(
        () => MetodoQueLancaExcecaoAsync()
    );
    // ✅ Exceção é capturada e verificada
}
```

#### Problema 2: Teste Pode Passar Antes de Completar

```csharp
// ❌ PROBLEMÁTICO
[Fact]
public async void TesteErrado()
{
    var resultado = await ProcessarAsync(); // Pode demorar 5 segundos
    Assert.Equal("esperado", resultado);
    // ❌ Framework pode verificar ANTES de completar
    // ❌ Teste pode passar incorretamente
}

// ✅ CORRETO
[Fact]
public async Task TesteCorreto()
{
    var resultado = await ProcessarAsync(); // Pode demorar 5 segundos
    Assert.Equal("esperado", resultado);
    // ✅ Framework aguarda Task completar antes de verificar
}
```

#### Problema 3: Framework Não Pode Aguardar

```csharp
// ❌ PROBLEMÁTICO
[Fact]
public async void TesteErrado()
{
    await MetodoAsync();
    // Framework não sabe quando terminar
    // Pode executar próximo teste antes deste terminar
}

// ✅ CORRETO
[Fact]
public async Task TesteCorreto()
{
    await MetodoAsync();
    // Framework aguarda Task completar
    // Só executa próximo teste após este terminar
}
```

### 🎯 Quando async void é Aceitável?

**async void é aceitável APENAS em event handlers:**

```csharp
// ✅ ACEITÁVEL - Event handler
private async void Button_Click(object sender, EventArgs e)
{
    await ProcessarAsync();
    // Event handlers podem ser async void
    // Porque não há como aguardar um event handler
}
```

**Por quê?**
- Event handlers não retornam valores
- Não há como aguardar um event handler
- É a única exceção aceitável

**⚠️ IMPORTANTE**: Mesmo em event handlers, exceções podem não ser capturadas. Use try-catch:

```csharp
// ✅ MELHOR PRÁTICA - Event handler com tratamento de erro
private async void Button_Click(object sender, EventArgs e)
{
    try
    {
        await ProcessarAsync();
    }
    catch (Exception ex)
    {
        // Tratar erro
        MessageBox.Show($"Erro: {ex.Message}");
    }
}
```

### 📊 Comparação Visual

| Característica | async Task | async void |
|---------------|------------|------------|
| **Retorna** | Task | Nada (void) |
| **Pode aguardar?** | ✅ Sim | ❌ Não |
| **Exceções capturadas?** | ✅ Sim | ❌ Pode não ser |
| **Framework aguarda?** | ✅ Sim | ❌ Não |
| **Uso em testes** | ✅ Correto | ❌ Problemático |
| **Uso em event handlers** | ❌ Não funciona | ✅ Aceitável |
| **Uso em métodos normais** | ✅ Sempre | ❌ Nunca |

### 🔑 Regras de Ouro

1. **Em testes**: ✅ **SEMPRE** `async Task`, nunca `async void`
2. **Em métodos normais**: ✅ **SEMPRE** `async Task`, nunca `async void`
3. **Em event handlers**: ⚠️ `async void` é aceitável (única exceção)
4. **Em event handlers**: ✅ Use try-catch para capturar exceções

### 💡 Por que async void Existe?

**async void existe apenas para event handlers:**

- Event handlers têm assinatura fixa: `void NomeEvento(object sender, EventArgs e)`
- Não podem retornar Task
- Mas podem precisar fazer operações assíncronas
- Por isso `async void` foi criado

**Mas:**
- ❌ Não use em testes
- ❌ Não use em métodos normais
- ✅ Use apenas em event handlers (e com cuidado)

### 🎯 Resumo

**async Task:**
- ✅ Retorna Task (pode ser aguardado)
- ✅ Framework de teste aguarda conclusão
- ✅ Exceções são capturadas
- ✅ **SEMPRE use em testes**

**async void:**
- ❌ Não retorna nada (não pode ser aguardado)
- ❌ Framework de teste não aguarda
- ❌ Exceções podem não ser capturadas
- ❌ **NUNCA use em testes**
- ⚠️ Use apenas em event handlers (com try-catch)

---

## 🔒 O que é Protected() no Moq?

### 🤔 Pergunta: "O que significa Protected() aqui? mockHandler.Protected()"

### 📚 Conceito: Membros Protegidos (Protected Members)

**Protected** é um modificador de acesso em C# que significa que o membro (método, propriedade) só pode ser acessado:
- Dentro da própria classe
- Dentro de classes derivadas (herança)

### 🎯 Por que Precisa de Protected() no Moq?

**HttpMessageHandler** tem o método `SendAsync` como **protected**:

```csharp
// Dentro de HttpMessageHandler (classe base do .NET)
protected virtual Task<HttpResponseMessage> SendAsync(
    HttpRequestMessage request,
    CancellationToken cancellationToken
)
```

**Por quê é protected?**
- É um método interno usado pelo `HttpClient`
- Não deve ser chamado diretamente por código externo
- Apenas classes derivadas podem chamar
- É parte da implementação interna

**Problema:**
- Para mockar `HttpClient`, precisamos mockar `HttpMessageHandler`
- Mas `SendAsync` é **protected** - não podemos acessar diretamente
- Moq precisa de uma forma de acessar membros protegidos

**Solução:**
- `.Protected()` do Moq permite acessar membros protegidos
- Permite fazer Setup de métodos protegidos

### 💻 Exemplo Detalhado

#### Sem Protected() (Não Funciona)

```csharp
// ❌ NÃO FUNCIONA - SendAsync é protected
var mockHandler = new Mock<HttpMessageHandler>();

mockHandler
    .Setup(x => x.SendAsync(...))  // ❌ Erro! SendAsync é protected
    .ReturnsAsync(...);
```

**Erro**: `'HttpMessageHandler.SendAsync(HttpRequestMessage, CancellationToken)' is inaccessible due to its protection level`

#### Com Protected() (Funciona)

```csharp
// ✅ FUNCIONA - Protected() permite acessar membros protegidos
var mockHandler = new Mock<HttpMessageHandler>();

mockHandler
    .Protected()  // ← Acessa membros protegidos
    .Setup<Task<HttpResponseMessage>>(
        "SendAsync",  // ← Nome do método como string
        ItExpr.IsAny<HttpRequestMessage>(),
        ItExpr.IsAny<CancellationToken>()
    )
    .ReturnsAsync(new HttpResponseMessage { ... });
```

### 🔍 Como Funciona

**`.Protected()` retorna um objeto especial que permite:**

1. **Acessar membros protegidos** da classe
2. **Fazer Setup usando o nome do método como string**
3. **Usar `ItExpr` em vez de `It`** (para expressões em métodos protegidos)

### 📝 Sintaxe Completa

```csharp
mockHandler
    .Protected()  // 1. Acessa membros protegidos
    .Setup<TipoRetorno>(  // 2. Define tipo de retorno
        "NomeDoMetodo",  // 3. Nome do método como string
        ItExpr.IsAny<TipoParametro1>(),  // 4. Parâmetros (usar ItExpr)
        ItExpr.IsAny<TipoParametro2>()
    )
    .ReturnsAsync(valor);  // 5. Define retorno
```

### 🎯 Diferenças Importantes

| Aspecto | Método Público | Método Protegido |
|---------|---------------|------------------|
| **Acesso** | Pode acessar diretamente | Precisa de `.Protected()` |
| **Setup** | `Setup(x => x.Metodo())` | `Protected().Setup<T>("Metodo", ...)` |
| **Parâmetros** | `It.IsAny<T>()` | `ItExpr.IsAny<T>()` |
| **Nome** | Usa expressão lambda | Usa string |

### 💻 Comparação: Público vs Protegido

#### Método Público (Normal)

```csharp
// Classe com método público
public class MeuServico
{
    public async Task<string> BuscarAsync() { ... }
}

// Mock de método público
var mock = new Mock<MeuServico>();
mock
    .Setup(x => x.BuscarAsync())  // ✅ Acesso direto
    .ReturnsAsync("dados");
```

#### Método Protegido (HttpMessageHandler)

```csharp
// HttpMessageHandler com método protegido
public abstract class HttpMessageHandler
{
    protected virtual Task<HttpResponseMessage> SendAsync(...) { ... }
}

// Mock de método protegido
var mock = new Mock<HttpMessageHandler>();
mock
    .Protected()  // ✅ Precisa de Protected()
    .Setup<Task<HttpResponseMessage>>(
        "SendAsync",  // ✅ Nome como string
        ItExpr.IsAny<HttpRequestMessage>(),  // ✅ ItExpr em vez de It
        ItExpr.IsAny<CancellationToken>()
    )
    .ReturnsAsync(new HttpResponseMessage { ... });
```

### 🗣️ Como Ler/Falar

**Em Português:**
```
mockHandler.Protected().Setup<Task<HttpResponseMessage>>("SendAsync", ...)
```

"Mock handler ponto Protected ponto Setup de Task de HttpResponseMessage, método SendAsync..."

**Em Inglês:**
```
mockHandler.Protected().Setup<Task<HttpResponseMessage>>("SendAsync", ...)
```

"Mock handler dot Protected dot Setup of Task of HttpResponseMessage, method SendAsync..."

### 🎯 Por que ItExpr em vez de It?

**`ItExpr`** é usado para expressões lambda em métodos protegidos:

```csharp
// Método público - usa It
mockService
    .Setup(x => x.BuscarAsync(It.IsAny<string>()))  // ✅ It
    .ReturnsAsync("dados");

// Método protegido - usa ItExpr
mockHandler
    .Protected()
    .Setup<Task<HttpResponseMessage>>(
        "SendAsync",
        ItExpr.IsAny<HttpRequestMessage>(),  // ✅ ItExpr
        ItExpr.IsAny<CancellationToken>()
    )
    .ReturnsAsync(...);
```

**Diferença:**
- `It`: Para métodos públicos (expressão lambda direta)
- `ItExpr`: Para métodos protegidos (expressão lambda via string)

### 📚 Alternativa: Usar IHttpClientFactory

**Em vez de mockar HttpMessageHandler diretamente, pode usar IHttpClientFactory:**

```csharp
// ✅ Alternativa mais simples
var mockFactory = new Mock<IHttpClientFactory>();
var mockHttpClient = new Mock<HttpClient>();

mockFactory
    .Setup(x => x.CreateClient(It.IsAny<string>()))
    .Returns(mockHttpClient.Object);

mockHttpClient
    .Setup(x => x.GetStringAsync(It.IsAny<string>()))
    .ReturnsAsync("dados");
```

**Vantagem**: Não precisa de `.Protected()` porque `GetStringAsync` é público.

### 🔑 Resumo

**`.Protected()` no Moq:**
- Permite acessar e mockar membros protegidos
- Necessário quando o método é `protected` (não público)
- Usa nome do método como string
- Usa `ItExpr` em vez de `It` para parâmetros
- Comum ao mockar `HttpMessageHandler` para testar `HttpClient`

**Quando usar:**
- ✅ Ao mockar classes com métodos protegidos
- ✅ Ao mockar `HttpMessageHandler` para testar `HttpClient`
- ❌ Não precisa para métodos públicos

---

## 🔧 O que é Fixture?

### 🤔 Pergunta: "O que significa Fixture? Qual a tradução? Por que se usa esse nome? E em inglês como se explica o que é fixture?"

### 📚 O que é Fixture?

**Fixture** (em português: **"Equipamento de Teste"** ou **"Configuração de Teste"**) é um objeto que contém código de setup e teardown compartilhado entre múltiplos testes.

### 🎬 Analogia: Fixture = Cenário de Teste

Imagine um laboratório:

```
Fixture = Equipamento e configuração do laboratório
Testes = Experimentos que usam o mesmo equipamento
```

**Exemplo:**
- Fixture: Configuração do banco de dados de teste
- Testes: Múltiplos testes que usam o mesmo banco

### 🗣️ Tradução e Significado

**Em Português:**
- **Tradução literal**: "Equipamento", "Instalação", "Acessório"
- **No contexto de testes**: "Configuração de Teste", "Ambiente de Teste", "Setup de Teste"
- **Uso comum**: Manter o termo "Fixture" (é amplamente usado assim)

**Em Inglês:**
- **Significado**: "A piece of equipment or furniture that is fixed in position"
- **No contexto de testes**: "Test fixture" = "A fixed state of a set of objects used as a baseline for running tests"

### 🎯 Por que esse Nome?

**Origem do termo:**

1. **Hardware/Engenharia**: Fixture = equipamento fixo usado para testar outros objetos
   - Exemplo: Fixture para testar peças de carro
   - É algo "fixo" que você usa para testar

2. **Software Testing**: Fixture = configuração fixa usada para testar código
   - Exemplo: Fixture com banco de dados configurado
   - É algo "fixo" que você usa para testar

**Por que "Fixture"?**
- É algo que fica "fixo" (não muda) entre testes
- É algo que você "instala" (setup) antes dos testes
- É algo que você "usa" para testar outras coisas

### 💻 O que é Fixture em Xunit?

**IClassFixture<T>** permite compartilhar uma instância de um objeto entre todos os testes de uma classe:

```csharp
// Fixture - configuração compartilhada
public class TestFixture : IDisposable
{
    private readonly ServiceProvider _serviceProvider;
    
    public TestFixture()
    {
        // Setup - executado UMA vez para todos os testes
        var services = new ServiceCollection();
        services.AddScoped<MeuServico>();
        _serviceProvider = services.BuildServiceProvider();
    }
    
    public T GetService<T>() => _serviceProvider.GetService<T>();
    
    public void Dispose()
    {
        // Teardown - executado após todos os testes
        _serviceProvider?.Dispose();
    }
}

// Testes - usam o mesmo fixture
public class IntegracaoTests : IClassFixture<TestFixture>
{
    private readonly TestFixture _fixture;
    
    public IntegracaoTests(TestFixture fixture)
    {
        _fixture = fixture;  // ← Mesma instância para todos os testes
    }
    
    [Fact]
    public async Task Teste1()
    {
        var service = _fixture.GetService<MeuServico>();
        // Usa o serviço...
    }
    
    [Fact]
    public async Task Teste2()
    {
        var service = _fixture.GetService<MeuServico>();
        // Usa o mesmo serviço (mesma instância do fixture)
    }
}
```

### 🎯 Quando Usar Fixture?

**Use Fixture quando:**
- ✅ Setup é caro (ex: criar banco de dados)
- ✅ Múltiplos testes precisam da mesma configuração
- ✅ Quer compartilhar estado entre testes
- ✅ Quer executar setup uma vez para todos os testes

**Não use Fixture quando:**
- ❌ Cada teste precisa de estado isolado
- ❌ Setup é rápido e simples
- ❌ Testes não compartilham configuração

### 📊 Comparação: Com vs Sem Fixture

#### Sem Fixture (Setup em cada teste)

```csharp
[Fact]
public async Task Teste1()
{
    // Setup repetido em cada teste
    var services = new ServiceCollection();
    services.AddScoped<MeuServico>();
    var serviceProvider = services.BuildServiceProvider();
    
    var service = serviceProvider.GetService<MeuServico>();
    // Teste...
}

[Fact]
public async Task Teste2()
{
    // Setup repetido novamente
    var services = new ServiceCollection();
    services.AddScoped<MeuServico>();
    var serviceProvider = services.BuildServiceProvider();
    
    var service = serviceProvider.GetService<MeuServico>();
    // Teste...
}
```

**Problemas:**
- Setup repetido em cada teste
- Mais lento (setup executado múltiplas vezes)
- Mais código duplicado

#### Com Fixture (Setup compartilhado)

```csharp
public class IntegracaoTests : IClassFixture<TestFixture>
{
    private readonly TestFixture _fixture;
    
    public IntegracaoTests(TestFixture fixture)
    {
        _fixture = fixture;  // Setup executado UMA vez
    }
    
    [Fact]
    public async Task Teste1()
    {
        var service = _fixture.GetService<MeuServico>();
        // Teste...
    }
    
    [Fact]
    public async Task Teste2()
    {
        var service = _fixture.GetService<MeuServico>();
        // Teste... (usa mesmo fixture)
    }
}
```

**Vantagens:**
- Setup executado uma vez
- Mais rápido
- Menos código duplicado
- Configuração centralizada

### 🗣️ Como Explicar Fixture

#### Em Português

**Forma 1: Literal**
```
TestFixture _fixture
```
"Test Fixture underscore fixture"

**Forma 2: Descritiva (Recomendada)**
```
private readonly TestFixture _fixture;
```
"Campo privado readonly do tipo Test Fixture chamado fixture"  
ou  
"Fixture de teste que contém a configuração compartilhada"

**Forma 3: Em Contexto**
```
public IntegracaoTests(TestFixture fixture)
{
    _fixture = fixture;
}
```
"Construtor recebe um Test Fixture e armazena no campo fixture"  
ou  
"Recebe a configuração de teste compartilhada e armazena para usar nos testes"

#### Em Inglês

**Forma 1: Literal**
```
TestFixture _fixture
```
"Test Fixture underscore fixture"

**Forma 2: Descritiva (Recomendada)**
```
private readonly TestFixture _fixture;
```
"Private readonly field of type Test Fixture named fixture"  
ou  
"Test fixture that contains shared configuration"

**Forma 3: Em Contexto**
```
public IntegracaoTests(TestFixture fixture)
{
    _fixture = fixture;
}
```
"Constructor receives a Test Fixture and stores it in the fixture field"  
ou  
"Receives the shared test configuration and stores it for use in tests"

### 📝 Exemplo Completo de Fixture

```csharp
// 1. Criar a classe Fixture
public class TestFixture : IDisposable
{
    private readonly ServiceProvider _serviceProvider;
    private readonly HttpClient _httpClient;
    
    public TestFixture()
    {
        // Setup executado UMA vez
        var services = new ServiceCollection();
        services.AddScoped<MeuServico>();
        services.AddScoped<IRepository, MockRepository>();
        _serviceProvider = services.BuildServiceProvider();
        
        // Configurar HttpClient de teste
        _httpClient = new HttpClient();
    }
    
    public T GetService<T>() => _serviceProvider.GetService<T>();
    public HttpClient GetHttpClient() => _httpClient;
    
    public void Dispose()
    {
        // Teardown executado após todos os testes
        _httpClient?.Dispose();
        _serviceProvider?.Dispose();
    }
}

// 2. Usar o Fixture nos testes
public class MeuServicoTests : IClassFixture<TestFixture>
{
    private readonly TestFixture _fixture;
    
    public MeuServicoTests(TestFixture fixture)
    {
        _fixture = fixture;  // Mesma instância para todos os testes
    }
    
    [Fact]
    public async Task Teste1()
    {
        var service = _fixture.GetService<MeuServico>();
        var resultado = await service.ProcessarAsync();
        Assert.NotNull(resultado);
    }
    
    [Fact]
    public async Task Teste2()
    {
        var service = _fixture.GetService<MeuServico>();
        var resultado = await service.BuscarAsync();
        Assert.NotNull(resultado);
    }
}
```

### 🔑 Pontos-Chave

1. **Fixture = Configuração Compartilhada**: Setup executado uma vez, usado por múltiplos testes
2. **IClassFixture<T>**: Interface do Xunit para compartilhar fixture entre testes
3. **Vida Útil**: Fixture é criado antes do primeiro teste, destruído após o último
4. **IDisposable**: Fixture deve implementar IDisposable para cleanup
5. **Tradução**: "Equipamento de Teste" ou "Configuração de Teste" (mas mantém "Fixture")

### 🎯 Resumo

**Fixture:**
- **O que é**: Objeto com configuração compartilhada entre testes
- **Tradução**: "Equipamento de Teste" ou "Configuração de Teste"
- **Por que o nome**: Vem de hardware/engenharia (equipamento fixo para testar)
- **Quando usar**: Setup caro ou configuração compartilhada
- **Como usar**: Implementar `IClassFixture<T>` na classe de testes

---

## 🔍 O que está Acontecendo no Teste com Mock? (Dependency Injection)

### 🤔 Pergunta: "MeuServico recebe IDependencia no construtor? Isso é DI? É como se fosse uma dependência resolvida no Program/Startup?"

### ✅ Resposta: Sim, é Dependency Injection!

**O que está acontecendo:**

1. **MeuServico** recebe `IDependencia` no construtor (é DI)
2. **Em produção**: DI container (Program/Startup) injeta a dependência real
3. **No teste**: Criamos manualmente um mock e passamos no construtor

### 📚 Como Funciona em Produção vs Teste

#### Em Produção (Program.cs ou Startup.cs)

```csharp
// Program.cs ou Startup.cs
var builder = WebApplication.CreateBuilder(args);

// Registrar dependências no DI container
builder.Services.AddScoped<IDependencia, DependenciaReal>();
builder.Services.AddScoped<MeuServico>();

var app = builder.Build();

// Quando MeuServico é criado, DI container injeta DependenciaReal automaticamente
var servico = app.Services.GetService<MeuServico>();
// Internamente: new MeuServico(new DependenciaReal())
```

**O que acontece:**
1. DI container cria `DependenciaReal`
2. DI container cria `MeuServico` passando `DependenciaReal` no construtor
3. `MeuServico` usa a dependência real

#### No Teste (Mock Manual)

```csharp
[Fact]
public async Task MetodoAsync_DeveChamarDependenciaCorretamente()
{
    // Arrange
    // 1. Criamos um MOCK da dependência (não a real)
    var mockDependencia = new Mock<IDependencia>();
    mockDependencia
        .Setup(x => x.BuscarAsync())
        .ReturnsAsync("dados");
    
    // 2. Criamos MeuServico MANUALMENTE passando o mock
    var servico = new MeuServico(mockDependencia.Object);
    // É como se fizéssemos: new MeuServico(mockDependencia.Object)
    // Mas em vez de DI container, fazemos manualmente
    
    // Act
    var resultado = await servico.MetodoAsync();
    
    // Assert
    mockDependencia.Verify(x => x.BuscarAsync(), Times.Once);
}
```

**O que acontece:**
1. Criamos um mock de `IDependencia` (não a implementação real)
2. Criamos `MeuServico` manualmente passando o mock no construtor
3. `MeuServico` usa o mock (que podemos controlar)

### 🎯 Comparação Visual

#### Em Produção

```
DI Container (Program.cs)
    ↓
Cria DependenciaReal
    ↓
Cria MeuServico(DependenciaReal)
    ↓
MeuServico usa DependenciaReal
```

#### No Teste

```
Teste
    ↓
Cria Mock<IDependencia>
    ↓
Cria MeuServico(mock.Object)  ← Manualmente!
    ↓
MeuServico usa Mock (controlado)
```

### 💻 Exemplo Completo: Código Real

#### Classe que será Testada

```csharp
// MeuServico - recebe IDependencia no construtor (DI)
public class MeuServico
{
    private readonly IDependencia _dependencia;
    
    // Construtor recebe dependência (Dependency Injection)
    public MeuServico(IDependencia dependencia)
    {
        _dependencia = dependencia;  // ← Dependência injetada
    }
    
    public async Task<string> MetodoAsync()
    {
        // Usa a dependência injetada
        var dados = await _dependencia.BuscarAsync();
        return Processar(dados);
    }
}

// Interface da dependência
public interface IDependencia
{
    Task<string> BuscarAsync();
}

// Implementação real (usada em produção)
public class DependenciaReal : IDependencia
{
    public async Task<string> BuscarAsync()
    {
        // Busca dados reais (banco, API, etc.)
        return await BuscarDoBancoAsync();
    }
}
```

#### Em Produção (Program.cs)

```csharp
// Program.cs
var builder = WebApplication.CreateBuilder(args);

// Registrar no DI container
builder.Services.AddScoped<IDependencia, DependenciaReal>();
builder.Services.AddScoped<MeuServico>();

var app = builder.Build();

// Quando alguém pedir MeuServico:
var servico = app.Services.GetService<MeuServico>();
// DI container faz: new MeuServico(new DependenciaReal())
// Serviço recebe a implementação REAL
```

#### No Teste

```csharp
[Fact]
public async Task MetodoAsync_DeveChamarDependenciaCorretamente()
{
    // Arrange
    // Criar MOCK (não a implementação real)
    var mockDependencia = new Mock<IDependencia>();
    mockDependencia
        .Setup(x => x.BuscarAsync())
        .ReturnsAsync("dados mockados");  // ← Retorna dados controlados
    
    // Criar serviço MANUALMENTE passando o mock
    // Em vez de DI container fazer, fazemos manualmente
    var servico = new MeuServico(mockDependencia.Object);
    // É como: new MeuServico(mockDependencia.Object)
    // Mas em vez de DependenciaReal, passamos o mock
    
    // Act
    var resultado = await servico.MetodoAsync();
    
    // Assert
    Assert.Equal("dados processados", resultado);
    // Verificar que a dependência foi chamada
    mockDependencia.Verify(x => x.BuscarAsync(), Times.Once);
}
```

### 🎯 Por que Usar Mock em Testes?

**Vantagens:**
1. ✅ **Controle**: Podemos controlar o que a dependência retorna
2. ✅ **Isolamento**: Testamos apenas `MeuServico`, não `DependenciaReal`
3. ✅ **Velocidade**: Não precisa de banco de dados, API, etc.
4. ✅ **Confiabilidade**: Não depende de recursos externos

**Sem Mock (Problemático):**
```csharp
// ❌ PROBLEMÁTICO - Usa dependência real
[Fact]
public async Task MetodoAsync_DeveFuncionar()
{
    // Cria dependência REAL (pode precisar de banco, API, etc.)
    var dependenciaReal = new DependenciaReal();
    var servico = new MeuServico(dependenciaReal);
    
    // ❌ Pode falhar se banco não estiver disponível
    // ❌ Pode ser lento (chama API real)
    // ❌ Não é isolado (testa MeuServico + DependenciaReal)
    var resultado = await servico.MetodoAsync();
}
```

**Com Mock (Correto):**
```csharp
// ✅ CORRETO - Usa mock
[Fact]
public async Task MetodoAsync_DeveFuncionar()
{
    // Cria MOCK (não precisa de banco, API, etc.)
    var mockDependencia = new Mock<IDependencia>();
    mockDependencia.Setup(x => x.BuscarAsync()).ReturnsAsync("dados");
    
    var servico = new MeuServico(mockDependencia.Object);
    
    // ✅ Rápido (não chama recursos externos)
    // ✅ Isolado (testa apenas MeuServico)
    // ✅ Confiável (não depende de recursos externos)
    var resultado = await servico.MetodoAsync();
}
```

### 📊 Comparação: Produção vs Teste

| Aspecto | Produção | Teste |
|---------|----------|-------|
| **Criação** | DI Container (Program.cs) | Manual (`new MeuServico(...)`) |
| **Dependência** | Implementação Real | Mock |
| **Configuração** | `AddScoped<IDependencia, DependenciaReal>()` | `new Mock<IDependencia>()` |
| **Objetivo** | Funcionar com dados reais | Testar isoladamente |

### 🎯 Resumo: O que Está Acontecendo

**No código do teste:**

```csharp
var mockDependencia = new Mock<IDependencia>();
var servico = new MeuServico(mockDependencia.Object);
```

**O que isso significa:**

1. ✅ **Sim, é Dependency Injection**: `MeuServico` recebe `IDependencia` no construtor
2. ✅ **Sim, é como Program/Startup**: Em produção, DI container faria isso automaticamente
3. ✅ **No teste, fazemos manualmente**: Em vez de DI container, criamos e passamos o mock manualmente
4. ✅ **Mock simula dependência real**: O mock faz o papel da `DependenciaReal` que seria injetada em produção

**Analogia:**
```
Produção: DI Container = Garçom que traz a comida real
Teste: Nós mesmos = Criamos comida fake (mock) e passamos
```

### 🔑 Pontos-Chave

1. **É Dependency Injection**: `MeuServico` recebe dependência no construtor
2. **Em produção**: DI container injeta implementação real
3. **No teste**: Criamos mock manualmente e passamos
4. **Mock simula**: Faz o papel da dependência real, mas com controle
5. **Vantagem**: Testa isoladamente, rápido, confiável

---

## 🎯 O que é ThrowsAsync? (Moq e xUnit)

### 🤔 Pergunta: "O que significa ThrowsAsync? E como funciona o Assert.ThrowsAsync?"

### ✅ Validação da Sua Compreensão

**Sua explicação está 100% CORRETA!** 🎉

Vou apenas refiná-la e adicionar detalhes técnicos:

### 📚 Dois ThrowsAsync Diferentes

**Importante**: Existem **dois** `ThrowsAsync` diferentes:

1. **`ThrowsAsync` do Moq**: Configura o mock para lançar exceção
2. **`Assert.ThrowsAsync` do xUnit**: Verifica se uma exceção foi lançada

### 🔍 1. ThrowsAsync do Moq

**O que é:**
- Método do Moq usado em `.Setup()` para configurar que o mock deve lançar uma exceção
- É a forma de simular erros em métodos assíncronos

**Sintaxe:**
```csharp
mockService
    .Setup(x => x.ProcessarAsync())
    .ThrowsAsync(new InvalidOperationException("Erro"));
```

**O que faz:**
- Configura o mock: "Quando `ProcessarAsync()` for chamado, lance `InvalidOperationException` com mensagem 'Erro'"

**Sua explicação (corrigida):**
> "Temos uma Interface chamada IServico que tem um método chamado ProcessarAsync. Quando esse método for invocado, eu quero que ele lance uma exceção do tipo InvalidOperationException, com a mensagem 'Erro'."

✅ **Perfeito!**

### 🔍 2. Assert.ThrowsAsync do xUnit

**O que é:**
- Método do xUnit que verifica se uma exceção foi lançada
- Retorna a exceção lançada para verificações adicionais
- **Deve ser aguardado** (usa `await`)

**Sintaxe:**
```csharp
var excecao = await Assert.ThrowsAsync<InvalidOperationException>(
    () => servico.ProcessarAsync()
);
```

**O que faz:**
1. Executa `servico.ProcessarAsync()`
2. Verifica se uma exceção do tipo `InvalidOperationException` foi lançada
3. Se sim, retorna a exceção
4. Se não, o teste falha

**Sua explicação (corrigida):**
> "Assert.ThrowsAsync verifica se o resultado do lambda é uma exceção do tipo InvalidOperationException. Como parâmetro da lambda passo a instância criada e peço para executar ProcessarAsync. Por último, verifico se a variável que guardou o retorno tem a string 'Erro' na propriedade Message."

✅ **Perfeito!**

### 💻 Exemplo Completo Passo a Passo

```csharp
[Fact]
public async Task MetodoAsync_QuandoErro_DeveLancarExcecao()
{
    // ============================================
    // ARRANGE - Preparar o cenário
    // ============================================
    
    // 1. Criar mock da interface
    var mockService = new Mock<IServico>();
    
    // 2. Configurar mock para lançar exceção quando ProcessarAsync for chamado
    mockService
        .Setup(x => x.ProcessarAsync())
        .ThrowsAsync(new InvalidOperationException("Erro"));
    // ↑ ThrowsAsync do Moq: "Quando ProcessarAsync for chamado, lance essa exceção"
    
    // 3. Obter instância do mock
    var servico = mockService.Object;
    // Agora servico é um IServico que, quando ProcessarAsync for chamado,
    // vai lançar InvalidOperationException("Erro")
    
    // ============================================
    // ACT & ASSERT - Executar e verificar
    // ============================================
    
    // 4. Executar e verificar se exceção foi lançada
    var excecao = await Assert.ThrowsAsync<InvalidOperationException>(
        () => servico.ProcessarAsync()  // ← Executa ProcessarAsync
    );
    // ↑ Assert.ThrowsAsync do xUnit:
    //   - Executa servico.ProcessarAsync()
    //   - Verifica se InvalidOperationException foi lançada
    //   - Se sim, retorna a exceção
    //   - Se não, teste falha
    
    // 5. Verificar detalhes da exceção
    Assert.Equal("Erro", excecao.Message);
    // Verifica se a mensagem da exceção é "Erro"
}
```

### 🎯 Fluxo Completo

```
1. Criar Mock<IServico>
   ↓
2. Configurar: ThrowsAsync(new InvalidOperationException("Erro"))
   "Quando ProcessarAsync for chamado, lance essa exceção"
   ↓
3. Obter instância: mockService.Object
   ↓
4. Executar: servico.ProcessarAsync()
   ↓
5. Mock lança: InvalidOperationException("Erro")
   ↓
6. Assert.ThrowsAsync captura a exceção
   ↓
7. Verificar: excecao.Message == "Erro"
```

### 📊 Comparação: ThrowsAsync vs ReturnsAsync

| Aspecto | ReturnsAsync | ThrowsAsync |
|---------|--------------|-------------|
| **O que faz** | Retorna valor | Lança exceção |
| **Uso** | Simular sucesso | Simular erro |
| **Exemplo** | `.ReturnsAsync("dados")` | `.ThrowsAsync(new Exception())` |

**Exemplo:**
```csharp
// Simular sucesso
mockService
    .Setup(x => x.ProcessarAsync())
    .ReturnsAsync("dados");  // ← Retorna "dados"

// Simular erro
mockService
    .Setup(x => x.ProcessarAsync())
    .ThrowsAsync(new Exception("Erro"));  // ← Lança exceção
```

### 🔍 Assert.ThrowsAsync: Detalhes Técnicos

**Por que usar `await`?**

```csharp
// ✅ CORRETO - Deve aguardar
var excecao = await Assert.ThrowsAsync<InvalidOperationException>(
    () => servico.ProcessarAsync()
);

// ❌ ERRADO - Não aguarda
var excecao = Assert.ThrowsAsync<InvalidOperationException>(
    () => servico.ProcessarAsync()
);
// Erro: Assert.ThrowsAsync retorna Task, não a exceção diretamente
```

**Por quê?**
- `Assert.ThrowsAsync` retorna `Task<TException>`
- Precisa aguardar para obter a exceção
- Sem `await`, você teria uma `Task`, não a exceção

### 🎯 Por que Usar ThrowsAsync?

**Cenário Real:**

```csharp
// Código real que será testado
public class MeuServico
{
    private readonly IApiClient _apiClient;
    
    public async Task<string> ProcessarAsync()
    {
        try
        {
            var dados = await _apiClient.BuscarAsync();
            return Processar(dados);
        }
        catch (InvalidOperationException ex)
        {
            // Tratar erro específico
            LogError(ex);
            throw;
        }
    }
}
```

**Teste: Verificar se erro é tratado corretamente**

```csharp
[Fact]
public async Task ProcessarAsync_QuandoApiErro_DeveLancarExcecao()
{
    // Arrange
    var mockApi = new Mock<IApiClient>();
    mockApi
        .Setup(x => x.BuscarAsync())
        .ThrowsAsync(new InvalidOperationException("API indisponível"));
    // ↑ Simula erro da API
    
    var servico = new MeuServico(mockApi.Object);
    
    // Act & Assert
    var excecao = await Assert.ThrowsAsync<InvalidOperationException>(
        () => servico.ProcessarAsync()
    );
    // ↑ Verifica se a exceção foi propagada corretamente
    
    Assert.Equal("API indisponível", excecao.Message);
}
```

### 📝 Alternativas: Outras Formas de Verificar Exceções

#### Forma 1: Assert.ThrowsAsync (Recomendada)

```csharp
var excecao = await Assert.ThrowsAsync<InvalidOperationException>(
    () => servico.ProcessarAsync()
);
Assert.Equal("Erro", excecao.Message);
```

#### Forma 2: try-catch (Não Recomendada)

```csharp
// ❌ NÃO RECOMENDADA
try
{
    await servico.ProcessarAsync();
    Assert.True(false, "Deveria ter lançado exceção");
}
catch (InvalidOperationException ex)
{
    Assert.Equal("Erro", ex.Message);
}
```

**Por que não usar?**
- Mais verboso
- Pode mascarar outros erros
- `Assert.ThrowsAsync` é mais claro e direto

### 🔑 Pontos-Chave

1. **ThrowsAsync do Moq**: Configura mock para lançar exceção
2. **Assert.ThrowsAsync do xUnit**: Verifica se exceção foi lançada
3. **Sempre usar await**: `Assert.ThrowsAsync` retorna `Task<TException>`
4. **Retorna a exceção**: Permite verificar detalhes (Message, InnerException, etc.)
5. **Lambda**: Passa método a ser executado, não o resultado

### 🎯 Resumo da Sua Compreensão (Validada)

✅ **ThrowsAsync do Moq:**
- Configura o mock para lançar exceção quando método for chamado
- Parâmetro: instância da exceção (com mensagem, etc.)

✅ **Assert.ThrowsAsync do xUnit:**
- Verifica se exceção foi lançada
- Retorna a exceção para verificações adicionais
- Deve ser aguardado (`await`)

✅ **Fluxo:**
1. Configurar mock com `ThrowsAsync`
2. Obter instância (`mockService.Object`)
3. Executar método dentro de `Assert.ThrowsAsync`
4. Verificar detalhes da exceção retornada

**Sua compreensão está perfeita!** 🎉

---

## 🗑️ IDisposable e CancellationToken: Limpeza de Recursos

### 🤔 Por que CancellationTokenSource Implementa IDisposable?

**CancellationTokenSource** implementa **IDisposable** porque ele gerencia recursos internos (como timers e callbacks) que precisam ser liberados adequadamente.

### 📚 O que é IDisposable?

**IDisposable** é uma interface em C# que indica que um objeto gerencia recursos não gerenciados (como timers, handles de arquivo, conexões de rede) que precisam ser liberados explicitamente.

**Padrão de uso:**
```csharp
// Usar 'using' para garantir que Dispose() seja chamado
using var cts = new CancellationTokenSource();
// ... usar cts ...
// Dispose() é chamado automaticamente ao sair do escopo
```

### 🎯 Por que CancellationTokenSource Precisa de Dispose?

**CancellationTokenSource** mantém recursos internos:
- **Timers**: Se você usar `CancelAfter()`, um timer interno é criado
- **Callbacks**: Registros de callbacks que precisam ser limpos
- **Threads**: Pode manter referências a threads

**Se não descartar:**
- ❌ Timers podem continuar rodando
- ❌ Callbacks podem não ser removidos
- ❌ Pode causar memory leaks
- ❌ Recursos não são liberados imediatamente

### 💻 Como Usar: Padrão Correto

#### Padrão 1: using Statement (Recomendado)

```csharp
[Fact]
public async Task ProcessarAsync_DeveRespeitarTimeout()
{
    // Arrange
    var mockService = new Mock<IServico>();
    mockService
        .Setup(x => x.ProcessarAsync(It.IsAny<CancellationToken>()))
        .Returns(async (CancellationToken ct) =>
        {
            await Task.Delay(5000, ct);
            return "resultado";
        });
    
    var service = mockService.Object;
    
    // ✅ CORRETO - using garante Dispose()
    using var cts = new CancellationTokenSource(TimeSpan.FromMilliseconds(100));
    
    // Act & Assert
    await Assert.ThrowsAsync<TaskCanceledException>(
        () => service.ProcessarAsync(cts.Token)
    );
    // Dispose() é chamado automaticamente aqui
}
```

**O que acontece:**
1. `CancellationTokenSource` é criado
2. Usado no teste
3. Ao sair do escopo do `using`, `Dispose()` é chamado automaticamente
4. Recursos são liberados

#### Padrão 2: using Block (Alternativa)

```csharp
[Fact]
public async Task ProcessarAsync_DeveRespeitarTimeout()
{
    // Arrange
    var mockService = new Mock<IServico>();
    // ... setup ...
    
    // ✅ CORRETO - using block
    using (var cts = new CancellationTokenSource(TimeSpan.FromMilliseconds(100)))
    {
        // Act & Assert
        await Assert.ThrowsAsync<TaskCanceledException>(
            () => service.ProcessarAsync(cts.Token)
        );
    } // Dispose() é chamado aqui
}
```

**Diferença:**
- `using var`: Dispose ao sair do escopo (mais moderno, C# 8.0+)
- `using { }`: Dispose ao sair do bloco (funciona em versões antigas)

#### Padrão 3: Dispose Manual (Quando Necessário)

```csharp
[Fact]
public async Task ProcessarAsync_DeveRespeitarTimeout()
{
    // Arrange
    var mockService = new Mock<IServico>();
    // ... setup ...
    
    var cts = new CancellationTokenSource(TimeSpan.FromMilliseconds(100));
    
    try
    {
        // Act & Assert
        await Assert.ThrowsAsync<TaskCanceledException>(
            () => service.ProcessarAsync(cts.Token)
        );
    }
    finally
    {
        // ✅ CORRETO - Dispose manual em finally
        cts.Dispose();
    }
}
```

**Quando usar:**
- Quando precisa de controle mais fino sobre quando descartar
- Quando está em código que não suporta `using var` (versões antigas do C#)

### ⚠️ O que Acontece se Não Descartar?

#### Problema: Memory Leak Potencial

```csharp
// ❌ PROBLEMÁTICO - Não descarta
[Fact]
public async Task ProcessarAsync_DeveRespeitarTimeout()
{
    var cts = new CancellationTokenSource(TimeSpan.FromMilliseconds(100));
    // ... usar cts ...
    // ❌ cts nunca é descartado
    // ❌ Timer interno pode continuar rodando
    // ❌ Recursos não são liberados imediatamente
}
```

**Consequências:**
- Timer interno pode continuar rodando mesmo após o teste
- Callbacks podem não ser removidos
- Pode causar memory leaks em testes longos
- Recursos não são liberados até garbage collection

#### Solução: Sempre Usar using

```csharp
// ✅ CORRETO - Sempre descarta
[Fact]
public async Task ProcessarAsync_DeveRespeitarTimeout()
{
    using var cts = new CancellationTokenSource(TimeSpan.FromMilliseconds(100));
    // ... usar cts ...
    // ✅ Dispose() é chamado automaticamente
    // ✅ Recursos são liberados imediatamente
}
```

### 🎯 Exemplos Práticos Completos

#### Exemplo 1: Teste com Timeout

```csharp
[Fact]
public async Task ProcessarAsync_ComTimeout_DeveLancarExcecao()
{
    // Arrange
    var mockService = new Mock<IServico>();
    mockService
        .Setup(x => x.ProcessarAsync(It.IsAny<CancellationToken>()))
        .Returns(async (CancellationToken ct) =>
        {
            await Task.Delay(5000, ct); // Simula operação longa
            return "resultado";
        });
    
    var service = mockService.Object;
    
    // ✅ CORRETO - using garante limpeza
    using var cts = new CancellationTokenSource(TimeSpan.FromMilliseconds(100));
    
    // Act & Assert
    await Assert.ThrowsAsync<TaskCanceledException>(
        () => service.ProcessarAsync(cts.Token)
    );
    // Dispose() chamado automaticamente aqui
}
```

#### Exemplo 2: Teste com Cancelamento Manual

```csharp
[Fact]
public async Task ProcessarAsync_ComCancelamento_DeveParar()
{
    // Arrange
    var mockService = new Mock<IServico>();
    var processando = true;
    
    mockService
        .Setup(x => x.ProcessarAsync(It.IsAny<CancellationToken>()))
        .Returns(async (CancellationToken ct) =>
        {
            while (processando && !ct.IsCancellationRequested)
            {
                await Task.Delay(100, ct);
            }
            return "resultado";
        });
    
    var service = mockService.Object;
    
    // ✅ CORRETO - using garante limpeza
    using var cts = new CancellationTokenSource();
    
    // Act
    var task = service.ProcessarAsync(cts.Token);
    await Task.Delay(200);
    cts.Cancel(); // Cancela manualmente
    
    // Assert
    await Assert.ThrowsAsync<TaskCanceledException>(() => task);
    // Dispose() chamado automaticamente aqui
}
```

#### Exemplo 3: Múltiplos CancellationTokenSource

```csharp
[Fact]
public async Task ProcessarMultiplosAsync_ComTimeouts_DeveFuncionar()
{
    // Arrange
    var mockService = new Mock<IServico>();
    // ... setup ...
    
    // ✅ CORRETO - Cada um com seu próprio using
    using var cts1 = new CancellationTokenSource(TimeSpan.FromMilliseconds(100));
    using var cts2 = new CancellationTokenSource(TimeSpan.FromMilliseconds(200));
    using var cts3 = new CancellationTokenSource(TimeSpan.FromMilliseconds(300));
    
    // Act
    var tasks = new[]
    {
        service.ProcessarAsync(cts1.Token),
        service.ProcessarAsync(cts2.Token),
        service.ProcessarAsync(cts3.Token)
    };
    
    // Assert
    var resultados = await Task.WhenAll(tasks);
    // Todos os Dispose() são chamados automaticamente aqui
}
```

### 🔍 CancellationToken vs CancellationTokenSource

**Importante**: Apenas **CancellationTokenSource** precisa ser descartado, não o **CancellationToken**:

```csharp
// ✅ CORRETO
using var cts = new CancellationTokenSource();
var token = cts.Token; // ← Token não precisa de Dispose
// Token é apenas uma struct, não gerencia recursos
```

**Por quê?**
- **CancellationTokenSource**: Gerencia recursos (timers, callbacks) → precisa de Dispose
- **CancellationToken**: Apenas uma struct que referencia o Source → não precisa de Dispose

### 📊 Comparação: Com vs Sem Dispose

| Aspecto | Sem Dispose | Com Dispose (using) |
|---------|-------------|---------------------|
| **Recursos liberados?** | ❌ Apenas no GC | ✅ Imediatamente |
| **Timer para?** | ❌ Pode continuar | ✅ Para imediatamente |
| **Memory leak?** | ⚠️ Possível | ✅ Não |
| **Código** | Mais simples | Mais seguro |
| **Recomendado?** | ❌ Não | ✅ Sim |

### 🎯 Regras de Ouro

1. **Sempre use `using`**: Ao criar `CancellationTokenSource`, use `using var` ou `using { }`
2. **Não precisa descartar Token**: Apenas o `CancellationTokenSource` precisa de Dispose
3. **Em testes**: Sempre descarte para evitar memory leaks
4. **Em produção**: Sempre descarte para liberar recursos imediatamente

### 💡 Quando Não Precisa de Dispose?

**Raramente**, mas há casos:

```csharp
// ✅ OK - Se o CancellationTokenSource vive durante toda a aplicação
public class BackgroundService
{
    private readonly CancellationTokenSource _cts = new();
    
    public void Start()
    {
        // _cts vive durante toda a vida do serviço
        // Dispose será chamado quando o serviço for descartado
    }
    
    public void Dispose()
    {
        _cts.Dispose(); // ← Dispose manual no Dispose do serviço
    }
}
```

**Mas mesmo assim:**
- Se o serviço implementa `IDisposable`, deve descartar o `CancellationTokenSource` no seu `Dispose()`
- É melhor sempre usar `using` quando possível

### 🔑 Pontos-Chave

1. **CancellationTokenSource implementa IDisposable**: Gerencia recursos que precisam ser liberados
2. **Sempre usar `using`**: Garante que `Dispose()` seja chamado automaticamente
3. **Token não precisa Dispose**: Apenas o Source precisa
4. **Em testes**: Sempre descartar para evitar memory leaks
5. **Em produção**: Sempre descartar para liberar recursos imediatamente

### 🎯 Resumo

**IDisposable com CancellationToken:**
- **CancellationTokenSource** implementa `IDisposable` porque gerencia recursos (timers, callbacks)
- **Sempre usar `using`**: `using var cts = new CancellationTokenSource();`
- **Token não precisa Dispose**: Apenas o Source precisa
- **Sem Dispose**: Pode causar memory leaks e recursos não liberados
- **Com Dispose**: Recursos são liberados imediatamente

**Padrão recomendado:**
```csharp
using var cts = new CancellationTokenSource(TimeSpan.FromMilliseconds(100));
// ... usar cts.Token ...
// Dispose() chamado automaticamente
```

---

**Última Atualização**: 2025-11-30


