# Auto-Avaliação Técnica .NET e Azure

**Data de Criação**: 2025-11-24  
**Data de Conclusão**: 2025-11-24  
**Status**: Concluída  
**Issue**: #8

## Objetivo

Esta auto-avaliação tem como objetivo mapear o conhecimento atual em .NET e Azure, identificando pontos fortes e gaps que orientarão o plano de estudos.

## Instruções

- Responda cada pergunta com honestidade sobre seu conhecimento atual
- Não há respostas certas ou erradas - o objetivo é mapear seu nível atual
- Após responder todas as perguntas, revisaremos juntos para identificar áreas de foco

---

## Fundamentos .NET

### Conceitos Básicos

#### 1. Diferença entre .NET Core, .NET Framework e .NET
- **Pontuação**: 75%
- **Resposta**: .NET Core é a versão mais atual do .NET criada pela Microsoft. É por meio dele que temos como trabalhar usando multiplataforma e desenvolver os aplicativos para cloud e outros sistemas operacionais. O .NET Framework é o sistema de desenvolvimento legado, era utilizado para trabalhar apenas com desenvolvimento no Windows e hoje só usa-se em caso de trabalhar com apps legados que ainda não foram migrados. A partir da versão 5.0 do .NET Core a Microsoft resolveu renomear para .NET e é nele que estão reunidas todas as funcionalidades tanto para trabalhar com desenvolvimento de APIs web, quanto de aplicativos para desktop e também de software web. Hoje usamos o .NET para trabalhar com desenvolvimento de novos software multiplataforma, já o .NET Framework ou o .NET Core até a versão 5 usamos só para trabalhar com aplicativos legados. 

#### 2. O que é CLR (Common Language Runtime)?
- **Pontuação**: 85%
- **Resposta**: O CLR é o motor do .NET, todas as aplicações que forem finalizadas, uma vez compiladas são transcritas para uma linguagem chamada IL ou MSIL, em seguida ao rodar a aplicação esse pacote MSIL é submetido ao CLR que realiza uma espécia de compilação de runtime eu acho que é JIT o nome. Ou seja, só no momento que está rodando a aplicação é que cada funcionalidade é realmente transformada em linguagem de máquina, mas somente quando essa funcionalidade é utilizada. 

#### 3. Como funciona o Garbage Collector no .NET?
- **Pontuação**: 80%
- **Resposta**: O GC do .NET trabalha com fases eu não lembro exato o nome de cada fase, mas sei que ele tenta encontrar uma referencia para o objeto e se não conseguir alcançar ele marca aquele objeto para ser recolhido, em seguida o GC passa e remove todos os objetos que não conseguiu alcançar. Os que sobraram vão para a fase 2 que ocorre com menor frequência e os que sobrarem vão para a fase 3. Objetos maiores por sua vez já são alocados diretamente para a fase 3. Eu não lembro o tamanho exato do objeto que precisa pra ser levado para a fase 3. O GC no entanto só pode trabalhar recolhendo o que é gerenciado pelo .NET, outros casos por exemplo o leitor de arquivos, que não é grenciado, é necessário que o desenvolvedor programe a gestão de forma manual. 

#### 4. Diferença entre Stack e Heap em .NET
- **Pontuação**: 75%
- **Resposta**: A Stack é o lugar onde são armazenados valores diretamente, o .NET tem dois tipos, os objetos de valor e os objetos de referencia. Tipos comuns como int, bool, char, tuple, entre outros são armazenados diretamente na Stack e quando consultamos a variável nos devolve o valor. Entretanto outros tipos de objeto como String, Class, são armazenados como referência e o que temos na variável é o endereço da Heap onde realmente estão guardadas as informações. QUando copiamos uma variável se ela for um value object copiamos o valor diretamente, mas se for um reference object apenas copiamos o endereço Heap e isso pode causar as vezes confusão, pois duas variáveis podem estar referenciando o mesmo endereço e quando alterada uma altera a outra por consequência de que elas não estão realmente guardando o valor e sim a referencia. Na Stack as coisas são armazenadas em pilha, conforme o nome já diz, na Heap eu acabei esquecendo. 

