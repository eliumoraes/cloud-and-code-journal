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

### Processo de Commit e Push

**IMPORTANTE**: A IA deve sempre seguir este processo ao fazer commits:

1. **Sugerir mensagem de commit**
   - Antes de fazer qualquer commit, a IA deve propor uma mensagem de commit
   - A mensagem deve seguir o formato Conventional Commits
   - Deve ser clara, organizada e adequada às mudanças realizadas

2. **Solicitar aprovação**
   - Após sugerir a mensagem, a IA deve perguntar explicitamente:
     - "Posso fazer o commit e push com esta mensagem?"
     - Ou similar, deixando claro que precisa de aprovação

3. **Aguardar confirmação**
   - A IA **NUNCA** deve fazer commit e push sem aprovação explícita do usuário
   - Apenas após receber confirmação positiva (ex: "sim", "pode", "ok", "faça") é que deve proceder

4. **Executar após aprovação**
   - Com a aprovação recebida, então fazer:
     - `git add` dos arquivos modificados
     - `git commit` com a mensagem aprovada
     - `git push` para o repositório remoto

### Formato de Mensagens de Commit

As mensagens de commit devem ser:

- **Organizadas**: Usar bullet list quando houver múltiplas mudanças relacionadas
- **Claras**: Descrever o que foi feito de forma objetiva
- **Concisas**: Evitar ser muito extensas, mas incluir informações relevantes
- **Estruturadas**: Seguir o padrão Conventional Commits

#### Exemplo de Mensagem com Bullet List

```
feat(learning): adiciona estudo sobre Azure Functions

- Adiciona documentação sobre triggers e bindings
- Inclui exemplos práticos de HTTP e Timer triggers
- Adiciona referências à documentação oficial
```

#### Exemplo de Mensagem Simples

```
docs(rules): atualiza regras de commit e push
```

### Regras Adicionais de Commit

- **Mensagens em português**: Descreva em português brasileiro
- **Descrição curta**: Máximo 72 caracteres na primeira linha
- **Corpo opcional**: Use bullet list para organizar múltiplas mudanças relacionadas
- **Um commit por mudança lógica**: Não misture múltiplas mudanças não relacionadas
- **Sempre solicitar aprovação**: Nunca fazer commit/push sem confirmação do usuário

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

## 📋 Regras para Criar Atividades no GitHub Project Board

### Ao Criar uma Nova Issue/Tarefa

Quando criar uma nova issue (usando os templates ou manualmente), sempre configure os seguintes campos no Project Board:

#### Nomenclatura de Títulos

- **NÃO inclua prefixos no título**: Não use `[LEARNING]`, `[CHALLENGE]`, `[PROJECT]`, `[JOURNAL]` no título
- **NÃO inclua número da semana**: Não use `Semana X` ou `Week X` no título - essa informação vai no campo Sprint
- **Use apenas o título descritivo**: O label já identifica o tipo visualmente no board, e o Sprint identifica a semana
- **Exemplos corretos**:
  - ✅ "Auto-avaliação Técnica .NET e Azure"
  - ✅ "Exercism - TwoFer"
  - ✅ "POC: Azure App Service + API REST"
  - ✅ "Baseline" (para journal - a semana está no Sprint)
  - ✅ "18/11/2025 a 24/11/2025" (para journal com datas)
- **Exemplos incorretos**:
  - ❌ "[LEARNING] Auto-avaliação Técnica .NET e Azure"
  - ❌ "[CHALLENGE] Exercism - TwoFer"
  - ❌ "[PROJECT] POC: Azure App Service + API REST"
  - ❌ "Semana 1 - Baseline" (use apenas "Baseline" e configure Sprint = Week 1)
  - ❌ "Week 2 - Fundamentos" (use apenas "Fundamentos" e configure Sprint = Week 2)

#### Campos Obrigatórios

