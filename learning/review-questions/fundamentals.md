# Perguntas de Revisão - Fundamentos .NET

Este arquivo contém perguntas sobre conceitos fundamentais de .NET para revisão espaciada.

## Como Usar

1. Responda cada pergunta quando ela aparecer na sua revisão
2. Atualize a data da última revisão
3. Ajuste o nível de confiança (1-5)
4. Agende a próxima revisão conforme o cronograma:
   - 1 dia depois (primeira revisão)
   - 3 dias depois (segunda revisão)
   - 1 semana depois (terceira revisão)
   - 2 semanas depois (quarta revisão)
   - 1 mês depois (revisão mensal)

## Formato

```markdown
### Pergunta X
- **Criada em**: YYYY-MM-DD
- **Última revisão**: YYYY-MM-DD
- **Nível de confiança**: X/5
- **Próxima revisão**: YYYY-MM-DD
- **Resposta**: [Sua resposta aqui]
```

---

## Conceitos Básicos

### 1. Diferença entre .NET Core, .NET Framework e .NET
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 2. O que é CLR (Common Language Runtime)?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 3. Como funciona o Garbage Collector no .NET?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 4. Diferença entre Stack e Heap em .NET
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 5. O que são Value Types e Reference Types?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

## Async/Await

### 6. Como funciona async/await em C#?
- **Criada em**: 2025-11-24
- **Última revisão**: 2025-11-30
- **Nível de confiança**: 4/5
- **Próxima revisão**: 2025-12-01
- **Resposta**: 

O async/await é a forma que o C# tem para trabalhar com métodos assíncronos. No C# toda vez que um método é marcado como async, isso significa que ele pode aceitar declarações do tipo await antes de um método que precisa ser delegado e vai levar algum tempo para ser resolvido. Quando uma thread está trabalhando, executando um método marcado com async e se depara com uma expressão await ela salva todo o estado atual do método e guarda na memória heap do computador em formato de uma máquina de estados, em seguida essa thread devolve para o chamador do método a execução. Ou seja, se tiver alguma coisa para ser feita depois e esse método assíncrono não estiver sendo aguardado, o chamador vai continuar. Assim que o await for resolvido, um thread da thread pool vai ser chamada para continuar, a máquina de estados vai ser removida da memória heap e receber uma instrução de MoveNext, continuando de onde parou. Quando terminar o método async vai retornar o tipo que ele havia sido instruído a retornar, ou até mesmo não retornar nada caso seja um void.  

### 7. Qual a diferença entre Task e ValueTask?
- **Criada em**: 2025-11-24
- **Última revisão**: 2025-11-30
- **Nível de confiança**: 5/5
- **Próxima revisão**: 2025-12-01
- **Resposta**: 

Task é feito para trabalhar quando temos certeza que o método é assíncrono. Uma Task sempre será alocada na heap memory, e nesse fato a Task diverge da ValueTask, pois em casos de se deparar com dados já presentes, por exemplo algo que foi salvo em chache, a Task ainda faz alocação na heap, enquanto a ValueTask por outro lado não necessita disso, ou seja, usa apenas a stack memory. A Task devemos usar para casos em que temos certeza que vai ser sempre assíncrono, a ValueTask em casos de hotpath ou cache, onde um grande percentual não necessita de atingir o await. Bibliotecas públicas devem usar sempre Task, enquanto que bibliotecas privadas podem usar ValueTask. ValueTask tem uma performance um pouco melhor que a Task, mas isso pode se inverter em casos que é sempre assíncrono. Uma das limitações de ValueTask é que não pode receber await múltiplas vezes. Não podemos salvar o estado e trabalhar com múltiplos awaits.  

### 8. O que é ConfigureAwait(false) e quando usar?
- **Criada em**: 2025-11-24
- **Última revisão**: 2025-11-30
- **Nível de confiança**: 4/5
- **Próxima revisão**: 2025-12-01
- **Resposta**: 

O ConfigureAwait pode ser invocado sempre que houver um await, ou seja, a chamada de um método assíncrono. Quando ConfigureAwait(false) ele instrui o que está sendo executado a não capturar o contexto, ou seja, indica que ao concluir o que se estava fazendo pode-se escolher qualquer thread no thread pool para fazer o delivery do resultado.