#### 5. O que são Value Types e Reference Types?
- **Pontuação**: 70%
- **Resposta**: Value types são valores que são armazenados diretamente como int, bool, tuple e char. Reference Types são valores que guardamos apenas uma referencia enquanto o seu conteúdo fica na Heap Memory. Alguns exemplos que me lembro são String e Class. 

### Async/Await

#### 6. Como funciona async/await em C#?
- **Pontuação**: 70%
- **Resposta**: Quando eu uso o async/await o C# faz com que aquela variável que está esperando o valor, ou seja, aguardando pelo retorno de algo para ser preenchida, encerre aquela thread e devolva o controler para o caller que por sua vez dá continuidade ao trabalho. Posteriormente (Geralmente nos próximos milésimos de seungods) quando o valor é entregue, outra thread assume e continua de onde parou. 

#### 7. Qual a diferença entre Task e ValueTask?
- **Pontuação**: 30%
- **Resposta**: Eu lembro que ValueTask tem maior performance, mas esqueci quando usar cada e as diferenças. 

#### 8. O que é ConfigureAwait(false) e quando usar?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 9. Como evitar deadlocks com async/await?
- **Pontuação**: 20%
- **Resposta**: Eu sei que no async/await uma exceção pode ser um grande problema e parece que a forma de tratar isso é trabalhando com algo parecido com delegate, não sei direito o nome, acho que event driven. 

### LINQ e Collections

#### 10. Diferença entre IEnumerable, ICollection, IList e IQueryable
- **Pontuação**: 0%
- **Resposta**: Não sei. Preciso estudar mais sobre isso. 

#### 11. Quando usar List vs Array vs IEnumerable?
- **Pontuação**: 50%
- **Resposta**: Eu sei que Array vale a pena usar quando tu sabe o tamanho, se for um tamanho fixo vale mais a pena trabalhar com Array pois tem maior performance. Agora List e Enumerable eu fico com dificuldade de responder, eu sei que eu posso trabalhar com Linq em List e estou incerto se posso com IEnumarable. 

#### 12. Diferença entre Select, Where e SelectMany no LINQ
- **Pontuação**: 40%
- **Resposta**: Eu não tenho certeza, mas imagino que o Select vai selecionar apenas o primeiro correspondente enquanto o SelectMany vai selecionar vários e Where é onde defini a condição para o que vou selecionar. 

#### 13. O que é deferred execution no LINQ?
- **Pontuação**: 75%
- **Resposta**: Quando tu escreve uma query em LINQ ele não a executa imediatamente, somente quando essa variável que vai guardar o resultado da query é utilizada. O impacto é vantajoso, pois aumenta a performance, uma vez que nem sempre a variável será utilizada, dependendo das condições do código. Mas eu falho aqui, pois esqueci exatamente, embora lembre que há uma forma de fazer ela ser executada imediatamente... 

### Dependency Injection

#### 14. O que é Dependency Injection e por que usar?
- **Pontuação**: 80%
- **Resposta**: DI é uma forma intaligente de lidar com dependência, no .NET podemos definir as injeções no program ou startup e posteriormente quando injetamos uma interface o .NET já sabe quem é responsável por lidar com aquela injeção. O benefício é facilidade ao trabalhar com a programação, pois já está definido o responsável por lidar, outro benefício é que posteriormente se precisarmos definir outro responsável por lidar com aquela dependência só precisamos fazer isso em um lugar do código. Eu gostaria de saber outros benefícils. 

