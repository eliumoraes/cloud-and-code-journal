# Progresso: Revisão Async/Await em .NET (Issue #11)

**Data de Criação**: 2025-11-25  
**Última Atualização**: 2025-12-06  
**Issue**: #11

## 🎯 Objetivo da Atividade

Revisar e reforçar conceitos fundamentais de async/await em .NET, garantindo compreensão sólida deste padrão essencial.

---

## 📊 Status dos Tópicos

| Tópico | Compreensão Inicial | Status Atual | Próxima Ação |
|--------|---------------------|--------------|--------------|
| Como funciona async/await | 70% | ✅ Concluído | - |
| Task vs ValueTask | 30% | ✅ Concluído | - |
| ConfigureAwait(false) | 0% | ✅ Concluído | - |
| Evitar deadlocks | 20% | ✅ Concluído | - |
| Testar código assíncrono | 0% | ✅ Concluído (teoria) | Implementar exemplos práticos |
| Best practices | - | ✅ Concluído | - |
| Async em diferentes contextos | - | ✅ Concluído | - |

---

## ✅ Atividades Concluídas

### 1. Leitura e Vídeos (2025-11-25)
- ✅ Leitura do texto introdutório (`async-await-introducao.md`)
- ✅ Assistido: "C# Async/Await/Task Explained (Deep Dive)" - IAmTimCorey
- ✅ Assistido: "Async/Await in C# - You're Doing it Wrong" - Nick Chapsas

### 2. Verificação de Compreensão (2025-11-25)
- ✅ Respondidas perguntas de verificação sobre conceitos básicos
- ✅ Identificadas dúvidas específicas para aprofundamento

### 3. Resolução de Dúvidas (2025-11-25)
- ✅ Documento criado: `async-await-conceitos-avancados.md`
- ✅ Dúvidas respondidas sobre:
  - Task vs Thread (abstração)
  - Thread Pool (analogia)
  - ValueTask (introdução)

### 4. Dúvidas Adicionais Resolvidas (2025-11-25)
- ✅ O que é uma Struct? (struct vs class explicado)
- ✅ Por que precisaria awaitar múltiplas vezes? (cenários práticos)
- ✅ Atualizado `rules.md` com estilo de trabalho progressivo

### 5. ConfigureAwait(false) - Concluído (2025-11-25 - 2025-11-26)
- ✅ Documento criado: `async-await-configureawait.md`
- ✅ Explicado: O que é SynchronizationContext
- ✅ Explicado: Por que usar ConfigureAwait(false)
- ✅ Explicado: Quando usar e quando não usar
- ✅ Exemplos práticos: Biblioteca vs Aplicação UI
- ✅ Armadilhas comuns e regras práticas
- ✅ Seção complementar adicionada: Entendendo Deadlocks em Detalhes
- ✅ Múltiplas analogias para memorização (Restaurante, Porta, Elevador)
- ✅ Explicação passo a passo do deadlock
- ✅ Diferentes ângulos de explicação (Sistema Operacional, Recursos, Fluxo)
- ✅ ConfigureAwait(false) em APIs e Azure Functions

### 6. Evitar Deadlocks - Concluído (2025-11-26)
- ✅ Documento criado: `async-await-evitar-deadlocks.md`
- ✅ Explicado: O que são deadlocks
- ✅ Explicado: Padrões que causam deadlocks (.Result, .Wait(), etc.)
- ✅ Explicado: Como evitar deadlocks
- ✅ Regras de ouro para evitar deadlocks
- ✅ Exemplos práticos: Código problemático vs correto
- ✅ Armadilhas especiais (locks, disposing, event handlers)
- ✅ Múltiplas analogias para memorização

### 7. Testar Código Assíncrono - Em Progresso (2025-11-28 - 2025-11-30)
- ✅ Documento criado: `async-await-testar-codigo-assincrono.md`
- ✅ Explicado: Por que testar código assíncrono é diferente
- ✅ Explicado: Fundamentos de testes assíncronos (async Task, await)
- ✅ Explicado: Mocking de operações assíncronas (ReturnsAsync, ThrowsAsync)
- ✅ Explicado: Testar timeout e cancelamento
- ✅ Explicado: Testar múltiplas Tasks (WhenAll, WhenAny)
- ✅ Armadilhas comuns em testes assíncronos
- ✅ Exemplos práticos completos
- ✅ Seção sobre Expressões Lambda (como ler em português e inglês)
- ✅ Seção sobre async void vs async Task (por que async void é problemático)
- ✅ Seção sobre Protected() no Moq (acessar membros protegidos)
- ✅ Seção sobre Fixture (configuração compartilhada entre testes)
- ✅ Seção sobre Dependency Injection em testes (o que está acontecendo com mocks)
- ✅ Seção sobre ThrowsAsync (Moq e xUnit) - validação de compreensão
- ✅ Seção sobre IDisposable e CancellationToken (limpeza de recursos)

