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

Resposta: Quando criamos uma Task, ela é uma referência na memória para uma atividade, para um método ou conjunto de métodos. Sobre a Task ser uma abstração, significa que é uma referência à classe e não a classe em si. Ela é chamada de uma "promessa" e pode entregar 3 tipos de estados nessa promessa (Success, Fault, Cancelled). Sobre ser uma abstração, acredito que é pelo fato de não ser possível identificar "o que exatamente" essa Task é, mas sim o que ela representa. É importante eu me aprofundar e ter uma explicação melhor que a minha para essa situação.

**Nota**: 4/5 – Você acertou a ideia de “promessa” e dos três desfechos, e que a Task representa algo em vez de “ser” o mecanismo concreto. Aprofundamento abaixo deixa mais preciso em que sentido ela é uma abstração.

Resposta melhorada pela IA: Task é uma abstração no sentido de que **esconde o mecanismo concreto** por trás do trabalho assíncrono. Você não lida diretamente com “qual thread está rodando”, “se é I/O esperando o SO” ou “se está na fila do pool” — você lida com um único conceito: uma **promessa de resultado** (ou falha, ou cancelamento). Ou seja: abstraímos os detalhes de implementação (thread, pool, I/O, completion port) e trabalhamos só com a ideia de “operação que vai terminar e me dar um resultado”. Por isso “abstração”: não é que seja “referência à classe e não a classe” (a Task é de fato uma instância de classe); é que ela **representa** “trabalho assíncrono” de forma uniforme, independente de como esse trabalho está sendo executado por baixo. Em resumo: Task abstrai o “como” (thread, I/O, etc.) e expõe só o “o quê” (uma operação que completa, falha ou é cancelada).

Solicitou aprofundamento: pediu uma explicação melhor. Foi explicado que a abstração está em esconder o mecanismo concreto (thread, I/O, pool) e expor apenas a “promessa” de resultado/falha/cancelamento, de forma uniforme.

---

### Pergunta 6
Uma thread pode executar múltiplas Tasks?

Resposta: Não. Cada thread executa uma task por vez. Quando uma thread atinge um await, que pode ser uma task por exemplo, a state machine vai ser criada e a thread vai voltar para o pool thread. Embora possa acontecer que a mesma thread acabe assumindo essa task do exemplo anterior, isso já não é a mesma vez.

**Nota**: 4,5/5 – Correto: uma thread executa uma tarefa por vez; ao atingir await ela volta ao pool; se a mesma thread reassumir depois, já é em outro momento, não “ao mesmo tempo”.

Resposta melhorada pela IA: Não ao mesmo tempo — uma thread executa uma tarefa (ou um trecho de uma Task) por vez. Quando essa thread encontra um await, a state machine é criada, a thread é devolvida ao pool e pode ser usada para outra coisa. Quando o await termina, alguma thread (pode ser a mesma ou outra) pega a continuação e executa. Ou seja: em qualquer instante, uma thread está fazendo só uma coisa; ao longo do tempo, a mesma thread pode ter executado várias Tasks ou continuações, mas sempre uma por vez. Por isso a resposta é “não” para “múltiplas Tasks ao mesmo tempo” e “sim” para “uma mesma thread pode ter trabalhado em várias Tasks em momentos diferentes”.

---

### Pergunta 7
O que é Thread Pool?

Resposta: Thread pool é uma área do .NET, uma área do motor do .NET onde ficam as threads, os recursos, que vão ser utilizados pelo .NET a fim de executar seções de código.

**Nota**: 4/5 – Você acertou: é um recurso do runtime .NET onde ficam threads prontas para executar código. A resposta melhorada reforça a ideia de “pool” (reutilização, não criar/destruir a cada uso).

Resposta melhorada pela IA: O Thread Pool é um conjunto de threads mantido pelo runtime .NET, prontas para executar trabalho. Em vez de criar uma thread nova a cada operação (o que é custoso), o .NET mantém um “reservatório” de threads já criadas; quando há trabalho (por exemplo uma continuação após um await, ou um Task.Run), o runtime pega uma thread disponível do pool, usa e depois devolve. Assim as threads são reutilizadas e o custo de criar/destruir thread fica bem menor. Em resumo: é a “área” do motor .NET onde ficam essas threads reutilizáveis que executam trechos de código sob demanda.