#### 15. Diferença entre Scoped, Transient e Singleton no DI
- **Pontuação**: 60%
- **Resposta**: Eu sei o que é Singleton, quando uma dependência é desse tipo, significa que, numa API por exemplo, mesmo que múltiplos requests aconteçam e mesmo que sejam de diferentes usuários, ela vai compartilhar o estado entre todos.. É interessante compartilhar isso por exemplo, num gerador de ID, que precise gerar IDs sequenciais evitando conflitos, digamos ele gera para um e ao ficar livre, gera para outro e vai guardando os estados. Agora posso estar meio errado e ser inverso ali, mas entre o Transient e o Scoped eu acredito que: O Transient fica vivo durante um único request, digamos que vão ser chamadas 3 camadas de uma aplicação, e 2 delas usam a mesma dependência, acredito que na primeira ao chamar, ela ainda fica viva e mantém os estados das suas viaráveis internas para quando for chamada a segunda vez. Eu acho que dá pra trabalhar com hashs compartilhados, quem sabe um traceId que quero passar de uma camada pra outra. Já o scoped fica vivo apenas enquanto aquela classe estiver viva, ou seja, se chamar 3 classes que usam aquela mesma dependência, durante a vida do request, ele vai instanciar 3 vezes. Então eu usaria quando não quero compartilhar estados de variáveis e tal para outras classes. 

#### 16. Como funciona o ServiceProvider no .NET?
- **Pontuação**: 0%
- **Resposta**: Não sei 

### Testing

#### 17. Diferença entre Unit Test, Integration Test e E2E Test
- **Pontuação**: 85%
- **Resposta**: Unit Test são os tipos de testes que trabalham apenas uma classe, ou seja, cada pedaço da aplicação, cada classe, tem seu teste específico, as dependências, são mockadas. Os testes de Integração por sua vez são parecidos, mas não é mockada a dependência. Ou seja se eu testo uma classe que depende de outras 2, eu vou passar pelas outras 2 também durante esse teste de verdade. O E2E é quando quero fazer o teste completo, desde o front, passando pelo back até voltar ao front. 

#### 18. O que são Mocks, Stubs e Fakes?
- **Pontuação**: 50%
- **Resposta**: Mocks eu sei, os outros 2 não. No caso Mocks são aquelas classes que respondem com alguma informação, são dependências da unidade que estou testando e quando quero testar cenários específicos eu já mocko as dependências, ou seja, simulo que aquela dependência está respondendo com x ou y para simular um caso específico. 

#### 19. Como testar código assíncrono?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

### Performance

#### 20. O que é Span<T> e Memory<T> e quando usar?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 21. Como fazer profiling de performance em .NET?
- **Pontuação**: 0%
- **Resposta**: Não sei nem o que é profiling. 

#### 22. O que são boxing e unboxing e como evitá-los?
- **Pontuação**: 40%
- **Resposta**: São as operações em que movo um valor da heap para a stack e vice-versa. Eu sei que tem impacto na performance, eu não sei como definir isso exatamente. Gostaria de saber como evitar com exemplos claros. 

---

## Serviços Azure

### Azure App Service

#### 23. O que é Azure App Service e quando usar?
- **Pontuação**: 40%
- **Resposta**: Eu sei que geralmente no Azure App Service é onde se hospeda o front de uma aplicação, ou até mesmo podemos guardar lá uma aplicação inteira front/back. Mas não sei definir exatamente o que é e os benefícios. 

#### 24. Diferença entre App Service Plan Consumption e Dedicated
- **Pontuação**: 70%
- **Resposta**: Eu sei que, pelo nome, um é dedicado, ou seja, os recursos definidos estão alocados ad eternum, enquanto o outro vai fazer escalamento conforme consumo. Pode ser que durante essa escala acabe impactando a performance, mas em contrapartida o custo é menor, enquanto no outro caso a performance é fixa, mas o custo é maior. 

#### 25. Como configurar deployment slots no App Service?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

### Azure Functions

#### 26. Quando usar Azure Functions vs App Service?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 27. Quais são os tipos de triggers disponíveis no Azure Functions?
- **Pontuação**: 50%
- **Resposta**: Todos os tipos é complicado, sei que tem HTTP, TimeTrigger, Blob Storage change of state, Banco de dados, etc. 

#### 28. Diferença entre Consumption Plan e Premium Plan no Functions
- **Pontuação**: 0%
- **Resposta**: Não sei. 

### Azure Service Bus

#### 29. Quando usar Service Bus vs Storage Queue vs Event Grid?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 30. O que é Dead Letter Queue e quando usar?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 31. Diferença entre Topics e Queues no Service Bus
- **Pontuação**: 0%
- **Resposta**: Não sei. 

