# Rules - Cloud and Code Journal

Este arquivo contém as regras e diretrizes que a IA deve seguir ao ajudar neste repositório.

## 🎯 Foco Principal

- **Tecnologias**: .NET (C#), Azure Cloud Services, Arquitetura de Software
- **Objetivo**: Acompanhar evolução como desenvolvedor .NET focado em Azure e arquitetura
- **Contexto**: Simular ambiente profissional de forma leve e prática

## 📝 Regras de Anotações (Journal)

### Estrutura de Entradas no Journal

As entradas semanais em `journal/` devem seguir este formato:

```markdown
# Semana [N] - [Data Inicial] a [Data Final]

## 🎯 Objetivos da Semana
- [ ] Objetivo 1
- [ ] Objetivo 2

## ✅ Conquistas
- Conquista 1
- Conquista 2

## 📚 Aprendizados
- Aprendizado 1
- Aprendizado 2

## 🚧 Desafios Enfrentados
- Desafio 1 e como foi resolvido
- Desafio 2 e como foi resolvido

## 🔄 Próximos Passos
- Próximo passo 1
- Próximo passo 2

## 📊 Métricas
- Tarefas concluídas: X/Y
- Tempo investido: ~X horas
```

### Padrões de Nomenclatura

- Arquivos de journal: `week-[N]-[YYYY-MM-DD].md`
- Exemplo: `week-1-2025-11-18.md`

## 💬 Regras de Como a IA Deve Responder

### Tom e Estilo
- **Profissional mas acessível**: Use linguagem técnica quando apropriado, mas explique conceitos complexos
- **Direto e objetivo**: Seja claro e evite rodeios
- **Construtivo**: Sempre ofereça soluções práticas e acionáveis
- **Focado em aprendizado**: Priorize explicações que ajudem no crescimento técnico

### Quando Ajudar com Código
- **Sempre explique o "porquê"**: Não apenas mostre código, explique a lógica
- **Mencione boas práticas**: Indique padrões .NET, convenções C# e práticas Azure
- **Sugira melhorias**: Quando apropriado, indique alternativas ou otimizações
- **Contexto Azure**: Sempre considere implicações de cloud quando relevante

### Quando Ajudar com Estudos
- **Estruture o aprendizado**: Organize conteúdos de forma progressiva
- **Forneça recursos**: Indique documentação oficial, tutoriais e exemplos práticos
- **Crie conexões**: Relacione novos conceitos com conhecimentos já adquiridos
- **Pratique ativa**: Sugira exercícios práticos e desafios relacionados

## 🔧 Convenções de Commit

### Formato de Mensagem de Commit

Seguir o padrão **Conventional Commits**:

```
<tipo>(<escopo>): <descrição curta>

<corpo opcional>

<rodapé opcional>
```

### Tipos de Commit

- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Mudanças na documentação
- `style`: Formatação, ponto e vírgula faltando, etc (não afeta código)
- `refactor`: Refatoração de código
- `test`: Adição ou correção de testes
- `chore`: Mudanças em build, dependências, etc
- `learning`: Conteúdo de aprendizado adicionado
- `challenge`: Solução de desafio (Exercism, Codewars, etc)
- `journal`: Entrada no journal semanal
- `project`: Mudanças em projetos/POCs

### Exemplos de Commits

```
feat(learning): adiciona estudo sobre Azure Functions

docs(journal): atualiza journal semana 1

challenge(exercism): resolve exercício TwoFer

project(poc): implementa POC de autenticação com Entra ID

fix(snippet): corrige exemplo de retry com Polly
```

### Regras Adicionais de Commit

- **Mensagens em português**: Descreva em português brasileiro
- **Descrição curta**: Máximo 72 caracteres na primeira linha
- **Corpo opcional**: Use para explicar o "porquê" quando necessário
- **Um commit por mudança lógica**: Não misture múltiplas mudanças não relacionadas

## 💻 Padrões de Código .NET

### Convenções C#

- **Nomenclatura**: 
  - Classes: `PascalCase`
  - Métodos: `PascalCase`
  - Propriedades: `PascalCase`
  - Campos privados: `_camelCase`
  - Variáveis locais: `camelCase`
  - Constantes: `PascalCase`

- **Organização**:
  - Usar `namespace` apropriados
  - Agrupar usando statements (`using` no topo)
  - Ordenar membros: campos, propriedades, construtores, métodos

- **Documentação**:
  - Usar XML comments para APIs públicas
  - Documentar parâmetros, retornos e exceções

### Padrões Azure

- **Nomenclatura de recursos**: Seguir [Azure naming conventions](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
- **Configuração**: Usar `appsettings.json` e Azure Key Vault para secrets
- **Logging**: Usar `ILogger` e Application Insights quando apropriado
- **Resiliência**: Implementar retry, circuit breaker e timeout patterns

### Arquitetura

- **SOLID**: Aplicar princípios SOLID sempre que possível
- **Clean Architecture**: Quando apropriado, seguir camadas bem definidas
- **Dependency Injection**: Usar DI container do .NET
- **Async/Await**: Preferir operações assíncronas para I/O

## 📚 Como a IA Deve Ajudar em Estudos

### Estruturação de Conteúdo de Aprendizado

Quando criar conteúdo em `learning/`:

1. **Criar índice/README**: Organizar tópicos de forma hierárquica
2. **Exemplos práticos**: Sempre incluir código de exemplo
3. **Referências**: Linkar documentação oficial e recursos externos
4. **Exercícios**: Sugerir práticas relacionadas ao conteúdo

### Formato de Arquivos de Aprendizado

```markdown
# [Tópico]

## Objetivo
O que será aprendido neste conteúdo.

## Conceitos
- Conceito 1
- Conceito 2

## Exemplos Práticos
\`\`\`csharp
// Código de exemplo
\`\`\`

## Recursos
- [Link 1](url)
- [Link 2](url)

## Próximos Passos
- Próximo tópico relacionado
- Exercício sugerido
```

## 🎯 Regras Específicas para Challenges

### Estrutura de Soluções

- **Criar pasta por plataforma**: `challenges/exercism/`, `challenges/codewars/`, etc.
- **Uma pasta por exercício**: `challenges/exercism/two-fer/`
- **Incluir README**: Explicar o problema e a solução
- **Código comentado**: Explicar a lógica da solução

### Formato de Solução

```markdown
# [Nome do Exercício]

## Problema
Descrição do problema.

## Solução
\`\`\`csharp
// Código da solução
\`\`\`

## Análise
- Complexidade: O(?)
- Abordagem: [explicação]

## Aprendizados
- O que foi aprendido com este exercício
```

## 🔄 Regras de Atualização

- **Este arquivo é vivo**: Pode e deve ser atualizado conforme necessário
- **Adicionar regras conforme surgem**: Quando padrões novos são estabelecidos, documentar aqui
- **Revisar periodicamente**: Manter regras atualizadas e relevantes

## ⚠️ Regras Importantes

1. **Nunca assumir que algo está finalizado**: Sempre indicar quando objetivos foram concluídos e pedir verificação
2. **Sugerir testes práticos**: Quando possível, indicar lista compacta de testes no Swagger ou ferramentas apropriadas
3. **Seguir arquivos .md**: Sempre ler e seguir orientações em README.md e rules.md
4. **Atualizar documentação**: Ao finalizar trabalho, atualizar README ou rules.md se necessário

## 📖 Recursos de Referência

- [.NET Documentation](https://docs.microsoft.com/dotnet/)
- [Azure Documentation](https://docs.microsoft.com/azure/)
- [C# Coding Conventions](https://docs.microsoft.com/dotnet/csharp/fundamentals/coding-style/coding-conventions)
- [Azure Architecture Center](https://docs.microsoft.com/azure/architecture/)

---

**Última atualização**: 2025-11-22