### 8. Task vs ValueTask - Aprofundamento - Concluído (2025-11-30)
- ✅ Documento criado: `async-await-task-vs-valuetask.md`
- ✅ Benchmarks práticos de performance (Task vs ValueTask)
- ✅ Análise de memória e alocação
- ✅ Critérios claros de quando usar cada um
- ✅ Exemplos de código real (Cache, Validação, API)
- ✅ Armadilhas e limitações detalhadas
- ✅ Impacto real em produção (casos de uso)
- ✅ Regras de ouro consolidadas

### 9. Best Practices - Consolidação - Concluído (2025-11-30)
- ✅ Documento criado: `async-await-best-practices.md`
- ✅ Regras de ouro consolidadas (10 regras principais)
- ✅ Padrões seguros documentados (6 padrões)
- ✅ Armadilhas comuns (8 armadilhas com soluções)
- ✅ Task vs ValueTask (critérios de decisão)
- ✅ ConfigureAwait (quando usar)
- ✅ Evitar deadlocks (fluxograma de decisão)
- ✅ Testes assíncronos (padrões corretos)
- ✅ Checklist de revisão (11 itens)
- ✅ Tabela de referência rápida
- ✅ Decisões rápidas (fluxogramas)
- ✅ Seção de Perguntas e Respostas (8 perguntas respondidas)

---

## 📝 Respostas às Perguntas de Verificação

### Pergunta 1: O que acontece com a thread no await?

**Sua Resposta:**
> "A Thread é liberada, ela volta imediatamente para o Thread Pool e pode ser utilizada. Posteriormente uma nova Thread (até a mesma) será chamada para dar continuidade, uma vez que o await é finalizado."

**Avaliação**: ✅ **CORRETO**
- Entendeu que a thread é liberada
- Compreendeu o conceito de Thread Pool
- Entendeu que pode ser a mesma ou outra thread

**Refinamento**: A thread não é "encerrada", é liberada para trabalhar em outras coisas.

---

### Pergunta 2: Buscar dados de 3 serviços

**Sua Resposta:**
> "Eu faria de forma assíncrona, pois nesse caso não me parece que uma busca depende da outra e sim que os dados serão combinados depois. Isso será vantajoso porque threads diferentes pode dar continuidade a cada await."

**Avaliação**: ✅ **CORRETO**
- Identificou corretamente que as buscas são independentes
- Entendeu a vantagem de fazer em paralelo
- Compreendeu o conceito de múltiplas threads trabalhando simultaneamente

**Próximo passo**: Ver exemplo prático com `Task.WhenAll()` quando abordarmos best practices.

---

### Pergunta 3: Diferença entre Task e Task<T>

**Sua Resposta:**
> "Quando eu defino um método de retorno como Task<T> onde T é string ou é um int, ou outro tipo, eu deixo claro que o resultado, uma vez que a task for concluída, a ser entregue, será do tipo que eu informei. Não vi ainda Task sem tipagem, mas imagino que nesse caso eu não estou entregando um retorno específico, e sim apenas indicando que a Task foi concluída."

**Avaliação**: ✅ **CORRETO**
- Entendeu que `Task<T>` retorna um valor do tipo T
- Entendeu que `Task` (sem tipo) apenas indica conclusão
- Raciocínio lógico correto sobre a diferença

**Exemplo para consolidar:**
```csharp
Task<string> taskComValor = BuscarNomeAsync(); // Retorna string
Task taskSemValor = SalvarAsync(); // Apenas indica sucesso/falha
```

---

### Pergunta 4: Dúvidas Específicas

#### 4.a - Task não é uma thread, é uma abstração

**Sua Dúvida:**
> "Num dos vídeos o autor explicou que uma Task não pode ser considerada um thread, mas sim uma abstração. Eu gostaria de mais detalhes sobre isso."