### Azure Storage

#### 32. Quando usar Blob Storage vs Table Storage vs File Share?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 33. O que são access tiers no Blob Storage?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 34. Como implementar retry policies com Azure Storage?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

### Azure SQL Database

#### 35. Diferença entre Azure SQL Database, Managed Instance e SQL Server em VM
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 36. O que é DTU vs vCore no Azure SQL?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 37. Como implementar connection pooling no Azure SQL?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

### Azure Key Vault

#### 38. Quando e como usar Azure Key Vault?
- **Pontuação**: 60%
- **Resposta**: O Azure KV serve para guardar secrets, eu não sei como integrar ele, mas acho que é via connection string e mais alguma biblioteca eu imagino específica pra isso. Devemos utilizar em vez de ficar colocando keys e secrets diretamente como variáveis de ambiente ou no appsettings. A vantagem é que os devs não terão acesso direto a essas informações e quando alguém sair do time podemos rotacionar. Sei que há mais vantagens, mas não lembro. 

#### 39. Como configurar Managed Identity para acessar Key Vault?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

### Azure Cosmos DB

#### 40. Quando usar Cosmos DB vs SQL Database?
- **Pontuação**: 70%
- **Resposta**: O CosmosDB usamos quando precisamos trabalhar com NoSQL. por exemplo para armazenar grandes estruturas de JSON. É super vantajoso, pois é um banco criado especificamente para isso. A desvantagem está ligada justamente a vantagem, não podemos fazer JOINs, ou seja se eu precisar de juntar 2 ou mais documentos eu preciso de múltiplos requests e em seguida trabalhar isso diretamente na minha aplicação. O SQL por sua vez trabalha diretamente com uma linguagem mais conhecidas e com tabelas, podendo fazer múltiplos joins de informação e se trabalhar corretamente com IDs e etc, tem grande performance e evita repetir informação. 

#### 41. O que é Request Units (RU) no Cosmos DB?
- **Pontuação**: 30%
- **Resposta**: Eu não sei, eu acho que cada request é uma RU, por exemplo se eu rodar uma query pra pegar um documento no Cosmos eu imagino que gasto 1 RU. 

#### 42. Como funciona o Change Feed no Cosmos DB?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

### Azure Event Grid

#### 43. Quando usar Event Grid vs Service Bus vs Event Hubs?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 44. Como implementar event-driven architecture com Event Grid?
- **Pontuação**: 0%
- **Resposta**: Não sei, mas quero aprender, já gostei. 

### Azure API Management

#### 45. Quando usar Azure API Management?
- **Pontuação**: 75%
- **Resposta**: Quando eu não quero expor diretamente o back da minha API eu posso trabalhar com o APIM. Uma das vantagens é que posso definir regras específicas. Posso fazer transformações de dados, ao receber um request posso editar e repassar já ajustado algo. Posso fazer transformações ao devolver os responses também. Criar regras específicas. Posso expor múltimas APIs em um único APIM, dando a impressão para o consumidor que é uma coisa só. Possso documentar informações também. 

#### 46. Como implementar rate limiting e throttling no API Management?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

### Security e Identity

#### 47. O que é Managed Identity e quando usar?
- **Pontuação**: 0%
- **Resposta**: Não sei 

#### 48. Diferença entre System-assigned e User-assigned Managed Identity
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 49. Como implementar RBAC no Azure?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

### Monitoring e Logging

#### 50. Como usar Application Insights para monitoramento?
- **Pontuação**: 50%
- **Resposta**: Quando tu trabalhar com o Application Insights, você pode fazer a implementação no .net eu acredito que é uma biblioteca própria e só requer fazer apontamento da connection string e também fazer a injeção ao usar logs, eu não lembro de cabeça os detalhes da implementação. 

#### 51. Diferença entre Log Analytics e Application Insights
- **Pontuação**: 0%
- **Resposta**: Não sei. 

#### 52. Como implementar distributed tracing no Azure?
- **Pontuação**: 0%
- **Resposta**: Não sei. 