---

### Pergunta 8
Por que usar Thread Pool em vez de criar threads manualmente?

Resposta: Usamos o Threado Pool pois podemos manter as threads já criadas e prontas para uso. Ume vez que realizamos a execução de uma nova Task (Task.Run) ou a continuação de uma Task depois de um await (MoveNext) a thread já se encontra criada e pronta para uso. Logo o custo é menor e a performance é maior. Por outro lado uma vez que essa thread termina sua missão temporária o runtime do .NET só precisa devolver ela para o pool que então ficará disponível para ser utilizada novamente.

**Nota**: 4,5/5 – Muito bom. Você citou reutilização, custo menor, performance maior, Task.Run e continuação após await, e a devolução da thread ao pool.

Resposta melhorada pela IA: Usamos o Thread Pool porque as threads já ficam criadas e prontas para uso. Quando precisamos executar uma nova Task (Task.Run) ou a continuação de uma Task depois de um await (MoveNext), a thread já está lá — não precisamos criar do zero. Criar e destruir thread manualmente tem custo alto (stack, recursos no SO, etc.); no pool, a thread é só “pegada”, usada e devolvida, então o custo é menor e a performance é maior. Quando a thread termina sua missão temporária, o runtime do .NET devolve ela ao pool e ela fica disponível para o próximo trabalho. Em resumo: reutilização em vez de criar/destruir a cada vez.

---

### Pergunta 9
Como o Thread Pool se relaciona com async/await?

Resposta: O Thread Pool mantém threads disponíveis e prontas para uso. As atividades assíncronas, como Tasks, vão precisar de recursos que rodem/executem o código que é contido dentro delas. O Thread Pool disponibiliza essas threads, esses recursos, que por sua vez possuem a missão de rodar esse código e após isso o Thread Pool recebe de volta as threads. É como se o Thread Pool falasse "- Hey eu vou manter as threads aqui, tu pode pegar quando quiser, usar pra rodar seus códigos assíncronos e devolver uma vez que terminar." O Thread Pool é uma espécie de guarda recursos do async/await. Toda vez que um await é atingido esse recurso volta ao Thread Pool, ficando disponível para ser utilizado na próxima vez.

**Nota**: 5/5 – Muito bom. Você descreveu o fluxo: pool mantém threads, async/await usa essas threads para rodar o código (e as continuações), ao atingir await a thread volta ao pool, e a analogia do “guarda-recursos” ficou clara.

Resposta melhorada pela IA: O Thread Pool mantém threads disponíveis e prontas para uso. As atividades assíncronas (Tasks) precisam de quem execute o código que está dentro delas — e quem faz isso são justamente as threads do pool. O pool “empresta” a thread; ela roda o código (ou a continuação depois de um await, o MoveNext); quando encontra um await, a thread é devolvida ao pool e fica disponível para outra coisa; quando o await termina, alguma thread do pool (pode ser a mesma ou outra) pega a continuação e segue. Ou seja: o Thread Pool é o “guarda-recursos” do async/await — “aqui estão as threads, pegue quando precisar para rodar seu código assíncrono e devolva quando terminar”. Toda vez que um await é atingido, a thread volta ao pool; quando uma continuação precisa rodar, uma thread do pool é usada de novo.

Solicitou aprofundamento: Além de Task, existe outro tipo que represente async/await? Quais são os representantes, quão comuns e por quê? Foi explicado que sim: o outro representante principal é **ValueTask** (e ValueTask&lt;T&gt;). **Task/Task&lt;T&gt;** são os mais comuns: tipo padrão da maioria das APIs, reference type (pode ser armazenado, compartilhado, awaitado mais de uma vez). **ValueTask/ValueTask&lt;T&gt;** são usados quando se quer evitar alocação (ex.: método que frequentemente completa de forma síncrona, hot path, cache); comuns em bibliotecas e em código de performance. Menos comum: tipos customizados que implementam o padrão awaitable (GetAwaiter(), IsCompleted, GetResult()). Em resumo: Task é o representante mais visto no dia a dia; ValueTask é o segundo, em APIs e hot paths; outros awaitables existem mas são raros.