**Resolvido em**: `async-await-conceitos-avancados.md`
- ✅ Task é uma promessa de trabalho futuro (abstração)
- ✅ Thread é recurso físico (garçom)
- ✅ Uma thread pode executar múltiplas Tasks
- ✅ Analogia: Task = ticket | Thread = garçom

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.b - Thread Pool com analogia memorável

**Sua Dúvida:**
> "O que exatamente é a thread pool e qual explicação eu posso usar que é conceitualmente correta, que contenha uma boa analogia e seja fácil de memorizar?"

**Resolvido em**: `async-await-conceitos-avancados.md`
- ✅ Analogia: Equipe de garçons sempre disponíveis
- ✅ Reutilização eficiente (não cria/destrói constantemente)
- ✅ Threads pré-criadas e gerenciadas pelo .NET
- ✅ Evita custo de criar/destruir threads

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.c - ValueTask

**Sua Dúvida:**
> "Eu ainda não entendo o que é ValueTask"

**Resolvido em**: `async-await-conceitos-avancados.md`
- ✅ ValueTask é struct (value type) vs Task (class)
- ✅ Sem alocação quando completa síncronamente
- ✅ Use em hot paths e métodos que frequentemente completam rápido
- ✅ Importante: ValueTask só pode ser awaitado uma vez

**Nível de confiança após explicação**: 🟡 Médio (introdução feita, precisa de prática)

**Próximo passo**: Ver exemplos práticos e benchmarks quando abordarmos Task vs ValueTask em profundidade.

---

#### 4.d - O que é uma Struct?

**Sua Dúvida:**
> "Eu ainda tenho dúvida sobre o que exatamente é uma struct."

**Resolvido em**: `async-await-conceitos-avancados.md`
- ✅ Struct é value type (valor direto na stack)
- ✅ Class é reference type (referência no heap)
- ✅ Struct copiado por valor, class por referência
- ✅ Analogia: Class = endereço de casa | Struct = cópia do objeto
- ✅ Exemplos práticos mostrando a diferença

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.e - Por que awaitar múltiplas vezes?

**Sua Dúvida:**
> "Eu também sobre porque eu precisaria usar await mais de uma vez, ou em quais circunstâncias (já que valuetask só pode ser awaitado uma vez)"

**Resolvido em**: `async-await-conceitos-avancados.md`
- ✅ Cenários comuns: cache de Tasks, passar Task para múltiplos métodos, compartilhar entre threads
- ✅ Task pode ser armazenada e reutilizada (await múltiplas vezes)
- ✅ ValueTask é otimizado para uso único (await apenas uma vez)
- ✅ Regra prática: Task para armazenar/reutilizar, ValueTask para retorno imediato
- ✅ Exemplos práticos de código mostrando quando reutilizar Tasks

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.f - O que significa "Task pode não usar thread (hardware/DMA)"?

**Sua Dúvida:**
> "O que isso significa? Task pode não usar thread: Operações I/O podem ser completadas sem thread (hardware/DMA)"

**Resolvido em**: `async-await-conceitos-avancados.md`
- ✅ DMA (Direct Memory Access) permite hardware transferir dados sem usar CPU
- ✅ Durante operações I/O (rede, disco), nenhuma thread está ocupada
- ✅ Thread é liberada e pode trabalhar em outras coisas
- ✅ Hardware notifica quando dados estão prontos
- ✅ Analogia: CPU pede para disco fazer trabalho e fica livre

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.g - Múltiplos await = múltiplas threads?

**Sua Dúvida:**
> "É seguro eu afirmar que: Se dentro de uma Task tem 3 await, eu tenho 4 threads trabalhando? Uma trabalhando na 'Task' e 3 outras trabalhando em cada 'await'?"

**Resolvido em**: `async-await-conceitos-avancados.md`
- ✅ **ERRADO**: Múltiplos await não criam múltiplas threads
- ✅ **CORRETO**: Uma thread executa sequencialmente, liberando-se em cada await
- ✅ Thread pode trabalhar em outras Tasks durante cada await
- ✅ Múltiplas threads só quando você cria múltiplas Tasks em paralelo
- ✅ Exemplo prático mostrando diferença entre sequencial e paralelo

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.h - Deadlock e "Captura o Contexto"

**Sua Dúvida:**
> "Quando você diz que 'Se chamado de contexto UI, captura o contexto' o que isso significa exatamente? Significa por acaso que a Thread da UI, passa a ser utilizada pela biblioteca, ou seja, ela se torna responsável por executar esse await? Se sim, então como é que 'UI Thread bloqueia esperando resultado'? Me causa um pouco de confusão."