---

## Análise e Próximos Passos

### Resumo Estatístico

- **Total de perguntas**: 52
- **Pontuação média geral**: ~35%
- **Pontuação .NET**: ~45%
- **Pontuação Azure**: ~25%

### Pontos Fortes Identificados

#### Fundamentos .NET (Bom conhecimento base)
- ✅ **CLR e Runtime**: 85% - Entendimento sólido do funcionamento do CLR e JIT compilation
- ✅ **Garbage Collector**: 80% - Compreensão das fases do GC e gerenciamento de memória
- ✅ **Dependency Injection**: 80% - Boa compreensão do conceito e uso prático
- ✅ **Testing**: 85% - Excelente entendimento dos tipos de testes (Unit, Integration, E2E)
- ✅ **Conceitos básicos**: 70-75% - Stack/Heap, Value/Reference Types, .NET Core/Framework

#### Azure (Conhecimento parcial)
- ✅ **API Management**: 75% - Boa compreensão do conceito e casos de uso
- ✅ **Cosmos DB**: 70% - Entendimento da diferença entre NoSQL e SQL
- ✅ **App Service Plans**: 70% - Compreensão básica de Consumption vs Dedicated

### Gaps Identificados

#### Críticos (0% de conhecimento - Alta prioridade)

**Azure - Mensageria e Event-Driven**
- ❌ Service Bus vs Storage Queue vs Event Grid (quando usar cada um)
- ❌ Dead Letter Queue e tratamento de mensagens falhas
- ❌ Topics vs Queues no Service Bus
- ❌ Event-driven architecture com Event Grid

**Azure - Storage**
- ❌ Diferenças entre Blob Storage, Table Storage e File Share
- ❌ Access tiers no Blob Storage
- ❌ Retry policies com Azure Storage

**Azure - Banco de Dados**
- ❌ Diferenças entre Azure SQL Database, Managed Instance e SQL Server em VM
- ❌ DTU vs vCore no Azure SQL
- ❌ Connection pooling no Azure SQL
- ❌ Request Units (RU) no Cosmos DB
- ❌ Change Feed no Cosmos DB

**Azure - Security e Identity**
- ❌ Managed Identity (conceito e uso)
- ❌ System-assigned vs User-assigned Managed Identity
- ❌ RBAC no Azure
- ❌ Configurar Managed Identity para Key Vault

**Azure - Monitoring**
- ❌ Log Analytics vs Application Insights
- ❌ Distributed tracing no Azure

**Azure - Functions**
- ❌ Quando usar Functions vs App Service
- ❌ Consumption Plan vs Premium Plan no Functions
- ❌ Deployment slots no App Service

**.NET - Performance e Avançado**
- ❌ Span<T> e Memory<T>
- ❌ Profiling de performance em .NET
- ❌ Boxing e unboxing (conceito básico conhecido, mas falta profundidade)

**.NET - Async/Await Avançado**
- ❌ ConfigureAwait(false) e quando usar
- ❌ Como evitar deadlocks com async/await
- ❌ Task vs ValueTask (conceito básico conhecido)

**.NET - LINQ e Collections**
- ❌ Diferenças entre IEnumerable, ICollection, IList e IQueryable
- ❌ Select vs SelectMany no LINQ (conceito parcial)
- ❌ List vs Array vs IEnumerable (conceito parcial)

**.NET - Dependency Injection**
- ❌ ServiceProvider interno (como funciona)
- ❌ Scoped vs Transient (conceito invertido - precisa correção)

**.NET - Testing**
- ❌ Como testar código assíncrono
- ❌ Stubs e Fakes (só conhece Mocks)

### Prioridades de Estudo

#### Prioridade ALTA (Semana 1-2)