---

## 2. Task vs ValueTask

### Pergunta 10
Qual a diferença entre Task e ValueTask?

Resposta: A diferença é que Task é um reference type e o ValueTask é um tipo que pode variar entre value type e reference type dependendo do caso. Task é utilizado para trabalhar com tarefas assíncronas, entretanto quando ocorre a recuperação de uma informação em chace, portanto uma tarefa síncrona, o custo de alocação de um Task na heap memory é um desperdício. Nesse caso o ValueTask pode ser uma alternativa melhor, pois já contém em seu padrão a possibilidade de ser alocado na heap memory, similar ao que ocorre com uma Task, entretanto quando o valor já se encontra disponível, no caso de um cache por exemplo, um ValueTask pode ser alocado diretamente na stack memory. Outra diferença é que uma Task pode ser awaitada múltiplas vezes, enquanto uma ValueTask pode ser awaitada uma única vez.

**Nota**: 4,5/5 – Muito bom. Você acertou: Task = reference type; ValueTask evita alocação quando o resultado já está pronto (ex.: cache); ValueTask pode ficar na stack quando síncrono; Task pode ser awaitada várias vezes, ValueTask só uma.

Resposta melhorada pela IA: Task é reference type (classe, sempre alocada na heap). ValueTask é value type (struct): em si não “varia” entre value e reference — ele é sempre struct; o que varia é o que ele guarda por dentro: quando o resultado já está disponível (ex.: cache, conclusão síncrona), o ValueTask guarda o valor direto e não aloca nada na heap; quando a operação é assíncrona, ele pode guardar internamente uma referência a uma Task. Assim, em cenários em que muitas vezes não há await de verdade (cache, hot path), usar ValueTask evita alocar Task na heap e melhora performance. Outra diferença importante: Task pode ser awaitada múltiplas vezes (pode guardar a referência e reutilizar); ValueTask só pode ser awaitada uma vez, porque é struct e pode ser copiado/consumido apenas uma vez de forma segura.

Solicitou aprofundamento: Se precisar fazer await de um ValueTask múltiplas vezes, quais são as opções? Foi explicado que a opção é converter para Task com **.AsTask()**: antes de fazer o primeiro await, chame `valueTask.AsTask()` e guarde o resultado em uma variável `Task` (ou `Task&lt;T&gt;`); a partir daí use essa Task, que pode ser awaitada várias vezes, passada para outros métodos, etc. Assim você “consome” o ValueTask uma vez (na conversão) e passa a trabalhar com a Task. Não dá para awaitar o próprio ValueTask mais de uma vez; se precisar de múltiplos awaits ou de compartilhar o resultado, use AsTask() e trabalhe com a Task.

Solicitou esclarecimento: E se precisar passar diferentes parâmetros (ex.: ObterAsync(1) e ObterAsync(2))? Foi explicado que aí são **chamadas diferentes**, cada uma retorna um **ValueTask diferente**. Você pode awaitar cada um desses ValueTasks uma vez: await ObterAsync(1) e await ObterAsync(2) — sem problema. A restrição é só **reutilizar o mesmo** ValueTask (mesmo id, mesma chamada) mais de uma vez. Parâmetros diferentes = ValueTasks diferentes = um await por chamada.

---

### Pergunta 11
Quando usar Task?

Resposta: A Task deve ser utilizada toda vez que eu precisar trabalhar com código assíncrono. Se eu tenho algum caso que vou precisar delegar e aguardar ser resolvido por await então devo utilizar Task. Alguns exemplos são leitura de arquivos, comunicação com bancos de dados, comunicação com api's externas, entre outros.

**Nota**: 4,5/5 – Muito bom. Você acertou: Task para operações assíncronas e deu bons exemplos (arquivos, DB, APIs). A resposta melhorada acrescenta quando preferir Task em vez de ValueTask.