1. **Assignee (Responsável)**
   - **Sempre**: Atribuir para você mesmo (@me)
   - Isso garante que a tarefa apareça em "My Work" quando estiver em progresso
   - Como fazer: Ao criar a issue, já atribua para você, ou depois vá no board e configure

2. **Status**
   - Escolha um dos valores:
     - `To do`: Tarefa planejada, mas ainda não iniciada
     - `In progress`: Tarefa em andamento (aparece em "My Work")
     - `Blocked`: Tarefa bloqueada por alguma dependência
     - `Done`: Tarefa concluída (aparece em "Done")
   - **Padrão inicial**: `To do` (para novas tarefas)

3. **Priority**
   - Escolha um dos valores:
     - `High`: Prioridade alta, tarefas importantes e urgentes
     - `Medium`: Prioridade média, tarefas importantes mas não urgentes
     - `Low`: Prioridade baixa, tarefas que podem esperar
   - **Como decidir**:
     - High: Aprendizados críticos, projetos principais, deadlines importantes
     - Medium: Estudos complementares, desafios intermediários
     - Low: Tarefas opcionais, melhorias, journal entries

4. **Sprint**
   - Digite a semana atual no formato: `Week 1`, `Week 2`, `Week 3`, etc.
   - Use para agrupar tarefas por semana
   - **Padrão**: Semana atual do planejamento

5. **Labels**
   - Aplique a label apropriada conforme o tipo de tarefa:
     - `learning`: Para estudos e aprendizado
     - `challenge`: Para exercícios (Exercism, Codewars, etc.)
     - `project`: Para POCs e projetos reais
     - `journal`: Para entradas semanais no journal
     - `feature`: Para features e funcionalidades
   - **IMPORTANTE**: Não inclua o tipo da tarefa no título da issue (ex: `[LEARNING]`, `[CHALLENGE]`). O label já identifica o tipo visualmente no board. Use apenas o título descritivo da tarefa.

### Fluxo de Configuração no Board

1. **Criar a Issue**
   - Use os templates disponíveis em `.github/ISSUE_TEMPLATE/`
   - Preencha todas as informações solicitadas no template

2. **Configurar no Project Board**
   - Acesse o Project Board
   - Encontre a issue recém-criada
   - Configure os campos:
     - Clique no card da issue
     - Ou use o menu (três pontinhos) → "Edit fields"
   - Preencha:
     - Assignee: @me (você mesmo)
     - Status: To do (ou In progress se já começou)
     - Priority: High/Medium/Low (conforme importância)
     - Sprint: Week X (semana atual)
     - Labels: já devem estar aplicadas pelo template

3. **Mover para a View Apropriada**
   - A issue aparecerá automaticamente nas views baseadas nos filtros:
     - **My Work**: Se `assignee:@me` E `status:In progress`
     - **Backlog**: Se `status:To do`
     - **Learning**: Se `label:learning`
     - **Done**: Se `status:Done`

### Checklist ao Criar Nova Tarefa

- [ ] Issue criada usando template apropriado
- [ ] Assignee configurado como @me
- [ ] Status definido (To do / In progress / Blocked / Done)
- [ ] Priority definida (High / Medium / Low)
- [ ] Sprint definida (Week X)
- [ ] Label apropriada aplicada
- [ ] Campos configurados no Project Board
- [ ] Issue aparece na view correta

### Dicas Importantes

- **Sempre atribua para você**: Isso garante que você veja suas tarefas em "My Work"
- **Use Priority consistentemente**: Facilita ordenação no Backlog
- **Atualize Status regularmente**: Mantém o board atualizado e mostra progresso real
- **Use Sprint para planejamento**: Agrupa tarefas por semana para facilitar revisão
- **Labels são importantes**: Permitem filtrar por tipo de atividade (Learning, Challenge, etc.)

### Exemplo Prático

Ao criar uma nova tarefa de aprendizado:

