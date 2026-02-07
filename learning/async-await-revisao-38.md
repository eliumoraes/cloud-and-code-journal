# Revisão espaciada: Async/Await em .NET (Issue #38)

**Data de Criação**: 2026-02-06  
**Última Atualização**: 2026-02-06  
**Issue**: #38

Respostas serão preenchidas conforme você responder, uma pergunta por vez. Formato: sua resposta → nota → resposta melhorada pela IA → opcional: esclarecimentos solicitados e explicados.

---

## 1. Conceitos Básicos

### Pergunta 1
O que acontece com a thread quando você usa await?

Resposta: Quando eu uso await, a thread que estava sendo utilizada é automaticamente devolvida para o thread pool. Nesse momento todo o estado da classe/código que estava é "embalado" e transformado em uma "state machine", as variáveis que já estavam definidas e etc ali dentro ficam guardadas neste "frozen state" e aquela task que precisa ser awaitada é delegada para outro (as vezes uma interface de rede por exemplo, as vezes uma atividade de reading do computador) e quando voltar, ela vai ativar um next da minha state que então recebe e vai continuar de onde parou.

**Nota**: 4,5/5 – Muito bom. Você captou o essencial: thread devolvida ao pool, estado guardado na state machine, trabalho delegado (I/O ou outro), e continuação depois.

Resposta melhorada pela IA: Quando uso await, a thread que estava em uso é devolvida ao thread pool. Nesse momento o estado do método (variáveis locais, ponto em que parou, etc.) é “embalado” numa state machine e fica guardado nesse “frozen state”. O trabalho que precisa ser aguardado (por exemplo uma chamada de rede ou uma leitura em disco) é delegado — às vezes para o hardware ou para o SO, sem ocupar thread. Quando esse trabalho termina, a continuação é disparada (o “next” da state machine, o MoveNext), em geral em alguma thread do pool, e o método segue de onde parou.

---

### Pergunta 2
O que é um state machine no contexto de async/await?

Resposta: Um state machine, no contexto de async/await, é uma espécie de estado em que o método estava antes que um "awaite" fosse atingido. Ele contém informações que as variáveis estavam armazenando, informações que as propriedades, instâncias de classe e fields estava "segurando" antes da chamada desse "await". Esse state machine também contém o execution point que havia sido alcançado do método, ou seja o ponto em que parou, para referência quando uma thread reassumir e continuar de onde a outra parou.

**Nota**: 4,5/5 – Muito bom. Você descreveu corretamente o que a state machine guarda (variáveis, propriedades, instâncias, ponto de execução) e para que serve (retomar de onde parou).

Resposta melhorada pela IA: No contexto de async/await, a state machine é a estrutura que o compilador gera para guardar o estado do método no momento em que um await é atingido. Ela contém tudo o que precisa ser preservado: os valores das variáveis locais, o que as propriedades, instâncias e fields estavam “segurando” antes desse await. Também guarda o ponto de execução — onde o método parou — para que, quando uma thread (geralmente do pool) reassumir o trabalho, possa continuar exatamente de onde a outra parou.

---

### Pergunta 3
O que é MoveNext e qual seu papel?

Resposta: MoveNext é um método padrão da state machine. O papel dele é servir como ponto de chamada, uma ordem que é disparada, quando um await que estava sendo executado é finalizado. Esse MoveNext é o próximo ponto que a thread que volta do thread pool vai retomar assim que iniciar a execução. Eu imagino que há algum parâmetro que ele recebe, mas estou incerto.

**Nota**: 4,5/5 – Muito bom. Você acertou o essencial: MoveNext é o método da state machine que é chamado quando o await termina, e é por aí que a thread (do pool) retoma a execução.

Resposta melhorada pela IA: MoveNext é o método da state machine (gerada pelo compilador) que faz o “próximo passo”. O papel dele é ser o ponto de chamada: quando um await termina, a continuação que foi agendada chama MoveNext na instância da state machine. A thread que pegar esse trabalho (em geral vinda do thread pool) executa MoveNext e o método segue dali em diante, de onde tinha parado. Quanto ao parâmetro: MoveNext() em geral não recebe parâmetros; o “estado” (variáveis, ponto em que parou) já está guardado nos campos da própria state machine, então ela sabe o que fazer quando MoveNext é invocado.

---

### Pergunta 4
Task é uma thread? Explique a diferença.

Resposta: Task não é uma thread. Task é na verdade um tipo/classe já pré definido pelo C#/DotNet que tem suporte nativo a métodos assíncronos. Uma Task já tem seus retornos pré definidos como CompletedTask e também erros que podem ser disparadaos(throwed). Uma task é executada por uma thread. Task e threads são coisas diferentes.