Resposta melhorada pela IA: Use Task quando precisar trabalhar com código assíncrono que será delegado e aguardado com await — leitura de arquivos, comunicação com banco de dados, chamadas a APIs externas, etc. Em relação a ValueTask: prefira **Task** quando (1) a operação é quase sempre assíncrona (não há ganho em ValueTask); (2) você precisa armazenar o resultado e fazer await mais de uma vez, ou passar a “promessa” para vários consumidores; (3) está escrevendo API pública e não tem um hot path que complete frequentemente de forma síncrona. Task é a escolha padrão e segura; ValueTask é otimização para casos específicos (cache, hot path, conclusão síncrona frequente).

---

### Pergunta 12
Quando usar ValueTask?

Resposta: O ValueTask deve ser utilizado quando precisamos otimizar um hot path que em muitas ocasiões completa como síncrono. Outro caso em que podemos utilizar o ValueTask é ao trabalhar com bibliotecas, nesse caso podemos também trabalhar com ele. Eu sei que tem mais ocasiões e mais detalhes, porém esqueci.

**Nota**: 4/5 – Você acertou os dois casos principais (hot path que completa síncrono, bibliotecas). A resposta melhorada lista os outros cenários comuns.

Resposta melhorada pela IA: Use **ValueTask** quando: (1) **Hot path que frequentemente completa de forma síncrona** — o método muitas vezes retorna sem await (ex.: cache hit, validação que falha logo); aí evitar alocar Task na heap melhora performance. (2) **Bibliotecas** — em código de biblioteca, onde você controla o consumo e pode garantir “um await por ValueTask”, ValueTask é comum (ex.: `MemoryStream.ReadAsync`, APIs em `System.Threading.Channels`). (3) **Cache** — métodos que leem de cache e muitas vezes já têm o valor (retorno síncrono). (4) **APIs internas/privadas** — quando o método não é público e você sabe que o chamador fará um único await. Em APIs públicas, Task costuma ser a escolha mais segura, a menos que exista um motivo claro de hot path; em bibliotecas e hot paths, ValueTask é a opção de otimização.

---

### Pergunta 13
Por que ValueTask só pode ser awaitado uma vez?

Resposta: Eu não sei.

**Nota**: Não soube responder — segue a explicação para consolidar. O motivo está ligado ao ValueTask ser struct e ao desenho “consumir uma vez”.

Resposta melhorada pela IA: O ValueTask é um **struct** (value type). Quando você faz await, o resultado é “consumido”: o valor fica lido ou a Task interna é usada. Como é struct, ele pode ser **copiado por valor**; se você tentar awaitar de novo (na mesma variável ou numa cópia), o estado interno já pode estar inválido ou o resultado já foi “gasto”. Além disso, o ValueTask foi desenhado para o cenário **um consumidor, um await**: isso permite otimizações (guardar o resultado direto no struct quando completa síncrono, sem alocar Task). Suportar múltiplos awaits exigiria garantir que o estado sobreviva e seja thread-safe, o que iria contra essa otimização. Por isso a regra: ValueTask = await uma vez; se precisar de vários awaits ou de compartilhar, use **.AsTask()** e trabalhe com a Task.

Solicitou aprofundamento na Pergunta 13. Detalhes adicionais: (1) **Consumo técnico**: ao fazer await, o compilador chama GetAwaiter() no ValueTask; o awaiter retornado mantém referência ao estado interno (o resultado ou a Task encapsulada). Quando o await termina, esse estado é “consumido” — lido ou usado para completar a continuação. O struct não foi feito para resetar ou reexpor esse estado para um segundo await. (2) **Cópia do struct**: se você passar o ValueTask para outro método ou guardar numa variável e depois awaitar em dois lugares, podem existir duas “cópias” do struct; cada await pode tentar consumir o mesmo estado subjacente, o que leva a comportamento indefinido ou exceção. (3) **Documentação e contrato**: a documentação do .NET deixa explícito que ValueTask deve ser awaitado no máximo uma vez; usar mais de uma vez pode causar comportamento indefinido. (4) **Resumo**: o design “single-consumer” permite que o struct seja leve e evite alocação no caso síncrono; múltiplos consumidores exigiriam uma estrutura mais complexa (como a Task), por isso para múltiplos awaits usa-se .AsTask().

---

### Pergunta 14
Task é class ou struct?

Resposta: Task é uma class. E class é um reference type. Toda vez que eu tenho uma classe eu vou devolver um resultado, uma exceção ou um cancelamento. A Task é utilizada sempre em desenvolvimento assíncrono e faz uso do padrão de state machine sempre que um await é atingido.