1. Criar issue usando template `learning-task.md`
2. Preencher informações do aprendizado
3. No board, configurar:
   - Assignee: @me ✅
   - Status: To do ✅
   - Priority: High (se for aprendizado crítico) ✅
   - Sprint: Week 1 ✅
   - Label: learning (já aplicada pelo template) ✅
4. A issue aparecerá em:
   - Backlog (porque Status = To do)
   - Learning (porque Label = learning)
5. Quando começar a trabalhar:
   - Mude Status para "In progress"
   - A issue aparecerá em "My Work"
6. Quando terminar:
   - Mude Status para "Done"
   - A issue aparecerá em "Done"

## 📅 Regras de Data

### Como Identificar Data Atual

**Sempre verificar a data atual antes de criar ou atualizar arquivos com datas:**

```powershell
# Comando para obter data atual no formato padrão
Get-Date -Format "yyyy-MM-dd"
```

**Formato padrão**: `yyyy-MM-dd` (exemplo: 2025-11-24)

### Quando Usar Datas

- **Data de criação**: Data atual quando o arquivo é criado
- **Data de atualização**: Data atual quando o arquivo é modificado
- **Datas em journal**: Usar datas reais da semana correspondente
- **Datas em issues**: Usar datas reais do período da semana

**⚠️ IMPORTANTE**: Nunca usar datas futuras ou datas incorretas. Sempre verificar com `Get-Date` antes de escrever datas.

## 🔐 Segurança e Tokens

### Token do GitHub

O token de acesso pessoal do GitHub está armazenado em:
- **Localização**: `.secrets/github-token.txt`
- **⚠️ IMPORTANTE**: Esta pasta está no `.gitignore` e **NÃO será commitada**
- **Uso**: Para configurar campos no GitHub Project Board via API
- **Renovação**: Quando necessário, atualize o arquivo `.secrets/github-token.txt`

### Como Usar o Token

```powershell
# Ler token do arquivo e configurar
$token = Get-Content .secrets\github-token.txt | Select-String -Pattern '^ghp_' | ForEach-Object { $_.Line }
$env:GH_TOKEN = $token
gh auth status
```

### Segurança

- ✅ Nunca commite arquivos da pasta `.secrets/`
- ✅ Revogue tokens comprometidos imediatamente
- ✅ Use tokens com expiração
- ✅ Não compartilhe tokens publicamente

**Links úteis**:
- Gerenciar tokens: https://github.com/settings/tokens
- Criar novo token: https://github.com/settings/tokens/new

## ⚠️ Regras Importantes

1. **Nunca assumir que algo está finalizado**: Sempre indicar quando objetivos foram concluídos e pedir verificação
2. **Sugerir testes práticos**: Quando possível, indicar lista compacta de testes no Swagger ou ferramentas apropriadas
3. **Seguir arquivos .md**: Sempre ler e seguir orientações em README.md e rules.md
4. **Atualizar documentação**: Ao finalizar trabalho, atualizar README ou rules.md se necessário
5. **Sempre solicitar aprovação para commits**: Nunca fazer commit e push sem aprovação explícita do usuário (ver seção "Processo de Commit e Push")
6. **Proteger informações sensíveis**: Nunca commitar tokens, senhas ou informações privadas (usar pasta `.secrets/`)

## 📖 Recursos de Referência

- [.NET Documentation](https://docs.microsoft.com/dotnet/)
- [Azure Documentation](https://docs.microsoft.com/azure/)
- [C# Coding Conventions](https://docs.microsoft.com/dotnet/csharp/fundamentals/coding-style/coding-conventions)
- [Azure Architecture Center](https://docs.microsoft.com/azure/architecture/)

---

**Última atualização**: 2025-11-24

---

## 📝 Histórico de Atualizações

- **2025-11-22**: Adicionada seção sobre regras para criar atividades no GitHub Project Board
- **2025-11-22**: Adicionado processo de commit e push com aprovação obrigatória e formato de mensagens
- **2025-11-24**: Adicionada regra sobre identificação de data atual e correção de datas incorretas