**Resolvido em**: `async-await-configureawait.md` (Seção Complementar)
- ✅ "Captura contexto" NÃO significa "usa a thread" - significa "lembra qual thread chamou e promete voltar"
- ✅ Thread é liberada durante await, mas .NET promete continuar na mesma thread depois
- ✅ `.Result` bloqueia a thread atual (UI Thread fica parada esperando)
- ✅ Deadlock: UI Thread bloqueada esperando resultado, mas resultado precisa da mesma UI Thread
- ✅ Explicação passo a passo detalhada do deadlock
- ✅ Múltiplas analogias: Restaurante, Porta, Elevador
- ✅ Diferentes ângulos: Sistema Operacional, Recursos, Fluxo de Dados
- ✅ Checklist mental para evitar deadlocks

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.i - ConfigureAwait(false) em APIs e Azure Functions

**Sua Dúvida:**
> "Outra dúvida: Como lido com isso em APIs? E em AZ Functions?"

**Resolvido em**: `async-await-configureawait.md` (Seção: Contextos Específicos)
- ✅ APIs REST (ASP.NET Core) não têm SynchronizationContext por padrão
- ✅ Azure Functions também não têm SynchronizationContext
- ✅ ConfigureAwait(false) é opcional em controllers/functions, mas recomendado
- ✅ ConfigureAwait(false) é obrigatório em services/bibliotecas
- ✅ Exemplos práticos para APIs e Azure Functions
- ✅ Comparação: UI vs API vs Azure Function
- ✅ Regra de ouro simplificada para cada contexto
- ✅ Armadilhas comuns e soluções

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.j - Validação: Explicação Detalhada do Deadlock

**Sua Explicação:**
> Explicação detalhada sobre deadlock com GetImageAsync, state machine, MoveNext, e como a thread fica bloqueada tentando recuperar o Result.

**Validação**: ✅ **100% CORRETA**
- ✅ Entendeu o fluxo completo do deadlock
- ✅ Compreendeu o conceito de state machine
- ✅ Entendeu o papel do MoveNext
- ✅ Explicou corretamente como a thread fica bloqueada
- ✅ Identificou o círculo vicioso que causa o deadlock

**Adicionado ao documento**: Seção complementar explicando state machine e MoveNext em detalhes.

**Nível de confiança**: 🟢 **Muito Alto** - Compreensão profunda demonstrada

---

#### 4.k - Razão de Existência do .Result, .Wait() e .WaitAll()

**Sua Dúvida:**
> "O Wait, o WaitAll e o Result são feitos para serem usados com código síncrono? Eu entendi que não devem ser utilizados com código assíncrono, mas fiquei em dúvida da sua razão de existência."

**Resolvido em**: `async-await-evitar-deadlocks.md` (Seção: Por que Existem?)
- ✅ Sim, são feitos para código síncrono que precisa interagir com código assíncrono
- ✅ Razão de existência: compatibilidade com código legado, pontos de entrada síncronos, interoperabilidade
- ✅ Por que são perigosos: bloqueiam threads, causam deadlocks, reduzem escalabilidade
- ✅ Casos legítimos: código legado, construtores (último recurso), Main antigo
- ✅ Quando NÃO usar: UI, APIs, Azure Functions
- ✅ Alternativas modernas: async all the way, factory pattern, lazy initialization
- ✅ Tabela comparativa: quando usar cada abordagem

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.l - As Três Formas de Evitar Deadlocks

**Sua Dúvida:**
> "Eu entendi também que uma forma é usar await all the way down. Outra é usar Task.Run(() =>...) e a terceira é usar ConfigureAwait(false). É isso mesmo?"

**Resolvido em**: `async-await-evitar-deadlocks.md` (Seção: As Três Formas)
- ✅ Sim, são três formas, mas cada uma tem propósito específico
- ✅ await all the way: Forma PREFERIDA (sempre que possível)
- ✅ ConfigureAwait(false): Para BIBLIOTECAS (evita capturar contexto)
- ✅ Task.Run(): Último recurso (quando não pode tornar assíncrono)
- ✅ Comparação detalhada das três abordagens
- ✅ Quando usar cada uma (fluxograma de decisão)
- ✅ Importante: ConfigureAwait sozinho não resolve se usar .Result na aplicação
- ✅ Importante: Task.Run ainda bloqueia thread (do pool)
- ✅ Combinação ideal: ConfigureAwait na biblioteca + await all the way na aplicação

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.m - Lock Object e SemaphoreSlim