**Nota**: 4,5/5 – Muito bom. Você deixou claro que Task é tipo/classe do .NET, que é executada por thread(s), e que são conceitos diferentes.

Resposta melhorada pela IA: Task não é uma thread. Task é um tipo/classe do .NET que representa uma operação assíncrona — uma "promessa" de trabalho que será ou já está sendo feita. Ela tem suporte nativo a métodos assíncronos, estados como CompletedTask e exceções que podem ser lançadas (thrown). Quem de fato executa o trabalho é uma (ou mais) thread; a Task é a abstração em cima disso. Em resumo: thread é o recurso que executa; Task é o "ticket" que representa a operação e seu resultado (ou erro).

Solicitou esclarecimento: Quais os possíveis retornos de uma Task? A "promessa" pode ser cumprida ou não — quais são as possibilidades? Foi explicado que uma Task pode terminar em três desfechos: (1) **Concluída com sucesso** (RanToCompletion): a promessa foi cumprida; em Task&lt;T&gt; há um valor de retorno, em Task é só CompletedTask; (2) **Falha** (Faulted): a operação lançou exceção(ões), a Task fica faulted e ao fazer await a exceção é relançada; (3) **Cancelada** (Canceled): a operação foi cancelada (ex.: CancellationToken); ao fazer await resulta em OperationCanceledException. Além disso existem estados intermediários (Created, WaitingToRun, Running, etc.), mas o que importa para o resultado da promessa são esses três fins: sucesso, falha ou cancelamento.


---

### Pergunta 5
O que significa dizer que Task é uma abstração?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 6
Uma thread pode executar múltiplas Tasks?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 7
O que é Thread Pool?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 8
Por que usar Thread Pool em vez de criar threads manualmente?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 9
Como o Thread Pool se relaciona com async/await?

Resposta: 

Resposta melhorada pela IA: 


---

## 2. Task vs ValueTask

### Pergunta 10
Qual a diferença entre Task e ValueTask?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 11
Quando usar Task?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 12
Quando usar ValueTask?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 13
Por que ValueTask só pode ser awaitado uma vez?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 14
Task é class ou struct?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 15
ValueTask é class ou struct?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 16
Qual o impacto na memória de cada um (Task vs ValueTask)?

Resposta: 

Resposta melhorada pela IA: 


---

## 3. ConfigureAwait(false)

### Pergunta 17
O que é SynchronizationContext?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 18
O que faz ConfigureAwait(false)?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 19
Por que ConfigureAwait(false) evita deadlocks?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 20
Quando usar ConfigureAwait(false)?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 21
Quando NÃO usar ConfigureAwait(false)?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 22
ConfigureAwait(false) é necessário em APIs REST?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 23
ConfigureAwait(false) é necessário em Azure Functions?

Resposta: 

Resposta melhorada pela IA: 


---

## 4. Deadlocks

### Pergunta 24
O que é um deadlock?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 25
Como deadlocks acontecem com async/await?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 26
Explique o deadlock passo a passo quando se usa .Result em UI Thread.

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 27
Quais são as três formas de evitar deadlocks?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 28
Qual é a forma preferida (de evitar deadlocks)?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 29
Quando usar cada uma das três formas de evitar deadlocks?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 30
Por que .Result, .Wait() e .WaitAll() são perigosos?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 31
Por que não pode usar await dentro de lock?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 32
O que é SemaphoreSlim e quando usar?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 33
Qual a diferença entre lock e SemaphoreSlim?

Resposta: 

Resposta melhorada pela IA: 


---

## 5. Operações I/O e Threads

### Pergunta 34
O que significa que operações I/O podem ser completadas sem thread?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 35
O que é DMA (Direct Memory Access)?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 36
Por que isso (I/O sem thread / DMA) é importante para performance?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 37
Se uma Task tem 3 await, quantas threads trabalham simultaneamente?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 38
O que acontece quando você tem múltiplos await em sequência?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 39
Quando você realmente tem múltiplas threads trabalhando?

Resposta: 

Resposta melhorada pela IA: 


---

## 6. Contextos Específicos

### Pergunta 40
ConfigureAwait(false) é necessário em controllers de API?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 41
ConfigureAwait(false) é necessário em services de API?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 42
Por que APIs não têm SynchronizationContext?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 43
ConfigureAwait(false) é necessário em Azure Functions?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 44
Qual a diferença entre Functions e APIs em relação a async/await?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 45
Por que não usar ConfigureAwait(false) em código que atualiza UI?

Resposta: 

Resposta melhorada pela IA: 


---

### Pergunta 46
O que acontece se você usar ConfigureAwait(false) em código UI?

Resposta: 

Resposta melhorada pela IA: 


---

**Total**: 46 perguntas. Recursos: `learning/async-await-*.md` e Issue #11.