Quando estamos trabalhando com código assíncrono ui, precisamos tomar certos cuidados. No caso de um event handler, não devemos colocar essa instrução diretamente nele, pois ao retornar com o resultado a thread não possui o contexto e vai dar um erro indicando que o processo havia sido iniciado em uma thread diferente. Ao estudar sobre isso podemos pensar em tempos, a thread principal, da UI, entra no método assíncrono enquanto está trabalhando, mas aí se depara com um await lá dentro, o compilador nesse momento guarda na memória heap o state machine e devolve o controle para o chamador, que continua com o que estava fazendo, porém ela ja tenta obter o resultado imediatamente, como não há um resultado pronto ainda nesse momento isso faz com que essa thread fique travada. Em paralelo quando a outra thread finaliza o que estava fazendo, ela não consegue continuar, pois não tem o contexto.

No código não ui entretanto, podemos fazer uso, pois nesse caso o método pode finalizar o que estava fazendo e sabe que precisa entregar o resultado para aquela thread de ui, que por sua vez ainda tem o contexto.

Basicamente ele libera a thread anterior e devolve o controle para o chamador sem armazenar contexto.

Em bibliotecas e services devemos sempre usar o ConfigureAwait(false), em casos de APIs e Functions isso é recomendado, e pode aumentar um pouco a performance da aplicação, o mesmo acontece em Console Applications, entretanto se não for usado ainda vai funcionar e não terá grande impacto.

O uso adequado do ConfigureAwait(false) pode impedir ou criar um deadlock se for inadequado.  

### 9. Como evitar deadlocks com async/await?
- **Criada em**: 2025-11-24
- **Última revisão**: 2025-11-30
- **Nível de confiança**: 4/5
- **Próxima revisão**: 2025-12-01
- **Resposta**: 

Padrões que causam deadlock:

Esses 3 eu tenho Certeza que se comportam da mesma forma:

.Result

.Wait()

.GetAwaiter().GetResult()

O que acontece: Tudo começa na thread que está resolvendo o método chamador, quando se depara com o .Result ela entra no método assíncrono e vai seguir resolvendo tudo até se deparar com um await. Nesse momento o compilador vai criar uma state machine e alocar na heap, e vai devolver o controle para o chamador, que imediatamente tenta pegar o que quer que seja esperado como retorno. Mas nada existe, pois em paralelo o await acabou de iniciar seu trabalho e está tentando resolver.

Em paralelo o await entra no seu trabalho e eventualmente resolve o que quer que seja, digamos, pegar uma imagem na internet, quando ele retorna ele precisa da thread anterior, para entregar o resultado, mas ela ainda está precisa tentando recuperar resultado em um tempo anterior, causando deadlock.

Os dois a seguir ainda entendo parcialmente, mas tenho dúvidas:

Task.Wait()

Task.WaitAll()

O que entendo é que eles colocam aquela thread que está executando a task em modo de espera, uma ou mais tasks dependendo de qual for escolhido.

Depois que "terminar" tu precisa recuperar com um .Result;

A solução é trabalhar com o Task.WhenAll para vários ou com o await para uma única task. Tornando toda a cadeia assíncrona.

Sobre a dúvida nesses casos é entender como realmente o Task.Wait e Task.WaitAll funcionam, para quê eles funcionam, e quais são os casos em que faz sentido usar eles. Entender como o fluxo deles acontece também me ajudaria.

Por ultimo:

Task.Run(async () => await BuscarDadosAsync()).Result;

Esse aí não vai causar um deadklock, mas vai segurar a thread até que seja resolvido, deve ser utilizado em ultimo caso.

Dúvidas que ficaram: Ao chegar no await, quando a thread é devolvida para o thread pool ou retorna para o chamador e continua...

Quem é que dá continuidade na resolução do await? É uma nova thread?  

## LINQ e Collections

### 10. Diferença entre IEnumerable, ICollection, IList e IQueryable
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 11. Quando usar List vs Array vs IEnumerable?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 12. Diferença entre Select, Where e SelectMany no LINQ
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 13. O que é deferred execution no LINQ?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

## Dependency Injection

### 14. O que é Dependency Injection e por que usar?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 15. Diferença entre Scoped, Transient e Singleton no DI
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 16. Como funciona o ServiceProvider no .NET?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

## Testing

### 17. Diferença entre Unit Test, Integration Test e E2E Test
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 18. O que são Mocks, Stubs e Fakes?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 19. Como testar código assíncrono?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

## Performance

### 20. O que é Span<T> e Memory<T> e quando usar?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 21. Como fazer profiling de performance em .NET?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

### 22. O que são boxing e unboxing e como evitá-los?
- **Criada em**: 2025-11-24
- **Última revisão**: 
- **Nível de confiança**: 
- **Próxima revisão**: 
- **Resposta**: 

---

**Notas**: Adicione novas perguntas conforme avança nos estudos. Revise regularmente conforme o cronograma de revisão espaciada.