**Sua Dúvida:**
> "Outra coisa que eu não entendi: O que é um lock object? O que é SemaphoreSlim?"

**Resolvido em**: `async-await-evitar-deadlocks.md` (Seção: O que é Lock Object e SemaphoreSlim?)
- ✅ Lock object: Objeto usado com `lock` para sincronização síncrona
- ✅ Analogia: Banheiro com chave (apenas uma thread por vez)
- ✅ SemaphoreSlim: Classe para sincronização assíncrona
- ✅ Analogia: Restaurante com mesas limitadas
- ✅ Por que não pode usar await dentro de lock (são incompatíveis)
- ✅ Como usar SemaphoreSlim com await (WaitAsync())
- ✅ Comparação detalhada: lock vs SemaphoreSlim
- ✅ Exemplos práticos: Proteger variável compartilhada, limitar conexões, cache
- ✅ Regra prática: Código síncrono → lock | Código assíncrono → SemaphoreSlim

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.n - Expressões Lambda (Lambda Expressions)

**Sua Dúvida:**
> "Eu esqueci o nome desse tipo de método. No javascript costumamos chamar isso de arrow function, como é chamado no C# ou .NET? E como fazer a leitura dessa expressão em inglês e em português ao explicar pra alguém?"

**Resolvido em**: `async-await-testar-codigo-assincrono.md` (Seção: Expressões Lambda)
- ✅ Em C# são chamadas de **Expressões Lambda** (Lambda Expressions)
- ✅ Em JavaScript são chamadas de **Arrow Functions**
- ✅ Como ler em português: "x seta x ponto ProcessarAsync" ou "x tal que chama ProcessarAsync de x"
- ✅ Como ler em inglês: "x arrow x dot ProcessarAsync" ou "x such that calls ProcessarAsync of x"
- ✅ Exemplos de leitura em contexto de Moq (Setup, Verify, It.IsAny)
- ✅ Dicas para explicar para outras pessoas
- ✅ Comparação JavaScript vs C#

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.o - async void vs async Task

**Sua Dúvida:**
> "Eu entendi que é certo usar async Task em vez de async void, mas fiquei confuso do porquê e também de quais as diferenças entre essas abordagens."

**Resolvido em**: `async-await-testar-codigo-assincrono.md` (Seção: Por que async void é Problemático?)
- ✅ async Task: Retorna Task (pode ser aguardado), exceções capturadas, framework aguarda
- ✅ async void: Não retorna nada (não pode ser aguardado), exceções podem não ser capturadas, framework não aguarda
- ✅ Por que async void é problemático em testes: Framework não pode aguardar, exceções podem não ser capturadas, teste pode passar incorretamente
- ✅ Quando async void é aceitável: Apenas em event handlers (única exceção)
- ✅ Analogia: async Task = Promessa com ticket | async void = Promessa sem ticket
- ✅ Exemplos práticos dos problemas com async void
- ✅ Regras de ouro: Sempre async Task em testes e métodos normais, async void apenas em event handlers

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.p - Protected() no Moq

**Sua Dúvida:**
> "O que significa Protected aqui? mockHandler.Protected()"

**Resolvido em**: `async-await-testar-codigo-assincrono.md` (Seção: O que é Protected() no Moq?)
- ✅ Protected é modificador de acesso em C# (membros acessíveis apenas na classe ou classes derivadas)
- ✅ Por que precisa de Protected() no Moq: SendAsync do HttpMessageHandler é protected
- ✅ Como funciona: Protected() permite acessar e mockar membros protegidos
- ✅ Sintaxe: Protected().Setup<TipoRetorno>("NomeMetodo", ItExpr.IsAny<T>())
- ✅ Diferença: Métodos públicos usam Setup(x => x.Metodo()), protegidos usam Protected().Setup("Metodo", ...)
- ✅ ItExpr vs It: ItExpr para métodos protegidos, It para métodos públicos
- ✅ Alternativa: Usar IHttpClientFactory em vez de mockar HttpMessageHandler diretamente
- ✅ Como ler/falar: "Mock handler ponto Protected ponto Setup..."

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.q - O que é Fixture?