1. **Async/Await em .NET** (Issue #11 já existe)
   - ConfigureAwait(false)
   - Evitar deadlocks
   - Task vs ValueTask
   - Testar código assíncrono

2. **Azure App Service** (Issue #12 já existe)
   - Conceitos fundamentais
   - Deployment slots
   - Quando usar vs Functions

3. **LINQ e Collections**
   - IEnumerable, ICollection, IList, IQueryable
   - Select vs SelectMany
   - List vs Array vs IEnumerable

4. **Dependency Injection - Correção de Conceitos**
   - Scoped vs Transient (corrigir entendimento invertido)
   - ServiceProvider interno

#### Prioridade MÉDIA (Semana 2-3)

5. **Azure Functions**
   - Quando usar vs App Service
   - Consumption vs Premium Plan
   - Triggers disponíveis (aprofundar)

6. **Azure Service Bus e Mensageria**
   - Service Bus vs Storage Queue vs Event Grid
   - Dead Letter Queue
   - Topics vs Queues

7. **Azure Storage**
   - Blob vs Table vs File Share
   - Access tiers
   - Retry policies

8. **Azure Key Vault**
   - Integração prática
   - Managed Identity para acesso

#### Prioridade BAIXA (Semana 3-4)

9. **Azure SQL Database**
   - Diferenças entre opções (Database, Managed Instance, VM)
   - DTU vs vCore
   - Connection pooling

10. **Azure Cosmos DB**
    - Request Units (RU) detalhado
    - Change Feed

11. **Performance .NET**
    - Span<T> e Memory<T>
    - Profiling
    - Boxing/unboxing (aprofundar)

12. **Security e Identity Azure**
    - Managed Identity completo
    - RBAC

13. **Monitoring Azure**
    - Log Analytics vs Application Insights
    - Distributed tracing

### Recomendações de Ajuste nas Issues Existentes

#### Issues que precisam de sub-tarefas ou ajustes:

**Issue #11 - Revisão: Async/Await em .NET** (High, Week 1)
- ✅ Prioridade correta
- ✅ Sprint correta
- 📝 Adicionar sub-tarefas:
  - ConfigureAwait(false) e quando usar
  - Como evitar deadlocks
  - Task vs ValueTask
  - Testar código assíncrono

**Issue #12 - POC: Azure App Service + API REST** (High, Week 1)
- ✅ Prioridade correta
- ✅ Sprint correta
- 📝 Adicionar sub-tarefas:
  - Estudar conceitos fundamentais do App Service
  - Configurar deployment slots
  - Entender quando usar vs Functions

**Issue #16 - .NET Core vs .NET Framework** (High, Week 2)
- ✅ Prioridade correta
- ✅ Sprint correta
- 📝 Pode ser mantida como está

**Issue #17 - Memory Management e Garbage Collector** (High, Week 2)
- ✅ Prioridade correta
- ✅ Sprint correta
- 📝 Adicionar sub-tarefas:
  - Revisar fases do GC (Gen 0, 1, 2)
  - Large Object Heap (LOH)
  - Boxing/unboxing e como evitar

#### Novas issues sugeridas:

1. **Estudar LINQ e Collections** (Medium, Week 1-2)
   - IEnumerable, ICollection, IList, IQueryable
   - Select vs SelectMany
   - List vs Array vs IEnumerable

2. **Corrigir conceitos de Dependency Injection** (Medium, Week 2)
   - Scoped vs Transient (corrigir entendimento)
   - ServiceProvider interno

3. **Azure Functions - Conceitos Fundamentais** (High, Week 2-3)
   - Quando usar vs App Service
   - Consumption vs Premium Plan
   - Triggers disponíveis

4. **Azure Service Bus e Mensageria** (High, Week 3)
   - Service Bus vs Storage Queue vs Event Grid
   - Dead Letter Queue
   - Topics vs Queues

5. **Azure Storage - Conceitos** (Medium, Week 3)
   - Blob vs Table vs File Share
   - Access tiers
   - Retry policies

6. **Azure Key Vault - Integração Prática** (Medium, Week 3)
   - Integração com .NET
   - Managed Identity para acesso

7. **Performance .NET - Span<T> e Memory<T>** (Low, Week 4)
   - Conceitos e quando usar
   - Profiling de performance

8. **Azure Monitoring** (Medium, Week 4)
   - Log Analytics vs Application Insights
   - Distributed tracing 

---

**Última Atualização**: 2025-11-24