**Nota**: 4,5/5 – Correto: Task é class (reference type). A ideia de resultado/exceção/cancelamento refere-se à Task em si; a state machine é gerada para o método async que usa await, e a Task representa a conclusão desse trabalho.

Resposta melhorada pela IA: **Task é class** (reference type). Ela é alocada na heap e pode ser referenciada, armazenada e awaitada mais de uma vez. Os três desfechos que você citou (resultado, exceção, cancelamento) são os possíveis estados finais **da Task**, não de toda classe. Quanto à state machine: quem usa o padrão de state machine é o **método** marcado com async (o compilador gera a state machine para esse método); a **Task** é o objeto que representa a operação assíncrona e seu resultado. Em resumo: Task = class, reference type, heap; o método async é que vira state machine quando tem await.

---

### Pergunta 15
ValueTask é class ou struct?

Resposta: ValueTask é um struct. É um value type. Structs é uma das categorias do value type. Value types são divididos em 3 categorias principais: enums, structs, primary types (int, bool, etc). Um ValueTask pode ser awaitado apenas uma vez. E a cópia de um ValueTask resulta em duas ocorrências na stack. A modificação de uma variável que contém um ValueTask afeta apenas ela e não suas cópias.

**Nota**: 5/5 – Muito bom. Você acertou: ValueTask = struct (value type), as três categorias de value types, await uma vez, cópia = valor independente na stack, semântica de valor (modificar uma não afeta as cópias).

Resposta melhorada pela IA: **ValueTask é struct** (value type). Structs são uma das três categorias principais de value types no C#: structs, enums e tipos primitivos (int, bool, etc.). Por ser struct, o ValueTask pode ficar na stack (ou inline); ao copiar, você tem duas ocorrências independentes — modificar um não afeta o outro (semântica de valor). E, como vimos, ValueTask só pode ser awaitado uma vez. Quando a operação é assíncrona, o struct pode guardar internamente uma referência a uma Task (na heap), mas o ValueTask em si é value type.

Solicitou aprofundamento: Quais são os tipos mais comuns das categorias structs, enums e tipos primitivos? **Structs**: tipos primitivos com palavra-chave são implementados como structs no .NET — int (Int32), long (Int64), bool (Boolean), double, float, decimal, char, byte, short; outros structs comuns: DateTime, TimeSpan, Guid, KeyValuePair&lt;TKey,TValue&gt;, ValueTuple, ValueTask, Span&lt;T&gt;, ReadOnlySpan&lt;T&gt;, e structs customizados (Point, etc.). **Enums**: tipos com enum (ex.: DayOfWeek, ConsoleColor, FileMode, HttpStatusCode, StringComparison) e enums definidos pelo usuário. **Tipos primitivos** (ou “simple types”): em C# costumam ser os que têm palavra-chave — int, uint, long, ulong, short, ushort, byte, sbyte, float, double, decimal, bool, char; no .NET todos são structs (value types). Em resumo: “primitivos” são um subconjunto de structs; enums são outro grupo; structs customizados e outros do BCL completam a categoria struct.

Solicitou aprofundamento: Definir categorias de value type, tipos principais de cada e subconjuntos. **Categorias:** (1) **Tipos struct** — subconjuntos: **(a) Primitivos/simple types** (palavra-chave): int, uint, long, ulong, short, ushort, byte, sbyte, float, double, decimal, bool, char. **(b) Structs do BCL**: DateTime, TimeSpan, Guid, KeyValuePair, ValueTuple, ValueTask, Span, ReadOnlySpan, etc. **(c) Structs customizados**: definidos pelo dev. (2) **Tipos enum** — subconjuntos: **(a) Enums do BCL**: DayOfWeek, ConsoleColor, FileMode, HttpStatusCode, StringComparison. **(b) Enums customizados**: definidos pelo dev. (3) **Nullable value types** (T?): int?, DateTime?, bool? — “revestimento” sobre um value type. Resumo: value type = structs (subconjuntos: primitivos, BCL, custom) + enums (BCL, custom) + nullable de qualquer um.

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