**Sua Dúvida:**
> "E o que significa Fixture? Qual a tradução? Porque se usa esse nome? E em inglês como se explica o que é fixture?"

**Resolvido em**: `async-await-testar-codigo-assincrono.md` (Seção: O que é Fixture?)
- ✅ Fixture = Objeto com configuração compartilhada entre testes
- ✅ Tradução: "Equipamento de Teste" ou "Configuração de Teste" (mas mantém "Fixture")
- ✅ Por que o nome: Vem de hardware/engenharia (equipamento fixo para testar)
- ✅ Em inglês: "Test fixture" = "A fixed state of a set of objects used as a baseline for running tests"
- ✅ Como usar: IClassFixture<T> permite compartilhar instância entre testes
- ✅ Quando usar: Setup caro ou configuração compartilhada
- ✅ Como ler/falar: "Test Fixture" ou "configuração de teste compartilhada"
- ✅ Exemplo completo de implementação e uso

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.r - O que está Acontecendo no Teste com Mock? (Dependency Injection)

**Sua Dúvida:**
> "Sobre a simulação que está acontecendo eu fiquei um pouco confuso na interpretação: Nesse caso MeuServico seria uma classe, que precisa receber no construtor uma instância de IDependencia? Isso é como se fosse uma DI ou é como se fosse uma classe chamando a outra e passando como dependência algo que ela mesmo construiu? Ou será que é como se fosse uma dependência que havia sido resolvida na Program ou Startup?"

**Resolvido em**: `async-await-testar-codigo-assincrono.md` (Seção: O que está Acontecendo no Teste com Mock?)
- ✅ Sim, é Dependency Injection: MeuServico recebe IDependencia no construtor
- ✅ Em produção: DI container (Program/Startup) injeta implementação real
- ✅ No teste: Criamos mock manualmente e passamos no construtor
- ✅ Mock simula: Faz o papel da dependência real, mas com controle
- ✅ Comparação: Produção (DI container) vs Teste (manual)
- ✅ Exemplo completo: Código real mostrando como funciona
- ✅ Por que usar mock: Controle, isolamento, velocidade, confiabilidade
- ✅ Analogia: DI Container = Garçom que traz comida real | Teste = Criamos comida fake (mock)

**Nível de confiança após explicação**: 🟢 Alto

---

#### 4.s - ThrowsAsync (Moq e xUnit)

**Sua Dúvida:**
> "O que significa ThrowsAsync? E como funciona o Assert.ThrowsAsync? Minha interpretação: ThrowsAsync configura o mock para lançar exceção quando método for chamado. Assert.ThrowsAsync verifica se exceção foi lançada e retorna a exceção para verificações."

**Resolvido em**: `async-await-testar-codigo-assincrono.md` (Seção: O que é ThrowsAsync?)
- ✅ Validação: Sua compreensão está 100% CORRETA
- ✅ Dois ThrowsAsync diferentes: ThrowsAsync do Moq (configura mock) vs Assert.ThrowsAsync do xUnit (verifica exceção)
- ✅ ThrowsAsync do Moq: Configura mock para lançar exceção quando método for chamado
- ✅ Assert.ThrowsAsync do xUnit: Verifica se exceção foi lançada, retorna exceção, deve ser aguardado
- ✅ Exemplo completo passo a passo do fluxo
- ✅ Comparação: ThrowsAsync vs ReturnsAsync
- ✅ Por que usar await: Assert.ThrowsAsync retorna Task<TException>
- ✅ Alternativas: try-catch (não recomendada)
- ✅ Fluxo completo: Criar mock → Configurar ThrowsAsync → Obter instância → Executar → Verificar

**Nível de confiança após explicação**: 🟢 Muito Alto (compreensão validada)

---

## 📚 Documentos Criados

1. **`async-await-introducao.md`**
   - Texto introdutório baseado na auto-avaliação
   - Refinamentos dos conceitos básicos
   - Exemplos práticos
   - Links para vídeos

2. **`async-await-conceitos-avancados.md`**
   - Task vs Thread (abstração)
   - Thread Pool (analogia)
   - ValueTask (introdução)
   - Struct vs Class (explicação detalhada)
   - Por que awaitar múltiplas vezes (cenários práticos)
   - DMA e operações I/O sem thread
   - Múltiplos await vs múltiplas threads (correção de conceito)

3. **`async-await-configureawait.md`**
   - O que é SynchronizationContext
   - Por que usar ConfigureAwait(false)
   - Quando usar e quando não usar
   - Exemplos práticos (Biblioteca vs UI)
   - Armadilhas comuns e regras práticas
   - Seção complementar: Deadlocks em detalhes
   - Múltiplas analogias e explicações
   - ConfigureAwait(false) em APIs e Azure Functions

4. **`async-await-evitar-deadlocks.md`**
   - O que são deadlocks
   - Padrões que causam deadlocks
   - Como evitar deadlocks
   - Regras de ouro
   - Exemplos práticos (problemático vs correto)
   - Armadilhas especiais (locks, disposing, event handlers)
   - Múltiplas analogias para memorização

5. **`async-await-testar-codigo-assincrono.md`**
   - Por que testar código assíncrono é diferente
   - Fundamentos de testes assíncronos
   - Mocking de operações assíncronas (Moq)
   - Testar timeout e cancelamento
   - Testar múltiplas Tasks (WhenAll, WhenAny)
   - Armadilhas comuns
   - Exemplos práticos completos

---

## 🎯 Próximos Passos

### Tópicos Críticos a Abordar

1. **ConfigureAwait(false)** (0% → 100%)
   - O que é e por que existe
   - Quando usar
   - Impacto no SynchronizationContext
   - Exemplos práticos

2. **Evitar Deadlocks** (20% → 100%)
   - O que causa deadlocks
   - Padrões que causam deadlocks
   - Como evitar
   - Exemplos de código problemático vs correto

3. **Testar Código Assíncrono** (0% → 100%)
   - Como escrever testes para métodos async
   - Mocking de operações assíncronas
   - Testes de timeout e cancelamento
   - Exemplos práticos

4. **Task vs ValueTask (Aprofundamento)**
   - Benchmarks práticos
   - Quando usar cada um
   - Exemplos de código real

5. **Best Practices**
   - Nomenclatura (sufixo Async)
   - Exception handling
   - Cancellation tokens
   - Fire-and-forget patterns

6. **Async em Diferentes Contextos**
   - APIs REST
   - Console applications
   - Background services
   - Azure Functions

---

## 📝 Perguntas de Revisão (fundamentals.md)

As perguntas 6-9 do arquivo `learning/review-questions/fundamentals.md` foram respondidas:

- [x] Pergunta 6: Como funciona async/await em C#? ✅ **CONCLUÍDO** (2025-11-30)
- [x] Pergunta 7: Qual a diferença entre Task e ValueTask? ✅ **CONCLUÍDO** (2025-11-30)
- [x] Pergunta 8: O que é ConfigureAwait(false) e quando usar? ✅ **CONCLUÍDO** (2025-11-30)
- [x] Pergunta 9: Como evitar deadlocks com async/await? ✅ **CONCLUÍDO** (2025-11-30)

**Nota**: Todas as perguntas foram respondidas e salvas no arquivo `learning/review-questions/fundamentals.md`.

---

## ✅ Critérios de Conclusão da Issue

- [x] Notas de estudo criadas em `learning/` ✅ **CONCLUÍDO** (7 documentos criados)
- [ ] Exemplos práticos implementados ⏳ **PRÓXIMO** (código executável)
- [x] Perguntas de revisão respondidas (6-9) ✅ **CONCLUÍDO** (2025-11-30)
- [x] Compreensão sólida demonstrada em todos os tópicos críticos ✅ **CONCLUÍDO** (todas as perguntas respondidas com nível 4-5/5)
- [ ] Testes assíncronos implementados ⏳ **PRÓXIMO** (código executável)

---

## 📚 Documentos Criados

1. ✅ `learning/async-await-introducao.md` - Introdução e conceitos básicos
2. ✅ `learning/async-await-conceitos-avancados.md` - Task vs Thread, Thread Pool, ValueTask (introdução)
3. ✅ `learning/async-await-configureawait.md` - ConfigureAwait(false) completo
4. ✅ `learning/async-await-evitar-deadlocks.md` - Deadlocks e como evitar
5. ✅ `learning/async-await-testar-codigo-assincrono.md` - Testes assíncronos completos
6. ✅ `learning/async-await-task-vs-valuetask.md` - Task vs ValueTask (aprofundamento com benchmarks)
7. ✅ `learning/async-await-best-practices.md` - Best Practices e Guia de Referência Rápida

---

**Última Atualização**: 2025-12-06


